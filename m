From: "David S. Miller" <davem@redhat.com>
Date: Thu, 15 Jan 2004 20:35:06 +0000
Subject: Re: qlogicpti on 2.6.1
Message-Id: <20040115123506.176bf2ad.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.58.0401141652170.15533@redfish.gatech.edu>
In-Reply-To: <Pine.GSO.4.58.0401141652170.15533@redfish.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 15 Jan 2004 11:17:05 -0500 (EST)
Chris Ricker <kaboom@gatech.edu> wrote:

> If I recompile without SMP support, 2.6.1-UP loads the driver, and I'm able 
> to mount and use the RAID 5 array on the D1000. No problems so far, in the 
> hour or so I've been pounding it.

Give this patch a spin under SMP.

=== drivers/scsi/qlogicpti.c 1.21 vs edited ==--- 1.21/drivers/scsi/qlogicpti.c	Mon Jan  5 11:02:49 2004
+++ edited/drivers/scsi/qlogicpti.c	Thu Jan 15 12:33:45 2004
@@ -319,7 +319,7 @@
 
 	risc_code_addr = 0x1000;	/* all load addresses are at 0x1000 */
 
-	spin_lock_irqsave(&qpti->lock, flags);
+	spin_lock_irqsave(host->host_lock, flags);
 
 	sbus_writew(HCCTRL_PAUSE, qpti->qregs + HCCTRL);
 
@@ -367,7 +367,7 @@
 	if (qlogicpti_mbox_command(qpti, param, 1)) {
 		printk(KERN_EMERG "qlogicpti%d: Cannot execute ISP firmware.\n",
 		       qpti->qpti_id);
-		spin_unlock_irqrestore(&qpti->lock, flags);
+		spin_unlock_irqrestore(host->host_lock, flags);
 		return 1;
 	}
 
@@ -378,7 +378,7 @@
 	   (param[0] != MBOX_COMMAND_COMPLETE)) {
 		printk(KERN_EMERG "qlogicpti%d: Cannot set initiator SCSI ID.\n",
 		       qpti->qpti_id);
-		spin_unlock_irqrestore(&qpti->lock, flags);
+		spin_unlock_irqrestore(host->host_lock, flags);
 		return 1;
 	}
 
@@ -393,7 +393,7 @@
 	if (qlogicpti_mbox_command(qpti, param, 1)) {
 		printk(KERN_EMERG "qlogicpti%d: Cannot init response queue.\n",
 		       qpti->qpti_id);
-		spin_unlock_irqrestore(&qpti->lock, flags);
+		spin_unlock_irqrestore(host->host_lock, flags);
 		return 1;
 	}
 
@@ -405,7 +405,7 @@
 	if (qlogicpti_mbox_command(qpti, param, 1)) {
 		printk(KERN_EMERG "qlogicpti%d: Cannot init request queue.\n",
 		       qpti->qpti_id);
-		spin_unlock_irqrestore(&qpti->lock, flags);
+		spin_unlock_irqrestore(host->host_lock, flags);
 		return 1;
 	}
 
@@ -451,7 +451,7 @@
 	qlogicpti_mbox_command(qpti, param, 0);
 	qpti->send_marker = 1;
 
-	spin_unlock_irqrestore(&qpti->lock, flags);
+	spin_unlock_irqrestore(host->host_lock, flags);
 	return 0;
 }
 
