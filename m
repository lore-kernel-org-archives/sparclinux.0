From: Meelis Roos <mroos@linux.ee>
Date: Sat, 07 Feb 2009 23:12:28 +0000
Subject: [PATCH] fix Quattro HME irq registration on proble failures
Message-Id: <Pine.SOC.4.64.0902080008100.7639@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Hmmm... one thing we could do is only register the IRQ if all 4
> slots of the per-quattro array are filled in.
> 
> Similar checks would be needed in quattro_sbus_free_irqs().
> 
> This means we'll also have to add some code to the error paths
> of happy_meal_sbus_probe_one() to make it NULL out the
> qp->happy_meals[qfe_slot] entry on failure.

Here is a preliminary patch, with some doubts:

* should we really panic if request_irq fails in 
quattro_sbus_register_irqs()? Better propagate the error up. However, do 
we still need to return success if any IRQ was registered correctly 
(like the logic of of_register_driver one step before)?

Should this be a different patch/commit?

* happy_meal_open() does request_irq for PCI cards and non-quattro SBus 
cards, so the printk on failure may lie about SBus? Or did I misread the 
code?

But here is the patch with description:
---------------------

Currently, the sunhme driver installs SBus Quattro interrupt handler 
when at least one HME card was initialized correctly and at least one 
Quattro card is present. This breaks when a Quattro card fails 
initialization for whatever reason - IRQ is registered and OOPS happens 
when it fires.

The solution, as suggested by David Miller, was to keep track which 
cards of the Quattro bundles have been initialized, and request/free the 
Quattro IRQ only when all four devices have been successfully 
initialized.

The patch only touches SBus initialization - PCI init already resets the 
card pointer to NULL on init failure.

The patch has been tested on Sun E3500 with SBus and PCI single HME 
cards and one PCI Quattro HME card in a situation where any PCI card 
failed init when the SBus routines tried to init them by mistake.

Additionally it replaces Quattro request_irq panic with error return - 
if this card fails to work, at least let the others work. This change is 
untested.

Signed-off-by: Meelis Roos <mroos@linux.ee>

diff --git a/drivers/net/sunhme.c b/drivers/net/sunhme.c
index 7a72a31..8887ed9 100644
--- a/drivers/net/sunhme.c
+++ b/drivers/net/sunhme.c
@@ -2543,25 +2543,36 @@ static struct quattro * __devinit quattro_sbus_find(struct of_device *child)
 }
 
 /* After all quattro cards have been probed, we call these functions
- * to register the IRQ handlers.
+ * to register the IRQ handlers for the cards that have been
+ * successfully probed and skip the cards that failed to initialize
  */
-static void __init quattro_sbus_register_irqs(void)
+static int __init quattro_sbus_register_irqs(void)
 {
 	struct quattro *qp;
 
 	for (qp = qfe_sbus_list; qp != NULL; qp = qp->next) {
 		struct of_device *op = qp->quattro_dev;
 		int err;
+		int qfe_slot, skip = 0;
+
+		for (qfe_slot = 0; qfe_slot < 4; qfe_slot++) {
+			if (qp->happy_meals[qfe_slot] = NULL) {
+				skip = 1;
+			}
+		}
+		if (skip) continue;
 
 		err = request_irq(op->irqs[0],
 				  quattro_sbus_interrupt,
 				  IRQF_SHARED, "Quattro",
 				  qp);
 		if (err != 0) {
-			printk(KERN_ERR "Quattro: Fatal IRQ registery error %d.\n", err);
-			panic("QFE request irq");
+			printk(KERN_ERR "Quattro HME: IRQ registration error %d.\n", err);
+			return err;
 		}
 	}
+
+	return 0;
 }
 
 static void quattro_sbus_free_irqs(void)
@@ -2570,6 +2581,14 @@ static void quattro_sbus_free_irqs(void)
 
 	for (qp = qfe_sbus_list; qp != NULL; qp = qp->next) {
 		struct of_device *op = qp->quattro_dev;
+		int qfe_slot, skip = 0;
+
+		for (qfe_slot = 0; qfe_slot < 4; qfe_slot++) {
+			if (qp->happy_meals[qfe_slot] = NULL) {
+				skip = 1;
+			}
+		}
+		if (skip) continue;
 
 		free_irq(op->irqs[0], qp);
 	}
@@ -2824,6 +2843,10 @@ err_out_iounmap:
 	if (hp->tcvregs)
 		of_iounmap(&op->resource[4], hp->tcvregs, TCVR_REG_SIZE);
 
+	if (qp != NULL ) {
+		qp->happy_meals[qfe_slot] = NULL;
+	}
+
 err_out_free_netdev:
 	free_netdev(dev);
 
@@ -3281,7 +3304,7 @@ static int __init happy_meal_sbus_init(void)
 
 	err = of_register_driver(&hme_sbus_driver, &of_bus_type);
 	if (!err)
-		quattro_sbus_register_irqs();
+		err = quattro_sbus_register_irqs();
 
 	return err;
 }


-- 
Meelis Roos (mroos@linux.ee)
