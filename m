From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Sun, 16 Oct 2005 16:28:19 +0000
Subject: PATCH: cs4231 on sbus
Message-Id: <43527FA3.8090301@triaton-webhosting.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070805060602050607070506"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------070805060602050607070506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

here is another cs4231 patch which makes
it work on my ultra2. Tested by Christopher
Zimmermann and myself. It introduces some
sbus_dma routines similar to the ebus_dma
stuff to make the code look nearly the same
for both cases. I hope it does not break ebus.
Patch against 2.6.14-rc2-git4. Thanks to
Christopher for testing.

Regards
             Georg Chini



--------------070805060602050607070506
Content-Type: text/plain;
 name="cs4231.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs4231.diff"

--- linux-2.6.14-rc2/sound/sparc/cs4231.c	2005-09-24 22:55:56.000000000 +0200
+++ linux-2.6.14-rc2_patched/sound/sparc/cs4231.c	2005-10-16 17:31:41.000000000 +0200
@@ -61,6 +61,14 @@
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Sun,CS4231}}");
 
+#ifdef SBUS_SUPPORT
+struct sbus_dma_info {
+       spinlock_t      lock;
+       int             dir;
+       void __iomem    *regs;
+};
+#endif
+
 typedef struct snd_cs4231 {
 	spinlock_t		lock;
 	void __iomem		*port;
@@ -69,6 +77,11 @@
 	struct ebus_dma_info	eb2p;
 #endif
 
+#ifdef SBUS_SUPPORT
+	struct sbus_dma_info	sb2c;
+	struct sbus_dma_info	sb2p;
+#endif
+
 	u32			flags;
 #define CS4231_FLAG_EBUS	0x00000001
 #define CS4231_FLAG_PLAYBACK	0x00000002
@@ -251,6 +264,15 @@
 #define APCPNVA	0x38UL	/* APC Play DMA Next Address */
 #define APCPNC	0x3cUL	/* APC Play Next Count */
 
+/* Defines for SBUS DMA-routines */
+
+#define APCVA  0x0UL	/* APC DMA Address */
+#define APCC   0x4UL	/* APC Count */
+#define APCNVA 0x8UL	/* APC DMA Next Address */
+#define APCNC  0xcUL	/* APC Next Count */
+#define APC_PLAY 0x30UL	/* Play registers start at 0x30 */
+#define APC_RECORD 0x20UL /* Record registers start at 0x20 */
+
 /* APCCSR bits */
 
 #define APC_INT_PENDING 0x800000 /* Interrupt Pending */
@@ -472,6 +494,103 @@
 }
 
 /*
+ * SBUS DMA routines
+ */
+#ifdef SBUS_SUPPORT
+
+int sbus_dma_request(struct sbus_dma_info *base, dma_addr_t bus_addr, size_t len)
+{
+	unsigned long flags;
+	u32 test, csr;
+	int err;
+	
+	if (len >= (1 << 24))
+		return -EINVAL;
+	spin_lock_irqsave(&base->lock, flags);
+	csr = sbus_readl(base->regs + APCCSR);
+	err = -EINVAL;
+	test = APC_CDMA_READY;
+	if ( base->dir == APC_PLAY )
+		test = APC_PDMA_READY;
+	if (!(csr & test))
+		goto out;
+	err = -EBUSY;
+	csr = sbus_readl(base->regs + APCCSR);
+	test = APC_XINT_CNVA;
+	if ( base->dir == APC_PLAY )
+		test = APC_XINT_PNVA;
+	if (!(csr & test))
+		goto out;
+	err = 0;
+	sbus_writel(bus_addr, base->regs + base->dir + APCNVA);
+	sbus_writel(len, base->regs + base->dir + APCNC);
+out:
+	spin_unlock_irqrestore(&base->lock, flags);
+	return err;
+}
+
+void sbus_dma_prepare(struct sbus_dma_info *base)
+{
+	unsigned long flags;
+	u32 csr, test;
+
+	spin_lock_irqsave(&base->lock, flags);
+	csr = sbus_readl(base->regs + APCCSR);
+	test =  APC_GENL_INT | APC_PLAY_INT | APC_XINT_ENA |
+		APC_XINT_PLAY | APC_XINT_PEMP | APC_XINT_GENL |
+		 APC_XINT_PENA;
+	if ( base->dir == APC_RECORD )
+		test = APC_GENL_INT | APC_CAPT_INT | APC_XINT_ENA |
+			APC_XINT_CAPT | APC_XINT_CEMP | APC_XINT_GENL;
+	csr |= test;
+	sbus_writel(csr, base->regs + APCCSR);
+	spin_unlock_irqrestore(&base->lock, flags);
+}
+
+void sbus_dma_enable(struct sbus_dma_info *base, int on)
+{
+	unsigned long flags;
+	u32 csr, shift;
+
+	spin_lock_irqsave(&base->lock, flags);
+	if (!on) {
+		if (base->dir == APC_PLAY) { 
+			sbus_writel(0, base->regs + base->dir + APCNVA); 
+			sbus_writel(1, base->regs + base->dir + APCC); 
+		}
+		else
+		{
+			sbus_writel(0, base->regs + base->dir + APCNC); 
+			sbus_writel(0, base->regs + base->dir + APCVA); 
+		} 
+	} 
+	udelay(500); 
+	csr = sbus_readl(base->regs + APCCSR);
+	shift = 0;
+	if ( base->dir == APC_PLAY )
+		shift = 1;
+	if (on)
+		csr &= ~(APC_CPAUSE << shift);
+	else
+		csr |= (APC_CPAUSE << shift); 
+	sbus_writel(csr, base->regs + APCCSR);
+	if (on)
+		csr |= (APC_CDMA_READY << shift);
+	else
+		csr &= ~(APC_CDMA_READY << shift);
+	sbus_writel(csr, base->regs + APCCSR);
+	
+	spin_unlock_irqrestore(&base->lock, flags);
+}
+
+unsigned int sbus_dma_addr(struct sbus_dma_info *base)
+{
+        return sbus_readl(base->regs + base->dir + APCVA);
+}
+
+#endif
+
+/*
  *  CS4231 detection / MCE routines
  */
 
