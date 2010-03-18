From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Thu, 18 Mar 2010 19:50:26 +0000
Subject: Re: [BUG] percpu misaligned allocation
Message-Id: <20100318195023.GE5103@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100318044930.GC5045@nowhere> <4BA1F2BA.30604@kernel.org>
In-Reply-To: <4BA1F2BA.30604@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tejun Heo <tj@kernel.org>
Cc: Sparc <sparclinux@vger.kernel.org>, David Miller <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>

On Thu, Mar 18, 2010 at 06:30:34PM +0900, Tejun Heo wrote:
> Hello,
> 
> On 03/18/2010 01:49 PM, Frederic Weisbecker wrote:
> > Hi,
> > 
> > While using the lock events through perf in a sparc box, I can see
> > the following message repeated many times:
> > 
> > 	Kernel unaligned access at TPC[49357c] perf_trace_lock_acquire+0xb4/0x180
> > 
> > It actually hangs the box as the messages are sent to a serial console.
> > 
> > When used with perf, the trace events use a per cpu buffer allocated
> > in kernel/trace/trace_event_perf.c, and the allocation appears to return
> > a misaligned percpu pointer. It is aligned to 4 while it seems it
> > requires to be aligned to 8.
> 
> Does this fix the problem?
> 
> diff --git a/kernel/trace/trace_event_profile.c b/kernel/trace/trace_event_profile.c
> index c1cc3ab..d3f7d1b 100644
> --- a/kernel/trace/trace_event_profile.c
> +++ b/kernel/trace/trace_event_profile.c
> @@ -27,13 +27,15 @@ static int ftrace_profile_enable_event(struct ftrace_event_call *event)
>  		return 0;
>  
>  	if (!total_profile_count) {
> -		buf = (char *)alloc_percpu(perf_trace_t);
> +		buf = (char *)__alloc_percpu(sizeof(perf_trace_t),
> +					     __alignof__(unsigned long));
>  		if (!buf)
>  			goto fail_buf;
>  
>  		rcu_assign_pointer(perf_trace_buf, buf);
>  
> -		buf = (char *)alloc_percpu(perf_trace_t);
> +		buf = (char *)__alloc_percpu(sizeof(perf_trace_t),
> +					     __alignof__(unsigned long));
>  		if (!buf)
>  			goto fail_buf_nmi;


Yep, it does the trick.

In case you test, I have two other misalignments, one is in
perf_trace_buf_prepare but it is my bad and it is nothing
related to percpu. I'm going to fix it.
Another is in the ring buffer and Steve has a pending fix.

Thanks.

