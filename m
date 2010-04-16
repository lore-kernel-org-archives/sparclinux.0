From: David Miller <davem@davemloft.net>
Date: Fri, 16 Apr 2010 09:12:32 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100416.021232.263517287.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hey Frederic, I just wanted you to know that I'm slowly but
surely trying to make progress on these crashes.

I'm trying various different things to narrow down the source of the
corruptions, so here's what I've done so far.

I did some things to eliminate various aspects of the function tracing
code paths, and see if the problem persists.

First, I made function_trace_call() unconditionally return
immediately.

Next, I restored function_trace_call() back to normal, and instead
made trace_function() return immediately.

I could not reproduce the corruptions in either of these cases with
the function tracer enabled in situations where I was guarenteed
normally to see a crash.

So the only part of the code paths left is the ring buffer and the
filling in of the entries.

Therefore, what I'm doing now is trying things like running various
hacked up variants of the ring buffer benchmark module while doing
things that usually trigger the bug (for me a "make -j128" is usually
enough) hoping I can trigger corruption.  No luck on that so far but
I'll keep trying this angle just to make sure.

BTW, I noticed that every single time we see the corruptions now, we
always see that "hrtimer: interrupt took xxx ns" message first.  I
have never seen the corruption messages without that reaching the logs
first.

Have you?

That might be an important clue, who knows...
