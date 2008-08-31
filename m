From: David Miller <davem@davemloft.net>
Date: Sun, 31 Aug 2008 08:24:30 +0000
Subject: [PATCH] sparc: Annotate of_device_id arrays with const or
Message-Id: <20080831.012430.149936546.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I just commited this to sparc-next-2.6 based upon some feedback I got
from Stephen.

sparc: Annotate of_device_id arrays with const or __initdata.

As suggested by Stephen Rothwell.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/parport.h    |    2 +-
 arch/sparc/kernel/apc.c             |    2 +-
 arch/sparc/kernel/pmc.c             |    2 +-
 arch/sparc/kernel/time.c            |    2 +-
 arch/sparc64/kernel/auxio.c         |    2 +-
 arch/sparc64/kernel/chmc.c          |    2 +-
 arch/sparc64/kernel/pci_fire.c      |    2 +-
 arch/sparc64/kernel/pci_psycho.c    |    2 +-
 arch/sparc64/kernel/pci_sabre.c     |    2 +-
 arch/sparc64/kernel/pci_schizo.c    |    2 +-
 arch/sparc64/kernel/pci_sun4v.c     |    2 +-
 arch/sparc64/kernel/power.c         |    2 +-
 arch/sparc64/kernel/time.c          |    6 +++---
 drivers/atm/fore200e.c              |    2 +-
 drivers/char/hw_random/n2-drv.c     |    2 +-
 drivers/hwmon/ultra45_env.c         |    2 +-
 drivers/input/misc/sparcspkr.c      |    4 ++--
 drivers/input/serio/i8042-sparcio.h |    2 +-
 drivers/mtd/maps/sun_uflash.c       |    2 +-
 drivers/net/myri_sbus.c             |    2 +-
 drivers/net/niu.c                   |    2 +-
 drivers/net/sunbmac.c               |    2 +-
 drivers/net/sunhme.c                |    2 +-
 drivers/net/sunlance.c              |    2 +-
 drivers/net/sunqe.c                 |    2 +-
 drivers/parport/parport_sunbpp.c    |    2 +-
 drivers/sbus/char/bbc_i2c.c         |    2 +-
 drivers/sbus/char/display7seg.c     |    2 +-
 drivers/sbus/char/envctrl.c         |    2 +-
 drivers/sbus/char/flash.c           |    2 +-
 drivers/sbus/char/uctrl.c           |    2 +-
 drivers/scsi/qlogicpti.c            |    2 +-
 drivers/scsi/sun_esp.c              |    2 +-
 drivers/serial/sunhv.c              |    2 +-
 drivers/serial/sunsab.c             |    2 +-
 drivers/serial/sunsu.c              |    2 +-
 drivers/serial/sunzilog.c           |    2 +-
 drivers/video/bw2.c                 |    2 +-
 drivers/video/cg14.c                |    2 +-
 drivers/video/cg3.c                 |    2 +-
 drivers/video/cg6.c                 |    2 +-
 drivers/video/ffb.c                 |    2 +-
 drivers/video/leo.c                 |    2 +-
 drivers/video/p9100.c               |    2 +-
 drivers/video/tcx.c                 |    2 +-
 drivers/watchdog/cpwd.c             |    2 +-
 drivers/watchdog/riowd.c            |    2 +-
 sound/sparc/amd7930.c               |    2 +-
 sound/sparc/cs4231.c                |    2 +-
 sound/sparc/dbri.c                  |    2 +-
 50 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/arch/sparc/include/asm/parport.h b/arch/sparc/include/asm/parport.h
