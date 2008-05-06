From: David Miller <davem@davemloft.net>
Date: Tue, 06 May 2008 20:57:25 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <20080506.135725.27054788.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>
Date: Tue, 6 May 2008 10:12:45 -0400 (EDT)

> On Mon, 5 May 2008, David Miller wrote:
> 
> > From: Alan Stern <stern@rowland.harvard.edu>
> > Date: Mon, 5 May 2008 17:06:51 -0400 (EDT)
> > 
> > From: Alan Stern <stern@rowland.harvard.edu>
> > Date: Mon, 5 May 2008 17:06:51 -0400 (EDT)
> > 
> > > On Mon, 5 May 2008, David Miller wrote:
> > > 
> > > > > Call Trace:
> > > > >  [000000000058bda8] __handle_sysrq+0xd0/0x1a0
> > > > >  [0000000000592500] sunsu_serial_interrupt+0x4e8/0x6c0
> > > > >  [000000000047dd4c] handle_IRQ_event+0x34/0xa0
> > > > >  [000000000047f2dc] handle_fasteoi_irq+0x64/0xe0
> > > > >  [000000000042d548] handler_irq+0x70/0xa0
> > > > >  [00000000004208b4] tl0_irq5+0x1c/0x20
> > > > >  [0000000000404980] __handle_softirq+0x8/0x10
> > > > >  [000000000045d9e0] run_timer_softirq+0x188/0x200
> > > > >  [00000000004590e4] __do_softirq+0x6c/0xe0
> > > > >  [00000000004591b8] do_softirq+0x60/0x80
> > > > >  [0000000000459344] irq_exit+0x6c/0xa0
> > > > >  [000000000042d558] handler_irq+0x80/0xa0
> > > > >  [00000000004208b4] tl0_irq5+0x1c/0x20
> > > > >  [fffff8006e147619] 0xfffff8006e147621
> > > > >  [000000001001d638] usb_hcd_poll_rh_status+0x40/0x180 [usbcore]
> > > > >  [000000001001dafc] usb_add_hcd+0x384/0x5c0 [usbcore]
> >  ...
> > > Maybe the interrupt happened before interrupts were disabled.  Or maybe 
> > > interrupts aren't getting disabled the way they should.  The stack dump 
> > > seems to indicate that an IRQ5 occurs nested within another IRQ5; that 
> > > shouldn't be possible.
> > 
> > Interrupts are reenabled when running softirqs right before returning
> > from the top-level interrupt.
> > 
> > Lo' and behold, the nested interrupt occurs in the middle of
> > run_timer_softirq() :-)
> > 
> > Nothing is wrong with the backtrace nor sparc64 interrupt handling.
> 
> Then my guess is that something strange is happening inside
> sunsu_serial_interrupt() or __handle_sysrq().

That's not how I read the trace.

What I see is that the cpu is stuck in usb_hcd_poll_rh_status(), and
can't make any progress.

Even if there might be some problem with sunsu_serial_interrupt() or
__handle_sysrq(), why isn't anyone willing to look at the USB portion
at the top of the backtrace at all?  I'm finding that bit frustrating.


