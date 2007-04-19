From: David Miller <davem@davemloft.net>
Date: Thu, 19 Apr 2007 07:32:21 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070419.003221.13771585.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Adam Kropelin" <akropel1@rochester.rr.com>
Date: Mon, 16 Apr 2007 23:35:56 -0400

> David Miller wrote:
> > From: "Adam Kropelin" <akropel1@rochester.rr.com>
> > Date: Mon, 16 Apr 2007 18:58:39 -0400
> >
> >> Starting smartd: esp: esp0: Aborting command [fffff80030b05280:2a]
> >> esp: esp0: Active command [fffff80030b05280:2a]
> >> esp: esp0: Aborting command [fffff80030b05280:00]
> >> esp: esp0: Queued command [fffff80030b05280:00]
> >> esp: esp0: Aborting command [fffff80030b05280:00]
> >> esp: esp0: Queued command [fffff80030b05280:00]
> >
> > Let's see what the heck smartd is sending to the device.  Please
> > reboot with smartd enabled and post the logs that get output
> > from this patch below applied, thanks.
> 
> Here it is:
> 
> Starting smartd:
 ...

Ok I think I nailed this.

I converted the ESP driver over to using auto-requestsense
when CHECK_CONDITION occurs for a scsi command.

The new ESP driver now passes my dbench+smartd-loop stress
test.

Let me know if you have some trouble with this patch.

Thanks in advance for testing!

diff --git a/drivers/scsi/esp.c b/drivers/scsi/esp.c
index 2d96fba..fd5548f 100644
--- a/drivers/scsi/esp.c
+++ b/drivers/scsi/esp.c
@@ -47,7 +47,7 @@ static u32 esp_debug;
 #define ESP_DEBUG_DATASTART	0x00000080
 #define ESP_DEBUG_DATADONE	0x00000100
 #define ESP_DEBUG_RECONNECT	0x00000200
