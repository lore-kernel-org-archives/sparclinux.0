From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 15 Nov 2008 21:34:29 +0000
Subject: [PATCH 2/8] sparc: refactor Kconfig a little
Message-Id: <1226784875-8829-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Mode declaration of SPARC up in the top
to match the structure of sparc64 Kconfig

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Kconfig |   47 ++++++++++++++++++++++++-----------------------
 1 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index e594559..c83f6f0 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -4,6 +4,30 @@
 
 mainmenu "Linux/SPARC Kernel Configuration"
 
+config SPARC
+	bool
+	default y
+	select HAVE_IDE
+	select HAVE_OPROFILE
+	select HAVE_ARCH_KGDB if !SMP
+	select HAVE_ARCH_TRACEHOOK
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select RTC_CLASS
+	select RTC_DRV_M48T59
+
+# Identify this as a Sparc32 build
+config SPARC32
+	bool
+	default y
+	help
+	  SPARC is a family of RISC microprocessors designed and marketed by
+	  Sun Microsystems, incorporated.  They are very widely found in Sun
+	  workstations and clones. This port covers the original 32-bit SPARC;
+	  it is old and stable and usually considered one of the "big three"
+	  along with the Intel and Alpha ports.  The UltraLinux project
+	  maintains both the SPARC32 and SPARC64 ports; its web page is
+	  available at <http://www.ultralinux.org/>.
+
 config MMU
 	bool
 	default y
@@ -69,29 +93,6 @@ config NR_CPUS
 	depends on SMP
 	default "32"
 
-config SPARC
-	bool
-	default y
-	select HAVE_IDE
-	select HAVE_OPROFILE
-	select HAVE_ARCH_KGDB if !SMP
-	select HAVE_ARCH_TRACEHOOK
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select RTC_CLASS
-	select RTC_DRV_M48T59
-
-# Identify this as a Sparc32 build
-config SPARC32
-	bool
-	default y
-	help
-	  SPARC is a family of RISC microprocessors designed and marketed by
-	  Sun Microsystems, incorporated.  They are very widely found in Sun
-	  workstations and clones. This port covers the original 32-bit SPARC;
-	  it is old and stable and usually considered one of the "big three"
-	  along with the Intel and Alpha ports.  The UltraLinux project
-	  maintains both the SPARC32 and SPARC64 ports; its web page is
-	  available at <http://www.ultralinux.org/>.
 
 # Global things across all Sun machines.
 config ISA
-- 
1.5.6.GIT

