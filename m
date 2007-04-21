From: "Marcel van Nies" <morcles@gmail.com>
Date: Sat, 21 Apr 2007 18:43:14 +0000
Subject: Re: QuadEthernet driver broken
Message-Id: <c75cfb180704211143l2f61350s1368101886baf380@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <87lkgxgxvj.fsf@chbouib.org>
In-Reply-To: <87lkgxgxvj.fsf@chbouib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

The MAC address assignment at module loading is simply forgotten.
The bug at module unloading is caused by an incorrect call.

The bug at module unloading does not only happen for sunqe,
sunlance and sunhme (sbus) suffer from it too.

This patch fixes the sunqe driver.
The sunlance and sunhme will follow.

I've tested this on my SS20.
Thanks.

Signed-off-by: Marcel van Nies <morcles@gmail.com>

--- linux-2.6.21-rc7-git5-up/drivers/net/sunqe.c.org	2007-02-04
19:44:54.000000000 +0100
+++ linux-2.6.21-rc7-git5-up/drivers/net/sunqe.c	2007-04-21
20:15:08.000000000 +0200
@@ -845,6 +845,8 @@
 	if (!dev)
 		return -ENOMEM;

+	memcpy(dev->dev_addr, idprom->id_ethaddr, 6);
+
 	qe = netdev_priv(dev);

 	i = of_getintprop_default(sdev->ofdev.node, "channel#", -1);
@@ -960,7 +962,7 @@
 	struct sunqe *qp = dev_get_drvdata(&dev->dev);
 	struct net_device *net_dev = qp->dev;

-	unregister_netdevice(net_dev);
+	unregister_netdev(net_dev);

 	sbus_iounmap(qp->qcregs, CREG_REG_SIZE);
 	sbus_iounmap(qp->mregs, MREGS_REG_SIZE);
