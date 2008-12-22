From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 22 Dec 2008 22:14:15 +0000
Subject: [PATCH 1/5] sparc: introduce CONFIG_BITS
Message-Id: <1229984059-3743-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

CONFIG_BITS is set to 32 for sparc32
and 64 for sparc64.

This allow us to use this symbol in for example header files
to ease unification of sparc32 and sparc64.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Kconfig |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index c8c7738..cd8c585 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -46,7 +46,11 @@ config ARCH_DEFCONFIG
 	default "arch/sparc/configs/sparc32_defconfig" if SPARC32
 	default "arch/sparc/configs/sparc64_defconfig" if SPARC64
 
-
+# CONFIG_BITS can be used at source level to get 32/64 bits
+config BITS
+	int
+	default 32 if SPARC32
+	default 64 if SPARC64
 
 config 64BIT
 	def_bool y if SPARC64
-- 
1.6.0.2.GIT

