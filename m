From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Mon, 05 Apr 2010 19:40:58 +0000
Subject: Re: Random scheduler/unaligned accesses crashes with perf lock
Message-Id: <20100405194055.GA5265@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100404122113.GD5177@nowhere> <20100404.180057.109331958.davem@davemloft.net> <20100405065701.GC5127@nowhere> <20100405.122233.188421941.davem@davemloft.net>
In-Reply-To: <20100405.122233.188421941.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@redhat.com, a.p.zijlstra@chello.nl, paulus@samba.org

On Mon, Apr 05, 2010 at 12:22:33PM -0700, David Miller wrote:
> From: Frederic Weisbecker <fweisbec@gmail.com>
> Date: Mon, 5 Apr 2010 08:57:04 +0200
> 
> > It seems to happen after an unaligned access fixup.
> 
> You shouldn't be getting the unaligned fixup in the first place,
> especially in the locations where you see them.  I suspect that
> once you see first fixup, all of the registers in the cpu have
> been corrupted in one way or another.
> 
> I suspect something fundamental gets corrupted, for example the
> current register window (%cwp) is corrupted and that screws up all of
> the registers so every single function starts accessing garbage.
> 
> My suspicions lie in three places, the ftrace mcount()
> stubs, stack_trace_flush(), or the new perf_arch_save_caller_regs()
> since those are the three places offhand that could make
> us potentially make us return to function in the wrong
> register window.


It happens without CONFIG_FUNCTION_TRACER as well (but it happens
when the function tracer runs). And I hadn't your perf_arch_save_caller_regs()
when I triggered this.

