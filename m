From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 23 Sep 2014 15:37:44 +0000
Subject: [PATCH] sparc64: Add vio_set_intr() to enable/disable Rx interrupts
Message-Id: <20140923153744.GB11042@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The vio_set_intr() API should be used by VIO consumers to enable/disable
Rx interrupts to facilitate deferred processing in softirq/bottom-half
context.

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
---
 arch/sparc/include/asm/vio.h |  2 ++
 arch/sparc/kernel/vio.c      | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/vio.h b/arch/sparc/include/asm/vio.h
index e0f6c39..0847b11 100644
--- a/arch/sparc/include/asm/vio.h
+++ b/arch/sparc/include/asm/vio.h
@@ -279,6 +279,7 @@ struct vio_dev {
 
 	unsigned int		tx_irq;
 	unsigned int		rx_irq;
+	u64			rx_ino;
 
 	struct device		dev;
 };
@@ -407,5 +408,6 @@ int vio_driver_init(struct vio_driver_state *vio, struct vio_dev *vdev,
 		    char *name);
 
 void vio_port_up(struct vio_driver_state *vio);
+int vio_set_intr(unsigned long dev_ino, int state);
 
 #endif /* _SPARC64_VIO_H */
diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index 8647fcc..cb5789c 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -180,8 +180,10 @@ static void vio_fill_channel_info(struct mdesc_handle *hp, u64 mp,
 			vdev->tx_irq = sun4v_build_virq(cdev_cfg_handle, *irq);
 
 		irq = mdesc_get_property(hp, target, "rx-ino", NULL);
-		if (irq)
+		if (irq) {
 			vdev->rx_irq = sun4v_build_virq(cdev_cfg_handle, *irq);
+			vdev->rx_ino = *irq;
+		}
 
 		chan_id = mdesc_get_property(hp, target, "id", NULL);
 		if (chan_id)
@@ -189,6 +191,15 @@ static void vio_fill_channel_info(struct mdesc_handle *hp, u64 mp,
 	}
 }
 
+int vio_set_intr(unsigned long dev_ino, int state)
+{
+	int err;
+
+	err = sun4v_vintr_set_valid(cdev_cfg_handle, dev_ino, state);
+	return err;
+}
+EXPORT_SYMBOL(vio_set_intr);
+
 static struct vio_dev *vio_create_one(struct mdesc_handle *hp, u64 mp,
 				      struct device *parent)
 {
-- 
1.8.4.2

