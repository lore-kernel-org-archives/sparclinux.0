From: David Miller <davem@davemloft.net>
Date: Thu, 13 Oct 2011 22:35:18 +0000
Subject: Re: longjmp question
Message-Id: <20111013.183518.758275329748186427.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Thu, 13 Oct 2011 23:06:17 +0100

> I believe that whenever flushw causes a spill trap, we are going to 
> load an incorrect source address (cont->machine_stack_src) as a second 
> memcpy argument. A couple of observations support it: if you 
> insert a breakpoint right after memcpy, you find that memory regions 
> pointed to by cont->machine_stack and cont->machine_stack_src are not 
> synchronized, as one would expect. Furthermore, breaking anywhere 
> *before* will make the problem magically go away (perhaps because gdb 
> flushes register windows itself on breakpoints, and then flushw in 
> cont_capture is effectively a noop?)
> 
> I hope it makes at least some sense :-).

Good detective work, did I mention that this Ruby continuation stuff
is extremely fragile?

Can you show me what values %sp and %fp have right before the flushw
is executed?

The effect of taking a breakpoint right before the flushw ought to
be the same as executing a flushw.  When a process being debugged
by GDB takes a breakpoint, we flush all the user register windows
out of the cpu and onto the process stack, the wake up the parent
(GDB) and context switch.

Obviously, something different is happening when you just let the
flushw execute without an immediately preceeding breakpoint, so
we have to figure out exactly what that is :-)

Something you might want to try, compile cont.c into an assembler
file cont.s, then insert the following around the flushw

	mov	%fp, %g1
	flushw
	mov	%fp, %g2

Then compile that into an object and link up ruby.

In the debugger, breakpoint right after that "mov %fp, %g2" and
print out from GDB the values of %g1 and %g2.  This might give
some hints as to what's going on exactly.

Another test, go into Ruby's defines.h and get rid of the:

# if defined(__sparc_v9__) || defined(__sparcv9) || defined(__arch64__)
        ("flushw")
# else

and make it always use "ta 0x03" instead of "flushw".  This might
explain why the Ruby developers can't reproduce this on Solaris.  That
could happen if for some reason their Solaris build isn't setting the
defines that guard the flushw instruction usage.

If using "ta 0x03" instead of "flushw" makes a difference that would
be a huge clue.

Thanks!
