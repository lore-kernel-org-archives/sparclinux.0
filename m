From: Wei Yongjun <yjwei@cn.fujitsu.com>
Date: Tue, 14 Apr 2009 06:16:55 +0000
Subject: [PATCH] sparc: fix possible build error in arch/sparc/include/asm/parport.h
Message-Id: <49E42A57.50506@cn.fujitsu.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

commit 51dcdfec6a274afc1c6fce180d582add9ff512c0 (parport: Use the PCI
IRQ if offered) parport_pc_probe_port() gained an irqflags arg.  This
isn't being supplied on sparc.  This patch make sparc fallback to the
old behaviour, that is using 0 for irqflags.

No test.

Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>
---
 arch/sparc/include/asm/parport.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/parport.h b/arch/sparc/include/asm/parport.h
index dff3f02..ff9ead6 100644
--- a/arch/sparc/include/asm/parport.h
+++ b/arch/sparc/include/asm/parport.h
@@ -117,7 +117,7 @@ static int __devinit ecpp_probe(struct of_device *op, const struct of_device_id
 	if (!strcmp(parent->name, "dma")) {
 		p = parport_pc_probe_port(base, base + 0x400,
 					  op->irqs[0], PARPORT_DMA_NOFIFO,
-					  op->dev.parent->parent);
+					  op->dev.parent->parent, 0);
 		if (!p)
 			return -ENOMEM;
 		dev_set_drvdata(&op->dev, p);
@@ -168,7 +168,8 @@ static int __devinit ecpp_probe(struct of_device *op, const struct of_device_id
 	p = parport_pc_probe_port(base, base + 0x400,
 				  op->irqs[0],
 				  slot,
-				  op->dev.parent);
+				  op->dev.parent,
+				  0);
 	err = -ENOMEM;
 	if (!p)
 		goto out_disable_irq;
-- 
1.5.3.8




