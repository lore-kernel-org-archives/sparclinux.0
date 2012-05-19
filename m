From: David Miller <davem@davemloft.net>
Date: Sat, 19 May 2012 22:25:52 +0000
Subject: Re: [RFC PATCH] sparc32: make srmmu helpers leon compatible
Message-Id: <20120519.182552.1859715171254759693.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120519200321.GA7617@merkur.ravnborg.org>
In-Reply-To: <20120519200321.GA7617@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 19 May 2012 22:03:21 +0200

> Could we call per_cpu_patch() before paging_init() maybe?

You definitely want to patch this since it's just the ASI value in the
loads and stores.

But the reason we have to invoke per_cpu_patch() after paging_init() is
that we need the cache flushing operations hooked up.

Otherwise we can't flush the instruction cache properly.

Actually...

The way we do that now is overkill.  We only needed to use the MMU
cache ops when we had sun4c around because sun4c lacked support for
the "flush" instruction.

But all sun4m and later chips have it so we can use it
unconditionally.

So in the per_cpu_patch() code, get rid of the cache ops invocation,
and instead execute a "flush %reg" after each of the instruction patch
assignments, where %reg is set to the address of the instruction that
was stored into.

Perhaps take the flushi() definition from asm/cacheflush_64.h and
place it into asm/cacheflush.h, then you can simply use that.

We can then use it to do things like make kprobes and jump_label
work on sparc32.
