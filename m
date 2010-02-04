From: Chris Torek <chris.torek@windriver.com>
Date: Thu, 04 Feb 2010 11:26:02 +0000
Subject: [PATCH 8/8] niu: rxflow integration
Message-Id: <bf51d8c647b3eb974d6ea8cb35e716f4b2ba2192.1265231570.git.chris.torek@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Set the number of CPUs to be used to handle separated flows on
receive.  The default maximum is 16, but we never use more than
half the online processors.

Signed-off-by: Hong H. Pham <hong.pham@windriver.com>
Signed-off-by: Chris Torek <chris.torek@windriver.com>
---
 drivers/net/niu.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/net/niu.c b/drivers/net/niu.c
index c82e970..488a4ae 100644
--- a/drivers/net/niu.c
+++ b/drivers/net/niu.c
@@ -76,6 +76,14 @@ static unsigned int rbr_refill_min __read_mostly = RBR_REFILL_MIN;
 module_param(rbr_refill_min, uint, 0644);
 MODULE_PARM_DESC(rbr_refill_min, "Minimum RBR refill threshold");
 
+/*
+ * An upper limit of 16 CPUs in rxflow separation usually works well.
+ * Lowering this value to 0 reverts the driver to pre-rxflow behavior.
+ */
+static unsigned int rxflow_max_cpus = 16;
+module_param(rxflow_max_cpus, uint, 0644);
+MODULE_PARM_DESC(rxflow_max_cpus, "Maximum CPUs for RXflow separation");
+
 #ifndef readq
 static u64 readq(void __iomem *reg)
 {
@@ -9812,6 +9820,26 @@ static void __devinit niu_driver_version(void)
 		pr_info("%s", version);
 }
 
+#ifdef CONFIG_SMP
+/*
+ * Set number of CPUs to handle flow separation on receive.  We
+ * want half the online CPUs, or the module-parameter upper limit
+ * (normally 16), whichever is smaller.
+ */
+static void __devinit niu_set_default_rx_cpus(struct net_device *dev)
+{
+	unsigned int n;
+
+	n = num_online_cpus() / 2;
+	if (n > rxflow_max_cpus)
+		n = rxflow_max_cpus;
+
+	dev->rx_cpus = n;
+}
+#else
+#define niu_set_default_rx_cpus(dev) do {} while (0)
+#endif /* CONFIG_SMP */
+
 static struct net_device * __devinit niu_alloc_and_init(
 	struct device *gen_dev, struct pci_dev *pdev,
 	struct of_device *op, const struct niu_ops *ops,
@@ -9842,6 +9870,8 @@ static struct net_device * __devinit niu_alloc_and_init(
 
 	np->port = port;
 
+	niu_set_default_rx_cpus(dev);
+
 	return dev;
 }
 
-- 
1.6.0.4.766.g6fc4a

