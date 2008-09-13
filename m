From: David Miller <davem@davemloft.net>
Date: Sat, 13 Sep 2008 01:42:48 +0000
Subject: Re: 16550 serial support
Message-Id: <20080912.184248.06964289.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 12 Sep 2008 20:36:40 +0200

> Unloading the module also didn't work the same way... so I figured it might
> be another unclean upgrade issue, so I rebooted it to see what happens when
> I start from scratch - and then a much more serious problem arose: at the
> point during the boot sequence when udev detected and loaded the modules,
> the machine reproducibly crashes (tried it twice in a row).

Does this make things better?

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 3b2f6c0..e27f216 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -241,7 +241,7 @@ typedef unsigned int __bitwise__ upf_t;
 
 struct uart_port {
 	spinlock_t		lock;			/* port lock */
-	unsigned int		iobase;			/* in/out[bwl] */
+	unsigned long		iobase;			/* in/out[bwl] */
 	unsigned char __iomem	*membase;		/* read/write[bwl] */
 	unsigned int		irq;			/* irq number */
 	unsigned int		uartclk;		/* base uart clock */
