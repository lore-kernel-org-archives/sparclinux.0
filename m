From: Randy Dunlap <rdunlap@xenotime.net>
Date: Wed, 09 Jul 2008 20:48:44 +0000
Subject: [PATCH] sparc64: Config category "Processor type and features"
Message-Id: <20080709134844.ab7c559f.rdunlap@xenotime.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

kernel bugzilla #11059:

sparc64 config menu is missing "Processor type and features",
so add that and move General Setup before Processor menu.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/sparc64/Kconfig |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20080709.orig/arch/sparc64/Kconfig
+++ linux-next-20080709/arch/sparc64/Kconfig
@@ -81,6 +81,10 @@ config GENERIC_HARDIRQS_NO__DO_IRQ
 	bool
 	def_bool y
 
+source "init/Kconfig"
+
+menu "Processor type and features"
+
 choice
 	prompt "Kernel page size"
 	default SPARC64_PAGE_SIZE_8KB
@@ -128,14 +132,10 @@ config HOTPLUG_CPU
 	  can be controlled through /sys/devices/system/cpu/cpu#.
 	  Say N if you want to disable CPU hotplug.
 
-source "init/Kconfig"
-
 config GENERIC_HARDIRQS
 	bool
 	default y
 
-menu "General machine setup"
-
 source "kernel/time/Kconfig"
 
 config SMP


---
~Randy
Linux Plumbers Conference, 17-19 September 2008, Portland, Oregon USA
http://linuxplumbersconf.org/
