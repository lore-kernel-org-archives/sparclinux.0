From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Tue, 01 Jun 2004 16:47:32 +0000
Subject: Re: RFC: defining sbus dma direction bits in terms of enum
Message-Id: <1086108452.28671.53.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-FrSqGH+ku9/7dLOmi5IX"
List-Id: <sparclinux.vger.kernel.org>
References: <20040531124455.GA16822@lst.de>
In-Reply-To: <20040531124455.GA16822@lst.de>
To: sparclinux@vger.kernel.org


--=-FrSqGH+ku9/7dLOmi5IX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-05-31 at 14:44 +0200, Christoph Hellwig wrote:
> And while we're at it, if someone cares for the
> sbus scsi drivers:  any chance to convert them awaya from needing scsi.h
> and hosts.h in drivers/scsi/ to the <scsi/*.h> headers?  It's really
> just some boring decrufting, mostly killing obsolete typedefs.

Patch attached to move from old typedefs to modern ones, and stop using
the old headers. This covers esp & qlogicpti, and really isn't rocket
science, just boring decrufting.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora SPARC Linux Project Leader

"If you are going through hell, keep going."
- Sir Winston Churchill


--=-FrSqGH+ku9/7dLOmi5IX
Content-Disposition: attachment; filename=linux-2.6.7rc1-sbus_scsi_cleanup.patch
Content-Type: text/x-patch; name=linux-2.6.7rc1-sbus_scsi_cleanup.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.6/drivers/scsi/esp.c.BAD	2004-06-01 15:44:30.593920000 -0400
+++ linux-2.6.6/drivers/scsi/esp.c	2004-06-01 16:26:28.473920000 -0400
@@ -26,8 +26,6 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 
-#include "scsi.h"
-#include "hosts.h"
 #include "esp.h"
 
 #include <asm/sbus.h>
@@ -366,7 +364,7 @@
 }
 
 #ifdef DEBUG_STATE_MACHINE
-static inline void esp_advance_phase(Scsi_Cmnd *s, int newphase)
+static inline void esp_advance_phase(struct scsi_cmnd *s, int newphase)
 {
 	ESPLOG(("<%s>", phase_string(newphase)));
 	s->SCp.sent_command = s->SCp.phase;
@@ -419,48 +417,48 @@
  * Note that these are per-ESP queues, not global queues like
  * the aha152x driver uses.
  */
-static inline void append_SC(Scsi_Cmnd **SC, Scsi_Cmnd *new_SC)
+static inline void append_SC(struct scsi_cmnd **SC, struct scsi_cmnd *new_SC)
 {
-	Scsi_Cmnd *end;
+	struct scsi_cmnd *end;
 
 	new_SC->host_scribble = (unsigned char *) NULL;
 	if (!*SC)
 		*SC = new_SC;
 	else {
-		for (end=*SC;end->host_scribble;end=(Scsi_Cmnd *)end->host_scribble)
+		for (end=*SC;end->host_scribble;end=(struct scsi_cmnd *)end->host_scribble)
 			;
 		end->host_scribble = (unsigned char *) new_SC;
 	}
 }
 
-static inline void prepend_SC(Scsi_Cmnd **SC, Scsi_Cmnd *new_SC)
+static inline void prepend_SC(struct scsi_cmnd **SC, struct scsi_cmnd *new_SC)
 {
 	new_SC->host_scribble = (unsigned char *) *SC;
 	*SC = new_SC;
 }
 
-static inline Scsi_Cmnd *remove_first_SC(Scsi_Cmnd **SC)
+static inline struct scsi_cmnd *remove_first_SC(struct scsi_cmnd **SC)
 {
-	Scsi_Cmnd *ptr;
+	struct scsi_cmnd *ptr;
 	ptr = *SC;
 	if (ptr)
-		*SC = (Scsi_Cmnd *) (*SC)->host_scribble;
+		*SC = (struct scsi_cmnd *) (*SC)->host_scribble;
 	return ptr;
 }
 
