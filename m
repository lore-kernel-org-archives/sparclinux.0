From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 24 Apr 2016 17:51:05 +0000
Subject: [PATCH] aeroflex/greth: fix warning about unused variable
Message-Id: <20160424175105.GA14620@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 24 Apr 2016 18:39:52 +0200
Subject: [PATCH] aeroflex/greth: fix warning about unused variable

Fix following warning:
aeroflex/greth.c:1326:11: warning: unused variable 'phy' [-Wunused-variable]

The variable was unused - remove it.
It looks like this warning has been there forever - was found by an
allyesconfig build of sparc32.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Kristoffer Glembo <kristoffer@gaisler.com>
---
 drivers/net/ethernet/aeroflex/greth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aeroflex/greth.c b/drivers/net/ethernet/aeroflex/greth.c
index b873531..bca07c5 100644
--- a/drivers/net/ethernet/aeroflex/greth.c
+++ b/drivers/net/ethernet/aeroflex/greth.c
@@ -1323,7 +1323,7 @@ static inline int phy_aneg_done(struct phy_device *phydev)
 
 static int greth_mdio_init(struct greth_private *greth)
 {
-	int ret, phy;
+	int ret;
 	unsigned long timeout;
 
 	greth->mdio = mdiobus_alloc();
-- 
1.8.3.1

