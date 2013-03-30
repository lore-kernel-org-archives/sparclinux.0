From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 30 Mar 2013 21:44:23 +0000
Subject: [PATCH 2/5] sparc: define __linux__ to fix defconfig build
Message-Id: <1364679866-29982-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The gcc version I use do not include a definition of __linux__.
Like many other archs add this to CFLAGS.

This fixes at least the following build error:
include/uapi/linux/coda.h:221: error: expected specifier-qualifier-list before 'u_quad_t'

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 541b8b0..f489626 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -14,6 +14,8 @@ else
         KBUILD_DEFCONFIG := sparc64_defconfig
 endif
 
+KBUILD_CFLAGS  += -D__linux__
+
 ifeq ($(CONFIG_SPARC32),y)
 #####
 # sparc32
-- 
1.6.0.6

