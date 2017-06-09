From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 09 Jun 2017 16:29:29 +0000
Subject: [PATCH v4 2/5] sparc64: enhance ldc_abort to print message
Message-Id: <af6df2784a30e3a4592a459cf80dcd51304d41b7.1497022394.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Enhance ldc_abort to accept a message to be printed when it is called. Add
a macro, LDC_ABORT, to print info. about the function that calls ldc_abort.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Aaron Young <aaron.young@oracle.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
---
 arch/sparc/kernel/ldc.c |   53 ++++++++++++++++++++++++----------------------
 1 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 77c34b0..902cbf4 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -177,6 +177,8 @@ struct ldc_channel {
 		printk(KERN_INFO PFX "ID[%lu] " f, lp->id, ## a); \
 } while (0)
 
+#define	LDC_ABORT(lp)	ldc_abort((lp), __func__)
+
 static const char *state_to_str(u8 state)
 {
 	switch (state) {
@@ -506,11 +508,12 @@ static int send_data_nack(struct ldc_channel *lp, struct ldc_packet *data_pkt)
 	return err;
 }
 
-static int ldc_abort(struct ldc_channel *lp)
+static int ldc_abort(struct ldc_channel *lp, const char *msg)
 {
 	unsigned long hv_err;
 
-	ldcdbg(STATE, "ABORT\n");
+	ldcdbg(STATE, "ABORT[%s]\n", msg);
+	ldc_print(lp);
 
 	/* We report but do not act upon the hypervisor errors because
 	 * there really isn't much we can do if they fail at this point.
@@ -595,7 +598,7 @@ static int process_ver_info(struct ldc_channel *lp, struct ldc_version *vp)
 		}
 	}
 	if (err)
-		return ldc_abort(lp);
+		return LDC_ABORT(lp);
 
 	return 0;
 }
@@ -608,13 +611,13 @@ static int process_ver_ack(struct ldc_channel *lp, struct ldc_version *vp)
 	if (lp->hs_state = LDC_HS_GOTVERS) {
 		if (lp->ver.major != vp->major ||
 		    lp->ver.minor != vp->minor)
-			return ldc_abort(lp);
+			return LDC_ABORT(lp);
 	} else {
 		lp->ver = *vp;
 		lp->hs_state = LDC_HS_GOTVERS;
 	}
 	if (send_rts(lp))
-		return ldc_abort(lp);
+		return LDC_ABORT(lp);
 	return 0;
 }
 
@@ -625,17 +628,17 @@ static int process_ver_nack(struct ldc_channel *lp, struct ldc_version *vp)
 	unsigned long new_tail;
 
 	if (vp->major = 0 && vp->minor = 0)
-		return ldc_abort(lp);
+		return LDC_ABORT(lp);
 
 	vap = find_by_major(vp->major);
 	if (!vap)
-		return ldc_abort(lp);
+		return LDC_ABORT(lp);
 
 	p = handshake_compose_ctrl(lp, LDC_INFO, LDC_VERS,
 					   vap, sizeof(*vap),
 					   &new_tail);
 	if (!p)
-		return ldc_abort(lp);
+		return LDC_ABORT(lp);
 
 	return send_tx_packet(lp, p, new_tail);
 }
@@ -658,7 +661,7 @@ static int process_version(struct ldc_channel *lp,
 		return process_ver_nack(lp, vp);
 
 	default:
-		return ldc_abort(lp);
+		return LDC_ABORT(lp);
 	}
 }
 
@@ -671,13 +674,13 @@ static int process_rts(struct ldc_channel *lp,
 	if (p->stype     != LDC_INFO	   ||
 	    lp->hs_state != LDC_HS_GOTVERS ||
 	    p->env       != lp->cfg.mode)
-		return ldc_abort(lp);
+		return LDC_ABORT(lp);
 
 	lp->snd_nxt = p->seqid;
 	lp->rcv_nxt = p->seqid;
 	lp->hs_state = LDC_HS_SENTRTR;
 	if (send_rtr(lp))
-		return ldc_abort(lp);
+		return LDC_ABORT(lp);
 
 	return 0;
 }
@@ -690,7 +693,7 @@ static int process_rtr(struct ldc_channel *lp,
 
 	if (p->stype     != LDC_INFO ||
 	    p->env       != lp->cfg.mode)
-		return ldc_abort(lp);
+		return LDC_ABORT(lp);
 
 	lp->snd_nxt = p->seqid;
 	lp->hs_state = LDC_HS_COMPLETE;
@@ -713,7 +716,7 @@ static int process_rdx(struct ldc_channel *lp,
 
 	if (p->stype != LDC_INFO ||
 	    !(rx_seq_ok(lp, p->seqid)))
-		return ldc_abort(lp);
+		return LDC_ABORT(lp);
 
 	lp->rcv_nxt = p->seqid;
 
@@ -740,14 +743,14 @@ static int process_control_frame(struct ldc_channel *lp,
 		return process_rdx(lp, p);
 
 	default:
-		return ldc_abort(lp);
+		return LDC_ABORT(lp);
 	}
 }
 
 static int process_error_frame(struct ldc_channel *lp,
 			       struct ldc_packet *p)
 {
-	return ldc_abort(lp);
+	return LDC_ABORT(lp);
 }
 
 static int process_data_ack(struct ldc_channel *lp,
@@ -766,7 +769,7 @@ static int process_data_ack(struct ldc_channel *lp,
 			return 0;
 		}
 		if (head = lp->tx_tail)
-			return ldc_abort(lp);
+			return LDC_ABORT(lp);
 	}
 
 	return 0;
@@ -870,7 +873,7 @@ static irqreturn_t ldc_rx(int irq, void *dev_id)
 			break;
 
 		default:
-			err = ldc_abort(lp);
+			err = LDC_ABORT(lp);
 			break;
 		}
 
@@ -885,7 +888,7 @@ static irqreturn_t ldc_rx(int irq, void *dev_id)
 
 		err = __set_rx_head(lp, new);
 		if (err < 0) {
-			(void) ldc_abort(lp);
+			(void) LDC_ABORT(lp);
 			break;
 		}
 		if (lp->hs_state = LDC_HS_COMPLETE)
@@ -1505,7 +1508,7 @@ static int read_raw(struct ldc_channel *lp, void *buf, unsigned int size)
 					&lp->rx_tail,
 					&lp->chan_state);
 	if (hv_err)
-		return ldc_abort(lp);
+		return LDC_ABORT(lp);
 
 	if (lp->chan_state = LDC_CHANNEL_DOWN ||
 	    lp->chan_state = LDC_CHANNEL_RESETTING)
@@ -1548,7 +1551,7 @@ static int write_nonraw(struct ldc_channel *lp, const void *buf,
 		return -EBUSY;
 
 	if (unlikely(lp->chan_state != LDC_CHANNEL_UP))
-		return ldc_abort(lp);
+		return LDC_ABORT(lp);
 
 	if (!tx_has_space_for(lp, size))
 		return -EAGAIN;
@@ -1616,7 +1619,7 @@ static int rx_bad_seq(struct ldc_channel *lp, struct ldc_packet *p,
 
 	err = ldc_rx_reset(lp);
 	if (err < 0)
-		return ldc_abort(lp);
+		return LDC_ABORT(lp);
 
 	return 0;
 }
@@ -1629,7 +1632,7 @@ static int data_ack_nack(struct ldc_channel *lp, struct ldc_packet *p)
 			return err;
 	}
 	if (p->stype & LDC_NACK)
-		return ldc_abort(lp);
+		return LDC_ABORT(lp);
 
 	return 0;
 }
@@ -1649,7 +1652,7 @@ static int rx_data_wait(struct ldc_channel *lp, unsigned long cur_head)
 						&lp->rx_tail,
 						&lp->chan_state);
 		if (hv_err)
-			return ldc_abort(lp);
+			return LDC_ABORT(lp);
 
 		if (lp->chan_state = LDC_CHANNEL_DOWN ||
 		    lp->chan_state = LDC_CHANNEL_RESETTING)
@@ -1672,7 +1675,7 @@ static int rx_set_head(struct ldc_channel *lp, unsigned long head)
 	int err = __set_rx_head(lp, head);
 
 	if (err < 0)
-		return ldc_abort(lp);
+		return LDC_ABORT(lp);
 
 	lp->rx_head = head;
 	return 0;
@@ -1711,7 +1714,7 @@ static int read_nonraw(struct ldc_channel *lp, void *buf, unsigned int size)
 					&lp->rx_tail,
 					&lp->chan_state);
 	if (hv_err)
-		return ldc_abort(lp);
+		return LDC_ABORT(lp);
 
 	if (lp->chan_state = LDC_CHANNEL_DOWN ||
 	    lp->chan_state = LDC_CHANNEL_RESETTING)
-- 
1.7.1

