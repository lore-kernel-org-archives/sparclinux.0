From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 28 Feb 2013 14:31:55 +0000
Subject: [PATCH] sparc,leon: fix GRPCI2 device0 PCI config space access
Message-Id: <1362061915-634-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

bus=3D0 slot=3D0 (device0) was used internally by the PCI host driver
to access the PCI host controller itself, however that had the
effect that PCI device0 was never accessible, which is wrong
when the motherboard has connected PCI AD16 signal to a slot.
A special case for accessing the PCI host controller itself is
added with this patch, by setting bus to TGT.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/leon_pci_grpci2.c |   41 ++++++++++++++++++++++---------=
---
 1 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/kernel/leon_pci_grpci2.c b/arch/sparc/kernel/leon_p=
ci_grpci2.c
index 40fdcbc..5f0402a 100644
--- a/arch/sparc/kernel/leon_pci_grpci2.c
+++ b/arch/sparc/kernel/leon_pci_grpci2.c
@@ -186,6 +186,8 @@ struct grpci2_cap_first {
 #define CAP9_IOMAP_OFS 0x20
 #define CAP9_BARSIZE_OFS 0x24
=20
+#define TGT 256
+
 struct grpci2_priv {
 	struct leon_pci_info	info; /* must be on top of this structure */
 	struct grpci2_regs	*regs;
@@ -237,8 +239,12 @@ static int grpci2_cfg_r32(struct grpci2_priv *priv, un=
signed int bus,
 	if (where & 0x3)
 		return -EINVAL;
=20
-	if (bus =3D 0 && PCI_SLOT(devfn) !=3D 0)
-		devfn +=3D (0x8 * 6);
+	if (bus =3D 0) {
+		devfn +=3D (0x8 * 6); /* start at AD16=DEvice0 */
+	} else if (bus =3D TGT) {
+		bus =3D 0;
+		devfn =3D 0; /* special case: bridge controller itself */
+	}
=20
 	/* Select bus */
 	spin_lock_irqsave(&grpci2_dev_lock, flags);
@@ -303,8 +309,12 @@ static int grpci2_cfg_w32(struct grpci2_priv *priv, un=
signed int bus,
 	if (where & 0x3)
 		return -EINVAL;
=20
-	if (bus =3D 0 && PCI_SLOT(devfn) !=3D 0)
-		devfn +=3D (0x8 * 6);
+	if (bus =3D 0) {
+		devfn +=3D (0x8 * 6); /* start at AD16=DEvice0 */
+	} else if (bus =3D TGT) {
+		bus =3D 0;
+		devfn =3D 0; /* special case: bridge controller itself */
+	}
=20
 	/* Select bus */
 	spin_lock_irqsave(&grpci2_dev_lock, flags);
@@ -368,7 +378,7 @@ static int grpci2_read_config(struct pci_bus *bus, unsi=
gned int devfn,
 	unsigned int busno =3D bus->number;
 	int ret;
=20
-	if (PCI_SLOT(devfn) > 15 || (PCI_SLOT(devfn) =3D 0 && busno =3D 0)) {
+	if (PCI_SLOT(devfn) > 15 || busno > 255) {
 		*val =3D ~0;
 		return 0;
 	}
@@ -406,7 +416,7 @@ static int grpci2_write_config(struct pci_bus *bus, uns=
igned int devfn,
 	struct grpci2_priv *priv =3D grpci2priv;
 	unsigned int busno =3D bus->number;
=20
-	if (PCI_SLOT(devfn) > 15 || (PCI_SLOT(devfn) =3D 0 && busno =3D 0))
+	if (PCI_SLOT(devfn) > 15 || busno > 255)
 		return 0;
=20
 #ifdef GRPCI2_DEBUG_CFGACCESS
@@ -578,15 +588,15 @@ void grpci2_hw_init(struct grpci2_priv *priv)
 		REGSTORE(regs->ahbmst_map[i], priv->pci_area);
=20
 	/* Get the GRPCI2 Host PCI ID */
-	grpci2_cfg_r32(priv, 0, 0, PCI_VENDOR_ID, &priv->pciid);
+	grpci2_cfg_r32(priv, TGT, 0, PCI_VENDOR_ID, &priv->pciid);
=20
 	/* Get address to first (always defined) capability structure */
-	grpci2_cfg_r8(priv, 0, 0, PCI_CAPABILITY_LIST, &capptr);
+	grpci2_cfg_r8(priv, TGT, 0, PCI_CAPABILITY_LIST, &capptr);
=20
 	/* Enable/Disable Byte twisting */
-	grpci2_cfg_r32(priv, 0, 0, capptr+CAP9_IOMAP_OFS, &io_map);
+	grpci2_cfg_r32(priv, TGT, 0, capptr+CAP9_IOMAP_OFS, &io_map);
 	io_map =3D (io_map & ~0x1) | (priv->bt_enabled ? 1 : 0);
-	grpci2_cfg_w32(priv, 0, 0, capptr+CAP9_IOMAP_OFS, io_map);
+	grpci2_cfg_w32(priv, TGT, 0, capptr+CAP9_IOMAP_OFS, io_map);
=20
 	/* Setup the Host's PCI Target BARs for other peripherals to access,
 	 * and do DMA to the host's memory. The target BARs can be sized and
@@ -617,17 +627,18 @@ void grpci2_hw_init(struct grpci2_priv *priv)
 				pciadr =3D 0;
 			}
 		}
-		grpci2_cfg_w32(priv, 0, 0, capptr+CAP9_BARSIZE_OFS+i*4, bar_sz);
-		grpci2_cfg_w32(priv, 0, 0, PCI_BASE_ADDRESS_0+i*4, pciadr);
-		grpci2_cfg_w32(priv, 0, 0, capptr+CAP9_BAR_OFS+i*4, ahbadr);
+		grpci2_cfg_w32(priv, TGT, 0, capptr+CAP9_BARSIZE_OFS+i*4,
+				bar_sz);
+		grpci2_cfg_w32(priv, TGT, 0, PCI_BASE_ADDRESS_0+i*4, pciadr);
+		grpci2_cfg_w32(priv, TGT, 0, capptr+CAP9_BAR_OFS+i*4, ahbadr);
 		printk(KERN_INFO "        TGT BAR[%d]: 0x%08x (PCI)-> 0x%08x\n",
 			i, pciadr, ahbadr);
 	}
=20
 	/* set as bus master and enable pci memory responses */
-	grpci2_cfg_r32(priv, 0, 0, PCI_COMMAND, &data);
+	grpci2_cfg_r32(priv, TGT, 0, PCI_COMMAND, &data);
 	data |=3D (PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
-	grpci2_cfg_w32(priv, 0, 0, PCI_COMMAND, data);
+	grpci2_cfg_w32(priv, TGT, 0, PCI_COMMAND, data);
=20
 	/* Enable Error respone (CPU-TRAP) on illegal memory access. */
 	REGSTORE(regs->ctrl, CTRL_ER | CTRL_PE);
--=20
1.7.0.4

