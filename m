From: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Date: Sat, 07 Sep 2013 07:38:09 +0000
Subject: [PATCH] sparc: remove deprecated IRQF_DISABLED
Message-Id: <1378539489-7607-1-git-send-email-michael.opdenacker@free-electrons.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Opdenacker <michael.opdenacker@free-electrons.com>

This patch proposes to remove the IRQF_DISABLED flag from sparc architecture
code. It's a NOOP since 2.6.35 and it will be removed one day.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/sparc/include/asm/floppy_64.h | 2 +-
 arch/sparc/kernel/ldc.c            | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/floppy_64.h
index e204f90..7c90c50 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -254,7 +254,7 @@ static int sun_fd_request_irq(void)
 		once = 1;
 
 		error = request_irq(FLOPPY_IRQ, sparc_floppy_irq,
-				    IRQF_DISABLED, "floppy", NULL);
+				    0, "floppy", NULL);
 
 		return ((error = 0) ? 0 : -1);
 	}
diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 54df554..e01d75d 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -1249,12 +1249,12 @@ int ldc_bind(struct ldc_channel *lp, const char *name)
 	snprintf(lp->rx_irq_name, LDC_IRQ_NAME_MAX, "%s RX", name);
 	snprintf(lp->tx_irq_name, LDC_IRQ_NAME_MAX, "%s TX", name);
 
-	err = request_irq(lp->cfg.rx_irq, ldc_rx, IRQF_DISABLED,
+	err = request_irq(lp->cfg.rx_irq, ldc_rx, 0,
 			  lp->rx_irq_name, lp);
 	if (err)
 		return err;
 
-	err = request_irq(lp->cfg.tx_irq, ldc_tx, IRQF_DISABLED,
+	err = request_irq(lp->cfg.tx_irq, ldc_tx, 0,
 			  lp->tx_irq_name, lp);
 	if (err) {
 		free_irq(lp->cfg.rx_irq, lp);
-- 
1.8.1.2

