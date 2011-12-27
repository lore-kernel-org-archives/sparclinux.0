From: David Miller <davem@davemloft.net>
Date: Tue, 27 Dec 2011 21:37:29 +0000
Subject: Re: [PATCH] sparc32: support atomic64_t
Message-Id: <20111227.163729.673688193723480549.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111227212850.GA8174@merkur.ravnborg.org>
In-Reply-To: <20111227212850.GA8174@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 27 Dec 2011 22:28:50 +0100

>>From 8d3ccd703b99564b119a6ddb4127c31f8f2fece3 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Tue, 27 Dec 2011 21:46:53 +0100
> Subject: [PATCH] sparc32: support atomic64_t
> 
> There is no-one that really require atomic64_t support on sparc32.
> But several drivers fails to build without proper atomic64 support.
> And for an allyesconfig build for sparc32 this is annoying.
> 
> Include the generic atomic64_t support for sparc32.
> This has a text footprint cost:
> 
> $size vmlinux (before atomic64_t support)
>    text    data     bss     dec     hex filename
> 3578860  134260  108781 3821901  3a514d vmlinux
> 
> $size vmlinux (after atomic64_t support)
>    text    data     bss     dec     hex filename
> 3579892  130684  108781 3819357  3a475d vmlinux
> 
> text increase (3579892 - 3578860) = 1032 bytes
> 
> data decreases - but I fail to explain why!
> I have rebuild twice to check my numbers.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied to sparc-next, thanks.

The data decreasing is really funny indeed, it should
increase because of the atomic64_lock[] array in lib/atomic64.c

And the decrease isn't some trivial amount, it's more than 3K!

