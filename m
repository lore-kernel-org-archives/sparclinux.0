From: Christopher Zimmermann <madroach@zakweb.de>
Date: Sat, 10 Sep 2005 15:41:46 +0000
Subject: Re: ALSA - CS4231 on ultra2
Message-Id: <20050910154146.GA3590@sparc>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
List-Id: <sparclinux.vger.kernel.org>
References: <4322D4DD.20609@triaton-webhosting.com>
In-Reply-To: <4322D4DD.20609@triaton-webhosting.com>
To: sparclinux@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Hello,
> 
> can anyone give me the status of the
> CS4231 ALSA driver on sparc64? I have
> seen the question a couple of times
> here (recently and some month ago),
> but nobody answered it.
> Is it the wrong place to put the question?
> 
> It would be nice to get the sound working.
> Can somebody give me a hint what I can do
> to solve the problem?
> 
> Regards
>             Georg Chini

I asked this question here a few days ago. According to David S. Miller
the driver is working for ebus systems, but neither completed nor tested
for sbus systems. I'm now trying to get it to work on my Ultra2. I never
did any kernel hacking till one week ago, so I can't promise nothing.
I will append a patch with what I did so far.
If you are interested to help me, you're welcome.

Christopher

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch

--- ../linux-2.6.12.5/sound/sparc/cs4231.c	2005-08-15 02:20:18.000000000 +0200
+++ sound/sparc/cs4231.c	2005-09-10 17:22:30.000000000 +0200
@@ -1,3 +1,6 @@
+#define SNDRV_DEBUG_MCE
+#define MY
+
 /*
  * Driver for CS4231 sound chips found on Sparcs.
  * Copyright (C) 2002 David S. Miller <davem@redhat.com>
@@ -402,7 +405,7 @@
 	     	udelay(100);
 #ifdef CONFIG_SND_DEBUG
 	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
-		snd_printk("outm: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
+		snd_printdd("outm: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
 #endif
 	if (chip->calibrate_mute) {
 		chip->image[reg] &= mask;
@@ -425,6 +428,10 @@
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
@@ -437,17 +444,17 @@
 	for (timeout = 250;
 	     timeout > 0 && (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT);
 	     timeout--)
-	     	udelay(100);
+	     	udelay(1000);
 #ifdef CONFIG_SND_DEBUG
 	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
-		snd_printk("out: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
+		snd_printdd("out: auto calibration time out - reg = 0x%x, value = 0x%x\n", reg, value);
 #endif
 	__cs4231_writeb(chip, chip->mce_bit | reg, CS4231P(chip, REGSEL));
 	__cs4231_writeb(chip, value, CS4231P(chip, REG));
 	chip->image[reg] = value;
 	mb();
-#if 0
-	printk("codec out - reg 0x%x = 0x%x\n", chip->mce_bit | reg, value);
+#ifdef MY
+	snd_printdd("codec out - reg 0x%x = 0x%x | timeout = %d\n", chip->mce_bit | reg, value, timeout);
 #endif
 }
 
@@ -462,57 +469,57 @@
 	     	udelay(100);
 #ifdef CONFIG_SND_DEBUG
 	if (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT)
-		snd_printk("in: auto calibration time out - reg = 0x%x\n", reg);
+		snd_printdd("in: auto calibration time out - reg = 0x%x\n", reg);
 #endif
 	__cs4231_writeb(chip, chip->mce_bit | reg, CS4231P(chip, REGSEL));
 	mb();
 	ret = __cs4231_readb(chip, CS4231P(chip, REG));
-#if 0
-	printk("codec in - reg 0x%x = 0x%x\n", chip->mce_bit | reg, ret);
+#ifdef MYIN
+	snd_printdd("codec in - reg 0x%x = 0x%x\n", chip->mce_bit | reg, ret);
 #endif
 	return ret;
 }
 
-#if 0
+#ifdef MY
 
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
+	/*snd_printdd("  0x00: left input      = 0x%02x\n", snd_cs4231_in(chip, 0x00));*/
+	/*snd_printdd("  0x10: alt 1 (CFIG 2)  = 0x%02x\n", snd_cs4231_in(chip, 0x10));*/
+	/*snd_printdd("  0x01: right input     = 0x%02x\n", snd_cs4231_in(chip, 0x01));*/
+	/*snd_printdd("  0x11: alt 2 (CFIG 3)  = 0x%02x\n", snd_cs4231_in(chip, 0x11));*/
+	/*snd_printdd("  0x02: GF1 left input  = 0x%02x\n", snd_cs4231_in(chip, 0x02));*/
+	/*snd_printdd("  0x12: left line in    = 0x%02x\n", snd_cs4231_in(chip, 0x12));*/
+	/*snd_printdd("  0x03: GF1 right input = 0x%02x\n", snd_cs4231_in(chip, 0x03));*/
+	/*snd_printdd("  0x13: right line in   = 0x%02x\n", snd_cs4231_in(chip, 0x13));*/
+	/*snd_printdd("  0x04: CD left input   = 0x%02x\n", snd_cs4231_in(chip, 0x04));*/
+	/*snd_printdd("  0x14: timer low       = 0x%02x\n", snd_cs4231_in(chip, 0x14));*/
+	/*snd_printdd("  0x05: CD right input  = 0x%02x\n", snd_cs4231_in(chip, 0x05));*/
+	/*snd_printdd("  0x15: timer high      = 0x%02x\n", snd_cs4231_in(chip, 0x15));*/
+	/*snd_printdd("  0x06: left output     = 0x%02x\n", snd_cs4231_in(chip, 0x06));*/
+	/*snd_printdd("  0x16: left MIC (PnP)  = 0x%02x\n", snd_cs4231_in(chip, 0x16));*/
+	/*snd_printdd("  0x07: right output    = 0x%02x\n", snd_cs4231_in(chip, 0x07));*/
+	/*snd_printdd("  0x17: right MIC (PnP) = 0x%02x\n", snd_cs4231_in(chip, 0x17));*/
+	/*snd_printdd("  0x08: playback format = 0x%02x\n", snd_cs4231_in(chip, 0x08));*/
+	snd_printdd("  0x18: IRQ status      = 0x%02x\n", snd_cs4231_in(chip, 0x18));
+	snd_printdd("  0x09: iface (CFIG 1)  = 0x%02x\n", snd_cs4231_in(chip, 0x09));
+	/*snd_printdd("  0x19: left line out   = 0x%02x\n", snd_cs4231_in(chip, 0x19));*/
+	snd_printdd("  0x0a: pin control     = 0x%02x\n", snd_cs4231_in(chip, 0x0a));
+	/*snd_printdd("  0x1a: mono control    = 0x%02x\n", snd_cs4231_in(chip, 0x1a));*/
+	snd_printdd("  0x0b: init & status   = 0x%02x\n", snd_cs4231_in(chip, 0x0b));
+	/*snd_printdd("  0x1b: right line out  = 0x%02x\n", snd_cs4231_in(chip, 0x1b));*/
+	/*snd_printdd("  0x0c: revision & mode = 0x%02x\n", snd_cs4231_in(chip, 0x0c));*/
+	/*snd_printdd("  0x1c: record format   = 0x%02x\n", snd_cs4231_in(chip, 0x1c));*/
+	/*snd_printdd("  0x0d: loopback        = 0x%02x\n", snd_cs4231_in(chip, 0x0d));*/
+	/*snd_printdd("  0x1d: var freq (PnP)  = 0x%02x\n", snd_cs4231_in(chip, 0x1d));*/
+	/*snd_printdd("  0x0e: ply upr count   = 0x%02x\n", snd_cs4231_in(chip, 0x0e));*/
+	/*snd_printdd("  0x1e: rec upr count   = 0x%02x\n", snd_cs4231_in(chip, 0x1e));*/
+	/*snd_printdd("  0x0f: ply lwr count   = 0x%02x\n", snd_cs4231_in(chip, 0x0f));*/
+	/*snd_printdd("  0x1f: rec lwr count   = 0x%02x\n", snd_cs4231_in(chip, 0x1f));*/
 }
 
 #endif
