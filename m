From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 01 Aug 2014 13:50:40 +0000
Subject: [PATCH sparc] ldc_connect() should not return EINVAL when handshake is in progress.
Message-Id: <20140801135040.GE19031@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



The LDC handshake could have been asynchronously triggered
after ldc_bind() enables the ldc_rx() receive interrupt-handler
(and thus intercepts incoming control packets)
and before vio_port_up() calls ldc_connect(). If that is the case,
ldc_connect() should return 0 and let the state-machine
progress.

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Acked-by: Karl Volz <karl.volz@oracle.com>
---
Resending to the correct list this time.

 arch/sparc/kernel/ldc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index e01d75d..66dacd5 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -1336,7 +1336,7 @@ int ldc_connect(struct ldc_channel *lp)
 	if (!(lp->flags & LDC_FLAG_ALLOCED_QUEUES) ||
 	    !(lp->flags & LDC_FLAG_REGISTERED_QUEUES) ||
 	    lp->hs_state != LDC_HS_OPEN)
-		err = -EINVAL;
+		err = ((lp->hs_state > LDC_HS_OPEN) ? 0 : -EINVAL);
 	else
 		err = start_handshake(lp);
 
-- 
1.8.4.2

