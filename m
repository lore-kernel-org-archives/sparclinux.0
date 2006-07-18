From: David Miller <davem@davemloft.net>
Date: Tue, 18 Jul 2006 04:32:15 +0000
Subject: Re: sparc32 git tree, preamble scan_one_device
Message-Id: <20060717.213215.13768169.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.10.10607152010260.10727-200000@coalcreekmill.cm.com>
In-Reply-To: <Pine.LNX.4.10.10607152010260.10727-200000@coalcreekmill.cm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Raymond Burns <rayburns@comcast.net>
Date: Sat, 15 Jul 2006 20:31:25 -0700 (PDT)

> The attached patch avoids access past null for the sun4d. This does
> not impact the kobject_add failed issue.
> 
> Minor restructure of the parent determination would simplify the code,
> the sun4d should never have an sbi at the root node.

This code is still buggy.  I think I corrected everything
necessary in the patch below, please try it out.

It was looking for the board# property in the "sbi" node,
and it assumed the "sbi" is the parent of the device node
which is not true, for example, when dealing with an
"le" device which sits underneath "lebuffer".

We should therefore traverse up to the root looking for the
"sbi" explicitly, then fetch the board# out of it's parent
which should be an "io-unit" node.

diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
index 5a2faad..97bf87e 100644
--- a/arch/sparc/kernel/of_device.c
+++ b/arch/sparc/kernel/of_device.c
@@ -596,14 +596,41 @@ static struct of_device * __init scan_on
 		static int pil_to_sbus[] = {
 			0, 0, 1, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0, 0,
 		};
-		struct device_node *busp = dp->parent;
+		struct device_node *io_unit, *sbi = dp->parent;
 		struct linux_prom_registers *regs;
-		int board = of_getintprop_default(busp, "board#", 0);
-		int slot;
+		int board, slot;
+
+		while (sbi) {
+			if (!strcmp(sbi->name, "sbi"))
+				break;
+
+			sbi = sbi->parent;
+		}
+		if (!sbi)
+			goto build_resources;
 
 		regs = of_get_property(dp, "reg", NULL);
+		if (!regs)
+			goto build_resources;
+
 		slot = regs->which_io;
 
+		/* If SBI's parent is not io-unit or the io-unit lacks
+		 * a "board#" property, something is very wrong.
+		 */
+		if (!sbi->parent || strcmp(sbi->parent->name, "io-unit")) {
+			printk("%s: Error, parent is not io-unit.\n",
+			       sbi->full_name);
+			goto build_resources;
+		}
+		io_unit = sbi->parent;
+		board = of_getintprop_default(io_unit, "board#", -1);
+		if (board = -1) {
+			printk("%s: Error, lacks board# property.\n",
+			       io_unit->full_name);
+			goto build_resources;
+		}
+
 		for (i = 0; i < op->num_irqs; i++) {
 			int this_irq = op->irqs[i];
 			int sbusl = pil_to_sbus[this_irq];
@@ -617,6 +644,7 @@ static struct of_device * __init scan_on
 		}
 	}
 
+build_resources:
 	build_device_resources(op, parent);
 
 	op->dev.parent = parent;
