From: Christoph Hellwig <hch@lst.de>
Date: Tue, 25 Jun 2019 14:37:03 +0000
Subject: [PATCH 04/16] MIPS: use the generic get_user_pages_fast code
Message-Id: <20190625143715.1689-5-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190625143715.1689-1-hch@lst.de>
In-Reply-To: <20190625143715.1689-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>
Cc: Nicholas Piggin <npiggin@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>

The mips code is mostly equivalent to the generic one, minus various
bugfixes and an arch override for gup_fast_permitted.

Note that this defines ARCH_HAS_PTE_SPECIAL for mips as mips has
pte_special and pte_mkspecial implemented and used in the existing
gup code.  They are no-op stubs, though which makes me a little unsure
if this is really right thing to do.

Note that this also adds back a missing cpu_has_dc_aliases check for
__get_user_pages_fast, which the old code was only doing for
get_user_pages_fast.  This clearly looks like an oversight, as any
condition that makes get_user_pages_fast unsafe also applies to
__get_user_pages_fast.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
---
 arch/mips/Kconfig               |   3 +
 arch/mips/include/asm/pgtable.h |   3 +
 arch/mips/mm/Makefile           |   1 -
 arch/mips/mm/gup.c              | 303 --------------------------------
 4 files changed, 6 insertions(+), 304 deletions(-)
 delete mode 100644 arch/mips/mm/gup.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 70d3200476bf..64108a2a16d4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -6,6 +6,7 @@ config MIPS
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_SUPPORTS_UPROBES
@@ -34,6 +35,7 @@ config MIPS
 	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
+	select GUP_GET_PTE_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
 	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_COMPILER_H
 	select HAVE_ARCH_JUMP_LABEL
@@ -55,6 +57,7 @@ config MIPS
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
+	select HAVE_GENERIC_GUP
 	select HAVE_IDE
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 4ccb465ef3f2..7d27194e3b45 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -20,6 +20,7 @@
 #include <asm/cmpxchg.h>
 #include <asm/io.h>
 #include <asm/pgtable-bits.h>
+#include <asm/cpu-features.h>
 
 struct mm_struct;
 struct vm_area_struct;
