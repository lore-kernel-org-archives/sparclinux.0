From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 26 Jul 2012 21:02:27 +0000
Subject: [PATCH 17/18] sparc32: move kmap_init() to highmem.c
Message-Id: <1343336548-3879-17-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Try to keep highmem support in a more central place.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/highmem.h |    1 -
 arch/sparc/mm/highmem.c          |   17 +++++++++++++++++
 arch/sparc/mm/init_32.c          |   13 -------------
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/include/asm/highmem.h b/arch/sparc/include/asm/highmem.h
index 6393383..4f9e15c 100644
--- a/arch/sparc/include/asm/highmem.h
+++ b/arch/sparc/include/asm/highmem.h
@@ -28,7 +28,6 @@
 /* declarations for highmem.c */
 extern unsigned long highstart_pfn, highend_pfn;
 
-extern pte_t *kmap_pte;
 extern pgprot_t kmap_prot;
 extern pte_t *pkmap_page_table;
 
diff --git a/arch/sparc/mm/highmem.c b/arch/sparc/mm/highmem.c
index 4d5f8b3..449f864 100644
--- a/arch/sparc/mm/highmem.c
+++ b/arch/sparc/mm/highmem.c
@@ -31,6 +31,23 @@
 #include <asm/pgalloc.h>
 #include <asm/vaddrs.h>
 
+pgprot_t kmap_prot;
+
+static pte_t *kmap_pte;
+
+void __init kmap_init(void)
+{
+	unsigned long address;
+	pmd_t *dir;
+
+	address = __fix_to_virt(FIX_KMAP_BEGIN);
+	dir = pmd_offset(pgd_offset_k(address), address);
+
+        /* cache the first kmap pte */
+        kmap_pte = pte_offset_kernel(dir, address);
+        kmap_prot = __pgprot(SRMMU_ET_PTE | SRMMU_PRIV | SRMMU_CACHE);
+}
+
 void *kmap_atomic(struct page *page)
 {
 	unsigned long vaddr;
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 020d2af..9f1162f 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -52,19 +52,6 @@ extern unsigned int sparc_ramdisk_size;
 
 unsigned long highstart_pfn, highend_pfn;
 
-pte_t *kmap_pte;
-pgprot_t kmap_prot;
-
-#define kmap_get_fixmap_pte(vaddr) \
-	pte_offset_kernel(pmd_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr))
-
-void __init kmap_init(void)
-{
-	/* cache the first kmap pte */
-	kmap_pte = kmap_get_fixmap_pte(__fix_to_virt(FIX_KMAP_BEGIN));
-	kmap_prot = __pgprot(SRMMU_ET_PTE | SRMMU_PRIV | SRMMU_CACHE);
-}
-
 void show_mem(unsigned int filter)
 {
 	printk("Mem-info:\n");
-- 
1.6.0.6

