From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 04 Mar 2005 05:31:27 +0000
Subject: [PATCH 2.6] Silence missing CONFIG_ symbol noise
Message-Id: <1109914288.17038.64.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-EXL2dsJFtQ6bXwu2zA/P"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-EXL2dsJFtQ6bXwu2zA/P
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

For sparc/sparc64, there are CONFIG_ symbols which are undefined.
On sparc64, CONFIG_AGP and CONFIG_AGP_INTEL are undefined.
On sparc, CONFIG_I2C, CONFIG_I2C_ALGOBIT, CONFIG_AGP, CONFIG_AGP_INTEL,
CONFIG_VIDEO_DEV, and CONFIG_ISP1301_OMAP are undefined.
This causes errors like "config:1234: trying to assign nonexistent
symbol FOO" to be thrown when the kernel config tools are run.

The reason that these CONFIG_ symbols are undefined is because the
hardware isn't supported by sparc/sparc64, but other supported hardware
resides in the same .config files pulled in by the various driver
Kconfig files.

Rather than hacking up the driver Kconfig files, I've created a new
arch-specific Kconfig.undefined file, where these (and future) undefined
symbols can be added for sparc/sparc64. This Kconfig.undefined file is
sourced by arch/{sparc,sparc64}/Kconfig, before the driver Kconfigs are
sourced.

The end result is that the undefined CONFIG_ symbol errors are not
thrown when the config utilities are run. The errors are not fatal, but
they do cause confusion when users are building kernels for
sparc/sparc64.

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
---
Tom "spot" Callaway: Red Hat Sales Engineer || GPG Fingerprint: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-EXL2dsJFtQ6bXwu2zA/P
Content-Disposition: attachment; filename=linux-2.6.10-sparc-undefinedsymbolfix.patch
Content-Type: text/x-patch; name=linux-2.6.10-sparc-undefinedsymbolfix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.10/arch/sparc64/Kconfig.BAD	2005-01-05 11:10:53.150117411 -0500
+++ linux-2.6.10/arch/sparc64/Kconfig	2005-01-05 11:34:04.610583267 -0500
@@ -579,6 +579,8 @@ config DRM_R128
 
 endmenu
 
+source "arch/sparc64/Kconfig.undefined"
+
 source "drivers/input/Kconfig"
 
 source "drivers/i2c/Kconfig"
--- linux-2.6.10/arch/sparc64/Kconfig.undefined.BAD	2005-01-05 11:34:41.337999851 -0500
+++ linux-2.6.10/arch/sparc64/Kconfig.undefined	2005-01-05 11:33:30.630748987 -0500
@@ -0,0 +1,10 @@
+# Little hack to cleanup undefined symbols
+# Note: These are not viable config options for this architecture.
+
+config AGP
+	bool
+	depends on BROKEN
+
+config AGP_INTEL
+	bool
+	depends on BROKEN
--- linux-2.6.10/arch/sparc/Kconfig.BAD	2005-01-05 11:10:04.183561459 -0500
+++ linux-2.6.10/arch/sparc/Kconfig	2005-01-05 11:34:31.598480483 -0500
@@ -367,6 +367,8 @@ config UNIX98_PTY_COUNT
 
 endmenu
 
+source "arch/sparc/Kconfig.undefined"
+
 source "drivers/input/Kconfig"
 
 source "fs/Kconfig"
--- linux-2.6.10/arch/sparc/Kconfig.undefined.BAD	2005-01-05 11:32:17.815818539 -0500
+++ linux-2.6.10/arch/sparc/Kconfig.undefined	2005-01-05 11:32:10.322957627 -0500
@@ -0,0 +1,27 @@
+# Little hack to clean up undefined symbols
+# Note: These are not viable config options for this architecture.
+
+config I2C
+	bool
+	depends on BROKEN
+
+config I2C_ALGOBIT
+	bool
+	depends on BROKEN
+
+config AGP
+	bool
+	depends on BROKEN
+
+config AGP_INTEL
+	bool
+	depends on BROKEN
+
+config VIDEO_DEV
+	bool
+	depends on BROKEN
+
+config ISP1301_OMAP
+	bool
+	depends on BROKEN
+

--=-EXL2dsJFtQ6bXwu2zA/P--