index 70dce02..dff3f02 100644
--- a/arch/sparc/include/asm/parport.h
+++ b/arch/sparc/include/asm/parport.h
@@ -215,7 +215,7 @@ static int __devexit ecpp_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id ecpp_match[] = {
+static const struct of_device_id ecpp_match[] = {
 	{
 		.name = "ecpp",
 	},
diff --git a/arch/sparc/kernel/apc.c b/arch/sparc/kernel/apc.c
index 0a20cd8..4dd1ba7 100644
--- a/arch/sparc/kernel/apc.c
+++ b/arch/sparc/kernel/apc.c
@@ -182,7 +182,7 @@ static int __devinit apc_probe(struct of_device *op,
 	return 0;
 }
 
-static struct of_device_id apc_match[] = {
+static struct of_device_id __initdata apc_match[] = {
 	{
 		.name = APC_OBPNAME,
 	},
diff --git a/arch/sparc/kernel/pmc.c b/arch/sparc/kernel/pmc.c
index 9976e82..814eb3c 100644
--- a/arch/sparc/kernel/pmc.c
+++ b/arch/sparc/kernel/pmc.c
@@ -72,7 +72,7 @@ static int __devinit pmc_probe(struct of_device *op,
 	return 0;
 }
 
-static struct of_device_id pmc_match[] = {
+static struct of_device_id __initdata pmc_match[] = {
 	{
 		.name = PMC_OBPNAME,
 	},
diff --git a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
index a713bb4..339c476 100644
--- a/arch/sparc/kernel/time.c
+++ b/arch/sparc/kernel/time.c
@@ -338,7 +338,7 @@ static int __devinit clock_probe(struct of_device *op, const struct of_device_id
 	return 0;
 }
 
-static struct of_device_id clock_match[] = {
+static struct of_device_id __initdata clock_match[] = {
 	{
 		.name = "eeprom",
 	},
diff --git a/arch/sparc64/kernel/auxio.c b/arch/sparc64/kernel/auxio.c
index dd5c7bf..858beda 100644
--- a/arch/sparc64/kernel/auxio.c
+++ b/arch/sparc64/kernel/auxio.c
@@ -109,7 +109,7 @@ void auxio_set_lte(int on)
 	}
 }
 
-static struct of_device_id auxio_match[] = {
+static struct of_device_id __initdata auxio_match[] = {
 	{
 		.name = "auxio",
 	},
diff --git a/arch/sparc64/kernel/chmc.c b/arch/sparc64/kernel/chmc.c
index 3e14952..2ed4010 100644
--- a/arch/sparc64/kernel/chmc.c
+++ b/arch/sparc64/kernel/chmc.c
@@ -801,7 +801,7 @@ static int __devexit us3mc_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id us3mc_match[] = {
+static const struct of_device_id us3mc_match[] = {
 	{
 		.name = "memory-controller",
 	},
diff --git a/arch/sparc64/kernel/pci_fire.c b/arch/sparc64/kernel/pci_fire.c
index adc3fe4..477928a 100644
--- a/arch/sparc64/kernel/pci_fire.c
+++ b/arch/sparc64/kernel/pci_fire.c
@@ -547,7 +547,7 @@ out_free:
 	return err;
 }
 
-static struct of_device_id fire_match[] = {
+static struct of_device_id __initdata fire_match[] = {
 	{
 		.name = "pci",
 		.compatible = "pciex108e,80f0",
diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
index 4e8f87a..708212a 100644
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -1099,7 +1099,7 @@ out_free:
 	return err;
 }
 
-static struct of_device_id psycho_match[] = {
+static struct of_device_id __initdata psycho_match[] = {
 	{
 		.name = "pci",
 		.compatible = "pci108e,8000",
diff --git a/arch/sparc64/kernel/pci_sabre.c b/arch/sparc64/kernel/pci_sabre.c
index 7cce4d8..cc476e9 100644
--- a/arch/sparc64/kernel/pci_sabre.c
+++ b/arch/sparc64/kernel/pci_sabre.c
@@ -885,7 +885,7 @@ out_free:
 	return err;
 }
 
-static struct of_device_id sabre_match[] = {
+static struct of_device_id __initdata sabre_match[] = {
 	{
 		.name = "pci",
 		.compatible = "pci108e,a001",
diff --git a/arch/sparc64/kernel/pci_schizo.c b/arch/sparc64/kernel/pci_schizo.c
index b95dd54..18fdd88 100644
--- a/arch/sparc64/kernel/pci_schizo.c
+++ b/arch/sparc64/kernel/pci_schizo.c
@@ -1504,7 +1504,7 @@ static int __devinit schizo_probe(struct of_device *op,
  * and pci108e,8001.  So list the chips in reverse chronological
  * order.
  */
-static struct of_device_id schizo_match[] = {
+static struct of_device_id __initdata schizo_match[] = {
 	{
 		.name = "pci",
 		.compatible = "pci108e,a801",
diff --git a/arch/sparc64/kernel/pci_sun4v.c b/arch/sparc64/kernel/pci_sun4v.c
index c1e72be..fea51a0 100644
--- a/arch/sparc64/kernel/pci_sun4v.c
+++ b/arch/sparc64/kernel/pci_sun4v.c
@@ -1026,7 +1026,7 @@ out_free:
 	return -ENOMEM;
 }
 
-static struct of_device_id pci_sun4v_match[] = {
+static struct of_device_id __initdata pci_sun4v_match[] = {
 	{
 		.name = "pci",
 		.compatible = "SUNW,sun4v-pci",
diff --git a/arch/sparc64/kernel/power.c b/arch/sparc64/kernel/power.c
index 7536255..7559ad3 100644
--- a/arch/sparc64/kernel/power.c
+++ b/arch/sparc64/kernel/power.c
@@ -89,7 +89,7 @@ static int __devinit power_probe(struct of_device *op, const struct of_device_id
 	return 0;
 }
 
-static struct of_device_id power_match[] = {
+static struct of_device_id __initdata power_match[] = {
 	{
 		.name = "power",
 	},
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index ea05038..209e7d2 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -438,7 +438,7 @@ static int __devinit rtc_probe(struct of_device *op, const struct of_device_id *
 	return platform_device_register(&rtc_cmos_device);
 }
 
-static struct of_device_id rtc_match[] = {
+static struct of_device_id __initdata rtc_match[] = {
 	{
 		.name = "rtc",
 		.compatible = "m5819",
@@ -482,7 +482,7 @@ static int __devinit bq4802_probe(struct of_device *op, const struct of_device_i
 	return platform_device_register(&rtc_bq4802_device);
 }
 
-static struct of_device_id bq4802_match[] = {
+static struct of_device_id __initdata bq4802_match[] = {
 	{
 		.name = "rtc",
 		.compatible = "bq4802",
@@ -566,7 +566,7 @@ static int __devinit mostek_probe(struct of_device *op, const struct of_device_i
 	return platform_device_register(&m48t59_rtc);
 }
 
-static struct of_device_id mostek_match[] = {
+static struct of_device_id __initdata mostek_match[] = {
 	{
 		.name = "eeprom",
 	},
diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index c2fa9fd..937c9c0 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -2685,7 +2685,7 @@ static int __devexit fore200e_sba_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id fore200e_sba_match[] = {
+static const struct of_device_id fore200e_sba_match[] = {
 	{
 		.name = SBA200E_PROM_NAME,
 		.data = (void *) &fore200e_bus[1],
diff --git a/drivers/char/hw_random/n2-drv.c b/drivers/char/hw_random/n2-drv.c
index 5220f54..8859aea 100644
--- a/drivers/char/hw_random/n2-drv.c
+++ b/drivers/char/hw_random/n2-drv.c
@@ -736,7 +736,7 @@ static int __devexit n2rng_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id n2rng_match[] = {
+static const struct of_device_id n2rng_match[] = {
 	{
 		.name		= "random-number-generator",
 		.compatible	= "SUNW,n2-rng",
diff --git a/drivers/hwmon/ultra45_env.c b/drivers/hwmon/ultra45_env.c
index 9aec95c..68e90ab 100644
--- a/drivers/hwmon/ultra45_env.c
+++ b/drivers/hwmon/ultra45_env.c
@@ -290,7 +290,7 @@ static int __devexit env_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id env_match[] = {
+static const struct of_device_id env_match[] = {
 	{
 		.name = "env-monitor",
 		.compatible = "SUNW,ebus-pic16f747-env",
diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
index d8765cc..c4f4231 100644
--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -249,7 +249,7 @@ static int bbc_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id bbc_beep_match[] = {
+static const struct of_device_id bbc_beep_match[] = {
 	{
 		.name = "beep",
 		.compatible = "SUNW,bbc-beep",
@@ -328,7 +328,7 @@ static int grover_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id grover_beep_match[] = {
+static const struct of_device_id grover_beep_match[] = {
 	{
 		.name = "beep",
 		.compatible = "SUNW,smbus-beep",
diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index 692a79e..5071af2 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -87,7 +87,7 @@ static int __devexit sparc_i8042_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id sparc_i8042_match[] = {
+static const struct of_device_id sparc_i8042_match[] = {
 	{
 		.name = "8042",
 	},
diff --git a/drivers/mtd/maps/sun_uflash.c b/drivers/mtd/maps/sun_uflash.c
index e931f1d..fd7a101 100644
--- a/drivers/mtd/maps/sun_uflash.c
+++ b/drivers/mtd/maps/sun_uflash.c
@@ -138,7 +138,7 @@ static int __devexit uflash_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id uflash_match[] = {
+static const struct of_device_id uflash_match[] = {
 	{
 		.name = UFLASH_OBPNAME,
 	},
diff --git a/drivers/net/myri_sbus.c b/drivers/net/myri_sbus.c
index 03867b1..979d778 100644
--- a/drivers/net/myri_sbus.c
+++ b/drivers/net/myri_sbus.c
@@ -1125,7 +1125,7 @@ static int __devexit myri_sbus_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id myri_sbus_match[] = {
+static const struct of_device_id myri_sbus_match[] = {
 	{
 		.name = "MYRICOM,mlanai",
 	},
diff --git a/drivers/net/niu.c b/drivers/net/niu.c
index e4765b7..016d9e0 100644
--- a/drivers/net/niu.c
+++ b/drivers/net/niu.c
@@ -9074,7 +9074,7 @@ static int __devexit niu_of_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id niu_match[] = {
+static const struct of_device_id niu_match[] = {
 	{
 		.name = "network",
 		.compatible = "SUNW,niusl",
diff --git a/drivers/net/sunbmac.c b/drivers/net/sunbmac.c
index 7009a5e..3f342b3 100644
--- a/drivers/net/sunbmac.c
+++ b/drivers/net/sunbmac.c
@@ -1281,7 +1281,7 @@ static int __devexit bigmac_sbus_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id bigmac_sbus_match[] = {
+static const struct of_device_id bigmac_sbus_match[] = {
 	{
 		.name = "be",
 	},
diff --git a/drivers/net/sunhme.c b/drivers/net/sunhme.c
index dc46e97..f1ebeb5 100644
--- a/drivers/net/sunhme.c
+++ b/drivers/net/sunhme.c
@@ -3252,7 +3252,7 @@ static int __devexit hme_sbus_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id hme_sbus_match[] = {
+static const struct of_device_id hme_sbus_match[] = {
 	{
 		.name = "SUNW,hme",
 	},
diff --git a/drivers/net/sunlance.c b/drivers/net/sunlance.c
index 292feb2..30cdb81 100644
--- a/drivers/net/sunlance.c
+++ b/drivers/net/sunlance.c
@@ -1571,7 +1571,7 @@ static int __devexit sunlance_sbus_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id sunlance_sbus_match[] = {
+static const struct of_device_id sunlance_sbus_match[] = {
 	{
 		.name = "le",
 	},
diff --git a/drivers/net/sunqe.c b/drivers/net/sunqe.c
index 81604ca..f636447 100644
--- a/drivers/net/sunqe.c
+++ b/drivers/net/sunqe.c
@@ -965,7 +965,7 @@ static int __devexit qec_sbus_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id qec_sbus_match[] = {
+static const struct of_device_id qec_sbus_match[] = {
 	{
 		.name = "qe",
 	},
diff --git a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sunbpp.c
index e4f00c6..065f229 100644
--- a/drivers/parport/parport_sunbpp.c
+++ b/drivers/parport/parport_sunbpp.c
@@ -372,7 +372,7 @@ static int __devexit bpp_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id bpp_match[] = {
+static const struct of_device_id bpp_match[] = {
 	{
 		.name = "SUNW,bpp",
 	},
diff --git a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
index af7f4af..f08e169 100644
--- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -404,7 +404,7 @@ static int __devexit bbc_i2c_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id bbc_i2c_match[] = {
+static const struct of_device_id bbc_i2c_match[] = {
 	{
 		.name = "i2c",
 		.compatible = "SUNW,bbc-i2c",
diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index 2f16d78..2550af4 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -256,7 +256,7 @@ static int __devexit d7s_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id d7s_match[] = {
+static const struct of_device_id d7s_match[] = {
 	{
 		.name = "display7seg",
 	},
diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index ea8c35c..58e583b 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -1120,7 +1120,7 @@ static int __devexit envctrl_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id envctrl_match[] = {
+static const struct of_device_id envctrl_match[] = {
 	{
 		.name = "i2c",
 		.compatible = "i2cpcf,8584",
diff --git a/drivers/sbus/char/flash.c b/drivers/sbus/char/flash.c
index 715996f..4108347 100644
--- a/drivers/sbus/char/flash.c
+++ b/drivers/sbus/char/flash.c
@@ -199,7 +199,7 @@ static int __devexit flash_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id flash_match[] = {
+static const struct of_device_id flash_match[] = {
 	{
 		.name = "flashprom",
 	},
diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index 6cff977..27993c3 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -417,7 +417,7 @@ static int __devexit uctrl_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id uctrl_match[] = {
+static const struct of_device_id uctrl_match[] = {
 	{
 		.name = "uctrl",
 	},
diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index b6ce82d..4280767 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1415,7 +1415,7 @@ static int __devexit qpti_sbus_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id qpti_match[] = {
+static const struct of_device_id qpti_match[] = {
 	{
 		.name = "ptisp",
 		.data = &qpti_template,
diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index 97316ca..3d73aad 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -617,7 +617,7 @@ static int __devexit esp_sbus_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id esp_match[] = {
+static const struct of_device_id esp_match[] = {
 	{
 		.name = "SUNW,esp",
 	},
diff --git a/drivers/serial/sunhv.c b/drivers/serial/sunhv.c
index e41766d..a94a2ab 100644
--- a/drivers/serial/sunhv.c
+++ b/drivers/serial/sunhv.c
@@ -616,7 +616,7 @@ static int __devexit hv_remove(struct of_device *dev)
 	return 0;
 }
 
-static struct of_device_id hv_match[] = {
+static const struct of_device_id hv_match[] = {
 	{
 		.name = "console",
 		.compatible = "qcn",
diff --git a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
index 29b4458..0355efe 100644
--- a/drivers/serial/sunsab.c
+++ b/drivers/serial/sunsab.c
@@ -1078,7 +1078,7 @@ static int __devexit sab_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id sab_match[] = {
+static const struct of_device_id sab_match[] = {
 	{
 		.name = "se",
 	},
diff --git a/drivers/serial/sunsu.c b/drivers/serial/sunsu.c
index a378464..a4dc79b 100644
--- a/drivers/serial/sunsu.c
+++ b/drivers/serial/sunsu.c
@@ -1506,7 +1506,7 @@ static int __devexit su_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id su_match[] = {
+static const struct of_device_id su_match[] = {
 	{
 		.name = "su",
 	},
diff --git a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
index 3cb4c8a..45a299f 100644
--- a/drivers/serial/sunzilog.c
+++ b/drivers/serial/sunzilog.c
@@ -1480,7 +1480,7 @@ static int __devexit zs_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id zs_match[] = {
+static const struct of_device_id zs_match[] = {
 	{
 		.name = "zs",
 	},
diff --git a/drivers/video/bw2.c b/drivers/video/bw2.c
index e721644..1e35ba6 100644
--- a/drivers/video/bw2.c
+++ b/drivers/video/bw2.c
@@ -372,7 +372,7 @@ static int __devexit bw2_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id bw2_match[] = {
+static const struct of_device_id bw2_match[] = {
 	{
 		.name = "bwtwo",
 	},
diff --git a/drivers/video/cg14.c b/drivers/video/cg14.c
index b17e746..a2d1882 100644
--- a/drivers/video/cg14.c
+++ b/drivers/video/cg14.c
@@ -589,7 +589,7 @@ static int __devexit cg14_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id cg14_match[] = {
+static const struct of_device_id cg14_match[] = {
 	{
 		.name = "cgfourteen",
 	},
diff --git a/drivers/video/cg3.c b/drivers/video/cg3.c
index 3aa7b6c..99f87fb 100644
--- a/drivers/video/cg3.c
+++ b/drivers/video/cg3.c
@@ -456,7 +456,7 @@ static int __devexit cg3_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id cg3_match[] = {
+static const struct of_device_id cg3_match[] = {
 	{
 		.name = "cgthree",
 	},
diff --git a/drivers/video/cg6.c b/drivers/video/cg6.c
index 2f64bb3..9eaa63a 100644
--- a/drivers/video/cg6.c
+++ b/drivers/video/cg6.c
@@ -814,7 +814,7 @@ static int __devexit cg6_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id cg6_match[] = {
+static const struct of_device_id cg6_match[] = {
 	{
 		.name = "cgsix",
 	},
diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
index 7992b13..9dbb964 100644
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -1042,7 +1042,7 @@ static int __devexit ffb_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id ffb_match[] = {
+static const struct of_device_id ffb_match[] = {
 	{
 		.name = "SUNW,ffb",
 	},
diff --git a/drivers/video/leo.c b/drivers/video/leo.c
index 13fea61..465459e 100644
--- a/drivers/video/leo.c
+++ b/drivers/video/leo.c
@@ -641,7 +641,7 @@ static int __devexit leo_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id leo_match[] = {
+static const struct of_device_id leo_match[] = {
 	{
 		.name = "SUNW,leo",
 	},
diff --git a/drivers/video/p9100.c b/drivers/video/p9100.c
index 9e90345..7000f2c 100644
--- a/drivers/video/p9100.c
+++ b/drivers/video/p9100.c
@@ -349,7 +349,7 @@ static int __devexit p9100_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id p9100_match[] = {
+static const struct of_device_id p9100_match[] = {
 	{
 		.name = "p9100",
 	},
diff --git a/drivers/video/tcx.c b/drivers/video/tcx.c
index 2a03f78..643afbf 100644
--- a/drivers/video/tcx.c
+++ b/drivers/video/tcx.c
@@ -505,7 +505,7 @@ static int __devexit tcx_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id tcx_match[] = {
+static const struct of_device_id tcx_match[] = {
 	{
 		.name = "SUNW,tcx",
 	},
diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 1f1ee25..084dfe9 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -666,7 +666,7 @@ static int __devexit cpwd_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id cpwd_match[] = {
+static const struct of_device_id cpwd_match[] = {
 	{
 		.name = "watchdog",
 	},
diff --git a/drivers/watchdog/riowd.c b/drivers/watchdog/riowd.c
index 04fd1ba..09cb183 100644
--- a/drivers/watchdog/riowd.c
+++ b/drivers/watchdog/riowd.c
@@ -230,7 +230,7 @@ static int __devexit riowd_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id riowd_match[] = {
+static const struct of_device_id riowd_match[] = {
 	{
 		.name = "pmc",
 	},
diff --git a/sound/sparc/amd7930.c b/sound/sparc/amd7930.c
index 0f82c3f..5af5503 100644
--- a/sound/sparc/amd7930.c
+++ b/sound/sparc/amd7930.c
@@ -1070,7 +1070,7 @@ out_err:
 	return err;
 }
 
-static struct of_device_id amd7930_match[] = {
+static const struct of_device_id amd7930_match[] = {
 	{
 		.name = "audio",
 	},
diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index cdbfae9..727438d 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -2094,7 +2094,7 @@ static int __devexit cs4231_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id cs4231_match[] = {
+static const struct of_device_id cs4231_match[] = {
 	{
 		.name = "SUNW,CS4231",
 	},
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 446f985..2edb0ad 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2665,7 +2665,7 @@ static int __devexit dbri_remove(struct of_device *op)
 	return 0;
 }
 
-static struct of_device_id dbri_match[] = {
+static const struct of_device_id dbri_match[] = {
 	{
 		.name = "SUNW,DBRIe",
 	},
-- 
1.5.6.5.GIT

