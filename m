From: David Miller <davem@davemloft.net>
Date: Tue, 09 Dec 2008 12:12:15 +0000
Subject: Re: random dumb (or maybe not) question about sparc64
Message-Id: <20081209.041215.133030666.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200812091146.mB9Bkqn02109@elf.torek.net>
In-Reply-To: <200812091146.mB9Bkqn02109@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Chris Torek <chris.torek@windriver.com>
Date: Tue, 09 Dec 2008 04:46:52 -0700

> The ptrace code uses flushw_user() to push user windows ... good
> enough, except, a bunch of other code then also does
> synchronize_user_stack(), but ptrace does not.
> 
> So, how does this work if you happen to hit a paged-out page in
> ptrace at the perfect inopportune time?
> 
> (This depends on whether you are ptrace()ing yourself, of course,
> which is an odd thing to do.  But it might also hit if you stop a
> process that was pushing its registers to a paged-out page and once
> resumed, is going to finish copying spilled windows from the thread
> info reg_window[] array.)
> 
> There could be something obvious that I am missing, though.
> 
> (This came up as an aside while I was fussing with some moderately
> ugly stack tracing code, doing user stack traces within the kernel.)

Good catch, that is indeed a bug.

Another way to handle this would be to add a ptrace fetch operation
that allows grabbing the window buffer from the thread_info struct.

Those flushw_user() calls you see in the regset code never execute for
ptrace's normal usage (tracing another task).  The task blocks first,
then the tracing parent gets on the cpu and inspects the child reg
state.

The ptrace inferior child task switch flushes the windows as a side
effect.

We can't do this stack push unconditionally, otherwise we might
recurse.  We might be getting the signal because of a failed
window buffer save to the stack.

Perhaps the best place would be in the arch_ptrace_stop() hook.
I believe IA64 uses this for the register backing store on that
cpu.  It seems to be created exactly for the case we are discussing
here. :)

What do you think?

