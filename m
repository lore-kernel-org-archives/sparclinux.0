From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Wed, 28 Jun 2006 14:16:01 +0000
Subject: [PATCH] sparc: remove sunzilog_console_init
Message-Id: <20060628141601.GA31139@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

This patch against 2.6.17 resolves the following build warning:
  CC      drivers/serial/sunzilog.o
drivers/serial/sunzilog.c:1390: warning: `sunzilog_console_init' defined but not used

It was tested on a SS20 with the console on a sunzilog.

Martin

--- 2.6.17/drivers/serial/sunzilog.c.old	2006-06-28 15:04:17.000000000 +0100
+++ 2.6.17/drivers/serial/sunzilog.c	2006-06-28 15:07:43.000000000 +0100
@@ -1386,28 +1386,6 @@
 	.data   =	&sunzilog_reg,
 };
 
-static int __init sunzilog_console_init(void)
-{
-	int i;
-
-	if (con_is_present())
-		return 0;
-
-	for (i = 0; i < NUM_CHANNELS; i++) {
-		int this_minor = sunzilog_reg.minor + i;
-
-		if ((this_minor - 64) = (serial_console - 1))
-			break;
-	}
-	if (i = NUM_CHANNELS)
-		return 0;
-
-	sunzilog_console.index = i;
-	sunzilog_port_table[i].flags |= SUNZILOG_FLAG_IS_CONS;
-	register_console(&sunzilog_console);
-	return 0;
-}
-
 static inline struct console *SUNZILOG_CONSOLE(void)
 {
 	int i;
@@ -1432,7 +1410,6 @@
 
 #else
 #define SUNZILOG_CONSOLE()	(NULL)
-#define sunzilog_console_init() do { } while (0)
 #endif
 
 /*
