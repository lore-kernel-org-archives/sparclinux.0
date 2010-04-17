From: David Miller <davem@davemloft.net>
Date: Sat, 17 Apr 2010 21:24:13 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100417.142413.52204017.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Sat, 17 Apr 2010 18:59:25 +0200

> This could be also a tracing recursion somewhere.
> One good way to know is to put pause_graph_tracing()
> and unpause_graph_tracing() in the very beginning and
> end of the tracing paths.
> 
> /me goes to try this.

Last night I still couldn't get the stack overflow checks to trigger,
even once i accounted for dynamic ftrace patchin, unfortunately.

But...

I added a tracing_off() call to the hrtimer deadlock avoidance case
and the machine doesn't crash after that triggers.

So I went to look at the per-cpu trace of the processor on which
the hrtimer deadlock avoidance triggered, and it has a looping
sequence of timestamps which looks really strange.  The other
per-cpu traces look just fine.

This is a major clue I think, so I'll keep snooping around trying
to dig more deeply into this.
