From: David Miller <davem@davemloft.net>
Date: Tue, 25 Oct 2016 15:02:42 +0000
Subject: [PATCH 11/11] sparc64: Delete now unused user copy fixup functions.
Message-Id: <20161025.110242.1453121195390324182.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Now that all of the user copy routines are converted to return
accurate residual lengths when an exception occurs, we no longer need
the broken fixup routines.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/uaccess_64.h | 36 ++-----------------
 arch/sparc/lib/Makefile             |  2 +-
 arch/sparc/lib/user_fixup.c         | 71 -------------------------------------
 3 files changed, 4 insertions(+), 105 deletions(-)
 delete mode 100644 arch/sparc/lib/user_fixup.c

diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index 0244012..5373136 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -188,64 +188,34 @@ int __get_user_bad(void);
 unsigned long __must_check ___copy_from_user(void *to,
 					     const void __user *from,
 					     unsigned long size);
-unsigned long copy_from_user_fixup(void *to, const void __user *from,
-				   unsigned long size);
 static inline unsigned long __must_check
 copy_from_user(void *to, const void __user *from, unsigned long size)
 {
-	unsigned long ret;
-
 	check_object_size(to, size, false);
 
-	ret = ___copy_from_user(to, from, size);
-	if (unlikely(ret)) {
-		if ((long)ret < 0)
-			ret = copy_from_user_fixup(to, from, size);
-		return ret;
-	}
-
-	return ret;
+	return ___copy_from_user(to, from, size);
 }
 #define __copy_from_user copy_from_user
 
 unsigned long __must_check ___copy_to_user(void __user *to,
 					   const void *from,
 					   unsigned long size);
-unsigned long copy_to_user_fixup(void __user *to, const void *from,
-				 unsigned long size);
 static inline unsigned long __must_check
 copy_to_user(void __user *to, const void *from, unsigned long size)
 {
-	unsigned long ret;
-
 	check_object_size(from, size, true);
 
-	ret = ___copy_to_user(to, from, size);
-	if (unlikely(ret)) {
-		if ((long)ret < 0)
-			ret = copy_to_user_fixup(to, from, size);
-		return ret;
-	}
-	return ret;
+	return ___copy_to_user(to, from, size);
 }
 #define __copy_to_user copy_to_user
 
 unsigned long __must_check ___copy_in_user(void __user *to,
 					   const void __user *from,
 					   unsigned long size);
-unsigned long copy_in_user_fixup(void __user *to, void __user *from,
-				 unsigned long size);
 static inline unsigned long __must_check
 copy_in_user(void __user *to, void __user *from, unsigned long size)
 {
-	unsigned long ret = ___copy_in_user(to, from, size);
-
-	if (unlikely(ret)) {
-		if ((long)ret < 0)
-			ret = copy_in_user_fixup(to, from, size);
-		return ret;
-	}
-	return ret;
+	return ___copy_in_user(to, from, size);
 }
 #define __copy_in_user copy_in_user
 
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 885f00e..69912d2 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -38,7 +38,7 @@ lib-$(CONFIG_SPARC64) +=  NG4patch.o NG4copy_page.o NG4clear_page.o NG4memset.o
 lib-$(CONFIG_SPARC64) += GENmemcpy.o GENcopy_from_user.o GENcopy_to_user.o
 lib-$(CONFIG_SPARC64) += GENpatch.o GENpage.o GENbzero.o
 
-lib-$(CONFIG_SPARC64) += copy_in_user.o user_fixup.o memmove.o
+lib-$(CONFIG_SPARC64) += copy_in_user.o memmove.o
 lib-$(CONFIG_SPARC64) += mcount.o ipcsum.o xor.o hweight.o ffs.o
 
 obj-$(CONFIG_SPARC64) += iomap.o
diff --git a/arch/sparc/lib/user_fixup.c b/arch/sparc/lib/user_fixup.c
deleted file mode 100644
index ac96ae2..0000000
--- a/arch/sparc/lib/user_fixup.c
+++ /dev/null
@@ -1,71 +0,0 @@
-/* user_fixup.c: Fix up user copy faults.
- *
- * Copyright (C) 2004 David S. Miller <davem@redhat.com>
- */
-
-#include <linux/compiler.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/module.h>
-
-#include <asm/uaccess.h>
-
-/* Calculating the exact fault address when using
- * block loads and stores can be very complicated.
- *
- * Instead of trying to be clever and handling all
- * of the cases, just fix things up simply here.
- */
-
-static unsigned long compute_size(unsigned long start, unsigned long size, unsigned long *offset)
-{
-	unsigned long fault_addr = current_thread_info()->fault_address;
-	unsigned long end = start + size;
-
-	if (fault_addr < start || fault_addr >= end) {
-		*offset = 0;
-	} else {
-		*offset = fault_addr - start;
-		size = end - fault_addr;
-	}
-	return size;
-}
-
-unsigned long copy_from_user_fixup(void *to, const void __user *from, unsigned long size)
-{
-	unsigned long offset;
-
-	size = compute_size((unsigned long) from, size, &offset);
-	if (likely(size))
-		memset(to + offset, 0, size);
-
-	return size;
-}
-EXPORT_SYMBOL(copy_from_user_fixup);
-
-unsigned long copy_to_user_fixup(void __user *to, const void *from, unsigned long size)
-{
-	unsigned long offset;
-
-	return compute_size((unsigned long) to, size, &offset);
-}
-EXPORT_SYMBOL(copy_to_user_fixup);
-
-unsigned long copy_in_user_fixup(void __user *to, void __user *from, unsigned long size)
-{
-	unsigned long fault_addr = current_thread_info()->fault_address;
-	unsigned long start = (unsigned long) to;
-	unsigned long end = start + size;
-
-	if (fault_addr >= start && fault_addr < end)
-		return end - fault_addr;
-
-	start = (unsigned long) from;
-	end = start + size;
-	if (fault_addr >= start && fault_addr < end)
-		return end - fault_addr;
-
-	return size;
-}
-EXPORT_SYMBOL(copy_in_user_fixup);
-- 
2.1.2.532.g19b5d50

