From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 24 May 2011 07:04:46 +0000
Subject: [PATCH 1/3 v3] sparc32: added CONFIG_PCIC_PCI Kconfig setting
Message-Id: <1306220688-8438-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/Kconfig            |    5 +++++
 arch/sparc/include/asm/pcic.h |    2 +-
 arch/sparc/kernel/Makefile    |    2 +-
 arch/sparc/kernel/entry.S     |    4 ++--
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 63a027c..c06bd34 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -536,6 +536,11 @@ config PCI_DOMAINS
 config PCI_SYSCALL
 	def_bool PCI
 
+config PCIC_PCI
+	bool
+	depends on PCI && !SPARC_LEON
+	default y
+
 source "drivers/pci/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
diff --git a/arch/sparc/include/asm/pcic.h b/arch/sparc/include/asm/pcic.h
index 7eb5d78..6676cbc 100644
--- a/arch/sparc/include/asm/pcic.h
+++ b/arch/sparc/include/asm/pcic.h
@@ -29,7 +29,7 @@ struct linux_pcic {
 	int			pcic_imdim;
 };
 
-#ifdef CONFIG_PCI
+#ifdef CONFIG_PCIC_PCI
 extern int pcic_present(void);
 extern int pcic_probe(void);
 extern void pci_time_init(void);
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 9cff270..59a2256 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -73,7 +73,7 @@ obj-$(CONFIG_SPARC64_SMP) += cpumap.o
 
 obj-y                     += dma.o
 
-obj-$(CONFIG_SPARC32_PCI) += pcic.o
+obj-$(CONFIG_PCIC_PCI)    += pcic.o
 
 obj-$(CONFIG_SMP)         += trampoline_$(BITS).o smp_$(BITS).o
 obj-$(CONFIG_SPARC32_SMP) += sun4m_smp.o sun4d_smp.o leon_smp.o
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 8341963..6b9a321 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -1604,7 +1604,7 @@ restore_current:
 	retl
 	 nop
 
-#ifdef CONFIG_PCI
+#ifdef CONFIG_PCIC_PCI
 #include <asm/pcic.h>
 
 	.align	4
@@ -1650,7 +1650,7 @@ pcic_nmi_trap_patch:
 	 rd	%psr, %l0
 	.word	0
 
-#endif /* CONFIG_PCI */
+#endif /* CONFIG_PCI_PCIC */
 
 	.globl	flushw_all
 flushw_all:
-- 
1.6.3.3

