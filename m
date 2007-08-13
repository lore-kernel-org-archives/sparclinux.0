From: David Miller <davem@davemloft.net>
Date: Mon, 13 Aug 2007 01:23:47 +0000
Subject: Re: ESP: cosmetic printk error during detection
Message-Id: <20070812.182347.130617135.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0708121438030.24332@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0708121438030.24332@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 12 Aug 2007 14:42:03 +0300 (EEST)

> The second esp0 should be esp1. In the code, esp->host->unique_id is 
> printed there and after printing the unique_id is assigned like that: 
> 
> esp->host->unique_id = instance++;
> 
> Should it be ++instance instead?

The first call of scsi_esp_register() (for the controller "0") should
get unique_id set to 0 and instance incremented to 1, the second call
(for the controller "1") should get unique_id set to 1 and instance
incremented to 2, which is what we want.

The problem is rather that we are not assigning the unique_id early
enough, and thus we do prints with the value uninitialized to zero.

Thankfully the bug is purely cosmetic as it only disrupts the probe
printk statements.

This patch should fix it up, thanks for the report.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index 77b06a9..95cf7b6 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -2314,6 +2314,7 @@ int __devinit scsi_esp_register(struct esp *esp, struct device *dev)
 	esp->host->transportt = esp_transport_template;
 	esp->host->max_lun = ESP_MAX_LUN;
 	esp->host->cmd_per_lun = 2;
+	esp->host->unique_id = instance;
 
 	esp_set_clock_params(esp);
 
@@ -2337,7 +2338,7 @@ int __devinit scsi_esp_register(struct esp *esp, struct device *dev)
 	if (err)
 		return err;
 
-	esp->host->unique_id = instance++;
+	instance++;
 
 	scsi_scan_host(esp->host);
 
