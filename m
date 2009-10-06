From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 06 Oct 2009 15:35:24 +0000
Subject: nocache/highmem mapping
Message-Id: <4ACB63BC.90200@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
We encountered something strange for out Sparc-Leon arch,
and would like to ask weather someone can clarify:
When running on a board with 512 MB we encountered
difficulties in highmem (256MB works ok). We could only
solve this problem by redefining the strange SRMMU_MAX_NOCACHE_PAGES
to a multiple of PMD_SIZE (0x400000)
-#define SRMMU_MAX_NOCACHE_PAGES	(1280)
+#define SRMMU_MAX_NOCACHE_PAGES	(1024)
So we would like to ask why is this the case only for Leon-Sparc,
Obviously other sun machines work well (maybe I'm wrong...)

Here is what we digged out:
The virtual address regions with 512 MB ram and
#define SRMMU_MAX_NOCACHE_PAGES	(1280)
are:

0xfc0000000 - 0xfc5000000 : nocache mem
0xfc5000000 - 0xfc9000000 : highmem

however srmmu_nocache_init()->srmmu_early_allocate_ptable_skeleton()
initializes the the page skelleton in steps of:
                 ...
	while(start < end) {
                 ...
		start = (start + PMD_SIZE) & PMD_MASK;
         }
                 ...

PMD_SIZE is 0x4000000, that means it will will initilize

0xfc0000000 - 0xfc4000000 and
0xfc4000000 - 0xfc8000000
before it breaks.

But this leaves highmem's front region
0xfc5000000 - 0xfc8000000 allocated with a
skelleton (!).
The effect is that  srmmu_paging_init()'s:
         ...
         pgd = pgd_offset_k(PKMAP_BASE);
	pmd = srmmu_pmd_offset(pgd, PKMAP_BASE);
	pte = srmmu_pte_offset(pmd, PKMAP_BASE);
	pkmap_page_table = pte;
         ...

pkmap_page_table will end up with the pte-ptd-set that nocache
has allocated, highmem's  mm/highmem.c:map_new_virtual()
               ...
               set_pte_at(&init_mm, vaddr,
		   &(pkmap_page_table[last_pkmap_nr]), mk_pte(page, kmap_prot));
               ...
will fail starting from v-address 0xfc800000.

The root of evil is  vaddrs.h's strange:
...
#define SRMMU_MAX_NOCACHE_PAGES	(1280)
...

We had to change it to
#define SRMMU_MAX_NOCACHE_PAGES	(1024) (PMD_SIZE size multiple (0x400000))

I'm not shure why this is the case only on our machines.

Maybe I am missing something.
-- Konrad









