From: David Miller <davem@davemloft.net>
Date: Wed, 04 Mar 2009 12:09:58 +0000
Subject: Re: esp scsi problem on shutdown - sunhme related?
Message-Id: <20090304.040958.28041245.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0903041320480.12608@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0903041320480.12608@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 4 Mar 2009 13:57:11 +0200 (EET)

> > What does /proc/interrupts look like on this system when
> > everything is up and running?
> 
> Seems they have different irqs:

Yes, but they share some registers in the SBUS controller.
I think I know what's going on.

For some interrupts, mainly those of SBUS card slots,
there is one IMAP register for the 4 interrupts that
slot can produce, but 4 ICLR registers.

The IMAP register controls "enable/disable" state as
well as contains which CPU the interrupt gets sent to.

The ICLR registers are what you hit after the interrupt
handler runs, to clear the interrupt state back to IDLE.

The problem here is that the generic interrupt layer is
going to disable both ESP's and HME's interrupts when
either of them calls free_irq() because the generic
code thinks there is only one "user" of the interrupt.
It doesn't see the sharing that happens in the controller
that we have on Sparc64.

I'm not exactly sure how I'll fix this.  I'll try to come
up with a scheme and post a patch for you to test tomorrow.

Thanks!
