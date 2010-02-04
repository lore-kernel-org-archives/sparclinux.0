From: Chris Torek <chris.torek@windriver.com>
Date: Thu, 04 Feb 2010 11:25:57 +0000
Subject: [PATCH 3/8] net: cpu reservation
Message-Id: <9a55d2f53e2c1d5bbc8864ef7a0fb46d84317f48.1265231568.git.chris.torek@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hong H. Pham <hong.pham@windriver.com>

Provide functions for the networking subsystems and drivers to
reserve or request CPUs.  This allows networking subsystems and
drivers to coordinate with each other so that CPU resources are
evenly and optimally distributed.

Signed-off-by: Hong H. Pham <hong.pham@windriver.com>
Signed-off-by: Chris Torek <chris.torek@windriver.com>
---
 include/linux/netdevice.h |   37 +++++++++++++
 net/core/dev.c            |  129 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+), 0 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a3fccc8..82a734e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2062,6 +2062,43 @@ static inline int skb_bond_should_drop(struct sk_buff *skb)
 
 extern struct pernet_operations __net_initdata loopback_net_ops;
 
+#ifdef CONFIG_SMP
+extern int		netdev_reserve_cpu(int cpu);
+extern int		netdev_release_cpu(int cpu);
+extern int		netdev_request_cpu(void);
+extern int		netdev_request_cpu_mask(struct cpumask *exclude_mask);
+extern int		netdev_map_to_cpu(unsigned int index);
+#else
+/*
+ * raw_smp_processor_id() will be 0 and the 'cpu' argument will be 0;
+ * and it's OK to reserve/release ourselves.
+ */
+static inline int netdev_reserve_cpu(int cpu)
+{
+	return 0;
+}
+
+static inline int netdev_release_cpu(int cpu)
+{
+	return 0;
+}
+
+static inline int netdev_request_cpu(void)
+{
+	return 0;
+}
+
+static inline int netdev_request_cpu_mask(struct cpumask *exclude_mask)
+{
+	return cpumask_test_cpu(0, exclude_mask) ? -EAGAIN : 0;
+}
+
+static inline int netdev_map_to_cpu(unsigned int index)
+{
+	return 0;
+}
+#endif /* CONFIG_SMP */
+
 static inline int dev_ethtool_get_settings(struct net_device *dev,
 					   struct ethtool_cmd *cmd)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index c36a17a..c80119d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5299,6 +5299,135 @@ static void netdev_init_queues(struct net_device *dev)
 	spin_lock_init(&dev->tx_global_lock);
 }
 
+/*
+ *	CPU reservation
+ */
+#ifdef CONFIG_SMP
+static u16 netdev_cpu_usage_map[NR_CPUS] = { 0 };
+static DEFINE_SPINLOCK(netdev_cpu_map_lock);
+
+/*
+ * netdev_map_to_cpu maps an IRQ to a CPU number.  It can be replaced by
+ * an architecture-specific version if this version is unlikely to
+ * produce good performance.
+ */
+int __weak netdev_map_to_cpu(unsigned int index)
+{
+	return index % NR_CPUS;
+}
+
+/*
+ * "Reserving" a CPU is simply a logical operation meant to distribute
+ * incoming packet streams to CPUs for cache optimization.  We keep
+ * a count of reservations per cpu number; see below for more details.
+ */
+int netdev_reserve_cpu(int cpu)
+{
+	if ((cpu < 0) || (cpu > ARRAY_SIZE(netdev_cpu_usage_map)))
+		return -EINVAL;
+
+	if (!cpu_online(cpu))
+		return -ENXIO;
+
+	spin_lock(&netdev_cpu_map_lock);
+	netdev_cpu_usage_map[cpu]++;
+	spin_unlock(&netdev_cpu_map_lock);
+	return 0;
+}
+
+int netdev_release_cpu(int cpu)
+{
+	int ret;
+
+	if ((cpu < 0) || (cpu > ARRAY_SIZE(netdev_cpu_usage_map)))
+		return -EINVAL;
+
+	if (!cpu_online(cpu))
+		return -ENXIO;
+
+	spin_lock(&netdev_cpu_map_lock);
+	if (netdev_cpu_usage_map[cpu] = 0)
+		ret = -EINVAL;
+	else {
+		netdev_cpu_usage_map[cpu]--;
+		ret = 0;
+	}
+	spin_unlock(&netdev_cpu_map_lock);
+	return ret;
+}
+
+/* Pick any least-loaded cpu; see netdev_request_cpu_mask. */
+int netdev_request_cpu(void)
+{
+	return netdev_request_cpu_mask(NULL);
+}
+
+/*
+ * netdev_request_cpu_mask is the main use point for CPU reservation.
+ * We find the CPU with the fewest reservations against it that is not
+ * also "pre-excluded" via the supplied mask.  This allows the caller to
+ * pick a lightly-loaded CPU, then pick the next-best CPU excluding the
+ * one just picked, then pick the third-best excluding the previous two,
+ * and so on.
+ *
+ * The intent is to allow demultiplexing of incoming streaming data by
+ * distributing each stream to the "least-loaded" CPU that is not involved
+ * in any other streams associated with a particular network device.
+ */
+int netdev_request_cpu_mask(struct cpumask *exclude_mask)
+{
+	int cpu_id, min_index, ret, i;
+	u16 min_val;
+
+	min_index = -1;
+	min_val = USHORT_MAX;
+
+	spin_lock(&netdev_cpu_map_lock);
+	for (i = 0; i < ARRAY_SIZE(netdev_cpu_usage_map); i++) {
+		cpu_id = netdev_map_to_cpu(i);
+
+		if (!cpu_online(cpu_id))
+			continue;
+
+		if (exclude_mask && cpumask_test_cpu(cpu_id, exclude_mask))
+			continue;
+
+		if (netdev_cpu_usage_map[cpu_id] = 0) {
+			netdev_cpu_usage_map[cpu_id]++;
+			ret = cpu_id;
+			goto out_unlock;
+		}
+
+		if (netdev_cpu_usage_map[cpu_id] < min_val) {
+			min_val = netdev_cpu_usage_map[cpu_id];
+			min_index = cpu_id;
+		}
+	}
+
+	/*
+	 * Can only happen if there are no online CPUs, or all CPUs have
+	 * been excluded.
+	 */
+	if (min_val = USHORT_MAX) {
+		ret = -EAGAIN;
+		goto out_unlock;
+	}
+
+	netdev_cpu_usage_map[min_index]++;
+	ret = min_index;
+
+out_unlock:
+	spin_unlock(&netdev_cpu_map_lock);
+	return ret;
+}
+
+EXPORT_SYMBOL(netdev_reserve_cpu);
+EXPORT_SYMBOL(netdev_release_cpu);
+EXPORT_SYMBOL(netdev_request_cpu);
+EXPORT_SYMBOL(netdev_request_cpu_mask);
+EXPORT_SYMBOL(netdev_map_to_cpu);
+#endif /* CONFIG_SMP */
+
 /**
  *	alloc_netdev_mq - allocate network device
  *	@sizeof_priv:	size of private data to allocate space for
-- 
1.6.0.4.766.g6fc4a

