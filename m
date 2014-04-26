From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 Apr 2014 07:57:35 +0000
Subject: [PATCH 2/4] sparc32: replace flip_dword() with swab32()
Message-Id: <1398499057-21497-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The latter is a generic implmentation.
flip_{,d}word() is sparc32 specific and will be dropped.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/leon_pci_grpci1.c | 4 ++--
 arch/sparc/kernel/leon_pci_grpci2.c | 4 ++--
 arch/sparc/kernel/pcic.c            | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/leon_pci_grpci1.c b/arch/sparc/kernel/leon_pci_grpci1.c
index 97cba4d..c8bf26e 100644
--- a/arch/sparc/kernel/leon_pci_grpci1.c
+++ b/arch/sparc/kernel/leon_pci_grpci1.c
@@ -144,7 +144,7 @@ static int grpci1_cfg_r32(struct grpci1_priv *priv, unsigned int bus,
 		grpci1_cfg_w32(priv, TGT, 0, PCI_COMMAND, tmp);
 	} else {
 		/* Bus always little endian (unaffected by byte-swapping) */
-		*val = flip_dword(tmp);
+		*val = swab32(tmp);
 	}
 
 	return 0;
@@ -197,7 +197,7 @@ static int grpci1_cfg_w32(struct grpci1_priv *priv, unsigned int bus,
 
 	pci_conf = (unsigned int *) (priv->pci_conf |
 						(devfn << 8) | (where & 0xfc));
-	LEON3_BYPASS_STORE_PA(pci_conf, flip_dword(val));
+	LEON3_BYPASS_STORE_PA(pci_conf, swab32(val));
 
 	return 0;
 }
diff --git a/arch/sparc/kernel/leon_pci_grpci2.c b/arch/sparc/kernel/leon_pci_grpci2.c
index 7ef0247..e433a4d 100644
--- a/arch/sparc/kernel/leon_pci_grpci2.c
+++ b/arch/sparc/kernel/leon_pci_grpci2.c
@@ -270,7 +270,7 @@ static int grpci2_cfg_r32(struct grpci2_priv *priv, unsigned int bus,
 		*val = 0xffffffff;
 	} else {
 		/* Bus always little endian (unaffected by byte-swapping) */
-		*val = flip_dword(tmp);
+		*val = swab32(tmp);
 	}
 
 	return 0;
@@ -328,7 +328,7 @@ static int grpci2_cfg_w32(struct grpci2_priv *priv, unsigned int bus,
 
 	pci_conf = (unsigned int *) (priv->pci_conf |
 						(devfn << 8) | (where & 0xfc));
-	LEON3_BYPASS_STORE_PA(pci_conf, flip_dword(val));
+	LEON3_BYPASS_STORE_PA(pci_conf, swab32(val));
 
 	/* Wait until GRPCI2 signals that CFG access is done, it should be
 	 * done instantaneously unless a DMA operation is ongoing...
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 09f4fdd..6996f32 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -783,7 +783,7 @@ int pcibios_enable_device(struct pci_dev *pdev, int mask)
 void pcic_nmi(unsigned int pend, struct pt_regs *regs)
 {
 
-	pend = flip_dword(pend);
+	pend = swab32(pend);
 
 	if (!pcic_speculative || (pend & PCI_SYS_INT_PENDING_PIO) = 0) {
 		/*
-- 
1.9.0

