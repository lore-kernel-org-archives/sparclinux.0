From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Tue, 06 Apr 2010 11:38:34 +0000
Subject: Re: Random scheduler/unaligned accesses crashes with perf lock
Message-Id: <20100406113830.GF5147@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100405065701.GC5127@nowhere> <20100405.122233.188421941.davem@davemloft.net> <20100405194055.GA5265@nowhere> <20100406.025049.267615796.davem@davemloft.net>
In-Reply-To: <20100406.025049.267615796.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@redhat.com, a.p.zijlstra@chello.nl, paulus@samba.org

On Tue, Apr 06, 2010 at 02:50:49AM -0700, David Miller wrote:
> From: Frederic Weisbecker <fweisbec@gmail.com>
> Date: Mon, 5 Apr 2010 21:40:58 +0200
> 
> > It happens without CONFIG_FUNCTION_TRACER as well (but it happens
> > when the function tracer runs). And I hadn't your
> > perf_arch_save_caller_regs() when I triggered this.
> 
> I figured out the problem, it's NMIs.  As soon as I disable all of the
> NMI watchdog code, the problem goes away.
> 
> This is because some parts of the NMI interrupt handling path are not
> marked with "notrace" and the various tracer code paths use
> local_irq_disable() (either directly or indirectly) which doesn't work
> with sparc64's NMI scheme.  These essentially turn NMIs back on in the
> NMI handler before the NMI condition has been cleared, and thus we can
> re-enter with another NMI interrupt.
> 
> We went through this for perf events, and we just made sure that
> local_irq_{enable,disable}() never occurs in any of the code paths in
> perf events that can be reached via the NMI interrupt handler.  (the
> only one we had was sched_clock() and that was easily fixed)



That reminds me we have a new pair of local_irq_disable/enable
in perf_event_task_output(), which path can be taken by hardware
pmu events.

See this patch:

8bb39f9aa068262732fe44b965d7a6eb5a5a7d67
perf: Fix 'perf sched record' deadlock

