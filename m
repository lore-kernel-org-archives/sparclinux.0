From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Mon, 05 Jan 2004 15:18:15 +0000
Subject: [PATCH] Fix missing module licenses
Message-Id: <1073315895.22653.86.camel@zorak>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-w70iCfEcMR0n5EBhiLkM"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-w70iCfEcMR0n5EBhiLkM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

A lot of the Sparc specific drivers are missing module licenses in 2.6,
this patch adds them as GPL.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora SPARC Linux Project Leader

"The author's mathematical treatment of the conception of purpose is
novel and highly ingenious, but heretical and, so far as the present
social order is concerned, dangerous and potentially subversive. Not to
be published." -- Aldous Huxley's "Brave New World"

--=-w70iCfEcMR0n5EBhiLkM
Content-Disposition: attachment; filename=linux-2.6.0-sparc-module-licenses.patch
Content-Type: text/x-patch; name=linux-2.6.0-sparc-module-licenses.patch; charset=
Content-Transfer-Encoding: 7bit

--- linux-2.6.0-test11/drivers/fc4/fc.c.BAD	2003-12-19 18:50:33.000000000 -0500
+++ linux-2.6.0-test11/drivers/fc4/fc.c	2003-12-19 18:50:37.000000000 -0500
@@ -1156,3 +1156,6 @@
 	kfree(p);
 	return status;
 }
+
+MODULE_LICENSE("GPL");
+
--- linux-2.6.0-test11/drivers/scsi/esp.c.BAD	2003-12-19 18:45:38.000000000 -0500
+++ linux-2.6.0-test11/drivers/scsi/esp.c	2003-12-19 18:46:10.000000000 -0500
@@ -4394,3 +4394,6 @@
 };
 
 #include "scsi_module.c"
+
+MODULE_LICENSE("GPL");
+
--- linux-2.6.0-test11/drivers/scsi/fcal.c.BAD	2003-12-19 18:46:26.000000000 -0500
+++ linux-2.6.0-test11/drivers/scsi/fcal.c	2003-12-19 18:46:32.000000000 -0500
@@ -316,3 +316,5 @@
 };
 #include "scsi_module.c"
 
+MODULE_LICENSE("GPL");
+
--- linux-2.6.0-test11/drivers/scsi/pluto.c.BAD	2003-12-19 18:46:39.000000000 -0500
+++ linux-2.6.0-test11/drivers/scsi/pluto.c	2003-12-19 18:46:45.000000000 -0500
@@ -360,3 +360,5 @@
 
 #include "scsi_module.c"
 
+MODULE_LICENSE("GPL");
+
--- linux-2.6.0-test11/drivers/scsi/qlogicpti.c.BAD	2003-12-19 18:47:11.000000000 -0500
+++ linux-2.6.0-test11/drivers/scsi/qlogicpti.c	2003-12-19 18:47:14.000000000 -0500
@@ -1554,3 +1554,6 @@
 
 
 #include "scsi_module.c"
+
+MODULE_LICENSE("GPL");
+
--- linux-2.6.0-test11/drivers/parport/parport_sunbpp.c.BAD	2003-12-19 18:51:12.000000000 -0500
+++ linux-2.6.0-test11/drivers/parport/parport_sunbpp.c	2003-12-19 18:51:22.000000000 -0500
@@ -397,3 +397,5 @@
 	}
 }
 #endif
+
+MODULE_LICENSE("GPL");
--- linux-2.6.0-test11/drivers/sbus/char/bpp.c.BAD	2003-12-19 18:47:39.000000000 -0500
+++ linux-2.6.0-test11/drivers/sbus/char/bpp.c	2003-12-19 18:47:46.000000000 -0500
@@ -1074,3 +1074,6 @@
 
 module_init(bpp_init);
 module_exit(bpp_cleanup);
+
+MODULE_LICENSE("GPL");
+
--- linux-2.6.0-test11/drivers/sbus/char/vfc_dev.c.BAD	2003-12-19 18:49:56.000000000 -0500
+++ linux-2.6.0-test11/drivers/sbus/char/vfc_dev.c	2003-12-19 18:50:00.000000000 -0500
@@ -738,4 +738,5 @@
 }
 #endif
 
+MODULE_LICENSE("GPL");
 

--=-w70iCfEcMR0n5EBhiLkM--

