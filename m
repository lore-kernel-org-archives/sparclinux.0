From: Matthew Wilcox <matthew@wil.cx>
Date: Fri, 01 Oct 2004 18:25:00 +0000
Subject: sym2 on sparc
Message-Id: <20041001182500.GJ16153@parcelfarce.linux.theplanet.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Sorry, got the mailing address wrong for sparclinux the first time round.

Could someone with a symbios 53c8xx chip test this patch?  It works
on non-sparc.  If I don't hear of any problems, it'll be in the next
driver update.

Index: drivers/scsi/sym53c8xx_2/sym_glue.c
=================================RCS file: /var/cvs/linux-2.6/drivers/scsi/sym53c8xx_2/sym_glue.c,v
retrieving revision 1.63
diff -u -p -r1.63 sym_glue.c
--- drivers/scsi/sym53c8xx_2/sym_glue.c	28 Sep 2004 12:34:20 -0000	1.63
+++ drivers/scsi/sym53c8xx_2/sym_glue.c	1 Oct 2004 18:15:30 -0000
@@ -56,6 +56,15 @@
 #define NAME53C		"sym53c"
 #define NAME53C8XX	"sym53c8xx"
 
+/* Bloody SPARC can't do anything normal ... */
+#ifdef __sparc__
+#define IRQ_FMT "%s"
+#define IRQ_PRM(x) __irq_itoa(x)
+#else
+#define IRQ_FMT "%d"
+#define IRQ_PRM(x) (x)
+#endif
+
 static int __devinit
 pci_get_base_address(struct pci_dev *pdev, int index, u_long *base)
 {
@@ -1400,18 +1409,8 @@ static int sym_host_info(struct sym_hcb 
 	copy_info(&info, "Chip " NAME53C "%s, device id 0x%x, "
 			 "revision id 0x%x\n",
 			 np->s.chip_name, np->device_id, np->revision_id);
-	copy_info(&info, "At PCI address %s, "
-#ifdef __sparc__
-		"IRQ %s\n",
-#else
-		"IRQ %d\n",
-#endif
-		pci_name(np->s.device),
-#ifdef __sparc__
-		__irq_itoa(np->s.irq));
-#else
-		(int) np->s.irq);
-#endif
+	copy_info(&info, "At PCI address %s, IRQ " IRQ_FMT "\n",
+		pci_name(np->s.device), IRQ_PRM(np->s.irq));
 	copy_info(&info, "Min. period factor %d, %s SCSI BUS%s\n",
 			 (int) (np->minsync_dt ? np->minsync_dt : np->minsync),
 			 np->maxwide ? "Wide" : "Narrow",
@@ -1539,19 +1538,9 @@ static struct Scsi_Host * __devinit sym_
 	struct sym_fw *fw;
 
 	printk(KERN_INFO
-		"sym%d: <%s> rev 0x%x at pci %s "
-#ifdef __sparc__
-		"irq %s\n",
-#else
-		"irq %d\n",
-#endif
+		"sym%d: <%s> rev 0x%x at pci %s irq " IRQ_FMT "\n",
 		unit, dev->chip.name, dev->chip.revision_id,
-		pci_name(dev->pdev),
-#ifdef __sparc__
-		__irq_itoa(dev->s.irq));
-#else
-		dev->s.irq);
-#endif
+		pci_name(dev->pdev), IRQ_PRM(dev->s.irq));
 
 	/*
 	 *  Get the firmware for this chip.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
