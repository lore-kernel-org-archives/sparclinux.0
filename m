From: "George Spelvin" <linux@horizon.com>
Date: Sat, 07 May 2016 22:30:18 +0000
Subject: Re: [patch V4] lib: GCD: Use binary GCD algorithm instead of Euclidean
Message-Id: <20160507223018.17111.qmail@ns.horizon.com>
List-Id: <sparclinux.vger.kernel.org>
In-Reply-To: <20160507112308.GA2612@ravnborg.org>
References: <1462527763-15301-1-git-send-email-zengzhaoxiu@163.com>
In-Reply-To: <1462527763-15301-1-git-send-email-zengzhaoxiu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org, zengzhaoxiu@163.com
Cc: akpm@linux-foundation.org, linux@horizon.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Sam Ravnborg wrote:
> sparc64 have an efficient ffs implementation.
> We use run-time patching to use the proper version
> depending on the actual sparc cpu.
> 
> As this is determinded at config time, then let the
> sparc cpu that has the efficient ffs benefit from this.
> 
> In other words - select CPU_NO_EFFICIENT_FFS only for SPARC32.

I'm not sure this is the right thing.

It's always a function call, and there's boot-time code patching to use
either an unrolled binary search or a POPC instructon on processors that
have that instruction.

The NO_EFFICIENT_FFS isn't much slower than the __ffs version, so the
call/return alone might eat the difference, and if the CPU doesn't have
POPC support it's definitely a lose.

Quite simply, gcd isn't important enough to be worth the same boot-time
code patching, and if we have to use one on both types of CPU the the
NO_EFFICIENT_FFS path is the safer alternative in case of uncertainty.

Would you be willing to try benchmarking it?  The baseline code, plus two
versions of the __ffs code using the two different __ffs implementations
(forced out of line by compiling from assembler source or using
inine asm and __attribute((noinline))).



By the way, the SPARC64 implementation could be improved.

It's currently 5 instructions:

__ffs:
        neg     %o0, %g1
        xnor    %o0, %g1, %o1
        popc    %o1, %o0
        retl
         sub    %o0, 1, %o0

That could be improved to 4:
	sub	%o0, 1, %g1
	andn	%g1, %o0, %g1
	retl
	 popc	%g1, %o0
