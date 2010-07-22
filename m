From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 22 Jul 2010 22:30:21 +0000
Subject: [PATCH 4/4] microblaze: remove references to of_device and
Message-Id: <20100722223021.21557.65702.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20100722222600.21557.34167.stgit@angua>
In-Reply-To: <20100722222600.21557.34167.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, benh@kernel.cras

of_device is just a #define alias to platform_device.  This patch
replaces all references to it with platform_device.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/microblaze/kernel/of_platform.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/microblaze/kernel/of_platform.c b/arch/microblaze/kernel/of_platform.c
index 80c9c49..c664b27 100644
--- a/arch/microblaze/kernel/of_platform.c
+++ b/arch/microblaze/kernel/of_platform.c
@@ -50,16 +50,16 @@ const struct of_device_id of_default_bus_ids[] = {
 
 static int of_dev_node_match(struct device *dev, void *data)
 {
-	return to_of_device(dev)->dev.of_node = data;
+	return to_platform_device(dev)->dev.of_node = data;
 }
 
-struct of_device *of_find_device_by_node(struct device_node *np)
+struct platform_device *of_find_device_by_node(struct device_node *np)
 {
 	struct device *dev;
 
 	dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match);
 	if (dev)
-		return to_of_device(dev);
+		return to_platform_device(dev);
 	return NULL;
 }
 EXPORT_SYMBOL(of_find_device_by_node);

