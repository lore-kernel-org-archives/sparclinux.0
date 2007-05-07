From: Robert Reif <reif@earthlink.net>
Date: Mon, 07 May 2007 02:20:47 +0000
Subject: [PATCH] fix sun_esp.c compile
Message-Id: <463E8CFF.7040103@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix a sparc32 compile problem in latest git.

drivers/scsi/sun_esp.c: In function 'sbus_esp_reset_dma':
drivers/scsi/sun_esp.c:294: error: 'loops_per_jiffy' undeclared (first 
use in this function)
drivers/scsi/sun_esp.c:294: error: (Each undeclared identifier is 
reported only once
drivers/scsi/sun_esp.c:294: error: for each function it appears in.)
drivers/scsi/sun_esp.c: In function 'sbus_esp_dma_drain':
drivers/scsi/sun_esp.c:364: error: 'loops_per_jiffy' undeclared (first 
use in this function)
drivers/scsi/sun_esp.c: In function 'sbus_esp_dma_invalidate':
drivers/scsi/sun_esp.c:396: error: 'loops_per_jiffy' undeclared (first 
use in this function)

Signed-off-by: Robert Reif <reif@earthlink.net>

diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index 8c766bc..85b76f2 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -7,6 +7,7 @@ #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/delay.h>
                                                                                

 #include <asm/irq.h>
 #include <asm/io.h>


