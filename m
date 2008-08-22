From: David Miller <davem@davemloft.net>
Date: Fri, 22 Aug 2008 09:45:31 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <20080822.024531.55901510.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@ut.ee>
Date: Fri, 22 Aug 2008 12:43:08 +0300 (EEST)

>            CPU0
>   0:       2711     <NULL>  timer
>   6:          0      sun4u  power
>   7:        153      sun4u  su(serial)
>   9:        388      sun4u  eth0
>  11:          2      sun4u  ohci_hcd:usb1
>  12:       1733      sun4u  pata_ali
> 
> eth1 is irq 10, currently down, but strange that there is no irq.
> ifconfig eth1 up:
> 
>            CPU0
>   0:       3794     <NULL>  timer
>   6:          0      sun4u  power
>   7:        153      sun4u  su(serial)
>   9:        776      sun4u  eth0
>  10:          5      sun4u  eth1
>  11:          2      sun4u  ohci_hcd:usb1
>  12:       1830      sun4u  pata_ali
> 
> wonder if there are some things more like that...

IRQs don't get requested until the network device is brought up,
for some drivers at least.  That's why eth1 doesn't show up when
it's down.

