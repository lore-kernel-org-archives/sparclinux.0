From: David Miller <davem@davemloft.net>
Date: Mon, 08 Oct 2012 19:29:15 +0000
Subject: Re: [RESEND PATCH 1/2] sparc64: Rearrange thread info to cheaply clear syscall noerror state.
Message-Id: <20121008.152915.535321336835140449.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20121004.174812.706050126936137696.davem@davemloft.net>
In-Reply-To: <20121004.174812.706050126936137696.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Sat, 6 Oct 2012 07:06:09 +0100

> -		set_fs((mm_segment_t) { get_thread_current_ds() });
> +		__asm__ __volatile__ ("wr %%g0, %0, %%asi" : :
> +			"r" (current_thread_info()->current_ds ));

Please use set_fs() or create a __set_fs() if you're trying to avoid
the weird cast.  This is also indented improperly, should be:

		__asm__ __volatile__ ("wr %%g0, %0, %%asi" : :
				      "r" (current_thread_info()->current_ds ));

Also, this whole bit about rearranging thead flags is an enormous,
unnecessary, and hard to audit distraction from fixing the syscall
tracing bug.

I've decided that I don't want to keep reviewing this risky
rearrangement change, it's bitten us once already.  We can do
this in sparc-next if you want next cycle.

Could you please, instead, just rearrange the order of operations in
ret_sys_call, as needed, to purely fix the strace bug?

Thanks.
