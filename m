From: David Miller <davem@davemloft.net>
Date: Fri, 16 Apr 2010 20:47:01 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100416.134701.106783257.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Fri, 16 Apr 2010 17:44:21 +0200

> """(note the hrtimer warnings are normals. This is a hanging prevention
> that has been added because of the function graph tracer first but
> eventually serves as a general protection for hrtimer. It's about
> similar to the balancing problem scheme: the time to service timers
> is so slow that timers re-expire before we exit the servicing loop,
> so we risk an endless loop)."""

I don't think it's normal in this case, I suspect we loop because
of some kind of corruption.

> That said it also means there is a problem I think. It's normal
> that it happens in a guest, but not a normal box. May be there
> a contention in the tracer fast path that slows down the machine.

I think it's looping not because of contention, but because of
corrupted memory/registers.

> Do you have CONFIG_DEBUG_LOCKDEP enabled? This was one of the
> sources of these contentions (fixed lately in -tip but for
> .35).

I'm using PROVE_LOCKING but not DEBUG_LOCKDEP.

Anyways, consistently my machine crashes with completely corrupted
registers in either irq_exit() or __do_softirq().  Usually we get an
unaligned access of some sort, either accessing the stack (because %fp
is garbage) or via an indirect call (usually because %i7 is garbage).

One thing that's interesting about the softirq path is that it uses
the softirq stack.  The only thing that guards us jumping onto the
softirq_stack are the tests done by do_softirq(), mainly
!in_interrupt() and we have softirqs pending.

What if preempt_count() got corrupted in such a way that we end up
evaluating in_interrupt() to zero when we shouldn't?

If that happens, and this makes us jump onto the top of softirq stack
of the current cpu multiple times, that could cause some wild
corruptions.

Another thing I've noticed is that there appears to be some kind of
pattern to many of the register corruptions I've seen.  There is
a pattern of 64-bit values that often looks like this (in memory
order):

0xffffffffc3300000
0xffffffffc33000cc
0xffffffffc3d00000
0xffffffffc3d000cc
0xffffffffc4000000
0xffffffffc40000cc

and, from another trace:

0xffffffffc6100000
0xffffffffc61000cc
0xffffffffc6a00000
0xffffffffc6a000cc
0xffffffffc6e00000
0xffffffffc6e000cc

They look like some kind of descriptor.  The closest thing I could
find were the scatter-gather descriptors used by the Fusion mptsas
driver, but I can't find a way that the descriptors would be formed
exactly like the above, but it does come close.

For example, drivers/message/fusion/mptscsih.c:mptscsih_qcmd()
has this call:

		ioc->add_sge((char *)&pScsiReq->SGL,
			MPT_SGE_FLAGS_SSIMPLE_READ | 0,
			(dma_addr_t) -1);

which puts -1 into the address field, but this doesn't exactly line up
because the 32-bit SGE descriptors are in the order "flags" then
"address" not the other way around.

Ho hum... anyways, just looking for clues.  If those are mptsas
descriptors, then it would be consistent with how I've found that the
block I/O path seems to invariably be involved during the crashes.
In another trace (that time with PROVE_LOCKING disabled) I saw
the host->host_lock passed down into spin_lock_irqsave() being NULL.
And this was in the software interrupt handler.
