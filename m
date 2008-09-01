From: David Miller <davem@davemloft.net>
Date: Mon, 01 Sep 2008 04:16:58 +0000
Subject: [PATCH 2/2]: sparc64: Rewrite central driver.
Message-Id: <20080831.211658.97678271.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Rewrite central driver.

This driver is now limited to just doing the basic clock board and FHC
chip initialization and registering the platform devices for the
per-board LEDs, which are driven by the new LEDS_STARFIRE driver.

The IRQ register handling is already confined purely to the device
tree code.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/fhc.h  |   43 +---
 arch/sparc64/kernel/central.c |  616 ++++++++++++++---------------------------
 arch/sparc64/kernel/sbus.c    |    3 -
 arch/sparc64/mm/init.c        |    3 -
 4 files changed, 214 insertions(+), 451 deletions(-)

diff --git a/arch/sparc/include/asm/fhc.h b/arch/sparc/include/asm/fhc.h
index 788cbc4..57f1b30 100644
--- a/arch/sparc/include/asm/fhc.h
+++ b/arch/sparc/include/asm/fhc.h
@@ -1,5 +1,4 @@
-/*
- * fhc.h: Structures for central/fhc pseudo driver on Sunfire/Starfire/Wildfire.
+/* fhc.h: FHC and Clock board register definitions.
  *
  * Copyright (C) 1997, 1999 David S. Miller (davem@redhat.com)
  */
@@ -7,14 +6,6 @@
 #ifndef _SPARC64_FHC_H
 #define _SPARC64_FHC_H
 
-#include <linux/timer.h>
-
-#include <asm/oplib.h>
-#include <asm/prom.h>
-#include <asm/upa.h>
-
-struct linux_fhc;
-
 /* Clock board register offsets. */
 #define CLOCK_CTRL	0x00UL	/* Main control */
 #define CLOCK_STAT1	0x10UL	/* Status one */
@@ -29,21 +20,7 @@ struct linux_fhc;
 #define CLOCK_CTRL_MLED		0x02	/* Mid LED, 1 = on */
 #define CLOCK_CTRL_RLED		0x01	/* RIght LED, 1 = on */
 
-struct linux_central {
-	struct linux_fhc		*child;
-	unsigned long			cfreg;
-	unsigned long			clkregs;
-	unsigned long			clkver;
-	int				slots;
-	struct device_node		*prom_node;
-
-	struct linux_prom_ranges	central_ranges[PROMREG_MAX];
-	int				num_central_ranges;
-};
-
 /* Firehose controller register offsets */