@@ -626,6 +627,8 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+#define gup_fast_permitted(start, end)	(!cpu_has_dc_aliases)
+
 #include <asm-generic/pgtable.h>
 
 /*
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index f34d7ff5eb60..1e8d335025d7 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -7,7 +7,6 @@ obj-y				+= cache.o
 obj-y				+= context.o
 obj-y				+= extable.o
 obj-y				+= fault.o
-obj-y				+= gup.o
 obj-y				+= init.o
 obj-y				+= mmap.o
 obj-y				+= page.o
diff --git a/arch/mips/mm/gup.c b/arch/mips/mm/gup.c
deleted file mode 100644
index 4c2b4483683c..000000000000
--- a/arch/mips/mm/gup.c
+++ /dev/null
@@ -1,303 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Lockless get_user_pages_fast for MIPS
- *
- * Copyright (C) 2008 Nick Piggin
- * Copyright (C) 2008 Novell Inc.
- * Copyright (C) 2011 Ralf Baechle
- */
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/vmstat.h>
-#include <linux/highmem.h>
-#include <linux/swap.h>
-#include <linux/hugetlb.h>
-
-#include <asm/cpu-features.h>
-#include <asm/pgtable.h>
-
-static inline pte_t gup_get_pte(pte_t *ptep)
-{
-#if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
-	pte_t pte;
-
-retry:
-	pte.pte_low = ptep->pte_low;
-	smp_rmb();
-	pte.pte_high = ptep->pte_high;
-	smp_rmb();
-	if (unlikely(pte.pte_low != ptep->pte_low))
-		goto retry;
-
-	return pte;
-#else
-	return READ_ONCE(*ptep);
-#endif
-}
-
-static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
-			int write, struct page **pages, int *nr)
-{
-	pte_t *ptep = pte_offset_map(&pmd, addr);
-	do {
-		pte_t pte = gup_get_pte(ptep);
-		struct page *page;
-
-		if (!pte_present(pte) ||
-		    pte_special(pte) || (write && !pte_write(pte))) {
-			pte_unmap(ptep);
-			return 0;
-		}
-		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
-		page = pte_page(pte);
-		get_page(page);
-		SetPageReferenced(page);
-		pages[*nr] = page;
-		(*nr)++;
-
-	} while (ptep++, addr += PAGE_SIZE, addr != end);
-
-	pte_unmap(ptep - 1);
-	return 1;
-}
-
-static inline void get_head_page_multiple(struct page *page, int nr)
-{
-	VM_BUG_ON(page != compound_head(page));
-	VM_BUG_ON(page_count(page) = 0);
-	page_ref_add(page, nr);
-	SetPageReferenced(page);
-}
-
-static int gup_huge_pmd(pmd_t pmd, unsigned long addr, unsigned long end,
-			int write, struct page **pages, int *nr)
-{
-	pte_t pte = *(pte_t *)&pmd;
-	struct page *head, *page;
-	int refs;
-
-	if (write && !pte_write(pte))
-		return 0;
-	/* hugepages are never "special" */
-	VM_BUG_ON(pte_special(pte));
-	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
-
-	refs = 0;
-	head = pte_page(pte);
-	page = head + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	do {
-		VM_BUG_ON(compound_head(page) != head);
-		pages[*nr] = page;
-		(*nr)++;
-		page++;
-		refs++;
-	} while (addr += PAGE_SIZE, addr != end);
-
-	get_head_page_multiple(head, refs);
-	return 1;
-}
-
-static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
-			int write, struct page **pages, int *nr)
-{
-	unsigned long next;
-	pmd_t *pmdp;
-
-	pmdp = pmd_offset(&pud, addr);
-	do {
-		pmd_t pmd = *pmdp;
-
-		next = pmd_addr_end(addr, end);
-		if (pmd_none(pmd))
-			return 0;
-		if (unlikely(pmd_huge(pmd))) {
-			if (!gup_huge_pmd(pmd, addr, next, write, pages,nr))
-				return 0;
-		} else {
-			if (!gup_pte_range(pmd, addr, next, write, pages,nr))
-				return 0;
-		}
-	} while (pmdp++, addr = next, addr != end);
-
-	return 1;
-}
-
-static int gup_huge_pud(pud_t pud, unsigned long addr, unsigned long end,
-			int write, struct page **pages, int *nr)
-{
-	pte_t pte = *(pte_t *)&pud;
-	struct page *head, *page;
-	int refs;
-
-	if (write && !pte_write(pte))
-		return 0;
-	/* hugepages are never "special" */
-	VM_BUG_ON(pte_special(pte));
-	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
-
-	refs = 0;
-	head = pte_page(pte);
-	page = head + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-	do {
-		VM_BUG_ON(compound_head(page) != head);
-		pages[*nr] = page;
-		(*nr)++;
-		page++;
-		refs++;
-	} while (addr += PAGE_SIZE, addr != end);
-
-	get_head_page_multiple(head, refs);
-	return 1;
-}
-
-static int gup_pud_range(pgd_t pgd, unsigned long addr, unsigned long end,
-			int write, struct page **pages, int *nr)
-{
-	unsigned long next;
-	pud_t *pudp;
-
-	pudp = pud_offset(&pgd, addr);
-	do {
-		pud_t pud = *pudp;
-
-		next = pud_addr_end(addr, end);
-		if (pud_none(pud))
-			return 0;
-		if (unlikely(pud_huge(pud))) {
-			if (!gup_huge_pud(pud, addr, next, write, pages,nr))
-				return 0;
-		} else {
-			if (!gup_pmd_range(pud, addr, next, write, pages,nr))
-				return 0;
-		}
-	} while (pudp++, addr = next, addr != end);
-
-	return 1;
-}
-
-/*
- * Like get_user_pages_fast() except its IRQ-safe in that it won't fall
- * back to the regular GUP.
- * Note a difference with get_user_pages_fast: this always returns the
- * number of pages pinned, 0 if no pages were pinned.
- */
-int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
-			  struct page **pages)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long addr, len, end;
-	unsigned long next;
-	unsigned long flags;
-	pgd_t *pgdp;
-	int nr = 0;
-
-	start &= PAGE_MASK;
-	addr = start;
-	len = (unsigned long) nr_pages << PAGE_SHIFT;
-	end = start + len;
-	if (unlikely(!access_ok((void __user *)start, len)))
-		return 0;
-
-	/*
-	 * XXX: batch / limit 'nr', to avoid large irq off latency
-	 * needs some instrumenting to determine the common sizes used by
-	 * important workloads (eg. DB2), and whether limiting the batch
-	 * size will decrease performance.
-	 *
-	 * It seems like we're in the clear for the moment. Direct-IO is
-	 * the main guy that batches up lots of get_user_pages, and even
-	 * they are limited to 64-at-a-time which is not so many.
-	 */
-	/*
-	 * This doesn't prevent pagetable teardown, but does prevent
-	 * the pagetables and pages from being freed.
-	 *
-	 * So long as we atomically load page table pointers versus teardown,
-	 * we can follow the address down to the page and take a ref on it.
-	 */
-	local_irq_save(flags);
-	pgdp = pgd_offset(mm, addr);
-	do {
-		pgd_t pgd = *pgdp;
-
-		next = pgd_addr_end(addr, end);
-		if (pgd_none(pgd))
-			break;
-		if (!gup_pud_range(pgd, addr, next, write, pages, &nr))
-			break;
-	} while (pgdp++, addr = next, addr != end);
-	local_irq_restore(flags);
-
-	return nr;
-}
-
-/**
- * get_user_pages_fast() - pin user pages in memory
- * @start:	starting user address
- * @nr_pages:	number of pages from start to pin
- * @gup_flags:	flags modifying pin behaviour
- * @pages:	array that receives pointers to the pages pinned.
- *		Should be at least nr_pages long.
- *
- * Attempt to pin user pages in memory without taking mm->mmap_sem.
- * If not successful, it will fall back to taking the lock and
- * calling get_user_pages().
- *
- * Returns number of pages pinned. This may be fewer than the number
- * requested. If nr_pages is 0 or negative, returns 0. If no pages
- * were pinned, returns -errno.
- */
-int get_user_pages_fast(unsigned long start, int nr_pages,
-			unsigned int gup_flags, struct page **pages)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long addr, len, end;
-	unsigned long next;
-	pgd_t *pgdp;
-	int ret, nr = 0;
-
-	start &= PAGE_MASK;
-	addr = start;
-	len = (unsigned long) nr_pages << PAGE_SHIFT;
-
-	end = start + len;
-	if (end < start || cpu_has_dc_aliases)
-		goto slow_irqon;
-
-	/* XXX: batch / limit 'nr' */
-	local_irq_disable();
-	pgdp = pgd_offset(mm, addr);
-	do {
-		pgd_t pgd = *pgdp;
-
-		next = pgd_addr_end(addr, end);
-		if (pgd_none(pgd))
-			goto slow;
-		if (!gup_pud_range(pgd, addr, next, gup_flags & FOLL_WRITE,
-				   pages, &nr))
-			goto slow;
-	} while (pgdp++, addr = next, addr != end);
-	local_irq_enable();
-
-	VM_BUG_ON(nr != (end - start) >> PAGE_SHIFT);
-	return nr;
-slow:
-	local_irq_enable();
-
-slow_irqon:
-	/* Try to get the remaining pages with get_user_pages */
-	start += nr << PAGE_SHIFT;
-	pages += nr;
-
-	ret = get_user_pages_unlocked(start, (end - start) >> PAGE_SHIFT,
-				      pages, gup_flags);
-
-	/* Have to be a bit careful with return values */
-	if (nr > 0) {
-		if (ret < 0)
-			ret = nr;
-		else
-			ret += nr;
-	}
-	return ret;
-}
-- 
2.20.1
