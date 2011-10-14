From: David Miller <davem@davemloft.net>
Date: Fri, 14 Oct 2011 23:26:50 +0000
Subject: Re: longjmp question
Message-Id: <20111014.192650.722103046413741060.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 15 Oct 2011 00:06:53 +0100

> Replacing "flushw" with "ta 0x03" makes the problem go away. What is 
> the difference between the two? I would naively think that the effect 
> of both should be saving register windows on the stack, allocating a
> new stack frame for each of them, so fp would get adjusted in either 
> case. Then I would expect that the correct fix would be to indicate to 
> the compiler that flushw is clobbering fp/sp registers, so it cannot 
> rely on their contents afterwards. The fact that using "ta 0x03" fixes 
> it makes me feel lost again :-).

Taking a trap has a side effect, in that the %g* and %o* registers
will be saved and restored by the trap entry and exit respectively.

Trap entry also grabs a register window (for the kernel), which
is restored from on trap exit.

The register window flush is performed between this trap statesave and
restore.

Furthermore, it also means that the current register window will be
saved by the "ta 0x03" case.

This is probably why certain gdb breakpoints also make the problem go
away.

Essentially, "ta 0x03" is kind of like:

	save	%sp, -WHATEVER, %sp
	flushw
	restore

so it will restore one more register window than an actual 'flushw'
in userspace would.

I'm starting to become convinced that if you look at the stack
backtrace at the time of the flushw done by ruby, you'll see that
there are multiple stack frames using the same memory regions.

I'll try to look at this more closely myself, especially since you've
given me excellent tips on how to reproduce this and run it under gdb,
but I'm currently fighting a gcc bug which I want to clear away first.

Thanks!