@@ -459,6 +459,7 @@
 
 static int __init qlogicpti_load_firmware(struct qlogicpti *qpti)
 {
+	struct Scsi_Host *host = qpti->qhost;
 	unsigned short csum = 0;
 	unsigned short param[6];
 	unsigned short *risc_code, risc_code_addr, risc_code_length;
@@ -469,7 +470,7 @@
 	risc_code_addr = 0x1000;	/* all f/w modules load at 0x1000 */
 	risc_code_length = sbus_risc_code_length01;
 
-	spin_lock_irqsave(&qpti->lock, flags);
+	spin_lock_irqsave(host->host_lock, flags);
 
 	/* Verify the checksum twice, one before loading it, and once
 	 * afterwards via the mailbox commands.
@@ -477,7 +478,7 @@
 	for (i = 0; i < risc_code_length; i++)
 		csum += risc_code[i];
 	if (csum) {
-		spin_unlock_irqrestore(&qpti->lock, flags);
+		spin_unlock_irqrestore(host->host_lock, flags);
 		printk(KERN_EMERG "qlogicpti%d: Aieee, firmware checksum failed!",
 		       qpti->qpti_id);
 		return 1;
@@ -489,7 +490,7 @@
 	while (--timeout && (sbus_readw(qpti->qregs + SBUS_CTRL) & SBUS_CTRL_RESET))
 		udelay(20);
 	if (!timeout) {
-		spin_unlock_irqrestore(&qpti->lock, flags);
+		spin_unlock_irqrestore(host->host_lock, flags);
 		printk(KERN_EMERG "qlogicpti%d: Cannot reset the ISP.", qpti->qpti_id);
 		return 1;
 	}
@@ -529,7 +530,7 @@
 	if (qlogicpti_mbox_command(qpti, param, 1)) {
 		printk(KERN_EMERG "qlogicpti%d: Cannot stop firmware for reload.\n",
 		       qpti->qpti_id);
-		spin_unlock_irqrestore(&qpti->lock, flags);
+		spin_unlock_irqrestore(host->host_lock, flags);
 		return 1;
 	}		
 
@@ -542,7 +543,7 @@
 		    param[0] != MBOX_COMMAND_COMPLETE) {
 			printk("qlogicpti%d: Firmware dload failed, I'm bolixed!\n",
 			       qpti->qpti_id);
-			spin_unlock_irqrestore(&qpti->lock, flags);
+			spin_unlock_irqrestore(host->host_lock, flags);
 			return 1;
 		}
 	}
@@ -562,7 +563,7 @@
 	    (param[0] != MBOX_COMMAND_COMPLETE)) {
 		printk(KERN_EMERG "qlogicpti%d: New firmware csum failure!\n",
 		       qpti->qpti_id);
-		spin_unlock_irqrestore(&qpti->lock, flags);
+		spin_unlock_irqrestore(host->host_lock, flags);
 		return 1;
 	}
 
@@ -576,7 +577,7 @@
 	    (param[0] != MBOX_COMMAND_COMPLETE)) {
 		printk(KERN_EMERG "qlogicpti%d: AboutFirmware cmd fails.\n",
 		       qpti->qpti_id);
-		spin_unlock_irqrestore(&qpti->lock, flags);
+		spin_unlock_irqrestore(host->host_lock, flags);
 		return 1;
 	}
 
@@ -592,7 +593,7 @@
 	    (param[0] != MBOX_COMMAND_COMPLETE)) {
 		printk(KERN_EMERG "qlogicpti%d: could not set clock rate.\n",
 		       qpti->qpti_id);
-		spin_unlock_irqrestore(&qpti->lock, flags);
+		spin_unlock_irqrestore(host->host_lock, flags);
 		return 1;
 	}
 
@@ -609,7 +610,7 @@
 		qlogicpti_mbox_command(qpti, param, 1);
 	}
 
-	spin_unlock_irqrestore(&qpti->lock, flags);
+	spin_unlock_irqrestore(host->host_lock, flags);
 	return 0;
 }
 
@@ -844,8 +845,6 @@
 			}
 			qpti = (struct qlogicpti *) qpti_host->hostdata;
 
-			spin_lock_init(&qpti->lock);
-
 			/* We are wide capable, 16 targets. */
 			qpti_host->max_id = MAX_TARGETS;
 
@@ -1171,7 +1170,6 @@
 				       void (*done)(Scsi_Cmnd *))
 {
 	struct qlogicpti *qpti = (struct qlogicpti *) Cmnd->device->host->hostdata;
-	unsigned long flags;
 
 	/*
 	 * done checking this host adapter?
@@ -1188,8 +1186,6 @@
 		return qlogicpti_queuecommand(Cmnd, ourdone);
 	}
 
-	spin_lock_irqsave(&qpti->lock, flags);
-
 	/*
 	 * We've peeked at all targets for this bus- time
 	 * to set parameters for devices for real now.
@@ -1231,8 +1227,6 @@
 	if (qpti = NULL)
 		Cmnd->device->host->hostt->queuecommand = qlogicpti_queuecommand;
 
-	spin_unlock_irqrestore(&qpti->lock, flags);
-
 	return qlogicpti_queuecommand(Cmnd, done);
 }
 
@@ -1249,14 +1243,11 @@
 	struct Scsi_Host *host = Cmnd->device->host;
 	struct qlogicpti *qpti = (struct qlogicpti *) host->hostdata;
 	struct Command_Entry *cmd;
-	unsigned long flags;
 	u_int out_ptr;
 	int in_ptr;
 
 	Cmnd->scsi_done = done;
 
-	spin_lock_irqsave(&qpti->lock, flags);
-
 	in_ptr = qpti->req_in_ptr;
 	cmd = (struct Command_Entry *) &qpti->req_cpu[in_ptr];
 	out_ptr = sbus_readw(qpti->qregs + MBOX4);
@@ -1281,15 +1272,12 @@
 
 	update_can_queue(host, in_ptr, out_ptr);
 
-	spin_unlock_irqrestore(&qpti->lock, flags);
 	return 0;
 
 toss_command:
 	printk(KERN_EMERG "qlogicpti%d: request queue overflow\n",
 	       qpti->qpti_id);
 
-	spin_unlock_irqrestore(&qpti->lock, flags);
-
 	/* Unfortunately, unless you use the new EH code, which
 	 * we don't, the midlayer will ignore the return value,
 	 * which is insane.  We pick up the pieces like this.
@@ -1447,12 +1435,10 @@
 	unsigned long flags;
 	Scsi_Cmnd *dq;
 
-	spin_lock_irqsave(&qpti->lock, flags);
+	spin_lock_irqsave(qpti->qhost->host_lock, flags);
 	dq = qlogicpti_intr_handler(qpti);
-	spin_unlock(&qpti->lock);
 
 	if (dq != NULL) {
-		spin_lock(qpti->qhost->host_lock);
 		do {
 			Scsi_Cmnd *next;
 
@@ -1460,9 +1446,8 @@
 			dq->scsi_done(dq);
 			dq = next;
 		} while (dq != NULL);
-		spin_unlock(qpti->qhost->host_lock);
 	}
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(qpti->qhost->host_lock, flags);
 
 	return IRQ_HANDLED;
 }
@@ -1473,15 +1458,12 @@
 	struct Scsi_Host *host = Cmnd->device->host;
 	struct qlogicpti *qpti = (struct qlogicpti *) host->hostdata;
 	int return_status = SUCCESS;
-	unsigned long flags;
 	u32 cmd_cookie;
 	int i;
 
 	printk(KERN_WARNING "qlogicpti : Aborting cmd for tgt[%d] lun[%d]\n",
 	       (int)Cmnd->device->id, (int)Cmnd->device->lun);
 
-	spin_lock_irqsave(&qpti->lock, flags);
-
 	qlogicpti_disable_irqs(qpti);
 
 	/* Find the 32-bit cookie we gave to the firmware for
@@ -1504,8 +1486,6 @@
 
 	qlogicpti_enable_irqs(qpti);
 
-	spin_unlock_irqrestore(&qpti->lock, flags);
-
 	return return_status;
 }
 
@@ -1515,12 +1495,9 @@
 	struct Scsi_Host *host = Cmnd->device->host;
 	struct qlogicpti *qpti = (struct qlogicpti *) host->hostdata;
 	int return_status = SUCCESS;
-	unsigned long flags;
 
 	printk(KERN_WARNING "qlogicpti : Resetting SCSI bus!\n");
 
-	spin_lock_irqsave(&qpti->lock, flags);
-
 	qlogicpti_disable_irqs(qpti);
 
 	param[0] = MBOX_BUS_RESET;
@@ -1532,8 +1509,6 @@
 	}
 
 	qlogicpti_enable_irqs(qpti);
-
-	spin_unlock_irqrestore(&qpti->lock, flags);
 
 	return return_status;
 }
=== drivers/scsi/qlogicpti.h 1.6 vs edited ==--- 1.6/drivers/scsi/qlogicpti.h	Sat Nov  2 02:12:18 2002
+++ edited/drivers/scsi/qlogicpti.h	Thu Jan 15 12:28:46 2004
@@ -335,7 +335,6 @@
 /* Software state for the driver. */
 struct qlogicpti {
 	/* These are the hot elements in the cache, so they come first. */
-	spinlock_t		  lock;			/* Driver mutex		      */
 	unsigned long             qregs;                /* Adapter registers          */
 	struct pti_queue_entry   *res_cpu;              /* Ptr to RESPONSE bufs (CPU) */
 	struct pti_queue_entry   *req_cpu;              /* Ptr to REQUEST bufs (CPU)  */
