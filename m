From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 09 Mar 2006 21:40:39 +0000
Subject: Re: ESP busted
Message-Id: <20060309.134039.70470377.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060309.131637.114886710.davem@davemloft.net>
In-Reply-To: <20060309.131637.114886710.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 09 Mar 2006 13:27:07 -0800 (PST)

> But I definitely can reproduce it with gcc-3.3.x:
> gcc-3.3 (GCC) 3.3.6 (Debian 1:3.3.6-10)
> 
> I'll see what I can do...

Josh, new patch, let me know if this makes ESP work
better for you.

I'm a little concerned, because this means gcc-3.3.x
is doing this lack of inlining for the entire sparc64
kernel, not just the ESP driver.

We might have to add some -finline-limit options back
onto the CFLAGS for gcc-3.3.x and previous on sparc64.

--- drivers/scsi/esp.c.~1~	2006-03-08 20:44:46.000000000 -0800
+++ drivers/scsi/esp.c	2006-03-09 13:36:58.000000000 -0800
@@ -1433,7 +1433,7 @@
 	return esp_host_info(esp, buffer, offset, length);
 }
 
-static void esp_get_dmabufs(struct esp *esp, struct scsi_cmnd *sp)
+static inline void esp_get_dmabufs(struct esp *esp, struct scsi_cmnd *sp)
 {
 	if (sp->use_sg = 0) {
 		sp->SCp.this_residual = sp->request_bufflen;
@@ -1458,7 +1458,7 @@
 	}
 }
 
