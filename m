From: Rob Herring <robh@kernel.org>
Date: Wed, 07 Nov 2018 22:31:48 +0000
Subject: [PATCH 5/8] sparc: Convert to using %pOFn instead of device_node.name
Message-Id: <20181107223151.14991-6-robh@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20181107223151.14991-1-robh@kernel.org>
In-Reply-To: <20181107223151.14991-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

This was originally applied for 4.19, but reverted. The problematic
changes to prom_{32,64}.c have been dropped.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/sparc/kernel/auxio_64.c | 4 ++--
 arch/sparc/kernel/power.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/auxio_64.c b/arch/sparc/kernel/auxio_64.c
index 6145658d915a..e1b10f88ffb4 100644
--- a/arch/sparc/kernel/auxio_64.c
+++ b/arch/sparc/kernel/auxio_64.c
@@ -115,8 +115,8 @@ static int auxio_probe(struct platform_device *dev)
 		auxio_devtype = AUXIO_TYPE_SBUS;
 		size = 1;
 	} else {
-		printk("auxio: Unknown parent bus type [%s]\n",
-		       dp->parent->name);
+		printk("auxio: Unknown parent bus type [%pOFn]\n",
+		       dp->parent);
 		return -ENODEV;
 	}
 	auxio_register = of_ioremap(&dev->resource[0], 0, size, "auxio");
diff --git a/arch/sparc/kernel/power.c b/arch/sparc/kernel/power.c
index 92627abce311..d941875dd718 100644
--- a/arch/sparc/kernel/power.c
+++ b/arch/sparc/kernel/power.c
@@ -41,8 +41,8 @@ static int power_probe(struct platform_device *op)
 
 	power_reg = of_ioremap(res, 0, 0x4, "power");
 
-	printk(KERN_INFO "%s: Control reg at %llx\n",
-	       op->dev.of_node->name, res->start);
+	printk(KERN_INFO "%pOFn: Control reg at %llx\n",
+	       op->dev.of_node, res->start);
 
 	if (has_button_interrupt(irq, op->dev.of_node)) {
 		if (request_irq(irq,
-- 
2.19.1
