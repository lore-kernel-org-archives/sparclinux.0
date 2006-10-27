From: Jurij Smakov <jurij@wooyd.org>
Date: Fri, 27 Oct 2006 06:55:03 +0000
Subject: Problems with setting devices' bus_id on sparc32
Message-Id: <20061027065502.GA4108@droopy.oc.cox.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

While investigating Debian bug #394697 [0] on sparc32, I've found that 
in a couple of places the bus_id field of struct device is set by 
copying the dp->path_component_name (obtained from prom) without any 
length checking. In most cases it happens to work, however on 
SparcStation5 for some devices this string is over 20 chars long (like 
'power-management@4,a0000000'), and that exceeds the amount of memory 
allocated for bus_id (which is BUS_ID_SIZE == 20). So, blindly 
copying the names into bus_id using strcpy() leads to all kinds of bad 
things. The attached hackish patch replaces strcpy() by strlcpy() in 
two places, making it possible to boot SS5 again (tested in QEMU, 
where vanilla 2.6.18 fails to boot with symptoms identical to the ones
described in the bug).

[0] http://bugs.debian.org/394697

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bus-id-size.patch"

diff -aur a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
--- a/arch/sparc/kernel/of_device.c	2006-09-19 20:42:06.000000000 -0700
+++ b/arch/sparc/kernel/of_device.c	2006-10-26 22:53:50.000000000 -0700
@@ -652,7 +652,7 @@
 	if (!parent)
 		strcpy(op->dev.bus_id, "root");
 	else
-		strcpy(op->dev.bus_id, dp->path_component_name);
+		strlcpy(op->dev.bus_id, dp->path_component_name, BUS_ID_SIZE);
 
 	if (of_device_register(op)) {
 		printk("%s: Could not register of device.\n",
diff -aur a/drivers/sbus/sbus.c b/drivers/sbus/sbus.c
--- a/drivers/sbus/sbus.c	2006-09-19 20:42:06.000000000 -0700
+++ b/drivers/sbus/sbus.c	2006-10-26 22:53:19.000000000 -0700
@@ -61,7 +61,7 @@
 	else
 		sdev->ofdev.dev.parent = &sdev->bus->ofdev.dev;
 	sdev->ofdev.dev.bus = &sbus_bus_type;
-	strcpy(sdev->ofdev.dev.bus_id, dp->path_component_name);
+	strlcpy(sdev->ofdev.dev.bus_id, dp->path_component_name, BUS_ID_SIZE);
 
 	if (of_device_register(&sdev->ofdev) != 0)
 		printk(KERN_DEBUG "sbus: device registration error for %s!\n",

--lrZ03NoBR/3+SXJZ--
