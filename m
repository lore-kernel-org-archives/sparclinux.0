From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 06 Jun 2008 21:00:24 +0000
Subject: [PATCH 12/21] sparc: Merge asm-sparc{,64}/mman.h
Message-Id: <1212786033-4227-12-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Renaming the function sparc64_mmap_check() to
sparc_mmap_check() was enough to make the two
header files identical.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc64/kernel/sys_sparc.c   |    6 +++---
 arch/sparc64/kernel/sys_sparc32.c |    4 ++--
 include/asm-sparc64/mman.h        |   32 +-------------------------------
 3 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/arch/sparc64/kernel/sys_sparc.c b/arch/sparc64/kernel/sys_sparc.c
index ac1bff5..e1f4eba 100644
--- a/arch/sparc64/kernel/sys_sparc.c
+++ b/arch/sparc64/kernel/sys_sparc.c
@@ -542,7 +542,7 @@ asmlinkage long sparc64_personality(unsigned long personality)
 	return ret;
 }
 
-int sparc64_mmap_check(unsigned long addr, unsigned long len)
+int sparc_mmap_check(unsigned long addr, unsigned long len)
 {
 	if (test_thread_flag(TIF_32BIT)) {
 		if (len >= STACK_TOP32)
@@ -614,9 +614,9 @@ asmlinkage unsigned long sys64_mremap(unsigned long addr,
 		goto out;
 	if (unlikely(new_len >= VA_EXCLUDE_START))
 		goto out;
-	if (unlikely(sparc64_mmap_check(addr, old_len)))
+	if (unlikely(sparc_mmap_check(addr, old_len)))
 		goto out;
-	if (unlikely(sparc64_mmap_check(new_addr, new_len)))
+	if (unlikely(sparc_mmap_check(new_addr, new_len)))
 		goto out;
 
 	down_write(&current->mm->mmap_sem);
diff --git a/arch/sparc64/kernel/sys_sparc32.c b/arch/sparc64/kernel/sys_sparc32.c
index ba5bd62..d4fd58c 100644
--- a/arch/sparc64/kernel/sys_sparc32.c
+++ b/arch/sparc64/kernel/sys_sparc32.c
@@ -870,9 +870,9 @@ asmlinkage unsigned long sys32_mremap(unsigned long addr,
 	unsigned long ret = -EINVAL;
 	unsigned long new_addr = __new_addr;
 
-	if (unlikely(sparc64_mmap_check(addr, old_len)))
+	if (unlikely(sparc_mmap_check(addr, old_len)))
 		goto out;
-	if (unlikely(sparc64_mmap_check(new_addr, new_len)))
+	if (unlikely(sparc_mmap_check(new_addr, new_len)))
 		goto out;
 	down_write(&current->mm->mmap_sem);
 	ret = do_mremap(addr, old_len, new_len, flags, new_addr);
diff --git a/include/asm-sparc64/mman.h b/include/asm-sparc64/mman.h
index d2ae67c..17ddb17 100644
--- a/include/asm-sparc64/mman.h
+++ b/include/asm-sparc64/mman.h
@@ -1,31 +1 @@
-#ifndef __SPARC64_MMAN_H__
-#define __SPARC64_MMAN_H__
-
-#include <asm-generic/mman.h>
-
-/* SunOS'ified... */
-
-#define MAP_RENAME      MAP_ANONYMOUS   /* In SunOS terminology */
-#define MAP_NORESERVE   0x40            /* don't reserve swap pages */
-#define MAP_INHERIT     0x80            /* SunOS doesn't do this, but... */
-#define MAP_LOCKED      0x100           /* lock the mapping */
-#define _MAP_NEW        0x80000000      /* Binary compatibility is fun... */
-
-#define MAP_GROWSDOWN	0x0200		/* stack-like segment */
-#define MAP_DENYWRITE	0x0800		/* ETXTBSY */
-#define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
-
-#define MCL_CURRENT     0x2000          /* lock all currently mapped pages */
-#define MCL_FUTURE      0x4000          /* lock all additions to address space */
-
-#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-
-#ifdef __KERNEL__
-#ifndef __ASSEMBLY__
-#define arch_mmap_check(addr,len,flags)	sparc64_mmap_check(addr,len)
-int sparc64_mmap_check(unsigned long addr, unsigned long len);
-#endif
-#endif
-
-#endif /* __SPARC64_MMAN_H__ */
+#include <asm-sparc/mman.h>
-- 
1.5.4.1.143.ge7e51

