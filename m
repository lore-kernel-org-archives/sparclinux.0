From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 21:49:23 +0000
Subject: [PATCH 12/16]: sparc64: Fix sparse warnings in vio.c
Message-Id: <20080912.144923.132282364.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Fix sparse warnings in vio.c

Several variables should be marked static.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/vio.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc64/kernel/vio.c b/arch/sparc64/kernel/vio.c
index a490077..92b1f8e 100644
--- a/arch/sparc64/kernel/vio.c
+++ b/arch/sparc64/kernel/vio.c
@@ -152,7 +152,7 @@ show_pciobppath_attr(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR(obppath, S_IRUSR | S_IRGRP | S_IROTH,
 		   show_pciobppath_attr, NULL);
 
-struct device_node *cdev_node;
+static struct device_node *cdev_node;
 
 static struct vio_dev *root_vdev;
 static u64 cdev_cfg_handle;
@@ -371,9 +371,9 @@ static struct mdesc_notifier_client vio_ds_notifier = {
 	.node_name	= "domain-services-port",
 };
 
-const char *channel_devices_node = "channel-devices";
-const char *channel_devices_compat = "SUNW,sun4v-channel-devices";
-const char *cfg_handle_prop = "cfg-handle";
+static const char *channel_devices_node = "channel-devices";
+static const char *channel_devices_compat = "SUNW,sun4v-channel-devices";
+static const char *cfg_handle_prop = "cfg-handle";
 
 static int __init vio_init(void)
 {
-- 
1.5.6.5.GIT

