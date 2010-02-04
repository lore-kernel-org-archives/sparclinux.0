From: Chris Torek <chris.torek@windriver.com>
Date: Thu, 04 Feb 2010 11:25:55 +0000
Subject: [PATCH 1/8] niu configurable parameters
Message-Id: <cfb0bb6f8ecbdcf46bbd365cc557336ef968b093.1265231568.git.chris.torek@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hong H. Pham <hong.pham@windriver.com>

Add support for boot or runtime configuration for various NIU
driver parameters.  Runtime configuration is done through the
control files in /sys/modules/niu/parameters/.  After changing
a configuration parameter, it is recommended that the interface
is brought down and up again to accept the new configuration.

The following is a list configurable NIU parameters.

  Parameter           Values    Description
  ========== ===== ================  wred_nonsyn_window  0..15     Weighted Random Early Discard window
                                for non-TCP packets.
  wred_syn_window     0..15     Weighted Random Early Discard window
                                for TCP packets.
  rcr_timeout         0..63     RCR timeout for interrupt mitigation
  rcr_pkt_threshold   0..65535  RCR packet threshold for interrupt
                                mitigation.
  rbr_refill_min      0..n      Minimum RBR refill threshold (note:
                                n is automatically limited to no more
                                than half the Receive Block Rings).

Signed-off-by: Hong H. Pham <hong.pham@windriver.com>
Signed-off-by: Chris Torek <chris.torek@windriver.com>
---
 drivers/net/niu.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/net/niu.c b/drivers/net/niu.c
index 8ce58c4..cfb43a4 100644
--- a/drivers/net/niu.c
+++ b/drivers/net/niu.c
@@ -45,6 +45,37 @@ MODULE_DESCRIPTION("NIU ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_MODULE_VERSION);
 
+#define RDC_RED_PARA_WIN_MAX (RDC_RED_PARA_WIN >> RDC_RED_PARA_WIN_SHIFT)
+static unsigned int wred_nonsyn_window __read_mostly = 0;
+module_param(wred_nonsyn_window, uint, 0644);
+MODULE_PARM_DESC(wred_nonsyn_window,
+	"Weighted Random Early Discard window for non-TCP packets (0-"
+	__stringify(RDC_RED_PARA_WIN_MAX) ")");
+
+#define RDC_RED_PARA_WIN_SYN_MAX \
+        (RDC_RED_PARA_WIN_SYN >> RDC_RED_PARA_WIN_SYN_SHIFT)
+static unsigned int wred_syn_window __read_mostly = 0;
+module_param(wred_syn_window, uint, 0644);
+MODULE_PARM_DESC(wred_syn_window,
+	"Weight Random Early Discard window for TCP packets (0-)"
+	__stringify(RDC_RED_PARA_WIN_SYN_MAX) ")");
+
+#define RCRCFIG_B_TIMEOUT_MAX (RCRCFIG_B_TIMEOUT >> RCRCFIG_B_TIMEOUT_SHIFT)
+static unsigned int rcr_timeout __read_mostly = 8;
+module_param(rcr_timeout, uint, 0644);
+MODULE_PARM_DESC(rcr_timeout, "RCR timeout (0-"
+	__stringify(RCRCFIG_B_TIMEOUT_MAX) ")");
+
+#define RCRCFIG_B_PTHRES_MAX (RCRCFIG_B_PTHRES >> RCRCFIG_B_PTHRES_SHIFT)
+static unsigned int rcr_pkt_threshold __read_mostly = 16;
+module_param(rcr_pkt_threshold, uint, 0644);
+MODULE_PARM_DESC(rcr_pkt_threshold, "RCR packet threshold (0-"
+	__stringify(RCRCFIG_B_PTHRES_MAX) ")");
+
+static unsigned int rbr_refill_min __read_mostly = RBR_REFILL_MIN;
+module_param(rbr_refill_min, uint, 0644);
+MODULE_PARM_DESC(rbr_refill_min, "Minimum RBR refill threshold");
+
 #ifndef readq
 static u64 readq(void __iomem *reg)
 {
@@ -4550,14 +4581,30 @@ static int niu_alloc_channels(struct niu *np)
 
 		niu_size_rbr(np, rp);
 
-		/* XXX better defaults, configurable, etc... XXX */
-		rp->nonsyn_window = 64;
+		if (wred_nonsyn_window > RDC_RED_PARA_WIN_MAX)
+			wred_nonsyn_window = RDC_RED_PARA_WIN_MAX;
+		rp->nonsyn_window = wred_nonsyn_window;
 		rp->nonsyn_threshold = rp->rcr_table_size - 64;
-		rp->syn_window = 64;
+
+		if (wred_syn_window > RDC_RED_PARA_WIN_SYN_MAX)
+			wred_syn_window = RDC_RED_PARA_WIN_SYN_MAX;
+		rp->syn_window = wred_syn_window;
 		rp->syn_threshold = rp->rcr_table_size - 64;
-		rp->rcr_pkt_threshold = 16;
-		rp->rcr_timeout = 8;
-		rp->rbr_kick_thresh = RBR_REFILL_MIN;
+
+		if (rcr_pkt_threshold > RCRCFIG_B_PTHRES_MAX)
+			rcr_pkt_threshold = RCRCFIG_B_PTHRES_MAX;
+		rp->rcr_pkt_threshold = rcr_pkt_threshold;
+
+		if (rcr_timeout > RCRCFIG_B_TIMEOUT_MAX)
+			rcr_timeout = RCRCFIG_B_TIMEOUT_MAX;
+		rp->rcr_timeout = rcr_timeout;
+
+		if (rbr_refill_min < 1)
+			rbr_refill_min = 1;
+		if (rbr_refill_min > (rp->rbr_table_size / 2))
+			rbr_refill_min = rp->rbr_table_size / 2;
+		rp->rbr_kick_thresh = rbr_refill_min;
+
 		if (rp->rbr_kick_thresh < rp->rbr_blocks_per_page)
 			rp->rbr_kick_thresh = rp->rbr_blocks_per_page;
 
-- 
1.6.0.4.766.g6fc4a

