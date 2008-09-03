From: David Miller <davem@davemloft.net>
Date: Wed, 03 Sep 2008 00:03:58 +0000
Subject: Re: generic IRQs for sparc32
Message-Id: <20080902.170358.263807614.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080902.010944.25269623.davem@davemloft.net>
In-Reply-To: <20080902.010944.25269623.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Tue, 02 Sep 2008 17:24:51 -0400

> SCSI subsystem initialized
> Unable to handle kernel paging request at virtual address fd412000
> tsk->{mm,active_mm}->context = 000000a7
> tsk->{mm,active_mm}->pgd = fc016000
>               \|/ ____ \|/
>               "@'/ ,. \`@"
>               /_| \__/ |_\
>                  \__U_/
> modprobe(313): Oops [#1]
> PSR: 404000c0 PC: fe61001c NPC: fe610020 Y: 00000000    Not tainted
> PC: <sbus_esp_read8+0x8/0x14 [sun_esp]>
> %G: fb8f19cc fd412000  000061a8 00177190  00009c40 fe610a48  fb8f0000 00000000
> %O: fb8e6e54 0000002c  0000002c fff01000  fff01000 f0267970  fb8f1a10 fe61eb7c
> RPC: <scsi_esp_register+0x1b0/0x3ec [esp_scsi]>
> %L: f0d084e0 00000024  fe62075c fe610e58  fb8e6e54 00000000  fb8f1a58 fb8f1a44
> %I: fb8e6e54 fb8630e8  000000ff 408000e0  f02670e8 ffffffff  fb8f1a80 fe610934
> Caller[fe610934]: esp_sbus_probe+0x378/0x468 [sun_esp]

Ok, so we're faulting on the I/O read of location "esp->regs + 0x2c"
in sbus_esp_read8().

But what's amusing is that we just did a sbus_esp_write8() using the
same exact esp->regs, and that worked!

Here is a debugging patch against sparc-next-2.6 that might help debug
this:

diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index 62a4618..48fc49f 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -2151,10 +2151,17 @@ static void esp_get_revision(struct esp *esp)
 {
 	u8 val;
 
+#if 1
+	printk(KERN_ERR "ESP: In esp_get_revision(), regs at %p\n", esp->regs);
+#endif
 	esp->config1 = (ESP_CONFIG1_PENABLE | (esp->scsi_id & 7));
 	esp->config2 = (ESP_CONFIG2_SCSI2ENAB | ESP_CONFIG2_REGPARITY);
 	esp_write8(esp->config2, ESP_CFG2);
 
+#if 1
+	printk(KERN_ERR "ESP: In esp_get_revision(), about to read ESP_CFG2, "
+	       "regs now at %p\n", esp->regs);
+#endif
 	val = esp_read8(ESP_CFG2);
 	val &= ~ESP_CONFIG2_MAGIC;
 	if (val != (ESP_CONFIG2_SCSI2ENAB | ESP_CONFIG2_REGPARITY)) {
diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index 3d73aad..5018210 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -94,6 +94,9 @@ static int __devinit esp_sbus_map_regs(struct esp *esp, int hme)
 	esp->regs = of_ioremap(res, 0, SBUS_ESP_REG_SIZE, "ESP");
 	if (!esp->regs)
 		return -ENOMEM;
+#if 1
+	printk(KERN_ERR "ESP: Mapped regs at %p\n", esp->regs);
+#endif
 
 	return 0;
 }
