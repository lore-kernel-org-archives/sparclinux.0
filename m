From: Wei Yongjun <yjwei@cn.fujitsu.com>
Date: Tue, 31 Mar 2009 08:49:10 +0000
Subject: [PATCH] sparc: remove some pointless conditionals before kfree()
Message-Id: <49D1D906.4060602@cn.fujitsu.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Remove some pointless conditionals before kfree().

Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>
---
 arch/sparc/kernel/ldc.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 6ce5d25..adf5f27 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -1183,8 +1183,7 @@ out_free_txq:
 	free_queue(lp->tx_num_entries, lp->tx_base);
 
 out_free_mssbuf:
-	if (mssbuf)
-		kfree(mssbuf);
+	kfree(mssbuf);
 
 out_free_iommu:
 	ldc_iommu_release(lp);
@@ -1217,8 +1216,7 @@ void ldc_free(struct ldc_channel *lp)
 
 	hlist_del(&lp->list);
 
-	if (lp->mssbuf)
-		kfree(lp->mssbuf);
+	kfree(lp->mssbuf);
 
 	ldc_iommu_release(lp);
 
-- 
1.5.3.8




