From: David Miller <davem@davemloft.net>
Date: Sat, 10 Mar 2007 08:29:44 +0000
Subject: Re: [PATCH] Fix sparc TIF_USEDFPU flag atomicity
Message-Id: <20070310.002944.115909724.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070310081743.GC23144@Krystal>
	<20070310082646.GC2994@holomorphy.com>
In-Reply-To: <20070310082646.GC2994@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wli@holomorphy.com
Cc: mathieu.desnoyers@polymtl.ca, akpm@linux-foundation.org, mbligh@google.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: William Lee Irwin III <wli@holomorphy.com>
Date: Sat, 10 Mar 2007 00:26:46 -0800

> On Sat, Mar 10, 2007 at 03:17:43AM -0500, Mathieu Desnoyers wrote:
> > @@ -348,7 +348,7 @@ void exit_thread(void)
> >  #ifndef CONFIG_SMP
> >  	if(last_task_used_math = current) {
> >  #else
> > -	if(current_thread_info()->flags & _TIF_USEDFPU) {
> > +	if(test_ti_thread_flag(current_thread_info(), TIF_USEDFPU)) {
> >  #endif
> >  		/* Keep process from leaving FPU in a bogon state. */
> >  		put_psr(get_psr() | PSR_EF);
> 
> Oh dear. Could we bit a bit more idiomatic here? For instance,
> something like:

Ok I pulled the sparc32 patch back out until there is some
consensus here :)

