From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 17 Feb 2011 20:57:48 +0000
Subject: How do we allocate virtual floppy irq on sparc64
Message-Id: <20110217205747.GA25027@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David / Thomas.

I'm trying to understand how we deal with floppy irq on sparc64.

In arch/sparc/include/asm/floppy_64.h we have:

               error = request_irq(FLOPPY_IRQ, sparc_floppy_irq,
                                    IRQF_DISABLED, "floppy", NULL);

FLOPPY_IRQ is set equal op->archdata.irqs[0] in sun_floppy_init().
So FLOPPY_IRQ is the platform irq - and not a virtual irq.

But as I understand request_irq(...) takes a virtual irq as parameter.
But I see no-where in the code where we allocate the virtual irq
that is equal to op->archdata.irqs[0].

I am looking into this because on sparc32 I need to come
up with something to deal with the floppy interrupt.

I was about to write something that allocated a virtual irq for
the floppy irq - but wanted to check how other archs deal with the same.
And now I am confused as I do not see how it is done...
Can you help sched some light on this?

If there is some other arch I could look at to be inspired then please
let me know.

PS. sun4m boots with my latest genirq patchset :-)
    But build fails if I eable FDC which I am looking at now.

	Sam
