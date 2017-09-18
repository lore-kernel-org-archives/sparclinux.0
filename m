From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Mon, 18 Sep 2017 18:10:36 +0000
Subject: [PATCH] sbus: char: Move D7S_MINOR to include/linux/miscdevice.h
Message-Id: <20170918181036.30982-1-clabbe.montjoie@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161215194703.11195-1-clabbe.montjoie@gmail.com>
In-Reply-To: <20161215194703.11195-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>

This patch move the define for D7S_MINOR to include/linux/miscdevice.h.
It's better that all minor number are in the same place.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/sbus/char/display7seg.c | 1 -
 include/linux/miscdevice.h      | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index f32765d3cbd8..5c8ed7350a04 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -22,7 +22,6 @@
 
 #include <asm/display7seg.h>
 
-#define D7S_MINOR	193
 #define DRIVER_NAME	"d7s"
 #define PFX		DRIVER_NAME ": "
 
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index 58751eae5f77..05c3892b3e92 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -35,6 +35,7 @@
 #define HWRNG_MINOR		183
 #define MICROCODE_MINOR		184
 #define IRNET_MINOR		187
+#define D7S_MINOR		193
 #define VFIO_MINOR		196
 #define TUN_MINOR		200
 #define CUSE_MINOR		203
-- 
2.13.5

