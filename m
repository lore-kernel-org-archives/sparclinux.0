From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 12 Aug 2007 18:54:20 +0000
Subject: Re: Sun4c interrupt controller, MMU, IOMMU?
Message-Id: <Pine.LNX.4.61.0708121901550.32464@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5580708120042m5f2fe544k83aaf00810efc070@mail.gmail.com>
In-Reply-To: <f43fc5580708120042m5f2fe544k83aaf00810efc070@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Sun, 12 Aug 2007, Blue Swirl wrote:

> On 8/12/07, Mark Fortescue <mark@mtfhpc.demon.co.uk> wrote:
>> The attached file is work in progress so it may not be 100% correct. You
>> will need a wide screen (150 columns) to view the file.
>
> Thanks! So basically the virtual to physical translation can be
> emulated by the following code:
>
> #include <inttypes.h>
> typedef uint32_t target_phys_addr_t;
> typedef uint32_t target_ulong;
> #define PAGE_READ      0x0001
> #define PAGE_WRITE     0x0002
> #define PAGE_EXEC      0x0004
>

Group bits is variable. For SS1 4/60 it is 7 (hard coded as it is not in 
V0 Prom), for SS2 4/75 it is 8 (from the V2 prom).

There is code in my SS1 prom that sugests that you should alow for upto 12 
bits. You can store an 8bit value in the SME on my SS1 Clone but I have 
not done any tests to see it it actually has 256 groups, as SunOS4.1.1, 
Solaris 2.6 and Linux hardcode SS1 to have 128 groups and the SS1 prom 
does not use groups > 127.

In addition, the Sun4 Linux code assumes > 8 bits.

> #define GROUP_BITS 8
> #define NGROUPS (1 << GROUP_BITS)

The number of contexts is variable. For SS2 it is 16 (from V2 prom). For 
SS1 4/60 it is 8 (hard coded as per no groups).

> #define NCONTEXTS 16
> #define PG4C_VALID_BIT    31
> #define PG4C_W_BIT        30
> #define PG4C_S_BIT        29
> #define PG4C_CACHE_BIT    28
> #define PG4C_IO_BIT       26
> #define PG4C_ACCESSED_BIT 25
> #define PG4C_MODIFIED_BIT 24
>
> #define PG4C_VALID_MASK    (1 << PG4C_VALID_BIT)
> #define PG4C_W_MASK        (1 << PG4C_W_BIT)
> #define PG4C_S_MASK        (1 << PG4C_S_BIT)
> #define PG4C_CACHE_MASK    (1 << PG4C_CACHE_BIT)
> #define PG4C_IO_MASK       (1 << PG4C_IO_BIT)

#define PG4C_TYPE_MASK       (3 << PG4C_IO_BIT)

#define PG4C_PFN_SIZE_BITS   16
#define PG4C_PFN_MASK        ((1 << PG4C_PFN_SIZE_BITS) - 1)

#define PG4C_PFN_SHIFT       12
#define PG4C_PAGE_MASK	     ((1 << PG4C_PFN_SHIFT) - 1)

The value for OBMEM is 0, for OBIO is 1. Other values crash my SS1 but 
going through solaris code, it looks like there is another state that is 
in theory valid.

> #define PG4C_ACCESSED_MASK (1 << PG4C_ACCESSED_BIT)
> #define PG4C_MODIFIED_MASK (1 << PG4C_MODIFIED_BIT)
>
> typedef struct CPUState {
>    uint8_t smes[NCONTEXTS * 2048];

uint8_t smes[NCONTEXTS * 4096];

>    uint32_t ptes[NCONTEXTS * NGROUPS * 64];
>    uint8_t sun4c_context;
>    uint32_t sun4c_afsr, sun4c_afar;
> } CPUState;
>
> int sun4c_get_physical_address (CPUState *env, target_phys_addr_t *physical,
>                                int *prot, int *access_index,
>                                target_ulong address,
>                                int rw, int is_user)
> {
>    uint32_t segment_num, pte_num, offset, pte, pte_index, group_index;
>    uint8_t group;
>    int is_dirty;
>
>    segment_num = (address & 0x3ffc0000) >> 17;

segment_num = (address & 0x3ffc0000) >> (PG4C_PFN_SHIFT + 6); /* 18 */

>    pte_num = (address & 0x0003ff800) >> 11;

pte_num = (address & 0x0003ff000) >> PG4C_PFN_SHIFT; /* 12 */

>    offset = address & 0x7ff;

offset = address & PG4C_PAGE_MASK; /* 0xfff */

>    group_index = (env->sun4c_context << 12) | segment_num;
>    group = env->smes[group_index];
>    pte_index = (env->sun4c_context << (GROUP_BITS + 6)) | (group << 6) |
>        pte_num;
>    pte = env->ptes[pte_index];
>    if (!(pte & PG4C_VALID_MASK))
>        return 1;
>
>    /* update page modified and dirty bits */
>    is_dirty = (rw & 1) && !(pte & PG4C_MODIFIED_MASK);
>    if (!(pte & PG4C_ACCESSED_MASK) || is_dirty) {
> 	pte |= PG4C_ACCESSED_MASK;
> 	if (is_dirty)
> 	    pte |= PG4C_MODIFIED_MASK;
>        env->ptes[pte_index] = pte;
>    }
>

I am not sure in when the PTE accessed bit (PG4C_ACCESSED_MASK) gets set. 
It definatly gets accesed on write but not always on read. It may only be 
set on read if the cache is empty (or on DMA)?

>    /* check access */
>    if (is_user && (pte & PG4C_S_MASK))
>        return 2;
>    if ((rw & 1) && (pte & PG4C_W_MASK))
>        return 4;
>
>    /* the page can be put in the TLB */
>    *prot = PAGE_READ | PAGE_EXEC;
>    if (pte & PG4C_W_MASK)
>        *prot |= PAGE_WRITE;
>
>    if (!(pte & PG4C_MODIFIED_MASK)) {
>        /* only set write access if already dirty... otherwise wait
>           for dirty access */
>        *prot &= ~PAGE_WRITE;
>    }
>
>    /* get physical address */
>    *physical = ((pte & PG4C_IO_MASK)? 0xf0000000 : 0) | ((pte & 0xffff) << 12)
>        | offset;

*physical = ((pte & PG4C_TYPE_MASK) = PG4C_IO_MASK ? 0xf0000000 : 0) | 
((pte & PG4C_PFN_MASK) << PG4C_PFN_SHIFT) | offset

>
>    return 0;
> }

PET bits 0 to 15 and 24 to 31 are software modifiable on my sun4c. The 
eight bits in the middle (16 .. 23) always read as 0. SunOS 4.1.1 always 
writes to these middle bits (maybe because the Page Frame Number on Sun4 
is 19 or 20 bits, not 16bits or maybe the engineers were catering from 
some sun4c hardware not known to us :) ).

As a short note: A Sun4 is very similar to a Sun4c so coding the sun4c 
stuf up using more #defines may have be benificial. From what I have 
seen in the Linux code, the register/prom addresses are the same as on 
my SS1. One big execption is that some of them use a three level 
SunMMU. The other would apear to be the page size (offset of 13 bits, not 
12 bits). Without the assistance of someone with various different 
versions of Sun4 that can be used to try out things, I can't verify if 
Linux actually maps directly to the physical hardware or works for some 
other reason. Best to assume it does untill proven otherwise.

I will try to update my diagram to include sun4 2 and 3 level SunMMU's 
based on the Linux coding.

Regards
 	Mark Fortescue.
