From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Wed, 09 May 2018 13:18:53 +0000
Subject: [PATCH v2 10/11] arch/*: Kconfig: fix documentation for NMI watchdog
Message-Id: <30b7698983a917b736088821420ac0c3bd9f9a0f.1525870886.git.mchehab+samsung@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525870886.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Changeset 9919cba7ff71 ("watchdog: Update documentation") updated
the documentation, removing the old nmi_watchdog.txt and adding
a file with a new content.

Update Kconfig files accordingly.

Fixes: 9919cba7ff71 ("watchdog: Update documentation")

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 arch/arm/Kconfig    | 2 +-
 arch/parisc/Kconfig | 2 +-
 arch/sh/Kconfig     | 2 +-
 arch/sparc/Kconfig  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7f8e7f4b88f..7b4fa8356978 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1305,7 +1305,7 @@ config SMP
 	  will run faster if you say N here.
 
 	  See also <file:Documentation/x86/i386/IO-APIC.txt>,
-	  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
+	  <file:Documentation/lockup-watchdogs.txt> and the SMP-HOWTO available at
 	  <http://tldp.org/HOWTO/SMP-HOWTO.html>.
 
 	  If you don't know what to do here, say N.
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index fc5a574c3482..b6823215cc9a 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -279,7 +279,7 @@ config SMP
 	  machines, but will use only one CPU of a multiprocessor machine.
 	  On a uniprocessor machine, the kernel will run faster if you say N.
 
-	  See also <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO
+	  See also <file:Documentation/lockup-watchdogs.txt> and the SMP-HOWTO
 	  available at <http://www.tldp.org/docs.html#howto>.
 
 	  If you don't know what to do here, say N.
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 97fe29316476..bf628dd7c195 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -689,7 +689,7 @@ config SMP
 	  People using multiprocessor machines who say Y here should also say
 	  Y to "Enhanced Real Time Clock Support", below.
 
-	  See also <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO
+	  See also <file:Documentation/lockup-watchdogs.txt> and the SMP-HOWTO
 	  available at <http://www.tldp.org/docs.html#howto>.
 
 	  If you don't know what to do here, say N.
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8767e45f1b2b..66171c2e428b 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -189,7 +189,7 @@ config SMP
 	  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
 	  Management" code will be disabled if you say Y here.
 
-	  See also <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO
+	  See also <file:Documentation/lockup-watchdogs.txt> and the SMP-HOWTO
 	  available at <http://www.tldp.org/docs.html#howto>.
 
 	  If you don't know what to do here, say N.
-- 
2.17.0

