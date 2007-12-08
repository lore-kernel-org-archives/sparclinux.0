From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Sat, 08 Dec 2007 09:17:12 +0000
Subject: Re: 2.6.24-rc4-mm1: undefined reference to `compat_sys_timerfd' on sparc64
Message-Id: <200712081017.13347.m.kozlowski@tuxland.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <20071204211701.994dfce6.akpm@linux-foundation.org> <200712080104.55619.m.kozlowski@tuxland.pl> <20071207160800.77e7e907.akpm@linux-foundation.org>
In-Reply-To: <20071207160800.77e7e907.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org


> >   LD      .tmp_vmlinux1
> > arch/sparc64/kernel/head.o: In function `sys_call_table32':
> > arch/sparc64/kernel/head.S:(.text+0x224e0): undefined reference to `compat_sys_timerfd'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> argh, sorry, I am soooooo fed up with fixing that patch.
> 
> --- a/arch/sparc64/kernel/systbls.S~timerfd-v3-new-timerfd-api-sparc64-fix
> +++ a/arch/sparc64/kernel/systbls.S
> @@ -80,7 +80,7 @@ sys_call_table32:
>  	.word sys_fchmodat, sys_faccessat, compat_sys_pselect6, compat_sys_ppoll, sys_unshare
>  /*300*/	.word compat_sys_set_robust_list, compat_sys_get_robust_list, compat_sys_migrate_pages, compat_sys_mbind, compat_sys_get_mempolicy
>  	.word compat_sys_set_mempolicy, compat_sys_kexec_load, compat_sys_move_pages, sys_getcpu, compat_sys_epoll_pwait
> -/*310*/	.word compat_sys_utimensat, compat_sys_signalfd, compat_sys_timerfd, sys_eventfd, compat_sys_fallocate
> +/*310*/	.word compat_sys_utimensat, compat_sys_signalfd, sys_ni_syscall, sys_eventfd, compat_sys_fallocate
>  
>  #endif /* CONFIG_COMPAT */

Ok - that helped.

Thanks,

	Mariusz