-#define ESP_DEBUG_SENSE		0x00000400
+#define ESP_DEBUG_AUTOSENSE	0x00000400
 
 #define esp_log_intr(f, a...) \
 do {	if (esp_debug & ESP_DEBUG_INTR) \
@@ -94,8 +94,8 @@ do {	if (esp_debug & ESP_DEBUG_RECONNECT) \
 		printk(f, ## a); \
 } while (0)
 
-#define esp_log_sense(f, a...) \
-do {	if (esp_debug & ESP_DEBUG_SENSE) \
+#define esp_log_autosense(f, a...) \
+do {	if (esp_debug & ESP_DEBUG_AUTOSENSE) \
 		printk(f, ## a); \
 } while (0)
 
@@ -537,10 +537,15 @@ static void esp_map_dma(struct esp *esp, struct scsi_cmnd *cmd)
 	}
 }
 
-static dma_addr_t esp_cur_dma_addr(struct scsi_cmnd *cmd)
+static dma_addr_t esp_cur_dma_addr(struct esp_cmd_entry *ent,
+				   struct scsi_cmnd *cmd)
 {
 	struct esp_cmd_priv *p = ESP_CMD_PRIV(cmd);
 
+	if (ent->flags & ESP_CMD_FLAG_AUTOSENSE) {
+		return ent->sense_dma +
+			(ent->sense_ptr - cmd->sense_buffer);
+	}
 	if (p->mapping_type = MAPPING_TYPE_SINGLE) {
 		return p->u.dma_addr +
 			(cmd->request_bufflen -
@@ -553,18 +558,28 @@ static dma_addr_t esp_cur_dma_addr(struct scsi_cmnd *cmd)
 	}
 }
 
-static unsigned int esp_cur_dma_len(struct scsi_cmnd *cmd)
+static unsigned int esp_cur_dma_len(struct esp_cmd_entry *ent,
+				    struct scsi_cmnd *cmd)
 {
 	struct esp_cmd_priv *p = ESP_CMD_PRIV(cmd);
 
+	if (ent->flags & ESP_CMD_FLAG_AUTOSENSE) {
+		return SCSI_SENSE_BUFFERSIZE -
+			(ent->sense_ptr - cmd->sense_buffer);
+	}
 	return p->cur_residue;
 }
 
-static void esp_advance_dma(struct esp *esp, struct scsi_cmnd *cmd,
-			    unsigned int len)
+static void esp_advance_dma(struct esp *esp, struct esp_cmd_entry *ent,
+			    struct scsi_cmnd *cmd, unsigned int len)
 {
 	struct esp_cmd_priv *p = ESP_CMD_PRIV(cmd);
 
+	if (ent->flags & ESP_CMD_FLAG_AUTOSENSE) {
+		ent->sense_ptr += len;
+		return;
+	}
+
 	p->cur_residue -= len;
 	p->tot_residue -= len;
 	if (p->cur_residue < 0 || p->tot_residue < 0) {
@@ -612,6 +627,10 @@ static void esp_save_pointers(struct esp *esp, struct esp_cmd_entry *ent)
 	struct scsi_cmnd *cmd = ent->cmd;
 	struct esp_cmd_priv *spriv = ESP_CMD_PRIV(cmd);
 
+	if (ent->flags & ESP_CMD_FLAG_AUTOSENSE) {
+		ent->saved_sense_ptr = ent->sense_ptr;
+		return;
+	}
 	ent->saved_cur_residue = spriv->cur_residue;
 	ent->saved_cur_sg = spriv->cur_sg;
 	ent->saved_tot_residue = spriv->tot_residue;
@@ -622,6 +641,10 @@ static void esp_restore_pointers(struct esp *esp, struct esp_cmd_entry *ent)
 	struct scsi_cmnd *cmd = ent->cmd;
 	struct esp_cmd_priv *spriv = ESP_CMD_PRIV(cmd);
 
+	if (ent->flags & ESP_CMD_FLAG_AUTOSENSE) {
+		ent->sense_ptr = ent->saved_sense_ptr;
+		return;
+	}
 	spriv->cur_residue = ent->saved_cur_residue;
 	spriv->cur_sg = ent->saved_cur_sg;
 	spriv->tot_residue = ent->saved_tot_residue;
@@ -834,8 +857,7 @@ static int esp_alloc_lun_tag(struct esp_cmd_entry *ent,
 			 * the queue and run this untagged command.
 			 */
 			lp->hold = 0;
-		} else if (lp->num_tagged &&
-			   ent->cmd->cmnd[0] != REQUEST_SENSE) {
+		} else if (lp->num_tagged) {
 			/* Plug the queue until num_tagged decreases
 			 * to zero in esp_free_lun_tag.
 			 */
@@ -877,28 +899,67 @@ static void esp_free_lun_tag(struct esp_cmd_entry *ent,
 	}
 }
 
-static int force_nontagged(struct scsi_cmnd *cmd)
+/* When a contingent allegiance conditon is created, we force feed a
+ * REQUEST_SENSE command to the device to fetch the sense data.  I
+ * tried many other schemes, relying on the scsi error handling layer
+ * to send out the REQUEST_SENSE automatically, but this was difficult
+ * to get right especially in the presence of applications like smartd
+ * which use SG_IO to send out their own REQUEST_SENSE commands.
+ */
+static void esp_autosense(struct esp *esp, struct esp_cmd_entry *ent)
 {
-	/* Why force INQUIRY non-tagged?  The reason is that I've seen
-	 * some seagate drives do some weird things when they were
-	 * allowed to disconnect an INQUIRY command.  This particular
-	 * disk was configured for 16-bit wide transfers, it would
-	 * go to DATA phase, transfer 12 bytes of the INQUIRY response,
-	 * spit out an IGNORE_WIDE_RESIDUE message, disconnect, then
-	 * reconnect and send the whole INQUIRY response.  These INQUIRY
-	 * requests were generated by udev's "scsi_id" command.
-	 *
-	 * This probably accounts for the BLIST_NOTQ seagate entries in
-	 * scsi_devinfo.c, one of which states "Chokes on tagged INQUIRY".
-	 *
-	 * All of this is just silly and asking for trouble, so just do
-	 * INQUIRY commands non-tagged.
-	 */
-	if (cmd->cmnd[0] = REQUEST_SENSE ||
-	    cmd->cmnd[0] = INQUIRY)
-		return 1;
+	struct scsi_cmnd *cmd = ent->cmd;
+	struct scsi_device *dev = cmd->device;
+	int tgt, lun;
+	u8 *p, val;
 
-	return 0;
+	tgt = dev->id;
+	lun = dev->lun;
+
+
+	if (!ent->sense_ptr) {
+		esp_log_autosense("esp%d: Doing auto-sense for "
+				  "tgt[%d] lun[%d]\n",
+				  esp->host->unique_id, tgt, lun);
+
+		ent->sense_ptr = cmd->sense_buffer;
+		ent->sense_dma = sbus_map_single(esp->sbus_dev,
+						 ent->sense_ptr,
+						 SCSI_SENSE_BUFFERSIZE,
+						 DMA_FROM_DEVICE);
+	}
+	ent->saved_sense_ptr = ent->sense_ptr;
+
+	esp->active_cmd = ent;
+
+	p = esp->command_block;
+	esp->msg_out_len = 0;
+
+	*p++ = IDENTIFY(0, lun);
+	*p++ = REQUEST_SENSE;
+	*p++ = ((dev->scsi_level <= SCSI_2) ?
+		(lun << 5) : 0);
+	*p++ = 0;
+	*p++ = 0;
+	*p++ = SCSI_SENSE_BUFFERSIZE;
+	*p++ = 0;
+
+	esp->select_state = ESP_SELECT_BASIC;
+
+	val = tgt;
+	if (esp->rev = FASHME)
+		val |= ESP_BUSID_RESELID | ESP_BUSID_CTR32BIT;
+	esp_write8(val, ESP_BUSID);
+
+	esp_write_tgt_sync(esp, tgt);
+	esp_write_tgt_config3(esp, tgt);
+
+	val = (p - esp->command_block);
+
+	if (esp->rev = FASHME)
+		esp_cmd(esp, ESP_CMD_FLUSH);
+	esp_send_dma_command(esp, esp->command_block_dma,
+			     val, 16, 0, ESP_CMD_DMA | ESP_CMD_SELA);
 }
 
 static struct esp_cmd_entry *find_and_prep_issuable_command(struct esp *esp)
@@ -913,8 +974,13 @@ static struct esp_cmd_entry *find_and_prep_issuable_command(struct esp *esp)
 		int tgt = dev->id;
 		int lun = dev->lun;
 
-		if (force_nontagged(cmd) ||
-		    !scsi_populate_tag_msg(cmd, &ent->tag[0])) {
+		if (ent->flags & ESP_CMD_FLAG_AUTOSENSE) {
+			ent->tag[0] = 0;
+			ent->tag[1] = 0;
+			return ent;
+		}
+
+		if (!scsi_populate_tag_msg(cmd, &ent->tag[0])) {
 			ent->tag[0] = 0;
 			ent->tag[1] = 0;
 		}
@@ -949,6 +1015,11 @@ static void esp_maybe_execute_command(struct esp *esp)
 	if (!ent)
 		return;
 
+	if (ent->flags & ESP_CMD_FLAG_AUTOSENSE) {
+		esp_autosense(esp, ent);
+		return;
+	}
+
 	cmd = ent->cmd;
 	dev = cmd->device;
 	tgt = dev->id;
@@ -1112,23 +1183,32 @@ static void esp_cmd_is_done(struct esp *esp, struct esp_cmd_entry *ent,
 		ent->eh_done = NULL;
 	}
 
-	if (cmd->cmnd[0] = REQUEST_SENSE) {
-		unsigned char *buf;
-		int i;
+	if (ent->flags & ESP_CMD_FLAG_AUTOSENSE) {
+		sbus_unmap_single(esp->sbus_dev, ent->sense_dma,
+				  SCSI_SENSE_BUFFERSIZE, DMA_FROM_DEVICE);
+		ent->sense_ptr = NULL;
 
-		if (cmd->use_sg = 0)
-			buf = cmd->request_buffer;
-		else {
-			struct scatterlist *sg = cmd->request_buffer;
+		/* Restore the message/status bytes to what we actually
+		 * saw originally.  Also, report that we are providing
+		 * the sense data.
+		 */
+		cmd->result = ((DRIVER_SENSE << 24) |
+			       (DID_OK << 16) |
+			       (COMMAND_COMPLETE << 8) |
+			       (SAM_STAT_CHECK_CONDITION << 0));
 
-			buf = page_address(sg[0].page) + sg[0].offset;
-		}
+		ent->flags &= ~ESP_CMD_FLAG_AUTOSENSE;
+		if (esp_debug & ESP_DEBUG_AUTOSENSE) {
+			int i;
 
-		esp_log_sense("ESP: SENSE [ ");
-		for (i = 0; i < 18; i++)
-			esp_log_sense("%02x ", buf[i]);
-		esp_log_sense("]\n");
+			printk("esp%d: tgt[%d] lun[%d] AUTO SENSE[ ",
+			       esp->host->unique_id, tgt, lun);
+			for (i = 0; i < 18; i++)
+				printk("%02x ", cmd->sense_buffer[i]);
+			printk("]\n");
+		}
 	}
+
 	cmd->scsi_done(cmd);
 
 	list_del(&ent->list);
@@ -1490,12 +1570,19 @@ static int esp_finish_select(struct esp *esp)
 		 * resources (such as DMA mapping & TAG) and reset state (such
 		 * as message out and command delivery variables).
 		 */
-		esp_unmap_dma(esp, cmd);
-		esp_free_lun_tag(ent, tp->lun[cmd->device->lun]);
-		tp->flags &= ~(ESP_TGT_NEGO_SYNC | ESP_TGT_NEGO_WIDE);
-		esp->flags &= ~ESP_FLAG_DOING_SLOWCMD;
-		esp->cmd_bytes_ptr = NULL;
-		esp->cmd_bytes_left = 0;
+		if (!(ent->flags & ESP_CMD_FLAG_AUTOSENSE)) {
+			esp_unmap_dma(esp, cmd);
+			esp_free_lun_tag(ent, tp->lun[cmd->device->lun]);
+			tp->flags &= ~(ESP_TGT_NEGO_SYNC | ESP_TGT_NEGO_WIDE);
+			esp->flags &= ~ESP_FLAG_DOING_SLOWCMD;
+			esp->cmd_bytes_ptr = NULL;
+			esp->cmd_bytes_left = 0;
+		} else {
+			sbus_unmap_single(esp->sbus_dev, ent->sense_dma,
+					  SCSI_SENSE_BUFFERSIZE,
+					  DMA_FROM_DEVICE);
+			ent->sense_ptr = NULL;
+		}
 
 		/* Now that the state is unwound properly, put back onto
 		 * the issue queue.  This command is no longer active.
@@ -1947,8 +2034,8 @@ again:
 	case ESP_EVENT_DATA_OUT: {
 		struct esp_cmd_entry *ent = esp->active_cmd;
 		struct scsi_cmnd *cmd = ent->cmd;
-		dma_addr_t dma_addr = esp_cur_dma_addr(cmd);
-		unsigned int dma_len = esp_cur_dma_len(cmd);
+		dma_addr_t dma_addr = esp_cur_dma_addr(ent, cmd);
+		unsigned int dma_len = esp_cur_dma_len(ent, cmd);
 
 		if (esp->rev = ESP100)
 			esp_cmd(esp, ESP_CMD_NULL);
@@ -1966,7 +2053,8 @@ again:
 			       esp->host->unique_id);
 			printk(KERN_ERR PFX "esp%d: cur adr[%08x] len[%08x]\n",
 			       esp->host->unique_id,
-			       esp_cur_dma_addr(cmd), esp_cur_dma_len(cmd));
+			       esp_cur_dma_addr(ent, cmd),
+			       esp_cur_dma_len(ent, cmd));
 			esp_schedule_reset(esp);
 			return 0;
 		}
@@ -2020,7 +2108,7 @@ again:
 			return 0;
 		}
 
-		esp_advance_dma(esp, cmd, bytes_sent);
+		esp_advance_dma(esp, ent, cmd, bytes_sent);
 		esp_event(esp, ESP_EVENT_CHECK_PHASE);
 		goto again;
 		break;
@@ -2065,10 +2153,17 @@ again:
 					ent->status, ent->message);
 			if (ent->status = SAM_STAT_TASK_SET_FULL)
 				esp_event_queue_full(esp, ent);
-			esp_cmd_is_done(esp, ent, cmd,
-					compose_result(ent->status,
-						       ent->message,
-						       DID_OK));
+
+			if (ent->status = SAM_STAT_CHECK_CONDITION &&
+			    !(ent->flags & ESP_CMD_FLAG_AUTOSENSE)) {
+				ent->flags |= ESP_CMD_FLAG_AUTOSENSE;
+				esp_autosense(esp, ent);
+			} else {
+				esp_cmd_is_done(esp, ent, cmd,
+						compose_result(ent->status,
+							       ent->message,
+							       DID_OK));
+			}
 		} else if (ent->message = DISCONNECT) {
 			esp_log_disconnect("ESP: Disconnecting tgt[%d] "
 					   "tag[%x:%x]\n",
@@ -2236,6 +2331,13 @@ static void esp_reset_cleanup_one(struct esp *esp, struct esp_cmd_entry *ent)
 	esp_unmap_dma(esp, cmd);
 	esp_free_lun_tag(ent, esp->target[tgt].lun[lun]);
 	cmd->result = DID_RESET << 16;
+
+	if (ent->flags & ESP_CMD_FLAG_AUTOSENSE) {
+		sbus_unmap_single(esp->sbus_dev, ent->sense_dma,
+				  SCSI_SENSE_BUFFERSIZE, DMA_FROM_DEVICE);
+		ent->sense_ptr = NULL;
+	}
+
 	cmd->scsi_done(cmd);
 	list_del(&ent->list);
 	esp_put_ent(esp, ent);
@@ -3273,7 +3375,7 @@ MODULE_PARM_DESC(esp_debug,
 "	0x00000080	Log data start\n"
 "	0x00000100	Log data done\n"
 "	0x00000200	Log reconnects\n"
-"	0x00000400	Log sense data\n"
+"	0x00000400	Log auto-sense data\n"
 );
 
 module_init(esp_init);
diff --git a/drivers/scsi/esp.h b/drivers/scsi/esp.h
index bd3237d..3d18dfa 100644
--- a/drivers/scsi/esp.h
+++ b/drivers/scsi/esp.h
@@ -275,12 +275,17 @@ struct esp_cmd_entry {
 	u8			flags;
 #define ESP_CMD_FLAG_WRITE	0x01 /* DMA is a write */
 #define ESP_CMD_FLAG_ABORT	0x02 /* being aborted */
+#define ESP_CMD_FLAG_AUTOSENSE	0x04 /* Doing automatic REQUEST_SENSE */
 
 	u8			tag[2];
 
 	u8			status;
 	u8			message;
 
+	unsigned char		*sense_ptr;
+	unsigned char		*saved_sense_ptr;
+	dma_addr_t		sense_dma;
+
 	struct completion	*eh_done;
 };
 

