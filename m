From: Chris Torek <chris.torek@windriver.com>
Date: Thu, 04 Feb 2010 11:26:00 +0000
Subject: [PATCH 6/8] net: add rxflow sirq
Message-Id: <6babb06d2d37fc1ea764d37b86c5a589f387201c.1265231569.git.chris.torek@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hong H. Pham <hong.pham@windriver.com>

Add a new soft interrupt type to handle flow separation on
receive work.

Signed-off-by: Hong H. Pham <hong.pham@windriver.com>
Signed-off-by: Chris Torek <chris.torek@windriver.com>
---
 include/linux/interrupt.h |    1 +
 kernel/softirq.c          |    3 ++-
 net/core/dev.c            |    8 ++++----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 75f3f00..39a8701 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -344,6 +344,7 @@ enum
 	TIMER_SOFTIRQ,
 	NET_TX_SOFTIRQ,
 	NET_RX_SOFTIRQ,
+	NET_RX_FLOW_SOFTIRQ,
 	BLOCK_SOFTIRQ,
 	BLOCK_IOPOLL_SOFTIRQ,
 	TASKLET_SOFTIRQ,
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 21939d9..b3730b1 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -57,7 +57,8 @@ static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp
 static DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
 
 char *softirq_to_name[NR_SOFTIRQS] = {
-	"HI", "TIMER", "NET_TX", "NET_RX", "BLOCK", "BLOCK_IOPOLL",
+	"HI", "TIMER", "NET_TX", "NET_RX", "NET_RX_FLOW",
+	"BLOCK", "BLOCK_IOPOLL",
 	"TASKLET", "SCHED", "HRTIMER",	"RCU"
 };
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 4168964..1b208ee 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2804,7 +2804,7 @@ static void net_rx_submit_work(struct net_device *dev)
 
 		if (!old_qlen)
 			__send_remote_softirq(&remote_queue->csd, target_cpu,
-			                      this_cpu, NET_RX_SOFTIRQ);
+			                      this_cpu, NET_RX_FLOW_SOFTIRQ);
 
 		spin_unlock_irqrestore(&remote_queue->work.lock, flag);
 
@@ -2826,7 +2826,7 @@ static void net_rxflow_action(struct softirq_action *h)
 	unsigned long time_limit = jiffies + 2;
 	int budget = netdev_budget;
 
-	dev_list = &__get_cpu_var(softirq_work_list[NET_RX_SOFTIRQ]);
+	dev_list = &__get_cpu_var(softirq_work_list[NET_RX_FLOW_SOFTIRQ]);
 	local_irq_disable();
 
 	while (!list_empty(dev_list)) {
@@ -2836,7 +2836,7 @@ static void net_rxflow_action(struct softirq_action *h)
 		int last_packet, i;
 
 		if (unlikely(budget <= 0 || time_after(jiffies, time_limit))) {
-			__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+			__raise_softirq_irqoff(NET_RX_FLOW_SOFTIRQ);
 			__get_cpu_var(netdev_rx_stat).time_squeeze++;
 			local_irq_enable();
 			return;
@@ -3398,7 +3398,6 @@ out:
 	dma_issue_pending_all();
 #endif
 
-	net_rxflow_action(h);
 	return;
 
 softnet_break:
@@ -6400,6 +6399,7 @@ static int __init net_dev_init(void)
 
 	open_softirq(NET_TX_SOFTIRQ, net_tx_action);
 	open_softirq(NET_RX_SOFTIRQ, net_rx_action);
+	open_softirq(NET_RX_FLOW_SOFTIRQ, net_rxflow_action);
 
 	hotcpu_notifier(dev_cpu_callback, 0);
 	dst_init();
-- 
1.6.0.4.766.g6fc4a

