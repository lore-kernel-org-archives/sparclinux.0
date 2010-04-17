From: David Miller <davem@davemloft.net>
Date: Sat, 17 Apr 2010 21:25:59 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100417.142559.147951803.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Sat, 17 Apr 2010 19:22:21 +0200

> This looks like the true cause.
> 
> I tested the following patch and it fixes the issue after several
> manual loops of:
> 
> 	echo function_graph > current_tracer
> 	echo nop > current_tracer
> 
> 
> Before it was triggering after two trials. Now it doesn't happen
> after 10 iterations.
> 
> I'm going to hunt the culprit that causes this, we certainly need
> a new __notrace somewhere.

Hmmm, interesting... and see my other email about how my
per-cpu traces with the non-graph tracer look corrupted when
that hrtimer timeout triggers....

Let me know where this __notrace marker is needed though, sounds
interesting!
