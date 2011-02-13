From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 Feb 2011 22:30:18 +0000
Subject: Re: [PATCH 4/4] sparc32: genirq conversion (buggy)
Message-Id: <20110213223018.GA1036@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110213192952.GD25069@merkur.ravnborg.org>
In-Reply-To: <20110213192952.GD25069@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Feb 13, 2011 at 02:00:26PM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 13 Feb 2011 22:48:44 +0100
> 
> > In the original implmentation we did the same via __enable_irq().
> 
> And we did so Via a function that's invoked by every cpu as it is booted.
> 
> Right?

To the best of my knowledge - no.

In irq_32.c:request_irq() we had:

        __enable_irq(irq);  // irq is what we consider real_irq


In irq.h: we had:
BTFIXUPDEF_CALL(void, enable_irq, unsigned int)
static inline void __enable_irq(unsigned int irq)
{
        BTFIXUP_CALL(enable_irq)(irq);
}

In sun4m_irq.c we had:
void __init sun4m_init_IRQ(void)
{
	...
	BTFIXUPSET_CALL(enable_irq, sun4m_enable_irq, BTFIXUPCALL_NORM);

So unless the btfix stuff does trick I do not understand then I
do not see this iterate over all cpu's.

I guess there is something obvious I have missed :-(

One thing I have left-out on the sun4m side is a call
to smp4m_irq_rotate() that for each interrupt let
the next be the interrupt target.
But I do not see that interrupts are globally enabled.


Note: I got one step further. It helped that I
called irq_ack(), irq_enable() around my desc->handle_irq(irq, desc);

But desc->handle_irq in NULL.

That will be for another day - it is getting late.

Thanks for all the help so far!

	Sam
