From: David Miller <davem@davemloft.net>
Date: Fri, 14 Sep 2007 17:21:34 +0000
Subject: Re: netconsole support for kernel 2.4 / sunhme patch
Message-Id: <20070914.102134.74738227.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C0602E1C431@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C0602E1C431@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Fri, 14 Sep 2007 08:25:45 +0200

> +static void poll_happy_meal (struct net_device *dev)
> +{
> +       disable_irq(dev->irq);
> +       sis900_interrupt (dev->irq, dev, NULL);
> +       enable_irq(dev->irq);
> +}
> +#endif

You obviously did not even try to use this, as you're calling the
interrupt handler for another driver.

This is what happens when you mindlessly cut and paste.
