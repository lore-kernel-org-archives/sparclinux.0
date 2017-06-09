From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 09 Jun 2017 16:29:28 +0000
Subject: [PATCH v4 1/5] sparc64: expand LDC interface
Message-Id: <0e8f93de4f70681c4e4bd87e39c4dffee5b0b139.1497022394.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add the following LDC APIs which are planned to be used by
LDC clients in the future:
- ldc_set_state: Sets given LDC channel to given state
- ldc_mode: Returns the mode of given LDC channel
- ldc_print: Prints info about given LDC channel
- ldc_rx_reset: Reset the RX queue of given LDC channel

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Aaron Young <aaron.young@oracle.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
---
 arch/sparc/include/asm/ldc.h |    8 +++++++
 arch/sparc/kernel/ldc.c      |   46 +++++++++++++++++++++++++++++++-----------
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/arch/sparc/include/asm/ldc.h b/arch/sparc/include/asm/ldc.h
index 6e9004a..698738a 100644
--- a/arch/sparc/include/asm/ldc.h
+++ b/arch/sparc/include/asm/ldc.h
@@ -48,6 +48,8 @@ struct ldc_channel_config {
 #define LDC_STATE_READY		0x03
 #define LDC_STATE_CONNECTED	0x04
 
+#define	LDC_PACKET_SIZE		64
+
 struct ldc_channel;
 
 /* Allocate state for a channel.  */
@@ -72,6 +74,12 @@ struct ldc_channel *ldc_alloc(unsigned long id,
 int ldc_disconnect(struct ldc_channel *lp);
 
 int ldc_state(struct ldc_channel *lp);
+void ldc_set_state(struct ldc_channel *lp, u8 state);
+int ldc_mode(struct ldc_channel *lp);
+void __ldc_print(struct ldc_channel *lp, const char *caller);
+int ldc_rx_reset(struct ldc_channel *lp);
+
+#define	ldc_print(chan)	__ldc_print(chan, __func__)
 
 /* Read and write operations.  Only valid when the link is up.  */
 int ldc_write(struct ldc_channel *lp, const void *buf,
diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 59d5038..77c34b0 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -34,7 +34,6 @@
 
 static char version[]  	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
-#define LDC_PACKET_SIZE		64
 
 /* Packet header layout for unreliable and reliable mode frames.
  * When in RAW mode, packets are simply straight 64-byte payloads
@@ -196,15 +195,6 @@ struct ldc_channel {
 	}
 }
 
-static void ldc_set_state(struct ldc_channel *lp, u8 state)
-{
-	ldcdbg(STATE, "STATE (%s) --> (%s)\n",
-	       state_to_str(lp->state),
-	       state_to_str(state));
-
-	lp->state = state;
-}
-
 static unsigned long __advance(unsigned long off, unsigned long num_entries)
 {
 	off += LDC_PACKET_SIZE;
@@ -829,7 +819,7 @@ static irqreturn_t ldc_rx(int irq, void *dev_id)
 	 * everything.
 	 */
 	if (lp->flags & LDC_FLAG_RESET) {
-		(void) __set_rx_head(lp, lp->rx_tail);
+		(void) ldc_rx_reset(lp);
 		goto out;
 	}
 
@@ -1447,6 +1437,38 @@ int ldc_state(struct ldc_channel *lp)
 }
 EXPORT_SYMBOL(ldc_state);
 
+void ldc_set_state(struct ldc_channel *lp, u8 state)
+{
+	ldcdbg(STATE, "STATE (%s) --> (%s)\n",
+	       state_to_str(lp->state),
+	       state_to_str(state));
+
+	lp->state = state;
+}
+
+int ldc_mode(struct ldc_channel *lp)
+{
+	return lp->cfg.mode;
+}
+
+int ldc_rx_reset(struct ldc_channel *lp)
+{
+	return __set_rx_head(lp, lp->rx_tail);
+}
+
+void __ldc_print(struct ldc_channel *lp, const char *caller)
+{
+	pr_info("%s: id=0x%lx flags=0x%x state=%s cstate=0x%lx hsstate=0x%x\n"
+		"\trx_h=0x%lx rx_t=0x%lx rx_n=%ld\n"
+		"\ttx_h=0x%lx tx_t=0x%lx tx_n=%ld\n"
+		"\trcv_nxt=%u snd_nxt=%u\n",
+		caller, lp->id, lp->flags, state_to_str(lp->state),
+		lp->chan_state, lp->hs_state,
+		lp->rx_head, lp->rx_tail, lp->rx_num_entries,
+		lp->tx_head, lp->tx_tail, lp->tx_num_entries,
+		lp->rcv_nxt, lp->snd_nxt);
+}
+
 static int write_raw(struct ldc_channel *lp, const void *buf, unsigned int size)
 {
 	struct ldc_packet *p;
@@ -1592,7 +1614,7 @@ static int rx_bad_seq(struct ldc_channel *lp, struct ldc_packet *p,
 	if (err)
 		return err;
 
-	err = __set_rx_head(lp, lp->rx_tail);
+	err = ldc_rx_reset(lp);
 	if (err < 0)
 		return ldc_abort(lp);
 
-- 
1.7.1

