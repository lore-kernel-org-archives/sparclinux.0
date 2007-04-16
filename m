From: David Miller <davem@davemloft.net>
Date: Mon, 16 Apr 2007 08:29:37 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070416.012937.122620601.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Sun, 15 Apr 2007 04:16:25 -0500

> Booted with new patch applied, and esp.esp_debug 47.
> 
> Only sense debug I see is:
> ESP: SENSE [ 70 00 06 00 00 00 00 0a 00 00 00 00 29 02 02 00 00 00 ]
> 
> Full log attached, from prom to break. :)

The sense looks good, the device is just saying that it has
been reset too recently.

The extended sense codes are 0x29 and 0x02, but the scsi scan only
retries the INQUIRY if the extended sense codes are 0x29 and 0x00 for
whatever reason.

Let's let the bus settle properly after a scsi reset in order to avoid
this altogether.

Please give this patch a spin.

diff --git a/drivers/scsi/esp.c b/drivers/scsi/esp.c
index 7882fc7..040c7b8 100644
--- a/drivers/scsi/esp.c
+++ b/drivers/scsi/esp.c
@@ -33,6 +33,9 @@
 #define DRV_VERSION		"2.000"
 #define DRV_MODULE_RELDATE	"March 30, 2007"
 
+/* SCSI bus reset settle time in seconds.  */
+static int esp_bus_reset_settle = 3;
+
 static u32 esp_debug;
 #define ESP_DEBUG_INTR		0x00000001
 #define ESP_DEBUG_SCSICMD	0x00000002
@@ -2788,6 +2791,9 @@ static int __devinit detect_one_esp(struct scsi_host_template *tpnt,
 
 	esp_bootup_reset(esp);
 
+	/* Let the SCSI bus reset settle. */
+	schedule_timeout_uninterruptible(esp_bus_reset_settle * HZ);
+
 	if (scsi_add_host(host, dev))
 		goto fail_free_irq;
 
@@ -3083,6 +3089,8 @@ static int esp_eh_bus_reset_handler(struct scsi_cmnd *cmd)
 
 	spin_unlock_irqrestore(esp->host->host_lock, flags);
 
+	schedule_timeout_uninterruptible(esp_bus_reset_settle * HZ);
+
 	if (!wait_for_completion_timeout(&eh_reset, 5 * HZ)) {
 		spin_lock_irqsave(esp->host->host_lock, flags);
 		esp->eh_reset = NULL;
@@ -3105,6 +3113,8 @@ static int esp_eh_host_reset_handler(struct scsi_cmnd *cmd)
 	esp_reset_cleanup(esp);
 	spin_unlock_irqrestore(esp->host->host_lock, flags);
 
+	schedule_timeout_uninterruptible(esp_bus_reset_settle * HZ);
+
 	return SUCCESS;
 }
 
@@ -3236,6 +3246,10 @@ MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
+module_param(esp_bus_reset_settle, int, 0);
+MODULE_PARM_DESC(esp_bus_reset_settle,
+		 "ESP scsi bus reset delay in seconds");
+
 module_param(esp_debug, int, 0);
 MODULE_PARM_DESC(esp_debug,
 "ESP bitmapped debugging message enable value:\n"
