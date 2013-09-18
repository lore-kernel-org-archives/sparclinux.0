From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 18 Sep 2013 13:24:51 +0000
Subject: [PATCH v2 09/10] of/i2c: Resolve interrupt references at probe time
Message-Id: <1379510692-32435-10-git-send-email-treding@nvidia.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
In-Reply-To: <1379510692-32435-1-git-send-email-treding@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Instead of resolving interrupt references at device creation time, delay
resolution until probe time. At device creation time, there is nothing
that can be done if an interrupt parent isn't ready yet, and the device
will end up with an invalid interrupt number (0).

If the interrupt reference is resolved at probe time, the device's probe
can be deferred, so that it's interrupt resolution can be retried after
more devices (possibly including its interrupt parent) have been probed.

However, individual drivers shouldn't be required to do that themselves,
over and over again, so this commit implements this functionality within
the I2C core.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- use __irq_of_parse_and_map() instead of of_irq_get()

 drivers/i2c/i2c-core.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 29d3f04..5b4f289 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -236,6 +236,22 @@ int i2c_recover_bus(struct i2c_adapter *adap)
 	return adap->bus_recovery_info->recover_bus(adap);
 }
 
+static int of_i2c_probe(struct i2c_client *client)
+{
+	struct device_node *np = client->dev.of_node;
+	int ret;
+
+	/* skip if the device node specifies no interrupts */
+	if (of_get_property(np, "interrupts", NULL)) {
+		ret = __irq_of_parse_and_map(client->dev.of_node, 0,
+					     &client->irq);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int i2c_device_probe(struct device *dev)
 {
 	struct i2c_client	*client = i2c_verify_client(dev);
@@ -254,6 +270,12 @@ static int i2c_device_probe(struct device *dev)
 					client->flags & I2C_CLIENT_WAKE);
 	dev_dbg(dev, "probe\n");
 
+	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
+		status = of_i2c_probe(client);
+		if (status)
+			return status;
+	}
+
 	status = driver->probe(client, i2c_match_id(driver->id_table, client));
 	if (status) {
 		client->driver = NULL;
@@ -1002,7 +1024,6 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
 			continue;
 		}
 
-		info.irq = irq_of_parse_and_map(node, 0);
 		info.of_node = of_node_get(node);
 		info.archdata = &dev_ad;
 
@@ -1016,7 +1037,6 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
 			dev_err(&adap->dev, "of_i2c: Failure registering %s\n",
 				node->full_name);
 			of_node_put(node);
-			irq_dispose_mapping(info.irq);
 			continue;
 		}
 	}
-- 
1.8.4

