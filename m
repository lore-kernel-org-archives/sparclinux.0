From: Jag Raman <jag.raman@oracle.com>
Date: Wed, 29 Mar 2017 21:51:44 +0000
Subject: [PATCH 3/5] sparc64: ensure LDC channel is ready before communication
Message-Id: <62de609ff9e4fd072e340111efefdd45c6d37cda.1490823535.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Ensure that LDC channel is up before writing to it, in RAW mode. Generate
event to bring the LDC channel up, if it's not up already.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Aaron Young <aaron.young@oracle.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
---
 arch/sparc/kernel/ldc.c |   30 +++++++++++++++++++++++++-----
 1 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index e589090..04996cc 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -846,9 +846,14 @@ static irqreturn_t ldc_rx(int irq, void *dev_id)
 		lp->hs_state = LDC_HS_COMPLETE;
 		ldc_set_state(lp, LDC_STATE_CONNECTED);
 
-		event_mask |= LDC_EVENT_UP;
-
-		orig_state = lp->chan_state;
+		/*
+		 * Generate an LDC_EVENT_UP event if the channel
+		 * was not already up.
+		 */
+		if (orig_state != LDC_CHANNEL_UP) {
+			event_mask |= LDC_EVENT_UP;
+			orig_state = lp->chan_state;
+		}
 	}
 
 	/* If we are in reset state, flush the RX queue and ignore
@@ -962,7 +967,14 @@ static irqreturn_t ldc_tx(int irq, void *dev_id)
 		lp->hs_state = LDC_HS_COMPLETE;
 		ldc_set_state(lp, LDC_STATE_CONNECTED);
 
-		event_mask |= LDC_EVENT_UP;
+		/*
+		 * Generate an LDC_EVENT_UP event if the channel
+		 * was not already up.
+		 */
+		if (orig_state != LDC_CHANNEL_UP) {
+			event_mask |= LDC_EVENT_UP;
+			orig_state = lp->chan_state;
+		}
 	}
 
 	spin_unlock_irqrestore(&lp->lock, flags);
@@ -1512,9 +1524,17 @@ void ldc_print(struct ldc_channel *lp)
 static int write_raw(struct ldc_channel *lp, const void *buf, unsigned int size)
 {
 	struct ldc_packet *p;
-	unsigned long new_tail;
+	unsigned long new_tail, hv_err;
 	int err;
 
+	hv_err = sun4v_ldc_tx_get_state(lp->id, &lp->tx_head, &lp->tx_tail,
+					&lp->chan_state);
+	if (unlikely(hv_err))
+		return -EBUSY;
+
+	if (unlikely(lp->chan_state != LDC_CHANNEL_UP))
+		return LDC_ABORT(lp);
+
 	if (size > LDC_PACKET_SIZE)
 		return -EMSGSIZE;
 
-- 
1.7.1

