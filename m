From: Corentin Labbe <clabbe@baylibre.com>
Date: Mon, 18 Jan 2021 08:23:45 +0000
Subject: [PATCH v2] sparc: sparc64_defconfig: add necessary configs for qemu
Message-Id: <20210118082345.16163-1-clabbe@baylibre.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>

The sparc64 qemu machines uses sunhme network hardware by default, so for
simple NFS boot testing using qemu, having CONFIG_HAPPYMEAL is useful.
And so we need also IP_PNP_DHCP for NFS boot.
For the same reason we need to enable its storage which is a PATA_CMD64.
And finally, we need CONFIG_DEVTMPFS for handling recent udev/systemd.

All those options will permit to enable boot testing in both kernelCI
and gentoo's kernelCI.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Changes since v1:
- Added CONFIG_DEVTMPFS for udev
- Changed PCNET32 to HAPPYMEAL, as the default netword card is sunhme

 arch/sparc/configs/sparc64_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index bde4d21a8ac8..439ec8bc6dca 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -236,3 +236,9 @@ CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRC16=m
 CONFIG_LIBCRC32C=m
 CONFIG_VCC=m
+CONFIG_ATA=y
+CONFIG_PATA_CMD64X=y
+CONFIG_HAPPYMEAL=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_DEVTMPFS=y
-- 
2.26.2