@@ -589,29 +708,21 @@
 #endif
 
 #ifdef SBUS_SUPPORT
-static void snd_cs4231_sbus_advance_dma(snd_pcm_substream_t *substream, unsigned int *periods_sent)
+static void snd_cs4231_sbus_advance_dma(struct sbus_dma_info *p, snd_pcm_substream_t *substream, unsigned int *periods_sent)
 {
-	cs4231_t *chip = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 
-	unsigned int period_size = snd_pcm_lib_period_bytes(substream);
-	unsigned int offset = period_size * (*periods_sent % runtime->periods);
-
-	if (runtime->period_size > 0xffff + 1)
-		BUG();
-
-	switch (substream->stream) {
-	case SNDRV_PCM_STREAM_PLAYBACK:
-		sbus_writel(runtime->dma_addr + offset, chip->port + APCPNVA);
-		sbus_writel(period_size, chip->port + APCPNC);
-		break;
-	case SNDRV_PCM_STREAM_CAPTURE:
-		sbus_writel(runtime->dma_addr + offset, chip->port + APCCNVA);
-		sbus_writel(period_size, chip->port + APCCNC);
-		break;
-	}
+	 while (1) {  
+		unsigned int period_size = snd_pcm_lib_period_bytes(substream);
+		unsigned int offset = period_size * (*periods_sent);
 
-	(*periods_sent) = (*periods_sent + 1) % runtime->periods;
+		if (period_size > 0xffff + 1)
+			BUG();
+	
+		if (sbus_dma_request(p, runtime->dma_addr + offset, period_size))
+			return;
+		(*periods_sent) = (*periods_sent + 1) % runtime->periods;
+	} 
 }
 #endif
 
