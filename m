From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Thu, 15 Dec 2016 19:47:03 +0000
Subject: [PATCH] sbus: char: Move D7S_MINOR to include/linux/miscdevice.h
Message-Id: <20161215194703.11195-1-clabbe.montjoie@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, sparclinux@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>

This patch move the define for D7S_MINOR to include/linux/miscdevice.h.
It's better that all minor number are in the same place.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/sbus/char/display7seg.c | 1 -
 include/linux/miscdevice.h      | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index 33fbe82..48a5df0 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -22,7 +22,6 @@
 
 #include <asm/display7seg.h>
 
-#define D7S_MINOR	193
 #define DRIVER_NAME	"d7s"
 #define PFX		DRIVER_NAME ": "
 
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index 5385d95..b1ba37aef 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -33,6 +33,7 @@
 #define I2O_MINOR		166
 #define HWRNG_MINOR		183
 #define MICROCODE_MINOR		184
+#define D7S_MINOR		193
 #define VFIO_MINOR		196
 #define TUN_MINOR		200
 #define CUSE_MINOR		203
-- 
2.10.2

