From: Corentin Labbe <clabbe@baylibre.com>
Date: Mon, 08 Mar 2021 09:51:26 +0000
Subject: [PATCH] sparc: sparc64_defconfig: remove duplicate CONFIGs
Message-Id: <20210308095126.8514-1-clabbe@baylibre.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>

After my patch there is CONFIG_ATA defined twice.
Remove the duplicate one.
Same problem for CONFIG_HAPPYMEAL, except I added as builtin for boot
test with NFS.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: a57cdeb369ef ("sparc: sparc64_defconfig: add necessary configs for qemu")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/sparc/configs/sparc64_defconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index 148f44b33890..12a4fb0bd52a 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -93,7 +93,7 @@ CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=m
 CONFIG_SUNLANCE=m
-CONFIG_HAPPYMEAL=m
+CONFIG_HAPPYMEAL=y
 CONFIG_SUNGEM=m
 CONFIG_SUNVNET=m
 CONFIG_LDMVSW=m
@@ -234,9 +234,7 @@ CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRC16=m
 CONFIG_LIBCRC32C=m
 CONFIG_VCC=m
-CONFIG_ATA=y
 CONFIG_PATA_CMD64X=y
-CONFIG_HAPPYMEAL=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_DEVTMPFS=y
-- 
2.26.2
