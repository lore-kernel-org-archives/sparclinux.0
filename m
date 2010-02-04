From: Chris Torek <chris.torek@windriver.com>
Date: Thu, 04 Feb 2010 11:25:59 +0000
Subject: [PATCH 5/8] net: per device separate flow on receive
Message-Id: <59e1f00f42c92d3dafeef5d713bf0b11149f065d.1265231569.git.chris.torek@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hong H. Pham <hong.pham@windriver.com>

Based on Dave Miller's patch found here:
http://article.gmane.org/gmane.linux.network/124921

This code provides the ability to separate incoming packet flows
per device, delivering each such stream to a remote CPU for
further processing.  Using flow separation on receive improves
throughput and addresses packet reordering in a single flow.

Limitations:
  * Device drivers that do not use NAPI can not use the flow
    separation on receive feature.

Signed-off-by: Hong H. Pham <hong.pham@windriver.com>
Signed-off-by: Chris Torek <chris.torek@windriver.com>
---
 include/linux/netdevice.h |    9 +
 net/core/dev.c            |  398 ++++++++++++++++++++++++++++++++++++++++++++-
 net/core/net-sysfs.c      |   25 +++
 3 files changed, 424 insertions(+), 8 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 82a734e..3b34c43 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -519,6 +519,8 @@ struct netdev_queue {
 } ____cacheline_aligned_in_smp;
 
 
+struct netdev_rxflow_info;
+
 /*
  * This structure defines the management hooks for network devices.
  * The following hooks can be defined; unless noted otherwise, they are
@@ -953,6 +955,13 @@ struct net_device {
 	/* max exchange id for FCoE LRO by ddp */
 	unsigned int		fcoe_ddp_xid;
 #endif
+
+#ifdef CONFIG_SMP
+	/* for separating flow on receive to remote CPUs for processing */
+	int			rx_cpus;
+	int			rx_separate_flow;
+	struct netdev_rxflow_info *rxflow;
+#endif
 };
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
diff --git a/net/core/dev.c b/net/core/dev.c
index c80119d..4168964 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -173,6 +173,21 @@ static DEFINE_SPINLOCK(ptype_lock);
 static struct list_head ptype_base[PTYPE_HASH_SIZE] __read_mostly;
 static struct list_head ptype_all __read_mostly;	/* Taps */
 
