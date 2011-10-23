From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 23 Oct 2011 13:47:27 +0000
Subject: Re: longjmp question
Message-Id: <20111023134726.GA6107@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Oct 22, 2011 at 06:54:05PM -0400, David Miller wrote:
>
> Just let the compiler do it for you, please... the compiler absolutely cannot
> optimize away a function that uses a volatile asm statement.  And it absolutely
> cannot make a function that clobbers %o7 a leaf function.

That's not what I see. I tried writing up a patch for Ruby using this, 
and here's what I get:

1. Preprocessed source of cont.c contains flush_register_windows 
definition:

# 219 "./include/ruby/defines.h"
static void
flush_register_windows(void)
{
    asm __volatile__ ("flushw" : : : "o7");
}

2. Preprocessed code of cont_save_machine_stack contains a call to 
flush_register_windows.

3. In cont.s both cont_save_machine_stack and flush_register_windows 
are completely optimized out when compiled with -O2. Relevant 
snippet:

.LL47:
        call    ruby_xmalloc2, 0
         mov    4, %o1
        ld      [%fp-12], %g3
        st      %o0, [%g3+28]
.LLBB115:
.LLBB114:
        .loc 2 222 0
#APP
! 222 "./include/ruby/defines.h" 1
        flushw
! 0 "" 2
#NO_APP
.LLBE114:
.LLBE115:
        .loc 1 353 0
        ld      [%fp-12], %g1
        sll     %i4, 2, %o2
        call    memcpy, 0
         ld     [%g1+32], %o1

In assembled form (objdump -d) it looks like this:

     54c:       40 00 00 00     call  54c <cont_capture+0x24c>
     550:       92 10 20 04     mov  4, %o1
     554:       c6 07 bf f4     ld  [ %fp + -12 ], %g3
     558:       d0 20 e0 1c     st  %o0, [ %g3 + 0x1c ]
     55c:       81 58 00 00     flushw 
     560:       c2 07 bf f4     ld  [ %fp + -12 ], %g1
     564:       95 2f 20 02     sll  %i4, 2, %o2
     568:       40 00 00 00     call  568 <cont_capture+0x268>
     56c:       d2 00 60 20     ld  [ %g1 + 0x20 ], %o1

I also tried listing the clobbered register as "%o7" instead of "o7", 
as the examples I could find prepend the register names with % in the 
clobber list. The results were the same.

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
