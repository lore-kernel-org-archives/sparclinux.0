From: "Marcel van Nies" <morcles@gmail.com>
Date: Sat, 21 Apr 2007 18:49:58 +0000
Subject: [PATCH] sunhme fix module unload
Message-Id: <c75cfb180704211149j1ec90ca8h35fc897c088228e1@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all,

This patch fixes the sunhme driver.

I've tested this on my SS20.
Thanks.

Signed-off-by: Marcel van Nies <morcles@gmail.com>

--- linux-2.6.21-rc7-git5-up/drivers/net/sunhme.c.org	2007-02-04
19:44:54.000000000 +0100
+++ linux-2.6.21-rc7-git5-up/drivers/net/sunhme.c	2007-04-21
19:36:09.000000000 +0200
@@ -3314,7 +3314,7 @@
 	struct happy_meal *hp = dev_get_drvdata(&dev->dev);
 	struct net_device *net_dev = hp->dev;

-	unregister_netdevice(net_dev);
+	unregister_netdev(net_dev);

 	/* XXX qfe parent interrupt... */
