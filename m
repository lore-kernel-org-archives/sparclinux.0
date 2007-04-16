From: David Miller <davem@davemloft.net>
Date: Mon, 16 Apr 2007 20:43:41 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070416.134341.28789185.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Adam Kropelin" <akropel1@rochester.rr.com>
Date: Sun, 15 Apr 2007 12:03:26 -0400

> I hit a small build glitch: Wwith the new driver, the combination...
>     CONFIG_SCSI_SPI_ATTRS=m
>     CONFIG_SCSI_SUNESP=y
> 

Missing Kconfig bits, I'll fix this with the following
patch thanks:

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 4cd280e..5e5ae79 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1766,6 +1766,7 @@ config SUN3X_ESP
 config SCSI_SUNESP
 	tristate "Sparc ESP Scsi Driver"
 	depends on SBUS && SCSI
+	select SCSI_SPI_ATTRS
 	help
 	  This is the driver for the Sun ESP SCSI host adapter. The ESP
 	  chipset is present in most SPARC SBUS-based computers.