@@ -528,11 +535,17 @@
 	/* huh.. looks like this sequence is proper for CS4231A chip (GUS MAX) */
 	for (timeout = 5; timeout > 0; timeout--)
 		__cs4231_readb(chip, CS4231P(chip, REGSEL));
+#ifdef MY
+	snd_printdd("(0) timeout = %i\n", timeout);
+#endif
 	/* end of cleanup sequence */
-	for (timeout = 250;
+	for (timeout = 2500;
 	     timeout > 0 && (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT);
 	     timeout--)
 	     	udelay(100);
+#ifdef MY
+	snd_printdd("(1) timeout = %i\n", timeout);
+#endif
 }
 
 static void snd_cs4231_mce_up(cs4231_t *chip)
@@ -545,12 +558,12 @@
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
@@ -561,20 +574,18 @@
 	unsigned long flags;
 	int timeout;
 
+	snd_printdd("snd_cs4231_mce_down.\n");
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
@@ -583,49 +594,49 @@
 
 	/* calibration process */
 
-	for (timeout = 500; timeout > 0 && (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) == 0; timeout--)
+	for (timeout = 2500; timeout > 0 && (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) == 0; timeout--)
 		udelay(100);
 	if ((snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) == 0) {
-		snd_printd("cs4231_mce_down - auto calibration time out (1)\n");
+		snd_printd("cs4231_mce_down - auto calibration time out (1): %d\n", timeout);
 		spin_unlock_irqrestore(&chip->lock, flags);
 		return;
 	}
