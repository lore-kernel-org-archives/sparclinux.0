From: Florian Vaussard <florian.vaussard@epfl.ch>
Date: Fri, 31 Jan 2014 13:34:33 +0000
Subject: [PATCH v3 1/5] can: sja1000: convert printk to use netdev API
Message-Id: <1391175277-19833-2-git-send-email-florian.vaussard@epfl.ch>
List-Id: <sparclinux.vger.kernel.org>
References: <1391175277-19833-1-git-send-email-florian.vaussard@epfl.ch>
In-Reply-To: <1391175277-19833-1-git-send-email-florian.vaussard@epfl.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Andreas Larsson <andreas@gaisler.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, florian.vaussard@epfl.ch

Use netdev_* where applicable.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 drivers/net/can/sja1000/sja1000.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index f17c301..55cce47 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -106,8 +106,7 @@ static int sja1000_probe_chip(struct net_device *dev)
 	struct sja1000_priv *priv = netdev_priv(dev);
 
 	if (priv->reg_base && sja1000_is_absent(priv)) {
-		printk(KERN_INFO "%s: probing @0x%lX failed\n",
-		       DRV_NAME, dev->base_addr);
+		netdev_err(dev, "probing failed\n");
 		return 0;
 	}
 	return -1;
-- 
1.8.1.2

