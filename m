From: "Bernhard R. Link" <brlink@debian.org>
Date: Sun, 14 Feb 2010 20:49:31 +0000
Subject: Re: soft lookup
Message-Id: <20100214204931.GA18453@pcpool00.mathematik.uni-freiburg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20100213170856.GA8334@pcpool00.mathematik.uni-freiburg.de>
In-Reply-To: <20100213170856.GA8334@pcpool00.mathematik.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

* David Miller <davem@davemloft.net> [100214 19:45]:
> > Looking at some of the addresses and a disassembled kernel, that seems
> > to be in sparc64_realfault_common within sparc64_realfault_common
> > within for example a call in setup_frame32 (inlined in do_signal32),
> > so I guess this is related to the signal stack misalignment and will
> > retest once I have a kernel with those patches applied.
> 
> It has nothing to do with that.
> 
> For some reason the fault isn't being resolved by the fault
> handler, so we keep faulting forever on the same instruction.

One fault that I looked at (this time with linux-image-2.6.32-2-sparc64-smp
version 2.6.32-8):

[  765.580097] BUG: soft lockup - CPU#0 stuck for 61s! [sh:58 9]
[  765.650395] Modules linked in: sunhme ext3 jbd mbcache sd_mod crc_t10dif evdev sun_esp esp_scsi scsi_transport_spi scsi_mod
[  765.786195] TSTATE: 0000000080001605 TPC: 0000000000407a9c TNPC: 0000000000407aa0 Y: ffa20f9a    Not tainted
[  765.906535] TPC: <sparc64_realfault_common+0x8/0x20>
[  765.968628] g0: 000000000000000a g1: 00000000ffcab0cc g2: 00000000f7e2dcb4 g3: 00000000008f4340
[  766.075480] g4: fffff80006623720 g5: fffff80000314000 g6: fffff80006544000 g7: 00000000ffcab290
[  766.182445] o0: 0000000000000001 o1: fffff80006544400 o2: 0000000000442030 o3: 00000000ffa20f9a
[  766.289480] o4: fffff80006547cf0 o5: 00000000f7d883d8 sp: fffff80006547261 ret_pc: 0000000000407aa4
[  766.400809] RPC: <sparc64_realfault_common+0x10/0x20>
[  766.464116] l0: 0000000000001000 l1: 0000004410001604 l2: 0000000000407a9c l3: 0000000000000000
[  766.571306] l4: 0000000000000002 l5: 00000000ffcaa000 l6: fffff80006544000 l7: 0000000080001005
[  766.678396] i0: 00000000ffcab068 i1: fffff80006547f60 i2: 0000000000000228 i3: 000000000080c2c8
[  766.785656] i4: 0000000000040005 i5: 0000000000000000 i6: fffff800065473c1 i7: 0000000000441fc0
[  766.892889] I7: <do_signal32+0x570/0xa78>

As I said, my sparc assembler knowledge is almost not existing,
so excuses in advance for messing everything up.

I'm assuming objdump -d on the unpacked vmlinuz gives me correct
addresses. That means it is here (the sparc64_realfault_common):

  407a94:       10 6f f3 2b     b  %xcc, 404740
  407a98:       8f 41 40 00     rd  %pc, %g7
  407a9c:       e8 29 a0 08     stb  %l4, [ %g6 + 8 ]     <-TPC
  407aa0:       ea 71 a0 20     stx  %l5, [ %g6 + 0x20 ]  <-TNPC
  407aa4:       40 01 09 1e     call  449f1c              <-ret_pc
  407aa8:       90 03 a8 bf     add  %sp, 0x8bf, %o0
  407aac:       10 6f f4 35     b  %xcc, 404b80
  407ab0:       01 00 00 00     nop

That seems very strange in my eyes. The odd sp value does not make my
confusion smaller.

