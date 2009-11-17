From: David Miller <davem@davemloft.net>
Date: Tue, 17 Nov 2009 12:49:28 +0000
Subject: Re: [experimental patch] sungem: force serdes dection on buildin
Message-Id: <20091117.044928.245588641.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20091113124350.GA1926@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20091113124350.GA1926@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Fri, 13 Nov 2009 13:43:50 +0100

> On a SunFire 880 the internal fibre gigabit interface (gem chip,
> an Agilent HDMP-1636A serdes on board) needs to be detected as
> a serdes and not as a seriallink.
> 
> The appended experimental patch changes this during detection and
> make the interface working (on top of the patches developed with davem for
> the Sun PCI gigabit fibre interface card).
> 
> Please comment and tell if there is a PCI sungem with seriallink and an
> ID of PCI_DEVICE_ID_SUN_GEM(2bad) out there.

It seems there is a special device property that we can use
to detect this properly.

Please try the attached patch on your system, it should fix
the problem too.

Thanks!

sungem: Fix Serdes detection.

We need to look for the 'shared-pins' property to get
this right.

Based upon a patch by Hermann Lauer.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/sungem.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/net/sungem.c b/drivers/net/sungem.c
index 305ec3d..1927b3d 100644
--- a/drivers/net/sungem.c
+++ b/drivers/net/sungem.c
@@ -2062,7 +2062,15 @@ static int gem_check_invariants(struct gem *gp)
 		mif_cfg &= ~MIF_CFG_PSELECT;
 		writel(mif_cfg, gp->regs + MIF_CFG);
 	} else {
-		gp->phy_type = phy_serialink;
+#ifdef CONFIG_SPARC
+		const char *p;
+
+		p = of_get_property(gp->of_node, "shared-pins", NULL);
+		if (p && !strcmp(p, "serdes"))
+			gp->phy_type = phy_serdes;
+		else
+#endif
+			gp->phy_type = phy_serialink;
 	}
 	if (gp->phy_type = phy_mii_mdio1 ||
 	    gp->phy_type = phy_mii_mdio0) {
-- 
1.6.5.3

