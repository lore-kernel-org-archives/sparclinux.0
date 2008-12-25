From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 25 Dec 2008 17:52:50 +0000
Subject: [PATCH 2/2] sparc: move select of ARCH_SUPPORTS_MSI
Message-Id: <20081225175250.GB8613@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

It is counter intuitive to have the select listed
as part of the PCI option.
Move the select to the SPARC64 specific part of the config.

PCI_MSI has a dependency on PCI so it does not harm to have
it always selected.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8ec81b6..0a94d9c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -31,6 +31,7 @@ config SPARC32
 config SPARC64
 	bool
 	default y if ARCH = "sparc64"
+	select ARCH_SUPPORTS_MSI
 	select HAVE_FUNCTION_TRACER
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
@@ -478,7 +479,6 @@ config SUN_LDOMS
 
 config PCI
 	bool "Support for PCI and PS/2 keyboard/mouse"
-	select ARCH_SUPPORTS_MSI if SPARC64
 	help
 	  Find out whether your system includes a PCI bus. PCI is the name of
 	  a bus system, i.e. the way the CPU talks to the other stuff inside
-- 
1.6.0.2.GIT

