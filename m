From: David Miller <davem@davemloft.net>
Date: Sat, 14 Apr 2007 17:26:08 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070414.102608.99839175.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sat, 14 Apr 2007 10:01:43 -0700 (PDT)

> I'll fix the bug in the qlogicpti driver and post the patch for
> you.

This should fix the qlogicpti driver.

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 9b827ce..9f10689 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1281,7 +1281,7 @@ static struct scsi_cmnd *qlogicpti_intr_handler(struct qlogicpti *qpti)
 				      (struct scatterlist *)Cmnd->request_buffer,
 				      Cmnd->use_sg,
 				      Cmnd->sc_data_direction);
-		} else {
+		} else if (Cmnd->request_bufflen) {
 			sbus_unmap_single(qpti->sdev,
 					  (__u32)((unsigned long)Cmnd->SCp.ptr),
 					  Cmnd->request_bufflen,