+struct netdev_rxflow_queue {
+	cpumask_t flows_hashed_space; /* cheating, a la <linux/sched.h> */
+#define flows_hashed(q) (&(q)->flows_hashed_space)
+	struct call_single_data csd;
+	struct sk_buff_head work;
+	struct sk_buff_head batch[0];
+};
+
+struct netdev_rxflow_info {
+	int        num_cpus; /* Weight of cpu_mask */
+	void      *queue;    /* Per CPU instance of netdev_rxflow_queue */
+	cpumask_var_t cpu_mask; /* Mask of CPUs used for rx flow processing */
+	u16        cpu_map[0];
+};
+
 /*
  * The @dev_base_head list is protected by @dev_base_lock and the rtnl
  * semaphore.
@@ -1113,6 +1128,121 @@ void dev_load(struct net *net, const char *name)
 }
 EXPORT_SYMBOL(dev_load);
 
+#ifdef CONFIG_SMP
+static int dev_init_rxflow(struct net_device *dev)
+{
+	struct netdev_rxflow_info *r;
+	struct netdev_rxflow_queue *q;
+	int ret, cpu, i, j, n;
+
+	n = dev->rx_cpus;
+	if (!n || !dev->rx_separate_flow) {
+		dev->rxflow = NULL;
+		return 0;
+	}
+
+	if (n > num_online_cpus())
+		n = dev->rx_cpus = num_online_cpus();
+
+	r = kzalloc(sizeof(struct netdev_rxflow_info) + (sizeof(u16) * n),
+	            GFP_KERNEL);
+	if (!r)
+		return -ENOMEM;
+
+	r->num_cpus = n;
+
+	if (!zalloc_cpumask_var(&r->cpu_mask, GFP_KERNEL)) {
+		kfree(r);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < n; i++) {
+		ret = netdev_request_cpu_mask(r->cpu_mask);
+		if (ret < 0) {
+			printk(KERN_ERR "%s: request for CPU to handle rx flow"
+			       " failed!\n", dev->name);
+			goto out_error;
+		}
+
+		r->cpu_map[i] = ret;
+		cpumask_set_cpu(ret, r->cpu_mask);
+	}
+
+	r->queue = __alloc_percpu(sizeof(struct netdev_rxflow_queue) +
+	               (sizeof(struct sk_buff_head) * n),
+	               __alignof__(sizeof(struct netdev_rxflow_queue)));
+
+	if (!r->queue) {
+		ret = -ENOMEM;
+		goto out_error;
+	}
+
+	for_each_possible_cpu(cpu) {
+		q = per_cpu_ptr(r->queue, cpu);
+		cpumask_clear(flows_hashed(q));
+		skb_queue_head_init(&q->work);
+
+		for (j = 0; j < n; j++)
+			skb_queue_head_init(&q->batch[j]);
+	}
+
+	dev->rxflow = r;
+	return 0;
+
+out_error:
+	for (j = 0; j < i; j++)
+		netdev_release_cpu(r->cpu_map[j]);
+
+	free_cpumask_var(r->cpu_mask);
+	kfree(r);
+	return ret;
+}
+
+static void dev_stop_rxflow(struct net_device *dev)
+{
+	struct netdev_rxflow_info *r = dev->rxflow;
+	struct netdev_rxflow_queue *q;
+	struct sk_buff_head *skb_queue;
+	int i, cpu;
+
+	if (!r)
+		return;
+
+	dev->rxflow = NULL;
+
+	for_each_possible_cpu(cpu) {
+		q = per_cpu_ptr(r->queue, cpu);
+
+		while (!skb_queue_empty(&q->work))
+			kfree_skb(__skb_dequeue(&q->work));
+
+		for (i = 0; i < r->num_cpus; i++) {
+			skb_queue = &q->batch[i];
+
+			while (!skb_queue_empty(skb_queue))
+				kfree_skb(__skb_dequeue(skb_queue));
+		}
+	}
+
+	free_percpu(r->queue);
+	r->queue = NULL;
+
+	for (i = 0; i < r->num_cpus; i++)
+		netdev_release_cpu(r->cpu_map[i]);
+
+	free_cpumask_var(r->cpu_mask);
+	r->num_cpus = 0;
+	kfree(r);
+}
+#else
+static inline int dev_init_rxflow(struct net_device *dev)
+{
+	return 0;
+}
+
+#define dev_stop_rxflow(dev) do {} while (0)
+#endif /* CONFIG_SMP */
+
 /**
  *	dev_open	- prepare an interface for use.
  *	@dev:	device to open
@@ -1169,6 +1299,13 @@ int dev_open(struct net_device *dev)
 		clear_bit(__LINK_STATE_START, &dev->state);
 	else {
 		/*
+		 *	Start rx flow separation if enabled.
+		 */
+		if (dev_init_rxflow(dev))
+			printk(KERN_WARNING
+			    "%s: rxflow separation disabled\n", dev->name);
+
+		/*
 		 *	Set the flags.
 		 */
 		dev->flags |= IFF_UP;
@@ -1235,6 +1372,8 @@ int dev_close(struct net_device *dev)
 
 	dev_deactivate(dev);
 
+	dev_stop_rxflow(dev);
+
 	/*
 	 *	Call the device specific close. This cannot fail.
 	 *	Only if device is UP
@@ -1874,7 +2013,7 @@ out_kfree_skb:
 	return rc;
 }
 
-static u32 skb_tx_hashrnd;
+static u32 skb_hashrnd;
 
 u16 skb_tx_hash(const struct net_device *dev, const struct sk_buff *skb)
 {
@@ -1892,7 +2031,7 @@ u16 skb_tx_hash(const struct net_device *dev, const struct sk_buff *skb)
 	else
 		hash = skb->protocol;
 
-	hash = jhash_1word(hash, skb_tx_hashrnd);
+	hash = jhash_1word(hash, skb_hashrnd);
 
 	return (u16) (((u64) hash * dev->real_num_tx_queues) >> 32);
 }
@@ -2417,7 +2556,7 @@ void netif_nit_deliver(struct sk_buff *skb)
  *	NET_RX_SUCCESS: no congestion
  *	NET_RX_DROP: packet was dropped
  */
