From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 19 Jan 2005 20:25:51 +0000
Subject: Re: FPU context and fork
Message-Id: <20050119122551.30e4342f.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <41EEB995.8070402@wp.pl>
In-Reply-To: <41EEB995.8070402@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 19 Jan 2005 20:48:37 +0100
Krzysztof Helt <krzysztof.h1@wp.pl> wrote:

> How  should it be done?  Should copy_flags() during do_fork() preserve 
> FPU context/registers for child task? Should SMP and UP context 
> switching be handled differently?

copy_thread(), via do_fork(), copies the FPU state in this code here:

#ifndef CONFIG_SMP
	if(last_task_used_math = current) {
#else
	if(current_thread_info()->flags & _TIF_USEDFPU) {
#endif
		put_psr(get_psr() | PSR_EF);
		fpsave(&p->thread.float_regs[0], &p->thread.fsr,
		       &p->thread.fpqueue[0], &p->thread.fpqdepth);
#ifdef CONFIG_SMP
		current_thread_info()->flags &= ~_TIF_USEDFPU;
#endif
	}
