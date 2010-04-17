From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Sat, 17 Apr 2010 21:34:15 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100417213413.GC15037@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Apr 17, 2010 at 02:29:06PM -0700, David Miller wrote:
> From: Frederic Weisbecker <fweisbec@gmail.com>
> Date: Sat, 17 Apr 2010 19:22:21 +0200
> 
> > I tested the following patch and it fixes the issue after several
> > manual loops of:
> 
> Wait, this is completely normal.
> 
> NMIs can come in at any time and nmi_enter() emits a trace via the
> rcu_nmi_enter().
> 
> This happens on x86 too.


Yeah but I've dumped the recursion cases I could find and there
was no NMI path.

I haven't started the watchdog nor perf, I guess NMI don't trigger
in other cases, right?

For now, the only reentrancy I could find was irqs that interrupt
the tracing path. Which means no good clue there. That said I
have only logged recursivity on trace entry path, not yet
on return.

I'm disabling the protections on entry, just to narrow down
the recursivity place, in case it only happens on return.

