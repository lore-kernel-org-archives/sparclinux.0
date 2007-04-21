From: "Marcel van Nies" <morcles@gmail.com>
Date: Sat, 21 Apr 2007 18:46:31 +0000
Subject: [PATCH] sunlance fix module unload
Message-Id: <c75cfb180704211146n20daf830p18d451d6fc1a793b@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all,

This patch fixes the sunlance driver.

I've tested this on my SS20.
Thanks.

Signed-off-by: Marcel van Nies <morcles@gmail.com>

--- linux-2.6.21-rc7-git5-up/drivers/net/sunlance.c.org	2007-02-04
19:44:54.000000000 +0100
+++ linux-2.6.21-rc7-git5-up/drivers/net/sunlance.c	2007-04-21
19:36:52.000000000 +0200
@@ -1550,7 +1550,7 @@
 	struct lance_private *lp = dev_get_drvdata(&sun4_sdev.ofdev.dev);
 	struct net_device *net_dev = lp->dev;

-	unregister_netdevice(net_dev);
+	unregister_netdev(net_dev);

 	lance_free_hwresources(lp);

@@ -1590,7 +1590,7 @@
 	struct lance_private *lp = dev_get_drvdata(&dev->dev);
 	struct net_device *net_dev = lp->dev;

-	unregister_netdevice(net_dev);
+	unregister_netdev(net_dev);

 	lance_free_hwresources(lp);
