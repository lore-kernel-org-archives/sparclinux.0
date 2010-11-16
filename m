From: David Miller <davem@davemloft.net>
Date: Tue, 16 Nov 2010 20:01:01 +0000
Subject: Re: [PATCH] sparc64: Netra AX1105 loses console output while
Message-Id: <20101116.120101.15223441.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20101107132051.GE19881@here>
In-Reply-To: <20101107132051.GE19881@here>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Adrien Mazarguil <maz@p0d.org>
Date: Sun, 7 Nov 2010 14:20:51 +0100

> While trying recent kernels on a Sun Netra AX1105 board, I noticed that the
> boot process stopped before init had a chance to run. Using git bisect, I
> narrowed this regression down to that commit:
 ...
> On this board, the new prom_nbputchar() fails at some point in the boot
> process and no subsequent output is shown. Using either the older function
> in place of this one or a static buffer solve that issue. This seems related
> to this paragraph in the above commit log:
...
> Looks like it is still required by older boards, or maybe something else
> needs to be fixed? This is strange because everything works fine until the
> first call to schedule() just before the last assembly part of switch_to()
> macro.

Thanks for tracking down this problem.

The real issue is that on older boards, passing larger than 32-bit
addresses to prom calls (generally) doesn't work correctly.

That's why using a static variable instead of a kernel stack variable
fixes the problem.

This is a larger can of worms than just these two console I/O
routines, let me do the audit and I'll give you a patch to test.

Thanks!
