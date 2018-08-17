From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 17 Aug 2018 19:12:22 +0000
Subject: [PATCH] sunhme: convert printk to pr_cont
Message-Id: <alpine.LRH.2.02.1808171510510.31883@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, netdev@vger.kernel.org

The kernel adds newlines automatically unless pr_cont is used. This patch
converts sunhme to use pr_cont, so that the messages are not broken to
multiple lines.

The patch also adds "\n" to a few strings that were missing it.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/net/ethernet/sun/sunhme.c |   70 +++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

Index: linux-stable/drivers/net/ethernet/sun/sunhme.c
=================================--- linux-stable.orig/drivers/net/ethernet/sun/sunhme.c	2018-04-20 18:11:00.000000000 +0200
+++ linux-stable/drivers/net/ethernet/sun/sunhme.c	2018-08-13 22:01:08.000000000 +0200
@@ -572,21 +572,21 @@ static void display_link_mode(struct hap
 {
 	printk(KERN_INFO "%s: Link is up using ", hp->dev->name);
 	if (hp->tcvr_type = external)
-		printk("external ");
+		pr_cont("external ");
 	else
-		printk("internal ");
-	printk("transceiver at ");
+		pr_cont("internal ");
+	pr_cont("transceiver at ");
 	hp->sw_lpa = happy_meal_tcvr_read(hp, tregs, MII_LPA);
 	if (hp->sw_lpa & (LPA_100HALF | LPA_100FULL)) {
 		if (hp->sw_lpa & LPA_100FULL)
-			printk("100Mb/s, Full Duplex.\n");
+			pr_cont("100Mb/s, Full Duplex.\n");
 		else
-			printk("100Mb/s, Half Duplex.\n");
+			pr_cont("100Mb/s, Half Duplex.\n");
 	} else {
 		if (hp->sw_lpa & LPA_10FULL)
-			printk("10Mb/s, Full Duplex.\n");
+			pr_cont("10Mb/s, Full Duplex.\n");
 		else
-			printk("10Mb/s, Half Duplex.\n");
+			pr_cont("10Mb/s, Half Duplex.\n");
 	}
 }
 
@@ -594,19 +594,19 @@ static void display_forced_link_mode(str
 {
 	printk(KERN_INFO "%s: Link has been forced up using ", hp->dev->name);
 	if (hp->tcvr_type = external)
-		printk("external ");
+		pr_cont("external ");
 	else
-		printk("internal ");
-	printk("transceiver at ");
+		pr_cont("internal ");
+	pr_cont("transceiver at ");
 	hp->sw_bmcr = happy_meal_tcvr_read(hp, tregs, MII_BMCR);
 	if (hp->sw_bmcr & BMCR_SPEED100)
-		printk("100Mb/s, ");
+		pr_cont("100Mb/s, ");
 	else
-		printk("10Mb/s, ");
+		pr_cont("10Mb/s, ");
 	if (hp->sw_bmcr & BMCR_FULLDPLX)
-		printk("Full Duplex.\n");
+		pr_cont("Full Duplex.\n");
 	else
-		printk("Half Duplex.\n");
+		pr_cont("Half Duplex.\n");
 }
 
 static int set_happy_link_modes(struct happy_meal *hp, void __iomem *tregs)
@@ -883,7 +883,7 @@ static void happy_meal_tx_reset(struct h
 
 	/* Lettuce, tomato, buggy hardware (no extra charge)? */
 	if (!tries)
-		printk(KERN_ERR "happy meal: Transceiver BigMac ATTACK!");
+		printk(KERN_ERR "happy meal: Transceiver BigMac ATTACK!\n");
 
 	/* Take care. */
 	HMD(("done\n"));
@@ -903,7 +903,7 @@ static void happy_meal_rx_reset(struct h
 
 	/* Will that be all? */
 	if (!tries)
-		printk(KERN_ERR "happy meal: Receiver BigMac ATTACK!");
+		printk(KERN_ERR "happy meal: Receiver BigMac ATTACK!\n");
 
 	/* Don't forget your vik_1137125_wa.  Have a nice day. */
 	HMD(("done\n"));
@@ -925,7 +925,7 @@ static void happy_meal_stop(struct happy
 
 	/* Come back next week when we are "Sun Microelectronics". */
 	if (!tries)
-		printk(KERN_ERR "happy meal: Fry guys.");
+		printk(KERN_ERR "happy meal: Fry guys.\n");
 
 	/* Remember: "Different name, same old buggy as shit hardware." */
 	HMD(("done\n"));
@@ -1143,7 +1143,7 @@ static void happy_meal_transceiver_check
 				hp->tcvr_type = internal;
 				ASD(("<internal>\n"));
 			} else {
-				printk(KERN_ERR "happy meal: Transceiver and a coke please.");
+				printk(KERN_ERR "happy meal: Transceiver and a coke please.\n");
 				hp->tcvr_type = none; /* Grrr... */
 				ASD(("<none>\n"));
 			}
@@ -1824,12 +1824,12 @@ static int happy_meal_is_not_so_happy(st
 		/* All sorts of DMA receive errors. */
 		printk(KERN_ERR "%s: Happy Meal rx DMA errors [ ", hp->dev->name);
 		if (status & GREG_STAT_RXERR)
-			printk("GenericError ");
+			pr_cont("GenericError ");
 		if (status & GREG_STAT_RXPERR)
-			printk("ParityError ");
+			pr_cont("ParityError ");
 		if (status & GREG_STAT_RXTERR)
-			printk("RxTagBotch ");
-		printk("]\n");
+			pr_cont("RxTagBotch ");
+		pr_cont("]\n");
 		reset = 1;
 	}
 
@@ -1852,14 +1852,14 @@ static int happy_meal_is_not_so_happy(st
 		/* All sorts of transmit DMA errors. */
 		printk(KERN_ERR "%s: Happy Meal tx DMA errors [ ", hp->dev->name);
 		if (status & GREG_STAT_TXEACK)
-			printk("GenericError ");
+			pr_cont("GenericError ");
 		if (status & GREG_STAT_TXLERR)
-			printk("LateError ");
+			pr_cont("LateError ");
 		if (status & GREG_STAT_TXPERR)
-			printk("ParityError ");
+			pr_cont("ParityError ");
 		if (status & GREG_STAT_TXTERR)
-			printk("TagBotch ");
-		printk("]\n");
+			pr_cont("TagBotch ");
+		pr_cont("]\n");
 		reset = 1;
 	}
 
@@ -1892,16 +1892,16 @@ static void happy_meal_mif_interrupt(str
 
 	/* Use the fastest transmission protocol possible. */
 	if (hp->sw_lpa & LPA_100FULL) {
-		printk(KERN_INFO "%s: Switching to 100Mbps at full duplex.", hp->dev->name);
+		printk(KERN_INFO "%s: Switching to 100Mbps at full duplex.\n", hp->dev->name);
 		hp->sw_bmcr |= (BMCR_FULLDPLX | BMCR_SPEED100);
 	} else if (hp->sw_lpa & LPA_100HALF) {
-		printk(KERN_INFO "%s: Switching to 100MBps at half duplex.", hp->dev->name);
+		printk(KERN_INFO "%s: Switching to 100MBps at half duplex.\n", hp->dev->name);
 		hp->sw_bmcr |= BMCR_SPEED100;
 	} else if (hp->sw_lpa & LPA_10FULL) {
-		printk(KERN_INFO "%s: Switching to 10MBps at full duplex.", hp->dev->name);
+		printk(KERN_INFO "%s: Switching to 10MBps at full duplex.\n", hp->dev->name);
 		hp->sw_bmcr |= BMCR_FULLDPLX;
 	} else {
-		printk(KERN_INFO "%s: Using 10Mbps at half duplex.", hp->dev->name);
+		printk(KERN_INFO "%s: Using 10Mbps at half duplex.\n", hp->dev->name);
 	}
 	happy_meal_tcvr_write(hp, tregs, MII_BMCR, hp->sw_bmcr);
 
@@ -2863,7 +2863,7 @@ static int happy_meal_sbus_probe_one(str
 		printk(KERN_INFO "%s: HAPPY MEAL (SBUS) 10/100baseT Ethernet ",
 		       dev->name);
 
-	printk("%pM\n", dev->dev_addr);
+	pr_cont("%pM\n", dev->dev_addr);
 
 	return 0;
 
@@ -3180,9 +3180,9 @@ static int happy_meal_pci_probe(struct p
 		printk(KERN_INFO "%s%s: Quattro HME (PCI/CheerIO) 10/100baseT Ethernet ", dev->name, prom_name);
 		if (qpdev->vendor = PCI_VENDOR_ID_DEC &&
 		    qpdev->device = PCI_DEVICE_ID_DEC_21153)
-			printk("DEC 21153 PCI Bridge\n");
+			pr_cont("DEC 21153 PCI Bridge\n");
 		else
-			printk("unknown bridge %04x.%04x\n",
+			pr_cont("unknown bridge %04x.%04x\n",
 				qpdev->vendor, qpdev->device);
 	}
 
@@ -3193,7 +3193,7 @@ static int happy_meal_pci_probe(struct p
 		printk(KERN_INFO "%s: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet ",
 		       dev->name);
 
-	printk("%pM\n", dev->dev_addr);
+	pr_cont("%pM\n", dev->dev_addr);
 
 	return 0;
 