-static inline Scsi_Cmnd *remove_SC(Scsi_Cmnd **SC, int target, int lun)
+static inline struct scsi_cmnd *remove_SC(struct scsi_cmnd **SC, int target, int lun)
 {
-	Scsi_Cmnd *ptr, *prev;
+	struct scsi_cmnd *ptr, *prev;
 
 	for (ptr = *SC, prev = NULL;
 	     ptr && ((ptr->device->id != target) || (ptr->device->lun != lun));
-	     prev = ptr, ptr = (Scsi_Cmnd *) ptr->host_scribble)
+	     prev = ptr, ptr = (struct scsi_cmnd *) ptr->host_scribble)
 		;
 	if (ptr) {
 		if (prev)
 			prev->host_scribble=ptr->host_scribble;
 		else
-			*SC=(Scsi_Cmnd *)ptr->host_scribble;
+			*SC=(struct scsi_cmnd *)ptr->host_scribble;
 	}
 	return ptr;
 }
@@ -1062,7 +1060,7 @@
 	esp->prev_hme_dmacsr = 0xffffffff;
 }
 
-static int __init detect_one_esp(Scsi_Host_Template *tpnt, struct sbus_dev *esp_dev,
+static int __init detect_one_esp(struct scsi_host_template *tpnt, struct sbus_dev *esp_dev,
 				 struct sbus_dev *espdma, struct sbus_bus *sbus,
 				 int id, int hme)
 {
@@ -1137,7 +1135,7 @@
 
 #include <asm/sun4paddr.h>
 
-static int __init esp_detect(Scsi_Host_Template *tpnt)
+static int __init esp_detect(struct scsi_host_template *tpnt)
 {
 	static struct sbus_dev esp_dev;
 	int esps_in_use = 0;
@@ -1162,7 +1160,7 @@
 
 #else /* !CONFIG_SUN4 */
 
-static int __init esp_detect(Scsi_Host_Template *tpnt)
+static int __init esp_detect(struct scsi_host_template *tpnt)
 {
 	struct sbus_bus *sbus;
 	struct sbus_dev *esp_dev, *sbdev_iter;
@@ -1428,7 +1426,7 @@
 	return esp_host_info(esp, buffer, offset, length);
 }
 
-static void esp_get_dmabufs(struct esp *esp, Scsi_Cmnd *sp)
+static void esp_get_dmabufs(struct esp *esp, struct scsi_cmnd *sp)
 {
 	if (sp->use_sg == 0) {
 		sp->SCp.this_residual = sp->request_bufflen;
@@ -1453,7 +1451,7 @@
 	}
 }
 
-static void esp_release_dmabufs(struct esp *esp, Scsi_Cmnd *sp)
+static void esp_release_dmabufs(struct esp *esp, struct scsi_cmnd *sp)
 {
 	if (sp->use_sg) {
 		sbus_unmap_sg(esp->sdev, sp->buffer, sp->use_sg,
@@ -1466,7 +1464,7 @@
 	}
 }
 
-static void esp_restore_pointers(struct esp *esp, Scsi_Cmnd *sp)
+static void esp_restore_pointers(struct esp *esp, struct scsi_cmnd *sp)
 {
 	struct esp_pointers *ep = &esp->data_pointers[sp->device->id];
 
@@ -1476,7 +1474,7 @@
 	sp->SCp.buffers_residual = ep->saved_buffers_residual;
 }
 
-static void esp_save_pointers(struct esp *esp, Scsi_Cmnd *sp)
+static void esp_save_pointers(struct esp *esp, struct scsi_cmnd *sp)
 {
 	struct esp_pointers *ep = &esp->data_pointers[sp->device->id];
 
@@ -1506,7 +1504,7 @@
  * case where we could see an interrupt is where we have disconnected
  * commands active and they are trying to reselect us.
  */
-static inline void esp_check_cmd(struct esp *esp, Scsi_Cmnd *sp)
+static inline void esp_check_cmd(struct esp *esp, struct scsi_cmnd *sp)
 {
 	switch (sp->cmd_len) {
 	case 6:
@@ -1557,8 +1555,8 @@
 
 static void esp_exec_cmd(struct esp *esp)
 {
-	Scsi_Cmnd *SCptr;
-	Scsi_Device *SDptr;
+	struct scsi_cmnd *SCptr;
+	struct scsi_device *SDptr;
 	struct esp_device *esp_dev;
 	volatile u8 *cmdp = esp->esp_command;
 	u8 the_esp_command;
@@ -1834,7 +1832,7 @@
 }
 
 /* Queue a SCSI command delivered from the mid-level Linux SCSI code. */
-static int esp_queue(Scsi_Cmnd *SCpnt, void (*done)(Scsi_Cmnd *))
+static int esp_queue(struct scsi_cmnd *SCpnt, void (*done)(struct scsi_cmnd *))
 {
 	struct esp *esp;
 
@@ -1871,7 +1869,7 @@
 }
 
 /* Dump driver state. */
-static void esp_dump_cmd(Scsi_Cmnd *SCptr)
+static void esp_dump_cmd(struct scsi_cmnd *SCptr)
 {
 	ESPLOG(("[tgt<%02x> lun<%02x> "
 		"pphase<%s> cphase<%s>]",
@@ -1882,7 +1880,7 @@
 
 static void esp_dump_state(struct esp *esp)
 {
-	Scsi_Cmnd *SCptr = esp->current_SC;
+	struct scsi_cmnd *SCptr = esp->current_SC;
 #ifdef DEBUG_ESP_CMDS
 	int i;
 #endif
@@ -1921,13 +1919,13 @@
 	ESPLOG(("esp%d: disconnected ", esp->esp_id));
 	while (SCptr) {
 		esp_dump_cmd(SCptr);
-		SCptr = (Scsi_Cmnd *) SCptr->host_scribble;
+		SCptr = (struct scsi_cmnd *) SCptr->host_scribble;
 	}
 	ESPLOG(("\n"));
 }
 
 /* Abort a command.  The host_lock is acquired by caller. */
-static int esp_abort(Scsi_Cmnd *SCptr)
+static int esp_abort(struct scsi_cmnd *SCptr)
 {
 	struct esp *esp = (struct esp *) SCptr->device->host->hostdata;
 	int don;
@@ -1957,14 +1955,14 @@
 		ESP_INTSOFF(esp->dregs);
 	}
 	if (esp->issue_SC) {
-		Scsi_Cmnd **prev, *this;
+		struct scsi_cmnd **prev, *this;
 		for (prev = (&esp->issue_SC), this = esp->issue_SC;
 		     this != NULL;
-		     prev = (Scsi_Cmnd **) &(this->host_scribble),
-			     this = (Scsi_Cmnd *) this->host_scribble) {
+		     prev = (struct scsi_cmnd **) &(this->host_scribble),
+			     this = (struct scsi_cmnd *) this->host_scribble) {
 
 			if (this == SCptr) {
-				*prev = (Scsi_Cmnd *) this->host_scribble;
+				*prev = (struct scsi_cmnd *) this->host_scribble;
 				this->host_scribble = NULL;
 
 				esp_release_dmabufs(esp, this);
@@ -2010,7 +2008,7 @@
  */
 static int esp_finish_reset(struct esp *esp)
 {
-	Scsi_Cmnd *sp = esp->current_SC;
+	struct scsi_cmnd *sp = esp->current_SC;
 
 	/* Clean up currently executing command, if any. */
 	if (sp != NULL) {
@@ -2059,7 +2057,7 @@
  *
  * The host_lock is acquired by caller.
  */
-static int esp_reset(Scsi_Cmnd *SCptr)
+static int esp_reset(struct scsi_cmnd *SCptr)
 {
 	struct esp *esp = (struct esp *) SCptr->device->host->hostdata;
 
@@ -2077,7 +2075,7 @@
 /* Internal ESP done function. */
 static void esp_done(struct esp *esp, int error)
 {
-	Scsi_Cmnd *done_SC = esp->current_SC;
+	struct scsi_cmnd *done_SC = esp->current_SC;
 
 	esp->current_SC = NULL;
 
@@ -2168,7 +2166,7 @@
 /* We try to avoid some interrupts by jumping ahead and see if the ESP
  * has gotten far enough yet.  Hence the following.
  */
-static inline int skipahead1(struct esp *esp, Scsi_Cmnd *scp,
+static inline int skipahead1(struct esp *esp, struct scsi_cmnd *scp,
 			     int prev_phase, int new_phase)
 {
 	if (scp->SCp.sent_command != prev_phase)
@@ -2202,7 +2200,7 @@
 	return do_intr_end;
 }
 
-static inline int skipahead2(struct esp *esp, Scsi_Cmnd *scp,
+static inline int skipahead2(struct esp *esp, struct scsi_cmnd *scp,
 			     int prev_phase1, int prev_phase2, int new_phase)
 {
 	if (scp->SCp.sent_command != prev_phase1 &&
@@ -2318,7 +2316,7 @@
 	dma_invalidate(esp);
 }
 
-static int dma_can_transfer(struct esp *esp, Scsi_Cmnd *sp)
+static int dma_can_transfer(struct esp *esp, struct scsi_cmnd *sp)
 {
 	__u32 base, end, sz;
 
@@ -2379,7 +2377,7 @@
  * tell the ESP to eat the extraneous byte so that we can proceed
  * to the next phase.
  */
-static int esp100_sync_hwbug(struct esp *esp, Scsi_Cmnd *sp, int fifocnt)
+static int esp100_sync_hwbug(struct esp *esp, struct scsi_cmnd *sp, int fifocnt)
 {
 	/* Do not touch this piece of code. */
 	if ((!(esp->erev == esp100)) ||
@@ -2479,7 +2477,7 @@
 /* This puts the driver in a state where it can revitalize a command that
  * is being continued due to reselection.
  */
-static inline void esp_connect(struct esp *esp, Scsi_Cmnd *sp)
+static inline void esp_connect(struct esp *esp, struct scsi_cmnd *sp)
 {
 	struct esp_device *esp_dev = sp->device->hostdata;
 
@@ -2502,7 +2500,7 @@
 /* This will place the current working command back into the issue queue
  * if we are to receive a reselection amidst a selection attempt.
  */
-static inline void esp_reconnect(struct esp *esp, Scsi_Cmnd *sp)
+static inline void esp_reconnect(struct esp *esp, struct scsi_cmnd *sp)
 {
 	if (!esp->disconnected_SC)
 		ESPLOG(("esp%d: Weird, being reselected but disconnected "
@@ -2540,7 +2538,7 @@
 	return rval - fifo_count;
 }
 
-static inline void advance_sg(Scsi_Cmnd *sp)
+static inline void advance_sg(struct scsi_cmnd *sp)
 {
 	++sp->SCp.buffer;
 	--sp->SCp.buffers_residual;
@@ -2568,7 +2566,7 @@
  */
 static int esp_do_data(struct esp *esp)
 {
-	Scsi_Cmnd *SCptr = esp->current_SC;
+	struct scsi_cmnd *SCptr = esp->current_SC;
 	int thisphase, hmuch;
 
 	ESPDATA(("esp_do_data: "));
@@ -2619,7 +2617,7 @@
 /* See how successful the data transfer was. */
 static int esp_do_data_finale(struct esp *esp)
 {
-	Scsi_Cmnd *SCptr = esp->current_SC;
+	struct scsi_cmnd *SCptr = esp->current_SC;
 	struct esp_device *esp_dev = SCptr->device->hostdata;
 	int bogus_data = 0, bytes_sent = 0, fifocnt, ecount = 0;
 
@@ -2800,7 +2798,7 @@
  * a tape, we don't want to go into a loop re-negotiating
  * synchronous capabilities over and over.
  */
-static int esp_should_clear_sync(Scsi_Cmnd *sp)
+static int esp_should_clear_sync(struct scsi_cmnd *sp)
 {
 	u8 cmd1 = sp->cmnd[0];
 	u8 cmd2 = sp->data_cmnd[0];
@@ -2834,7 +2832,7 @@
  */
 static int esp_do_freebus(struct esp *esp)
 {
-	Scsi_Cmnd *SCptr = esp->current_SC;
+	struct scsi_cmnd *SCptr = esp->current_SC;
 	struct esp_device *esp_dev = SCptr->device->hostdata;
 	int rval;
 
@@ -2905,7 +2903,7 @@
  */
 static int esp_bad_reconnect(struct esp *esp)
 {
-	Scsi_Cmnd *sp;
+	struct scsi_cmnd *sp;
 
 	ESPLOG(("esp%d: Eieeee, reconnecting unknown command!\n",
 		esp->esp_id));
@@ -2914,7 +2912,7 @@
 	ESPLOG(("esp%d: issue_SC[", esp->esp_id));
 	while (sp) {
 		ESPLOG(("<%02x,%02x>", sp->device->id, sp->device->lun));
-		sp = (Scsi_Cmnd *) sp->host_scribble;
+		sp = (struct scsi_cmnd *) sp->host_scribble;
 	}
 	ESPLOG(("]\n"));
 	sp = esp->current_SC;
@@ -2928,7 +2926,7 @@
 	ESPLOG(("esp%d: disconnected_SC[", esp->esp_id));
 	while (sp) {
 		ESPLOG(("<%02x,%02x>", sp->device->id, sp->device->lun));
-		sp = (Scsi_Cmnd *) sp->host_scribble;
+		sp = (struct scsi_cmnd *) sp->host_scribble;
 	}
 	ESPLOG(("]\n"));
 	return do_reset_bus;
@@ -2938,7 +2936,7 @@
 static int esp_do_reconnect(struct esp *esp)
 {
 	int lun, target;
-	Scsi_Cmnd *SCptr;
+	struct scsi_cmnd *SCptr;
 
 	/* Check for all bogus conditions first. */
 	target = reconnect_target(esp);
@@ -2988,7 +2986,7 @@
  */
 static int esp_do_status(struct esp *esp)
 {
-	Scsi_Cmnd *SCptr = esp->current_SC;
+	struct scsi_cmnd *SCptr = esp->current_SC;
 	int intr, rval;
 
 	rval = skipahead1(esp, SCptr, in_the_dark, in_status);
@@ -3133,7 +3131,7 @@
 
 static int esp_disconnect_amidst_phases(struct esp *esp)
 {
-	Scsi_Cmnd *sp = esp->current_SC;
+	struct scsi_cmnd *sp = esp->current_SC;
 	struct esp_device *esp_dev = sp->device->hostdata;
 
 	/* This means real problems if we see this
@@ -3226,7 +3224,7 @@
 /* First interrupt after exec'ing a cmd comes here. */
 static int esp_select_complete(struct esp *esp)
 {
-	Scsi_Cmnd *SCptr = esp->current_SC;
+	struct scsi_cmnd *SCptr = esp->current_SC;
 	struct esp_device *esp_dev = SCptr->device->hostdata;
 	int cmd_bytes_sent, fcnt;
 
@@ -3582,7 +3580,7 @@
  * this because so many initiators cannot cope with this occurring.
  */
 static int target_with_ants_in_pants(struct esp *esp,
-				     Scsi_Cmnd *SCptr,
+				     struct scsi_cmnd *SCptr,
 				     struct esp_device *esp_dev)
 {
 	if (esp_dev->sync || SCptr->device->borken) {
@@ -3641,7 +3639,7 @@
 
 static int check_multibyte_msg(struct esp *esp)
 {
-	Scsi_Cmnd *SCptr = esp->current_SC;
+	struct scsi_cmnd *SCptr = esp->current_SC;
 	struct esp_device *esp_dev = SCptr->device->hostdata;
 	u8 regval = 0;
 	int message_out = 0;
@@ -3822,7 +3820,7 @@
 
 static int esp_do_msgindone(struct esp *esp)
 {
-	Scsi_Cmnd *SCptr = esp->current_SC;
+	struct scsi_cmnd *SCptr = esp->current_SC;
 	int message_out = 0, it = 0, rval;
 
 	rval = skipahead1(esp, SCptr, in_msgin, in_msgindone);
@@ -3904,7 +3902,7 @@
 
 static int esp_do_cmdbegin(struct esp *esp)
 {
-	Scsi_Cmnd *SCptr = esp->current_SC;
+	struct scsi_cmnd *SCptr = esp->current_SC;
 
 	esp_advance_phase(SCptr, in_cmdend);
 	if (esp->erev == fashme) {
@@ -4125,7 +4123,7 @@
 /* This is the second tier in our dual-level SCSI state machine. */
 static int esp_work_bus(struct esp *esp)
 {
-	Scsi_Cmnd *SCptr = esp->current_SC;
+	struct scsi_cmnd *SCptr = esp->current_SC;
 	unsigned int phase;
 
 	ESPBUS(("esp_work_bus: "));
@@ -4153,7 +4151,7 @@
 /* Main interrupt handler for an esp adapter. */
 static void esp_handle(struct esp *esp)
 {
-	Scsi_Cmnd *SCptr;
+	struct scsi_cmnd *SCptr;
 	int what_next = do_intr_end;
 
 	SCptr = esp->current_SC;
@@ -4353,7 +4351,7 @@
 	return IRQ_HANDLED;
 }
 
-static int esp_slave_alloc(Scsi_Device *SDptr)
+static int esp_slave_alloc(struct scsi_device *SDptr)
 {
 	struct esp_device *esp_dev =
 		kmalloc(sizeof(struct esp_device), GFP_ATOMIC);
@@ -4365,7 +4363,7 @@
 	return 0;
 }
 
-static void esp_slave_destroy(Scsi_Device *SDptr)
+static void esp_slave_destroy(struct scsi_device *SDptr)
 {
 	struct esp *esp = (struct esp *) SDptr->host->hostdata;
 
@@ -4374,7 +4372,7 @@
 	SDptr->hostdata = NULL;
 }
 
-static Scsi_Host_Template driver_template = {
+static struct scsi_host_template driver_template = {
 	.proc_name		= "esp",
 	.proc_info		= esp_proc_info,
 	.name			= "Sun ESP 100/100a/200",
--- linux-2.6.6/drivers/scsi/esp.h.BAD	2004-06-01 16:04:20.663920000 -0400
+++ linux-2.6.6/drivers/scsi/esp.h	2004-06-01 16:31:39.003920000 -0400
@@ -10,9 +10,20 @@
 
 #include <linux/config.h>
 
+/* #include "scsi.h" */
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_eh.h>
+#include <scsi/scsi_request.h>
+#include <scsi/scsi_tcq.h>
+#include <scsi/scsi.h>
+#include <scsi/scsi_host.h>
+
 /* For dvma controller register definitions. */
 #include <asm/dma.h>
 
+#define scsi_to_sbus_dma_dir(scsi_dir)	((int)(scsi_dir))
+
 /* The ESP SCSI controllers have their register sets in three
  * "classes":
  *
@@ -181,9 +192,9 @@
 	int			bursts;		/* Burst sizes our DVMA supports */
 
 	/* Our command queues, only one cmd lives in the current_SC queue. */
-	Scsi_Cmnd		*issue_SC;	/* Commands to be issued */
-	Scsi_Cmnd		*current_SC;	/* Who is currently working the bus */
-	Scsi_Cmnd		*disconnected_SC;/* Commands disconnected from the bus */
+	struct scsi_cmnd	*issue_SC;	/* Commands to be issued */
+	struct scsi_cmnd	*current_SC;	/* Who is currently working the bus */
+	struct scsi_cmnd	*disconnected_SC;/* Commands disconnected from the bus */
 
 	/* Message goo */
 	u8			cur_msgout[16];
--- linux-2.6.6/drivers/scsi/qlogicpti.h.BAD	2004-06-01 16:23:36.433920000 -0400
+++ linux-2.6.6/drivers/scsi/qlogicpti.h	2004-06-01 16:40:56.873920000 -0400
@@ -8,6 +8,17 @@
 
 #include <linux/config.h>
 
+/* #include "scsi.h" */
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_eh.h>
+#include <scsi/scsi_request.h>
+#include <scsi/scsi_tcq.h>
+#include <scsi/scsi.h>
+#include <scsi/scsi_host.h>
+
+#define scsi_to_sbus_dma_dir(scsi_dir)	((int)(scsi_dir))
+
 /* Qlogic/SBUS controller registers. */
 #define SBUS_CFG1	0x006UL
 #define SBUS_CTRL	0x008UL
@@ -352,7 +363,7 @@
 	 * Ex000 sparc64 machines with >4GB of ram we just keep track of the
 	 * scsi command pointers here.  This is essentially what Matt Jacob does. -DaveM
 	 */
-	Scsi_Cmnd                *cmd_slots[QLOGICPTI_REQ_QUEUE_LEN + 1];
+	struct scsi_cmnd         *cmd_slots[QLOGICPTI_REQ_QUEUE_LEN + 1];
 
 	/* The rest of the elements are unimportant for performance. */
 	struct qlogicpti         *next;
--- linux-2.6.6/drivers/scsi/qlogicpti.c.BAD	2004-06-01 16:30:26.033920000 -0400
+++ linux-2.6.6/drivers/scsi/qlogicpti.c	2004-06-01 16:43:24.903920000 -0400
@@ -26,8 +26,6 @@
 
 #include <asm/byteorder.h>
 
-#include "scsi.h"
-#include "hosts.h"
 #include "qlogicpti.h"
 
 #include <asm/sbus.h>
@@ -809,7 +807,7 @@
 }
 
 /* Detect all PTI Qlogic ISP's in the machine. */
-static int __init qlogicpti_detect(Scsi_Host_Template *tpnt)
+static int __init qlogicpti_detect(struct scsi_host_template *tpnt)
 {
 	struct qlogicpti *qpti;
 	struct Scsi_Host *qpti_host;
@@ -878,7 +876,7 @@
 			qpti_get_bursts(qpti);
 			qpti_get_clock(qpti);
 
-			/* Clear out Scsi_Cmnd array. */
+			/* Clear out scsi_cmnd array. */
 			memset(qpti->cmd_slots, 0, sizeof(qpti->cmd_slots));
 
 			if (qpti_map_queues(qpti) < 0)
@@ -997,7 +995,7 @@
 	marker->rsvd = 0;
 }
 
-static inline void cmd_frob(struct Command_Entry *cmd, Scsi_Cmnd *Cmnd,
+static inline void cmd_frob(struct Command_Entry *cmd, struct scsi_cmnd *Cmnd,
 			    struct qlogicpti *qpti)
 {
 	memset(cmd, 0, sizeof(struct Command_Entry));
@@ -1027,7 +1025,7 @@
 }
 
 /* Do it to it baby. */
-static inline int load_cmd(Scsi_Cmnd *Cmnd, struct Command_Entry *cmd,
+static inline int load_cmd(struct scsi_cmnd *Cmnd, struct Command_Entry *cmd,
 			   struct qlogicpti *qpti, u_int in_ptr, u_int out_ptr)
 {
 	struct dataseg *ds;
@@ -1115,11 +1113,11 @@
 /*
  * Until we scan the entire bus with inquiries, go throught this fella...
  */
-static void ourdone(Scsi_Cmnd *Cmnd)
+static void ourdone(struct scsi_cmnd *Cmnd)
 {
 	struct qlogicpti *qpti = (struct qlogicpti *) Cmnd->device->host->hostdata;
 	int tgt = Cmnd->device->id;
-	void (*done) (Scsi_Cmnd *);
+	void (*done) (struct scsi_cmnd *);
 
 	/* This grot added by DaveM, blame him for ugliness.
 	 * The issue is that in the 2.3.x driver we use the
@@ -1127,7 +1125,7 @@
 	 * completion linked list at interrupt service time,
 	 * so we have to store the done function pointer elsewhere.
 	 */
-	done = (void (*)(Scsi_Cmnd *))
+	done = (void (*)(struct scsi_cmnd *))
 		(((unsigned long) Cmnd->SCp.Message)
 #ifdef __sparc_v9__
 		 | ((unsigned long) Cmnd->SCp.Status << 32UL)
@@ -1164,10 +1162,10 @@
 	done(Cmnd);
 }
 
-static int qlogicpti_queuecommand(Scsi_Cmnd *Cmnd, void (*done)(Scsi_Cmnd *));
+static int qlogicpti_queuecommand(struct scsi_cmnd *Cmnd, void (*done)(struct scsi_cmnd *));
 
-static int qlogicpti_queuecommand_slow(Scsi_Cmnd *Cmnd,
-				       void (*done)(Scsi_Cmnd *))
+static int qlogicpti_queuecommand_slow(struct scsi_cmnd *Cmnd,
+				       void (*done)(struct scsi_cmnd *))
 {
 	struct qlogicpti *qpti = (struct qlogicpti *) Cmnd->device->host->hostdata;
 
@@ -1238,7 +1236,7 @@
  *
  * "This code must fly." -davem
  */
-static int qlogicpti_queuecommand(Scsi_Cmnd *Cmnd, void (*done)(Scsi_Cmnd *))
+static int qlogicpti_queuecommand(struct scsi_cmnd *Cmnd, void (*done)(struct scsi_cmnd *))
 {
 	struct Scsi_Host *host = Cmnd->device->host;
 	struct qlogicpti *qpti = (struct qlogicpti *) host->hostdata;
@@ -1351,9 +1349,9 @@
 	return (sts->scsi_status & STATUS_MASK) | (host_status << 16);
 }
 
-static Scsi_Cmnd *qlogicpti_intr_handler(struct qlogicpti *qpti)
+static struct scsi_cmnd *qlogicpti_intr_handler(struct qlogicpti *qpti)
 {
-	Scsi_Cmnd *Cmnd, *done_queue = NULL;
+	struct scsi_cmnd *Cmnd, *done_queue = NULL;
 	struct Status_Entry *sts;
 	u_int in_ptr, out_ptr;
 
@@ -1433,16 +1431,16 @@
 {
 	struct qlogicpti *qpti = dev_id;
 	unsigned long flags;
-	Scsi_Cmnd *dq;
+	struct scsi_cmnd *dq;
 
 	spin_lock_irqsave(qpti->qhost->host_lock, flags);
 	dq = qlogicpti_intr_handler(qpti);
 
 	if (dq != NULL) {
 		do {
-			Scsi_Cmnd *next;
+			struct scsi_cmnd *next;
 
-			next = (Scsi_Cmnd *) dq->host_scribble;
+			next = (struct scsi_cmnd *) dq->host_scribble;
 			dq->scsi_done(dq);
 			dq = next;
 		} while (dq != NULL);
@@ -1452,7 +1450,7 @@
 	return IRQ_HANDLED;
 }
 
-static int qlogicpti_abort(Scsi_Cmnd *Cmnd)
+static int qlogicpti_abort(struct scsi_cmnd *Cmnd)
 {
 	u_short param[6];
 	struct Scsi_Host *host = Cmnd->device->host;
@@ -1489,7 +1487,7 @@
 	return return_status;
 }
 
-static int qlogicpti_reset(Scsi_Cmnd *Cmnd)
+static int qlogicpti_reset(struct scsi_cmnd *Cmnd)
 {
 	u_short param[6];
 	struct Scsi_Host *host = Cmnd->device->host;
@@ -1513,7 +1511,7 @@
 	return return_status;
 }
 
-static Scsi_Host_Template driver_template = {
+static struct scsi_host_template driver_template = {
 	.detect			= qlogicpti_detect,
 	.release		= qlogicpti_release,
 	.info			= qlogicpti_info,

--=-FrSqGH+ku9/7dLOmi5IX--

