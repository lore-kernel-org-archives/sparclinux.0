From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 27 Jul 2017 16:26:00 +0000
Subject: [PATCH] sunhme: fix up GREG_STAT and GREG_IMASK register offsets
Message-Id: <1501172760-26293-1-git-send-email-mark.cave-ayland@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Update the values to match those from the STP2002QFP documentation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 drivers/net/ethernet/sun/sunhme.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sun/sunhme.h b/drivers/net/ethernet/sun/sunhme.h
index 4a8d5b1..0d3bb1e 100644
--- a/drivers/net/ethernet/sun/sunhme.h
+++ b/drivers/net/ethernet/sun/sunhme.h
@@ -13,9 +13,9 @@
 /* Happy Meal global registers. */
 #define GREG_SWRESET	0x000UL	/* Software Reset  */
 #define GREG_CFG	0x004UL	/* Config Register */
-#define GREG_STAT	0x108UL	/* Status          */
-#define GREG_IMASK	0x10cUL	/* Interrupt Mask  */
-#define GREG_REG_SIZE	0x110UL
+#define GREG_STAT	0x100UL	/* Status          */
+#define GREG_IMASK	0x104UL	/* Interrupt Mask  */
+#define GREG_REG_SIZE	0x108UL
 
 /* Global reset register. */
 #define GREG_RESET_ETX         0x01
-- 
1.7.10.4

