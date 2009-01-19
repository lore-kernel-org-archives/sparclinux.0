From: David Miller <davem@davemloft.net>
Date: Mon, 19 Jan 2009 06:41:48 +0000
Subject: Re: fhc led registration warnings
Message-Id: <20090118.224148.24684099.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0901161258360.2120@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0901161258360.2120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 16 Jan 2009 13:02:33 +0200 (EET)

> While booting todays 2.6.29-rc1+git on E3500, these warning about FHC 
> LEDs sysfs registration appeared in the logs. I sent the previous mail 
> away and decided to send this one separately, but now I see that the 
> location of platform-specific device registrations js the same where CPU 
> detection problem were, so maybe they are related afterall.
> 
> [  136.437166] WARNING: at fs/sysfs/dir.c:462 sysfs_add_one+0x44/0x60()
> [  136.437226] sysfs: duplicate filename 'sunfire-fhc-leds.0' can not be created

Does this patch fix the problem?

sparc64: Initialize FHC/CLOCK LED platform_device 'id' field correctly.

There is only one clock board, so use -1 as the 'id' so we get just
the base name as the LED device name string.

There are multiple FHC boards potentially in a system so use the board
number as the 'id' value for that case.

Based upon a bug report from Meelis Roos.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc/kernel/central.c b/arch/sparc/kernel/central.c
index 05f1c91..f3b5466 100644
--- a/arch/sparc/kernel/central.c
+++ b/arch/sparc/kernel/central.c
@@ -103,6 +103,7 @@ static int __devinit clock_board_probe(struct of_device *op,
 	p->leds_resource.name = "leds";
 
 	p->leds_pdev.name = "sunfire-clockboard-leds";
+	p->leds_pdev.id = -1;
 	p->leds_pdev.resource = &p->leds_resource;
 	p->leds_pdev.num_resources = 1;
 	p->leds_pdev.dev.parent = &op->dev;
@@ -197,6 +198,7 @@ static int __devinit fhc_probe(struct of_device *op,
 		p->leds_resource.name = "leds";
 
 		p->leds_pdev.name = "sunfire-fhc-leds";
+		p->leds_pdev.id = p->board_num;
 		p->leds_pdev.resource = &p->leds_resource;
 		p->leds_pdev.num_resources = 1;
 		p->leds_pdev.dev.parent = &op->dev;
