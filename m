From: Alan Stern <stern@rowland.harvard.edu>
Date: Mon, 05 May 2008 21:06:51 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <Pine.LNX.4.44L0.0805051659480.2221-100000@iolanthe.rowland.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 5 May 2008, David Miller wrote:

> From: Meelis Roos <mroos@linux.ee>
> Date: Mon, 5 May 2008 19:13:34 +0300 (EEST)
> 
> [ USB folks CC:'d, it appears when modloading the UHCI host
>   controller on this system the cpu hangs.  ]
> 
> > modprobe      R  running task        0   414    413
> > Call Trace:
> >  [000000000058bda8] __handle_sysrq+0xd0/0x1a0
> >  [0000000000592500] sunsu_serial_interrupt+0x4e8/0x6c0
> >  [000000000047dd4c] handle_IRQ_event+0x34/0xa0
> >  [000000000047f2dc] handle_fasteoi_irq+0x64/0xe0
> >  [000000000042d548] handler_irq+0x70/0xa0
> >  [00000000004208b4] tl0_irq5+0x1c/0x20
> >  [0000000000404980] __handle_softirq+0x8/0x10
> >  [000000000045d9e0] run_timer_softirq+0x188/0x200
> >  [00000000004590e4] __do_softirq+0x6c/0xe0
> >  [00000000004591b8] do_softirq+0x60/0x80
> >  [0000000000459344] irq_exit+0x6c/0xa0
> >  [000000000042d558] handler_irq+0x80/0xa0
> >  [00000000004208b4] tl0_irq5+0x1c/0x20
> >  [fffff8006e147619] 0xfffff8006e147621
> >  [000000001001d638] usb_hcd_poll_rh_status+0x40/0x180 [usbcore]
> >  [000000001001dafc] usb_add_hcd+0x384/0x5c0 [usbcore]

That 0xfffff8006e147621 on the third line from the bottom looks 
peculiar.  Presumably it's an address in uhci-hcd before the module 
initialization procedure has completed and the symbols loaded?

In uhci-hcd, the function called by usb_hcd_poll_rh_status() is
uhci_hub_status_data(); you can find it in drivers/usb/host/uhci-hub.c.  
Almost the first thing it does is spin_lock_irqsave(), which leads me
to wonder how an interrupt could have occurred at that point.

Maybe the interrupt happened before interrupts were disabled.  Or maybe 
interrupts aren't getting disabled the way they should.  The stack dump 
seems to indicate that an IRQ5 occurs nested within another IRQ5; that 
shouldn't be possible.

> I suspect this is where it's hanging.  Could you possibly
> bisect this or run test patches from the USB folks?

Apparently the IRQ5 handler calls sunsu_serial_interrupt(); maybe 
that's where the problem is.

Alan Stern

