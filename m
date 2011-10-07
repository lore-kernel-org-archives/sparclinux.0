From: Jurij Smakov <jurij@wooyd.org>
Date: Fri, 07 Oct 2011 23:22:10 +0000
Subject: longjmp question
Message-Id: <20111007232209.GA11892@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

Over the last few days I had some quality time trying to track down 
the segfault in one of Ruby tests, involving continuations (which are 
implemented on top of setjmp/longjmp):

http://redmine.ruby-lang.org/issues/5244

After lots of experiments I came to a conclusion that something is 
wrong with libc (eglibc in this case) implementation of longjmp. In 
particular, this code from sysdeps/sparc/sparc32/__longjmp.S is used 
to perform the longjmp in the Ruby test:

[...]
#define RW_FP [%fp + 0x48]

ENTRY(__longjmp)
        /* Store our arguments in global registers so we can still
           use them while unwinding frames and their register windows.  */

        ld ENV(o0,JB_FP), %g3   /* Cache target FP in register %g3.  */
#ifdef PTR_DEMANGLE
        PTR_DEMANGLE (%g3, %g3, %g4)
#endif
[...]
LOC(thread):
        /*
         * Do a "flush register windows trap".  The trap handler in the
         * kernel writes all the register windows to their stack slots, and
         * marks them all as invalid (needing to be sucked up from the
         * stack when used).  This ensures that all information needed to
         * unwind to these callers is in memory, not in the register
         * windows.
         */
        ta      ST_FLUSH_WINDOWS
#ifdef PTR_DEMANGLE
        ld      ENV(g1,JB_PC), %g5 /* Set return PC. */
        ld      ENV(g1,JB_SP), %g1 /* Set saved SP on restore below. */
        PTR_DEMANGLE2 (%o7, %g5, %g4)
        PTR_DEMANGLE2 (%fp, %g1, %g4)
#else
        ld      ENV(g1,JB_PC), %o7 /* Set return PC. */
        ld      ENV(g1,JB_SP), %fp /* Set saved SP on restore below. */
#endif
        sub     %fp, 64, %sp    /* Allocate a register frame. */
        st      %g3, RW_FP      /* Set saved FP on restore below. */
        retl
         restore %g2, 0, %o0    /* Restore values from above register frame. */

At the end of the procedure %g3 contains the target (post-jump) frame 
pointer address, which we would like to end up in %fp as a result of 
restore instruction in the retl delay slot. To that end we write it to 
a location determined by RW_FP, which is [%fp + 0x48]. However, 
according to http://www.sics.se/~psm/sparcstack.html, which nicely 
describes the layout of registers in memory and the effect of 
save/restore operations, the post-restore frame pointer value should 
be located at [%fp + 0x38], as we are only saving 16 word-sized 
registers, and %fp is 15-th out of them (see Figure 4), so offset 
should be 14 * 4 = 56 = 0x38. I'm not sure whether if that's just an 
off-by-0x10, or I don't understand how this things work - anyone has 
any ideas?
 
There are a lot of things here I don't understand. For example, Ruby 
test only fails if the code is compiled with -O2, but works with -O0,
and with -O0 we get the correct value of target frame pointer at
[%fp + 0x38], so it does not matter whether we write another one at
the "wrong" location. With -O2 though the memory layout is different, 
and we end up with broken value at [%fp + 0x38], and this is what gets 
restored into %fp, eventually causing a segfault. Also, it's probably 
not the whole story, because after changing the offset to 0x38 I still 
get a test failure, but it now segfaults in a different place. I could 
not, however, explain the 0x48 vs 0x38 discrepancy, so taking things 
one step at a time here :-).

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
