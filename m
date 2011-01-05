From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 05 Jan 2011 21:03:45 +0000
Subject: [PATCH 2/4] sunhme: cleanup conditional on CONFIG_SBUS
Message-Id: <1294261427-26104-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc has always SBUS defined.
So there is no need to have #ifdef CONFIG_SBUS within
code that is SPARC only.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/net/sunhme.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/drivers/net/sunhme.c b/drivers/net/sunhme.c
index 5e28c41..e716795 100644
--- a/drivers/net/sunhme.c
+++ b/drivers/net/sunhme.c
@@ -1578,18 +1578,13 @@ static int happy_meal_init(struct happy_meal *hp)
 	hme_write32(hp, gregs + GREG_CFG, GREG_CFG_BURST64);
 #else
 	if ((hp->happy_bursts & DMA_BURST64) &&
-	    ((hp->happy_flags & HFLAG_PCI) != 0
-#ifdef CONFIG_SBUS
-	     || sbus_can_burst64()
-#endif
-	     || 0)) {
+	    ((hp->happy_flags & HFLAG_PCI) != 0 || sbus_can_burst64() || 0)) {
 		u32 gcfg = GREG_CFG_BURST64;
 
 		/* I have no idea if I should set the extended
 		 * transfer mode bit for Cheerio, so for now I
 		 * do not.  -DaveM
 		 */
-#ifdef CONFIG_SBUS
 		if ((hp->happy_flags & HFLAG_PCI) = 0) {
 			struct platform_device *op = hp->happy_dev;
 			if (sbus_can_dma_64bit()) {
@@ -1598,8 +1593,6 @@ static int happy_meal_init(struct happy_meal *hp)
 				gcfg |= GREG_CFG_64BIT;
 			}
 		}
-#endif
-
 		HMD(("64>"));
 		hme_write32(hp, gregs + GREG_CFG, gcfg);
 	} else if (hp->happy_bursts & DMA_BURST32) {
-- 
1.6.0.6

