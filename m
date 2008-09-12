From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 21:50:02 +0000
Subject: [PATCH 15/16]: sparc64: Kill sparse warnings in mm/init.h
Message-Id: <20080912.145002.83600366.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Kill sparse warnings in mm/init.h

1) Several exported symbols need extern decls, they are exported
   not for C code but for assembler routines.

2) PAGE_EXEC isn't used, delete

3) Several larger than 32-bit constants need "UL" markers

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/mm/init.c |   36 ++++++----------------------------
 arch/sparc64/mm/init.h |   49 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 29 deletions(-)
 create mode 100644 arch/sparc64/mm/init.h

diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
index 4fb9de0..3c10daf 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -50,10 +50,7 @@
 #include <asm/cpudata.h>
 #include <asm/irq.h>
 
-#define MAX_PHYS_ADDRESS	(1UL << 42UL)
-#define KPTE_BITMAP_CHUNK_SZ	(256UL * 1024UL * 1024UL)
-#define KPTE_BITMAP_BYTES	\
-	((MAX_PHYS_ADDRESS / KPTE_BITMAP_CHUNK_SZ) / 8)
+#include "init.h"
 
 unsigned long kern_linear_pte_xor[2] __read_mostly;
 
@@ -415,17 +412,9 @@ void mmu_info(struct seq_file *m)
 #endif /* CONFIG_DEBUG_DCFLUSH */
 }
 
-struct linux_prom_translation {
-	unsigned long virt;
-	unsigned long size;
-	unsigned long data;
-};
-
-/* Exported for kernel TLB miss handling in ktlb.S */
 struct linux_prom_translation prom_trans[512] __read_mostly;
 unsigned int prom_trans_ents __read_mostly;
 
