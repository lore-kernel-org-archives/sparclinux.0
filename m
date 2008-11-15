From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 15 Nov 2008 21:34:32 +0000
Subject: [PATCH 5/8] sparc: use Kconfig.hz
Message-Id: <1226784875-8829-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We already has the proper definition in place in param.h.
So use the common Kconfig.hz file

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Kconfig |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index d460fc5..3ff77f8 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -55,10 +55,6 @@ config ARCH_NO_VIRT_TO_BUS
 config OF
 	def_bool y
 
-config HZ
-	int
-	default 100
-
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
@@ -93,6 +89,7 @@ config NR_CPUS
 	depends on SMP
 	default "32"
 
+source "kernel/Kconfig.hz"
 
 # Global things across all Sun machines.
 config ISA
-- 
1.5.6.GIT

