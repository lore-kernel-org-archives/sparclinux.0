From: David Miller <davem@davemloft.net>
Date: Mon, 12 Jun 2017 22:46:37 +0000
Subject: Re: [v3 0/8] Early boot timestamp
Message-Id: <20170612.184637.792618363736431368.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1497300108-158125-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1497300108-158125-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 12 Jun 2017 16:41:40 -0400

> Changelog:
> 	v2 - v3:
> 		- __aligned(64) -> __cacheline_aligned
> 		- Replaced in sched_clock() wmb() with barrier()
> 	v1 - v2:
> 		- Early boot timestamps are now available on all 64-bit
> 		  sparc processors
> 		- New hot-patched get_tick() function.
> 
> This patch set:
> - enables early boot timestamps on SPARC,
> - adds offset so we count time from zero, the same as it is done on other
>   platforms
> - improves the performance by inling, hot patching, and combining loads
>   into the same cacheline. (and few other optimizations).
> 
> So, the final performance of sched_clock() is faster than now: the fewer
> number of loads, and all of them are coming from the same cacheline. Loads
> can run while we are reading tick value, and we do not do function call.
 ...

Applied, thanks for doing this work.

I'll push it out to the sparc-next tree after I do a little bit of
testing myself.

Thanks again.
