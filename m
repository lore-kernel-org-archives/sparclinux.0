From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 19 Jan 2005 20:43:59 +0000
Subject: Re: FPU context and fork
Message-Id: <20050119124359.15acae9d.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <41EEB995.8070402@wp.pl>
In-Reply-To: <41EEB995.8070402@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 19 Jan 2005 21:46:40 +0100
Krzysztof Helt <krzysztof.h1@wp.pl> wrote:

> >#ifndef CONFIG_SMP
> >	if(last_task_used_math = current) {
> >#else
> >	if(current_thread_info()->flags & _TIF_USEDFPU) {
> >#endif
> >		put_psr(get_psr() | PSR_EF);
> >		fpsave(&p->thread.float_regs[0], &p->thread.fsr,
> >		       &p->thread.fpqueue[0], &p->thread.fpqdepth);
> >#ifdef CONFIG_SMP
> >		current_thread_info()->flags &= ~_TIF_USEDFPU;
> >#endif
> >	}
> >
> It is not enough or I do not understand something. The new thread will 
> have a _TIF_USEDFPU flag disabled (if not cleared here, it is cleared in 
> copy_flags() in the do_fork()). So, a FP disabled trap handler will 
> initialize FPU state from default values, not from the ones saved here. 
> BTW, the new thread is p or current in the copy_thread function? I 
> suppose it is current.

No, we are saving the "current" fpu state to the save area of "p" which
is the child thread.
