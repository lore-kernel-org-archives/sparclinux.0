From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 10 Oct 2006 15:46:35 +0000
Subject: [PATCH 4/4] fix sparc32 modpost warnings
Message-Id: <20061010154635.GE30909@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix this 2.6.19-rc1 build warnings from modpost:

WARNING: vmlinux - Section mismatch: reference to .init.text:sunzilog_console_setup from .data between 'sunzilog_console' (at offset 0x8394) and 'devices_subsys'

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
Index: linux/drivers/serial/sunzilog.c
=================================--- linux.orig/drivers/serial/sunzilog.c	2006-10-06 00:33:43.000000000 +0100
+++ linux/drivers/serial/sunzilog.c	2006-10-07 03:48:41.000000000 +0100
@@ -1190,7 +1190,7 @@
 	return 0;
 }
 
-static struct console sunzilog_console = {
+static struct console sunzilog_console_ops = {
 	.name	=	"ttyS",
 	.write	=	sunzilog_console_write,
 	.device	=	uart_console_device,
@@ -1216,10 +1216,10 @@
 	if (i = NUM_CHANNELS)
 		return NULL;
 
-	sunzilog_console.index = i;
+	sunzilog_console_ops.index = i;
 	sunzilog_port_table[i].flags |= SUNZILOG_FLAG_IS_CONS;
 
-	return &sunzilog_console;
+	return &sunzilog_console_ops;
 }
 
 #else
