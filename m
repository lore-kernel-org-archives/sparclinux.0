From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 03 Aug 2014 14:31:56 +0000
Subject: [PATCH] tlbflush: Prevent flushing locked OBP LITLB entry
Message-Id: <201408031631.57053.cat.schulze@alice-dsl.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>

Prevent flush_tlb_kernel_range() from flushing the locked PROM LITLB entry.
When both a region below LOW_OBP_ADDRESS and a region above HI_OBP_ADDRESS
are to be flushed, __purge_vmap_area_lazy() might decide to combine both
flushes into one call to flush_tlb_kernel_range(), without checking whether
this combined flush will also affect the locked OBP LITLB entry. Removing
this entry will cause a RED state exception on the next reboot, with observed
effects from hang on reboot to corrupted PCI resource information passed to
Linux after the reboot.

This patch tries to prevent this flush by adding a check to
flush_tlb_kernel_range(). This will catch all attempts to flush the OBP LITLB
entry from all possible callers. Fixing the algorithm used in
__purge_vmap_area_lazy() (which is located in the architecture independent
part of the kernel) is also recommended, but not part of this patch.

Patch applies to 3.16-rc6.

Signed-off-by: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>

---

diff -Naupr linux-3.16-rc6-orig/arch/sparc/include/asm/tlbflush_64.h linux-3.16-rc6-patched/arch/sparc/include/asm/tlbflush_64.h
--- linux-3.16-rc6-orig/arch/sparc/include/asm/tlbflush_64.h	2014-07-27 11:46:05.000000000 +0200
+++ linux-3.16-rc6-patched/arch/sparc/include/asm/tlbflush_64.h	2014-08-03 16:12:13.000000000 +0200
@@ -49,8 +49,20 @@ void __flush_tlb_kernel_range(unsigned l
 #ifndef CONFIG_SMP
 
 #define flush_tlb_kernel_range(start,end) \
-do {	flush_tsb_kernel_range(start,end); \
-	__flush_tlb_kernel_range(start,end); \
+do { \
+	if ((start < HI_OBP_ADDRESS) && (end > LOW_OBP_ADDRESS)) { \
+		if (start < LOW_OBP_ADDRESS) { \
+			flush_tsb_kernel_range(start, LOW_OBP_ADDRESS); \
+			__flush_tlb_kernel_range(start, LOW_OBP_ADDRESS); \
+		} \
+		if (end > HI_OBP_ADDRESS) { \
+			flush_tsb_kernel_range(HI_OBP_ADDRESS, end); \
+			__flush_tlb_kernel_range(HI_OBP_ADDRESS, end); \
+		} \
+	} else { \
+		flush_tsb_kernel_range(start, end); \
+		__flush_tlb_kernel_range(start, end); \
+	} \
 } while (0)
 
 static inline void global_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr)
@@ -64,8 +76,20 @@ void smp_flush_tlb_kernel_range(unsigned
 void smp_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr);
 
 #define flush_tlb_kernel_range(start, end) \
-do {	flush_tsb_kernel_range(start,end); \
-	smp_flush_tlb_kernel_range(start, end); \
+do { \
+	if ((start < HI_OBP_ADDRESS) && (end > LOW_OBP_ADDRESS)) { \
+		if (start < LOW_OBP_ADDRESS) { \
+			flush_tsb_kernel_range(start, LOW_OBP_ADDRESS); \
+			smp_flush_tlb_kernel_range(start, LOW_OBP_ADDRESS); \
+		} \
+		if (end > HI_OBP_ADDRESS) { \
+			flush_tsb_kernel_range(HI_OBP_ADDRESS, end); \
+			smp_flush_tlb_kernel_range(HI_OBP_ADDRESS, end); \
+		} \
+	} else { \
+		flush_tsb_kernel_range(start, end); \
+		smp_flush_tlb_kernel_range(start, end); \
+	} \
 } while (0)
 
 #define global_flush_tlb_page(mm, vaddr) \
