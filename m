From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 09 Mar 2007 10:53:43 +0000
Subject: Re: [PATCH 4/4]: [SPARC64]: Add clocksource/clockevents support.
Message-Id: <20070309105343.GA10687@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.213759.35469392.davem@davemloft.net>
In-Reply-To: <20070305.213759.35469392.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>


* David Miller <davem@davemloft.net> wrote:

> >From 1171ef62b18d7eef093ecf961dd09b11339d53d9 Mon Sep 17 00:00:00 2001
> From: David S. Miller <davem@sunset.davemloft.net>
> Date: Mon, 5 Mar 2007 15:28:37 -0800
> Subject: [PATCH] [SPARC64]: Add clocksource/clockevents support.
> 
> I'd like to thank John Stul and others for helping me along the way.
> 
> A lot of cleanups fell out of this.  For example, the get_compare() 
> tick_op was totally unused, so was deleted.  And the most often used 
> tick_op members were grouped together for cache-friendlyness.

cool stuff! It's really gratifying to see that you were able to two new 
major features on Sparc64 (CONFIG_NO_HZ and CONFIG_HIGH_RES_TIMERS) via:

>  7 files changed, 25 insertions(+), 172 deletions(-)
>  4 files changed, 238 insertions(+), 230 deletions(-)

so it's in fact a net removal of code! I think this really demonstrates 
the power of unified frameworks.

	Ingo
