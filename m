From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 18 Mar 2010 15:22:33 +0000
Subject: [V2 PATCH 05/10] arch/microblaze: Always use 'struct device.of_node'
Message-Id: <20100318152233.21082.44377.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20100318144836.21082.93040.stgit@angua>
In-Reply-To: <20100318144836.21082.93040.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, benh@kernel.crashing.org, linux-kernel@vger.kernel.org, michal.simek@petalogix.com, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au

The following structure elements duplicate the information in
'struct device.of_node' and so are being eliminated.  This patch
makes all readers of the following elements use device.of_node instead.

struct of_device.node
struct dev_archdata.of_node

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/kernel/of_device.c   |    8 ++++----
 arch/microblaze/kernel/of_platform.c |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/microblaze/kernel/of_device.c b/arch/microblaze/kernel/of_device.c
index f6c5218..90d2246 100644
--- a/arch/microblaze/kernel/of_device.c
+++ b/arch/microblaze/kernel/of_device.c
@@ -12,7 +12,7 @@
 void of_device_make_bus_id(struct of_device *dev)
 {
 	static atomic_t bus_no_reg_magic;
-	struct device_node *node = dev->node;
+	struct device_node *node = dev->dev.of_node;
 	const u32 *reg;
 	u64 addr;
 	int magic;
@@ -76,17 +76,17 @@ int of_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 
 	ofdev = to_of_device(dev);
 
-	if (add_uevent_var(env, "OF_NAME=%s", ofdev->node->name))
+	if (add_uevent_var(env, "OF_NAME=%s", ofdev->dev.of_node->name))
 		return -ENOMEM;
 
-	if (add_uevent_var(env, "OF_TYPE=%s", ofdev->node->type))
+	if (add_uevent_var(env, "OF_TYPE=%s", ofdev->dev.of_node->type))
 		return -ENOMEM;
 
 	/* Since the compatible field can contain pretty much anything
 	 * it's not really legal to split it out with commas. We split it
 	 * up using a number of environment variables instead. */
 
-	compat = of_get_property(ofdev->node, "compatible", &cplen);
+	compat = of_get_property(ofdev->dev.of_node, "compatible", &cplen);
 	while (compat && *compat && cplen > 0) {
 		if (add_uevent_var(env, "OF_COMPATIBLE_%d=%s", seen, compat))
 			return -ENOMEM;
diff --git a/arch/microblaze/kernel/of_platform.c b/arch/microblaze/kernel/of_platform.c
index 1c6d684..ea7d024 100644
--- a/arch/microblaze/kernel/of_platform.c
+++ b/arch/microblaze/kernel/of_platform.c
@@ -167,7 +167,7 @@ EXPORT_SYMBOL(of_platform_bus_probe);
 
 static int of_dev_node_match(struct device *dev, void *data)
 {
-	return to_of_device(dev)->node = data;
+	return to_of_device(dev)->dev.of_node = data;
 }
 
 struct of_device *of_find_device_by_node(struct device_node *np)
@@ -185,7 +185,7 @@ EXPORT_SYMBOL(of_find_device_by_node);
 static int of_dev_phandle_match(struct device *dev, void *data)
 {
 	phandle *ph = data;
-	return to_of_device(dev)->node->phandle = *ph;
+	return to_of_device(dev)->dev.of_node->phandle = *ph;
 }
 
 struct of_device *of_find_device_by_phandle(phandle ph)

