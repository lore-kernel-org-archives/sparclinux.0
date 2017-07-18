From: Rob Herring <robh@kernel.org>
Date: Tue, 18 Jul 2017 21:43:27 +0000
Subject: [PATCH] sbus: Convert to using %pOF instead of full_name
Message-Id: <20170718214339.7774-47-robh@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, sparclinux@vger.kernel.org

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 drivers/sbus/char/display7seg.c | 4 ++--
 drivers/sbus/char/flash.c       | 4 ++--
 drivers/sbus/char/uctrl.c       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index 04efed171c88..f32765d3cbd8 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -212,8 +212,8 @@ static int d7s_probe(struct platform_device *op)

 	writeb(regs,  p->regs);

-	printk(KERN_INFO PFX "7-Segment Display%s at [%s:0x%llx] %s\n",
-	       op->dev.of_node->full_name,
+	printk(KERN_INFO PFX "7-Segment Display%pOF at [%s:0x%llx] %s\n",
+	       op->dev.of_node,
 	       (regs & D7S_FLIP) ? " (FLIPPED)" : "",
 	       op->resource[0].start,
 	       sol_compat ? "in sol_compat mode" : "");
diff --git a/drivers/sbus/char/flash.c b/drivers/sbus/char/flash.c
index 216f923161d1..a610b8d3d11f 100644
--- a/drivers/sbus/char/flash.c
+++ b/drivers/sbus/char/flash.c
@@ -181,8 +181,8 @@ static int flash_probe(struct platform_device *op)
 	}
 	flash.busy = 0;

-	printk(KERN_INFO "%s: OBP Flash, RD %lx[%lx] WR %lx[%lx]\n",
-	       op->dev.of_node->full_name,
+	printk(KERN_INFO "%pOF: OBP Flash, RD %lx[%lx] WR %lx[%lx]\n",
+	       op->dev.of_node,
 	       flash.read_base, flash.read_size,
 	       flash.write_base, flash.write_size);

diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index 57696fc0b482..0a5013350acd 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -379,8 +379,8 @@ static int uctrl_probe(struct platform_device *op)
 	}

 	sbus_writel(UCTRL_INTR_RXNE_REQ|UCTRL_INTR_RXNE_MSK, &p->regs->uctrl_intr);
-	printk(KERN_INFO "%s: uctrl regs[0x%p] (irq %d)\n",
-	       op->dev.of_node->full_name, p->regs, p->irq);
+	printk(KERN_INFO "%pOF: uctrl regs[0x%p] (irq %d)\n",
+	       op->dev.of_node, p->regs, p->irq);
 	uctrl_get_event_status(p);
 	uctrl_get_external_status(p);

--
2.11.0

