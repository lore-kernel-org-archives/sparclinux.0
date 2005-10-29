From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Sat, 29 Oct 2005 12:23:04 +0000
Subject: PATCH: cs4231 on SBus
Message-Id: <436369A8.1080107@triaton-webhosting.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030006030704080204000304"
List-Id: <sparclinux.vger.kernel.org>
References: <43527FA3.8090301@triaton-webhosting.com>
In-Reply-To: <43527FA3.8090301@triaton-webhosting.com>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------030006030704080204000304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch fixes some of the remaining issues
with cs4231 on SBus. Playback and capture
work fine now. In addition to the changes in the
patch I sent a few days ago, this patch also
includes a fix for a bug which led to rare
occurrences of a null pointer dereference,
noted and fixed by Christopher Zimmermann.

Not tested on EBus, could somebody please
give it a spin?

Regards
              Georg




--------------030006030704080204000304
Content-Type: text/plain;
 name="snd_cs4231.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="snd_cs4231.diff"

diff -r -U3 linux-2.6.14-rc5.orig/include/asm-sparc64/ebus.h linux-2.6.14-rc5/include/asm-sparc64/ebus.h
--- linux-2.6.14-rc5.orig/include/asm-sparc64/ebus.h	2005-10-20 08:23:05.000000000 +0200
+++ linux-2.6.14-rc5/include/asm-sparc64/ebus.h	2005-10-27 07:31:32.000000000 +0200
@@ -79,6 +79,7 @@
 			    size_t len);
 extern void ebus_dma_prepare(struct ebus_dma_info *p, int write);
 extern unsigned int ebus_dma_residue(struct ebus_dma_info *p);
+extern unsigned int ebus_dma_addr(struct ebus_dma_info *p);
 extern void ebus_dma_enable(struct ebus_dma_info *p, int on);
 
 extern struct linux_ebus		*ebus_chain;
diff -r -U3 linux-2.6.14-rc5.orig/sound/sparc/cs4231.c linux-2.6.14-rc5/sound/sparc/cs4231.c
--- linux-2.6.14-rc5.orig/sound/sparc/cs4231.c	2005-10-20 08:23:05.000000000 +0200
+++ linux-2.6.14-rc5/sound/sparc/cs4231.c	2005-10-27 07:30:11.000000000 +0200
@@ -61,13 +61,37 @@
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Sun,CS4231}}");
 
-typedef struct snd_cs4231 {
-	spinlock_t		lock;
-	void __iomem		*port;
+#ifdef SBUS_SUPPORT
+typedef struct sbus_dma_info {
+       spinlock_t      lock;
+       int             dir;
+       void __iomem    *regs;
+} sbus_dma_info_t;
+#endif
+
+typedef struct snd_cs4231 cs4231_t;
+
+typedef struct cs4231_dma_control {
+        void		(*prepare)(struct cs4231_dma_control *dma_cont, int dir);
+        void		(*enable)(struct cs4231_dma_control *dma_cont, int on);
+        int		(*request)(struct cs4231_dma_control *dma_cont, dma_addr_t bus_addr, size_t len);
+        unsigned int	(*address)(struct cs4231_dma_control *dma_cont);
+        void		(*reset)(cs4231_t *chip); 
+        void		(*preallocate)(cs4231_t *chip, snd_pcm_t *pcm); 
 #ifdef EBUS_SUPPORT
-	struct ebus_dma_info	eb2c;
-	struct ebus_dma_info	eb2p;
+	struct		ebus_dma_info	ebus_info;
+#endif
+#ifdef SBUS_SUPPORT
+	struct		sbus_dma_info	sbus_info;
 #endif
+} cs4231_dma_control_t;
+
+struct snd_cs4231 {
+	spinlock_t		lock;
+	void __iomem		*port;
+
+	cs4231_dma_control_t	p_dma;
+	cs4231_dma_control_t	c_dma;
 
 	u32			flags;
 #define CS4231_FLAG_EBUS	0x00000001
@@ -106,7 +130,7 @@
 	unsigned int		irq[2];
 	unsigned int		regs_size;
 	struct snd_cs4231	*next;
-} cs4231_t;
+};
 
 static cs4231_t *cs4231_list;
 
