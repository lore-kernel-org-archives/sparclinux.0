From: Meelis Roos <mroos@ut.ee>
Date: Sun, 14 Sep 2008 15:43:38 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <Pine.SOC.4.64.0809141842150.19219@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > {7} ok .registers
> >         Normal          Alternate       MMU               Vector
> > 0:                 0                0                0                0
> > 1:            781100                6         fff9f6d0 ffffffffffffffff
> > 2:            798c00      1ccf8207c08         f0000000         f0000000
> > 3:          fffd0000                1                1         fffd0000
> > 4:          deadbeef      1ccf8207c10                1         f004c99c
> > 5:          deadbeef                1                f               aa
> > 6:          deadbeef           200000         fffd0000         fff9f000
> > 7:                10                0               68                7
> > %PC  5813c0 %nPC 5813c4
> > %TBA f0000000 %CCR 44 XCC:nZvc   ICC:nZvc
> 
> Can you go into your build tree and say:
> 
> bash$ gdb ./vmlinux
> (gdb) x/10i 0x5813c0

(gdb) x/10i 0x5813c0
0x5813c0 <mcount>:      ldub  [ %g6 + 0xc ], %g1
0x5813c4 <mcount+4>:    srl  %g1, 1, %g3
0x5813c8 <mcount+8>:    inc  %g3
0x5813cc <mcount+12>:   sllx  %g3, 8, %g3
0x5813d0 <mcount+16>:   add  %g3, 0xc0, %g3
0x5813d4 <mcount+20>:   add  %g6, %g3, %g3
0x5813d8 <mcount+24>:   sub  %g3, 0x7ff, %g3
0x5813dc <mcount+28>:   cmp  %sp, %g3
0x5813e0 <mcount+32>:   bg  %xcc, 0x581480 <mcount+192>
0x5813e4 <mcount+36>:   nop
(gdb)
0x5813e8 <mcount+40>:   lduh  [ %g6 + 0x3e ], %g1
0x5813ec <mcount+44>:   sethi  %hi(0x824400), %g3
0x5813f0 <mcount+48>:   or  %g3, 0x268, %g3     ! 0x824668 <hardirq_stack>
0x5813f4 <mcount+52>:   sllx  %g1, 3, %g1
0x5813f8 <mcount+56>:   ldx  [ %g3 + %g1 ], %g7
0x5813fc <mcount+60>:   sub  %g7, 0x7ff, %g7
0x581400 <mcount+64>:   cmp  %sp, %g7
0x581404 <mcount+68>:   bleu  %xcc, 0x581418 <mcount+88>
0x581408 <mcount+72>:   sethi  %hi(0x4000), %g3
0x58140c <mcount+76>:   add  %g7, %g3, %g7
(gdb)
0x581410 <mcount+80>:   cmp  %sp, %g7
0x581414 <mcount+84>:   bcs,pn   %xcc, 0x581480 <mcount+192>
0x581418 <mcount+88>:   sethi  %hi(0x824800), %g3
0x58141c <mcount+92>:   or  %g3, 0x68, %g3      ! 0x824868 <softirq_stack>
0x581420 <mcount+96>:   ldx  [ %g3 + %g1 ], %g7
0x581424 <mcount+100>:  cmp  %sp, %g7
0x581428 <mcount+104>:  bleu  %xcc, 0x581468 <mcount+168>
0x58142c <mcount+108>:  sethi  %hi(0x4000), %g3
0x581430 <mcount+112>:  add  %g7, %g3, %g7
0x581434 <mcount+116>:  cmp  %sp, %g7
(gdb)
0x581438 <mcount+120>:  bcs,pn   %xcc, 0x581480 <mcount+192>
0x58143c <mcount+124>:  nop
0x581440 <mcount+128>:  sethi  %hi(0x799000), %g7
0x581444 <mcount+132>:  or  %g7, 0x28, %g7      ! 0x799028 <ovstack>
0x581448 <mcount+136>:  add  %g7, -4096, %g3
0x58144c <mcount+140>:  sub  %g3, 0x8bf, %g3
0x581450 <mcount+144>:  sub  %g7, 0x7ff, %g7
0x581454 <mcount+148>:  cmp  %sp, %g7
0x581458 <mcount+152>:  bcs,pn   %xcc, 0x581468 <mcount+168>
0x58145c <mcount+156>:  cmp  %sp, %g3


-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
