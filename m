From: David Miller <davem@davemloft.net>
Date: Mon, 17 Jul 2006 05:12:22 +0000
Subject: Re: 2.6.18-rc1 fails to boot on E250
Message-Id: <20060716.221222.88477280.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060714.165308.83620688.davem@davemloft.net>
In-Reply-To: <20060714.165308.83620688.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Marc Zyngier <maz@misterjones.org>
Date: Sun, 16 Jul 2006 17:44:37 +0200

> As usual, I'll be happy to test any idea you may have to solve this
> problem.

This should do it.  I sanity booted this on my ultra60 just to
make sure. :-)

diff-tree 06390fa60b00941eac0fac107e63942ec9277f2c (from 82d6897fefca6206bca7153805b4c5359ce97fc4)
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Sun Jul 16 22:10:44 2006 -0700

    [SPARC64]: Fix more of_device layer IRQ bugs, and correct PROMREG_MAX.
    
    Sabre and Psycho PCI controllers can have partial interrupt-map
    properties, meaning that on-board devices don't match up to any
    entries.  Instead, they are fully specified from the beginning and
    we should pass them directly to the IRQ translator as-is.
    
    Also, fill in the necessary translator slots for the "graphics"
    and "expansion UPA" interrupts on Sabre, Psycho, and SYSIO SBUS.
    
    Increase PROMREG_MAX to 24, as seen on SUNW,ffb devices.
    
    Finally, prevent accidentally writing past the end of the of_device
    struct resource[] and irqs[] arrays.  Spit out a log message when
    we ignore some entries because there are too many of them.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index 7064cee..238bbf6 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -542,9 +542,17 @@ static void __init build_device_resource
 	/* Convert to num-cells.  */
 	num_reg /= 4;
 
-	/* Conver to num-entries.  */
+	/* Convert to num-entries.  */
 	num_reg /= na + ns;
 
+	/* Prevent overruning the op->resources[] array.  */
+	if (num_reg > PROMREG_MAX) {
+		printk(KERN_WARNING "%s: Too many regs (%d), "
+		       "limiting to %d.\n",
+		       op->node->full_name, num_reg, PROMREG_MAX);
+		num_reg = PROMREG_MAX;
+	}
+
 	for (index = 0; index < num_reg; index++) {
 		struct resource *r = &op->resource[index];
 		u32 addr[OF_MAX_ADDR_CELLS];
@@ -650,8 +658,22 @@ apply_interrupt_map(struct device_node *
 	next:
 		imap += (na + 3);
 	}
-	if (i = imlen)
+	if (i = imlen) {
+		/* Psycho and Sabre PCI controllers can have 'interrupt-map'
+		 * properties that do not include the on-board device
+		 * interrupts.  Instead, the device's 'interrupts' property
+		 * is already a fully specified INO value.
+		 *
+		 * Handle this by deciding that, if we didn't get a
+		 * match in the parent's 'interrupt-map', and the
+		 * parent is an IRQ translater, then use the parent as
+		 * our IRQ controller.
+		 */
+		if (pp->irq_trans)
+			return pp;
+
 		return NULL;
+	}
 
 	*irq_p = irq;
 	cp = of_find_node_by_phandle(handle);
@@ -803,6 +825,14 @@ static struct of_device * __init scan_on
 		op->num_irqs = 0;
 	}
 
+	/* Prevent overruning the op->irqs[] array.  */
+	if (op->num_irqs > PROMINTR_MAX) {
+		printk(KERN_WARNING "%s: Too many irqs (%d), "
+		       "limiting to %d.\n",
+		       dp->full_name, op->num_irqs, PROMINTR_MAX);
+		op->num_irqs = PROMINTR_MAX;
+	}
+
 	build_device_resources(op, parent);
 	for (i = 0; i < op->num_irqs; i++)
 		op->irqs[i] = build_one_device_irq(op, parent, op->irqs[i]);
diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc64/kernel/prom.c
index c86007a..5cc5ab6 100644
--- a/arch/sparc64/kernel/prom.c
+++ b/arch/sparc64/kernel/prom.c
@@ -344,10 +344,12 @@ static unsigned long __psycho_onboard_im
 /*0x2f*/	PSYCHO_IMAP_CE,
 /*0x30*/	PSYCHO_IMAP_A_ERR,
 /*0x31*/	PSYCHO_IMAP_B_ERR,
-/*0x32*/	PSYCHO_IMAP_PMGMT
+/*0x32*/	PSYCHO_IMAP_PMGMT,
+/*0x33*/	PSYCHO_IMAP_GFX,
+/*0x34*/	PSYCHO_IMAP_EUPA,
 };
 #define PSYCHO_ONBOARD_IRQ_BASE		0x20
-#define PSYCHO_ONBOARD_IRQ_LAST		0x32
+#define PSYCHO_ONBOARD_IRQ_LAST		0x34
 #define psycho_onboard_imap_offset(__ino) \
 	__psycho_onboard_imap_off[(__ino) - PSYCHO_ONBOARD_IRQ_BASE]
 
@@ -529,6 +531,10 @@ static unsigned long __sabre_onboard_ima
 /*0x2e*/	SABRE_IMAP_UE,
 /*0x2f*/	SABRE_IMAP_CE,
 /*0x30*/	SABRE_IMAP_PCIERR,
+/*0x31*/	0 /* reserved */,
+/*0x32*/	0 /* reserved */,
+/*0x33*/	SABRE_IMAP_GFX,
+/*0x34*/	SABRE_IMAP_EUPA,
 };
 #define SABRE_ONBOARD_IRQ_BASE		0x20
 #define SABRE_ONBOARD_IRQ_LAST		0x30
@@ -895,6 +901,8 @@ static unsigned long sysio_irq_offsets[]
 	SYSIO_IMAP_CE,
 	SYSIO_IMAP_SBERR,
 	SYSIO_IMAP_PMGMT,
+	SYSIO_IMAP_GFX,
+	SYSIO_IMAP_EUPA,
 };
 
 #undef bogon
diff --git a/include/asm-sparc64/openprom.h b/include/asm-sparc64/openprom.h
index b4959d2..e01b805 100644
--- a/include/asm-sparc64/openprom.h
+++ b/include/asm-sparc64/openprom.h
@@ -175,7 +175,7 @@ struct linux_nodeops {
 };
 
 /* More fun PROM structures for device probing. */
-#define PROMREG_MAX     16
+#define PROMREG_MAX     24
 #define PROMVADDR_MAX   16
 #define PROMINTR_MAX    15
 
