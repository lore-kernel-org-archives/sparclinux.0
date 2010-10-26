From: David Miller <davem@davemloft.net>
Date: Tue, 26 Oct 2010 17:54:51 +0000
Subject: Re: LEON SMP
Message-Id: <20101026.105451.242135041.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4CC714EC.2050001@gaisler.com>
In-Reply-To: <4CC714EC.2050001@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 26 Oct 2010 19:50:36 +0200

> The LEON do not have internal timers as some CPUs does, it has
> one/multiple General Purpose TIMERs on the Processor Local Bus. On
> single-CPU/SMP systems the first Timer is used for System Clock, and
> on SMP systems timer two is also used to generate a simultaneous IRQ
> on all CPUs for profiling etc. (leon_percpu_timer_interrupt()). On the
> quad-core SMP system I discovered that since the per-cpu timer is
> generated at the same frequency (and almost simultaneously) as the
> System Clock Timer. I have made a patch that uses only one Timer for
> SMP systems, the Timer generates a per-cpu tick as before, however on
> CPU0 the handler_irq() is also called after profiling has been done,
> this is to handle the System Clock Tick. I seems to work successfully,
> and it saves me HZ interrupts per second and a Timer instance. What is
> you opinion about that? Is it possible to use the same timer for
> System Clock and for per-cpu profiling etc.?

You only need to generate one timer interrupt per-cpu, and the kernel
generically decides to run the global timer actions (jiffies update,
etc.) on a choosen cpu, transparently, in the per-cpu periodic timer
code.
