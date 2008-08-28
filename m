From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 19:13:08 +0000
Subject: Re: [PATCH 0/49]: Kill SBUS device layer.
Message-Id: <20080828.121308.110152921.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080827.212309.29520193.davem@davemloft.net>
In-Reply-To: <20080827.212309.29520193.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Friedrich Oslage <bluebird@gentoo.org>
Date: Thu, 28 Aug 2008 19:49:12 +0200

> I also tested your patches on my Ultra 2, it has an Quad FastEthernet
> network interface card which causes a panic on boot:
> 
> Quattro: Fatal IRQ registery error -16.
> 
> Attached are two boot logs, one with your patches applied and one
> without.

Thank you for testing, the following patch should fix the
problem.

Let me know if it works.

diff --git a/drivers/net/sunhme.c b/drivers/net/sunhme.c
index 7638a9f..dc46e97 100644
--- a/drivers/net/sunhme.c
+++ b/drivers/net/sunhme.c
@@ -2534,7 +2534,7 @@ static struct quattro * __devinit quattro_sbus_find(struct of_device *child)
 		for (i = 0; i < 4; i++)
 			qp->happy_meals[i] = NULL;
 
-		qp->quattro_dev = op;
+		qp->quattro_dev = child;
 		qp->next = qfe_sbus_list;
 		qfe_sbus_list = qp;
 
