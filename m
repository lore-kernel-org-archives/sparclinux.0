From: cathy.zhou@oracle.com
Date: Wed, 14 Mar 2018 17:56:07 +0000
Subject: [PATCH net-next] sunvnet: does not support GSO for sctp
Message-Id: <1521050167-3946-1-git-send-email-cathy.zhou@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, netdev@vger.kernel.org
Cc: sparclinux@vger.kernel.org

From: Cathy Zhou <Cathy.Zhou@Oracle.COM>

The NETIF_F_GSO_SOFTWARE implies support for GSO on SCTP, but the
sunvnet driver does not support GSO for sctp.  Here we remove the
NETIF_F_GSO_SOFTWARE feature flag and only report NETIF_F_ALL_TSO
instead.

Signed-off-by: Cathy Zhou <Cathy.Zhou@Oracle.COM>
Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/sun/sunvnet.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/sun/sunvnet.c b/drivers/net/ethernet/sun/sunvnet.c
index 63d3d6b..a94f504 100644
--- a/drivers/net/ethernet/sun/sunvnet.c
+++ b/drivers/net/ethernet/sun/sunvnet.c
@@ -312,7 +312,7 @@ static void vnet_poll_controller(struct net_device *dev)
 	dev->ethtool_ops = &vnet_ethtool_ops;
 	dev->watchdog_timeo = VNET_TX_TIMEOUT;
 
-	dev->hw_features = NETIF_F_TSO | NETIF_F_GSO | NETIF_F_GSO_SOFTWARE |
+	dev->hw_features = NETIF_F_TSO | NETIF_F_GSO | NETIF_F_ALL_TSO |
 			   NETIF_F_HW_CSUM | NETIF_F_SG;
 	dev->features = dev->hw_features;
 
-- 
1.7.1

