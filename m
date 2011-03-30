From: David Miller <davem@davemloft.net>
Date: Wed, 30 Mar 2011 09:22:09 +0000
Subject: Re: [PATCH 5/5] sparc32: genirq support
Message-Id: <20110330.022209.241934646.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1298234400-22378-5-git-send-email-sam@ravnborg.org>
In-Reply-To: <1298234400-22378-5-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 16 Mar 2011 16:53:18 +0100

> I think it is very good as well, it will save us a lot of problems in
> the future! However LEON needs VIRQ to map 1:1 to real IRQs. I figured
> that it does not hurt the SUNs if we map 1:1 as long as it is
> possible. The reason is that LEON drivers must have the possibility to
> do request_irq on IRQ and IRQ+1 and IRQ+2 and so on. Due to how the
> Plug&Play information is designed we can only know the first IRQ of a
> device, a device may have 2 IRQs (always IRQ and IRQ+1 in that
> case). And since VIRQ->REAL_IRQ but not VIRQ+1->REAL_IRQ+1 this will
> break.
> 
> Please see my patches sent to the list (not the APBUART patches),
> perhaps Sam can include the single patch into the PATCH5? The other
> patches for the exteneded IRQ controller and irq_shutdown must be
> applied afterwards.

I disagree with the validity of your conclusion.

The physical interrupts can be anything.

What you need to do on LEON is convert this linear sequence of
physical IRQs to a set of virtual IRQs and make the drivers receive
this information.

The method by which the IRQs are communicated to the kernel is
absolutely arbitrary, and has no bearing on how this stuff must
or must not work.

Therefore, there is absolutely no 1:1 requirement, and I am strongly
against supporting such a mapping.  It makes the whole VIRQ exercise
pointless.

Make the drivers LEON drivers and able to receive a set of IRQs from
the kernel, instead of depending upon linearity.
