From: Frans Pop <elendil@planet.nl>
Date: Tue, 17 Jun 2008 11:53:48 +0000
Subject: [PATCH] sparc: correct module name in Kconfig help for SCSI_SUNESP
Message-Id: <200806171353.49127.elendil@planet.nl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans Pop <elendil@planet.nl>

The module name was changed from esp to sun_esp some time ago.
    
Signed-off-by: Frans Pop <elendil@planet.nl>
---

Should the help text maybe also mention that it supports SUNW,fas devices?
It's still SBUS of course, but it may not be immediately obvious that esp 
also covers fas.


diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 81ccbd7..0632552 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1741,7 +1741,7 @@ config SCSI_SUNESP
 	  chipset is present in most SPARC SBUS-based computers.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called esp.
+	  module will be called sun_esp.
 
 config ZFCP
 	tristate "FCP host bus adapter driver for IBM eServer zSeries"
