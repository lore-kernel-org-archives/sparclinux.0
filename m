From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Fri, 13 Nov 2009 12:43:50 +0000
Subject: [experimental patch] sungem: force serdes dection on buildin V880 fiber gigabit ethernet
Message-Id: <20091113124350.GA1926@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On a SunFire 880 the internal fibre gigabit interface (gem chip,
an Agilent HDMP-1636A serdes on board) needs to be detected as
a serdes and not as a seriallink.

The appended experimental patch changes this during detection and
make the interface working (on top of the patches developed with davem for
the Sun PCI gigabit fibre interface card).

Please comment and tell if there is a PCI sungem with seriallink and an
ID of PCI_DEVICE_ID_SUN_GEM(2bad) out there.

BTW, the patch is against debian lenny kernel sources (2.6.26-2-sparc64-smp),
as since 2.6.27rcX the kernel did not run anymore on this hardware
(will try 2.6.31.6 when compile finished).

Thanks,
  Hermann

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sungem-serdes-detect.patch"

diff -up build_sparc_none_sparc64-smp/drivers/net/sungem.c.detect build_sparc_none_sparc64-smp/drivers/net/sungem.c
--- build_sparc_none_sparc64-smp/drivers/net/sungem.c.detect	2009-11-13 11:56:58.000000000 +0100
+++ build_sparc_none_sparc64-smp/drivers/net/sungem.c	2009-11-13 11:54:24.000000000 +0100
@@ -2062,7 +2062,11 @@ static int gem_check_invariants(struct g
 		mif_cfg &= ~MIF_CFG_PSELECT;
 		writel(mif_cfg, gp->regs + MIF_CFG);
 	} else {
-		gp->phy_type = phy_serialink;
+	        if (pdev->device == PCI_DEVICE_ID_SUN_GEM) {
+		  printk(KERN_INFO PFX "SUNGEM phy_serdes forced.\n");
+		  gp->phy_type = phy_serdes;
+		} else
+		  gp->phy_type = phy_serialink;
 	}
 	if (gp->phy_type == phy_mii_mdio1 ||
 	    gp->phy_type == phy_mii_mdio0) {

--FL5UXtIhxfXey3p5--