@@ -646,59 +757,27 @@
 	} else {
 #endif
 #ifdef SBUS_SUPPORT
-	u32 csr = sbus_readl(chip->port + APCCSR);
-	/* I don't know why, but on sbus the period counter must
-	 * only start counting after the first period is sent.
-	 * Therefore this dummy thing.
-	 */
-	unsigned int dummy = 0;
-
-	switch (what) {
-	case CS4231_PLAYBACK_ENABLE:
+	if (what & CS4231_PLAYBACK_ENABLE) {
 		if (on) {
-			csr &= ~APC_XINT_PLAY;
-			sbus_writel(csr, chip->port + APCCSR);
-
-			csr &= ~APC_PPAUSE;
-			sbus_writel(csr, chip->port + APCCSR);
-
-			snd_cs4231_sbus_advance_dma(substream, &dummy);
-
-			csr |=  APC_GENL_INT | APC_PLAY_INT | APC_XINT_ENA |
-				APC_XINT_PLAY | APC_XINT_EMPT | APC_XINT_GENL |
-				APC_XINT_PENA | APC_PDMA_READY;
-			sbus_writel(csr, chip->port + APCCSR);
+			sbus_dma_prepare(&chip->sb2p);
+			sbus_dma_enable(&chip->sb2p, 1);
+			snd_cs4231_sbus_advance_dma(&chip->sb2p,
+				chip->playback_substream,
+				&chip->p_periods_sent);
 		} else {
-			csr |= APC_PPAUSE;
-			sbus_writel(csr, chip->port + APCCSR);
-
-			csr &= ~APC_PDMA_READY;
-			sbus_writel(csr, chip->port + APCCSR);
+			sbus_dma_enable(&chip->sb2p, 0);
 		}
-		break;
-	case CS4231_RECORD_ENABLE:
+	}
+	if (what & CS4231_RECORD_ENABLE) {
 		if (on) {
-			csr &= ~APC_XINT_CAPT;
-			sbus_writel(csr, chip->port + APCCSR);
-
-			csr &= ~APC_CPAUSE;
-			sbus_writel(csr, chip->port + APCCSR);
-
-			snd_cs4231_sbus_advance_dma(substream, &dummy);
-
-			csr |=  APC_GENL_INT | APC_CAPT_INT | APC_XINT_ENA |
-				APC_XINT_CAPT | APC_XINT_CEMP | APC_XINT_GENL |
-				APC_CDMA_READY;
-
-			sbus_writel(csr, chip->port + APCCSR);
+			sbus_dma_prepare(&chip->sb2c);
+			sbus_dma_enable(&chip->sb2c, 1);
+			snd_cs4231_sbus_advance_dma(&chip->sb2c,
+				chip->capture_substream,
+				&chip->c_periods_sent);
 		} else {
-			csr |= APC_CPAUSE;
-			sbus_writel(csr, chip->port + APCCSR);
-
-			csr &= ~APC_CDMA_READY;
-			sbus_writel(csr, chip->port + APCCSR);
+			sbus_dma_enable(&chip->sb2c, 0);
 		}
-		break;
 	}
 #endif
 #ifdef EBUS_SUPPORT
@@ -1136,10 +1215,7 @@
 	if (runtime->period_size > 0xffff + 1)
 		BUG();
 
-	snd_cs4231_out(chip, CS4231_PLY_LWR_CNT, (runtime->period_size - 1) & 0x00ff);
-	snd_cs4231_out(chip, CS4231_PLY_UPR_CNT, (runtime->period_size - 1) >> 8 & 0x00ff);
 	chip->p_periods_sent = 0;
-
 	spin_unlock_irqrestore(&chip->lock, flags);
 
 	return 0;
@@ -1171,16 +1247,14 @@
 static int snd_cs4231_capture_prepare(snd_pcm_substream_t *substream)
 {
 	cs4231_t *chip = snd_pcm_substream_chip(substream);
-	snd_pcm_runtime_t *runtime = substream->runtime;
 	unsigned long flags;
 
 	spin_lock_irqsave(&chip->lock, flags);
 	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_RECORD_ENABLE |
 					    CS4231_RECORD_PIO);
 
-	snd_cs4231_out(chip, CS4231_REC_LWR_CNT, (runtime->period_size - 1) & 0x00ff);
-	snd_cs4231_out(chip, CS4231_REC_LWR_CNT, (runtime->period_size - 1) >> 8 & 0x00ff);
 
+	chip->c_periods_sent = 0;
 	spin_unlock_irqrestore(&chip->lock, flags);
 
 	return 0;
@@ -1199,40 +1273,20 @@
 		chip->capture_substream->runtime->overrange++;
 }
 
-static irqreturn_t snd_cs4231_generic_interrupt(cs4231_t *chip)
+#ifdef SBUS_SUPPORT
+static irqreturn_t snd_cs4231_sbus_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	unsigned long flags;
 	unsigned char status;
+	u32 csr;
+	cs4231_t *chip = dev_id;
 
 	/*This is IRQ is not raised by the cs4231*/
 	if (!(__cs4231_readb(chip, CS4231P(chip, STATUS)) & CS4231_GLOBALIRQ))
 		return IRQ_NONE;
 
-	status = snd_cs4231_in(chip, CS4231_IRQ_STATUS);
-
-	if (status & CS4231_TIMER_IRQ) {
-		if (chip->timer)
-			snd_timer_interrupt(chip->timer, chip->timer->sticks);
-	}		
-
-	if (status & CS4231_RECORD_IRQ)
-		snd_cs4231_overrange(chip);
-
-	/* ACK the CS4231 interrupt. */
-	spin_lock_irqsave(&chip->lock, flags);
-	snd_cs4231_outm(chip, CS4231_IRQ_STATUS, ~CS4231_ALL_IRQS | ~status, 0);
-	spin_unlock_irqrestore(&chip->lock, flags);
-
-	return 0;
-}
-
-#ifdef SBUS_SUPPORT
-static irqreturn_t snd_cs4231_sbus_interrupt(int irq, void *dev_id, struct pt_regs *regs)
-{
-	cs4231_t *chip = dev_id;
-
 	/* ACK the APC interrupt. */
-	u32 csr = sbus_readl(chip->port + APCCSR);
+	csr = sbus_readl(chip->port + APCCSR);
 
 	sbus_writel(csr, chip->port + APCCSR);
 
@@ -1240,20 +1294,36 @@
 	    (csr & APC_PLAY_INT) &&
 	    (csr & APC_XINT_PNVA) &&
 	    !(csr & APC_XINT_EMPT)) {
-		snd_cs4231_sbus_advance_dma(chip->playback_substream,
-					    &chip->p_periods_sent);
 		snd_pcm_period_elapsed(chip->playback_substream);
+		snd_cs4231_sbus_advance_dma(&chip->sb2p, chip->playback_substream,
+					    &chip->p_periods_sent);
 	}
 
 	if ((chip->image[CS4231_IFACE_CTRL] & CS4231_RECORD_ENABLE) &&
 	    (csr & APC_CAPT_INT) &&
-	    (csr & APC_XINT_CNVA)) {
-		snd_cs4231_sbus_advance_dma(chip->capture_substream,
-					    &chip->c_periods_sent);
+	    (csr & APC_XINT_CNVA) &&
+	    !(csr & APC_XINT_EMPT)) {
 		snd_pcm_period_elapsed(chip->capture_substream);
+		snd_cs4231_sbus_advance_dma(&chip->sb2c,chip->capture_substream,
+					    &chip->c_periods_sent);
 	}
