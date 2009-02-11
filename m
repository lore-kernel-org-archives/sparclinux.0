From: David Miller <davem@davemloft.net>
Date: Wed, 11 Feb 2009 01:32:52 +0000
Subject: Re: [PATCH] fix Quattro HME irq registration on proble failures
Message-Id: <20090210.173252.247636723.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0902080008100.7639@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0902080008100.7639@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 8 Feb 2009 01:12:28 +0200 (EET)

> Currently, the sunhme driver installs SBus Quattro interrupt handler 
> when at least one HME card was initialized correctly and at least one 
> Quattro card is present. This breaks when a Quattro card fails 
> initialization for whatever reason - IRQ is registered and OOPS happens 
> when it fires.
> 
> The solution, as suggested by David Miller, was to keep track which 
> cards of the Quattro bundles have been initialized, and request/free the 
> Quattro IRQ only when all four devices have been successfully 
> initialized.
> 
> The patch only touches SBus initialization - PCI init already resets the 
> card pointer to NULL on init failure.
> 
> The patch has been tested on Sun E3500 with SBus and PCI single HME 
> cards and one PCI Quattro HME card in a situation where any PCI card 
> failed init when the SBus routines tried to init them by mistake.
> 
> Additionally it replaces Quattro request_irq panic with error return - 
> if this card fails to work, at least let the others work. This change is 
> untested.
> 
> Signed-off-by: Meelis Roos <mroos@linux.ee>

This patch looks great, I made some minor coding style fixups
and updated to commit log message to indicate that you did
test this change also on an E450 system.

Now, to answer your questions:

> * should we really panic if request_irq fails in 
> quattro_sbus_register_irqs()? Better propagate the error up. However, do 
> we still need to return success if any IRQ was registered correctly 
> (like the logic of of_register_driver one step before)?

Yes, propagating the error is much better.  The panic() is overboard.

> * happy_meal_open() does request_irq for PCI cards and non-quattro SBus 
> cards, so the printk on failure may lie about SBus? Or did I misread the 
> code?

It's half lying :-) In some of the cases this request_irq() would be
for SBUS (non-quattro only) and for others it would be for PCI
(quattro or not).
