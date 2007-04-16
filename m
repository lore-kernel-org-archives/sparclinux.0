From: David Miller <davem@davemloft.net>
Date: Mon, 16 Apr 2007 23:38:54 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070416.163854.17862874.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Adam Kropelin" <akropel1@rochester.rr.com>
Date: Mon, 16 Apr 2007 18:58:39 -0400

> Starting smartd: esp: esp0: Aborting command [fffff80030b05280:2a]
> esp: esp0: Active command [fffff80030b05280:2a]
> esp: esp0: Aborting command [fffff80030b05280:00]
> esp: esp0: Queued command [fffff80030b05280:00]
> esp: esp0: Aborting command [fffff80030b05280:00]
> esp: esp0: Queued command [fffff80030b05280:00]

smartd definitely gives something to the device which it does not
like.

Initially I thought perhaps TEST_UNIT_READY should not be allowed to
disconnect just like INQUIRY and REQUEST_SENSE commands.  But what
we're seeing aborted here is a TEST_UNIT_READY presumably submitted by
the scsi-midlayer after the ABORT attempt.

Let's see what the heck smartd is sending to the device.  Please
reboot with smartd enabled and post the logs that get output
from this patch below applied, thanks.

diff --git a/drivers/scsi/esp.c b/drivers/scsi/esp.c
index 2d96fba..6151ed7 100644
--- a/drivers/scsi/esp.c
+++ b/drivers/scsi/esp.c
@@ -1174,6 +1174,18 @@ static int esp_queue(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
 		return 0;
 	}
 
+#if 1
+	if (!strcmp(current->comm, "smartd")) {
+		int i;
+
+		printk("ESP: SMARTD tgt[%d] lun[%d] scsi_cmd [ ",
+		       cmd->device->id, cmd->device->lun);
+		for (i = 0; i < cmd->cmd_len; i++)
+			printk("%02x ", cmd->cmnd[i]);
+		printk("]\n");
+	}
+#endif
+
 	spriv = ESP_CMD_PRIV(cmd);
 	spriv->u.dma_addr = ~(dma_addr_t)0x0;
 	spriv->mapping_type = MAPPING_TYPE_NONE;
