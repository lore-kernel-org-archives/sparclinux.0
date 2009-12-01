From: David Miller <davem@davemloft.net>
Date: Tue, 01 Dec 2009 05:48:11 +0000
Subject: Re: Boot problems on a V880
Message-Id: <20091130.214811.233690337.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200911262202.45791.pat@computer-refuge.org>
In-Reply-To: <200911262202.45791.pat@computer-refuge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Patrick Finnegan <pat@computer-refuge.org>
Date: Mon, 30 Nov 2009 23:04:31 -0500

> I re-ran prtconf -pv under the 2.6.32-rc3 from your sparc git tree, and 
> have the output here (it looks like it has what you're looking for):
> 
> http://ned.cc.purdue.edu/prtconf-v880

Linus's tree has the fix, via my net-2.6 tree, so if you use a pure
sparc-2.6 tree you won't have it.

You can thus try adding the following patch on top of your sparc-2.6
tree, or alternatively, try Linus's current tree as all the sparc
fixes have been merged there now too.

commit e54d5512b600aa0d492010436ff7eb0c9194efc1
Author: David S. Miller <davem@davemloft.net>
Date:   Tue Nov 17 04:46:18 2009 -0800

    sungem: Fix Serdes detection.
    
    We need to look for the 'shared-pins' property to get
    this right.
    
    Based upon a patch by Hermann Lauer.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

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
