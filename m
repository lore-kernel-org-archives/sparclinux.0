From: Petr Mladek <pmladek@suse.com>
Date: Wed, 09 Dec 2015 13:21:03 +0000
Subject: [PATCH v3 2/4] printk/nmi: Use IRQ work only when ready
Message-Id: <1449667265-17525-3-git-send-email-pmladek@suse.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
In-Reply-To: <1449667265-17525-1-git-send-email-pmladek@suse.com>
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
index 7b5ff81b291f..29a498586465 100644
--- a/kernel/printk/nmi.c
+++ b/kernel/printk/nmi.c
@@ -38,6 +38,7 @@
  * were handled or when IRQs are blocked.
  */
 DEFINE_PER_CPU(printk_func_t, printk_func) = vprintk_default;
+static int printk_nmi_irq_ready;
 
 #define NMI_LOG_BUF_LEN (4096 - sizeof(atomic_t) - sizeof(struct irq_work))
 
@@ -83,8 +84,11 @@ again:
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
@@ -190,6 +194,13 @@ void __init printk_nmi_init(void)
 
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

