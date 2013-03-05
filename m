From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 05 Mar 2013 17:04:21 +0000
Subject: [PATCH v3] sparc,leon: updated GRPCI2 config name
Message-Id: <1362503061-31756-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/Kconfig         |    2 +-
 arch/sparc/kernel/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index ad5ad8f..dbc7082 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -511,7 +511,7 @@ config SPARC_GRPCI1
 	  from the bootloader that makes the GRPCI to generate interrupts
 	  on detected PCI Parity and System errors.
 
-config GRPCI2
+config SPARC_GRPCI2
 	bool "GRPCI2 Host Bridge Support"
 	depends on LEON_PCI
 	default y
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index c90a2a0..d2936d0 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -74,7 +74,7 @@ obj-y                     += dma.o
 
 obj-$(CONFIG_PCIC_PCI)    += pcic.o
 obj-$(CONFIG_LEON_PCI)    += leon_pci.o
-obj-$(CONFIG_GRPCI2)      += leon_pci_grpci2.o
+obj-$(CONFIG_SPARC_GRPCI2)+= leon_pci_grpci2.o
 obj-$(CONFIG_SPARC_GRPCI1)+= leon_pci_grpci1.o
 
 obj-$(CONFIG_SMP)         += trampoline_$(BITS).o smp_$(BITS).o
-- 
1.7.0.4

