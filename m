From: Meelis Roos <mroos@linux.ee>
Date: Sun, 03 Jun 2007 19:56:48 +0000
Subject: ESP wants SPI
Message-Id: <Pine.SOC.4.64.0706032254530.19546@math>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I got linakeg errors when ESP SCSI was compiled in but Parallel SCSI 
transport attributes (CONFIG_SCSI_SPI_ATTRS) were modular as before.

Should CONFIG_SCSI_SUNESP select CONFIG_SCSI_SPI_ATTRS or depend on it?

-- 
Meelis Roos (mroos@linux.ee)
