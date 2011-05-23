From: David Miller <davem@davemloft.net>
Date: Mon, 23 May 2011 03:43:26 +0000
Subject: Re: [PATCH 2/2] sparc32: fix build, move inline function to .c file
Message-Id: <20110522.234326.1984521449818826938.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110521212758.GB18545@merkur.ravnborg.org>
In-Reply-To: <20110521212758.GB18545@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 21 May 2011 23:27:58 +0200

>>From 875da4871c4654390d41aa110480211ccbd2aac2 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sat, 21 May 2011 22:59:19 +0200
> Subject: [PATCH 2/2] sparc32: fix build, move inline function to .c file
> 
> Fix following build eroor:
> 
>   CC      arch/sparc/kernel/irq_32.o
> In file included from arch/sparc/include/asm/smp.h:6:0,
>                  from arch/sparc/include/asm/system_32.h:12,
>                  from arch/sparc/include/asm/system.h:6,
>                  from arch/sparc/include/asm/ptrace.h:235,
>                  from arch/sparc/include/asm/thread_info_32.h:19,
>                  from sparc/include/asm/thread_info.h:6,
>                  from include/linux/thread_info.h:53,
>                  from include/linux/preempt.h:9,
>                  from include/linux/smp.h:34,
>                  from include/linux/kernel_stat.h:4,
>                  from arch/sparc/kernel/irq_32.c:14:
> arch/sparc/include/asm/smp_32.h:82:19: error: static declaration of 'smp_call_function_single' follows non-static declaration
> include/linux/smp.h:29:5: note: previous declaration of 'smp_call_function_single' was here
> 
> Bug is likely triggered by changes in include files.
> The fix was obviously correct so I found no value in tracking
> down the offending commit.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