@@ -251,6 +275,15 @@
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
@@ -569,8 +602,7 @@
 	spin_unlock_irqrestore(&chip->lock, flags);
 }
 
-#ifdef EBUS_SUPPORT
-static void snd_cs4231_ebus_advance_dma(struct ebus_dma_info *p, snd_pcm_substream_t *substream, unsigned int *periods_sent)
+static void snd_cs4231_advance_dma(struct cs4231_dma_control *dma_cont, snd_pcm_substream_t *substream, unsigned int *periods_sent)
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
 
@@ -581,129 +613,41 @@
 		if (period_size >= (1 << 24))
 			BUG();
 
-		if (ebus_dma_request(p, runtime->dma_addr + offset, period_size))
+		if (dma_cont->request(dma_cont, runtime->dma_addr + offset, period_size))
 			return;
 		(*periods_sent) = ((*periods_sent) + 1) % runtime->periods;
 	}
 }
-#endif
-
-#ifdef SBUS_SUPPORT
-static void snd_cs4231_sbus_advance_dma(snd_pcm_substream_t *substream, unsigned int *periods_sent)
-{
-	cs4231_t *chip = snd_pcm_substream_chip(substream);
-	snd_pcm_runtime_t *runtime = substream->runtime;
-
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
-
-	(*periods_sent) = (*periods_sent + 1) % runtime->periods;
-}
-#endif
 
 static void cs4231_dma_trigger(snd_pcm_substream_t *substream, unsigned int what, int on)
 {
 	cs4231_t *chip = snd_pcm_substream_chip(substream);
+	cs4231_dma_control_t *dma_cont;
 
-#ifdef EBUS_SUPPORT
-	if (chip->flags & CS4231_FLAG_EBUS) {
-		if (what & CS4231_PLAYBACK_ENABLE) {
-			if (on) {
-				ebus_dma_prepare(&chip->eb2p, 0);
-				ebus_dma_enable(&chip->eb2p, 1);
-				snd_cs4231_ebus_advance_dma(&chip->eb2p,
-					chip->playback_substream,
-					&chip->p_periods_sent);
-			} else {
-				ebus_dma_enable(&chip->eb2p, 0);
-			}
-		}
-		if (what & CS4231_RECORD_ENABLE) {
-			if (on) {
-				ebus_dma_prepare(&chip->eb2c, 1);
-				ebus_dma_enable(&chip->eb2c, 1);
-				snd_cs4231_ebus_advance_dma(&chip->eb2c,
-					chip->capture_substream,
-					&chip->c_periods_sent);
-			} else {
-				ebus_dma_enable(&chip->eb2c, 0);
-			}
-		}
-	} else {
-#endif
-#ifdef SBUS_SUPPORT
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
+		dma_cont = &chip->p_dma;
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
+			dma_cont->prepare(dma_cont, 0);
+			dma_cont->enable(dma_cont, 1);
+			snd_cs4231_advance_dma(dma_cont,
+				chip->playback_substream,
+				&chip->p_periods_sent);
 		} else {
-			csr |= APC_PPAUSE;
-			sbus_writel(csr, chip->port + APCCSR);
-
-			csr &= ~APC_PDMA_READY;
-			sbus_writel(csr, chip->port + APCCSR);
+			dma_cont->enable(dma_cont, 0);
 		}
-		break;
-	case CS4231_RECORD_ENABLE:
+	}
+	if (what & CS4231_RECORD_ENABLE) {
+		dma_cont = &chip->c_dma;
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
+			dma_cont->prepare(dma_cont, 1);
+			dma_cont->enable(dma_cont, 1);
+			snd_cs4231_advance_dma(dma_cont,
+				chip->capture_substream,
+				&chip->c_periods_sent);
 		} else {
-			csr |= APC_CPAUSE;
-			sbus_writel(csr, chip->port + APCCSR);
-
-			csr &= ~APC_CDMA_READY;
-			sbus_writel(csr, chip->port + APCCSR);
+			dma_cont->enable(dma_cont, 0);
 		}
