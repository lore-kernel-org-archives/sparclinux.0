From: Jag Raman <jag.raman@oracle.com>
Date: Thu, 25 May 2017 14:25:58 +0000
Subject: [PATCH v3 5/5] sparc64: print debug messages when reading from LDC channel
Message-Id: <584d3ef4b77bce1054a190df86526d7a1a1604f1.1495721691.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Print debug messages when reading from given LDC channel.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Aaron Young <aaron.young@oracle.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
---
 arch/sparc/kernel/ldc.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 4a27f53..005ec8b 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -1954,6 +1954,8 @@ int ldc_read(struct ldc_channel *lp, void *buf, unsigned int size)
 	unsigned long flags;
 	int err;
 
+	ldcdbg(RX, "%s: entered size=%d\n", __func__, size);
+
 	if (!buf)
 		return -EINVAL;
 
@@ -1969,6 +1971,9 @@ int ldc_read(struct ldc_channel *lp, void *buf, unsigned int size)
 
 	spin_unlock_irqrestore(&lp->lock, flags);
 
+	ldcdbg(RX, "%s: mode=%d, head=%lu, tail=%lu rv=%d\n", __func__,
+	       lp->cfg.mode, lp->rx_head, lp->rx_tail, err);
+
 	return err;
 }
 EXPORT_SYMBOL(ldc_read);
-- 
1.7.1

