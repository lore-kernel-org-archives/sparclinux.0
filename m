From: David Miller <davem@davemloft.net>
Date: Mon, 30 Oct 2006 00:19:58 +0000
Subject: Re: Another 2.6.18 regression? (SunBlade1000)
Message-Id: <20061029.161958.104039171.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061024031642.GA4403@droopy.oc.cox.net>
In-Reply-To: <20061024031642.GA4403@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Roland Stigge <stigge@antcom.de>
Date: Sat, 28 Oct 2006 23:23:41 +0200

> David Miller wrote:
> >> After removing the floppy driver, the result looks a bit different: The
> >> bootup proceeds a bit further, but the error message is similar.
> >>
> >> See http://people.debian.org/~stigge/sun4u-nofd.jpg
> > 
> > What does 0x4268e8 match up to in your System.map?
> 
> Looks like tomatillo_wsync_handler:

That explains the bug clearly.

Please try this patch, thanks a lot!

diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc64/kernel/prom.c
index c60efb3..0917c24 100644
--- a/arch/sparc64/kernel/prom.c
+++ b/arch/sparc64/kernel/prom.c
@@ -793,7 +793,7 @@ static unsigned int schizo_irq_build(str
 	return virt_irq;
 }
 
-static void schizo_irq_trans_init(struct device_node *dp)
+static void __schizo_irq_trans_init(struct device_node *dp, int is_tomatillo)
 {
 	struct linux_prom64_registers *regs;
 	struct schizo_irq_data *irq_data;
@@ -807,11 +807,24 @@ static void schizo_irq_trans_init(struct
 	dp->irq_trans->data = irq_data;
 
 	irq_data->pbm_regs = regs[0].phys_addr;
-	irq_data->sync_reg = regs[3].phys_addr + 0x1a18UL;
+	if (is_tomatillo)
+		irq_data->sync_reg = regs[3].phys_addr + 0x1a18UL;
+	else
+		irq_data->sync_reg = 0UL;
 	irq_data->portid = of_getintprop_default(dp, "portid", 0);
 	irq_data->chip_version = of_getintprop_default(dp, "version#", 0);
 }
 
+static void schizo_irq_trans_init(struct device_node *dp)
+{
+	__schizo_irq_trans_init(dp, 0);
+}
+
+static void tomatillo_irq_trans_init(struct device_node *dp)
+{
+	__schizo_irq_trans_init(dp, 1);
+}
+
 static unsigned int pci_sun4v_irq_build(struct device_node *dp,
 					unsigned int devino,
 					void *_data)
@@ -1050,8 +1063,8 @@ static struct irq_trans pci_irq_trans_ta
 	{ "pci108e,8001", schizo_irq_trans_init },
 	{ "SUNW,schizo+", schizo_irq_trans_init },
 	{ "pci108e,8002", schizo_irq_trans_init },
-	{ "SUNW,tomatillo", schizo_irq_trans_init },
-	{ "pci108e,a801", schizo_irq_trans_init },
+	{ "SUNW,tomatillo", tomatillo_irq_trans_init },
+	{ "pci108e,a801", tomatillo_irq_trans_init },
 	{ "SUNW,sun4v-pci", pci_sun4v_irq_trans_init },
 };
 #endif