-static void esp_release_dmabufs(struct esp *esp, struct scsi_cmnd *sp)
+static inline void esp_release_dmabufs(struct esp *esp, struct scsi_cmnd *sp)
 {
 	if (sp->use_sg) {
 		sbus_unmap_sg(esp->sdev, sp->buffer, sp->use_sg,
@@ -1471,7 +1471,7 @@
 	}
 }
 
-static void esp_restore_pointers(struct esp *esp, struct scsi_cmnd *sp)
+static inline void esp_restore_pointers(struct esp *esp, struct scsi_cmnd *sp)
 {
 	struct esp_pointers *ep = &esp->data_pointers[sp->device->id];
 
@@ -1481,7 +1481,7 @@
 	sp->SCp.buffers_residual = ep->saved_buffers_residual;
 }
 
-static void esp_save_pointers(struct esp *esp, struct scsi_cmnd *sp)
+static inline void esp_save_pointers(struct esp *esp, struct scsi_cmnd *sp)
 {
 	struct esp_pointers *ep = &esp->data_pointers[sp->device->id];
 
@@ -2013,7 +2013,7 @@
  * is to clean out the command queues and begin re-execution
  * of SCSI commands once more.
  */
-static int esp_finish_reset(struct esp *esp)
+static inline int esp_finish_reset(struct esp *esp)
 {
 	struct scsi_cmnd *sp = esp->current_SC;
 
@@ -2050,7 +2050,7 @@
 	return do_intr_end;
 }
 
-static int esp_do_resetbus(struct esp *esp)
+static inline int esp_do_resetbus(struct esp *esp)
 {
 	ESPLOG(("esp%d: Resetting scsi bus\n", esp->esp_id));
 	esp->resetting_bus = 1;
@@ -2078,7 +2078,7 @@
 }
 
 /* Internal ESP done function. */
-static void esp_done(struct esp *esp, int error)
+static inline void esp_done(struct esp *esp, int error)
 {
 	struct scsi_cmnd *done_SC = esp->current_SC;
 
@@ -2105,7 +2105,6 @@
 static int esp_do_msgin(struct esp *esp);
 static int esp_do_msgindone(struct esp *esp);
 static int esp_do_msgout(struct esp *esp);
-static int esp_do_cmdbegin(struct esp *esp);
 
 #define sreg_datainp(__sreg)  (((__sreg) & ESP_STAT_PMASK) = ESP_DIP)
 #define sreg_dataoutp(__sreg) (((__sreg) & ESP_STAT_PMASK) = ESP_DOP)
@@ -2803,7 +2802,7 @@
  * a tape, we don't want to go into a loop re-negotiating
  * synchronous capabilities over and over.
  */
-static int esp_should_clear_sync(struct scsi_cmnd *sp)
+static inline int esp_should_clear_sync(struct scsi_cmnd *sp)
 {
 	u8 cmd1 = sp->cmnd[0];
 	u8 cmd2 = sp->data_cmnd[0];
@@ -3109,7 +3108,7 @@
 	}
 }
 
-static int esp_enter_status(struct esp *esp)
+static inline int esp_enter_status(struct esp *esp)
 {
 	u8 thecmd = ESP_CMD_ICCSEQ;
 
@@ -3178,44 +3177,63 @@
 	return do_intr_end;
 }
 
-static int esp_enter_msgout(struct esp *esp)
+static inline int esp_do_cmdbegin(struct esp *esp)
+{
+	struct scsi_cmnd *SCptr = esp->current_SC;
+
+	esp_advance_phase(SCptr, in_cmdend);
+	if (esp->erev = fashme) {
+		u32 tmp = sbus_readl(esp->dregs + DMA_CSR);
+		int i;
+
+		for (i = 0; i < esp->esp_scmdleft; i++)
+			esp->esp_command[i] = *esp->esp_scmdp++;
+		esp->esp_scmdleft = 0;
+		esp_cmd(esp, ESP_CMD_FLUSH);
+		esp_setcount(esp->eregs, i, 1);
+		esp_cmd(esp, (ESP_CMD_DMA | ESP_CMD_TI));
+		tmp |= (DMA_SCSI_DISAB | DMA_ENABLE);
+		tmp &= ~(DMA_ST_WRITE);
+		sbus_writel(i, esp->dregs + DMA_COUNT);
+		sbus_writel(esp->esp_command_dvma, esp->dregs + DMA_ADDR);
+		sbus_writel(tmp, esp->dregs + DMA_CSR);
+	} else {
+		u8 tmp;
+
+		esp_cmd(esp, ESP_CMD_FLUSH);
+		tmp = *esp->esp_scmdp++;
+		esp->esp_scmdleft--;
+		sbus_writeb(tmp, esp->eregs + ESP_FDATA);
+		esp_cmd(esp, ESP_CMD_TI);
+	}
+	return do_intr_end;
+}
+
+static inline int esp_enter_msgout(struct esp *esp)
 {
 	esp_advance_phase(esp->current_SC, in_msgout);
 	return esp_do_msgout(esp);
 }
 
-static int esp_enter_msgin(struct esp *esp)
+static inline int esp_enter_msgin(struct esp *esp)
 {
 	esp_advance_phase(esp->current_SC, in_msgin);
 	return esp_do_msgin(esp);
 }
 
-static int esp_enter_cmd(struct esp *esp)
+static inline int esp_enter_cmd(struct esp *esp)
 {
 	esp_advance_phase(esp->current_SC, in_cmdbegin);
 	return esp_do_cmdbegin(esp);
 }
 
-static int esp_enter_badphase(struct esp *esp)
+static inline int esp_enter_badphase(struct esp *esp)
 {
 	ESPLOG(("esp%d: Bizarre bus phase %2x.\n", esp->esp_id,
 		esp->sreg & ESP_STAT_PMASK));
 	return do_reset_bus;
 }
 
-typedef int (*espfunc_t)(struct esp *);
-
-static espfunc_t phase_vector[] = {
-	esp_do_data,		/* ESP_DOP */
-	esp_do_data,		/* ESP_DIP */
-	esp_enter_cmd,		/* ESP_CMDP */
-	esp_enter_status,	/* ESP_STATP */
-	esp_enter_badphase,	/* ESP_STAT_PMSG */
-	esp_enter_badphase,	/* ESP_STAT_PMSG | ESP_STAT_PIO */
-	esp_enter_msgout,	/* ESP_MOP */
-	esp_enter_msgin,	/* ESP_MIP */
-};
-
 /* The target has control of the bus and we have to see where it has
  * taken us.
  */
@@ -3223,7 +3241,25 @@
 {
 	if ((esp->ireg & ESP_INTR_DC) != 0)
 		return esp_disconnect_amidst_phases(esp);
-	return phase_vector[esp->sreg & ESP_STAT_PMASK](esp);
+
+	switch (esp->sreg & ESP_STAT_PMASK) {
+	case ESP_DOP:
+		return esp_do_data(esp);
+	case ESP_DIP:
+		return esp_do_data(esp);
+	case ESP_CMDP:
+		return esp_enter_cmd(esp);
+	case ESP_STATP:
+		return esp_enter_status(esp);
+	case ESP_STAT_PMSG:
+	case ESP_STAT_PMSG | ESP_STAT_PIO:
+	default:
+		return esp_enter_badphase(esp);
+	case ESP_MOP:
+		return esp_enter_msgout(esp);
+	case ESP_MIP:
+		return esp_enter_msgin(esp);
+	};
 }
 
 /* First interrupt after exec'ing a cmd comes here. */
@@ -3482,7 +3518,7 @@
 }
 
 /* Continue reading bytes for msgin phase. */
-static int esp_do_msgincont(struct esp *esp)
+static inline int esp_do_msgincont(struct esp *esp)
 {
 	if (esp->ireg & ESP_INTR_BSERV) {
 		/* in the right phase too? */
@@ -3584,9 +3620,9 @@
  * the SCSI2 standard specifically recommends against targets doing
  * this because so many initiators cannot cope with this occurring.
  */
-static int target_with_ants_in_pants(struct esp *esp,
-				     struct scsi_cmnd *SCptr,
-				     struct esp_device *esp_dev)
+static inline int target_with_ants_in_pants(struct esp *esp,
+					    struct scsi_cmnd *SCptr,
+					    struct esp_device *esp_dev)
 {
 	if (esp_dev->sync || SCptr->device->borken) {
 		/* sorry, no can do */
@@ -3905,39 +3941,7 @@
 	return do_intr_end;
 }
 
-static int esp_do_cmdbegin(struct esp *esp)
-{
-	struct scsi_cmnd *SCptr = esp->current_SC;
-
-	esp_advance_phase(SCptr, in_cmdend);
-	if (esp->erev = fashme) {
-		u32 tmp = sbus_readl(esp->dregs + DMA_CSR);
-		int i;
-
-		for (i = 0; i < esp->esp_scmdleft; i++)
-			esp->esp_command[i] = *esp->esp_scmdp++;
-		esp->esp_scmdleft = 0;
-		esp_cmd(esp, ESP_CMD_FLUSH);
-		esp_setcount(esp->eregs, i, 1);
-		esp_cmd(esp, (ESP_CMD_DMA | ESP_CMD_TI));
-		tmp |= (DMA_SCSI_DISAB | DMA_ENABLE);
-		tmp &= ~(DMA_ST_WRITE);
-		sbus_writel(i, esp->dregs + DMA_COUNT);
-		sbus_writel(esp->esp_command_dvma, esp->dregs + DMA_ADDR);
-		sbus_writel(tmp, esp->dregs + DMA_CSR);
-	} else {
-		u8 tmp;
-
-		esp_cmd(esp, ESP_CMD_FLUSH);
-		tmp = *esp->esp_scmdp++;
-		esp->esp_scmdleft--;
-		sbus_writeb(tmp, esp->eregs + ESP_FDATA);
-		esp_cmd(esp, ESP_CMD_TI);
-	}
-	return do_intr_end;
-}
-
-static int esp_do_cmddone(struct esp *esp)
+static inline int esp_do_cmddone(struct esp *esp)
 {
 	if (esp->erev = fashme)
 		dma_invalidate(esp);
@@ -4036,7 +4040,7 @@
 	return do_intr_end;
 }
 
-static int esp_do_msgoutdone(struct esp *esp)
+static inline int esp_do_msgoutdone(struct esp *esp)
 {
 	if (esp->msgout_len > 1) {
 		/* XXX HME/FAS ATN deassert workaround required,
@@ -4099,34 +4103,15 @@
 	return esp_do_phase_determine(esp);
 }
 
-static int esp_bus_unexpected(struct esp *esp)
+static inline int esp_bus_unexpected(struct esp *esp)
 {
 	ESPLOG(("esp%d: command in weird state %2x\n",
 		esp->esp_id, esp->current_SC->SCp.phase));
 	return do_reset_bus;
 }
 
-static espfunc_t bus_vector[] = {
-	esp_do_data_finale,
-	esp_do_data_finale,
-	esp_bus_unexpected,
-	esp_do_msgin,
-	esp_do_msgincont,
-	esp_do_msgindone,
-	esp_do_msgout,
-	esp_do_msgoutdone,
-	esp_do_cmdbegin,
-	esp_do_cmddone,
-	esp_do_status,
-	esp_do_freebus,
-	esp_do_phase_determine,
-	esp_bus_unexpected,
-	esp_bus_unexpected,
-	esp_bus_unexpected,
-};
-
 /* This is the second tier in our dual-level SCSI state machine. */
-static int esp_work_bus(struct esp *esp)
+static inline int esp_work_bus(struct esp *esp)
 {
 	struct scsi_cmnd *SCptr = esp->current_SC;
 	unsigned int phase;
@@ -4137,24 +4122,45 @@
 		return esp_do_reconnect(esp);
 	}
 	phase = SCptr->SCp.phase;
-	if ((phase & 0xf0) = in_phases_mask)
-		return bus_vector[(phase & 0x0f)](esp);
-	else if ((phase & 0xf0) = in_slct_mask)
+	if ((phase & 0xf0) = in_phases_mask) {
+		switch (phase) {
+		case in_datain:
+			return esp_do_data_finale(esp);
+		case in_dataout:
+			return esp_do_data_finale(esp);
+		case in_data_done:
+			return esp_bus_unexpected(esp);
+		case in_msgin:
+			return esp_do_msgin(esp);
+		case in_msgincont:
+			return esp_do_msgincont(esp);
+		case in_msgindone:
+			return esp_do_msgindone(esp);
+		case in_msgout:
+			return esp_do_msgout(esp);
+		case in_msgoutdone:
+			return esp_do_msgoutdone(esp);
+		case in_cmdbegin:
+			return esp_do_cmdbegin(esp);
+		case in_cmdend:
+			return esp_do_cmddone(esp);
+		case in_status:
+			return esp_do_status(esp);
+		case in_freeing:
+			return esp_do_freebus(esp);
+		case in_the_dark:
+			return esp_do_phase_determine(esp);
+		default:
+			return esp_bus_unexpected(esp);
+		};
+	} else if ((phase & 0xf0) = in_slct_mask)
 		return esp_select_complete(esp);
 	else
 		return esp_bus_unexpected(esp);
 }
 
-static espfunc_t isvc_vector[] = {
-	NULL,
-	esp_do_phase_determine,
-	esp_do_resetbus,
-	esp_finish_reset,
-	esp_work_bus
-};
-
 /* Main interrupt handler for an esp adapter. */
-static void esp_handle(struct esp *esp)
+static inline void esp_handle(struct esp *esp)
 {
 	struct scsi_cmnd *SCptr;
 	int what_next = do_intr_end;
@@ -4323,15 +4329,27 @@
 	/* This is tier-one in our dual level SCSI state machine. */
 state_machine:
 	while (what_next != do_intr_end) {
-		if (what_next >= do_phase_determine &&
-		    what_next < do_intr_end) {
-			what_next = isvc_vector[what_next](esp);
-		} else {
+		switch (what_next) {
+		case do_phase_determine:
+			what_next = esp_do_phase_determine(esp);
+			break;
+		case do_reset_bus:
+			what_next = esp_do_resetbus(esp);
+			break;
+		case do_reset_complete:
+			what_next = esp_finish_reset(esp);
+			break;
+		case do_work_bus:
+			what_next = esp_work_bus(esp);
+			break;
+
+		default:
 			/* state is completely lost ;-( */
-			ESPLOG(("esp%d: interrupt engine loses state, resetting bus\n",
-				esp->esp_id));
+			ESPLOG(("esp%d: interrupt engine loses state, "
+				"resetting bus\n", esp->esp_id));
 			what_next = do_reset_bus;
-		}
+			break;
+		};
 	}
 }
 