-int netif_receive_skb(struct sk_buff *skb)
+int __netif_receive_skb(struct sk_buff *skb)
 {
 	struct packet_type *ptype, *pt_prev;
 	struct net_device *orig_dev;
@@ -2431,10 +2570,6 @@ int netif_receive_skb(struct sk_buff *skb)
 	if (vlan_tx_tag_present(skb) && vlan_hwaccel_do_receive(skb))
 		return NET_RX_SUCCESS;
 
-	/* if we've gotten here through NAPI, check netpoll */
-	if (netpoll_receive_skb(skb))
-		return NET_RX_DROP;
-
 	if (!skb->skb_iif)
 		skb->skb_iif = skb->dev->ifindex;
 
@@ -2513,6 +2648,246 @@ out:
 	rcu_read_unlock();
 	return ret;
 }
+
+#ifdef CONFIG_SMP
+/*
+ * skb->data points at the network header, but that is the only thing
+ * we can rely upon.
+ */
+static u16 simple_rx_hash(struct sk_buff *skb, int range)
+{
+	u32 addr1, addr2, ports;
+	struct ipv6hdr *ip6;
+	struct iphdr *ip;
+	u32 hash, ihl;
+	u8 ip_proto;
+
+	switch (skb->protocol) {
+	case __constant_htons(ETH_P_IP):
+		if (!pskb_may_pull(skb, sizeof(*ip)))
+			return 0;
+
+		ip = (struct iphdr *) skb->data;
+		ip_proto = ip->protocol;
+		addr1 = ip->saddr;
+		addr2 = ip->daddr;
+		ihl = ip->ihl;
+		break;
+	case __constant_htons(ETH_P_IPV6):
+		if (!pskb_may_pull(skb, sizeof(*ip6)))
+			return 0;
+
+		ip6 = (struct ipv6hdr *) skb->data;
+		ip_proto = ip6->nexthdr;
+		addr1 = ip6->saddr.s6_addr32[3];
+		addr2 = ip6->daddr.s6_addr32[3];
+		ihl = (40 >> 2);
+		break;
+	default:
+		return 0;
+	}
+
+	ports = 0;
+	switch (ip_proto) {
+	case IPPROTO_TCP:
+	case IPPROTO_UDP:
+	case IPPROTO_DCCP:
+	case IPPROTO_ESP:
+	case IPPROTO_AH:
+	case IPPROTO_SCTP:
+	case IPPROTO_UDPLITE:
+		if (pskb_may_pull(skb, (ihl * 4) + 4))
+			ports = *((u32 *) (skb->data + (ihl * 4)));
+		break;
+
+	default:
+		break;
+	}
+	hash = jhash_3words(addr1, addr2, ports, skb_hashrnd);
+
+	return (u16) (((u64) hash * range) >> 32);
+}
+
+int netif_receive_skb(struct sk_buff *skb)
+{
+	struct netdev_rxflow_info  *r = skb->dev->rxflow;
+	struct netdev_rxflow_queue *q;
+	int target_cpu, this_cpu;
+	u16 flow_hash;
+
+	/*
+	 * If we've gotten here through NAPI, check netpoll.  This part
+	 * has to be synchronous and not get pushed to remote softirq
+	 * receive packet processing.
+	 */
+	if (netpoll_receive_skb(skb))
+		return NET_RX_DROP;
+
+	if (!r)
+		return __netif_receive_skb(skb);
+
+	flow_hash  = simple_rx_hash(skb, r->num_cpus);
+	target_cpu = r->cpu_map[flow_hash];
+
+	/* If the target CPU is too backlogged, drop the packet here */
+	q = per_cpu_ptr(r->queue, target_cpu);
+	if (unlikely(skb_queue_len(&q->work) > netdev_max_backlog)) {
+		kfree_skb(skb);
+		__get_cpu_var(netdev_rx_stat).dropped++;
+		return NET_RX_DROP;
+	}
+
+	/*
+	 * Queue packet up for batch processing when this NAPI session
+	 * completes.
+	 */
+	this_cpu = get_cpu();
+	q = per_cpu_ptr(r->queue, this_cpu);
+	__skb_queue_tail(&q->batch[flow_hash], skb);
+	cpumask_set_cpu(flow_hash, flows_hashed(q));
+	put_cpu();
+
+	return NET_RX_SUCCESS;
+}
+
+static inline void net_skb_queue_splice(const struct sk_buff_head *list,
+                                        struct sk_buff *prev,
+                                        struct sk_buff *next)
+{
+	struct sk_buff *first = list->next;
+	struct sk_buff *last = list->prev;
+
+	first->prev = prev;
+	prev->next = first;
+
+	last->next = next;
+	next->prev = last;
+}
+
+static inline void net_skb_queue_splice_tail(struct sk_buff_head *list,
+                                             struct sk_buff_head *head)
+{
+	net_skb_queue_splice(list,
+	                     (struct sk_buff *)head->prev,
+	                     (struct sk_buff *)head);
+	head->qlen += list->qlen;
+}
+
+static void net_rx_submit_work(struct net_device *dev)
+{
+	struct netdev_rxflow_info  *r;
+	struct netdev_rxflow_queue *this_queue, *remote_queue;
+	struct sk_buff_head *skb_batch;
+	int target_cpu, this_cpu, flow;
+	u32 old_qlen;
+	unsigned long flag;
+
+	if (!dev)
+		return;
+
+	r = dev->rxflow;
+	if (!r)
+		return;
+
+	this_cpu   = get_cpu();
+	this_queue = per_cpu_ptr(r->queue, this_cpu);
+
+	for_each_cpu(flow, flows_hashed(this_queue)) {
+		skb_batch    = &this_queue->batch[flow];
+		target_cpu   = r->cpu_map[flow];
+		remote_queue = per_cpu_ptr(r->queue, target_cpu);
+
+		spin_lock_irqsave(&remote_queue->work.lock, flag);
+
+		old_qlen = skb_queue_len(&remote_queue->work);
+		net_skb_queue_splice_tail(skb_batch, &remote_queue->work);
+
+		if (!old_qlen)
+			__send_remote_softirq(&remote_queue->csd, target_cpu,
+			                      this_cpu, NET_RX_SOFTIRQ);
+
+		spin_unlock_irqrestore(&remote_queue->work.lock, flag);
+
+		/*
+		 * Should use skb_queue_head_init(skb_batch), but we don't
+		 * want to stomp on the lock.
+		 */
+		skb_batch->prev = skb_batch->next = (struct sk_buff *)skb_batch;
+		skb_batch->qlen = 0;
+	}
+
+	cpumask_clear(flows_hashed(this_queue));
+	put_cpu();
+}
+
+static void net_rxflow_action(struct softirq_action *h)
+{
+	struct list_head *dev_list;
+	unsigned long time_limit = jiffies + 2;
+	int budget = netdev_budget;
+
+	dev_list = &__get_cpu_var(softirq_work_list[NET_RX_SOFTIRQ]);
+	local_irq_disable();
+
+	while (!list_empty(dev_list)) {
+		struct netdev_rxflow_queue *q;
+		struct sk_buff *skb;
+		unsigned long flag;
+		int last_packet, i;
+
+		if (unlikely(budget <= 0 || time_after(jiffies, time_limit))) {
+			__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+			__get_cpu_var(netdev_rx_stat).time_squeeze++;
+			local_irq_enable();
+			return;
+		}
+
+		local_irq_enable();
+
+		/*
+		 * Access is safe even though interrupts have been enabled.
+		 * New entries are added to the tail of this list by the
+		 * remote softirq handler, and only this function can remove
+		 * this head entry from the list.
+		 */
+		q = list_entry(dev_list->next, struct netdev_rxflow_queue,
+		               csd.list);
+
+		for (last_packet = i = 0; i < weight_p; i++) {
+			spin_lock_irqsave(&q->work.lock, flag);
+			skb = __skb_dequeue(&q->work);
+			if (skb_queue_empty(&q->work)) {
+				list_del_init(&q->csd.list);
+				last_packet = 1;
+			}
+			spin_unlock_irqrestore(&q->work.lock, flag);
+			__netif_receive_skb(skb);
+
+			budget--;
+			if (last_packet)
+				break;
+		}
+
+		local_irq_disable();
+
+		if (!last_packet)
+			list_move_tail(&q->csd.list, dev_list);
+	}
+
+	local_irq_enable();
+}
+#else /* CONFIG_SMP */
+int netif_receive_skb(struct sk_buff *skb)
+{
+	if (netpoll_receive_skb(skb))
+		return NET_RX_DROP;
+
+	return __netif_receive_skb(skb);
+}
+
+#define net_rx_submit_work(dev) do {} while (0)
+#define net_rxflow_action(h) do {} while (0)
+#endif /* CONFIG_SMP */
 EXPORT_SYMBOL(netif_receive_skb);
 
 /* Network device is going away, flush any packets still pending  */
