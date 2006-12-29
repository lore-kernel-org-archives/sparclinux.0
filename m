From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Fri, 29 Dec 2006 21:47:28 +0000
Subject: [PATCH] cs4231 alsa driver: Fix IRQ and initialisation problems,
Message-Id: <45958CF0.3090106@triaton-webhosting.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Georg Chini georg.chini@triaton-webhosting.com

SBUS: Change IRQ-handler return value from 0 to IRQ_HANDLED and
fix some initialisation problems.
Change period_bytes_min from 4096 to 256 to allow driver to work with
low latency (VOIP) applications. Hope this does not break EBUS.

Signed-off-by: Georg Chini <georg.chini@triaton-webhosting.com>
---

diff -uprN linux.orig/sound/sparc/cs4231.c linux/sound/sparc/cs4231.c
--- linux.orig/sound/sparc/cs4231.c     2006-12-29 22:08:10.000000000 +0100
+++ linux/sound/sparc/cs4231.c  2006-12-29 21:45:42.000000000 +0100
@@ -1268,7 +1268,7 @@ static struct snd_pcm_hardware snd_cs423
        .channels_min           = 1,
        .channels_max           = 2,
        .buffer_bytes_max       = (32*1024),
-       .period_bytes_min       = 4096,
+       .period_bytes_min       = 256,
        .period_bytes_max       = (32*1024),
        .periods_min            = 1,
        .periods_max            = 1024,
@@ -1288,7 +1288,7 @@ static struct snd_pcm_hardware snd_cs423
        .channels_min           = 1,
        .channels_max           = 2,
        .buffer_bytes_max       = (32*1024),
-       .period_bytes_min       = 4096,
+       .period_bytes_min       = 256,
        .period_bytes_max       = (32*1024),
        .periods_min            = 1,
        .periods_max            = 1024,
@@ -1796,7 +1796,7 @@ static irqreturn_t snd_cs4231_sbus_inter
        snd_cs4231_outm(chip, CS4231_IRQ_STATUS, ~CS4231_ALL_IRQS | 
~status, 0);
        spin_unlock_irqrestore(&chip->lock, flags);

-       return 0;
+       return IRQ_HANDLED;
 }

 /*
@@ -1821,7 +1821,6 @@ static int sbus_dma_request(struct cs423
        if (!(csr & test))
                goto out;
        err = -EBUSY;
-       csr = sbus_readl(base->regs + APCCSR);
        test = APC_XINT_CNVA;
        if ( base->dir = APC_PLAY )
                test = APC_XINT_PNVA;
@@ -1862,17 +1861,16 @@ static void sbus_dma_enable(struct cs423

        spin_lock_irqsave(&base->lock, flags);
        if (!on) {
-               if (base->dir = APC_PLAY) {
-                       sbus_writel(0, base->regs + base->dir + APCNVA);
-                       sbus_writel(1, base->regs + base->dir + APCC);
-               }
-               else
-               {
-                       sbus_writel(0, base->regs + base->dir + APCNC);
-                       sbus_writel(0, base->regs + base->dir + APCVA);
-               }
+               sbus_writel(0, base->regs + base->dir + APCNC);
+               sbus_writel(0, base->regs + base->dir + APCNVA);
+               sbus_writel(0, base->regs + base->dir + APCC);
+               sbus_writel(0, base->regs + base->dir + APCVA);
+              
+               /* ACK any APC interrupts. */
+               csr = sbus_readl(base->regs + APCCSR);
+               sbus_writel(csr, base->regs + APCCSR);
        }
-       udelay(600);
+       udelay(1000);
        csr = sbus_readl(base->regs + APCCSR);
        shift = 0;
        if ( base->dir = APC_PLAY )

