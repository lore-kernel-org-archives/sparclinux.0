From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Date: Fri, 01 May 2015 12:05:39 +0000
Subject: [PATCH] sparc: kernel: GRPCI2: Remove a useless memset
Message-Id: <1430481939-10268-1-git-send-email-christophe.jaillet@wanadoo.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe Jaillet <christophe.jaillet@wanadoo.fr>

grpci2priv is allocated using kzalloc, so there is no need to memset it.

Signed-off-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
---
 arch/sparc/kernel/leon_pci_grpci2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/kernel/leon_pci_grpci2.c b/arch/sparc/kernel/leon_pci_grpci2.c
index 94e392b..814fb17 100644
--- a/arch/sparc/kernel/leon_pci_grpci2.c
+++ b/arch/sparc/kernel/leon_pci_grpci2.c
@@ -723,7 +723,6 @@ static int grpci2_of_probe(struct platform_device *ofdev)
 		err = -ENOMEM;
 		goto err1;
 	}
-	memset(grpci2priv, 0, sizeof(*grpci2priv));
 	priv->regs = regs;
 	priv->irq = ofdev->archdata.irqs[0]; /* BASE IRQ */
 	priv->irq_mode = (capability & STS_IRQMODE) >> STS_IRQMODE_BIT;
-- 
2.1.0

