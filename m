From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 04 Jun 2019 08:00:59 +0000
Subject: [PATCH] sparc: configs: Remove useless UEVENT_HELPER_PATH
Message-Id: <1559635259-21585-1-git-send-email-krzk@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Krzysztof Kozlowski <krzk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>

Remove the CONFIG_UEVENT_HELPER_PATH because:
1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
   CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
   made default to 'n',
2. It is not recommended (help message: "This should not be used today
   [...] creates a high system load") and was kept only for ancient
   userland,
3. Certain userland specifically requests it to be disabled (systemd
   README: "Legacy hotplug slows down the system and confuses udev").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/sparc/configs/sparc32_defconfig | 1 -
 arch/sparc/configs/sparc64_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/sparc/configs/sparc32_defconfig b/arch/sparc/configs/sparc32_defconfig
index 2d4f34c52c67..7b3efe5edc1a 100644
--- a/arch/sparc/configs/sparc32_defconfig
+++ b/arch/sparc/configs/sparc32_defconfig
@@ -27,7 +27,6 @@ CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_NET_PKTGEN=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index ea547d596fcf..6c325d53a20a 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -57,7 +57,6 @@ CONFIG_IPV6_TUNNEL=m
 CONFIG_VLAN_8021Q=m
 CONFIG_NET_PKTGEN=m
 CONFIG_NET_TCPPROBE=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_LOOP=m
-- 
2.7.4
