From: David Miller <davem@davemloft.net>
Date: Mon, 23 May 2011 03:43:15 +0000
Subject: Re: [PATCH 1/2] sparc32: fix build, fix missing cpu_relax
Message-Id: <20110522.234315.1087454235734526777.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110521212651.GA18545@merkur.ravnborg.org>
In-Reply-To: <20110521212651.GA18545@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 21 May 2011 23:26:51 +0200

>>From e8e6c6af3a369f51185012fc149629312d6b2a1c Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sat, 21 May 2011 22:55:17 +0200
> Subject: [PATCH 1/2] sparc32: fix build, fix missing cpu_relax declaration
> 
> Fix following sparc (32 bit) build error:
> 
>   CC      arch/sparc/kernel/asm-offsets.s
> In file included from include/linux/seqlock.h:29:0,
>                  from include/linux/time.h:8,
>                  from include/linux/timex.h:56,
>                  from include/linux/sched.h:57,
>                  from arch/sparc/kernel/asm-offsets.c:13:
> include/linux/spinlock.h: In function 'spin_unlock_wait':
> include/linux/spinlock.h:360:2: error: implicit declaration of function 'cpu_relax'
> 
> Most likely caused by commit e66eed651fd1 ("list: remove
> prefetching from regular list iterators") due to include
> changes.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
