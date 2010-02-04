From: Chris Torek <chris.torek@windriver.com>
Date: Thu, 04 Feb 2010 11:26:01 +0000
Subject: [PATCH 7/8] niu: reserve interrupt-service CPU
Message-Id: <a808bc11fd003313e180c91e9aac769cb9c94448.1265231570.git.chris.torek@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hong H. Pham <hong.pham@windriver.com>

Register the CPU used for interrupt handling with the network
device layer so that other work can be distributed evenly and
optimally across the remaining CPUs.

Signed-off-by: Hong H. Pham <hong.pham@windriver.com>
Signed-off-by: Chris Torek <chris.torek@windriver.com>
---
 drivers/net/niu.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/net/niu.c b/drivers/net/niu.c
index cfb43a4..c82e970 100644
--- a/drivers/net/niu.c
+++ b/drivers/net/niu.c
@@ -6143,6 +6143,7 @@ static int niu_request_irq(struct niu *np)
 	for (i = 0; i < np->num_ldg; i++) {
 		struct niu_ldg *lp = &np->ldg[i];
 
+		netdev_reserve_cpu(netdev_map_to_cpu(lp->irq));
 		err = request_irq(lp->irq, niu_interrupt,
 				  IRQF_SHARED | IRQF_SAMPLE_RANDOM,
 				  np->irq_name[i], lp);
@@ -6158,6 +6159,7 @@ out_free_irqs:
 		struct niu_ldg *lp = &np->ldg[j];
 
 		free_irq(lp->irq, lp);
+		netdev_release_cpu(netdev_map_to_cpu(lp->irq));
 	}
 	return err;
 }
@@ -6170,6 +6172,7 @@ static void niu_free_irq(struct niu *np)
 		struct niu_ldg *lp = &np->ldg[i];
 
 		free_irq(lp->irq, lp);
+		netdev_release_cpu(netdev_map_to_cpu(lp->irq));
 	}
 }
 
-- 
1.6.0.4.766.g6fc4a

