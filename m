From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 26 Oct 2015 00:26:38 +0000
Subject: [PATCH -next] sparc: Populate 'device' for platform device devicetree nodes
Message-Id: <1445819198-13744-1-git-send-email-linux@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

Since commit 61e82530d80f ("of/platform: Point to struct device from device
node"), the 'device' pointer in devicetree nodes for platform devices must
be set for of_find_device_by_node to succeed. This is not the case unless
the platform device was created using of_platform_device_create(), which
is not always the case. This causes all sparc images to crash with "Unable
to handle NULL pointer reference" in functions such as iommu_init(), which
don't expect of_find_device_by_node() to return NULL.

Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This patch depends on the patch causing the problem (which can not be easily
reverted). It should probably go through the same tree as that patch,
or the patches should be merged.

 arch/sparc/kernel/of_device_32.c | 1 +
 arch/sparc/kernel/of_device_64.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 185aa96fa5be..18a3506ead38 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -350,6 +350,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 	sd->op = op;
 
 	op->dev.of_node = dp;
+	dp->device = &op->dev;
 
 	intr = of_get_property(dp, "intr", &len);
 	if (intr) {
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 7bbdc26d9512..e7a7f3c8733e 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -647,6 +647,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 	sd->op = op;
 
 	op->dev.of_node = dp;
+	dp->device = &op->dev;
 
 	irq = of_get_property(dp, "interrupts", &len);
 	if (irq) {
-- 
2.1.4

