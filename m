From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 20 Jul 2017 05:00:55 +0000
Subject: [RESEND PATCH] sparc: defconfig: Cleanup from old Kconfig options
Message-Id: <1500526855-4132-1-git-send-email-krzk@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Remove old, dead Kconfig options (in order appearing in this commit):
 - EXPERIMENTAL is gone since v3.9;
 - INET_LRO: commit 7bbf3cae65b6 ("ipv4: Remove inet_lro library");
 - AUTOFS_FS: commit 561c5cf9236a ("staging: Remove autofs3");
 - RCU_CPU_STALL_DETECTOR: commit a00e0d714fbd ("rcu: Remove conditional
   compilation for RCU CPU stall warnings");
 - USB_DEVICE_CLASS: commit 007bab91324e ("USB: remove
   CONFIG_USB_DEVICE_CLASS");
 - SYSCTL_SYSCALL_CHECK: commit 7c60c48f58a7 ("sysctl: Improve the
   sysctl sanity checks");

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/configs/sparc32_defconfig | 4 ----
 arch/sparc/configs/sparc64_defconfig | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/sparc/configs/sparc32_defconfig b/arch/sparc/configs/sparc32_defconfig
index c74d3701ad68..207a43a2d8b3 100644
--- a/arch/sparc/configs/sparc32_defconfig
+++ b/arch/sparc/configs/sparc32_defconfig
@@ -1,4 +1,3 @@
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT
@@ -23,7 +22,6 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_INET_AH=y
 CONFIG_INET_ESP=y
 CONFIG_INET_IPCOMP=y
-# CONFIG_INET_LRO is not set
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
@@ -69,7 +67,6 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 CONFIG_ISO9660_FS=m
 CONFIG_PROC_KCORE=y
@@ -82,7 +79,6 @@ CONFIG_NLS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_KGDB=y
 CONFIG_KGDB_TESTS=y
 CONFIG_CRYPTO_NULL=m
diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index b2e650d1764f..ca8609d7292f 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -1,5 +1,4 @@
 CONFIG_64BIT=y
-CONFIG_EXPERIMENTAL=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -184,7 +183,6 @@ CONFIG_HID_TOPSEED=y
 CONFIG_HID_THRUSTMASTER=y
 CONFIG_HID_ZEROPLUS=y
 CONFIG_USB=y
-# CONFIG_USB_DEVICE_CLASS is not set
 CONFIG_USB_EHCI_HCD=m
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
 CONFIG_USB_OHCI_HCD=y
@@ -210,8 +208,6 @@ CONFIG_LOCKUP_DETECTOR=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_SCHEDSTATS=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_UPROBE_EVENTS=y
 CONFIG_KEYS=y
-- 
2.7.4