-/* Exported for SMP bootup purposes. */
 unsigned long kern_locked_tte_data;
 
 /* The obp translations are saved based on 8k pagesize, since obp can
@@ -2064,7 +2053,6 @@ pgprot_t PAGE_COPY __read_mostly;
 pgprot_t PAGE_SHARED __read_mostly;
 EXPORT_SYMBOL(PAGE_SHARED);
 
-pgprot_t PAGE_EXEC __read_mostly;
 unsigned long pg_iobits __read_mostly;
 
 unsigned long _PAGE_IE __read_mostly;
@@ -2077,14 +2065,6 @@ unsigned long _PAGE_CACHE __read_mostly;
 EXPORT_SYMBOL(_PAGE_CACHE);
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-
-#define VMEMMAP_CHUNK_SHIFT	22
-#define VMEMMAP_CHUNK		(1UL << VMEMMAP_CHUNK_SHIFT)
-#define VMEMMAP_CHUNK_MASK	~(VMEMMAP_CHUNK - 1UL)
-#define VMEMMAP_ALIGN(x)	(((x)+VMEMMAP_CHUNK-1UL)&VMEMMAP_CHUNK_MASK)
-
-#define VMEMMAP_SIZE	((((1UL << MAX_PHYSADDR_BITS) >> PAGE_SHIFT) * \
-			  sizeof(struct page *)) >> VMEMMAP_CHUNK_SHIFT)
 unsigned long vmemmap_table[VMEMMAP_SIZE];
 
 int __meminit vmemmap_populate(struct page *start, unsigned long nr, int node)
@@ -2168,7 +2148,6 @@ static void __init sun4u_pgprot_init(void)
 				       _PAGE_CACHE_4U | _PAGE_P_4U |
 				       __ACCESS_BITS_4U | __DIRTY_BITS_4U |
 				       _PAGE_EXEC_4U | _PAGE_L_4U);
-	PAGE_EXEC = __pgprot(_PAGE_EXEC_4U);
 
 	_PAGE_IE = _PAGE_IE_4U;
 	_PAGE_E = _PAGE_E_4U;
@@ -2179,10 +2158,10 @@ static void __init sun4u_pgprot_init(void)
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	kern_linear_pte_xor[0] = (_PAGE_VALID | _PAGE_SZBITS_4U) ^
-		0xfffff80000000000;
+		0xfffff80000000000UL;
 #else
 	kern_linear_pte_xor[0] = (_PAGE_VALID | _PAGE_SZ4MB_4U) ^
-		0xfffff80000000000;
+		0xfffff80000000000UL;
 #endif
 	kern_linear_pte_xor[0] |= (_PAGE_CP_4U | _PAGE_CV_4U |
 				   _PAGE_P_4U | _PAGE_W_4U);
@@ -2220,7 +2199,6 @@ static void __init sun4v_pgprot_init(void)
 				__ACCESS_BITS_4V | __DIRTY_BITS_4V |
 				_PAGE_EXEC_4V);
 	PAGE_KERNEL_LOCKED = PAGE_KERNEL;
-	PAGE_EXEC = __pgprot(_PAGE_EXEC_4V);
 
 	_PAGE_IE = _PAGE_IE_4V;
 	_PAGE_E = _PAGE_E_4V;
@@ -2228,20 +2206,20 @@ static void __init sun4v_pgprot_init(void)
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	kern_linear_pte_xor[0] = (_PAGE_VALID | _PAGE_SZBITS_4V) ^
-		0xfffff80000000000;
+		0xfffff80000000000UL;
 #else
 	kern_linear_pte_xor[0] = (_PAGE_VALID | _PAGE_SZ4MB_4V) ^
-		0xfffff80000000000;
+		0xfffff80000000000UL;
 #endif
 	kern_linear_pte_xor[0] |= (_PAGE_CP_4V | _PAGE_CV_4V |
 				   _PAGE_P_4V | _PAGE_W_4V);
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	kern_linear_pte_xor[1] = (_PAGE_VALID | _PAGE_SZBITS_4V) ^
-		0xfffff80000000000;
+		0xfffff80000000000UL;
 #else
 	kern_linear_pte_xor[1] = (_PAGE_VALID | _PAGE_SZ256MB_4V) ^
-		0xfffff80000000000;
+		0xfffff80000000000UL;
 #endif
 	kern_linear_pte_xor[1] |= (_PAGE_CP_4V | _PAGE_CV_4V |
 				   _PAGE_P_4V | _PAGE_W_4V);
diff --git a/arch/sparc64/mm/init.h b/arch/sparc64/mm/init.h
new file mode 100644
index 0000000..1606387
--- /dev/null
+++ b/arch/sparc64/mm/init.h
@@ -0,0 +1,49 @@
+#ifndef _SPARC64_MM_INIT_H
+#define _SPARC64_MM_INIT_H
+
+/* Most of the symbols in this file are defined in init.c and
+ * marked non-static so that assembler code can get at them.
+ */
+
+#define MAX_PHYS_ADDRESS	(1UL << 42UL)
+#define KPTE_BITMAP_CHUNK_SZ	(256UL * 1024UL * 1024UL)
+#define KPTE_BITMAP_BYTES	\
+	((MAX_PHYS_ADDRESS / KPTE_BITMAP_CHUNK_SZ) / 8)
+
+extern unsigned long kern_linear_pte_xor[2];
+extern unsigned long kpte_linear_bitmap[KPTE_BITMAP_BYTES / sizeof(unsigned long)];
+extern unsigned int sparc64_highest_unlocked_tlb_ent;
+extern unsigned long sparc64_kern_pri_context;
+extern unsigned long sparc64_kern_pri_nuc_bits;
+extern unsigned long sparc64_kern_sec_context;
+extern void mmu_info(struct seq_file *m);
+
+struct linux_prom_translation {
+	unsigned long virt;
+	unsigned long size;
+	unsigned long data;
+};
+
+/* Exported for kernel TLB miss handling in ktlb.S */
+extern struct linux_prom_translation prom_trans[512];
+extern unsigned int prom_trans_ents;
+
+/* Exported for SMP bootup purposes. */
+extern unsigned long kern_locked_tte_data;
+
+extern void prom_world(int enter);
+
+extern void free_initmem(void);
+
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+#define VMEMMAP_CHUNK_SHIFT	22
+#define VMEMMAP_CHUNK		(1UL << VMEMMAP_CHUNK_SHIFT)
+#define VMEMMAP_CHUNK_MASK	~(VMEMMAP_CHUNK - 1UL)
+#define VMEMMAP_ALIGN(x)	(((x)+VMEMMAP_CHUNK-1UL)&VMEMMAP_CHUNK_MASK)
+
+#define VMEMMAP_SIZE	((((1UL << MAX_PHYSADDR_BITS) >> PAGE_SHIFT) * \
+			  sizeof(struct page *)) >> VMEMMAP_CHUNK_SHIFT)
+extern unsigned long vmemmap_table[VMEMMAP_SIZE];
+#endif
+
+#endif /* _SPARC64_MM_INIT_H */
-- 
1.5.6.5.GIT

