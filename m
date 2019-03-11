From: David Miller <davem@davemloft.net>
Date: Mon, 11 Mar 2019 23:13:13 +0000
Subject: Re: [PATCH 12/14] sparc64: rtrap: Remove unneeded need_resched() loop
Message-Id: <20190311.161313.458909688496508375.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190311224752.8337-1-valentin.schneider@arm.com>
        <20190311224752.8337-13-valentin.schneider@arm.com>
In-Reply-To: <20190311224752.8337-13-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: valentin.schneider@arm.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>
Date: Mon, 11 Mar 2019 22:47:50 +0000

> Since the enabling and disabling of IRQs within preempt_schedule_irq()
> is contained in a need_resched() loop, we don't need the outer arch
> code loop.
> 
> We seem to be looping back somewhere much higher than the usual
> preempt/need_resched checks, but AFAICT we would just branch to
> 'rtrap_no_irq_enable' and then back to 'to_kernel', which is
> a need_resched() loop with a few extra steps.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> ---
>  arch/sparc/kernel/rtrap_64.S | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
> index 29aa34f11720..57fb75686957 100644
> --- a/arch/sparc/kernel/rtrap_64.S
> +++ b/arch/sparc/kernel/rtrap_64.S
> @@ -322,7 +322,6 @@ to_kernel:
>  		 nop
>  		call			preempt_schedule_irq
>  		 nop
> -		ba,pt			%xcc, rtrap
>  #endif
>  kern_fpucheck:	ldub			[%g6 + TI_FPDEPTH], %l5
>  		brz,pt			%l5, rt_continue
> -- 
> 2.20.1
> 

We must re-evaluate the %tstate value stored in ptregs, you cannot
make this change.
