From: David Miller <davem@davemloft.net>
Date: Fri, 27 Jul 2007 20:47:40 +0000
Subject: Re: new parport_pc BUG
Message-Id: <20070727.134740.94072311.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0707272224450.1678@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0707272224450.1678@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 27 Jul 2007 22:29:53 +0300 (EEST)

> I tested todays git (2.6.23-rc1-gd941cf5e) on Ultra 5 and got a new 
> parport_pc BUG. This time the call trace is different than last time.
> 
> The line in question is BUG_ON(dev->bus != &pci_bus_type);
> 
> kernel BUG at include/asm/dma-mapping.h:35!

Thanks for the report, I'll fix this.
