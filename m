From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 20 Aug 2018 17:08:28 +0000
Subject: [PATCH] sparc: fix KBUILD_DEFCONFIG for ARCH=sparc32
Message-Id: <1534784908-11692-1-git-send-email-yamada.masahiro@socionext.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org

As commit 5ba800962a80 ("kbuild: update ARCH alias info for sparc")
addressed, SPARC accepts ARCH=sparc32 as an alias.

However, arch/sparc/Makefile wrongly sets KBUILD_DEFCONFIG, then
sparc64_defconfig is chosen as the base configuration for ARCH=sparc32.

  $ make ARCH=sparc32 defconfig
  *** Default configuration is based on 'sparc64_defconfig'
  #
  # configuration written to .config
  #

Fix the logic to choose sparc64_defconfig only when ARCH=sparc64.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sparc/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 966a13d..e32ef20 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -9,10 +9,10 @@
 # Copyright (C) 1998 Jakub Jelinek (jj@ultra.linux.cz)
 
 # We are not yet configured - so test on arch
-ifeq ($(ARCH),sparc)
-        KBUILD_DEFCONFIG := sparc32_defconfig
-else
+ifeq ($(ARCH),sparc64)
         KBUILD_DEFCONFIG := sparc64_defconfig
+else
+        KBUILD_DEFCONFIG := sparc32_defconfig
 endif
 
 ifeq ($(CONFIG_SPARC32),y)
-- 
2.7.4
