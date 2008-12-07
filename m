From: Robert Reif <reif@earthlink.net>
Date: Sun, 07 Dec 2008 18:29:42 +0000
Subject: [PATCH] use sparc64 version of prom/printf.c
Message-Id: <493C1616.6080206@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070409060500090505080308"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------070409060500090505080308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Use sparc64 version of prom/printf.c.

The only differences for sparc32 is that prom_printf is no longer 
exported for modules which should be OK.

Signed-off-by: Robert Reif <reif@earthlink.net>


--------------070409060500090505080308
Content-Type: text/plain;
 name="prom-printf.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prom-printf.diff.txt"

 arch/sparc/include/asm/oplib_32.h |    2 +-
 arch/sparc/prom/Makefile          |    2 +-
 arch/sparc/prom/printf.c          |   47 ++++++++++++++++++++++++++++++++++++
 arch/sparc/prom/printf_32.c       |   48 -------------------------------------
 arch/sparc/prom/printf_64.c       |   47 ------------------------------------
 5 files changed, 49 insertions(+), 97 deletions(-)
 create mode 100644 arch/sparc/prom/printf.c
 delete mode 100644 arch/sparc/prom/printf_32.c
 delete mode 100644 arch/sparc/prom/printf_64.c

diff --git a/arch/sparc/include/asm/oplib_32.h b/arch/sparc/include/asm/oplib_32.h
index 3bdf56f..73d4552 100644
--- a/arch/sparc/include/asm/oplib_32.h
+++ b/arch/sparc/include/asm/oplib_32.h
@@ -136,7 +136,7 @@ extern char prom_getchar(void);
 extern void prom_putchar(char character);
 
 /* Prom's internal routines, don't use in kernel/boot code. */
-extern void prom_printf(char *fmt, ...);
+extern void prom_printf(const char *fmt, ...);
 extern void prom_write(const char *buf, unsigned int len);
 
 /* Multiprocessor operations... */
diff --git a/arch/sparc/prom/Makefile b/arch/sparc/prom/Makefile
index f8e0278..1b8c073 100644
--- a/arch/sparc/prom/Makefile
+++ b/arch/sparc/prom/Makefile
@@ -15,7 +15,7 @@ lib-$(CONFIG_SPARC32) += palloc.o
 lib-$(CONFIG_SPARC32) += ranges.o
 lib-$(CONFIG_SPARC32) += segment.o
 lib-y                 += console_$(BITS).o
-lib-y                 += printf_$(BITS).o
+lib-y                 += printf.o
 lib-y                 += tree_$(BITS).o
 lib-$(CONFIG_SPARC64) += p1275.o
 lib-$(CONFIG_SPARC64) += cif.o
diff --git a/arch/sparc/prom/printf.c b/arch/sparc/prom/printf.c
new file mode 100644
index 0000000..660943e
--- /dev/null
+++ b/arch/sparc/prom/printf.c
@@ -0,0 +1,47 @@
+/*
+ * printf.c:  Internal prom library printf facility.
+ *
+ * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
+ * Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
+ * Copyright (c) 2002 Pete Zaitcev (zaitcev@yahoo.com)
+ *
+ * We used to warn all over the code: DO NOT USE prom_printf(),
+ * and yet people do. Anton's banking code was outputting banks
+ * with prom_printf for most of the 2.4 lifetime. Since an effective
+ * stick is not available, we deployed a carrot: an early printk
+ * through PROM by means of -p boot option. This ought to fix it.
+ * USE printk; if you need, deploy -p.
+ */
+
+#include <linux/kernel.h>
+
+#include <asm/openprom.h>
+#include <asm/oplib.h>
+
+static char ppbuf[1024];
+
+void
+prom_write(const char *buf, unsigned int n)
+{
+	char ch;
+
+	while (n != 0) {
+		--n;
+		if ((ch = *buf++) == '\n')
+			prom_putchar('\r');
+		prom_putchar(ch);
+	}
+}
+
+void
+prom_printf(const char *fmt, ...)
+{
+	va_list args;
+	int i;
+
+	va_start(args, fmt);
+	i = vscnprintf(ppbuf, sizeof(ppbuf), fmt, args);
+	va_end(args);
+
+	prom_write(ppbuf, i);
+}
diff --git a/arch/sparc/prom/printf_32.c b/arch/sparc/prom/printf_32.c
deleted file mode 100644
index a36ab9c..0000000
--- a/arch/sparc/prom/printf_32.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * printf.c:  Internal prom library printf facility.
- *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- * Copyright (c) 2002 Pete Zaitcev (zaitcev@yahoo.com)
- *
- * We used to warn all over the code: DO NOT USE prom_printf(),
- * and yet people do. Anton's banking code was outputting banks
- * with prom_printf for most of the 2.4 lifetime. Since an effective
- * stick is not available, we deployed a carrot: an early printk
- * through PROM by means of -p boot option. This ought to fix it.
- * USE printk; if you need, deploy -p.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-
-#include <asm/openprom.h>
-#include <asm/oplib.h>
-
-static char ppbuf[1024];
-
-void
-prom_write(const char *buf, unsigned int n)
-{
-	char ch;
-
-	while (n != 0) {
-		--n;
-		if ((ch = *buf++) == '\n')
-			prom_putchar('\r');
-		prom_putchar(ch);
-	}
-}
-
-void
-prom_printf(char *fmt, ...)
-{
-	va_list args;
-	int i;
-
-	va_start(args, fmt);
-	i = vscnprintf(ppbuf, sizeof(ppbuf), fmt, args);
-	va_end(args);
-
-	prom_write(ppbuf, i);
-}
-EXPORT_SYMBOL(prom_printf);
diff --git a/arch/sparc/prom/printf_64.c b/arch/sparc/prom/printf_64.c
deleted file mode 100644
index 660943e..0000000
--- a/arch/sparc/prom/printf_64.c
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * printf.c:  Internal prom library printf facility.
- *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- * Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- * Copyright (c) 2002 Pete Zaitcev (zaitcev@yahoo.com)
- *
- * We used to warn all over the code: DO NOT USE prom_printf(),
- * and yet people do. Anton's banking code was outputting banks
- * with prom_printf for most of the 2.4 lifetime. Since an effective
- * stick is not available, we deployed a carrot: an early printk
- * through PROM by means of -p boot option. This ought to fix it.
- * USE printk; if you need, deploy -p.
- */
-
-#include <linux/kernel.h>
-
-#include <asm/openprom.h>
-#include <asm/oplib.h>
-
-static char ppbuf[1024];
-
-void
-prom_write(const char *buf, unsigned int n)
-{
-	char ch;
-
-	while (n != 0) {
-		--n;
-		if ((ch = *buf++) == '\n')
-			prom_putchar('\r');
-		prom_putchar(ch);
-	}
-}
-
-void
-prom_printf(const char *fmt, ...)
-{
-	va_list args;
-	int i;
-
-	va_start(args, fmt);
-	i = vscnprintf(ppbuf, sizeof(ppbuf), fmt, args);
-	va_end(args);
-
-	prom_write(ppbuf, i);
-}


--------------070409060500090505080308--
