From: David Miller <davem@davemloft.net>
Date: Fri, 22 Aug 2008 09:13:19 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <20080822.021319.67884347.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@ut.ee>
Date: Fri, 22 Aug 2008 12:08:34 +0300 (EEST)

> [  196.489734] ohci_hcd 0000:00:0a.0: created debug files
> [  196.557562] ohci_hcd 0000:00:0a.0: irq 11, io mem 0x1ff01000000
> [  196.683692] Driver 'sr' needs updating - please use bus_type methods

I wonder if OHCI's IRQ is shared with another device.

What does /proc/interrupts say after a successful boot on
an older kernel?
