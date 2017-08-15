From: Jag Raman <jag.raman@oracle.com>
Date: Tue, 15 Aug 2017 21:02:58 +0000
Subject: [PATCH v2 02/13] sparc64: vcc: Add VCC debug message macros
Message-Id: <06e30803f85a853258685d1d313353ccf09d52db.1502829972.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add C macros to print debug messages from VCC module

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/sparc/kernel/ldc.c |    1 +
 drivers/tty/vcc.c       |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 840e0b2..1169915 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -1493,6 +1493,7 @@ void __ldc_print(struct ldc_channel *lp, const char *caller)
 		lp->tx_head, lp->tx_tail, lp->tx_num_entries,
 		lp->rcv_nxt, lp->snd_nxt);
 }
+EXPORT_SYMBOL(__ldc_print);
 
 static int write_raw(struct ldc_channel *lp, const void *buf, unsigned int size)
 {
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index e1b8099..4fd8dd0 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -5,6 +5,47 @@
 
 #include <linux/module.h>
 
+#define DRV_MODULE_NAME		"vcc"
+#define DRV_MODULE_VERSION	"1.1"
+#define DRV_MODULE_RELDATE	"July 1, 2017"
+
+MODULE_DESCRIPTION("Sun LDOM virtual console concentrator driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_MODULE_VERSION);
+
+int vcc_dbg;
+int vcc_dbg_ldc;
+int vcc_dbg_vio;
+
+module_param(vcc_dbg, uint, 0664);
+module_param(vcc_dbg_ldc, uint, 0664);
+module_param(vcc_dbg_vio, uint, 0664);
+
+#define VCC_DBG_DRV	0x1
+#define VCC_DBG_LDC	0x2
+#define VCC_DBG_PKT	0x4
+
+#define vccdbg(f, a...)						\
+	do {							\
+		if (vcc_dbg & VCC_DBG_DRV)			\
+			pr_info(f, ## a);			\
+	} while (0)						\
+
+#define vccdbgl(l)						\
+	do {							\
+		if (vcc_dbg & VCC_DBG_LDC)			\
+			ldc_print(l);				\
+	} while (0)						\
+
+#define vccdbgp(pkt)						\
+	do {							\
+		if (vcc_dbg & VCC_DBG_PKT) {			\
+			int i;					\
+			for (i = 0; i < pkt.tag.stype; i++)	\
+				pr_info("[%c]", pkt.data[i]);	\
+		}						\
+	} while (0)						\
+
 static int __init vcc_init(void)
 {
 	return 0;
-- 
1.7.1

