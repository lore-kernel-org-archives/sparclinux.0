From: Andreas Larsson <andreas@gaisler.com>
Date: Tue, 04 Dec 2012 14:09:37 +0000
Subject: [PATCH 1/2] of_i2c: sparc: Allow OF_I2C for sparc
Message-Id: <1354630178-25387-2-git-send-email-andreas@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1354630178-25387-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1354630178-25387-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: grant.likely@secretlab.ca, w.sang@pengutronix.de, sam@ravnborg.org, sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, spi-devel-general@lists.sourceforge.net, linux-i2c@vger.kernel.org, software@gaisler.com

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 drivers/of/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index dfba3e6..d37bfcf 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -53,7 +53,7 @@ config OF_DEVICE
 
 config OF_I2C
 	def_tristate I2C
-	depends on I2C && !SPARC
+	depends on I2C
 	help
 	  OpenFirmware I2C accessors
 
-- 
1.7.0.4