And looking at i7 that is in setup_frame32 (inlined in handle_signal32
again inlined in do_signal32)

  handle_signal32: setup_frame32(ka, regs, signr, oldset);
  synchronize_user_stack();
  441f7c:       7f ff a5 86     call  42b594 <_start+0x27594>
  441f80:       01 00 00 00     nop
  save_and_clear_fpu() (INLINED)
  441f84:       9b 41 80 00     rd  %fprs, %o5
  441f88:       80 8b 60 06     btst  6, %o5
  441f8c:       02 48 00 06     be  %icc, 441fa4 <_start+0x3dfa4>
  441f90:       0f 00 11 07     sethi  %hi(0x441c00), %g7
  441f94:       03 00 17 09     sethi  %hi(0x5c2400), %g1
  441f98:       81 c0 62 80     jmp  %g1 + 0x280        ! 5c2680 <_start+0x1be680>
  441f9c:       8e 11 e3 a0     or  %g7, 0x3a0, %g7
  441fa0:       8d 80 20 00     wr  %g0, 0, %fprs
  sigframe_size = SF_ALIGNEDSZ;
  if (!(current_thread_info()->fpsaved[0] & FPRS_FEF))
      sigframe_size -= sizeof(__siginfo_fpu_t);
  441fa4:       c2 09 a0 10     ldub  [ %g6 + 0x10 ], %g1
  441fa8:       84 10 22 28     mov  0x228, %g2
  441fac:       90 07 a7 bf     add  %fp, 0x7bf, %o0
  441fb0:       92 10 00 19     mov  %i1, %o1
  441fb4:       82 08 60 04     and  %g1, 4, %g1
  441fb8:       85 78 65 10     movre  %g1, 0x110, %g2
  441fbc:       a1 38 a0 00     sra  %g2, 0, %l0
  sf = (struct signal_frame32 __user *)get_sigframe(&ka->sa, regs, sigframe_size);
  441fc0:       7f ff fd 64     call  441550 <_start+0x3d550>
  441fc4:       94 10 00 10     mov  %l0, %o2
  441fc8:       82 0a 20 07     and  %o0, 7, %g1
  441fcc:       0a c8 40 e7     brnz  %g1, 442368 <_start+0x3e368>

get_sigframe looking like this:
  441550:       ce 02 60 74     ld  [ %o1 + 0x74 ], %g7
  441554:       ce 72 60 70     stx  %g7, [ %o1 + 0x70 ]
  441558:       c6 59 24 00     ldx  [ %g4 + 0x400 ], %g3
  44155c:       80 a1 c0 03     cmp  %g7, %g3
  441560:       08 68 00 0e     bleu  %xcc, 441598 <_start+0x3d598>
  441564:       84 10 00 04     mov  %g4, %g2
  441568:       da 59 24 08     ldx  [ %g4 + 0x408 ], %o5
  44156c:       82 21 c0 03     sub  %g7, %g3, %g1
  441570:       80 a0 40 0d     cmp  %g1, %o5
  441574:       38 68 00 0a     bgu,a   %xcc, 44159c <_start+0x3d59c>
  441578:       c2 5a 20 08     ldx  [ %o0 + 8 ], %g1
  44157c:       82 21 c0 0a     sub  %g7, %o2, %g1
  441580:       80 a0 40 03     cmp  %g1, %g3
  441584:       08 68 00 15     bleu  %xcc, 4415d8 <_start+0x3d5d8>
  441588:       82 20 40 03     sub  %g1, %g3, %g1
  44158c:       80 a0 40 0d     cmp  %g1, %o5
  441590:       18 68 00 12     bgu  %xcc, 4415d8 <_start+0x3d5d8>
  441594:       01 00 00 00     nop
  441598:       c2 5a 20 08     ldx  [ %o0 + 8 ], %g1
  44159c:       80 88 60 01     btst  1, %g1
  4415a0:       02 68 00 0c     be  %xcc, 4415d0 <_start+0x3d5d0>
  4415a4:       82 09 ff f8     and  %g7, -8, %g1
  4415a8:       c4 58 a4 08     ldx  [ %g2 + 0x408 ], %g2
  4415ac:       02 c8 80 09     brz  %g2, 4415d0 <_start+0x3d5d0>
  4415b0:       80 a1 c0 03     cmp  %g7, %g3
  4415b4:       28 68 00 06     bleu,a   %xcc, 4415cc <_start+0x3d5cc>
  4415b8:       8e 00 80 03     add  %g2, %g3, %g7
  4415bc:       82 21 c0 03     sub  %g7, %g3, %g1
  4415c0:       80 a0 40 02     cmp  %g1, %g2
  4415c4:       38 68 00 02     bgu,a   %xcc, 4415cc <_start+0x3d5cc>
  4415c8:       8e 00 80 03     add  %g2, %g3, %g7
  4415cc:       82 09 ff f8     and  %g7, -8, %g1
  4415d0:       81 c3 e0 08     retl
  4415d4:       90 20 40 0a     sub  %g1, %o2, %o0
  4415d8:       81 c3 e0 08     retl
  4415dc:       90 10 3f ff     mov  -1, %o0

So how does it get from there to the realfault code?
