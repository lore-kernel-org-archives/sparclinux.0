From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Sun, 12 Aug 2007 15:34:18 +0000
Subject: Re: Sun4c interrupt controller, MMU, IOMMU?
Message-Id: <f43fc5580708120834sabf5e05jdd58715f2eadc1e@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5580708120042m5f2fe544k83aaf00810efc070@mail.gmail.com>
In-Reply-To: <f43fc5580708120042m5f2fe544k83aaf00810efc070@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 8/12/07, Mark Fortescue <mark@mtfhpc.demon.co.uk> wrote:
> The attached file is work in progress so it may not be 100% correct. You
> will need a wide screen (150 columns) to view the file.

Thanks! So basically the virtual to physical translation can be
emulated by the following code:

#include <inttypes.h>
typedef uint32_t target_phys_addr_t;
typedef uint32_t target_ulong;
#define PAGE_READ      0x0001
#define PAGE_WRITE     0x0002
#define PAGE_EXEC      0x0004

#define GROUP_BITS 8
#define NGROUPS (1 << GROUP_BITS)
#define NCONTEXTS 16
#define PG4C_VALID_BIT    31
#define PG4C_W_BIT        30
#define PG4C_S_BIT        29
#define PG4C_CACHE_BIT    28
#define PG4C_IO_BIT       26
#define PG4C_ACCESSED_BIT 25
#define PG4C_MODIFIED_BIT 24

#define PG4C_VALID_MASK    (1 << PG4C_VALID_BIT)
#define PG4C_W_MASK        (1 << PG4C_W_BIT)
#define PG4C_S_MASK        (1 << PG4C_S_BIT)
#define PG4C_CACHE_MASK    (1 << PG4C_CACHE_BIT)
#define PG4C_IO_MASK       (1 << PG4C_IO_BIT)
#define PG4C_ACCESSED_MASK (1 << PG4C_ACCESSED_BIT)
#define PG4C_MODIFIED_MASK (1 << PG4C_MODIFIED_BIT)

typedef struct CPUState {
    uint8_t smes[NCONTEXTS * 2048];
    uint32_t ptes[NCONTEXTS * NGROUPS * 64];
    uint8_t sun4c_context;
    uint32_t sun4c_afsr, sun4c_afar;
} CPUState;

int sun4c_get_physical_address (CPUState *env, target_phys_addr_t *physical,
                                int *prot, int *access_index,
                                target_ulong address,
                                int rw, int is_user)
{
    uint32_t segment_num, pte_num, offset, pte, pte_index, group_index;
    uint8_t group;
    int is_dirty;

    segment_num = (address & 0x3ffc0000) >> 17;
    pte_num = (address & 0x0003ff800) >> 11;
    offset = address & 0x7ff;
    group_index = (env->sun4c_context << 12) | segment_num;
    group = env->smes[group_index];
    pte_index = (env->sun4c_context << (GROUP_BITS + 6)) | (group << 6) |
        pte_num;
    pte = env->ptes[pte_index];
    if (!(pte & PG4C_VALID_MASK))
        return 1;

    /* update page modified and dirty bits */
    is_dirty = (rw & 1) && !(pte & PG4C_MODIFIED_MASK);
    if (!(pte & PG4C_ACCESSED_MASK) || is_dirty) {
	pte |= PG4C_ACCESSED_MASK;
	if (is_dirty)
	    pte |= PG4C_MODIFIED_MASK;
        env->ptes[pte_index] = pte;
    }

    /* check access */
    if (is_user && (pte & PG4C_S_MASK))
        return 2;
    if ((rw & 1) && (pte & PG4C_W_MASK))
        return 4;

    /* the page can be put in the TLB */
    *prot = PAGE_READ | PAGE_EXEC;
    if (pte & PG4C_W_MASK)
        *prot |= PAGE_WRITE;

    if (!(pte & PG4C_MODIFIED_MASK)) {
        /* only set write access if already dirty... otherwise wait
           for dirty access */
        *prot &= ~PAGE_WRITE;
    }

    /* get physical address */
    *physical = ((pte & PG4C_IO_MASK)? 0xf0000000 : 0) | ((pte & 0xffff) << 12)
        | offset;

    return 0;
}
