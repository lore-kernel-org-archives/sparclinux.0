From: "George Spelvin" <linux@horizon.com>
Date: Thu, 28 Apr 2016 23:15:33 +0000
Subject: Re: [patch V3] lib: GCD: add binary GCD algorithm
Message-Id: <20160428231533.17445.qmail@ns.horizon.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
In-Reply-To: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Dave Miller spake truth from on high:
> Read it again, it is patched if the cpu supports the necessary instructions
> in which case it's a very short sequence.
> 
> The actual code used when the cpu support said instruction is simply:
> 
>	neg	%o0, %g1
>	xnor	%o0, %g1, %o1
>	popc	%o1, %o0
>	retl
>	 sub	%o0, 1, %o0

D'oh!  Missed that run-time patching.  (Done by popc_patch() in
arch/sparc/kernel/setup_64.c, which is executed based on boot-time
capabilities detection.)

I'm surprised you don't use the shorter:
	sub	%o0, 1, %g1
	andn	%g1, %o0, %g1
	retl
	 popc	%g1, %o0

This kind of blows a hole in having a compile-time flag.  Which code
path to use?  It's absolutely not worth choosing gcd() implementations
at boot time.

The race is between that, plus the call and right shift, and the loop

1:	andcc	<src>, 1, %g0
	bne,a	1b
	 srl	<src>, 1, <src>
... where the branch is taken 50% of the time, so on average it
will be taken once before being not taken.
