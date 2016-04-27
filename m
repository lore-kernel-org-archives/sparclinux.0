From: David Miller <davem@davemloft.net>
Date: Wed, 27 Apr 2016 19:33:55 +0000
Subject: Re: Bisected: RED State Exception in 4.5 on E420R
Message-Id: <20160427.153355.1297496599099983487.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 7 Apr 2016 11:22:10 +0300 (EEST)

>> Just got power & cooling back to my computer lab (and I'm back to 
>> reporting bugs). I have a bqacklog of things to test but on E420R I got 
>> a halt during early bootup:
> 
>> [    0.000000] Kernel: Using 5 locked TLB entries for main kernel image.
>> [    0.000000] Remapping the kernel... done.
>> 
>> RED State Exception
> 
> Bisected:
> 
> commit 1a40b95374f680625318ab61d81958e949e0afe3
> Author: Mike Frysinger <vapier@gentoo.org>
> Date:   Mon Jan 18 06:32:30 2016 -0500
> 
>     sparc: Fix system call tracing register handling.

The patch itself looks semantically correct, and I just went over it
several times.

Furthermore, we do not make system calls, let alone traced system
calls, this early in the boot.

Therefore some other aspect of the change is causing problems and I
think that aspect is the size of the new code.

There is this subtle dependency on how large the low level assembler
included by head_64.S can be.   It is coming from this expression:

/*
 * The following skip makes sure the trap table in ttable.S is aligned
 * on a 32K boundary as required by the v9 specs for TBA register.
 *
 * We align to a 32K boundary, then we have the 32K kernel TSB,
 * the 64K kernel 4MB TSB, and then the 32K aligned trap table.
 */
1:
	.skip	0x4000 + _start - 1b

Which means that all of this code cannot be more then 16K in size.

Unfortunately, having certain config options changes how large this
assembler is.  For example preemption, tracing, hugepage, and
pagealloc debug can all enable more code in these files.

The patch itself adds 28 instructions, and there are opportunities
all over this low level assembly (unused branch delay slots, etc.)
to crib those back.

I'll see what I can do and will post a test patch when I come up
with something.

Thanks.
