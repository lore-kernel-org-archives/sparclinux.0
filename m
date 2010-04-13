From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 23:56:39 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100413.165639.257883930.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Wed, 14 Apr 2010 00:05:43 +0200

> [  126.704213] hrtimer: interrupt took 8360145 ns

Ok, I can trigger this and then I get watchdog timeouts saying cpu X
was stuck for 61 seconds etc.

This is just using the function tracer.

If I dump all the cpu regs (Frederic, this is obtained by using 'echo
"y" >/proc/sysrq-trigger' or BREAK+Y on console, you might find this
useful :-) then I see the stuck cpus are in the function tracer code
path, often in the ring buffer entry allocator.

I can "unstick" the machine if I am able to echo "0" into
tracing_enable from one of my shells.

This is beginning to smell like a problem wherein we re-enter the
tracer from the tracer and for some reason we can't get out of the
cycle.  Maybe I forgot to annotate a helper function or file on
sparc64 to elide mcount calls.

Anyways, that is one possibility.

But, wince we see corruptions sometimes too, this could also point to
some issue with the sparc64 specific ftrace assembler stubs and
instruction patching.

I'll dig further.
