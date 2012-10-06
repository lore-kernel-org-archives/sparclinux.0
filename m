From: David Miller <davem@davemloft.net>
Date: Sat, 06 Oct 2012 03:49:17 +0000
Subject: Re: [RESEND PATCH 1/2] sparc64: Rearrange thread info to cheaply clear syscall noerror state.
Message-Id: <20121005.234917.203688119628544532.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20121004.174812.706050126936137696.davem@davemloft.net>
In-Reply-To: <20121004.174812.706050126936137696.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Sat, 6 Oct 2012 00:26:51 +0100

> @@ -203,7 +203,7 @@ struct global_reg_snapshot {
>  extern struct global_reg_snapshot global_reg_snapshot[NR_CPUS];
>  
>  #define force_successful_syscall_return()	    \
> -do {	current_thread_info()->syscall_noerror = 1; \
> +do {	((u8 *)&current_thread_info()->flags)[TI_FLAG_BYTE_NOERROR] = 1; \
>  } while (0)
>  #define user_mode(regs) (!((regs)->tstate & TSTATE_PRIV))

Al, please at least do me the courtesy of actually looking at the
patch I posted and commited, and in particular the cleanups I made to
your original commit.  Like other bytes, this new NOERROR one should
have helpers like the other ones:

#define get_thread_noerror()		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_NOERROR])
#define set_thread_noerror(val)		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_NOERROR] = (val))

And then use set_thread_noerror(1) in force_successful_syscall_return().

I made several other adjustments, in particular in commenting the
assembler "sth" stores so that they are easily greppable for people
looking for uses of the TI_FLAG_BYTE_* defines.
