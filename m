From: David Miller <davem@davemloft.net>
Date: Sun, 28 Sep 2014 04:35:25 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20140928.003525.1355110317298235630.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Sat, 27 Sep 2014 16:46:51 -0400

>> Anyways, let me know how these work for you.  I'll be running tests
>> on my T4-2 all weekend.
> I'll commence with T5-2 which is local to me.
> 
> M7-4 came up with an older kernel of mine but with hardware faults.

Thanks in advance.

I added the following to my tree to deal with the MAX_BANKS issue,
I hope it helps the case you talked about, and it's essentially
free :-)

==========
From ed49895e9d85d33cc5d8e774a58b24b416fbd846 Mon Sep 17 00:00:00 2001
From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 27 Sep 2014 21:30:57 -0700
Subject: [PATCH] sparc64: Kill unnecessary tables and increase MAX_BANKS.

swapper_low_pmd_dir and swapper_pud_dir are actually completely
useless and unnecessary.

We just need swapper_pg_dir[].  Naturally the other page table chunks
will be allocated on an as-needed basis.  Since the kernel actually
accesses these tables in the PAGE_OFFSET view, there is not even a TLB
locality advantage of placing them in the kernel image.

Use the hard coded vmlinux.ld.S slot for swapper_pg_dir which is
naturally page aligned.

Increase MAX_BANKS to 1024 in order to handle heavily fragmented
virtual guests.

Even with this MAX_BANKS increase, the kernel is 20K+ smaller.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_64.h |  1 -
 arch/sparc/kernel/vmlinux.lds.S     |  5 +++--
 arch/sparc/mm/init_64.c             | 25 ++-----------------------
 3 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index c093922..bfeb626 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -927,7 +927,6 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 #endif
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
-extern pmd_t swapper_low_pmd_dir[PTRS_PER_PMD];
 
 void paging_init(void);
 unsigned long find_ecache_flush_span(unsigned long size);
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 0bacceb..0924305 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -35,8 +35,9 @@ jiffies = jiffies_64;
 
 SECTIONS
 {
-	/* swapper_low_pmd_dir is sparc64 only */
-	swapper_low_pmd_dir = 0x0000000000402000;
+#ifdef CONFIG_SPARC64
+	swapper_pg_dir = 0x0000000000402000;
+#endif
 	. = INITIAL_ADDRESS;
 	.text TEXTSTART :
 	{
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index ede1840..b9a14a0 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -87,7 +87,7 @@ extern struct tsb swapper_tsb[KERNEL_TSB_NENTRIES];
 
 static unsigned long cpu_pgsz_mask;
 
-#define MAX_BANKS	32
+#define MAX_BANKS	1024
 
 static struct linux_prom64_registers pavail[MAX_BANKS];
 static int pavail_ents;
@@ -1947,12 +1947,6 @@ static void __init sun4v_linear_pte_xor_finalize(void)
 
 static unsigned long last_valid_pfn;
 
-/* These must be page aligned in order to not trigger the
- * alignment tests of pgd_bad() and pud_bad().
- */
-pgd_t swapper_pg_dir[PTRS_PER_PGD] __attribute__ ((aligned (PAGE_SIZE)));
-static pud_t swapper_pud_dir[PTRS_PER_PUD] __attribute__ ((aligned (PAGE_SIZE)));
-
 static void sun4u_pgprot_init(void);
 static void sun4v_pgprot_init(void);
 
@@ -2006,8 +2000,6 @@ void __init paging_init(void)
 {
 	unsigned long end_pfn, shift, phys_base;
 	unsigned long real_end, i;
-	pud_t *pud;
-	pmd_t *pmd;
 	int node;
 
 	setup_page_offset();
@@ -2103,20 +2095,7 @@ void __init paging_init(void)
 	 */
 	init_mm.pgd += ((shift) / (sizeof(pgd_t)));
 	
-	memset(swapper_low_pmd_dir, 0, sizeof(swapper_low_pmd_dir));
-
-	/* The kernel page tables we publish into what the rest of the
-	 * world sees must be adjusted so that they see the PAGE_OFFSET
-	 * address of these in-kerenel data structures.  However right
-	 * here we must access them from the kernel image side, because
-	 * the trap tables haven't been taken over and therefore we cannot
-	 * take TLB misses in the PAGE_OFFSET linear mappings yet.
-	 */
-	pud = swapper_pud_dir + (shift / sizeof(pud_t));
-	pgd_set(&swapper_pg_dir[0], pud);
-
-	pmd = swapper_low_pmd_dir + (shift / sizeof(pmd_t));
-	pud_set(&swapper_pud_dir[0], pmd);
+	memset(swapper_pg_dir, 0, sizeof(swapper_pg_dir));
 
 	inherit_prom_mappings();
 	
-- 
1.8.1.2

