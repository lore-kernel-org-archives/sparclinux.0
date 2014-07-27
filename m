From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 27 Jul 2014 13:39:39 +0000
Subject: [PATCH] Prevent flushing of locked PROM ITLB entry (RED State Exception or hang on reboot)
Message-Id: <201407271539.40156.cat.schulze@alice-dsl.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On UltraSPARC systems, the PROM establishes a locked ITLB entry that needs
to be present on return to the PROM (which happens when the system reboots).
If the kernel tries to reboot with this ITLB entry not being present, a
RED State Exception is caused, which *may* cause a restart as well, but some
internal state may be corrupted. (It was observed that PCI resource information
from the PROM was badly damaged when a linux kernel was started after such a
RED State Exception, causing subsequent resource allocation errors in the
kernel.) In other cases, the machine might also hang after the RED State Exception.

The locked PROM ITLB entry is flushed by flush_tlb_kernel_range(start, end) when
the flushed interval contains the PROM region from 0xf0000000 to 0x100000000UL.
This seems to happen when __vunmap() is called and triggers a __purge_vmap_area_lazy()
call, where both virtual mappings below 0xf0000000 (kernel modules) and above
0x100000000UL (data mappings) are to be flushed. The kernel at present does not consider
that there might also be a PROM mapping in between, and forces all existing mappings
in the interval determined by __purge_vmap_area_lazy() to be removed.

The flushing of the locked PROM ITLB entry happens in our case already during the boot
process when modules are loaded and unloaded for probing purposes.

With this patch, the affected SunBlade 2000 was able to reboot without problems again.

The patch was originally developed against a 3.13 backport kernel from Debian.
Both the patch against 3.13 and a recent 3.16-rc6 are included below. Please note
that I could only test the 3.13 version as I do not have access to the affected
machine anymore.

PATCH 1 - KERNEL VERSION 3.13 #####################################################

diff -Naupr linux-source-3.13-orig/arch/sparc/include/asm/tlbflush_64.h linux-source-3.13-patched/arch/sparc/include/asm/tlbflush_64.h
--- linux-source-3.13-orig/arch/sparc/include/asm/tlbflush_64.h 2014-04-14 15:48:24.000000000 +0200
+++ linux-source-3.13-patched/arch/sparc/include/asm/tlbflush_64.h      2014-07-27 14:29:58.000000000 +0200
@@ -49,8 +49,20 @@ extern void __flush_tlb_kernel_range(uns
 #ifndef CONFIG_SMP
 
 #define flush_tlb_kernel_range(start,end) \
-do {   flush_tsb_kernel_range(start,end); \
-       __flush_tlb_kernel_range(start,end); \
+do { \
+       if((start < 0x100000000UL) && (end > 0xf0000000)) { \
+               if(start < 0xf0000000) { \
+                         flush_tsb_kernel_range(start, 0xf0000000); \
+                       __flush_tlb_kernel_range(start, 0xf0000000); \
+               } \
+               if(end > 0x100000000UL) { \
+                         flush_tsb_kernel_range(0x100000000UL, end); \
+                       __flush_tlb_kernel_range(0x100000000UL, end); \
+               } \
+       } else { \
+                 flush_tsb_kernel_range(start, end); \
+               __flush_tlb_kernel_range(start, end); \
+       } \
 } while (0)
 
 static inline void global_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr)
@@ -64,8 +76,20 @@ extern void smp_flush_tlb_kernel_range(u
 extern void smp_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr);
 
 #define flush_tlb_kernel_range(start, end) \
-do {   flush_tsb_kernel_range(start,end); \
-       smp_flush_tlb_kernel_range(start, end); \
+do { \
+       if((start < 0x100000000UL) && (end > 0xf0000000)) { \
+               if(start < 0xf0000000) { \
+                           flush_tsb_kernel_range(start, 0xf0000000); \
+                       smp_flush_tlb_kernel_range(start, 0xf0000000); \
+               } \
+               if(end > 0x100000000UL) { \
+                           flush_tsb_kernel_range(0x100000000UL, end); \
+                       smp_flush_tlb_kernel_range(0x100000000UL, end); \
+               } \
+       } else { \
+                   flush_tsb_kernel_range(start, end); \
+               smp_flush_tlb_kernel_range(start, end); \
+       } \
 } while (0)
 
 #define global_flush_tlb_page(mm, vaddr) \

PATCH 2 - KERNEL VERSION 3.16 #####################################################

diff -Naupr linux-3.16-rc6-orig/arch/sparc/include/asm/tlbflush_64.h linux-3.16-rc6-patched/arch/sparc/include/asm/tlbflush_64.h
--- linux-3.16-rc6-orig/arch/sparc/include/asm/tlbflush_64.h    2014-07-27 11:46:05.000000000 +0200
+++ linux-3.16-rc6-patched/arch/sparc/include/asm/tlbflush_64.h 2014-07-27 14:28:12.000000000 +0200
@@ -49,8 +49,20 @@ void __flush_tlb_kernel_range(unsigned l
 #ifndef CONFIG_SMP
 
 #define flush_tlb_kernel_range(start,end) \
-do {   flush_tsb_kernel_range(start,end); \
-       __flush_tlb_kernel_range(start,end); \
+do { \
+       if((start < 0x100000000UL) && (end > 0xf0000000)) { \
+               if(start < 0xf0000000) { \
+                         flush_tsb_kernel_range(start, 0xf0000000); \
+                       __flush_tlb_kernel_range(start, 0xf0000000); \
+               } \
+               if(end > 0x100000000UL) { \
+                         flush_tsb_kernel_range(0x100000000UL, end); \
+                       __flush_tlb_kernel_range(0x100000000UL, end); \
+               } \
+       } else { \
+                 flush_tsb_kernel_range(start, end); \
+               __flush_tlb_kernel_range(start, end); \
+       } \
 } while (0)
 
 static inline void global_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr)
@@ -64,8 +76,20 @@ void smp_flush_tlb_kernel_range(unsigned
 void smp_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr);
 
 #define flush_tlb_kernel_range(start, end) \
-do {   flush_tsb_kernel_range(start,end); \
-       smp_flush_tlb_kernel_range(start, end); \
+do { \
+       if((start < 0x100000000UL) && (end > 0xf0000000)) { \
+               if(start < 0xf0000000) { \
+                           flush_tsb_kernel_range(start, 0xf0000000); \
+                       smp_flush_tlb_kernel_range(start, 0xf0000000); \
+               } \
+               if(end > 0x100000000UL) { \
+                           flush_tsb_kernel_range(0x100000000UL, end); \
+                       smp_flush_tlb_kernel_range(0x100000000UL, end); \
+               } \
+       } else { \
+                   flush_tsb_kernel_range(start, end); \
+               smp_flush_tlb_kernel_range(start, end); \
+       } \
 } while (0)
 
Regards,
Alexander Schulze

