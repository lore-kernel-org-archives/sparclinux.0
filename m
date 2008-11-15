From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 15 Nov 2008 21:34:34 +0000
Subject: [PATCH 7/8] sparc: add "Bus options" to Kconfig
Message-Id: <1226784875-8829-7-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

To align with sparc64 add a "Bus options" menu
This has the additiona advantage that all
bus options are kept together

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Kconfig |  128 +++++++++++++++++++++++++++-------------------------
 1 files changed, 67 insertions(+), 61 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 0a2062e..61a3a0c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -92,50 +92,6 @@ config NR_CPUS
 source "kernel/Kconfig.hz"
 
 # Global things across all Sun machines.
-config ISA
-	bool
-	help
-	  ISA is found on Espresso only and is not supported currently.
-	  Say N
-
-config EISA
-	bool
-	help
-	  EISA is not supported.
-	  Say N
-
-config MCA
-	bool
-	help
-	  MCA is not supported.
-	  Say N
-
-config PCMCIA
-	tristate
-	---help---
-	  Say Y here if you want to attach PCMCIA- or PC-cards to your Linux
-	  computer.  These are credit-card size devices such as network cards,
-	  modems or hard drives often used with laptops computers.  There are
-	  actually two varieties of these cards: the older 16 bit PCMCIA cards
-	  and the newer 32 bit CardBus cards.  If you want to use CardBus
-	  cards, you need to say Y here and also to "CardBus support" below.
-
-	  To use your PC-cards, you will need supporting software from David
-	  Hinds' pcmcia-cs package (see the file <file:Documentation/Changes>
-	  for location).  Please also read the PCMCIA-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>.
-
-	  To compile this driver as modules, choose M here: the
-	  modules will be called pcmcia_core and ds.
-
-config SBUS
-	bool
-	default y
-
-config SBUSCHAR
-	bool
-	default y
-
 config SERIAL_CONSOLE
 	bool
 	default y
@@ -159,14 +115,6 @@ config SERIAL_CONSOLE
 
 	  If unsure, say N.
 
-config SUN_AUXIO
-	bool
-	default y
-
-config SUN_IO
-	bool
-	default y
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
@@ -212,6 +160,73 @@ config SUN_PM
 	  Enable power management and CPU standby features on supported
 	  SPARC platforms.
 
+config SPARC_LED
+	tristate "Sun4m LED driver"
+	help
+	  This driver toggles the front-panel LED on sun4m systems
+	  in a user-specifiable manner.  Its state can be probed
+	  by reading /proc/led and its blinking mode can be changed
+	  via writes to /proc/led
+
+source "mm/Kconfig"
+
+endmenu
+
+menu "Bus options (PCI etc.)"
+config ISA
+	bool
+	help
+	  ISA is found on Espresso only and is not supported currently.
+
+config ISAPNP
+	bool
+	help
+	  ISAPNP is not supported
+
+config EISA
+	bool
+	help
+	  EISA is not supported.
+
+config MCA
+	bool
+	help
+	  MCA is not supported.
+
+config PCMCIA
+	tristate
+	---help---
+	  Say Y here if you want to attach PCMCIA- or PC-cards to your Linux
+	  computer.  These are credit-card size devices such as network cards,
+	  modems or hard drives often used with laptops computers.  There are
+	  actually two varieties of these cards: the older 16 bit PCMCIA cards
+	  and the newer 32 bit CardBus cards.  If you want to use CardBus
+	  cards, you need to say Y here and also to "CardBus support" below.
+
+	  To use your PC-cards, you will need supporting software from David
+	  Hinds' pcmcia-cs package (see the file <file:Documentation/Changes>
+	  for location).  Please also read the PCMCIA-HOWTO, available from
+	  <http://www.tldp.org/docs.html#howto>.
+
+	  To compile this driver as modules, choose M here: the
+	  modules will be called pcmcia_core and ds.
+
+config SBUS
+	bool
+	default y
+
+config SBUSCHAR
+	bool
+	default y
+
+config SUN_AUXIO
+	bool
+	default y
+
+config SUN_IO
+	bool
+	default y
+
 config PCI
 	bool "Support for PCI and PS/2 keyboard/mouse"
 	help
@@ -237,15 +252,6 @@ config SUN_OPENPROMFS
 	  Only choose N if you know in advance that you will not need to modify
 	  OpenPROM settings on the running system.
 
-config SPARC_LED
-	tristate "Sun4m LED driver"
-	help
-	  This driver toggles the front-panel LED on sun4m systems
-	  in a user-specifiable manner.  Its state can be probed
-	  by reading /proc/led and its blinking mode can be changed
-	  via writes to /proc/led
-
-source "mm/Kconfig"
 
 endmenu
 
-- 
1.5.6.GIT