+	
+	status = snd_cs4231_in(chip, CS4231_IRQ_STATUS);
+
+	if (status & CS4231_TIMER_IRQ) {
+		if (chip->timer)
+			snd_timer_interrupt(chip->timer, chip->timer->sticks);
+	}		
+
+	if (status & CS4231_RECORD_IRQ)
+		snd_cs4231_overrange(chip);
 
-	return snd_cs4231_generic_interrupt(chip);
+	/* ACK the CS4231 interrupt. */
+	spin_lock_irqsave(&chip->lock, flags);
+	snd_cs4231_outm(chip, CS4231_IRQ_STATUS, ~CS4231_ALL_IRQS | ~status, 0);
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	return 0;
 }
 #endif
 
@@ -1284,24 +1354,29 @@
 static snd_pcm_uframes_t snd_cs4231_playback_pointer(snd_pcm_substream_t *substream)
 {
 	cs4231_t *chip = snd_pcm_substream_chip(substream);
-	size_t ptr, residue, period_bytes;
-
+	size_t ptr;
+#ifdef EBUS_SUPPORT
+	size_t residue, period_bytes;
+#endif
+	
 	if (!(chip->image[CS4231_IFACE_CTRL] & CS4231_PLAYBACK_ENABLE))
 		return 0;
+#ifdef EBUS_SUPPORT
 	period_bytes = snd_pcm_lib_period_bytes(substream);
 	ptr = period_bytes * chip->p_periods_sent;
-#ifdef EBUS_SUPPORT
 	if (chip->flags & CS4231_FLAG_EBUS) {
 		residue = ebus_dma_residue(&chip->eb2p);
+		ptr += period_bytes - residue;
 	} else {
 #endif
 #ifdef SBUS_SUPPORT
-		residue = sbus_readl(chip->port + APCPC);
+		ptr = sbus_dma_addr(&chip->sb2p);
+		if (ptr != 0)
+			ptr -= substream->runtime->dma_addr;
 #endif
 #ifdef EBUS_SUPPORT
 	}
 #endif
-	ptr += period_bytes - residue;
 
 	return bytes_to_frames(substream->runtime, ptr);
 }