-#if 0
-	printk("(2) timeout = %i, jiffies = %li\n", timeout, jiffies);
+#ifdef MY
+	snd_printdd("(2) timeout = %i, jiffies = %li\n", timeout, jiffies);
 #endif
 	/* in 10ms increments, check condition, up to 250ms */
 	timeout = 25;
 	while (snd_cs4231_in(chip, CS4231_TEST_INIT) & CS4231_CALIB_IN_PROGRESS) {
 		spin_unlock_irqrestore(&chip->lock, flags);
 		if (--timeout < 0) {
-			snd_printk("mce_down - auto calibration time out (2)\n");
+			snd_printdd("mce_down - auto calibration time out (2)\n");
 			return;
 		}
 		msleep(10);
 		spin_lock_irqsave(&chip->lock, flags);
 	}
-#if 0
-	printk("(3) jiffies = %li\n", jiffies);
+#ifdef MY
+	snd_printdd("(3) jiffies = %li\n", jiffies);
 #endif
 	/* in 10ms increments, check condition, up to 100ms */
 	timeout = 10;
 	while (__cs4231_readb(chip, CS4231P(chip, REGSEL)) & CS4231_INIT) {
 		spin_unlock_irqrestore(&chip->lock, flags);
 		if (--timeout < 0) {
-			snd_printk("mce_down - auto calibration time out (3)\n");
+			snd_printdd("mce_down - auto calibration time out (3)\n");
 			return;
 		}
 		msleep(10);
 		spin_lock_irqsave(&chip->lock, flags);
 	}
 	spin_unlock_irqrestore(&chip->lock, flags);
-#if 0
-	printk("(4) jiffies = %li\n", jiffies);
-	snd_printk("mce_down - exit = 0x%x\n", __cs4231_readb(chip, CS4231P(chip, REGSEL)));
+#ifdef MY
+	snd_printdd("(4) jiffies = %li\n", jiffies);
+	snd_printdd("mce_down - exit = 0x%x\n", __cs4231_readb(chip, CS4231P(chip, REGSEL)));
 #endif
 }
 