-		break;
-	}
-#endif
-#ifdef EBUS_SUPPORT
 	}
-#endif
 }
 
 static int snd_cs4231_trigger(snd_pcm_substream_t *substream, int cmd)
@@ -1136,10 +1080,7 @@
 	if (runtime->period_size > 0xffff + 1)
 		BUG();
 
-	snd_cs4231_out(chip, CS4231_PLY_LWR_CNT, (runtime->period_size - 1) & 0x00ff);
-	snd_cs4231_out(chip, CS4231_PLY_UPR_CNT, (runtime->period_size - 1) >> 8 & 0x00ff);
 	chip->p_periods_sent = 0;
-
 	spin_unlock_irqrestore(&chip->lock, flags);
 
 	return 0;
@@ -1171,16 +1112,14 @@
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
@@ -1199,134 +1138,55 @@
 		chip->capture_substream->runtime->overrange++;
 }
 
-static irqreturn_t snd_cs4231_generic_interrupt(cs4231_t *chip)
-{
-	unsigned long flags;
-	unsigned char status;
-
-	/*This is IRQ is not raised by the cs4231*/
-	if (!(__cs4231_readb(chip, CS4231P(chip, STATUS)) & CS4231_GLOBALIRQ))
-		return IRQ_NONE;
-
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
-	/* ACK the APC interrupt. */
-	u32 csr = sbus_readl(chip->port + APCCSR);
-
-	sbus_writel(csr, chip->port + APCCSR);
-
-	if ((chip->image[CS4231_IFACE_CTRL] & CS4231_PLAYBACK_ENABLE) &&
-	    (csr & APC_PLAY_INT) &&
-	    (csr & APC_XINT_PNVA) &&
-	    !(csr & APC_XINT_EMPT)) {
-		snd_cs4231_sbus_advance_dma(chip->playback_substream,
-					    &chip->p_periods_sent);
-		snd_pcm_period_elapsed(chip->playback_substream);
-	}
-
-	if ((chip->image[CS4231_IFACE_CTRL] & CS4231_RECORD_ENABLE) &&
-	    (csr & APC_CAPT_INT) &&
-	    (csr & APC_XINT_CNVA)) {
-		snd_cs4231_sbus_advance_dma(chip->capture_substream,
-					    &chip->c_periods_sent);
-		snd_pcm_period_elapsed(chip->capture_substream);
-	}
-
-	return snd_cs4231_generic_interrupt(chip);
-}
-#endif
-
-#ifdef EBUS_SUPPORT
-static void snd_cs4231_ebus_play_callback(struct ebus_dma_info *p, int event, void *cookie)
+static void snd_cs4231_play_callback(cs4231_t *cookie)
 {
 	cs4231_t *chip = cookie;
 
 	if (chip->image[CS4231_IFACE_CTRL] & CS4231_PLAYBACK_ENABLE) {
 		snd_pcm_period_elapsed(chip->playback_substream);
-		snd_cs4231_ebus_advance_dma(p, chip->playback_substream,
+		snd_cs4231_advance_dma(&chip->p_dma, chip->playback_substream,
 					    &chip->p_periods_sent);
 	}
 }
 
-static void snd_cs4231_ebus_capture_callback(struct ebus_dma_info *p, int event, void *cookie)
+static void snd_cs4231_capture_callback(cs4231_t *cookie)
 {
 	cs4231_t *chip = cookie;
 
 	if (chip->image[CS4231_IFACE_CTRL] & CS4231_RECORD_ENABLE) {
 		snd_pcm_period_elapsed(chip->capture_substream);
-		snd_cs4231_ebus_advance_dma(p, chip->capture_substream,
+		snd_cs4231_advance_dma(&chip->c_dma, chip->capture_substream,
 					    &chip->c_periods_sent);
 	}
 }
-#endif
 
 static snd_pcm_uframes_t snd_cs4231_playback_pointer(snd_pcm_substream_t *substream)
 {
 	cs4231_t *chip = snd_pcm_substream_chip(substream);
-	size_t ptr, residue, period_bytes;
-
+	cs4231_dma_control_t *dma_cont = &chip->p_dma;
+	size_t ptr;
+	
 	if (!(chip->image[CS4231_IFACE_CTRL] & CS4231_PLAYBACK_ENABLE))
 		return 0;
-	period_bytes = snd_pcm_lib_period_bytes(substream);
-	ptr = period_bytes * chip->p_periods_sent;
-#ifdef EBUS_SUPPORT
-	if (chip->flags & CS4231_FLAG_EBUS) {
-		residue = ebus_dma_residue(&chip->eb2p);
-	} else {
-#endif
-#ifdef SBUS_SUPPORT
-		residue = sbus_readl(chip->port + APCPC);
-#endif
-#ifdef EBUS_SUPPORT
-	}
-#endif
-	ptr += period_bytes - residue;
-
+	ptr = dma_cont->address(dma_cont);
+	if (ptr != 0)
+		ptr -= substream->runtime->dma_addr;
+	
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
 static snd_pcm_uframes_t snd_cs4231_capture_pointer(snd_pcm_substream_t * substream)
 {
 	cs4231_t *chip = snd_pcm_substream_chip(substream);
-	size_t ptr, residue, period_bytes;
+	cs4231_dma_control_t *dma_cont = &chip->c_dma;
+	size_t ptr;
 	
 	if (!(chip->image[CS4231_IFACE_CTRL] & CS4231_RECORD_ENABLE))
 		return 0;
-	period_bytes = snd_pcm_lib_period_bytes(substream);
-	ptr = period_bytes * chip->c_periods_sent;
-#ifdef EBUS_SUPPORT
-	if (chip->flags & CS4231_FLAG_EBUS) {
-		residue = ebus_dma_residue(&chip->eb2c);
-	} else {
-#endif
-#ifdef SBUS_SUPPORT
-		residue = sbus_readl(chip->port + APCCC);
-#endif
-#ifdef EBUS_SUPPORT
-	}
-#endif
-	ptr += period_bytes - residue;
+	ptr = dma_cont->address(dma_cont);
+	if (ptr != 0)
+		ptr -= substream->runtime->dma_addr;
+	
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
@@ -1362,30 +1222,8 @@
 	spin_lock_irqsave(&chip->lock, flags);
 
 
-	/* Reset DMA engine.  */
-#ifdef EBUS_SUPPORT
-	if (chip->flags & CS4231_FLAG_EBUS) {
-		/* Done by ebus_dma_register */
-	} else {
-#endif
-#ifdef SBUS_SUPPORT
-                sbus_writel(APC_CHIP_RESET, chip->port + APCCSR);
-                sbus_writel(0x00, chip->port + APCCSR);
-                sbus_writel(sbus_readl(chip->port + APCCSR) | APC_CDC_RESET,
-			    chip->port + APCCSR);
-  
-                udelay(20);
-  
-                sbus_writel(sbus_readl(chip->port + APCCSR) & ~APC_CDC_RESET,
-			    chip->port + APCCSR);
-                sbus_writel(sbus_readl(chip->port + APCCSR) | (APC_XINT_ENA |
-							       APC_XINT_PENA |
-							       APC_XINT_CENA),
-			    chip->port + APCCSR);
-#endif
-#ifdef EBUS_SUPPORT
-	}
-#endif
+	/* Reset DMA engine (sbus only).  */
+	chip->p_dma.reset(chip);
 
 	__cs4231_readb(chip, CS4231P(chip, STATUS));	/* clear any pendings IRQ */
 	__cs4231_writeb(chip, 0, CS4231P(chip, STATUS));
@@ -1505,8 +1343,8 @@
 {
 	cs4231_t *chip = snd_pcm_substream_chip(substream);
 
-	chip->playback_substream = NULL;
 	snd_cs4231_close(chip, CS4231_MODE_PLAY);
+	chip->playback_substream = NULL;
 
 	return 0;
 }
@@ -1515,8 +1353,8 @@
 {
 	cs4231_t *chip = snd_pcm_substream_chip(substream);
 
-	chip->capture_substream = NULL;
 	snd_cs4231_close(chip, CS4231_MODE_RECORD);
+	chip->capture_substream = NULL;
 
 	return 0;
 }
@@ -1571,21 +1409,7 @@
 	pcm->info_flags = SNDRV_PCM_INFO_JOINT_DUPLEX;
 	strcpy(pcm->name, "CS4231");
 
-#ifdef EBUS_SUPPORT
-	if (chip->flags & CS4231_FLAG_EBUS) {
-		snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-						      snd_dma_pci_data(chip->dev_u.pdev),
-						      64*1024, 128*1024);
-	} else {
-#endif
-#ifdef SBUS_SUPPORT
-		snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_SBUS,
-						      snd_dma_sbus_data(chip->dev_u.sdev),
-						      64*1024, 128*1024);
-#endif
-#ifdef EBUS_SUPPORT
-	}
-#endif
+	chip->p_dma.preallocate(chip, pcm);
 
 	chip->pcm = pcm;
 
@@ -1942,6 +1766,180 @@
 }
 
 #ifdef SBUS_SUPPORT
+
+static irqreturn_t snd_cs4231_sbus_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned long flags;
+	unsigned char status;
+	u32 csr;
+	cs4231_t *chip = dev_id;
+
+	/*This is IRQ is not raised by the cs4231*/
+	if (!(__cs4231_readb(chip, CS4231P(chip, STATUS)) & CS4231_GLOBALIRQ))
+		return IRQ_NONE;
+
+	/* ACK the APC interrupt. */
+	csr = sbus_readl(chip->port + APCCSR);
+
+	sbus_writel(csr, chip->port + APCCSR);
+
+	if ((csr & APC_PDMA_READY) && 
+ 	    (csr & APC_PLAY_INT) &&
+	    (csr & APC_XINT_PNVA) &&
+	    !(csr & APC_XINT_EMPT))
+			snd_cs4231_play_callback(chip);
+
+	if ((csr & APC_CDMA_READY) && 
+  	    (csr & APC_CAPT_INT) &&
+	    (csr & APC_XINT_CNVA) &&
+	    !(csr & APC_XINT_EMPT))
+			snd_cs4231_capture_callback(chip);
+	
+	status = snd_cs4231_in(chip, CS4231_IRQ_STATUS);
+
+	if (status & CS4231_TIMER_IRQ) {
+		if (chip->timer)
+			snd_timer_interrupt(chip->timer, chip->timer->sticks);
+	}		
+
+	if ((status & CS4231_RECORD_IRQ) && (csr & APC_CDMA_READY))
+		snd_cs4231_overrange(chip);
+
+	/* ACK the CS4231 interrupt. */
+	spin_lock_irqsave(&chip->lock, flags);
+	snd_cs4231_outm(chip, CS4231_IRQ_STATUS, ~CS4231_ALL_IRQS | ~status, 0);
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	return 0;
+}
+
+/*
+ * SBUS DMA routines
+ */
+
+int sbus_dma_request(struct cs4231_dma_control *dma_cont, dma_addr_t bus_addr, size_t len)
+{
+	unsigned long flags;
+	u32 test, csr;
+	int err;
+	sbus_dma_info_t *base = &dma_cont->sbus_info;
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
+void sbus_dma_prepare(struct cs4231_dma_control *dma_cont, int d)
+{
+	unsigned long flags;
+	u32 csr, test;
+	sbus_dma_info_t *base = &dma_cont->sbus_info;
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
+void sbus_dma_enable(struct cs4231_dma_control *dma_cont, int on)
+{
+	unsigned long flags;
+	u32 csr, shift;
+	sbus_dma_info_t *base = &dma_cont->sbus_info;
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
+	udelay(600); 
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
+unsigned int sbus_dma_addr(struct cs4231_dma_control *dma_cont)
+{
+	sbus_dma_info_t *base = &dma_cont->sbus_info;
+
+        return sbus_readl(base->regs + base->dir + APCVA);
+}
+
+void sbus_dma_reset(cs4231_t *chip)
+{
+        sbus_writel(APC_CHIP_RESET, chip->port + APCCSR);
+        sbus_writel(0x00, chip->port + APCCSR);
+        sbus_writel(sbus_readl(chip->port + APCCSR) | APC_CDC_RESET,
+		    chip->port + APCCSR);
+  
+        udelay(20);
+  
+        sbus_writel(sbus_readl(chip->port + APCCSR) & ~APC_CDC_RESET,
+		    chip->port + APCCSR);
+        sbus_writel(sbus_readl(chip->port + APCCSR) | (APC_XINT_ENA |
+		       APC_XINT_PENA |
+		       APC_XINT_CENA),
+	               chip->port + APCCSR);
+}
+
+void sbus_dma_preallocate(cs4231_t *chip, snd_pcm_t *pcm)
+{
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_SBUS,
+					      snd_dma_sbus_data(chip->dev_u.sdev),
+					      64*1024, 128*1024);
+}
+
+/*
+ * Init and exit routines
+ */
+
 static int snd_cs4231_sbus_free(cs4231_t *chip)
 {
 	if (chip->irq[0])
@@ -1983,6 +1981,8 @@
 		return -ENOMEM;
 
 	spin_lock_init(&chip->lock);
+	spin_lock_init(&chip->c_dma.sbus_info.lock);
+	spin_lock_init(&chip->p_dma.sbus_info.lock);
 	init_MUTEX(&chip->mce_mutex);
 	init_MUTEX(&chip->open_mutex);
 	chip->card = card;
@@ -1998,6 +1998,25 @@
 		return -EIO;
 	}
 
+	chip->c_dma.sbus_info.regs = chip->port;
+	chip->p_dma.sbus_info.regs = chip->port;
+	chip->c_dma.sbus_info.dir = APC_RECORD;
+	chip->p_dma.sbus_info.dir = APC_PLAY;
+
+	chip->p_dma.prepare = sbus_dma_prepare;
+	chip->p_dma.enable = sbus_dma_enable;
+	chip->p_dma.request = sbus_dma_request;
+	chip->p_dma.address = sbus_dma_addr;
+	chip->p_dma.reset = sbus_dma_reset;
+	chip->p_dma.preallocate = sbus_dma_preallocate;
+
+	chip->c_dma.prepare = sbus_dma_prepare;
+	chip->c_dma.enable = sbus_dma_enable;
+	chip->c_dma.request = sbus_dma_request;
+	chip->c_dma.address = sbus_dma_addr;
+	chip->c_dma.reset = sbus_dma_reset;
+	chip->c_dma.preallocate = sbus_dma_preallocate;
+
 	if (request_irq(sdev->irqs[0], snd_cs4231_sbus_interrupt,
 			SA_SHIRQ, "cs4231", chip)) {
 		snd_printdd("cs4231-%d: Unable to grab SBUS IRQ %s\n",
@@ -2051,15 +2070,70 @@
 #endif
 
 #ifdef EBUS_SUPPORT
+
+static void snd_cs4231_ebus_play_callback(struct ebus_dma_info *p, int event, void *cookie)
+{
+	cs4231_t *chip = cookie;
+	
+	snd_cs4231_play_callback(chip);
+}
+
+static void snd_cs4231_ebus_capture_callback(struct ebus_dma_info *p, int event, void *cookie)
+{
+	cs4231_t *chip = cookie;
+
+	snd_cs4231_capture_callback(chip);
+}
+
+/*
+ * EBUS DMA wrappers
+ */
+
+int _ebus_dma_request(struct cs4231_dma_control *dma_cont, dma_addr_t bus_addr, size_t len)
+{
+	return ebus_dma_request(&dma_cont->ebus_info, bus_addr, len);
+}
+
+void _ebus_dma_enable(struct cs4231_dma_control *dma_cont, int on)
+{
+	ebus_dma_enable(&dma_cont->ebus_info, on);
+}
+
+void _ebus_dma_prepare(struct cs4231_dma_control *dma_cont, int dir)
+{
+	ebus_dma_prepare(&dma_cont->ebus_info, dir);
+}
+
+unsigned int _ebus_dma_addr(struct cs4231_dma_control *dma_cont)
+{
+	return ebus_dma_addr(&dma_cont->ebus_info);
+}
+
+void _ebus_dma_reset(cs4231_t *chip)
+{
+	return;
+}
+
+void _ebus_dma_preallocate(cs4231_t *chip, snd_pcm_t *pcm)
+{
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+				      snd_dma_pci_data(chip->dev_u.pdev),
+				      64*1024, 128*1024);
+}
+
+/*
+ * Init and exit routines
+ */
+
 static int snd_cs4231_ebus_free(cs4231_t *chip)
 {
-	if (chip->eb2c.regs) {
-		ebus_dma_unregister(&chip->eb2c);
-		iounmap(chip->eb2c.regs);
-	}
-	if (chip->eb2p.regs) {
-		ebus_dma_unregister(&chip->eb2p);
-		iounmap(chip->eb2p.regs);
+	if (chip->c_dma.ebus_info.regs) {
+		ebus_dma_unregister(&chip->c_dma.ebus_info);
+		iounmap(chip->c_dma.ebus_info.regs);
+	}
+	if (chip->p_dma.ebus_info.regs) {
+		ebus_dma_unregister(&chip->p_dma.ebus_info);
+		iounmap(chip->p_dma.ebus_info.regs);
 	}
 
 	if (chip->port)
@@ -2097,8 +2171,8 @@
 		return -ENOMEM;
 
 	spin_lock_init(&chip->lock);
-	spin_lock_init(&chip->eb2c.lock);
-	spin_lock_init(&chip->eb2p.lock);
+	spin_lock_init(&chip->c_dma.ebus_info.lock);
+	spin_lock_init(&chip->p_dma.ebus_info.lock);
 	init_MUTEX(&chip->mce_mutex);
 	init_MUTEX(&chip->open_mutex);
 	chip->flags |= CS4231_FLAG_EBUS;
@@ -2106,43 +2180,57 @@
 	chip->dev_u.pdev = edev->bus->self;
 	memcpy(&chip->image, &snd_cs4231_original_image,
 	       sizeof(snd_cs4231_original_image));
-	strcpy(chip->eb2c.name, "cs4231(capture)");
-	chip->eb2c.flags = EBUS_DMA_FLAG_USE_EBDMA_HANDLER;
-	chip->eb2c.callback = snd_cs4231_ebus_capture_callback;
-	chip->eb2c.client_cookie = chip;
-	chip->eb2c.irq = edev->irqs[0];
-	strcpy(chip->eb2p.name, "cs4231(play)");
-	chip->eb2p.flags = EBUS_DMA_FLAG_USE_EBDMA_HANDLER;
-	chip->eb2p.callback = snd_cs4231_ebus_play_callback;
-	chip->eb2p.client_cookie = chip;
-	chip->eb2p.irq = edev->irqs[1];
+	strcpy(chip->c_dma.ebus_info.name, "cs4231(capture)");
+	chip->c_dma.ebus_info.flags = EBUS_DMA_FLAG_USE_EBDMA_HANDLER;
+	chip->c_dma.ebus_info.callback = snd_cs4231_ebus_capture_callback;
+	chip->c_dma.ebus_info.client_cookie = chip;
+	chip->c_dma.ebus_info.irq = edev->irqs[0];
+	strcpy(chip->p_dma.ebus_info.name, "cs4231(play)");
+	chip->p_dma.ebus_info.flags = EBUS_DMA_FLAG_USE_EBDMA_HANDLER;
+	chip->p_dma.ebus_info.callback = snd_cs4231_ebus_play_callback;
+	chip->p_dma.ebus_info.client_cookie = chip;
+	chip->p_dma.ebus_info.irq = edev->irqs[1];
+
+	chip->p_dma.prepare = _ebus_dma_prepare;
+	chip->p_dma.enable = _ebus_dma_enable;
+	chip->p_dma.request = _ebus_dma_request;
+	chip->p_dma.address = _ebus_dma_addr;
+	chip->p_dma.reset = _ebus_dma_reset;
+	chip->p_dma.preallocate = _ebus_dma_preallocate;
+
+	chip->c_dma.prepare = _ebus_dma_prepare;
+	chip->c_dma.enable = _ebus_dma_enable;
+	chip->c_dma.request = _ebus_dma_request;
+	chip->c_dma.address = _ebus_dma_addr;
+	chip->c_dma.reset = _ebus_dma_reset;
+	chip->c_dma.preallocate = _ebus_dma_preallocate;
 
 	chip->port = ioremap(edev->resource[0].start, 0x10);
-	chip->eb2p.regs = ioremap(edev->resource[1].start, 0x10);
-	chip->eb2c.regs = ioremap(edev->resource[2].start, 0x10);
-	if (!chip->port || !chip->eb2p.regs || !chip->eb2c.regs) {
+	chip->p_dma.ebus_info.regs = ioremap(edev->resource[1].start, 0x10);
+	chip->c_dma.ebus_info.regs = ioremap(edev->resource[2].start, 0x10);
+	if (!chip->port || !chip->p_dma.ebus_info.regs || !chip->c_dma.ebus_info.regs) {
 		snd_cs4231_ebus_free(chip);
 		snd_printdd("cs4231-%d: Unable to map chip registers.\n", dev);
 		return -EIO;
 	}
 
-	if (ebus_dma_register(&chip->eb2c)) {
+	if (ebus_dma_register(&chip->c_dma.ebus_info)) {
 		snd_cs4231_ebus_free(chip);
 		snd_printdd("cs4231-%d: Unable to register EBUS capture DMA\n", dev);
 		return -EBUSY;
 	}
-	if (ebus_dma_irq_enable(&chip->eb2c, 1)) {
+	if (ebus_dma_irq_enable(&chip->c_dma.ebus_info, 1)) {
 		snd_cs4231_ebus_free(chip);
 		snd_printdd("cs4231-%d: Unable to enable EBUS capture IRQ\n", dev);
 		return -EBUSY;
 	}
 
-	if (ebus_dma_register(&chip->eb2p)) {
+	if (ebus_dma_register(&chip->p_dma.ebus_info)) {
 		snd_cs4231_ebus_free(chip);
 		snd_printdd("cs4231-%d: Unable to register EBUS play DMA\n", dev);
 		return -EBUSY;
 	}
-	if (ebus_dma_irq_enable(&chip->eb2p, 1)) {
+	if (ebus_dma_irq_enable(&chip->p_dma.ebus_info, 1)) {
 		snd_cs4231_ebus_free(chip);
 		snd_printdd("cs4231-%d: Unable to enable EBUS play IRQ\n", dev);
 		return -EBUSY;

--------------030006030704080204000304--
