From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 21 Apr 2015 14:30:41 +0000
Subject: [PATCH] sparc: Use GFP_ATOMIC in ldc_alloc_exp_dring() as it can be called in softirq context
Message-Id: <1429626641-199974-1-git-send-email-sowmini.varadhan@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Since it is possible for vnet_event_napi to end up doing
vnet_control_pkt_engine -> ... -> vnet_send_attr ->
vnet_port_alloc_tx_ring -> ldc_alloc_exp_dring -> kzalloc()
(i.e., in softirq context), kzalloc() should be called with
GFP_ATOMIC from ldc_alloc_exp_dring.

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
---
 arch/sparc/kernel/ldc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index d2ae0f7..7d3ca30 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -2290,7 +2290,7 @@ void *ldc_alloc_exp_dring(struct ldc_channel *lp, unsigned int len,
 	if (len & (8UL - 1))
 		return ERR_PTR(-EINVAL);
 
-	buf = kzalloc(len, GFP_KERNEL);
+	buf = kzalloc(len, GFP_ATOMIC);
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
 
-- 
1.7.1

