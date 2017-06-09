From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 09 Jun 2017 16:30:52 +0000
Subject: [PATCH v1 03/12] sparc64: skip handshake for LDC channels in RAW mode
Message-Id: <2fa8719fee2bde0cac3be9671d49d0eedbe76c72.1497024216.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

LDC channels in RAW mode does not provide any session management. No
handshake protocol is defined for LDC channels in RAW mode. It's
therefore skipped.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/sparc/kernel/ldc.c   |   10 ++++++++++
 arch/sparc/kernel/viohs.c |    6 +++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 97a5743..840e0b2 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -1347,6 +1347,14 @@ int ldc_bind(struct ldc_channel *lp)
 	lp->hs_state = LDC_HS_OPEN;
 	ldc_set_state(lp, LDC_STATE_BOUND);
 
+	if (lp->cfg.mode = LDC_MODE_RAW) {
+		/*
+		 * There is no handshake in RAW mode, so handshake
+		 * is completed.
+		 */
+		lp->hs_state = LDC_HS_COMPLETE;
+	}
+
 	spin_unlock_irqrestore(&lp->lock, flags);
 
 	return 0;
@@ -1460,11 +1468,13 @@ void ldc_set_state(struct ldc_channel *lp, u8 state)
 
 	lp->state = state;
 }
+EXPORT_SYMBOL(ldc_set_state);
 
 int ldc_mode(struct ldc_channel *lp)
 {
 	return lp->cfg.mode;
 }
+EXPORT_SYMBOL(ldc_mode);
 
 int ldc_rx_reset(struct ldc_channel *lp)
 {
diff --git a/arch/sparc/kernel/viohs.c b/arch/sparc/kernel/viohs.c
index 68e952a..d4f13c0 100644
--- a/arch/sparc/kernel/viohs.c
+++ b/arch/sparc/kernel/viohs.c
@@ -776,7 +776,11 @@ void vio_port_up(struct vio_driver_state *vio)
 	}
 
 	if (!err) {
-		err = ldc_connect(vio->lp);
+		if (ldc_mode(vio->lp) = LDC_MODE_RAW)
+			ldc_set_state(vio->lp, LDC_STATE_CONNECTED);
+		else
+			err = ldc_connect(vio->lp);
+
 		if (err)
 			printk(KERN_WARNING "%s: Port %lu connect failed, "
 			       "err=%d\n",
-- 
1.7.1