@@ -2912,6 +3287,9 @@ void netif_napi_add(struct net_device *dev, struct napi_struct *napi,
 	napi->weight = weight;
 	list_add(&napi->dev_list, &dev->napi_list);
 	napi->dev = dev;
+#ifdef CONFIG_SMP
+	dev->rx_separate_flow = 1;
+#endif
 #ifdef CONFIG_NETPOLL
 	spin_lock_init(&napi->poll_lock);
 	napi->poll_owner = -1;
@@ -2986,6 +3364,9 @@ static void net_rx_action(struct softirq_action *h)
 
 		WARN_ON_ONCE(work > weight);
 
+		if (work)
+			net_rx_submit_work(n->dev);
+
 		budget -= work;
 
 		local_irq_disable();
@@ -3017,6 +3398,7 @@ out:
 	dma_issue_pending_all();
 #endif
 
+	net_rxflow_action(h);
 	return;
 
 softnet_break:
@@ -6031,7 +6413,7 @@ subsys_initcall(net_dev_init);
 
 static int __init initialize_hashrnd(void)
 {
-	get_random_bytes(&skb_tx_hashrnd, sizeof(skb_tx_hashrnd));
+	get_random_bytes(&skb_hashrnd, sizeof(skb_hashrnd));
 	return 0;
 }
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index fbc1c74..9b389d3 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -289,6 +289,28 @@ static ssize_t show_ifalias(struct device *dev,
 	return ret;
 }
 
+#ifdef CONFIG_SMP
+NETDEVICE_SHOW(rx_cpus, fmt_dec);
+
+static int change_rx_cpus(struct net_device *net,
+                          unsigned long new_rx_cpus)
+{
+	/* No effect until the interface is brought down and up. */
+	if (new_rx_cpus > num_online_cpus())
+		new_rx_cpus = num_online_cpus();
+
+	net->rx_cpus = new_rx_cpus;
+	return 0;
+}
+
+static ssize_t store_rx_cpus(struct device *dev,
+                             struct device_attribute *attr,
+                             const char *buf, size_t len)
+{
+	return netdev_store(dev, attr, buf, len, change_rx_cpus);
+}
+#endif /* CONFIG_SMP */
+
 static struct device_attribute net_class_attributes[] = {
 	__ATTR(addr_len, S_IRUGO, show_addr_len, NULL),
 	__ATTR(dev_id, S_IRUGO, show_dev_id, NULL),
@@ -309,6 +331,9 @@ static struct device_attribute net_class_attributes[] = {
 	__ATTR(flags, S_IRUGO | S_IWUSR, show_flags, store_flags),
 	__ATTR(tx_queue_len, S_IRUGO | S_IWUSR, show_tx_queue_len,
 	       store_tx_queue_len),
+#ifdef CONFIG_SMP
+	__ATTR(rx_cpus, S_IRUGO | S_IWUSR, show_rx_cpus, store_rx_cpus),
+#endif
 	{}
 };
 
-- 
1.6.0.4.766.g6fc4a