-#if 0 /* Unused for now... */
+#ifdef MYunused /* Unused for now... */
 static unsigned int snd_cs4231_get_count(unsigned char format, unsigned int size)
 {
 	switch (format & 0xe0) {
@@ -657,7 +668,7 @@
 		if (ebus_dma_request(p, runtime->dma_addr + offset, dma_size))
 			return;
 #if 0
-		printk("ebus_advance: Sent period %u (size[%x] offset[%x])\n",
+		snd_printdd("ebus_advance: Sent period %u (size[%x] offset[%x])\n",
 		       (*periods_sent), dma_size, offset);
 #endif
 		(*periods_sent) = ((*periods_sent) + 1) % runtime->periods;
@@ -665,8 +676,29 @@
 }
 #endif
 
-static void cs4231_dma_trigger(cs4231_t *chip, unsigned int what, int on)
+#ifdef SBUS_SUPPORT
+static void snd_cs4231_sbus_advance_dma(snd_pcm_substream_t *substream, unsigned int *periods_sent)
 {
+	cs4231_t *chip = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+
+	unsigned int dma_size = snd_pcm_lib_period_bytes(substream);
+	unsigned int offset = dma_size * (*periods_sent);
+
+	if (dma_size >= (1 << 24))
+		BUG();
+
+	sbus_writel(runtime->dma_addr + offset, chip->port + APCPNVA);
+	sbus_writel(dma_size, chip->port + APCPNC);
+	
+	(*periods_sent) = ((*periods_sent) + 1) % runtime->periods;
+}
+#endif
+
+static void cs4231_dma_trigger(snd_pcm_substream_t *substream, unsigned int what, int on)
+{
+	cs4231_t *chip = snd_pcm_substream_chip(substream);
+
 #ifdef EBUS_SUPPORT
 	if (chip->flags & CS4231_FLAG_EBUS) {
 		if (what & CS4231_PLAYBACK_ENABLE) {
@@ -674,9 +706,9 @@
 				ebus_dma_prepare(&chip->eb2p, 0);
 				ebus_dma_enable(&chip->eb2p, 1);
 				snd_cs4231_ebus_advance_dma(&chip->eb2p,
-					chip->playback_substream,
-					&chip->p_periods_sent);
-			} else {
+						chip->playback_substream,
+						&chip->p_periods_sent); }
+			else {
 				ebus_dma_enable(&chip->eb2p, 0);
 			}
 		}
@@ -685,15 +717,39 @@
 				ebus_dma_prepare(&chip->eb2c, 1);
 				ebus_dma_enable(&chip->eb2c, 1);
 				snd_cs4231_ebus_advance_dma(&chip->eb2c,
-					chip->capture_substream,
-					&chip->c_periods_sent);
-			} else {
+						chip->capture_substream,
+						&chip->c_periods_sent);
+			}
+			else {
 				ebus_dma_enable(&chip->eb2c, 0);
 			}
 		}
 	} else {
 #endif
 #ifdef SBUS_SUPPORT
+	snd_printdd("cs4231: DMA trigger\n");
+
+	if(what & CS4231_PLAYBACK_ENABLE) {
+		u32 csr, pnva;
+
+		csr = sbus_readl(chip->port + APCCSR);
+		snd_printdd("cs4231: DMA trigger: csr=%#.8x\n", csr);
+
+		csr &= ~APC_XINT_PLAY;
+		sbus_writel(csr, chip->port + APCCSR);
+
+		csr &= ~APC_PPAUSE;
+		sbus_writel(csr, chip->port + APCCSR);
+
+		pnva = sbus_readl(chip->port + APCPNVA);
+		snd_printdd("cs4231: DMA trigger: pnva=%#.8x\n", pnva);
+		snd_cs4231_sbus_advance_dma(substream, &chip->c_periods_sent);
+
+		csr |=  APC_GENL_INT | APC_PLAY_INT | APC_XINT_ENA |
+			APC_XINT_PLAY | APC_XINT_EMPT | APC_XINT_GENL |
+			APC_XINT_PENA | APC_PDMA_READY;
+		sbus_writel(csr, chip->port + APCCSR);
+	}
 #endif
 #ifdef EBUS_SUPPORT
 	}
@@ -705,6 +761,8 @@
 	cs4231_t *chip = snd_pcm_substream_chip(substream);
 	int result = 0;
 
+	snd_printdd("cs4231: snd_cs4231_trigger.\n");
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -725,14 +783,14 @@
 			}
 		}
 
