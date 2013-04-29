From: Chanho Min <chanho.min@lge.com>
Date: Mon, 29 Apr 2013 05:40:05 +0000
Subject: [PATCH] lib: add weak __clzsi2()/__clzdi2() functions
Message-Id: <1367214005-14302-1-git-send-email-chanho.min@lge.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kyungsik Lee <kyungsik.lee@lge.com>, Yann Collet <yann.collet.73@gmail.com>, Bob Pearson <rpearson@systemfabricworks.com>, Richard Weinberger <richard@nod.at>, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-m68k@vger.kernel.org, linux-next@vger.kernel.org, Chanho Min <chanho.min@lge.com>

Some architectures need __clzsi2() or __clzdi2() for __builtin_clz and
It causes build failure. They can be implemented using the fls() and
overridden by linking arch-specific versions may not be implemented yet.

Reference: https://lkml.org/lkml/2013/4/18/603
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 lib/Makefile |    2 +-
 lib/clz.c    |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 lib/clz.c

diff --git a/lib/Makefile b/lib/Makefile
index af79e8c..e17b3ee 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -23,7 +23,7 @@ lib-y	+= kobject.o klist.o
 
 obj-y += bcd.o div64.o sort.o parser.o halfmd4.o debug_locks.o random32.o \
 	 bust_spinlocks.o hexdump.o kasprintf.o bitmap.o scatterlist.o \
-	 gcd.o lcm.o list_sort.o uuid.o flex_array.o \
+	 gcd.o lcm.o list_sort.o uuid.o flex_array.o clz.o\
 	 bsearch.o find_last_bit.o find_next_bit.o llist.o memweight.o kfifo.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
diff --git a/lib/clz.c b/lib/clz.c
new file mode 100644
index 0000000..5222b2d
--- /dev/null
+++ b/lib/clz.c
@@ -0,0 +1,36 @@
+/*
+ * lib/clz.c
+ *
+ * Copyright (C) 2013 Chanho Min <chanho.min@lge.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * __clzsi2/_clzdi2() can be overridden by linking arch-specific versions.
+ */
+
+#include <linux/export.h>
+#include <linux/kernel.h>
+
+int __weak __clzsi2(int val)
+{
+	return BITS_PER_LONG - fls(val);
+}
+EXPORT_SYMBOL(__clzsi2);
+
+#if BITS_PER_LONG = 32
+int __weak __clzdi2(long val)
+{
+	return BITS_PER_LONG - fls((int)val);
+}
+EXPORT_SYMBOL(__clzdi2);
+#elif BITS_PER_LONG = 64
+int __weak __clzdi2i(long val)
+{
+	return BITS_PER_LONG - fls64((u64)val);
+}
+EXPORT_SYMBOL(__clzdi2);
+#else
+#error BITS_PER_LONG not 32 or 64
+#endif
-- 
1.7.9.5

