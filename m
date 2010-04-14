From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Wed, 14 Apr 2010 15:29:13 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100414152911.GE5142@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 14, 2010 at 02:04:49AM -0700, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Tue, 13 Apr 2010 18:59:31 -0700 (PDT)
> 
> > From: David Miller <davem@davemloft.net>
> > Date: Tue, 13 Apr 2010 16:56:39 -0700 (PDT)
> > 
> >> I'll dig further.
> > 
> > Ok Frederic, I think I figured it out.  We only save 128 bytes
> > of stack space in the mcount stubs, but that's not enough.
> 
> Ok, one more fix after this one.
> 
> The other problem I seem to be hitting is that we overrun the main
> kernel stack with tracing enabled.
> 
> Let's run NMIs on the hardirq stack to abate this problem for now,
> patch below which I'll also push to sparc-2.6
> 
> The only remaining issue I have is that one of the cpus can get stuck
> in the scheduler load balancer.  Whatever NOHZ cpu gets selected to
> balance idle domains can get stuck because the time it takes to
> rebalance domains with tracing enabled exceeds the interval of the
> scheduler tick, so it just balances endlessly and never makes any
> forward progress from the initial timer interrupt.


I observed the same thing yesterday, cpu 0 was stuck in the balancing
path.

Anyway, I'm testing your patches.