-#if 0
-		printk("TRIGGER: what[%x] on(%d)\n",
+#ifdef MY
+		snd_printdd("TRIGGER: what[%x] on(%d)\n",
 		       what, (cmd == SNDRV_PCM_TRIGGER_START));
 #endif
 
 		spin_lock_irqsave(&chip->lock, flags);
 		if (cmd == SNDRV_PCM_TRIGGER_START) {
-			cs4231_dma_trigger(chip, what, 1);
+			cs4231_dma_trigger(substream, what, 1);
 			chip->image[CS4231_IFACE_CTRL] |= what;
 			if (what & CS4231_PLAYBACK_ENABLE) {
 				snd_cs4231_out(chip, CS4231_PLY_LWR_CNT, 0xff);
@@ -743,7 +801,7 @@
 				snd_cs4231_out(chip, CS4231_REC_UPR_CNT, 0xff);
 			}
 		} else {
-			cs4231_dma_trigger(chip, what, 0);
+			cs4231_dma_trigger(substream, what, 0);
 			chip->image[CS4231_IFACE_CTRL] &= ~what;
 		}
 		snd_cs4231_out(chip, CS4231_IFACE_CTRL,
@@ -755,7 +813,7 @@
 		result = -EINVAL;
 		break;
 	}
-#if 0
+#ifdef MY
 	snd_cs4231_debug(chip);
 #endif
 	return result;
@@ -790,8 +848,8 @@
 	}
 	if (channels > 1)
 		rformat |= CS4231_STEREO;
-#if 0
-	snd_printk("get_format: 0x%x (mode=0x%x)\n", format, mode);
+#ifdef MY
+	snd_printdd("get_format: 0x%x (mode=0x\%x)\n", format, 0);
 #endif
 	return rformat;
 }
@@ -944,7 +1002,7 @@
 	snd_cs4231_mce_down(chip);
 
 #ifdef SNDRV_DEBUG_MCE
-	snd_printk("init: (1)\n");
+	snd_printdd("init: (1)\n");
 #endif
 	snd_cs4231_mce_up(chip);
 	spin_lock_irqsave(&chip->lock, flags);
@@ -957,7 +1015,7 @@
 	snd_cs4231_mce_down(chip);
 
 #ifdef SNDRV_DEBUG_MCE
-	snd_printk("init: (2)\n");
+	snd_printdd("init: (2)\n");
 #endif
 
 	snd_cs4231_mce_up(chip);
@@ -967,7 +1025,7 @@
 	snd_cs4231_mce_down(chip);
 
 #ifdef SNDRV_DEBUG_MCE
-	snd_printk("init: (3) - afei = 0x%x\n", chip->image[CS4231_ALT_FEATURE_1]);
+	snd_printdd("init: (3) - afei = 0x%x\n", chip->image[CS4231_ALT_FEATURE_1]);
 #endif
 
 	spin_lock_irqsave(&chip->lock, flags);
@@ -981,7 +1039,7 @@
 	snd_cs4231_mce_down(chip);
 
 #ifdef SNDRV_DEBUG_MCE
-	snd_printk("init: (4)\n");
+	snd_printdd("init: (4)\n");
 #endif
 
 	snd_cs4231_mce_up(chip);
@@ -991,7 +1049,7 @@
 	snd_cs4231_mce_down(chip);
 
 #ifdef SNDRV_DEBUG_MCE
-	snd_printk("init: (5)\n");
+	snd_printdd("init: (5)\n");
 #endif
 }
 
@@ -999,6 +1057,8 @@
 {
 	unsigned long flags;
 
+	snd_printdd("cs4231: snd_cs4231_open.\n");
+
 	down(&chip->open_mutex);
 	if ((chip->mode & mode)) {
 		up(&chip->open_mutex);
@@ -1011,6 +1071,7 @@
 	}
 	/* ok. now enable and ack CODEC IRQ */
 	spin_lock_irqsave(&chip->lock, flags);
+
 	snd_cs4231_out(chip, CS4231_IRQ_STATUS, CS4231_PLAYBACK_IRQ |
 		       CS4231_RECORD_IRQ |
 		       CS4231_TIMER_IRQ);
@@ -1022,6 +1083,11 @@
 		       CS4231_RECORD_IRQ |
 		       CS4231_TIMER_IRQ);
 	snd_cs4231_out(chip, CS4231_IRQ_STATUS, 0);
+
+#ifdef MY
+	snd_cs4231_debug(chip);
+#endif
+
 	spin_unlock_irqrestore(&chip->lock, flags);
 
 	chip->mode = mode;
@@ -1117,6 +1183,8 @@
 	unsigned char new_pdfr;
 	int err;
 
