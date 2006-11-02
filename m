From: Fabio Massimo Di Nitto <fabbione@ubuntu.com>
Date: Thu, 02 Nov 2006 17:05:54 +0000
Subject: Re: T1000 CPU lockups
Message-Id: <454A2572.4020006@ubuntu.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200611011449.37829.dennis@ausil.us>
In-Reply-To: <200611011449.37829.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David,

the patch does indeed fix the problem. I was able to build glibc-2.5 all the way
trough on Niagara. I am CC Ben and Martin because we need this in .17 kernels
too. A similar bug has been found on PPC and it has been escalated to local DoS
since any user can actually kill a system just running the test suite.

Thanks
Fabio

David Miller wrote:
> From: Dennis Gilmore <dennis@ausil.us>
> Date: Wed, 1 Nov 2006 14:49:37 -0600
> 
>> I have had  my T1000 lockup intermittently.  I'm running a vanilla 2.6.18 
>> kernel.   I get in the system logs for quite a few of the cpu's
>>
>> Oct 31 20:58:19 daedalus kernel: BUG: soft lockup detected on CPU#21!
>> Oct 31 20:58:19 daedalus kernel: Call Trace:
>> Oct 31 20:58:20 daedalus kernel:  [00000000004319f4] 
>> smp_percpu_timer_interrupt+0xd4/0x144
>> Oct 31 20:58:20 daedalus kernel:  [00000000004109d4] tl0_irq14+0x1c/0x20
>> Oct 31 20:58:20 daedalus kernel:  [0000000000468f28] futex_lock_pi+0x130/0x7cc
>> Oct 31 20:58:20 daedalus kernel:  [000000000046a154] do_futex+0xb90/0xbbc
>> Oct 31 20:58:20 daedalus kernel:  [000000000046a6f4] 
>> compat_sys_futex+0x11c/0x130
>> Oct 31 20:58:20 daedalus kernel:  [0000000000406c94] 
>> linux_sparc_syscall32+0x3c/0x40
>> Oct 31 20:58:20 daedalus kernel:  [00000000701004b0] 0x701004b8
>>
>> after these. while the system stays alive  I cant actually do anything 
> 
> I think Fabbione was seeing this one too, CC:'d for more testing.
> 
> This patch below should fix it, thanks for the most excellent bug
> report.
> 
> diff --git a/include/asm-sparc64/futex.h b/include/asm-sparc64/futex.h
> index dee4020..7392fc4 100644
> --- a/include/asm-sparc64/futex.h
> +++ b/include/asm-sparc64/futex.h
> @@ -87,24 +87,22 @@ static inline int
>  futex_atomic_cmpxchg_inatomic(int __user *uaddr, int oldval, int newval)
>  {
>  	__asm__ __volatile__(
> -	"\n1:	lduwa	[%2] %%asi, %0\n"
> -	"2:	casa	[%2] %%asi, %0, %1\n"
> -	"3:\n"
> +	"\n1:	casa	[%3] %%asi, %2, %0\n"
> +	"2:\n"
>  	"	.section .fixup,#alloc,#execinstr\n"
>  	"	.align	4\n"
> -	"4:	ba	3b\n"
> -	"	 mov	%3, %0\n"
> +	"3:	ba	2b\n"
> +	"	 mov	%4, %0\n"
>  	"	.previous\n"
>  	"	.section __ex_table,\"a\"\n"
>  	"	.align	4\n"
> -	"	.word	1b, 4b\n"
> -	"	.word	2b, 4b\n"
> +	"	.word	1b, 3b\n"
>  	"	.previous\n"
> -	: "=&r" (oldval)
> -	: "r" (newval), "r" (uaddr), "i" (-EFAULT)
> +	: "=r" (newval)
> +	: "0" (newval), "r" (oldval), "r" (uaddr), "i" (-EFAULT)
>  	: "memory");
>  
> -	return oldval;
> +	return newval;
>  }
>  
>  #endif /* !(_SPARC64_FUTEX_H) */


-- 
I'm going to make him an offer he can't refuse.
