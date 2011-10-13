From: Jurij Smakov <jurij@wooyd.org>
Date: Thu, 13 Oct 2011 22:06:17 +0000
Subject: Re: longjmp question
Message-Id: <20111013220617.GA4711@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Oct 12, 2011 at 07:42:28PM -0400, David Miller wrote:
> From: Jurij Smakov <jurij@wooyd.org>
> Date: Thu, 13 Oct 2011 00:21:28 +0100
> 
> > On Wed, Oct 12, 2011 at 07:06:17PM -0400, David Miller wrote:
> >> 
> >> Jurij, how do I setup this testcase?
> >> 
> >> I checked out Ruby from SVN and built it, but I can't find this
> >> miniruby thing so that I can run the command line in that Ruby bug
> >> report.
> >> 
> >> Thanks.
> > 
> > Thanks for looking at it! Attached is a script which I use to set up 
> > the environment and start gdb for the binary (you probably will need 
> > directory names adjusted, if you are building from directly from svn 
> > and not from Debian package). I'm still in the process of trying to 
> > understand what's Ruby is trying to do with all the machine state 
> > saves and restores, so I was not able to make a lot of progress so 
> > far.
> 
> Thanks for the script.
> 
> Ruby is too clever for it's own good.  Right before it calls setjmp()
> it copies the stack frame down to the current bottom of the stack
> into a save area.
> 
> Later, right before it longjmp()'s, it copies back to the stack from
> the save area.
> 
> Look at the "workaround" for x86-86 in cont_restore_1(), and all of
> the special case code they need in order to get IA64 right.
> 
> What a mess.
> 
> This is only going to get worse when GCC's support for shrink-wrapping
> and other interesting features propagates.  There is no guarentee that
> the stack won't expand further downward between when Ruby saves the
> stack frames and when it does it's setjmp() call, and it very much
> relies upon that such a stack expansion not happening.
> 
> Anyways I'll see if there is some way to salvage this and make it
> work.  I suspect that Solaris doesn't have the restore loop
> optimization we do in longjmp, and that's why Ruby works there with
> the same compilers on sparc.

I think I've figured it out (famous last words :-). The problem 
appears to be in cont_save_machine_stack in cont.c. The part where new 
memory is allocated and the machine state is saved using memcpy from
cont->machine_stack_src to cont->machine_stack generates the following 
assembler code:

   0xf7f4d728 <+584>:   mov  %i4, %o0                           // %o0 = 437, size of memory to allocate in words
   0xf7f4d72c <+588>:   call  0xf7fb4004 <ruby_xmalloc2@plt>
   0xf7f4d730 <+592>:   mov  4, %o1                             // %o1 = 4, word size
   0xf7f4d734 <+596>:   ld  [ %fp + -12 ], %g3                  // load 'cont' address into g3.
=> 0xf7f4d738 <+600>:   st  %o0, [ %g3 + 0x1c ]                 // %o0 contains the address returned by ruby_xmalloc2, store it in cont->machine_stack
   0xf7f4d73c <+604>:   flushw                                  // flush register windows
   0xf7f4d740 <+608>:   ld  [ %fp + -12 ], %g1                  // load 'cont' address into g1. But flushw might have caused a spill trap and changed fp!
   0xf7f4d744 <+612>:   sll  %i4, 2, %o2                        // 437*4, total amount of memory to copy, goes into o2, third arg for memcpy
   0xf7f4d748 <+616>:   call  0xf7fb2b1c <memcpy@plt>
   0xf7f4d74c <+620>:   ld  [ %g1 + 0x20 ], %o1                 // we load what we think to be cont->machine_stack_src into second arg
   0xf7f4d750 <+624>:   ld  [ %fp + -12 ], %g2
   0xf7f4d754 <+628>:   call  0xf7fb29b4 <_setjmp@plt>
   0xf7f4d758 <+632>:   add  %g2, 0x278, %o0
   0xf7f4d75c <+636>:   cmp  %o0, 0

I believe that whenever flushw causes a spill trap, we are going to 
load an incorrect source address (cont->machine_stack_src) as a second 
memcpy argument. A couple of observations support it: if you 
insert a breakpoint right after memcpy, you find that memory regions 
pointed to by cont->machine_stack and cont->machine_stack_src are not 
synchronized, as one would expect. Furthermore, breaking anywhere 
*before* will make the problem magically go away (perhaps because gdb 
flushes register windows itself on breakpoints, and then flushw in 
cont_capture is effectively a noop?)

I hope it makes at least some sense :-).

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
