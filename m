From: Christopher Zimmermann <madroach@zakweb.de>
Date: Sun, 11 Sep 2005 20:54:57 +0000
Subject: CS4231 for sbus
Message-Id: <20050911205457.GA1978@sparc>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, 

I completed the CS4231 for SBus. Playback does work on my Ultra2.
capture doesn't (yet). I hope my patch doesn't break support on EBus.
Unfortunatelly I have no access to any EBus based system. 
I had a problem with the p_periods_sent counter. I worked around this by
passing only a dummy pointer to snd_cs4231_sbus_advance_dma in
cs4231_dma_trigger. Another option would be to change
ptr = period_bytes * (chip->p_periods_sent % substream->runtime->periods);
to
ptr = period_bytes * ((chip->p_periods_sent - 1) % substream->runtime->periods);
in snd_cs4231_playback_pointer, but I was afraid this could break the
EBus support. Any suggestions??
the driver works also without the '% substream->runtime->periods'. Why??

Christopher

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch

--- linux-2.6.12.5/sound/sparc/cs4231.c	2005-08-15 02:20:18.000000000 +0200
+++ linux-2.6.12.5_patched/sound/sparc/cs4231.c	2005-09-11 22:34:47.000000000 +0200
@@ -173,7 +173,7 @@
 
 #define CS4231_GLOBALIRQ	0x01	/* IRQ is active */
 
-/* definitions for codec irq status */
+/* definitions for codec irq status - CS4231_IRQ_STATUS	*/
 
 #define CS4231_PLAYBACK_IRQ	0x10
 #define CS4231_RECORD_IRQ	0x20
@@ -402,7 +402,7 @@
 	     	udelay(100);
 #ifdef CONFIG_SND_DEBUG
 	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
