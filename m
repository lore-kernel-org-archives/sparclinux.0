From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Wed, 27 Jun 2007 21:08:40 +0000
Subject: [Patch]: Minor fixes for CS4231 on SBus
Message-Id: <4682D1D8.3070309@triaton-webhosting.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050907050903020901030500"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------050907050903020901030500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

remove unnecessary sbus_dma_reset function and
change sbus_dma_enable to avoid occasional system
crashes when stopping recording. Patch is against
2.6.22-rc5. Tested on my ultra2.

Regards
              Georg


--------------050907050903020901030500
Content-Type: text/plain;
 name="cs4231-2.6.22-rc5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs4231-2.6.22-rc5.diff"

CS4231 SBus: Remove unnecessary sbus_dma_reset function and change
             sbus_dma_enable to avoid occasional system crashes when
	     stopping recording.

signed off: Georg Chini <georg.chini@triaton-webhosting.com>

--- linux-2.6.22-rc5/sound/sparc/cs4231.c	2007-06-17 04:09:12.000000000 +0200
+++ linux-2.6.22-rc5.changed/sound/sparc/cs4231.c	2007-06-18 22:00:04.000000000 +0200
@@ -74,7 +74,6 @@
         void		(*enable)(struct cs4231_dma_control *dma_cont, int on);
         int		(*request)(struct cs4231_dma_control *dma_cont, dma_addr_t bus_addr, size_t len);
         unsigned int	(*address)(struct cs4231_dma_control *dma_cont);
-        void		(*reset)(struct snd_cs4231 *chip); 
         void		(*preallocate)(struct snd_cs4231 *chip, struct snd_pcm *pcm); 
 #ifdef EBUS_SUPPORT
 	struct		ebus_dma_info	ebus_info;
@@ -1214,10 +1213,6 @@
 
 	spin_lock_irqsave(&chip->lock, flags);
 
-
-	/* Reset DMA engine (sbus only).  */
-	chip->p_dma.reset(chip);
-
 	__cs4231_readb(chip, CS4231P(chip, STATUS));	/* clear any pendings IRQ */
 	__cs4231_writeb(chip, 0, CS4231P(chip, STATUS));
 	mb();
@@ -1861,14 +1856,13 @@
 	if (!on) {
 		sbus_writel(0, base->regs + base->dir + APCNC);
 		sbus_writel(0, base->regs + base->dir + APCNVA);
-		sbus_writel(0, base->regs + base->dir + APCC);
-		sbus_writel(0, base->regs + base->dir + APCVA);
+		if ( base->dir == APC_PLAY ) {
+			sbus_writel(0, base->regs + base->dir + APCC);
+			sbus_writel(0, base->regs + base->dir + APCVA);
+		}
 
-		/* ACK any APC interrupts. */
-		csr = sbus_readl(base->regs + APCCSR);
-		sbus_writel(csr, base->regs + APCCSR);
+		udelay(1200);
 	} 
-	udelay(1000);
 	csr = sbus_readl(base->regs + APCCSR);
 	shift = 0;
 	if ( base->dir == APC_PLAY )
@@ -1894,23 +1888,6 @@
         return sbus_readl(base->regs + base->dir + APCVA);
 }
 
-static void sbus_dma_reset(struct snd_cs4231 *chip)
-{
-        sbus_writel(APC_CHIP_RESET, chip->port + APCCSR);
-        sbus_writel(0x00, chip->port + APCCSR);
-        sbus_writel(sbus_readl(chip->port + APCCSR) | APC_CDC_RESET,
-		    chip->port + APCCSR);
-  
-        udelay(20);
-  
-        sbus_writel(sbus_readl(chip->port + APCCSR) & ~APC_CDC_RESET,
-		    chip->port + APCCSR);
-        sbus_writel(sbus_readl(chip->port + APCCSR) | (APC_XINT_ENA |
-		       APC_XINT_PENA |
-		       APC_XINT_CENA),
-	               chip->port + APCCSR);
-}
-
 static void sbus_dma_preallocate(struct snd_cs4231 *chip, struct snd_pcm *pcm)
 {
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_SBUS,
@@ -1986,14 +1963,12 @@
 	chip->p_dma.enable = sbus_dma_enable;
 	chip->p_dma.request = sbus_dma_request;
 	chip->p_dma.address = sbus_dma_addr;
-	chip->p_dma.reset = sbus_dma_reset;
 	chip->p_dma.preallocate = sbus_dma_preallocate;
 
 	chip->c_dma.prepare = sbus_dma_prepare;
 	chip->c_dma.enable = sbus_dma_enable;
 	chip->c_dma.request = sbus_dma_request;
 	chip->c_dma.address = sbus_dma_addr;
-	chip->c_dma.reset = sbus_dma_reset;
 	chip->c_dma.preallocate = sbus_dma_preallocate;
 
 	if (request_irq(sdev->irqs[0], snd_cs4231_sbus_interrupt,
@@ -2087,11 +2062,6 @@
 	return ebus_dma_addr(&dma_cont->ebus_info);
 }
 
-static void _ebus_dma_reset(struct snd_cs4231 *chip)
-{
-	return;
-}
-
 static void _ebus_dma_preallocate(struct snd_cs4231 *chip, struct snd_pcm *pcm)
 {
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
@@ -2171,14 +2141,12 @@
 	chip->p_dma.enable = _ebus_dma_enable;
 	chip->p_dma.request = _ebus_dma_request;
 	chip->p_dma.address = _ebus_dma_addr;
-	chip->p_dma.reset = _ebus_dma_reset;
 	chip->p_dma.preallocate = _ebus_dma_preallocate;
 
 	chip->c_dma.prepare = _ebus_dma_prepare;
 	chip->c_dma.enable = _ebus_dma_enable;
 	chip->c_dma.request = _ebus_dma_request;
 	chip->c_dma.address = _ebus_dma_addr;
-	chip->c_dma.reset = _ebus_dma_reset;
 	chip->c_dma.preallocate = _ebus_dma_preallocate;
 
 	chip->port = ioremap(edev->resource[0].start, 0x10);

--------------050907050903020901030500--
