From: David Miller <davem@davemloft.net>
Date: Tue, 22 Aug 2017 20:48:07 +0000
Subject: Re: arch/sparc/kernel/nmi.c: warning: array subscript is above array bounds
Message-Id: <20170822.134807.637888043411074729.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1708222221270.23061@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1708222221270.23061@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Tue, 22 Aug 2017 22:25:12 +0300 (EEST)

> Just noticed this scroll away when compiling todays 4.13-rc5+git on a 
> sparc64 machine with old debian gcc version 4.9.2 (Debian 4.9.2-1).
> 
>   CC      arch/sparc/kernel/nmi.o
> In file included from ./include/linux/compiler.h:58:0,
>                  from ./include/uapi/linux/stddef.h:1,
>                  from ./include/linux/stddef.h:4,
>                  from ./include/uapi/linux/posix_types.h:4,
>                  from ./include/uapi/linux/types.h:13,
>                  from ./include/linux/types.h:5,
>                  from ./include/linux/proc_fs.h:7,
>                  from kernel/cpu.c:6:
> kernel/cpu.c: In function 'cpu_up':
> ./arch/sparc/include/asm/percpu_64.h:13:13: warning: array subscript is above array bounds [-Warray-bounds]
>   (trap_block[(__cpu)].__per_cpu_base)

trap_block[] is an array of size NR_CPUS.

We are feeding a variable 'cpu' into this array index.

I can't see how the compiler can say whether the array subscript is
above the array bounds or not.  It lacks sufficient information to
determine this for sure.

I would just ignore this for now.

Your subject line should have been "kernel/cpu.c: ..." instead of
"arch/sparc/kernel/nmi.c" btw.
