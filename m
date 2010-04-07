From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Wed, 07 Apr 2010 11:27:12 +0000
Subject: Re: [patch 3/3] sched: Use local_irq_save_nmi() in cpu_clock()
Message-Id: <20100407112707.GA5143@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100406132807.698467930@chello.nl> <20100406133141.039454288@chello.nl>
In-Reply-To: <20100406133141.039454288@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: mingo@elte.hu, David Miller <davem@davemloft.net>, acme@redhat.com, paulus@samba.org, Mike Galbraith <efault@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Apr 06, 2010 at 03:28:10PM +0200, Peter Zijlstra wrote:
> Since we can call cpu_clock() from NMI context fix up the IRQ
> disabling to conform to the new rules.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> ---
>  kernel/sched_clock.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/kernel/sched_clock.c
> =================================> --- linux-2.6.orig/kernel/sched_clock.c
> +++ linux-2.6/kernel/sched_clock.c
> @@ -241,9 +241,9 @@ unsigned long long cpu_clock(int cpu)
>  	unsigned long long clock;
>  	unsigned long flags;
>  
> -	local_irq_save(flags);
> +	local_irq_save_nmi(flags);
>  	clock = sched_clock_cpu(cpu);
> -	local_irq_restore(flags);
> +	local_irq_restore_nmi(flags);
>  
>  	return clock;
>  }


That seem to add a small overhead in various places.
Do we want to make local_irq_save_nmi = local_irq_save
for archs that have native nmi?

Or cpu_clock_nmi()?

