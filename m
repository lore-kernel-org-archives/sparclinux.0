From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 06 Jan 2009 20:22:45 +0000
Subject: [PATCH] sparc64: refactor code in init_64.c
Message-Id: <20090106202245.GB17714@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The sparc64 allmodconfig build broke due to enabling of the
branch_tracer that does some very clever things with
all if conditions. This caused my gcc 3.4.5 to be so confused that
it emitted two warnings:

arch/sparc/mm/init_64.c: In function `update_mmu_cache':
arch/sparc/mm/init_64.c:271: warning: 'pg_flags' might be used uninitialized in this function
arch/sparc/mm/init_64.c:272: warning: 'page' might be used uninitialized in this function

And with -Werror this broke the build.

Refactor code so it:
1) becomes more readable
2) no longer emit a warning with the branch_tracer enabled

The refactoring uses a small helper function (flush_dcache()).

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---

The diff is not readable so you need to apply it to
see the end result.

Please review extra carefully to check that the transformation of:

    (page = pfn_to_page(pfn), page_mapping(page))

is correct.

Thanks,
	Sam

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index c04b111..6afb1a1 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -259,21 +259,16 @@ static inline void tsb_insert(struct tsb *ent, unsigned long tag, unsigned long
 unsigned long _PAGE_ALL_SZ_BITS __read_mostly;
 unsigned long _PAGE_SZBITS __read_mostly;
 
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t pte)
+static void flush_dcache(unsigned long pfn)
 {
-	struct mm_struct *mm;
-	struct tsb *tsb;
-	unsigned long tag, flags;
-	unsigned long tsb_index, tsb_hash_shift;
+	struct page *page;
 
-	if (tlb_type != hypervisor) {
-		unsigned long pfn = pte_pfn(pte);
+	page = pfn_to_page(pfn);
+	if (page && page_mapping(page)) {
 		unsigned long pg_flags;
-		struct page *page;
 
-		if (pfn_valid(pfn) &&
-		    (page = pfn_to_page(pfn), page_mapping(page)) &&
-		    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
+		pg_flags = page->flags;
+		if (pg_flags & (1UL << PG_dcache_dirty)) {
 			int cpu = ((pg_flags >> PG_dcache_cpu_shift) &
 				   PG_dcache_cpu_mask);
 			int this_cpu = get_cpu();
@@ -291,6 +286,21 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t p
 			put_cpu();
 		}
 	}
+}
+
+void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t pte)
+{
+	struct mm_struct *mm;
+	struct tsb *tsb;
+	unsigned long tag, flags;
+	unsigned long tsb_index, tsb_hash_shift;
+
+	if (tlb_type != hypervisor) {
+		unsigned long pfn = pte_pfn(pte);
+
+		if (pfn_valid(pfn))
+			flush_dcache(pfn);
+	}
 
 	mm = vma->vm_mm;
 

