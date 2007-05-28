From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Mon, 28 May 2007 23:43:04 +0000
Subject: [PATCH] sun_esp.c build for sparc32 UP
Message-Id: <20070528234304.GA24466@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

A sparc32 UP build of the new ESP driver gives these build errors:

  CC      drivers/scsi/sun_esp.o
drivers/scsi/sun_esp.c: In function `sbus_esp_reset_dma':
drivers/scsi/sun_esp.c:294: error: `loops_per_jiffy' undeclared (first use in this function)
drivers/scsi/sun_esp.c:294: error: (Each undeclared identifier is reported only once
drivers/scsi/sun_esp.c:294: error: for each function it appears in.)
drivers/scsi/sun_esp.c: In function `sbus_esp_dma_drain':
drivers/scsi/sun_esp.c:364: error: `loops_per_jiffy' undeclared (first use in this function)
drivers/scsi/sun_esp.c: In function `sbus_esp_dma_invalidate':
drivers/scsi/sun_esp.c:396: error: `loops_per_jiffy' undeclared (first use in this function)
make[2]: *** [drivers/scsi/sun_esp.o] Error 1

These are due to udelay(). The code includes asm/delay.h (indirectly), but
that is not enough to make it work.

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
Index: linux/drivers/scsi/sun_esp.c
=================================--- linux.orig/drivers/scsi/sun_esp.c	2007-05-26 22:16:06.000000000 +0100
+++ linux/drivers/scsi/sun_esp.c	2007-05-27 23:05:52.000000000 +0100
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
