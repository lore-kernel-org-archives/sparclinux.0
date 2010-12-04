From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 04 Dec 2010 03:57:47 +0000
Subject: [RFC 5/8] sparc: prom: Merge console_*.c into printf.c
Message-Id: <4CF9BC3B.10306@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

prom_console_write_buf() is only used in prom/printf.c, so as it's
the only remaining function in console_*.c, let's merge console_*.c
into printf.c.

We'll also rename prom_nbputchar() to __prom_console_write_buf()
and merge the definitions of prom_console_write_buf() as they're
identical.

Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
---
 arch/sparc/prom/Makefile     |    1 -
 arch/sparc/prom/console_32.c |   56 ---------------------------------
 arch/sparc/prom/console_64.c |   48 ----------------------------
 arch/sparc/prom/printf.c     |   71 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 69 insertions(+), 107 deletions(-)
 delete mode 100644 arch/sparc/prom/console_32.c
 delete mode 100644 arch/sparc/prom/console_64.c

diff --git a/arch/sparc/prom/Makefile b/arch/sparc/prom/Makefile
index 816c0fa..cf14bbf 100644
--- a/arch/sparc/prom/Makefile
+++ b/arch/sparc/prom/Makefile
@@ -13,7 +13,6 @@ lib-$(CONFIG_SPARC32) += mp.o
 lib-$(CONFIG_SPARC32) += palloc.o
 lib-$(CONFIG_SPARC32) += ranges.o
 lib-$(CONFIG_SPARC32) += segment.o
-lib-y                 += console_$(BITS).o
 lib-y                 += printf.o
 lib-y                 += tree_$(BITS).o
 lib-$(CONFIG_SPARC64) += p1275.o
diff --git a/arch/sparc/prom/console_32.c b/arch/sparc/prom/console_32.c
deleted file mode 100644
index 055368a..0000000
--- a/arch/sparc/prom/console_32.c
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * console.c: Routines that deal with sending and receiving IO
- *            to/from the current console device using the PROM.
- *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- * Copyright (C) 1998 Pete Zaitcev <zaitcev@yahoo.com>
- */
-
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <asm/openprom.h>
-#include <asm/oplib.h>
-#include <asm/system.h>
-#include <linux/string.h>
-
-extern void restore_current(void);
-
-/* Non blocking put character to console device, returns -1 if
- * unsuccessful.
- */
-static int prom_nbputchar(const char *buf)
-{
-	unsigned long flags;
-	int i = -1;
-
-	spin_lock_irqsave(&prom_lock, flags);
-	switch(prom_vers) {
-	case PROM_V0:
-		if ((*(romvec->pv_nbputchar))(*buf))
-			i = 1;
-		break;
-	case PROM_V2:
-	case PROM_V3:
-		if ((*(romvec->pv_v2devops).v2_dev_write)(*romvec->pv_v2bootargs.fd_stdout,
-							  buf, 0x1) = 1)
-			i = 1;
-		break;
-	default:
-		break;
-	};
-	restore_current();
-	spin_unlock_irqrestore(&prom_lock, flags);
-	return i; /* Ugh, we could spin forever on unsupported proms ;( */
-}
-
-void prom_console_write_buf(const char *buf, int len)
-{
-	while (len) {
-		int n = prom_nbputchar(buf);
-		if (n < 0)
-			continue;
-		len -= n;
-		buf += n;
-	}
-}
diff --git a/arch/sparc/prom/console_64.c b/arch/sparc/prom/console_64.c
deleted file mode 100644
index d66b98c..0000000
--- a/arch/sparc/prom/console_64.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/* console.c: Routines that deal with sending and receiving IO
- *            to/from the current console device using the PROM.
- *
- * Copyright (C) 1995 David S. Miller (davem@davemloft.net)
- * Copyright (C) 1996,1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- */
-
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <asm/openprom.h>
-#include <asm/oplib.h>
-#include <asm/system.h>
-#include <linux/string.h>
-
-extern int prom_stdout;
-
-static int __prom_console_write_buf(const char *buf, int len)
-{
-	unsigned long args[7];
-	int ret;
-
-	args[0] = (unsigned long) "write";
-	args[1] = 3;
-	args[2] = 1;
-	args[3] = (unsigned int) prom_stdout;
-	args[4] = (unsigned long) buf;
-	args[5] = (unsigned int) len;
-	args[6] = (unsigned long) -1;
-
-	p1275_cmd_direct(args);
-
-	ret = (int) args[6];
-	if (ret < 0)
-		return -1;
-	return ret;
-}
-
-void prom_console_write_buf(const char *buf, int len)
-{
-	while (len) {
-		int n = __prom_console_write_buf(buf, len);
-		if (n < 0)
-			continue;
-		len -= n;
-		buf += n;
-	}
-}
diff --git a/arch/sparc/prom/printf.c b/arch/sparc/prom/printf.c
index d9682f0..590b985 100644
--- a/arch/sparc/prom/printf.c
+++ b/arch/sparc/prom/printf.c
@@ -2,8 +2,8 @@
  * printf.c:  Internal prom library printf facility.
  *
  * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- * Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- * Copyright (c) 2002 Pete Zaitcev (zaitcev@yahoo.com)
+ * Copyright (C) 1996,1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
+ * Copyright (c) 1998,2002 Pete Zaitcev (zaitcev@yahoo.com)
  *
  * We used to warn all over the code: DO NOT USE prom_printf(),
  * and yet people do. Anton's banking code was outputting banks
@@ -26,6 +26,73 @@ static char ppbuf[1024];
 static char console_write_buf[CONSOLE_WRITE_BUF_SIZE];
 static DEFINE_RAW_SPINLOCK(console_write_lock);
 
+#ifdef CONFIG_SPARC32
+
+extern void restore_current(void);
+
+static int __prom_console_write_buf(const char *buf, int len)
+{
+	unsigned long flags;
+	int i = -1;
+
+	spin_lock_irqsave(&prom_lock, flags);
+	switch(prom_vers) {
+	case PROM_V0:
+		if ((*(romvec->pv_nbputchar))(*buf))
+			i = 1;
+		break;
+	case PROM_V2:
+	case PROM_V3:
+		if ((*(romvec->pv_v2devops).v2_dev_write)(*romvec->pv_v2bootargs.fd_stdout,
+							  buf, 0x1) = 1)
+			i = 1;
+		break;
+	default:
+		break;
+	};
+	restore_current();
+	spin_unlock_irqrestore(&prom_lock, flags);
+	return i; /* Ugh, we could spin forever on unsupported proms ;( */
+}
+
+#else
+
+extern int prom_stdout;
+
+static int __prom_console_write_buf(const char *buf, int len)
+{
+	unsigned long args[7];
+	int ret;
+
+	args[0] = (unsigned long) "write";
+	args[1] = 3;
+	args[2] = 1;
+	args[3] = (unsigned int) prom_stdout;
+	args[4] = (unsigned long) buf;
+	args[5] = (unsigned int) len;
+	args[6] = (unsigned long) -1;
+
+	p1275_cmd_direct(args);
+
+	ret = (int) args[6];
+	if (ret < 0)
+		return -1;
+	return ret;
+}
+
+#endif
+
+void prom_console_write_buf(const char *buf, int len)
+{
+	while (len) {
+		int n = __prom_console_write_buf(buf, len);
+		if (n < 0)
+			continue;
+		len -= n;
+		buf += n;
+	}
+}
+
 void notrace prom_write(const char *buf, unsigned int n)
 {
 	unsigned int dest_len;
