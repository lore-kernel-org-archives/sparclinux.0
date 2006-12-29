From: "Chini, Georg" <georg.chini@hp.com>
Date: Fri, 29 Dec 2006 22:16:02 +0000
Subject: Third Try: [PATCH] cs4231 alsa driver: Fix IRQ and initialisation
Message-Id: <459593A2.2000600@hp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020506020509090700000905"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------020506020509090700000905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I don't know what my mail program does to the patch. When I
send it there is always a + sign too much in one line. So I attach
it as a file now. I hope this works, and once again sorry for the
confusion.

Regards
              Georg Chini

--------------020506020509090700000905
Content-Type: text/plain;
 name="cs4231_061229.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs4231_061229.diff"

From: Georg Chini georg.chini@triaton-webhosting.com

SBUS: Change IRQ-handler return value from 0 to IRQ_HANDLED and
fix some initialisation problems.
Change period_bytes_min from 4096 to 256 to allow driver to work with
low latency (VOIP) applications. Hope this does not break EBUS.

Signed-off-by: Georg Chini <georg.chini@triaton-webhosting.com>

diff -uprN linux.orig/sound/sparc/cs4231.c linux/sound/sparc/cs4231.c
--- linux.orig/sound/sparc/cs4231.c	2006-12-29 22:08:10.000000000 +0100
+++ linux/sound/sparc/cs4231.c	2006-12-29 21:45:42.000000000 +0100
@@ -1268,7 +1268,7 @@ static struct snd_pcm_hardware snd_cs423
 	.channels_min		= 1,
 	.channels_max		= 2,
 	.buffer_bytes_max	= (32*1024),
-	.period_bytes_min	= 4096,
+	.period_bytes_min	= 256,
 	.period_bytes_max	= (32*1024),
 	.periods_min		= 1,
 	.periods_max		= 1024,
@@ -1288,7 +1288,7 @@ static struct snd_pcm_hardware snd_cs423
 	.channels_min		= 1,
 	.channels_max		= 2,
 	.buffer_bytes_max	= (32*1024),
-	.period_bytes_min	= 4096,
+	.period_bytes_min	= 256,
 	.period_bytes_max	= (32*1024),
 	.periods_min		= 1,
 	.periods_max		= 1024,
@@ -1796,7 +1796,7 @@ static irqreturn_t snd_cs4231_sbus_inter
 	snd_cs4231_outm(chip, CS4231_IRQ_STATUS, ~CS4231_ALL_IRQS | ~status, 0);
 	spin_unlock_irqrestore(&chip->lock, flags);
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
 /*
@@ -1821,7 +1821,6 @@ static int sbus_dma_request(struct cs423
 	if (!(csr & test))
 		goto out;
 	err = -EBUSY;
-	csr = sbus_readl(base->regs + APCCSR);
 	test = APC_XINT_CNVA;
 	if ( base->dir == APC_PLAY )
 		test = APC_XINT_PNVA;
@@ -1862,17 +1861,16 @@ static void sbus_dma_enable(struct cs423
 
 	spin_lock_irqsave(&base->lock, flags);
 	if (!on) {
-		if (base->dir == APC_PLAY) { 
-			sbus_writel(0, base->regs + base->dir + APCNVA); 
-			sbus_writel(1, base->regs + base->dir + APCC); 
-		}
-		else
-		{
-			sbus_writel(0, base->regs + base->dir + APCNC); 
-			sbus_writel(0, base->regs + base->dir + APCVA); 
-		} 
+		sbus_writel(0, base->regs + base->dir + APCNC); 
+		sbus_writel(0, base->regs + base->dir + APCNVA); 
+		sbus_writel(0, base->regs + base->dir + APCC); 
+		sbus_writel(0, base->regs + base->dir + APCVA); 
+		
+		/* ACK any APC interrupts. */
+		csr = sbus_readl(base->regs + APCCSR);
+		sbus_writel(csr, base->regs + APCCSR);
 	} 
-	udelay(600); 
+	udelay(1000); 
 	csr = sbus_readl(base->regs + APCCSR);
 	shift = 0;
 	if ( base->dir == APC_PLAY )

--------------020506020509090700000905--
