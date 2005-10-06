From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Thu, 06 Oct 2005 13:34:19 +0000
Subject: [PATCH 2.6] sparc32 unresolved symbols
Message-Id: <1128605659.2140.127.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-nRPyIPxTOL/fIA8FLvpI"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-nRPyIPxTOL/fIA8FLvpI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

When compiling for sparc32, I noticed that there were some undefined
symbols, specifically:

*** Warning: "ioread8" [drivers/scsi/sym53c8xx_2/sym53c8xx.ko]
undefined!
*** Warning: "pci_iounmap" [drivers/scsi/sym53c8xx_2/sym53c8xx.ko]
undefined!
*** Warning: "iowrite8" [drivers/scsi/sym53c8xx_2/sym53c8xx.ko]
undefined!
*** Warning: "iowrite16" [drivers/scsi/sym53c8xx_2/sym53c8xx.ko]
undefined!
*** Warning: "ioread16" [drivers/scsi/sym53c8xx_2/sym53c8xx.ko]
undefined!
*** Warning: "pci_iomap" [drivers/scsi/sym53c8xx_2/sym53c8xx.ko]
undefined!
*** Warning: "iowrite32" [drivers/scsi/sym53c8xx_2/sym53c8xx.ko]
undefined!
*** Warning: "ioread32" [drivers/scsi/sym53c8xx_2/sym53c8xx.ko]
undefined!

(The sym53c8xx driver is used for the SPARCStation 2)

Not terribly difficult to fix, patch attached.

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-nRPyIPxTOL/fIA8FLvpI
Content-Disposition: attachment; filename=linux-2.6.13-sparc-genericiomap.patch
Content-Type: text/x-patch; name=linux-2.6.13-sparc-genericiomap.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.13/arch/sparc/Kconfig.BAD	2005-10-05 12:07:24.104102481 -0400
+++ linux-2.6.13/arch/sparc/Kconfig	2005-10-05 12:07:45.977777177 -0400
@@ -21,6 +21,10 @@ config GENERIC_ISA_DMA
 	bool
 	default y
 
+config GENERIC_IOMAP
+	bool
+	default y
+
 source "init/Kconfig"
 
 menu "General machine setup"
--- linux-2.6.13/arch/sparc/defconfig.BAD	2005-10-05 12:08:07.042574841 -0400
+++ linux-2.6.13/arch/sparc/defconfig	2005-10-05 12:08:19.885622401 -0400
@@ -5,6 +5,7 @@ CONFIG_MMU=y
 CONFIG_UID16=y
 CONFIG_HIGHMEM=y
 CONFIG_GENERIC_ISA_DMA=y
+CONFIG_GENERIC_IOMAP=y
 
 #
 # Code maturity level options

--=-nRPyIPxTOL/fIA8FLvpI--