-		snd_printk("outm: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
+		snd_printdd("outm: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
 #endif
 	if (chip->calibrate_mute) {
 		chip->image[reg] &= mask;
@@ -425,6 +425,10 @@
 	     timeout > 0 && (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT);
 	     timeout--)
 	     	udelay(100);
+#ifdef CONFIG_SND_DEBUG
+	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
+		snd_printdd("out: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
+#endif
 	__cs4231_writeb(chip, chip->mce_bit | reg, CS4231P(chip, REGSEL));
 	__cs4231_writeb(chip, value, CS4231P(chip, REG));
 	mb();
@@ -440,14 +444,14 @@
 	     	udelay(100);
 #ifdef CONFIG_SND_DEBUG
 	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
-		snd_printk("out: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
+		snd_printdd("out: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
 #endif
 	__cs4231_writeb(chip, chip->mce_bit | reg, CS4231P(chip, REGSEL));
 	__cs4231_writeb(chip, value, CS4231P(chip, REG));
 	chip->image[reg] = value;
 	mb();
 #if 0
-	printk("codec out - reg 0x%x = 0x%x\n", chip->mce_bit | reg, value);
+	snd_printdd("codec out - reg 0x%x = 0x%x | timeout = %d\n", chip->mce_bit | reg, value, timeout);
 #endif
 }
 
@@ -462,13 +466,13 @@
 	     	udelay(100);
 #ifdef CONFIG_SND_DEBUG
 	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
-		snd_printk("in: auto calibration time out - reg = 0x%x\n", reg);
+		snd_printdd("in: auto calibration time out - reg = 0x%x\n", reg);
 #endif
 	__cs4231_writeb(chip, chip->mce_bit | reg, CS4231P(chip, REGSEL));
 	mb();
 	ret = __cs4231_readb(chip, CS4231P(chip, REG));
 #if 0
-	printk("codec in - reg 0x%x = 0x%x\n", chip->mce_bit | reg, ret);
+	snd_printdd("codec in - reg 0x%x = 0x%x\n", chip->mce_bit | reg, ret);
 #endif
 	return ret;
 }
@@ -477,42 +481,42 @@
 
 static void snd_cs4231_debug(cs4231_t *chip)
 {
-	printk("CS4231 REGS:      INDEX = 0x%02x  ",
+	snd_printdd("CS4231 REGS:      INDEX = 0x%02x\n",
 	       __cs4231_readb(chip, CS4231P(chip, REGSEL)));
-	printk("                 STATUS = 0x%02x\n",
+	snd_printdd("                 STATUS = 0x%02x\n",
 	       __cs4231_readb(chip, CS4231P(chip, STATUS)));
-	printk("  0x00: left input      = 0x%02x  ", snd_cs4231_in(chip, 0x00));
-	printk("  0x10: alt 1 (CFIG 2)  = 0x%02x\n", snd_cs4231_in(chip, 0x10));
-	printk("  0x01: right input     = 0x%02x  ", snd_cs4231_in(chip, 0x01));
-	printk("  0x11: alt 2 (CFIG 3)  = 0x%02x\n", snd_cs4231_in(chip, 0x11));
-	printk("  0x02: GF1 left input  = 0x%02x  ", snd_cs4231_in(chip, 0x02));
-	printk("  0x12: left line in    = 0x%02x\n", snd_cs4231_in(chip, 0x12));
-	printk("  0x03: GF1 right input = 0x%02x  ", snd_cs4231_in(chip, 0x03));
-	printk("  0x13: right line in   = 0x%02x\n", snd_cs4231_in(chip, 0x13));
-	printk("  0x04: CD left input   = 0x%02x  ", snd_cs4231_in(chip, 0x04));
-	printk("  0x14: timer low       = 0x%02x\n", snd_cs4231_in(chip, 0x14));
-	printk("  0x05: CD right input  = 0x%02x  ", snd_cs4231_in(chip, 0x05));
-	printk("  0x15: timer high      = 0x%02x\n", snd_cs4231_in(chip, 0x15));
-	printk("  0x06: left output     = 0x%02x  ", snd_cs4231_in(chip, 0x06));
-	printk("  0x16: left MIC (PnP)  = 0x%02x\n", snd_cs4231_in(chip, 0x16));
-	printk("  0x07: right output    = 0x%02x  ", snd_cs4231_in(chip, 0x07));
-	printk("  0x17: right MIC (PnP) = 0x%02x\n", snd_cs4231_in(chip, 0x17));
-	printk("  0x08: playback format = 0x%02x  ", snd_cs4231_in(chip, 0x08));
-	printk("  0x18: IRQ status      = 0x%02x\n", snd_cs4231_in(chip, 0x18));
-	printk("  0x09: iface (CFIG 1)  = 0x%02x  ", snd_cs4231_in(chip, 0x09));
-	printk("  0x19: left line out   = 0x%02x\n", snd_cs4231_in(chip, 0x19));
-	printk("  0x0a: pin control     = 0x%02x  ", snd_cs4231_in(chip, 0x0a));
-	printk("  0x1a: mono control    = 0x%02x\n", snd_cs4231_in(chip, 0x1a));
-	printk("  0x0b: init & status   = 0x%02x  ", snd_cs4231_in(chip, 0x0b));
-	printk("  0x1b: right line out  = 0x%02x\n", snd_cs4231_in(chip, 0x1b));
-	printk("  0x0c: revision & mode = 0x%02x  ", snd_cs4231_in(chip, 0x0c));
-	printk("  0x1c: record format   = 0x%02x\n", snd_cs4231_in(chip, 0x1c));
-	printk("  0x0d: loopback        = 0x%02x  ", snd_cs4231_in(chip, 0x0d));
-	printk("  0x1d: var freq (PnP)  = 0x%02x\n", snd_cs4231_in(chip, 0x1d));
-	printk("  0x0e: ply upr count   = 0x%02x  ", snd_cs4231_in(chip, 0x0e));
-	printk("  0x1e: rec upr count   = 0x%02x\n", snd_cs4231_in(chip, 0x1e));
-	printk("  0x0f: ply lwr count   = 0x%02x  ", snd_cs4231_in(chip, 0x0f));
-	printk("  0x1f: rec lwr count   = 0x%02x\n", snd_cs4231_in(chip, 0x1f));
+	snd_printdd("  0x00: left input      = 0x%02x\n", snd_cs4231_in(chip, 0x00));
+	snd_printdd("  0x10: alt 1 (CFIG 2)  = 0x%02x\n", snd_cs4231_in(chip, 0x10));
+	snd_printdd("  0x01: right input     = 0x%02x\n", snd_cs4231_in(chip, 0x01));
+	snd_printdd("  0x11: alt 2 (CFIG 3)  = 0x%02x\n", snd_cs4231_in(chip, 0x11));
+	snd_printdd("  0x02: GF1 left input  = 0x%02x\n", snd_cs4231_in(chip, 0x02));
+	snd_printdd("  0x12: left line in    = 0x%02x\n", snd_cs4231_in(chip, 0x12));
+	snd_printdd("  0x03: GF1 right input = 0x%02x\n", snd_cs4231_in(chip, 0x03));
+	snd_printdd("  0x13: right line in   = 0x%02x\n", snd_cs4231_in(chip, 0x13));
+	snd_printdd("  0x04: CD left input   = 0x%02x\n", snd_cs4231_in(chip, 0x04));
+	snd_printdd("  0x14: timer low       = 0x%02x\n", snd_cs4231_in(chip, 0x14));
+	snd_printdd("  0x05: CD right input  = 0x%02x\n", snd_cs4231_in(chip, 0x05));
+	snd_printdd("  0x15: timer high      = 0x%02x\n", snd_cs4231_in(chip, 0x15));
+	snd_printdd("  0x06: left output     = 0x%02x\n", snd_cs4231_in(chip, 0x06));
+	snd_printdd("  0x16: left MIC (PnP)  = 0x%02x\n", snd_cs4231_in(chip, 0x16));
+	snd_printdd("  0x07: right output    = 0x%02x\n", snd_cs4231_in(chip, 0x07));
+	snd_printdd("  0x17: right MIC (PnP) = 0x%02x\n", snd_cs4231_in(chip, 0x17));
+	snd_printdd("  0x08: playback format = 0x%02x\n", snd_cs4231_in(chip, 0x08));
+	snd_printdd("  0x18: IRQ status      = 0x%02x\n", snd_cs4231_in(chip, 0x18));
+	snd_printdd("  0x09: iface (CFIG 1)  = 0x%02x\n", snd_cs4231_in(chip, 0x09));
+	snd_printdd("  0x19: left line out   = 0x%02x\n", snd_cs4231_in(chip, 0x19));
+	snd_printdd("  0x0a: pin control     = 0x%02x\n", snd_cs4231_in(chip, 0x0a));
+	snd_printdd("  0x1a: mono control    = 0x%02x\n", snd_cs4231_in(chip, 0x1a));
+	snd_printdd("  0x0b: init & status   = 0x%02x\n", snd_cs4231_in(chip, 0x0b));
+	snd_printdd("  0x1b: right line out  = 0x%02x\n", snd_cs4231_in(chip, 0x1b));
+	snd_printdd("  0x0c: revision & mode = 0x%02x\n", snd_cs4231_in(chip, 0x0c));
+	snd_printdd("  0x1c: record format   = 0x%02x\n", snd_cs4231_in(chip, 0x1c));
+	snd_printdd("  0x0d: loopback        = 0x%02x\n", snd_cs4231_in(chip, 0x0d));
+	snd_printdd("  0x1d: var freq (PnP)  = 0x%02x\n", snd_cs4231_in(chip, 0x1d));
+	snd_printdd("  0x0e: ply upr count   = 0x%02x\n", snd_cs4231_in(chip, 0x0e));
+	snd_printdd("  0x1e: rec upr count   = 0x%02x\n", snd_cs4231_in(chip, 0x1e));
+	snd_printdd("  0x0f: ply lwr count   = 0x%02x\n", snd_cs4231_in(chip, 0x0f));
+	snd_printdd("  0x1f: rec lwr count   = 0x%02x\n", snd_cs4231_in(chip, 0x1f));
 }
 
 #endif
@@ -528,11 +532,17 @@
 	/* huh.. looks like this sequence is proper for CS4231A chip (GUS MAX) */
 	for (timeout = 5; timeout > 0; timeout--)
 		__cs4231_readb(chip, CS4231P(chip, REGSEL));
+#if 0
+	snd_printdd("(0) timeout = %i\n", timeout);
+#endif
 	/* end of cleanup sequence */
-	for (timeout = 250;
+	for (timeout = 500;
 	     timeout > 0 && (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT);
 	     timeout--)
-	     	udelay(100);
+	     	udelay(1000);
+#if 0
+	snd_printdd("(1) timeout = %i\n", timeout);
+#endif
 }
 
 static void snd_cs4231_mce_up(cs4231_t *chip)
@@ -545,12 +555,12 @@
 		udelay(100);
 #ifdef CONFIG_SND_DEBUG
 	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
-		snd_printk("mce_up - auto calibration time out (0)\n");
+		snd_printdd("mce_up - auto calibration time out (0)\n");
 #endif
 	chip->mce_bit |= CS4231_MCE;
 	timeout = __cs4231_readb(chip, CS4231P(chip, REGSEL));
 	if (timeout == 0x80)
-		snd_printk("mce_up [%p]: serious init problem - codec still busy\n", chip->port);
+		snd_printdd("mce_up [%p]: serious init problem - codec still busy\n", chip->port);
 	if (!(timeout & CS4231_MCE))
 		__cs4231_writeb(chip, chip->mce_bit | (timeout & 0x1f), CS4231P(chip, REGSEL));
 	spin_unlock_irqrestore(&chip->lock, flags);
@@ -563,18 +573,15 @@
 
 	spin_lock_irqsave(&chip->lock, flags);
 	snd_cs4231_busy_wait(chip);
-#if 0
-	printk("(1) timeout = %i\n", timeout);
-#endif
 #ifdef CONFIG_SND_DEBUG
 	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
-		snd_printk("mce_down [%p] - auto calibration time out (0)\n", CS4231P(chip, REGSEL));
+		snd_printdd("mce_down [%p] - auto calibration time out (0)\n", CS4231P(chip, REGSEL));
 #endif
 	chip->mce_bit &= ~CS4231_MCE;
 	timeout = __cs4231_readb(chip, CS4231P(chip, REGSEL));
 	__cs4231_writeb(chip, chip->mce_bit | (timeout & 0x1f), CS4231P(chip, REGSEL));
 	if (timeout == 0x80)
-		snd_printk("mce_down [%p]: serious init problem - codec still busy\n", chip->port);
+		snd_printdd("mce_down [%p]: serious init problem - codec still busy\n", chip->port);
 	if ((timeout & CS4231_MCE) == 0) {
 		spin_unlock_irqrestore(&chip->lock, flags);
 		return;
@@ -586,12 +593,12 @@
 	for (timeout = 500; timeout > 0 && (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) == 0; timeout--)
 		udelay(100);
 	if ((snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) == 0) {
-		snd_printd("cs4231_mce_down - auto calibration time out (1)\n");
+		snd_printd("cs4231_mce_down - auto calibration time out (1): %d\n", timeout);
 		spin_unlock_irqrestore(&chip->lock, flags);
 		return;
 	}
 #if 0
-	printk("(2) timeout = %i, jiffies = %li\n", timeout, jiffies);
+	snd_printdd("(2) timeout = %i, jiffies = %li\n", timeout, jiffies);
 #endif
 	/* in 10ms increments, check condition, up to 250ms */
 	timeout = 25;
@@ -605,7 +612,7 @@
 		spin_lock_irqsave(&chip->lock, flags);
 	}
 #if 0
-	printk("(3) jiffies = %li\n", jiffies);
+	snd_printdd("(3) jiffies = %li\n", jiffies);
 #endif
 	/* in 10ms increments, check condition, up to 100ms */
 	timeout = 10;
@@ -620,8 +627,8 @@
 	}
 	spin_unlock_irqrestore(&chip->lock, flags);
 #if 0
-	printk("(4) jiffies = %li\n", jiffies);
-	snd_printk("mce_down - exit = 0x%x\n", __cs4231_readb(chip, CS4231P(chip, REGSEL)));
+	snd_printdd("(4) jiffies = %li\n", jiffies);
+	snd_printdd("mce_down - exit = 0x%x\n", __cs4231_readb(chip, CS4231P(chip, REGSEL)));
 #endif
 }
 
@@ -648,25 +655,59 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 
 	while (1) {
-		unsigned int dma_size = snd_pcm_lib_period_bytes(substream);
-		unsigned int offset = dma_size * (*periods_sent);
+		unsigned int period_size = snd_pcm_lib_period_bytes(substream);
+		unsigned int offset = period_size * (*periods_sent);
 
-		if (dma_size >= (1 << 24))
+		if (period_size >= (1 << 24))
 			BUG();
 
-		if (ebus_dma_request(p, runtime->dma_addr + offset, dma_size))
+		if (ebus_dma_request(p, runtime->dma_addr + offset, period_size))
 			return;
 #if 0
-		printk("ebus_advance: Sent period %u (size[%x] offset[%x])\n",
-		       (*periods_sent), dma_size, offset);
+		snd_printdd("ebus_advance: Sent period %u (size[%x] offset[%x])\n",
+		       (*periods_sent), period_size, offset);
 #endif
 		(*periods_sent) = ((*periods_sent) + 1) % runtime->periods;
 	}
 }
 #endif
 
-static void cs4231_dma_trigger(cs4231_t *chip, unsigned int what, int on)
+#ifdef SBUS_SUPPORT
+static void snd_cs4231_sbus_advance_dma(snd_pcm_substream_t *substream, unsigned int *periods_sent)
+{
+	cs4231_t *chip = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+
+	unsigned int period_size = snd_pcm_lib_period_bytes(substream);
+	unsigned int offset = period_size * (*periods_sent % runtime->periods);
+
+	if(runtime->period_size > 0xffff + 1)
+		BUG();
+
+#if 0
+	snd_printdd("sbus_advance: period_size: %#x | runtime->dma_addr: %#x | offset: %#x | total: %#x\n",
+			period_size, runtime->dma_addr, offset, runtime->dma_addr + offset);
+#endif
+
+	switch(substream->stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		sbus_writel(runtime->dma_addr + offset, chip->port + APCPNVA);
+		sbus_writel(period_size, chip->port + APCPNC);
+		break;
+	case SNDRV_PCM_STREAM_CAPTURE:
+		sbus_writel(runtime->dma_addr + offset, chip->port + APCCNVA);
+		sbus_writel(period_size, chip->port + APCCNC);
+		break;
+	}
+
+	(*periods_sent) = (*periods_sent + 1) % runtime->periods;
+}
+#endif
+
+static void cs4231_dma_trigger(snd_pcm_substream_t *substream, unsigned int what, int on)
 {
+	cs4231_t *chip = snd_pcm_substream_chip(substream);
+
 #ifdef EBUS_SUPPORT
 	if (chip->flags & CS4231_FLAG_EBUS) {
 		if (what & CS4231_PLAYBACK_ENABLE) {
@@ -694,6 +735,61 @@
 	} else {
 #endif
 #ifdef SBUS_SUPPORT
+	u32 csr = sbus_readl(chip->port + APCCSR);
+	unsigned int dummy;
+#if 0
+	snd_printdd("cs4231: DMA trigger\n");
+#endif
+
+	switch(what) {
+	case CS4231_PLAYBACK_ENABLE:
+		if(on) {
+			csr &= ~APC_XINT_PLAY;
+			sbus_writel(csr, chip->port + APCCSR);
+
+			csr &= ~APC_PPAUSE;
+			sbus_writel(csr, chip->port + APCCSR);
+
+			snd_cs4231_sbus_advance_dma(substream, &dummy);
+
+			csr |=  APC_GENL_INT | APC_PLAY_INT | APC_XINT_ENA |
+				APC_XINT_PLAY | APC_XINT_EMPT | APC_XINT_GENL |
+				APC_XINT_PENA | APC_PDMA_READY;
+			sbus_writel(csr, chip->port + APCCSR);
+		}
+		else {
+			csr |=APC_PPAUSE;
+			sbus_writel(csr, chip->port + APCCSR);
+
+			csr &= ~APC_PDMA_READY;
+			sbus_writel(csr, chip->port + APCCSR);
+		}
+		break;
+	case CS4231_RECORD_ENABLE:
+		if(on) {
+			csr &= ~APC_XINT_CAPT;
+			sbus_writel(csr, chip->port + APCCSR);
+
+			csr &= ~APC_CPAUSE;
+			sbus_writel(csr, chip->port + APCCSR);
+
+			snd_cs4231_sbus_advance_dma(substream, &dummy);
+
+			csr |=  APC_GENL_INT | APC_CAPT_INT | APC_XINT_ENA |
+				APC_XINT_CAPT | APC_XINT_CEMP | APC_XINT_GENL |
+				APC_CDMA_READY;
+
+			sbus_writel(csr, chip->port + APCCSR);
+		}
+		else {
+			csr |= APC_CPAUSE;
+			sbus_writel(csr, chip->port + APCCSR);
+
+			csr &= ~APC_CDMA_READY;
+			sbus_writel(csr, chip->port + APCCSR);
+		}
+		break;
+	}
 #endif
 #ifdef EBUS_SUPPORT
 	}
@@ -705,6 +801,10 @@
 	cs4231_t *chip = snd_pcm_substream_chip(substream);
 	int result = 0;
 
+#if 0
+	snd_printdd("cs4231: snd_cs4231_trigger.\n");
+#endif
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -726,24 +826,16 @@
 		}
 
 #if 0
-		printk("TRIGGER: what[%x] on(%d)\n",
+		snd_printdd("TRIGGER: what[%x] on(%d)\n",
 		       what, (cmd == SNDRV_PCM_TRIGGER_START));
 #endif
 
 		spin_lock_irqsave(&chip->lock, flags);
 		if (cmd == SNDRV_PCM_TRIGGER_START) {
-			cs4231_dma_trigger(chip, what, 1);
+			cs4231_dma_trigger(substream, what, 1);
 			chip->image[CS4231_IFACE_CTRL] |= what;
-			if (what & CS4231_PLAYBACK_ENABLE) {
-				snd_cs4231_out(chip, CS4231_PLY_LWR_CNT, 0xff);
-				snd_cs4231_out(chip, CS4231_PLY_UPR_CNT, 0xff);
-			}
-			if (what & CS4231_RECORD_ENABLE) {
-				snd_cs4231_out(chip, CS4231_REC_LWR_CNT, 0xff);
-				snd_cs4231_out(chip, CS4231_REC_UPR_CNT, 0xff);
-			}
 		} else {
-			cs4231_dma_trigger(chip, what, 0);
+			cs4231_dma_trigger(substream, what, 0);
 			chip->image[CS4231_IFACE_CTRL] &= ~what;
 		}
 		snd_cs4231_out(chip, CS4231_IFACE_CTRL,
@@ -791,7 +883,7 @@
 	if (channels > 1)
 		rformat |= CS4231_STEREO;
 #if 0
-	snd_printk("get_format: 0x%x (mode=0x%x)\n", format, mode);
+	snd_printdd("get_format: 0x%x (mode=0x\%x)\n", format, 0);
 #endif
 	return rformat;
 }
@@ -944,7 +1036,7 @@
 	snd_cs4231_mce_down(chip);
 
 #ifdef SNDRV_DEBUG_MCE
-	snd_printk("init: (1)\n");
+	snd_printdd("init: (1)\n");
 #endif
 	snd_cs4231_mce_up(chip);
 	spin_lock_irqsave(&chip->lock, flags);
@@ -957,7 +1049,7 @@
 	snd_cs4231_mce_down(chip);
 
 #ifdef SNDRV_DEBUG_MCE
-	snd_printk("init: (2)\n");
+	snd_printdd("init: (2)\n");
 #endif
 
 	snd_cs4231_mce_up(chip);
@@ -967,7 +1059,7 @@
 	snd_cs4231_mce_down(chip);
 
 #ifdef SNDRV_DEBUG_MCE
-	snd_printk("init: (3) - afei = 0x%x\n", chip->image[CS4231_ALT_FEATURE_1]);
+	snd_printdd("init: (3) - afei = 0x%x\n", chip->image[CS4231_ALT_FEATURE_1]);
 #endif
 
 	spin_lock_irqsave(&chip->lock, flags);
@@ -981,7 +1073,7 @@
 	snd_cs4231_mce_down(chip);
 
 #ifdef SNDRV_DEBUG_MCE
-	snd_printk("init: (4)\n");
+	snd_printdd("init: (4)\n");
 #endif
 
 	snd_cs4231_mce_up(chip);
@@ -991,7 +1083,7 @@
 	snd_cs4231_mce_down(chip);
 
 #ifdef SNDRV_DEBUG_MCE
-	snd_printk("init: (5)\n");
+	snd_printdd("init: (5)\n");
 #endif
 }
 
@@ -999,6 +1091,10 @@
 {
 	unsigned long flags;
 
+#if 0
+	snd_printdd("cs4231: snd_cs4231_open.\n");
+#endif
+
 	down(&chip->open_mutex);
 	if ((chip->mode & mode)) {
 		up(&chip->open_mutex);
@@ -1022,6 +1118,11 @@
 		       CS4231_RECORD_IRQ |
 		       CS4231_TIMER_IRQ);
 	snd_cs4231_out(chip, CS4231_IRQ_STATUS, 0);
+
+#if 0
+	snd_cs4231_debug(chip);
+#endif
+
 	spin_unlock_irqrestore(&chip->lock, flags);
 
 	chip->mode = mode;
@@ -1117,6 +1218,10 @@
 	unsigned char new_pdfr;
 	int err;
 
+#if 0
+	snd_printdd("cs4231: snd_cs4231_playback_hw_params.\n");
+#endif
+
 	if ((err = snd_pcm_lib_malloc_pages(substream,
 					    params_buffer_bytes(hw_params))) < 0)
 		return err;
@@ -1136,11 +1241,29 @@
 static int snd_cs4231_playback_prepare(snd_pcm_substream_t *substream)
 {
 	cs4231_t *chip = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
 	unsigned long flags;
 
+#if 0
+	snd_printdd("cs4231: snd_cs4231_playback_prepare.\n");
+#endif
+
 	spin_lock_irqsave(&chip->lock, flags);
+
 	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_PLAYBACK_ENABLE |
 					    CS4231_PLAYBACK_PIO);
+
+	if(runtime->period_size > 0xffff + 1)
+		BUG();
+
+	snd_cs4231_out(chip, CS4231_PLY_LWR_CNT, (runtime->period_size - 1) & 0x00ff);
+	snd_cs4231_out(chip, CS4231_PLY_UPR_CNT, (runtime->period_size - 1) >> 8 & 0x00ff);
+	chip->p_periods_sent = 0;
+
+#if 0
+	snd_cs4231_debug(chip);
+#endif
+
 	spin_unlock_irqrestore(&chip->lock, flags);
 
 	return 0;
@@ -1172,12 +1295,16 @@
 static int snd_cs4231_capture_prepare(snd_pcm_substream_t *substream)
 {
 	cs4231_t *chip = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
 	unsigned long flags;
 
 	spin_lock_irqsave(&chip->lock, flags);
 	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_RECORD_ENABLE |
 					    CS4231_RECORD_PIO);
 
+	snd_cs4231_out(chip, CS4231_REC_LWR_CNT, (runtime->period_size - 1) & 0x00ff);
+	snd_cs4231_out(chip, CS4231_REC_LWR_CNT, (runtime->period_size - 1) >> 8 & 0x00ff);
+
 	spin_unlock_irqrestore(&chip->lock, flags);
 
 	return 0;
@@ -1196,53 +1323,76 @@
 		chip->capture_substream->runtime->overrange++;
 }
 
-static void snd_cs4231_generic_interrupt(cs4231_t *chip)
+static irqreturn_t snd_cs4231_generic_interrupt(cs4231_t *chip)
 {
 	unsigned long flags;
 	unsigned char status;
 
+	/*This is IRQ is not raised by the cs4231*/
+	if(!(__cs4231_readb(chip, CS4231P(chip, STATUS)) & CS4231_GLOBALIRQ))
+		return IRQ_NONE;
+
 	status = snd_cs4231_in(chip, CS4231_IRQ_STATUS);
-	if (!status)
-		return;
 
-	if (status & CS4231_TIMER_IRQ) {
+#if 0
+	snd_printdd("cs4231: snd_cs4231_generic_interruptIRQ, status=%#.2x.\n", status);
+#endif
+
+	if(status & CS4231_TIMER_IRQ) {
 		if (chip->timer)
 			snd_timer_interrupt(chip->timer, chip->timer->sticks);
 	}		
-	if (status & CS4231_PLAYBACK_IRQ)
-		snd_pcm_period_elapsed(chip->playback_substream);
-	if (status & CS4231_RECORD_IRQ) {
+
+	if(status & 0x0f)
+		snd_printdd("cs4231: snd_cs4231_generic_interruptIRQ under- or overrun, status=%#.2x.\n", status);
+	
+#if 0
+	if(status & CS4231_PLAYBACK_IRQ)
+		;
+#endif
+
+	if(status & CS4231_RECORD_IRQ)
 		snd_cs4231_overrange(chip);
-		snd_pcm_period_elapsed(chip->capture_substream);
-	}
 
 	/* ACK the CS4231 interrupt. */
 	spin_lock_irqsave(&chip->lock, flags);
 	snd_cs4231_outm(chip, CS4231_IRQ_STATUS, ~CS4231_ALL_IRQS | ~status, 0);
 	spin_unlock_irqrestore(&chip->lock, flags);
+
+	return 0;
 }
 
 #ifdef SBUS_SUPPORT
 static irqreturn_t snd_cs4231_sbus_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	cs4231_t *chip = dev_id;
-	u32 csr;
-
-	csr = sbus_readl(chip->port + APCCSR);
-	if (!(csr & (APC_INT_PENDING |
-		     APC_PLAY_INT |
-		     APC_CAPT_INT |
-		     APC_GENL_INT |
-		     APC_XINT_PEMP |
-		     APC_XINT_CEMP)))
-		return IRQ_NONE;
 
 	/* ACK the APC interrupt. */
+	u32 csr = sbus_readl(chip->port + APCCSR);
+#if 0
+	static unsigned int irqcount;
+	snd_printdd("cs4231: snd_cs4231_sbus_interruptIRQ No%u, csr=%#.8x.\n", irqcount++, csr);
+	/*snd_cs4231_debug(chip);*/
+#endif
 	sbus_writel(csr, chip->port + APCCSR);
 
-	snd_cs4231_generic_interrupt(chip);
+	if(csr & APC_XINT_PEMP || csr & APC_XINT_PEMP)
+		snd_printdd("cs4231: snd_cs4231_sbus_interruptIRQ DMA underrun, csr=%#.8x.\n", csr);
+
+	if(csr & APC_PLAY_INT && csr & APC_XINT_PNVA && !(csr & APC_XINT_EMPT)) {
+		snd_cs4231_sbus_advance_dma(chip->playback_substream, &chip->p_periods_sent);
+		snd_pcm_period_elapsed(chip->playback_substream);
+	}
+
+	if(csr & APC_CAPT_INT && csr & APC_XINT_CNVA) {
+		snd_cs4231_sbus_advance_dma(chip->playback_substream, &chip->c_periods_sent);
+		snd_pcm_period_elapsed(chip->capture_substream);
+	}
+
+	if(csr & APC_XINT_CEMP)
+		;
 
-	return IRQ_HANDLED;
+	return snd_cs4231_generic_interrupt(chip);
 }
 #endif
 
@@ -1278,7 +1428,7 @@
 	if (!(chip->image[CS4231_IFACE_CTRL] & CS4231_PLAYBACK_ENABLE))
 		return 0;
 	period_bytes = snd_pcm_lib_period_bytes(substream);
-	ptr = period_bytes * chip->p_periods_sent;
+	ptr = period_bytes * (chip->p_periods_sent % substream->runtime->periods);
 #ifdef EBUS_SUPPORT
 	if (chip->flags & CS4231_FLAG_EBUS) {
 		residue = ebus_dma_residue(&chip->eb2p);
@@ -1290,7 +1440,17 @@
 #ifdef EBUS_SUPPORT
 	}
 #endif
+#if 0
+	snd_printdd("Residue: %u\n", (unsigned)residue);
+#endif
 	ptr += (period_bytes - residue);
+
+#if 0
+	snd_printdd("cs4231: snd_cs4231_playback_pointer: residue: %#x | ptr: %#x\n",
+			(unsigned)bytes_to_frames(substream->runtime, residue),
+			(unsigned)bytes_to_frames(substream->runtime, ptr));
+#endif
+
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
@@ -1315,6 +1475,9 @@
 	}
 #endif
 	ptr += (period_bytes - residue);
+#if 0
+	snd_cs4231_debug(chip);
+#endif
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
@@ -1458,6 +1621,10 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	int err;
 
+#if 0
+	snd_printdd("cs4231: snd_cs4231_playback_open.\n");
+#endif
+
 	runtime->hw = snd_cs4231_playback;
 
 	if ((err = snd_cs4231_open(chip, CS4231_MODE_PLAY)) < 0) {
@@ -1496,6 +1663,10 @@
 {
 	cs4231_t *chip = snd_pcm_substream_chip(substream);
 
+#if 0
+	snd_printdd("cs4231: snd_cs4231_playback_close.\n");
+#endif
+
 	chip->playback_substream = NULL;
 	snd_cs4231_close(chip, CS4231_MODE_PLAY);
 
@@ -1982,13 +2153,13 @@
 	chip->port = sbus_ioremap(&sdev->resource[0], 0,
 				  chip->regs_size, "cs4231");
 	if (!chip->port) {
-		snd_printk("cs4231-%d: Unable to map chip registers.\n", dev);
+		snd_printdd("cs4231-%d: Unable to map chip registers.\n", dev);
 		return -EIO;
 	}
 
 	if (request_irq(sdev->irqs[0], snd_cs4231_sbus_interrupt,
 			SA_SHIRQ, "cs4231", chip)) {
-		snd_printk("cs4231-%d: Unable to grab SBUS IRQ %s\n",
+		snd_printdd("cs4231-%d: Unable to grab SBUS IRQ %s\n",
 			   dev,
 			   __irq_itoa(sdev->irqs[0]));
 		snd_cs4231_sbus_free(chip);
@@ -2110,29 +2281,29 @@
 	chip->eb2c.regs = ioremap(edev->resource[2].start, 0x10);
 	if (!chip->port || !chip->eb2p.regs || !chip->eb2c.regs) {
 		snd_cs4231_ebus_free(chip);
-		snd_printk("cs4231-%d: Unable to map chip registers.\n", dev);
+		snd_printdd("cs4231-%d: Unable to map chip registers.\n", dev);
 		return -EIO;
 	}
 
 	if (ebus_dma_register(&chip->eb2c)) {
 		snd_cs4231_ebus_free(chip);
-		snd_printk("cs4231-%d: Unable to register EBUS capture DMA\n", dev);
+		snd_printdd("cs4231-%d: Unable to register EBUS capture DMA\n", dev);
 		return -EBUSY;
 	}
 	if (ebus_dma_irq_enable(&chip->eb2c, 1)) {
 		snd_cs4231_ebus_free(chip);
-		snd_printk("cs4231-%d: Unable to enable EBUS capture IRQ\n", dev);
+		snd_printdd("cs4231-%d: Unable to enable EBUS capture IRQ\n", dev);
 		return -EBUSY;
 	}
 
 	if (ebus_dma_register(&chip->eb2p)) {
 		snd_cs4231_ebus_free(chip);
-		snd_printk("cs4231-%d: Unable to register EBUS play DMA\n", dev);
+		snd_printdd("cs4231-%d: Unable to register EBUS play DMA\n", dev);
 		return -EBUSY;
 	}
 	if (ebus_dma_irq_enable(&chip->eb2p, 1)) {
 		snd_cs4231_ebus_free(chip);
-		snd_printk("cs4231-%d: Unable to enable EBUS play IRQ\n", dev);
+		snd_printdd("cs4231-%d: Unable to enable EBUS play IRQ\n", dev);
 		return -EBUSY;
 	}
 
@@ -2190,6 +2361,10 @@
 
 	found = 0;
 
+#if 0
+	snd_printdd("cs4231: XXX\n");
+#endif
+
 #ifdef SBUS_SUPPORT
 	for_all_sbusdev(sdev, sbus) {
 		if (!strcmp(sdev->prom_name, "SUNW,CS4231")) {

--M9NhX3UHpAaciwkO--
