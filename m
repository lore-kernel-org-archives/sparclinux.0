From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 29 Dec 2008 23:58:00 +0000
Subject: [PATCH 01/11] sparc: delete unused config symbols
Message-Id: <1230595090-23982-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

There is no need to define a config symbol if
it is never set to any value. Undefined symbols equal
to 'n'.

GENERIC_GPIO looks like it is similar but
it is set using select in some other file so
it must be kept.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Kconfig |   28 ----------------------------
 1 files changed, 0 insertions(+), 28 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 0a94d9c..002f7b4 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -188,14 +188,6 @@ config ARCH_MAY_HAVE_PC_FDC
 	bool
 	default y
 
-config ARCH_HAS_ILOG2_U32
-	bool
-	default n
-
-config ARCH_HAS_ILOG2_U64
-	bool
-	default n
-
 config EMULATED_CMPXCHG
 	bool
 	default y if SPARC32
@@ -442,26 +434,6 @@ config SERIAL_CONSOLE
 endmenu
 
 menu "Bus options (PCI etc.)"
-config ISA
-	bool
-	help
-	  ISA is found on Espresso only and is not supported currently.
-
-config ISAPNP
-	bool
-	help
-	  ISAPNP is not supported
-
-config EISA
-	bool
-	help
-	  EISA is not supported.
-
-config MCA
-	bool
-	help
-	  MCA is not supported.
-
 config SBUS
 	bool
 	default y
-- 
1.6.0.2.GIT

