From: David Miller <davem@davemloft.net>
Date: Sun, 20 Nov 2011 22:29:03 +0000
Subject: Re: bug report: 3.1.0-rc4 doesn't discover my FC drives
Message-Id: <20111120.172903.1343140327482060200.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1315419505.1068.43.camel@o.ww.redhat.com>
In-Reply-To: <1315419505.1068.43.camel@o.ww.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Heinz Mauelshagen <heinzm@redhat.com>
Date: Fri, 18 Nov 2011 12:20:02 +0100

> I'm not able to discover any FC-drives on my E6500
> (same drives get discovered on an Intel box) with 3.1.0-rc4.
> 
> Is this a known issue?
> Wrong driver?
> Any hints to analyze further?

The common problem with hardware as old as these SBUS scsi controllers
is that the SCSI protocol sequence is done by firmware and this firmware
is 15 years old and hasn't been updated since.

So the more recent the devices are which you try to hook up to them,
the less likely they'll be usable with such an old controller.

There's a patch below for the qlogicpti driver that will add some
tracing to the SCSI bus probe, so you can try it out to see what might
be happening.

But, I wonder, are you sure the drives are attached to the qlogicpti
card?  You say FC disks, but qlogicpti is SCSI.

The SBUS fibre-channel controllers Sun made aren't supported, we had
to rip the old drivers we had out of the tree nearly 10 years ago
because 1) the drivers were unmaintained and rapidly rotting and 2) we
never were able to secure the right to distribute the firmware for
those cards in any way so people had to extract the firmware from the
Solaris drivers in a cumbersome way to even to try and use these
cards.

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index e40dc1c..8d01193 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -48,6 +48,7 @@
 #include <scsi/scsi_eh.h>
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_dbg.h>
 
 #define MAX_TARGETS	16
 #define MAX_LUNS	8	/* 32 for 1.31 F/W */
@@ -1011,6 +1012,8 @@ static int qlogicpti_queuecommand_lck(struct scsi_cmnd *Cmnd, void (*done)(struc
 	u_int out_ptr;
 	int in_ptr;
 
+	pr_info("qlogicpti: Queueing command %p\n", Cmnd);
+	scsi_print_command(Cmnd);
 	Cmnd->scsi_done = done;
 
 	in_ptr = qpti->req_in_ptr;
@@ -1169,12 +1172,19 @@ static struct scsi_cmnd *qlogicpti_intr_handler(struct qlogicpti *qpti)
 			memcpy(Cmnd->sense_buffer, sts->req_sense_data,
 			       SCSI_SENSE_BUFFERSIZE);
 
+		pr_info("qlogicpti: Completing command %p, entry_type[0x%02x]\n",
+			Cmnd, sts->hdr.entry_type);
+		pr_info("qlogicpti: sts->completion_status[0x%016x]\n",
+			sts->completion_status);
+
 		if (sts->hdr.entry_type = ENTRY_STATUS)
 			Cmnd->result  			    qlogicpti_return_status(sts, qpti->qpti_id);
 		else
 			Cmnd->result = DID_ERROR << 16;
 
+		scsi_print_result(Cmnd);
+
 		if (scsi_bufflen(Cmnd))
 			dma_unmap_sg(&qpti->op->dev,
 				     scsi_sglist(Cmnd), scsi_sg_count(Cmnd),
