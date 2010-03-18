From: David Miller <davem@davemloft.net>
Date: Thu, 18 Mar 2010 06:26:48 +0000
Subject: Re: [BUG] percpu misaligned allocation
Message-Id: <20100317.232648.59697287.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100318044930.GC5045@nowhere>
In-Reply-To: <20100318044930.GC5045@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fweisbec@gmail.com
Cc: sparclinux@vger.kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Thu, 18 Mar 2010 05:49:33 +0100

> While using the lock events through perf in a sparc box, I can see
> the following message repeated many times:
> 
> 	Kernel unaligned access at TPC[49357c] perf_trace_lock_acquire+0xb4/0x180
> 
> It actually hangs the box as the messages are sent to a serial console.
> 
> When used with perf, the trace events use a per cpu buffer allocated
> in kernel/trace/trace_event_perf.c, and the allocation appears to return
> a misaligned percpu pointer. It is aligned to 4 while it seems it
> requires to be aligned to 8.

Thanks I'll take a look at this.

RAW locks (both rwlocks and spinlocks) on sparc64 are 4-bytes
in size, maybe some piece of code is assuming that locks
are cpu word sized.

Where is perf_trace_lock_acquire() I can't find it in Linus's
tree?  Does it get created by some crazy macro expansion?

