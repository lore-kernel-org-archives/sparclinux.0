From: Christoph Hellwig <hch@lst.de>
Date: Thu, 24 Sep 2020 04:15:23 +0000
Subject: [PATCH] sparc64: switch defconfig from the legacy ide driver to libata
Message-Id: <20200924041523.521143-1-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Replace the ide options with the equivalent libata options.  This has
been carried by various downstreams like the linux-build-test repo
for years already.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/configs/sparc64_defconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index bde4d21a8ac8e7..35a32adbbc59d2 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -66,9 +66,8 @@ CONFIG_CDROM_PKTCDVD=m
 CONFIG_CDROM_PKTCDVD_WCACHE=y
 CONFIG_ATA_OVER_ETH=m
 CONFIG_SUNVDC=m
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_BLK_DEV_ALI15X3=y
+CONFIG_ATA=y
+CONFIG_PATA_ALI=y
 CONFIG_RAID_ATTRS=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
-- 
2.28.0
