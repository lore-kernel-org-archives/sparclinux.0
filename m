From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Wed, 03 Sep 2008 16:32:45 +0000
Subject: [PATCH 1/2] rtc-m48t59: allow externally mapped ioaddr
Message-Id: <20080903183245.fe3a08eb.krzysztof.h1@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Add support for externally mapped ioaddr.
This is required on sparc32 as the ioaddr
must be mapped with of_ioremap().

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-old/drivers/rtc/rtc-m48t59.c linux-sparc/drivers/rtc/rtc-m48t59.c
--- linux-old/drivers/rtc/rtc-m48t59.c	2008-09-03 17:58:23.379026420 +0200
+++ linux-sparc/drivers/rtc/rtc-m48t59.c	2008-09-03 18:14:22.391028044 +0200
@@ -411,9 +411,14 @@ static int __devinit m48t59_rtc_probe(st
 	if (!m48t59)
 		return -ENOMEM;
 
-	m48t59->ioaddr = ioremap(res->start, res->end - res->start + 1);
-	if (!m48t59->ioaddr)
-		goto out;
+	m48t59->ioaddr = pdata->ioaddr;
+
+	if (!m48t59->ioaddr) {
+		/* ioaddr not mapped externally */
+		m48t59->ioaddr = ioremap(res->start, res->end - res->start + 1);
+		if (!m48t59->ioaddr)
+			goto out;
+	}
 
 	/* Try to get irq number. We also can work in
 	 * the mode without IRQ.
@@ -481,11 +486,12 @@ out:
 static int __devexit m48t59_rtc_remove(struct platform_device *pdev)
 {
 	struct m48t59_private *m48t59 = platform_get_drvdata(pdev);
+	struct m48t59_plat_data *pdata = pdev->dev.platform_data;
 
 	sysfs_remove_bin_file(&pdev->dev.kobj, &m48t59_nvram_attr);
 	if (!IS_ERR(m48t59->rtc))
 		rtc_device_unregister(m48t59->rtc);
-	if (m48t59->ioaddr)
+	if (m48t59->ioaddr &&  !pdata->ioaddr)
 		iounmap(m48t59->ioaddr);
 	if (m48t59->irq != NO_IRQ)
 		free_irq(m48t59->irq, &pdev->dev);
diff -urp linux-old/include/linux/rtc/m48t59.h linux-sparc/include/linux/rtc/m48t59.h
--- linux-old/include/linux/rtc/m48t59.h	2008-09-03 17:58:23.379026420 +0200
+++ linux-sparc/include/linux/rtc/m48t59.h	2008-09-03 18:13:30.039022100 +0200
@@ -55,6 +55,8 @@ struct m48t59_plat_data {
 
 	int type; /* RTC model */
 
+	/* ioaddr mapped externally */
+	void __iomem *ioaddr;
 	/* offset to RTC registers, automatically set according to the type */
 	unsigned int offset;
 };
