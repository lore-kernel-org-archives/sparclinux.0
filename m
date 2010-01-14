From: Roel Kluin <roel.kluin@gmail.com>
Date: Thu, 14 Jan 2010 16:55:55 +0000
Subject: [PATCH] sparc: leds_resource.end assigned to itself in clock_board_probe()
Message-Id: <4B4F4C9B.9040202@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

These statements appear redundant.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Is there any reason to assign this to itself?

diff --git a/arch/sparc/kernel/central.c b/arch/sparc/kernel/central.c
index f3b5466..773caf4 100644
--- a/arch/sparc/kernel/central.c
+++ b/arch/sparc/kernel/central.c
@@ -99,7 +99,6 @@ static int __devinit clock_board_probe(struct of_device *op,
 
 	p->leds_resource.start = (unsigned long)
 		(p->clock_regs + CLOCK_CTRL);
-	p->leds_resource.end = p->leds_resource.end;
 	p->leds_resource.name = "leds";
 
 	p->leds_pdev.name = "sunfire-clockboard-leds";
@@ -194,7 +193,6 @@ static int __devinit fhc_probe(struct of_device *op,
 	if (!p->central) {
 		p->leds_resource.start = (unsigned long)
 			(p->pregs + FHC_PREGS_CTRL);
-		p->leds_resource.end = p->leds_resource.end;
 		p->leds_resource.name = "leds";
 
 		p->leds_pdev.name = "sunfire-fhc-leds";
