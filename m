From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 26 Jul 2012 21:02:18 +0000
Subject: [PATCH 08/18] sparc32: fixmap.h cleanup
Message-Id: <1343336548-3879-8-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Remove all unused stuff from fixmap.h
It is only used for highmem - sparc32 has no fixmap support.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/fixmap.h |   94 ++------------------------------------
 1 files changed, 5 insertions(+), 89 deletions(-)

diff --git a/arch/sparc/include/asm/fixmap.h b/arch/sparc/include/asm/fixmap.h
index f18fc07..0bdec93 100644
--- a/arch/sparc/include/asm/fixmap.h
+++ b/arch/sparc/include/asm/fixmap.h
@@ -1,110 +1,26 @@
-/*
- * fixmap.h: compile-time virtual memory allocation
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1998 Ingo Molnar
- *
- * Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
- */
+/* Highmem related constants */
 
 #ifndef _ASM_FIXMAP_H
 #define _ASM_FIXMAP_H
 
-#include <linux/kernel.h>
-#include <asm/page.h>
-#ifdef CONFIG_HIGHMEM
-#include <linux/threads.h>
 #include <asm/kmap_types.h>
-#endif
 
-/*
- * Here we define all the compile-time 'special' virtual
- * addresses. The point is to have a constant address at
- * compile time, but to set the physical address only
- * in the boot process. We allocate these special  addresses
- * from the top of unused virtual memory (0xfd000000 - 1 page) backwards.
- * Also this lets us do fail-safe vmalloc(), we
- * can guarantee that these special addresses and
- * vmalloc()-ed addresses never overlap.
- *
- * these 'compile-time allocated' memory buffers are
- * fixed-size 4k pages. (or larger if used with an increment
- * highger than 1) use fixmap_set(idx,phys) to associate
- * physical memory with fixmap indices.
- *
- * TLB entries of such buffers will not be flushed across
- * task switches.
- */
-
-/*
- * on UP currently we will have no trace of the fixmap mechanism,
- * no page table allocations, etc. This might change in the
- * future, say framebuffers for the console driver(s) could be
- * fix-mapped?
- */
 enum fixed_addresses {
 	FIX_HOLE,
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,
-	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+	FIX_KMAP_END = (KM_TYPE_NR * NR_CPUS),
 #endif
 	__end_of_fixed_addresses
 };
 
-extern void __set_fixmap (enum fixed_addresses idx,
-					unsigned long phys, pgprot_t flags);
-
-#define set_fixmap(idx, phys) \
-		__set_fixmap(idx, phys, PAGE_KERNEL)
-/*
- * Some hardware wants to get fixmapped without caching.
- */
-#define set_fixmap_nocache(idx, phys) \
-		__set_fixmap(idx, phys, PAGE_KERNEL_NOCACHE)
-/*
- * used by vmalloc.c.
- *
- * Leave one empty page between IO pages at 0xfd000000 and
- * the start of the fixmap.
+/* Leave one empty page between IO pages at 0xfd000000 and
+ * the top of the fixmap.
  */
 #define FIXADDR_TOP	(0xfcfff000UL)
-#define FIXADDR_SIZE	((__end_of_fixed_addresses) << PAGE_SHIFT)
+#define FIXADDR_SIZE	((FIX_KMAP_END + 1) << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
 
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
-#define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
-
-extern void __this_fixmap_does_not_exist(void);
-
-/*
- * 'index to address' translation. If anyone tries to use the idx
- * directly without tranlation, we catch the bug with a NULL-deference
- * kernel oops. Illegal ranges of incoming indices are caught too.
- */
-static inline unsigned long fix_to_virt(const unsigned int idx)
-{
-	/*
-	 * this branch gets completely eliminated after inlining,
-	 * except when someone tries to use fixaddr indices in an
-	 * illegal way. (such as mixing up address types or using
-	 * out-of-range indices).
-	 *
-	 * If it doesn't get removed, the linker will complain
-	 * loudly with a reasonably clear error message..
-	 */
-	if (idx >= __end_of_fixed_addresses)
-		__this_fixmap_does_not_exist();
-
-        return __fix_to_virt(idx);
-}
-
-static inline unsigned long virt_to_fix(const unsigned long vaddr)
-{
-	BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
-	return __virt_to_fix(vaddr);
-}
 
 #endif
-- 
1.6.0.6

