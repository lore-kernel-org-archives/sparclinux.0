From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 15 May 2017 17:51:08 +0000
Subject: [PATCH net-next 2/2] ldmvsw: stop the clean timer at beginning of remove
Message-Id: <1494870668-65047-3-git-send-email-shannon.nelson@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1494870668-65047-1-git-send-email-shannon.nelson@oracle.com>
In-Reply-To: <1494870668-65047-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, netdev@vger.kernel.org
Cc: sparclinux@vger.kernel.org, Shannon Nelson <shannon.nelson@oracle.com>

Stop the clean timer earlier to be sure there's no asynchronous
interference while stopping the port.

Orabug: 25748241

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/sun/ldmvsw.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/sun/ldmvsw.c b/drivers/net/ethernet/sun/ldmvsw.c
index 309747c..5b56c24 100644
--- a/drivers/net/ethernet/sun/ldmvsw.c
+++ b/drivers/net/ethernet/sun/ldmvsw.c
@@ -411,6 +411,7 @@ static int vsw_port_remove(struct vio_dev *vdev)
 
 	if (port) {
 		del_timer_sync(&port->vio.timer);
+		del_timer_sync(&port->clean_timer);
 
 		napi_disable(&port->napi);
 		unregister_netdev(port->dev);
@@ -418,7 +419,6 @@ static int vsw_port_remove(struct vio_dev *vdev)
 		list_del_rcu(&port->list);
 
 		synchronize_rcu();
-		del_timer_sync(&port->clean_timer);
 		spin_lock_irqsave(&port->vp->lock, flags);
 		sunvnet_port_rm_txq_common(port);
 		spin_unlock_irqrestore(&port->vp->lock, flags);
-- 
1.7.1

