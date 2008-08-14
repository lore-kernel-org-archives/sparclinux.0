From: David Miller <davem@davemloft.net>
Date: Thu, 14 Aug 2008 03:52:08 +0000
Subject: Re: [BUG] Kernel panic on heavy disk activity with esp_scsi
Message-Id: <20080813.205208.127042891.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1210367903.21472.14.camel@lya.porno-bullen.de>
In-Reply-To: <1210367903.21472.14.camel@lya.porno-bullen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Friedrich Oslage <bluebird@porno-bullen.de>
Date: Wed, 18 Jun 2008 22:06:24 +0200

> Well, it does fix the OOPS, but now the system is stuck in an infinite
> reset-loop. Dmesg shows the "DMA length is zero" message once per
> second.

Can you run and trigger this problem with the following debugging
patch applied?  Just give me the first one tha triggers.

Thanks!

diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index 62a4618..41ec3e4 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -1717,6 +1717,16 @@ again:
 			       esp->host->unique_id,
 			       (unsigned long long)esp_cur_dma_addr(ent, cmd),
 			       esp_cur_dma_len(ent, cmd));
+			{
+				int i;
+				printk("esp%d: tgt[%d] lun[%d] scsi_cmd [ ",
+				       esp->host->unique_id, cmd->device->id,
+				       cmd->device->lun);
+				for (i = 0; i < cmd->cmd_len; i++)
+					printk("%02x ", cmd->cmnd[i]);
+				printk("]\n");
+				esp_dump_cmd_log(esp);
+			}
 			esp_schedule_reset(esp);
 			return 0;
 		}