-struct fhc_regs {
-	unsigned long			pregs;	/* FHC internal regs */
 #define FHC_PREGS_ID	0x00UL	/* FHC ID */
 #define  FHC_ID_VERS		0xf0000000 /* Version of this FHC		*/
 #define  FHC_ID_PARTID		0x0ffff000 /* Part ID code (0x0f9f = FHC)	*/
@@ -90,32 +67,14 @@ struct fhc_regs {
 #define  FHC_JTAG_CTRL_MENAB	0x80000000 /* Indicates this is JTAG Master	 */
 #define  FHC_JTAG_CTRL_MNONE	0x40000000 /* Indicates no JTAG Master present	 */
 #define FHC_PREGS_JCMD	0x100UL	/* FHC JTAG Command Register */
-	unsigned long			ireg;	/* FHC IGN reg */
 #define FHC_IREG_IGN	0x00UL	/* This FHC's IGN */
-	unsigned long			ffregs;	/* FHC fanfail regs */
 #define FHC_FFREGS_IMAP	0x00UL	/* FHC Fanfail IMAP */
 #define FHC_FFREGS_ICLR	0x10UL	/* FHC Fanfail ICLR */
-	unsigned long			sregs;	/* FHC system regs */
 #define FHC_SREGS_IMAP	0x00UL	/* FHC System IMAP */
 #define FHC_SREGS_ICLR	0x10UL	/* FHC System ICLR */
-	unsigned long			uregs;	/* FHC uart regs */
 #define FHC_UREGS_IMAP	0x00UL	/* FHC Uart IMAP */
 #define FHC_UREGS_ICLR	0x10UL	/* FHC Uart ICLR */
-	unsigned long			tregs;	/* FHC TOD regs */
 #define FHC_TREGS_IMAP	0x00UL	/* FHC TOD IMAP */
 #define FHC_TREGS_ICLR	0x10UL	/* FHC TOD ICLR */
-};
-
-struct linux_fhc {
-	struct linux_fhc		*next;
-	struct linux_central		*parent;	/* NULL if not central FHC */
-	struct fhc_regs			fhc_regs;
-	int				board;
-	int				jtag_master;
-	struct device_node		*prom_node;
-
-	struct linux_prom_ranges	fhc_ranges[PROMREG_MAX];
-	int				num_fhc_ranges;
-};
 
 #endif /* !(_SPARC64_FHC_H) */
diff --git a/arch/sparc64/kernel/central.c b/arch/sparc64/kernel/central.c
index 68c91b2..05f1c91 100644
--- a/arch/sparc64/kernel/central.c
+++ b/arch/sparc64/kernel/central.c
@@ -1,458 +1,268 @@
 /* central.c: Central FHC driver for Sunfire/Starfire/Wildfire.
  *
- * Copyright (C) 1997, 1999 David S. Miller (davem@davemloft.net)
+ * Copyright (C) 1997, 1999, 2008 David S. Miller (davem@davemloft.net)
  */
 
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/string.h>
-#include <linux/timer.h>
-#include <linux/sched.h>
-#include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
 
-#include <asm/page.h>
 #include <asm/fhc.h>
-#include <asm/starfire.h>
-
-static struct linux_central *central_bus = NULL;
-static struct linux_fhc *fhc_list = NULL;
+#include <asm/upa.h>
+
+struct clock_board {
+	void __iomem		*clock_freq_regs;
+	void __iomem		*clock_regs;
+	void __iomem		*clock_ver_reg;
+	int			num_slots;
+	struct resource		leds_resource;
+	struct platform_device	leds_pdev;
+};
+
+struct fhc {
+	void __iomem		*pregs;
+	bool			central;
+	bool			jtag_master;
+	int			board_num;
+	struct resource		leds_resource;
+	struct platform_device	leds_pdev;
+};
+
+static int __devinit clock_board_calc_nslots(struct clock_board *p)
+{
+	u8 reg = upa_readb(p->clock_regs + CLOCK_STAT1) & 0xc0;
 
-#define IS_CENTRAL_FHC(__fhc)	((__fhc) = central_bus->child)
+	switch (reg) {
+	case 0x40:
+		return 16;
 
-static void central_probe_failure(int line)
-{
-	prom_printf("CENTRAL: Critical device probe failure at central.c:%d\n",
-		    line);
-	prom_halt();
-}
+	case 0xc0:
+		return 8;
 
-static void central_ranges_init(struct linux_central *central)
-{
-	struct device_node *dp = central->prom_node;
-	const void *pval;
-	int len;
-	
-	central->num_central_ranges = 0;
-	pval = of_get_property(dp, "ranges", &len);
-	if (pval) {
-		memcpy(central->central_ranges, pval, len);
-		central->num_central_ranges -			(len / sizeof(struct linux_prom_ranges));
+	case 0x80:
+		reg = 0;
+		if (p->clock_ver_reg)
+			reg = upa_readb(p->clock_ver_reg);
+		if (reg) {
+			if (reg & 0x80)
+				return 4;
+			else
+				return 5;
+		}
+		/* Fallthrough */
+	default:
+		return 4;
 	}
 }
 
-static void fhc_ranges_init(struct linux_fhc *fhc)
+static int __devinit clock_board_probe(struct of_device *op,
+				       const struct of_device_id *match)
 {
-	struct device_node *dp = fhc->prom_node;
-	const void *pval;
-	int len;
-	
-	fhc->num_fhc_ranges = 0;
-	pval = of_get_property(dp, "ranges", &len);
-	if (pval) {
-		memcpy(fhc->fhc_ranges, pval, len);
-		fhc->num_fhc_ranges -			(len / sizeof(struct linux_prom_ranges));
-	}
-}
+	struct clock_board *p = kzalloc(sizeof(*p), GFP_KERNEL);
+	int err = -ENOMEM;
 
-/* Range application routines are exported to various drivers,
- * so do not __init this.
- */
-static void adjust_regs(struct linux_prom_registers *regp, int nregs,
-			struct linux_prom_ranges *rangep, int nranges)
-{
-	int regc, rngc;
-
-	for (regc = 0; regc < nregs; regc++) {
-		for (rngc = 0; rngc < nranges; rngc++)
-			if (regp[regc].which_io = rangep[rngc].ot_child_space)
-				break; /* Fount it */
-		if (rngc = nranges) /* oops */
-			central_probe_failure(__LINE__);
-		regp[regc].which_io = rangep[rngc].ot_parent_space;
-		regp[regc].phys_addr -= rangep[rngc].ot_child_base;
-		regp[regc].phys_addr += rangep[rngc].ot_parent_base;
+	if (!p) {
+		printk(KERN_ERR "clock_board: Cannot allocate struct clock_board\n");
+		goto out;
 	}
-}
 
-/* Apply probed fhc ranges to registers passed, if no ranges return. */
-static void apply_fhc_ranges(struct linux_fhc *fhc,
-			     struct linux_prom_registers *regs,
-			     int nregs)
-{
-	if (fhc->num_fhc_ranges)
-		adjust_regs(regs, nregs, fhc->fhc_ranges,
-			    fhc->num_fhc_ranges);
-}
+	p->clock_freq_regs = of_ioremap(&op->resource[0], 0,
+					resource_size(&op->resource[0]),
+					"clock_board_freq");
+	if (!p->clock_freq_regs) {
+		printk(KERN_ERR "clock_board: Cannot map clock_freq_regs\n");
+		goto out_free;
+	}
 
-/* Apply probed central ranges to registers passed, if no ranges return. */
-static void apply_central_ranges(struct linux_central *central,
-				 struct linux_prom_registers *regs, int nregs)
-{
-	if (central->num_central_ranges)
-		adjust_regs(regs, nregs, central->central_ranges,
-			    central->num_central_ranges);
-}
+	p->clock_regs = of_ioremap(&op->resource[1], 0,
+				   resource_size(&op->resource[1]),
+				   "clock_board_regs");
+	if (!p->clock_regs) {
+		printk(KERN_ERR "clock_board: Cannot map clock_regs\n");
+		goto out_unmap_clock_freq_regs;
+	}
 
-static void * __init central_alloc_bootmem(unsigned long size)
-{
-	void *ret;
+	if (op->resource[2].flags) {
+		p->clock_ver_reg = of_ioremap(&op->resource[2], 0,
+					      resource_size(&op->resource[2]),
+					      "clock_ver_reg");
+		if (!p->clock_ver_reg) {
+			printk(KERN_ERR "clock_board: Cannot map clock_ver_reg\n");
+			goto out_unmap_clock_regs;
+		}
+	}
 
-	ret = __alloc_bootmem(size, SMP_CACHE_BYTES, 0UL);
-	if (ret != NULL)
-		memset(ret, 0, size);
+	p->num_slots = clock_board_calc_nslots(p);
 
-	return ret;
-}
+	p->leds_resource.start = (unsigned long)
+		(p->clock_regs + CLOCK_CTRL);
+	p->leds_resource.end = p->leds_resource.end;
+	p->leds_resource.name = "leds";
 
-static unsigned long prom_reg_to_paddr(struct linux_prom_registers *r)
-{
-	unsigned long ret = ((unsigned long) r->which_io) << 32;
+	p->leds_pdev.name = "sunfire-clockboard-leds";
+	p->leds_pdev.resource = &p->leds_resource;
+	p->leds_pdev.num_resources = 1;
+	p->leds_pdev.dev.parent = &op->dev;
 
-	return ret | (unsigned long) r->phys_addr;
-}
-
-static void __init probe_other_fhcs(void)
-{
-	struct device_node *dp;
-	const struct linux_prom64_registers *fpregs;
-
-	for_each_node_by_name(dp, "fhc") {
-		struct linux_fhc *fhc;
-		int board;
-		u32 tmp;
-
-		if (dp->parent &&
-		    dp->parent->parent != NULL)
-			continue;
-
-		fhc = (struct linux_fhc *)
-			central_alloc_bootmem(sizeof(struct linux_fhc));
-		if (fhc = NULL)
-			central_probe_failure(__LINE__);
-
-		/* Link it into the FHC chain. */
-		fhc->next = fhc_list;
-		fhc_list = fhc;
-
-		/* Toplevel FHCs have no parent. */
-		fhc->parent = NULL;
-		
-		fhc->prom_node = dp;
-		fhc_ranges_init(fhc);
-
-		/* Non-central FHC's have 64-bit OBP format registers. */
-		fpregs = of_get_property(dp, "reg", NULL);
-		if (!fpregs)
-			central_probe_failure(__LINE__);
-
-		/* Only central FHC needs special ranges applied. */
-		fhc->fhc_regs.pregs = fpregs[0].phys_addr;
-		fhc->fhc_regs.ireg = fpregs[1].phys_addr;
-		fhc->fhc_regs.ffregs = fpregs[2].phys_addr;
-		fhc->fhc_regs.sregs = fpregs[3].phys_addr;
-		fhc->fhc_regs.uregs = fpregs[4].phys_addr;
-		fhc->fhc_regs.tregs = fpregs[5].phys_addr;
-
-		board = of_getintprop_default(dp, "board#", -1);
-		fhc->board = board;
-
-		tmp = upa_readl(fhc->fhc_regs.pregs + FHC_PREGS_JCTRL);
-		if ((tmp & FHC_JTAG_CTRL_MENAB) != 0)
-			fhc->jtag_master = 1;
-		else
-			fhc->jtag_master = 0;
-
-		tmp = upa_readl(fhc->fhc_regs.pregs + FHC_PREGS_ID);
-		printk("FHC(board %d): Version[%x] PartID[%x] Manuf[%x] %s\n",
-		       board,
-		       (tmp & FHC_ID_VERS) >> 28,
-		       (tmp & FHC_ID_PARTID) >> 12,
-		       (tmp & FHC_ID_MANUF) >> 1,
-		       (fhc->jtag_master ? "(JTAG Master)" : ""));
-		
-		/* This bit must be set in all non-central FHC's in
-		 * the system.  When it is clear, this identifies
-		 * the central board.
-		 */
-		tmp = upa_readl(fhc->fhc_regs.pregs + FHC_PREGS_CTRL);
-		tmp |= FHC_CONTROL_IXIST;
-		upa_writel(tmp, fhc->fhc_regs.pregs + FHC_PREGS_CTRL);
+	err = platform_device_register(&p->leds_pdev);
+	if (err) {
+		printk(KERN_ERR "clock_board: Could not register LEDS "
+		       "platform device\n");
+		goto out_unmap_clock_ver_reg;
 	}
-}
 
-static void probe_clock_board(struct linux_central *central,
-			      struct linux_fhc *fhc,
-			      struct device_node *fp)
-{
-	struct device_node *dp;
-	struct linux_prom_registers cregs[3];
-	const struct linux_prom_registers *pr;
-	int nslots, tmp, nregs;
-
-	dp = fp->child;
-	while (dp) {
-		if (!strcmp(dp->name, "clock-board"))
-			break;
-		dp = dp->sibling;
-	}
-	if (!dp)
-		central_probe_failure(__LINE__);
+	printk(KERN_INFO "clock_board: Detected %d slot Enterprise system.\n",
+	       p->num_slots);
 
-	pr = of_get_property(dp, "reg", &nregs);
-	if (!pr)
-		central_probe_failure(__LINE__);
+	err = 0;
+out:
+	return err;
 
-	memcpy(cregs, pr, nregs);
-	nregs /= sizeof(struct linux_prom_registers);
+out_unmap_clock_ver_reg:
+	if (p->clock_ver_reg)
+		of_iounmap(&op->resource[2], p->clock_ver_reg,
+			   resource_size(&op->resource[2]));
 
-	apply_fhc_ranges(fhc, &cregs[0], nregs);
-	apply_central_ranges(central, &cregs[0], nregs);
-	central->cfreg = prom_reg_to_paddr(&cregs[0]);
-	central->clkregs = prom_reg_to_paddr(&cregs[1]);
+out_unmap_clock_regs:
+	of_iounmap(&op->resource[1], p->clock_regs,
+		   resource_size(&op->resource[1]));
 
-	if (nregs = 2)
-		central->clkver = 0UL;
-	else
-		central->clkver = prom_reg_to_paddr(&cregs[2]);
+out_unmap_clock_freq_regs:
+	of_iounmap(&op->resource[0], p->clock_freq_regs,
+		   resource_size(&op->resource[0]));
 
-	tmp = upa_readb(central->clkregs + CLOCK_STAT1);
-	tmp &= 0xc0;
-	switch(tmp) {
-	case 0x40:
-		nslots = 16;
-		break;
-	case 0xc0:
-		nslots = 8;
-		break;
-	case 0x80:
-		if (central->clkver != 0UL &&
-		   upa_readb(central->clkver) != 0) {
-			if ((upa_readb(central->clkver) & 0x80) != 0)
-				nslots = 4;
-			else
-				nslots = 5;
-			break;
-		}
-	default:
-		nslots = 4;
-		break;
-	};
-	central->slots = nslots;
-	printk("CENTRAL: Detected %d slot Enterprise system. cfreg[%02x] cver[%02x]\n",
-	       central->slots, upa_readb(central->cfreg),
-	       (central->clkver ? upa_readb(central->clkver) : 0x00));
+out_free:
+	kfree(p);
+	goto out;
 }
 
-static void ZAP(unsigned long iclr, unsigned long imap)
+static struct of_device_id __initdata clock_board_match[] = {
+	{
+		.name = "clock-board",
+	},
+	{},
+};
+
+static struct of_platform_driver clock_board_driver = {
+	.match_table	= clock_board_match,
+	.probe		= clock_board_probe,
+	.driver		= {
+		.name	= "clock_board",
+	},
+};
+
+static int __devinit fhc_probe(struct of_device *op,
+			       const struct of_device_id *match)
 {
-	u32 imap_tmp;
-
-	upa_writel(0, iclr);
-	upa_readl(iclr);
-	imap_tmp = upa_readl(imap);
-	imap_tmp &= ~(0x80000000);
-	upa_writel(imap_tmp, imap);
-	upa_readl(imap);
-}
+	struct fhc *p = kzalloc(sizeof(*p), GFP_KERNEL);
+	int err = -ENOMEM;
+	u32 reg;
 
-static void init_all_fhc_hw(void)
-{
-	struct linux_fhc *fhc;
-
-	for (fhc = fhc_list; fhc != NULL; fhc = fhc->next) {
-		u32 tmp;
-
-		/* Clear all of the interrupt mapping registers
-		 * just in case OBP left them in a foul state.
-		 */
-		ZAP(fhc->fhc_regs.ffregs + FHC_FFREGS_ICLR,
-		    fhc->fhc_regs.ffregs + FHC_FFREGS_IMAP);
-		ZAP(fhc->fhc_regs.sregs + FHC_SREGS_ICLR,
-		    fhc->fhc_regs.sregs + FHC_SREGS_IMAP);
-		ZAP(fhc->fhc_regs.uregs + FHC_UREGS_ICLR,
-		    fhc->fhc_regs.uregs + FHC_UREGS_IMAP);
-		ZAP(fhc->fhc_regs.tregs + FHC_TREGS_ICLR,
-		    fhc->fhc_regs.tregs + FHC_TREGS_IMAP);
-
-		/* Setup FHC control register. */
-		tmp = upa_readl(fhc->fhc_regs.pregs + FHC_PREGS_CTRL);
-
-		/* All non-central boards have this bit set. */
-		if (! IS_CENTRAL_FHC(fhc))
-			tmp |= FHC_CONTROL_IXIST;
-
-		/* For all FHCs, clear the firmware synchronization
-		 * line and both low power mode enables.
-		 */
-		tmp &= ~(FHC_CONTROL_AOFF | FHC_CONTROL_BOFF |
-			 FHC_CONTROL_SLINE);
-
-		upa_writel(tmp, fhc->fhc_regs.pregs + FHC_PREGS_CTRL);
-		upa_readl(fhc->fhc_regs.pregs + FHC_PREGS_CTRL);
+	if (!p) {
+		printk(KERN_ERR "fhc: Cannot allocate struct fhc\n");
+		goto out;
 	}
 
-}
+	if (!strcmp(op->node->parent->name, "central"))
+		p->central = true;
 
-void __init central_probe(void)
-{
-	struct linux_prom_registers fpregs[6];
-	const struct linux_prom_registers *pr;
-	struct linux_fhc *fhc;
-	struct device_node *dp, *fp;
-	int err;
-
-	dp = of_find_node_by_name(NULL, "central");
-	if (!dp)
-		return;
-
-	/* Ok we got one, grab some memory for software state. */
-	central_bus = (struct linux_central *)
-		central_alloc_bootmem(sizeof(struct linux_central));
-	if (central_bus = NULL)
-		central_probe_failure(__LINE__);
-
-	fhc = (struct linux_fhc *)
-		central_alloc_bootmem(sizeof(struct linux_fhc));
-	if (fhc = NULL)
-		central_probe_failure(__LINE__);
-
-	/* First init central. */
-	central_bus->child = fhc;
-	central_bus->prom_node = dp;
-	central_ranges_init(central_bus);
-
-	/* And then central's FHC. */
-	fhc->next = fhc_list;
-	fhc_list = fhc;
-
-	fhc->parent = central_bus;
-	fp = dp->child;
-	while (fp) {
-		if (!strcmp(fp->name, "fhc"))
-			break;
-		fp = fp->sibling;
+	p->pregs = of_ioremap(&op->resource[0], 0,
+			      resource_size(&op->resource[0]),
+			      "fhc_pregs");
+	if (!p->pregs) {
+		printk(KERN_ERR "fhc: Cannot map pregs\n");
+		goto out_free;
 	}
-	if (!fp)
-		central_probe_failure(__LINE__);
-
-	fhc->prom_node = fp;
-	fhc_ranges_init(fhc);
-
-	/* Now, map in FHC register set. */
-	pr = of_get_property(fp, "reg", NULL);
-	if (!pr)
-		central_probe_failure(__LINE__);
-	memcpy(fpregs, pr, sizeof(fpregs));
-
-	apply_central_ranges(central_bus, &fpregs[0], 6);
-	
-	fhc->fhc_regs.pregs = prom_reg_to_paddr(&fpregs[0]);
-	fhc->fhc_regs.ireg = prom_reg_to_paddr(&fpregs[1]);
-	fhc->fhc_regs.ffregs = prom_reg_to_paddr(&fpregs[2]);
-	fhc->fhc_regs.sregs = prom_reg_to_paddr(&fpregs[3]);
-	fhc->fhc_regs.uregs = prom_reg_to_paddr(&fpregs[4]);
-	fhc->fhc_regs.tregs = prom_reg_to_paddr(&fpregs[5]);
-
-	/* Obtain board number from board status register, Central's
-	 * FHC lacks "board#" property.
-	 */
-	err = upa_readl(fhc->fhc_regs.pregs + FHC_PREGS_BSR);
-	fhc->board = (((err >> 16) & 0x01) |
-		      ((err >> 12) & 0x0e));
-
-	fhc->jtag_master = 0;
-
-	/* Attach the clock board registers for CENTRAL. */
-	probe_clock_board(central_bus, fhc, fp);
-
-	err = upa_readl(fhc->fhc_regs.pregs + FHC_PREGS_ID);
-	printk("FHC(board %d): Version[%x] PartID[%x] Manuf[%x] (CENTRAL)\n",
-	       fhc->board,
-	       ((err & FHC_ID_VERS) >> 28),
-	       ((err & FHC_ID_PARTID) >> 12),
-	       ((err & FHC_ID_MANUF) >> 1));
-
-	probe_other_fhcs();
-
-	init_all_fhc_hw();
-}
 
-static inline void fhc_ledblink(struct linux_fhc *fhc, int on)
-{
-	u32 tmp;
+	if (p->central) {
+		reg = upa_readl(p->pregs + FHC_PREGS_BSR);
+		p->board_num = ((reg >> 16) & 1) | ((reg >> 12) & 0x0e);
+	} else {
+		p->board_num = of_getintprop_default(op->node, "board#", -1);
+		if (p->board_num = -1) {
+			printk(KERN_ERR "fhc: No board# property\n");
+			goto out_unmap_pregs;
+		}
+		if (upa_readl(p->pregs + FHC_PREGS_JCTRL) & FHC_JTAG_CTRL_MENAB)
+			p->jtag_master = true;
+	}
 
-	tmp = upa_readl(fhc->fhc_regs.pregs + FHC_PREGS_CTRL);
+	if (!p->central) {
+		p->leds_resource.start = (unsigned long)
+			(p->pregs + FHC_PREGS_CTRL);
+		p->leds_resource.end = p->leds_resource.end;
+		p->leds_resource.name = "leds";
+
+		p->leds_pdev.name = "sunfire-fhc-leds";
+		p->leds_pdev.resource = &p->leds_resource;
+		p->leds_pdev.num_resources = 1;
+		p->leds_pdev.dev.parent = &op->dev;
+
+		err = platform_device_register(&p->leds_pdev);
+		if (err) {
+			printk(KERN_ERR "fhc: Could not register LEDS "
+			       "platform device\n");
+			goto out_unmap_pregs;
+		}
+	}
+	reg = upa_readl(p->pregs + FHC_PREGS_CTRL);
 
-	/* NOTE: reverse logic on this bit */
-	if (on)
-		tmp &= ~(FHC_CONTROL_RLED);
-	else
-		tmp |= FHC_CONTROL_RLED;
-	tmp &= ~(FHC_CONTROL_AOFF | FHC_CONTROL_BOFF | FHC_CONTROL_SLINE);
+	if (!p->central)
+		reg |= FHC_CONTROL_IXIST;
 
-	upa_writel(tmp, fhc->fhc_regs.pregs + FHC_PREGS_CTRL);
-	upa_readl(fhc->fhc_regs.pregs + FHC_PREGS_CTRL);
-}
+	reg &= ~(FHC_CONTROL_AOFF |
+		 FHC_CONTROL_BOFF |
+		 FHC_CONTROL_SLINE);
 
-static inline void central_ledblink(struct linux_central *central, int on)
-{
-	u8 tmp;
+	upa_writel(reg, p->pregs + FHC_PREGS_CTRL);
+	upa_readl(p->pregs + FHC_PREGS_CTRL);
 
-	tmp = upa_readb(central->clkregs + CLOCK_CTRL);
+	reg = upa_readl(p->pregs + FHC_PREGS_ID);
+	printk(KERN_INFO "fhc: Board #%d, Version[%x] PartID[%x] Manuf[%x] %s\n",
+	       p->board_num,
+	       (reg & FHC_ID_VERS) >> 28,
+	       (reg & FHC_ID_PARTID) >> 12,
+	       (reg & FHC_ID_MANUF) >> 1,
+	       (p->jtag_master ?
+		"(JTAG Master)" :
+		(p->central ? "(Central)" : "")));
 
-	/* NOTE: reverse logic on this bit */
-	if (on)
-		tmp &= ~(CLOCK_CTRL_RLED);
-	else
-		tmp |= CLOCK_CTRL_RLED;
+	err = 0;
 
-	upa_writeb(tmp, central->clkregs + CLOCK_CTRL);
-	upa_readb(central->clkregs + CLOCK_CTRL);
-}
+out:
+	return err;
 
-static struct timer_list sftimer;
-static int led_state;
+out_unmap_pregs:
+	of_iounmap(&op->resource[0], p->pregs, resource_size(&op->resource[0]));
 
-static void sunfire_timer(unsigned long __ignored)
-{
-	struct linux_fhc *fhc;
-
-	central_ledblink(central_bus, led_state);
-	for (fhc = fhc_list; fhc != NULL; fhc = fhc->next)
-		if (! IS_CENTRAL_FHC(fhc))
-			fhc_ledblink(fhc, led_state);
-	led_state = ! led_state;
-	sftimer.expires = jiffies + (HZ >> 1);
-	add_timer(&sftimer);
+out_free:
+	kfree(p);
+	goto out;
 }
 
-/* After PCI/SBUS busses have been probed, this is called to perform
- * final initialization of all FireHose Controllers in the system.
- */
-void firetruck_init(void)
+static struct of_device_id __initdata fhc_match[] = {
+	{
+		.name = "fhc",
+	},
+	{},
+};
+
+static struct of_platform_driver fhc_driver = {
+	.match_table	= fhc_match,
+	.probe		= fhc_probe,
+	.driver		= {
+		.name	= "fhc",
+	},
+};
+
+static int __init sunfire_init(void)
 {
-	struct linux_central *central = central_bus;
-	u8 ctrl;
-
-	/* No central bus, nothing to do. */
-	if (central = NULL)
-		return;
-
-	/* OBP leaves it on, turn it off so clock board timer LED
-	 * is in sync with FHC ones.
-	 */
-	ctrl = upa_readb(central->clkregs + CLOCK_CTRL);
-	ctrl &= ~(CLOCK_CTRL_RLED);
-	upa_writeb(ctrl, central->clkregs + CLOCK_CTRL);
-
-	led_state = 0;
-	init_timer(&sftimer);
-	sftimer.data = 0;
-	sftimer.function = &sunfire_timer;
-	sftimer.expires = jiffies + (HZ >> 1);
-	add_timer(&sftimer);
+	(void) of_register_driver(&fhc_driver, &of_platform_bus_type);
+	(void) of_register_driver(&clock_board_driver, &of_platform_bus_type);
+	return 0;
 }
+
+subsys_initcall(sunfire_init);
diff --git a/arch/sparc64/kernel/sbus.c b/arch/sparc64/kernel/sbus.c
index 9d7dfb8..2ead310 100644
--- a/arch/sparc64/kernel/sbus.c
+++ b/arch/sparc64/kernel/sbus.c
@@ -659,7 +659,6 @@ fatal_memory_error:
 
 static int __init sbus_init(void)
 {
-	extern void firetruck_init(void);
 	struct device_node *dp;
 
 	for_each_node_by_name(dp, "sbus") {
@@ -669,8 +668,6 @@ static int __init sbus_init(void)
 		of_propagate_archdata(op);
 	}
 
-	firetruck_init();
-
 	return 0;
 }
 
diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
index 75d82e2..8cc1892 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -1673,8 +1673,6 @@ void __cpuinit sun4v_ktsb_register(void)
 
 /* paging_init() sets up the page tables */
 
-extern void central_probe(void);
-
 static unsigned long last_valid_pfn;
 pgd_t swapper_pg_dir[2048];
 
@@ -1844,7 +1842,6 @@ void __init paging_init(void)
 
 	printk("Booting Linux...\n");
 
-	central_probe();
 	cpu_probe();
 }
 
-- 
1.5.6.5.GIT

