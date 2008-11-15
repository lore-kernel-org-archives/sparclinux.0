From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 15 Nov 2008 21:34:33 +0000
Subject: [PATCH 6/8] sparc: add menu "Executable file formats"
Message-Id: <1226784875-8829-6-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is what we use in sparc64 - make sparc equal

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Kconfig |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 3ff77f8..0a2062e 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -245,12 +245,16 @@ config SPARC_LED
 	  by reading /proc/led and its blinking mode can be changed
 	  via writes to /proc/led
 
-source "fs/Kconfig.binfmt"
-
 source "mm/Kconfig"
 
 endmenu
 
+menu "Executable file formats"
+
+source "fs/Kconfig.binfmt"
+
+endmenu
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
-- 
1.5.6.GIT

