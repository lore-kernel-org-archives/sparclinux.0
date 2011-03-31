From: David Miller <davem@davemloft.net>
Date: Thu, 31 Mar 2011 00:38:18 +0000
Subject: [PATCH] sparc64: Fix section mis-match errors.
Message-Id: <20110330.173818.186308353.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Fix all of the problems spotted by CONFIG_DEBUG_SECTION_MISMATCH under
arch/sparc during a 64-bit defconfig build.

They fall into two categorites:

1) of_device_id is marked as __initdata, and we can never do this
   since these objects sit in the device core data structures way
   past boot.  So even if a driver will never be reloaded, we have
   to keep the device ID table around.

   Mark such cases const instead.

2) The bootmem alloc/free handling code in mdesc.c was not fully
   marked __init as it should be, thus generating a reference
   to free_bootmem_late() (which is __init) from non-__init code.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/auxio_64.c   |    2 +-
 arch/sparc/kernel/central.c    |    4 ++--
 arch/sparc/kernel/ds.c         |    2 +-
 arch/sparc/kernel/mdesc.c      |    2 +-
 arch/sparc/kernel/pci_fire.c   |    2 +-
 arch/sparc/kernel/pci_psycho.c |    2 +-
 arch/sparc/kernel/pci_sabre.c  |    2 +-
 arch/sparc/kernel/pci_schizo.c |    2 +-
 arch/sparc/kernel/pci_sun4v.c  |    2 +-
 arch/sparc/kernel/power.c      |    2 +-
 arch/sparc/kernel/time_64.c    |    6 +++---
 11 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/kernel/auxio_64.c b/arch/sparc/kernel/auxio_64.c
index 2abace0..773091a 100644
--- a/arch/sparc/kernel/auxio_64.c
+++ b/arch/sparc/kernel/auxio_64.c
@@ -93,7 +93,7 @@ void auxio_set_lte(int on)
 }
 EXPORT_SYMBOL(auxio_set_lte);
 