+	snd_printdd("cs4231: snd_cs4231_playback_hw_params.\n");
+
 	if ((err = snd_pcm_lib_malloc_pages(substream,
 					    params_buffer_bytes(hw_params))) < 0)
 		return err;
@@ -1130,6 +1198,7 @@
 
 static int snd_cs4231_playback_hw_free(snd_pcm_substream_t *substream)
 {
+	snd_printdd("cs4231: snd_cs4231_playback_hw_free.\n");
 	return snd_pcm_lib_free_pages(substream);
 }
 
@@ -1138,9 +1207,15 @@
 	cs4231_t *chip = snd_pcm_substream_chip(substream);
 	unsigned long flags;
 
+	snd_printdd("cs4231: snd_cs4231_playback_prepare.\n");
+
 	spin_lock_irqsave(&chip->lock, flags);
+
 	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_PLAYBACK_ENABLE |
 					    CS4231_PLAYBACK_PIO);
+#ifdef MY
+	snd_cs4231_debug(chip);
+#endif
 	spin_unlock_irqrestore(&chip->lock, flags);
 
 	return 0;
@@ -1202,6 +1277,9 @@
 	unsigned char status;
 
 	status = snd_cs4231_in(chip, CS4231_IRQ_STATUS);
+
+	snd_printdd("cs4231: snd_cs4231_generic_interruptIRQ, status=%#.2x.\n", status);
+
 	if (!status)
 		return;
 
@@ -1229,6 +1307,7 @@
 	u32 csr;
 
 	csr = sbus_readl(chip->port + APCCSR);
+	snd_printdd("cs4231: snd_cs4231_sbus_interruptIRQ, csr=%#.8x.\n", csr);
 	if (!(csr & (APC_INT_PENDING |
 		     APC_PLAY_INT |
 		     APC_CAPT_INT |
@@ -1275,6 +1354,8 @@
 	cs4231_t *chip = snd_pcm_substream_chip(substream);
 	size_t ptr, residue, period_bytes;
 
+	snd_printdd("cs4231: snd_cs4231_playback_pointer.\n");
+
 	if (!(chip->image[CS4231_IFACE_CTRL] & CS4231_PLAYBACK_ENABLE))
 		return 0;
 	period_bytes = snd_pcm_lib_period_bytes(substream);
@@ -1315,6 +1396,9 @@
 	}
 #endif
 	ptr += (period_bytes - residue);
+#ifdef MY
+	snd_cs4231_debug(chip);
+#endif
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
@@ -1328,7 +1412,7 @@
 	int i, id, vers;
 	unsigned char *ptr;
 
-#if 0
+#ifdef MY
 	snd_cs4231_debug(chip);
 #endif
 	id = vers = 0;
@@ -1458,6 +1542,8 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	int err;
 
+	snd_printdd("cs4231: snd_cs4231_playback_open.\n");
+
 	runtime->hw = snd_cs4231_playback;
 
 	if ((err = snd_cs4231_open(chip, CS4231_MODE_PLAY)) < 0) {
@@ -1496,6 +1582,8 @@
 {
 	cs4231_t *chip = snd_pcm_substream_chip(substream);
 
+	snd_printdd("cs4231: snd_cs4231_playback_close.\n");
+
 	chip->playback_substream = NULL;
 	snd_cs4231_close(chip, CS4231_MODE_PLAY);
 
@@ -1982,18 +2070,23 @@
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
 		return -EBUSY;
 	}
+#ifdef MY
+	snd_printdd("cs4231-%d: Able to grab SBUS IRQ %s\n",
+		   dev,
+		   __irq_itoa(sdev->irqs[0]));
+#endif
 	chip->irq[0] = sdev->irqs[0];
 
 	if (snd_cs4231_probe(chip) < 0) {
@@ -2110,29 +2203,29 @@
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
 
@@ -2190,6 +2283,8 @@
 
 	found = 0;
 
+	snd_printdd("cs4231: XXX\n");
+
 #ifdef SBUS_SUPPORT
 	for_all_sbusdev(sdev, sbus) {
 		if (!strcmp(sdev->prom_name, "SUNW,CS4231")) {

--zYM0uCDKw75PZbzx--
