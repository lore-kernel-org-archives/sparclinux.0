From: David Miller <davem@davemloft.net>
Date: Mon, 02 Nov 2009 10:45:28 +0000
Subject: Re: nocache/highmem mapping
Message-Id: <20091102.024528.64402028.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4ACB63BC.90200@gaisler.com>
In-Reply-To: <4ACB63BC.90200@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 06 Oct 2009 17:35:24 +0200

I looked over this in detail and I can't see what the problem
is.

> Here is what we digged out:
> The virtual address regions with 512 MB ram and
> #define SRMMU_MAX_NOCACHE_PAGES	(1280)
> are:
> 
> 0xfc0000000 - 0xfc5000000 : nocache mem
> 0xfc5000000 - 0xfc9000000 : highmem
> 
> however srmmu_nocache_init()->srmmu_early_allocate_ptable_skeleton()
> initializes the the page skelleton in steps of:
>                 ...
> 	while(start < end) {
>                 ...
> 		start = (start + PMD_SIZE) & PMD_MASK;
>         }
>                 ...
> 
> PMD_SIZE is 0x4000000, that means it will will initilize
> 
> 0xfc0000000 - 0xfc4000000 and
> 0xfc4000000 - 0xfc8000000
> before it breaks.
> 
> But this leaves highmem's front region
> 0xfc5000000 - 0xfc8000000 allocated with a
> skelleton (!).

That's perfectly fine, these page tables can be shared by
multiple region users.  And in fact you calculate of the
highmem front region is flawed, it's not 0xfc500000, in
fact it's a constant and not at all related to how much of
a nocache region we decide to use.

> The effect is that  srmmu_paging_init()'s:
>         ...
>         pgd = pgd_offset_k(PKMAP_BASE);
> 	pmd = srmmu_pmd_offset(pgd, PKMAP_BASE);
> 	pte = srmmu_pte_offset(pmd, PKMAP_BASE);
> 	pkmap_page_table = pte;
>         ...
> 
> pkmap_page_table will end up with the pte-ptd-set that nocache
> has allocated, highmem's  mm/highmem.c:map_new_virtual()
>               ...
>               set_pte_at(&init_mm, vaddr,
> 		   &(pkmap_page_table[last_pkmap_nr]), mk_pte(page,
> 		   kmap_prot));
>               ...
> will fail starting from v-address 0xfc800000.

The only real requirement is that PKMAP_BASE is aligned to a single
PTE chunk, so that pkmap_page_table highmem thing works.

Since I see no real reason to lower the NOCACHE area size, it's better
to just properly align-up the PKMAP_BASE.

And wait.... that's exactly what PKMAP_BASE is defined to do:

#define PKMAP_SIZE (LAST_PKMAP << PAGE_SHIFT)
#define PKMAP_BASE PMD_ALIGN(SRMMU_NOCACHE_VADDR + (SRMMU_MAX_NOCACHE_PAGES << PAGE_SHIFT))

PKMAP_BASE is defined to be PMD_ALIGN'd _exactly_ because of the
requirements created by pkmap_page_table and the highmem code.

PKMAP_BASE should evaluate always to:

	PMD_ALIGN(KERNBASE + SRMMU_MAXMEM + (1280 << PAGE_SHIFT))
	|
	PMD_ALIGN(0xf0000000 + 0x0c000000 + (1280 << PAGE_SHIFT))
	|
	PMD_ALIGN(0xfc000000 + (1280 << PAGE_SHIFT))
	|
	PMD_ALIGN(0xfc000000 + 0x500000)
	|
	PMD_ALIGN(0xfc500000)

So what's PMD_ALIGN?

#define PMD_SHIFT		SUN4C_PMD_SHIFT
#define PMD_SIZE        	(1UL << PMD_SHIFT)
#define PMD_MASK        	(~(PMD_SIZE-1))
#define PMD_ALIGN(__addr) 	(((__addr) + ~PMD_MASK) & PMD_MASK)

This value here is the "abstract" PMD size we use in the sparc32 port,
which we happen to just use the sun4c PMD size.

And since that is larger than the SRMMU's PMD size, this should
still align PKMAP_BASE sufficiently.

#define PMD_SHIFT		22
#define PMD_SIZE        	(1UL << 22)
#define PMD_MASK        	(~(PMD_SIZE-1))
#define PMD_ALIGN(__addr) 	(((__addr) + ~PMD_MASK) & PMD_MASK)

Thus:

	PMD_ALIGN(0xfc500000)
	|
	0xfc800000

So PKMAP_BASE is 0xfc800000, and your bug must be something else.
