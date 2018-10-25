From: David Miller <davem@davemloft.net>
Date: Thu, 25 Oct 2018 23:39:22 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20181025.163922.819710832440506147.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 8 Oct 2018 20:42:14 +0200

> Hi Dave!
> 
> On 10/8/18 8:48 AM, David Miller wrote:
>> I've been moving so haven't had access to my Sparc boxes during this
>> time.  That's been resolved, and now I can get the patches flowing
>> again.
> Great to hear you're back!
> 
> Can I bring this bug [1] back to your attention which allowed a regular
> userland application to crash the kernel? Would be interesting to see
> whether you're able to reproduce the issue.
> 
> The offending binary is attached to the bug report. It's a test program
> from the testsuite of the Free Pascal Compiler which was recently ported
> to sparc64.
> 
> Thanks,
> Adrian
> 
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id 0625

I'm looking at this now.

I cannot reproduce the system crash, but I definitely get the illegal
instruction both with and without using strace.  And those system log
message don't show, it must be from some specific config option?
Actually I don't see that "Kernel memory exposure" string anywhere in
the standard upstream kernel.

Running under gdb the process is gone when the SIGILL arrives which
means that a signal wasn't sent but rather the process was forefully
exited by the kernel with SIGILL.

Only two things do that:

1) Failing register window faults (arch/sparc/kernel/process_64.c)
2) Invalid signal frames during signal delivery (arch/sparc/kernel/signal32,
   arch/sparc/kernel/signal_64.c)

This is a 64-bit ELF binary so my guess is setup_rt_frame().

I put some debugging in and I guessed wrong:

[   40.366945] [tweaklib2:428]: fault_in_user_windows() copy failed

Something definitely corrupted the stack and/or frame pointer in this
code.
