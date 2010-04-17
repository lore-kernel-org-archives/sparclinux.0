From: David Miller <davem@davemloft.net>
Date: Sat, 17 Apr 2010 21:38:37 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100417.143837.24301795.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Sat, 17 Apr 2010 23:34:15 +0200

> I haven't started the watchdog nor perf, I guess NMI don't trigger
> in other cases, right?

They do, for the NMI watchdog, every few seconds.

> For now, the only reentrancy I could find was irqs that interrupt
> the tracing path. Which means no good clue there. That said I
> have only logged recursivity on trace entry path, not yet
> on return.
> 
> I'm disabling the protections on entry, just to narrow down
> the recursivity place, in case it only happens on return.

No need to do so much work, when you hit this case simply
disable tracing and dump_stack().  That way you'll see it
clearly.