-static struct of_device_id __initdata auxio_match[] = {
+static const struct of_device_id auxio_match[] = {
 	{
 		.name = "auxio",
 	},
diff --git a/arch/sparc/kernel/central.c b/arch/sparc/kernel/central.c
index 136d371..7eef3f7 100644
--- a/arch/sparc/kernel/central.c
+++ b/arch/sparc/kernel/central.c
@@ -140,7 +140,7 @@ out_free:
 	goto out;
 }
 
-static struct of_device_id __initdata clock_board_match[] = {
+static const struct of_device_id clock_board_match[] = {
 	{
 		.name = "clock-board",
 	},
@@ -245,7 +245,7 @@ out_free:
 	goto out;
 }
 
-static struct of_device_id __initdata fhc_match[] = {
+static const struct of_device_id fhc_match[] = {
 	{
 		.name = "fhc",
 	},
diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index 4a700f4..3add4de 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -1218,7 +1218,7 @@ static int ds_remove(struct vio_dev *vdev)
 	return 0;
 }
 
-static struct vio_device_id __initdata ds_match[] = {
+static const struct vio_device_id ds_match[] = {
 	{
 		.type = "domain-services-port",
 	},
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 6addb91..56db064 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -107,7 +107,7 @@ static struct mdesc_handle * __init mdesc_memblock_alloc(unsigned int mdesc_size
 	return hp;
 }
 
-static void mdesc_memblock_free(struct mdesc_handle *hp)
+static void __init mdesc_memblock_free(struct mdesc_handle *hp)
 {
 	unsigned int alloc_size;
 	unsigned long start;
diff --git a/arch/sparc/kernel/pci_fire.c b/arch/sparc/kernel/pci_fire.c
index 3d70f83..d29a32f 100644
--- a/arch/sparc/kernel/pci_fire.c
+++ b/arch/sparc/kernel/pci_fire.c
@@ -496,7 +496,7 @@ out_err:
 	return err;
 }
 
-static struct of_device_id __initdata fire_match[] = {
+static const struct of_device_id fire_match[] = {
 	{
 		.name = "pci",
 		.compatible = "pciex108e,80f0",
diff --git a/arch/sparc/kernel/pci_psycho.c b/arch/sparc/kernel/pci_psycho.c
index 56ee745..86ae08d 100644
--- a/arch/sparc/kernel/pci_psycho.c
+++ b/arch/sparc/kernel/pci_psycho.c
@@ -592,7 +592,7 @@ out_err:
 	return err;
 }
 
-static struct of_device_id __initdata psycho_match[] = {
+static const struct of_device_id psycho_match[] = {
 	{
 		.name = "pci",
 		.compatible = "pci108e,8000",
diff --git a/arch/sparc/kernel/pci_sabre.c b/arch/sparc/kernel/pci_sabre.c
index 2857073..948068a 100644
--- a/arch/sparc/kernel/pci_sabre.c
+++ b/arch/sparc/kernel/pci_sabre.c
@@ -581,7 +581,7 @@ out_err:
 	return err;
 }
 
-static struct of_device_id __initdata sabre_match[] = {
+static const struct of_device_id sabre_match[] = {
 	{
 		.name = "pci",
 		.compatible = "pci108e,a001",
diff --git a/arch/sparc/kernel/pci_schizo.c b/arch/sparc/kernel/pci_schizo.c
index 1d41af7..fecfcb2 100644
--- a/arch/sparc/kernel/pci_schizo.c
+++ b/arch/sparc/kernel/pci_schizo.c
@@ -1470,7 +1470,7 @@ static int __devinit schizo_probe(struct platform_device *op)
  * and pci108e,8001.  So list the chips in reverse chronological
  * order.
  */
-static struct of_device_id __initdata schizo_match[] = {
+static const struct of_device_id schizo_match[] = {
 	{
 		.name = "pci",
 		.compatible = "pci108e,a801",
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 6cf5346..b01a06e 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -998,7 +998,7 @@ out_err:
 	return err;
 }
 
-static struct of_device_id __initdata pci_sun4v_match[] = {
+static const struct of_device_id pci_sun4v_match[] = {
 	{
 		.name = "pci",
 		.compatible = "SUNW,sun4v-pci",
diff --git a/arch/sparc/kernel/power.c b/arch/sparc/kernel/power.c
index cd725fe..cb4c0f5 100644
--- a/arch/sparc/kernel/power.c
+++ b/arch/sparc/kernel/power.c
@@ -52,7 +52,7 @@ static int __devinit power_probe(struct platform_device *op)
 	return 0;
 }
 
-static struct of_device_id __initdata power_match[] = {
+static const struct of_device_id power_match[] = {
 	{
 		.name = "power",
 	},
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 95ec25f..2b8d54b 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -442,7 +442,7 @@ static int __devinit rtc_probe(struct platform_device *op)
 	return platform_device_register(&rtc_cmos_device);
 }
 
-static struct of_device_id __initdata rtc_match[] = {
+static const struct of_device_id rtc_match[] = {
 	{
 		.name = "rtc",
 		.compatible = "m5819",
@@ -487,7 +487,7 @@ static int __devinit bq4802_probe(struct platform_device *op)
 	return platform_device_register(&rtc_bq4802_device);
 }
 
-static struct of_device_id __initdata bq4802_match[] = {
+static const struct of_device_id bq4802_match[] = {
 	{
 		.name = "rtc",
 		.compatible = "bq4802",
@@ -552,7 +552,7 @@ static int __devinit mostek_probe(struct platform_device *op)
 	return platform_device_register(&m48t59_rtc);
 }
 
-static struct of_device_id __initdata mostek_match[] = {
+static const struct of_device_id mostek_match[] = {
 	{
 		.name = "eeprom",
 	},
-- 
1.7.4.2

