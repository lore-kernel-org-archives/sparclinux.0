From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 27 Jun 2016 12:23:52 +0000
Subject: [PATCH] sparc64: sparc64_defconfig: convert to use libata PATA drivers
Message-Id: <1467030232-10027-1-git-send-email-b.zolnierkie@samsung.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

IDE subsystem has been deprecated since 2009 and the majority
(if not all) of Linux distributions have switched to use
libata for ATA support exclusively.  However there are still
some users (mostly old or/and embedded non-x86 systems) that
have not converted from using IDE subsystem to libata PATA
drivers.  This doesn't seem to be good thing in the long-term
for Linux as while there is less and less PATA systems left
in use:

* testing efforts are divided between two subsystems

* having duplicate drivers for same hardware confuses users

This patch converts sparc64_defconfig to use libata PATA
drivers.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/sparc/configs/sparc64_defconfig | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index e4bbc76..41609ad 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -68,19 +68,17 @@ CONFIG_CDROM_PKTCDVD=m
 CONFIG_CDROM_PKTCDVD_WCACHE=y
 CONFIG_ATA_OVER_ETH=m
 CONFIG_SUNVDC=m
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_BLK_DEV_ALI15X3=y
 CONFIG_RAID_ATTRS=m
-CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
-CONFIG_BLK_DEV_SR=m
+CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=m
 CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_SPI_ATTRS=y
 CONFIG_SCSI_FC_ATTRS=y
+CONFIG_ATA=y
+CONFIG_PATA_ALI=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=m
 CONFIG_MD_LINEAR=m
-- 
1.9.1

