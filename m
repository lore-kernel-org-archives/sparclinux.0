From: Chanho Min <chanho.min@lge.com>
Date: Thu, 02 May 2013 09:56:19 +0000
Subject: [PATCH] lib: add weak clz/ctz functions
Message-Id: <1367488579-15456-1-git-send-email-chanho.min@lge.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kyungsik Lee <kyungsik.lee@lge.com>, Yann Collet <yann.collet.73@gmail.com>, Bob Pearson <rpearson@systemfabricworks.com>, Richard Weinberger <richard@nod.at>, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-m68k@vger.kernel.org, linux-next@vger.kernel.org, Chanho Min <chanho.min@lge.com>

Some architectures need __c[lt]z[sd]i2() for __builtin_c[lt]z[ll] and
It causes build failure. They can be implemented using the fls()/__ffs() and
overridden by linking arch-specific versions may not be implemented yet.

Reference: https://lkml.org/lkml/2013/4/18/603
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 lib/Makefile  |    2 +-
 lib/clz_ctz.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 lib/clz_ctz.c

diff --git a/lib/Makefile b/lib/Makefile
index af79e8c..3eacb2c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -23,7 +23,7 @@ lib-y	+= kobject.o klist.o
 
 obj-y += bcd.o div64.o sort.o parser.o halfmd4.o debug_locks.o random32.o \
 	 bust_spinlocks.o hexdump.o kasprintf.o bitmap.o scatterlist.o \
-	 gcd.o lcm.o list_sort.o uuid.o flex_array.o \
+	 gcd.o lcm.o list_sort.o uuid.o flex_array.o clz_ctz.o\
 	 bsearch.o find_last_bit.o find_next_bit.o llist.o memweight.o kfifo.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
diff --git a/lib/clz_ctz.c b/lib/clz_ctz.c
new file mode 100644
index 0000000..a8f8379
--- /dev/null
+++ b/lib/clz_ctz.c
@@ -0,0 +1,58 @@
+/*
+ * lib/clz_ctz.c
+ *
+ * Copyright (C) 2013 Chanho Min <chanho.min@lge.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * __c[lt]z[sd]i2 can be overridden by linking arch-specific versions.
+ */
+
+#include <linux/export.h>
+#include <linux/kernel.h>
+
+int __weak __ctzsi2(int val)
+{
+	return __ffs(val);
+}
+EXPORT_SYMBOL(__ctzsi2);
+
+int __weak __clzsi2(int val)
+{
+	return 32 - fls(val);
+}
+EXPORT_SYMBOL(__clzsi2);
+
+#if BITS_PER_LONG = 32
+
+int __weak __clzdi2(long val)
+{
+	return 32 - fls((int)val);
+}
+EXPORT_SYMBOL(__clzdi2);
+
+int __weak __ctzdi2(long val)
+{
+	return __ffs((u32)val);
+}
+EXPORT_SYMBOL(__ctzdi2);
+
+#elif BITS_PER_LONG = 64
+
+int __weak __clzdi2(long val)
+{
+	return 64 - fls64((u64)val);
+}
+EXPORT_SYMBOL(__clzdi2);
+
+int __weak __ctzdi2(long val)
+{
+	return __ffs64((u64)val);
+}
+EXPORT_SYMBOL(__ctzdi2);
+
+#else
+#error BITS_PER_LONG not 32 or 64
+#endif
-- 
1.7.9.5

