From: Raphael Assenat <raph@raphnet.net>
Date: Fri, 24 Jun 2005 16:38:01 +0000
Subject: [patch] Add some compat ioctl for ppdev
Message-Id: <20050624163801.GA24370@midgar.vault.raphnet.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
The following patch adds some ioctls to include/linux/compat_ioctl.h
to allow using ppdev from the 32 bit user space on sparc64.

This patch also adds the PPDEV option in the sparc64 menu, near Parallel
printer support in the 'General machine setup' submenu.

All those ioctls seem to be compatible, since (correct me if I'm wrong)
they dont use the 'long' type. See include/linux/ppdev.h.

The application I used to test the new ioctls only used the following:
PPEXCL
PPCLAIM
PPNEGOT
PPGETMODES
PPRCONTROL
PPWCONTROL
PPDATADIR
PPWDATA
PPRDATA

But I beleive that the other ioctls will work fine.

Please consider applying.

Regards,
Raphael Assenat




--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ppdev.diff"

diff -Nru -X linux-2.6.12/Documentation/dontdiff linux-2.6.11.12/arch/sparc64/Kconfig linux-2.6.11.12-raph/arch/sparc64/Kconfig
--- linux-2.6.11.12/arch/sparc64/Kconfig	2005-04-29 21:31:16.000000000 -0400
+++ linux-2.6.11.12-raph/arch/sparc64/Kconfig	2005-06-18 20:10:20.000000000 -0400
@@ -422,6 +422,24 @@
 	  If you have more than 8 printers, you need to increase the LP_NO
 	  macro in lp.c and the PARPORT_MAX macro in parport.h.
 
+config PPDEV
+	tristate "Support for user-space parallel port device drivers"
+	depends on PARPORT
+	---help---
+	  Saying Y to this adds support for /dev/parport device nodes.  This
+	  is needed for programs that want portable access to the parallel
+	  port, for instance deviceid (which displays Plug-and-Play device
+	  IDs).
+
+	  This is the parallel port equivalent of SCSI generic support (sg).
+	  It is safe to say N to this -- it is not needed for normal printing
+	  or parallel port CD-ROM/disk support.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ppdev.
+
+	  If unsure, say N.
+
 config ENVCTRL
 	tristate "SUNW, envctrl support"
 	depends on PCI
diff -Nru -X linux-2.6.12/Documentation/dontdiff linux-2.6.11.12/include/linux/compat_ioctl.h linux-2.6.11.12-raph/include/linux/compat_ioctl.h
--- linux-2.6.11.12/include/linux/compat_ioctl.h	2005-04-29 21:32:06.000000000 -0400
+++ linux-2.6.11.12-raph/include/linux/compat_ioctl.h	2005-06-18 21:15:26.000000000 -0400
@@ -345,10 +345,27 @@
 /* LP */
 COMPATIBLE_IOCTL(LPGETSTATUS)
 /* ppdev */
+COMPATIBLE_IOCTL(PPSETMODE)
+COMPATIBLE_IOCTL(PPRSTATUS)
+COMPATIBLE_IOCTL(PPRCONTROL)
+COMPATIBLE_IOCTL(PPWCONTROL)
+COMPATIBLE_IOCTL(PPFCONTROL)
+COMPATIBLE_IOCTL(PPRDATA)
+COMPATIBLE_IOCTL(PPWDATA)
 COMPATIBLE_IOCTL(PPCLAIM)
 COMPATIBLE_IOCTL(PPRELEASE)
-COMPATIBLE_IOCTL(PPEXCL)
 COMPATIBLE_IOCTL(PPYIELD)
+COMPATIBLE_IOCTL(PPEXCL)
+COMPATIBLE_IOCTL(PPDATADIR)
+COMPATIBLE_IOCTL(PPNEGOT)
+COMPATIBLE_IOCTL(PPWCTLONIRQ)
+COMPATIBLE_IOCTL(PPCLRIRQ)
+COMPATIBLE_IOCTL(PPSETPHASE)
+COMPATIBLE_IOCTL(PPGETMODES)
+COMPATIBLE_IOCTL(PPGETMODE)
+COMPATIBLE_IOCTL(PPGETPHASE)
+COMPATIBLE_IOCTL(PPGETFLAGS)
+COMPATIBLE_IOCTL(PPSETFLAGS)
 /* CDROM stuff */
 COMPATIBLE_IOCTL(CDROMPAUSE)
 COMPATIBLE_IOCTL(CDROMRESUME)

--OXfL5xGRrasGEqWY--
