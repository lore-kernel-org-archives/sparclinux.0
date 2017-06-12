From: David Miller <davem@davemloft.net>
Date: Mon, 12 Jun 2017 19:13:15 +0000
Subject: Re: [v2 8/8] sparc64: optimize functions that access tick
Message-Id: <20170612.151315.1161089292073771494.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1497286107-974183-9-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1497286107-974183-9-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 12 Jun 2017 12:48:27 -0400

> @@ -853,13 +851,19 @@ unsigned long long sched_clock(void)
>  {
>  	unsigned long quotient = tick_operations.ticks_per_nsec_quotient;
>  	unsigned long offset = tick_operations.offset;
> -	unsigned long ticks = tick_operations.get_tick();
>  
> -	return ((ticks * quotient) >> SPARC64_NSEC_PER_CYC_SHIFT) - offset;
> +	/* Use wmb so the compiler emits the loads first and overlaps load
> +	 * latency with reading tick, because reading %tick/%stick is a
> +	 * post-sync instruction that will flush and restart subsequent
> +	 * instructions after it commits.
> +	 */
> +	wmb();
> +
> +	return ((get_tick() * quotient) >> SPARC64_NSEC_PER_CYC_SHIFT) - offset;
>  }

I think you need to use barrier() here not wmb().

wmb() orders memory operations wrt. other memory operations.

get_tick() doesn't modify memory nor access memory, so as far as the
compiler is concerned it can still legal order the loads after
get_tick() if it really wanted to.

barrier() emits a volatile empty asm, which strictly orders all
operations before and after the barrier().
