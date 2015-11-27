From: Petr Mladek <pmladek@suse.com>
Date: Fri, 27 Nov 2015 11:09:29 +0000
Subject: [PATCH v2 2/5] printk/nmi: Use IRQ work only when ready
Message-Id: <1448622572-16900-3-git-send-email-pmladek@suse.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
In-Reply-To: <1448622572-16900-1-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

NMIs could happen at any time. This patch makes sure that the safe
printk() in NMI will schedule IRQ work only when the related
structs are initialized.

All pending messages are flushed when the IRQ work is being
initialized.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nmi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
index 3989e13a0021..05b4c09110f9 100644
--- a/kernel/printk/nmi.c
+++ b/kernel/printk/nmi.c
@@ -36,6 +36,7 @@
  * were handled or when IRQs are blocked.
  */
 DEFINE_PER_CPU(printk_func_t, printk_func) = vprintk_default;
+static int printk_nmi_irq_ready;
 
 struct nmi_seq_buf {
 	atomic_t		len;	/* length of written data */
@@ -80,8 +81,11 @@ again:
 		goto again;
 
 	/* Get flushed in a more safe context. */
-	if (add)
+	if (add && printk_nmi_irq_ready) {
+		/* Make sure that IRQ work is really initialized. */
+		smp_rmb();
 		irq_work_queue(&s->work);
+	}
 
 	return add;
 }
@@ -187,6 +191,13 @@ void __init printk_nmi_init(void)
 
 		init_irq_work(&s->work, __printk_nmi_flush);
 	}
+
+	/* Make sure that IRQ works are initialized before enabling. */
+	smp_wmb();
+	printk_nmi_irq_ready = 1;
+
+	/* Flush pending messages that did not have scheduled IRQ works. */
+	printk_nmi_flush();
 }
 
 void printk_nmi_enter(void)
-- 
1.8.5.6

