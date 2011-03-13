From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 Mar 2011 21:13:31 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <20110313211331.GA3683@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi Daniel - thanks for looking at this patch.

I was actually planning to send it to David tonight.
But after your comments I will wait.

>  I have begun too look at the patches, one thing that strikes me is
> why handle_level_irq is used and why the ack functions irq_ack and
> irq_mask_ack are not defined.

The sun4m at least uses level triggered interrupts.
And looking at the implmentation the enable() and disable() functions
in all cases did a simple mask and unmask - also the leon variants.

So based on this observation I decided to go got the handle_level_irq
flow handler. From the implmentation in kernel/irq/ I could
also see that handle_level_irq always called irq_mask() / irq_unmask()
which was a match towoards to earlier implemtnation.

On top of this - this just worked for my sun4m box.

> On the LEON architecture IRQs are
> normally edge triggered, the exception beeing PCI interrupts that is
> level triggered. Implementing the ack functions in the current
> implementation would result in acking edge triggered IRQs which means
> IRQs may be lost (on the LEON at least)? I thought SUN SPARCs also have
> edge triggered interrupts and that the CPU acks the IRQ automatically
> when the trap is taken?
>  =A0
>  What is the difference between having handle_level_irq without ACKs
> implemented and having handle_edge_irq doing the interrupt flow
> handling?

Thomas? Can you help here? You are much more into these details than I am.

	Sam
