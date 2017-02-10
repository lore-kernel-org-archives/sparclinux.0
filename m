From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 10 Feb 2017 17:38:21 +0000
Subject: [PATCH v3 net-next 5/9] sunvnet: add memory barrier before check for tx enable
Message-Id: <1486748305-240339-6-git-send-email-shannon.nelson@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1486748305-240339-1-git-send-email-shannon.nelson@oracle.com>
In-Reply-To: <1486748305-240339-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Shannon Nelson <shannon.nelson@oracle.com>

In order to allow the underlying LDC and outstanding memory operations
to potentially catch up with the driver's Tx requests, add a memory
barrier before checking again for available tx descriptors.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/sun/sunvnet_common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/sun/sunvnet_common.c b/drivers/net/ethernet/sun/sunvnet_common.c
index 624ad65..05fe85f 100644
--- a/drivers/net/ethernet/sun/sunvnet_common.c
+++ b/drivers/net/ethernet/sun/sunvnet_common.c
@@ -1429,6 +1429,7 @@ int sunvnet_start_xmit_common(struct sk_buff *skb, struct net_device *dev,
 	dr->prod = (dr->prod + 1) & (VNET_TX_RING_SIZE - 1);
 	if (unlikely(vnet_tx_dring_avail(dr) < 1)) {
 		netif_tx_stop_queue(txq);
+		smp_rmb();
 		if (vnet_tx_dring_avail(dr) > VNET_TX_WAKEUP_THRESH(dr))
 			netif_tx_wake_queue(txq);
 	}
-- 
1.7.1

