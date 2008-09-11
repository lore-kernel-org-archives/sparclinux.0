From: David Miller <davem@davemloft.net>
Date: Thu, 11 Sep 2008 21:35:06 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <20080911.143506.16780375.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 11 Sep 2008 17:14:14 +0300 (EEST)

> There is still some strangeness though. Physically, the machine has 2 
> SBus Quad Fast Ethernet cards,

Ok, this is eth0-eth3 and eth5-eth8 from your log:

eth0: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet eth0: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:08
eth1: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet eth1: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:09
eth2: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet eth2: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:0a
eth3: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet eth3: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:0b
eth5: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet eth5: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:94
eth6: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet eth6: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:95
eth7: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet eth7: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:96
eth8: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet eth8: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:97


> SBus I/O module onboard hme,

That should be eth4:

eth4: HAPPY MEAL (SBUS) 10/100baseT Ethernet eth4: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:b6:ee:e2

> one PC Quad fast Ethernet (eth10..eth13)

Those appear to be missing.

> and one PCI I/O module onboard hme (eth9). 

Yep:

eth9: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet eth9: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:b6:ee:e2

> All 14 interfaces were there in 2.6.8 debian kernel, some some PCI 
> devices are missing here it seems?

Right, the PCI QFE is missing.  I bet something in the driver probe is silently
failing.

> dmesg complains about IRQ handler type mismatches though:

This is for the PCI controller error interrupts, strange.

I think it's complaining because several sources are sharing
the same interrupt, but that ought not to be the case.

Can you boot this machine with "of_debug=3" and send me the
output?

Below is a debugging patch for the sunhme driver, so we can see if
it is actually trying to probe those QFE PCI interfaces and failing
in some strange way.

diff --git a/drivers/net/sunhme.c b/drivers/net/sunhme.c
index b79d5f0..7914544 100644
--- a/drivers/net/sunhme.c
+++ b/drivers/net/sunhme.c
@@ -2992,6 +2992,9 @@ static int __devinit happy_meal_pci_probe(struct pci_dev *pdev,
 	int err;
 	DECLARE_MAC_BUF(mac);
 
+	printk(KERN_ERR "sunhme: Probing PCI device bus[%u] devfn[0x%x]\n",
+	       pdev->bus->number, pdev->devfn);
+
 	/* Now make sure pci_dev cookie is there. */
 #ifdef CONFIG_SPARC
 	dp = pci_device_to_OF_node(pdev);
@@ -3005,25 +3008,33 @@ static int __devinit happy_meal_pci_probe(struct pci_dev *pdev,
 
 	err = -ENODEV;
 
-	if (pci_enable_device(pdev))
+	if (pci_enable_device(pdev)) {
+		printk(KERN_ERR "sunhme: Cannot enable PCI device\n");
 		goto err_out;
+	}
 	pci_set_master(pdev);
 
 	if (!strcmp(prom_name, "SUNW,qfe") || !strcmp(prom_name, "qfe")) {
 		qp = quattro_pci_find(pdev);
-		if (qp = NULL)
+		if (qp = NULL) {
+			printk(KERN_ERR "sunhme: quattro_pci_find() fails\n");
 			goto err_out;
+		}
 		for (qfe_slot = 0; qfe_slot < 4; qfe_slot++)
 			if (qp->happy_meals[qfe_slot] = NULL)
 				break;
-		if (qfe_slot = 4)
+		if (qfe_slot = 4) {
+			printk(KERN_ERR "sunhme: Error, qfe_slot is 4\n");
 			goto err_out;
+		}
 	}
 
 	dev = alloc_etherdev(sizeof(struct happy_meal));
 	err = -ENOMEM;
-	if (!dev)
+	if (!dev) {
+		printk(KERN_ERR "sunhme: alloc_etherdev() fails\n");
 		goto err_out;
+	}
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
 	if (hme_version_printed++ = 0)
@@ -3206,6 +3217,7 @@ static int __devinit happy_meal_pci_probe(struct pci_dev *pdev,
 
 	printk("%s\n", print_mac(mac, dev->dev_addr));
 
+	printk(KERN_ERR "sunhme: Success\n");
 	return 0;
 
 err_out_iounmap:
@@ -3221,6 +3233,7 @@ err_out_clear_quattro:
 	free_netdev(dev);
 
 err_out:
+	printk(KERN_ERR "sunhme: Returning error %d\n", err);
 	return err;
 }
 
