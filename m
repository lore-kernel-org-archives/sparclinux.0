From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 07 Apr 2010 01:13:10 +0000
Subject: Re: [patch 1/3] kernel: local_irq_{save,restore}_nmi()
Message-Id: <1270602790.19685.15603.camel@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100406132807.698467930@chello.nl>
	 <20100406133140.903644813@chello.nl>
In-Reply-To: <20100406133140.903644813@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: mingo@elte.hu, David Miller <davem@davemloft.net>, acme@redhat.com, paulus@samba.org, Mike Galbraith <efault@gmx.de>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, 2010-04-06 at 15:28 +0200, Peter Zijlstra wrote:

> Index: linux-2.6/kernel/trace/trace_irqsoff.c
> =================================> --- linux-2.6.orig/kernel/trace/trace_irqsoff.c
> +++ linux-2.6/kernel/trace/trace_irqsoff.c
> @@ -316,6 +316,14 @@ void trace_hardirqs_off(void)
>  }
>  EXPORT_SYMBOL(trace_hardirqs_off);
>  
> +void trace_hardirqs_off_no_nmi(void)
> +{
> +	WARN_ON_ONCE(in_nmi());

Should we do this for all archs? I can imagine a lot of warning reports
coming in the near future. And they will be passing it towards me.

-- Steve



> +	if (!preempt_trace() && irq_trace())
> +		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
> +}
> +EXPORT_SYMBOL(trace_hardirqs_off_no_nmi);
> +
>  void trace_hardirqs_on_caller(unsigned long caller_addr)
>  {
>  	if (!preempt_trace() && irq_trace())
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