@@ -1309,24 +1384,29 @@
 static snd_pcm_uframes_t snd_cs4231_capture_pointer(snd_pcm_substream_t * substream)
 {
 	cs4231_t *chip = snd_pcm_substream_chip(substream);
-	size_t ptr, residue, period_bytes;
+	size_t ptr;
+#ifdef EBUS_SUPPORT
+	size_t residue, period_bytes;
+#endif
 	
 	if (!(chip->image[CS4231_IFACE_CTRL] & CS4231_RECORD_ENABLE))
 		return 0;
+#ifdef EBUS_SUPPORT
 	period_bytes = snd_pcm_lib_period_bytes(substream);
 	ptr = period_bytes * chip->c_periods_sent;
-#ifdef EBUS_SUPPORT
 	if (chip->flags & CS4231_FLAG_EBUS) {
 		residue = ebus_dma_residue(&chip->eb2c);
+		ptr += period_bytes - residue;
 	} else {
 #endif
 #ifdef SBUS_SUPPORT
-		residue = sbus_readl(chip->port + APCCC);
+		ptr = sbus_dma_addr(&chip->sb2c);
+		if (ptr != 0)
+			ptr -= substream->runtime->dma_addr;
 #endif
 #ifdef EBUS_SUPPORT
 	}
 #endif
-	ptr += period_bytes - residue;
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
@@ -1983,6 +2063,8 @@
 		return -ENOMEM;
 
 	spin_lock_init(&chip->lock);
+	spin_lock_init(&chip->sb2c.lock);
+	spin_lock_init(&chip->sb2p.lock);
 	init_MUTEX(&chip->mce_mutex);
 	init_MUTEX(&chip->open_mutex);
 	chip->card = card;
@@ -1998,6 +2080,11 @@
 		return -EIO;
 	}
 
+	chip->sb2c.regs = chip->port;
+	chip->sb2p.regs = chip->port;
+	chip->sb2c.dir = APC_RECORD;
+	chip->sb2p.dir = APC_PLAY;
+
 	if (request_irq(sdev->irqs[0], snd_cs4231_sbus_interrupt,
 			SA_SHIRQ, "cs4231", chip)) {
 		snd_printdd("cs4231-%d: Unable to grab SBUS IRQ %s\n",

--------------070805060602050607070506--
