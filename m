From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Mon, 01 Jul 2013 21:49:22 +0000
Subject: [PATCH] sunvnet: vnet_port_remove must call unregister_netdev
Message-Id: <51D1F962.1020409@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The missing call to unregister_netdev() leaves the interface active
after the driver is unloaded by rmmod.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
 drivers/net/ethernet/sun/sunvnet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/sun/sunvnet.c b/drivers/net/ethernet/sun/sunvnet.c
index 1df0ff3..3df5684 100644
--- a/drivers/net/ethernet/sun/sunvnet.c
+++ b/drivers/net/ethernet/sun/sunvnet.c
@@ -1239,6 +1239,8 @@ static int vnet_port_remove(struct vio_dev *vdev)
 		dev_set_drvdata(&vdev->dev, NULL);
 
 		kfree(port);
+
+		unregister_netdev(vp->dev);
 	}
 	return 0;
 }
-- 
1.8.3.2

