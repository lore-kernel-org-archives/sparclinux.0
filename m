From: James Clarke <jrtc27@jrtc27.com>
Date: Mon, 29 May 2017 16:54:18 +0000
Subject: [PATCH 1/2] sparc: Remove corresponding sysfs file on device remove
Message-Id: <20170529165419.19121-1-jrtc27@jrtc27.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: James Clarke <jrtc27@jrtc27.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id2541
---
 arch/sparc/kernel/vio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index f6bb857254fc..4da8db27fbf2 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -368,9 +368,15 @@ static void vio_remove(struct mdesc_handle *hp, u64 node)
 	dev = device_find_child(&root_vdev->dev, (void *) node,
 				vio_md_node_match);
 	if (dev) {
+		struct vio_dev *vdev = to_vio_dev(dev);
+
 		printk(KERN_INFO "VIO: Removing device %s\n", dev_name(dev));
 
 		device_unregister(dev);
+		if (vdev->dp)
+			sysfs_remove_file(&vdev->dev.kobj,
+					  &dev_attr_obppath.attr);
+
 		put_device(dev);
 	}
 }
-- 
2.11.0

