From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Wed, 19 Jan 2005 20:46:40 +0000
Subject: Re: FPU context and fork
Message-Id: <41EEC730.2000603@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <41EEB995.8070402@wp.pl>
In-Reply-To: <41EEB995.8070402@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David S. Miller wrote:

>On Wed, 19 Jan 2005 20:48:37 +0100
>Krzysztof Helt <krzysztof.h1@wp.pl> wrote:
>
>  
>
>>How  should it be done?  Should copy_flags() during do_fork() preserve 
>>FPU context/registers for child task? Should SMP and UP context 
>>switching be handled differently?
>>    
>>
>
>copy_thread(), via do_fork(), copies the FPU state in this code here:
>
>#ifndef CONFIG_SMP
>	if(last_task_used_math = current) {
>#else
>	if(current_thread_info()->flags & _TIF_USEDFPU) {
>#endif
>		put_psr(get_psr() | PSR_EF);
>		fpsave(&p->thread.float_regs[0], &p->thread.fsr,
>		       &p->thread.fpqueue[0], &p->thread.fpqdepth);
>#ifdef CONFIG_SMP
>		current_thread_info()->flags &= ~_TIF_USEDFPU;
>#endif
>	}
>
>  
>
It is not enough or I do not understand something. The new thread will 
have a _TIF_USEDFPU flag disabled (if not cleared here, it is cleared in 
copy_flags() in the do_fork()). So, a FP disabled trap handler will 
initialize FPU state from default values, not from the ones saved here. 
BTW, the new thread is p or current in the copy_thread function? I 
suppose it is current.

Krzysztof

