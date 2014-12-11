From: Dwight Engen <dwight.engen@oracle.com>
Date: Thu, 11 Dec 2014 17:26:16 +0000
Subject: [PATCH 2/3] sparc/ldc: create separate ldc_unbind from ldc_free
Message-Id: <1418318777-16453-2-git-send-email-dwight.engen@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Dwight Engen <dwight.engen@oracle.com>
---
 arch/sparc/include/asm/ldc.h |    1 +
 arch/sparc/kernel/ldc.c      |   12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/ldc.h b/arch/sparc/include/asm/ldc.h
index 58ab64d..6e9004a 100644
--- a/arch/sparc/include/asm/ldc.h
+++ b/arch/sparc/include/asm/ldc.h
@@ -61,6 +61,7 @@ void ldc_free(struct ldc_channel *lp);
 
 /* Register TX and RX queues of the link with the hypervisor.  */
 int ldc_bind(struct ldc_channel *lp);
+void ldc_unbind(struct ldc_channel *lp);
 
 /* For non-RAW protocols we need to complete a handshake before
  * communication can proceed.  ldc_connect() does that, if the
diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 4310332..274a9f5 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -1222,11 +1222,12 @@ out_err:
 }
 EXPORT_SYMBOL(ldc_alloc);
 
-void ldc_free(struct ldc_channel *lp)
+void ldc_unbind(struct ldc_channel *lp)
 {
 	if (lp->flags & LDC_FLAG_REGISTERED_IRQS) {
 		free_irq(lp->cfg.rx_irq, lp);
 		free_irq(lp->cfg.tx_irq, lp);
+		lp->flags &= ~LDC_FLAG_REGISTERED_IRQS;
 	}
 
 	if (lp->flags & LDC_FLAG_REGISTERED_QUEUES) {
@@ -1240,10 +1241,15 @@ void ldc_free(struct ldc_channel *lp)
 		lp->flags &= ~LDC_FLAG_ALLOCED_QUEUES;
 	}
 
-	hlist_del(&lp->list);
+	ldc_set_state(lp, LDC_STATE_INIT);
+}
+EXPORT_SYMBOL(ldc_unbind);
 
+void ldc_free(struct ldc_channel *lp)
+{
+	ldc_unbind(lp);
+	hlist_del(&lp->list);
 	kfree(lp->mssbuf);
-
 	ldc_iommu_release(lp);
 
 	kfree(lp);
-- 
1.7.1

