From: David Miller <davem@davemloft.net>
Date: Sun, 15 Apr 2007 02:24:01 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070414.192401.63043938.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Sat, 14 Apr 2007 19:54:10 -0500

> This patch is already in my tree. The kernel base is
> patch-2.6.21-rc6-git5.
> 
> I'm not netbooting these kernels either. Straight boot from firmware,
> system is serial connected through a screen (which is where the logs are
> coming from).
> 
> Additional thoughts? :)

It's never easy :)

Let's see what's in the sense buffer, boot with the following
patch and "esp.esp_bug 47" on the boot command line.

Thanks!

diff --git a/drivers/scsi/esp.c b/drivers/scsi/esp.c
index b500961..dc25b1e 100644
--- a/drivers/scsi/esp.c
+++ b/drivers/scsi/esp.c
@@ -44,6 +44,7 @@ static u32 esp_debug;
 #define ESP_DEBUG_DATASTART	0x00000080
 #define ESP_DEBUG_DATADONE	0x00000100
 #define ESP_DEBUG_RECONNECT	0x00000200
+#define ESP_DEBUG_SENSE		0x00000400
 
 #define esp_log_intr(f, a...) \
 do {	if (esp_debug & ESP_DEBUG_INTR) \
@@ -90,6 +91,11 @@ do {	if (esp_debug & ESP_DEBUG_RECONNECT) \
 		printk(f, ## a); \
 } while (0)
 
+#define esp_log_sense(f, a...) \
+do {	if (esp_debug & ESP_DEBUG_SENSE) \
+		printk(f, ## a); \
+} while (0)
+
 #define esp_read8(REG) \
 	sbus_readb(esp->regs + (REG))
 #define dma_read32(REG) \
@@ -1103,6 +1109,23 @@ static void esp_cmd_is_done(struct esp *esp, struct esp_cmd_entry *ent,
 		ent->eh_done = NULL;
 	}
 
+	if (cmd->cmnd[0] = REQUEST_SENSE) {
+		unsigned char *buf;
+		int i;
+
+		if (cmd->use_sg = 0)
+			buf = cmd->request_buffer;
+		else {
+			struct scatterlist *sg = cmd->request_buffer;
+
+			buf = page_address(sg[0].page) + sg[0].offset;
+		}
+
+		esp_log_sense("ESP: SENSE [ ");
+		for (i = 0; i < 18; i++)
+			esp_log_sense("%02x ", buf[i]);
+		esp_log_sense("]\n");
+	}
 	cmd->scsi_done(cmd);
 
 	list_del(&ent->list);
@@ -3225,6 +3248,7 @@ MODULE_PARM_DESC(esp_debug,
 "	0x00000080	Log data start\n"
 "	0x00000100	Log data done\n"
 "	0x00000200	Log reconnects\n"
+"	0x00000400	Log sense data\n"
 );
 
 module_init(esp_init);
