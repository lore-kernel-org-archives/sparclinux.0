From: Roland Dreier <roland@topspin.com>
Date: Thu, 30 Dec 2004 06:14:36 +0000
Subject: [PATCH] Hook up drivers/infiniband/Kconfig to sparc32
Message-Id: <52u0q4cnxv.fsf@topspin.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Feel free to drop if this doesn't seem worthwhile...

I'm not sure what the probability of someone putting an InfiniBand HCA
in a sparc32 machine is, but this hooks up the new Kconfig file to the
main arch/sparc Kconfig file.

Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-bk/arch/sparc/Kconfig
=================================--- linux-bk.orig/arch/sparc/Kconfig	2004-12-29 22:05:28.716051125 -0800
+++ linux-bk/arch/sparc/Kconfig	2004-12-29 22:11:00.292036332 -0800
@@ -376,6 +376,8 @@
 
 source "drivers/usb/Kconfig"
 
+source "drivers/infiniband/Kconfig"
+
 source "drivers/char/watchdog/Kconfig"
 
 source "arch/sparc/Kconfig.debug"
