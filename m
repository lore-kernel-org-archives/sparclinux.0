From: Meelis Roos <mroos@linux.ee>
Date: Wed, 10 Oct 2018 13:24:59 +0000
Subject: sparc64 mystery with Cheetah+ D-cache parity error (n_tty_set_termios, bpf_check, cheetah_copy_page_
Message-Id: <a4391645-0c4f-bd99-7371-b0e2cb505542@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, netdev@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>

I have seen multiple strange messages like this, on multiple sparc64 machines:

[   55.523882] CPU[1]: Cheetah+ D-cache parity error at TPC[0000000000707e8c]
[   55.626033] TPC<n_tty_set_termios+0x2c/0x3c0>

This specfic one ise from n_tty_set_termios and it is currently repeatable on a Sun V210.
I have seen these on V245 and V445 too, with different addresses. On V445, the same address caused
errors on multiple CPUs so it does not seem like a hardware problem, rather something software releated,
that's why I am reporting it here.

On V445 it is gone with my current custom kernels but was there with 4.16.0-1-sparc64-smp Debian kernel package,
probabaly because I do not have bpfilter compiled in:

Sep 27 22:51:52 v445 kernel: [   51.635141] CPU[3]: Cheetah+ D-cache parity error at TPC[000000000057bc70]
Sep 27 22:51:52 v445 kernel: [   51.733940] TPC<bpf_check+0x30/0x1780>
Sep 27 23:13:45 v445 kernel: [   59.192005] CPU[1]: Cheetah+ D-cache parity error at TPC[000000000057bc70]
Sep 27 23:13:45 v445 kernel: [   59.290762] TPC<bpf_check+0x30/0x1780>
Sep 27 23:22:14 v445 kernel: [  336.892797] CPU[3]: Cheetah+ D-cache parity error at TPC[000000000057bc70]
Sep 27 23:22:14 v445 kernel: [  336.991586] TPC<bpf_check+0x30/0x1780>
Sep 27 23:22:15 v445 kernel: [  337.546927] CPU[0]: Cheetah+ D-cache parity error at TPC[000000000057bc70]
Sep 27 23:22:15 v445 kernel: [  337.645689] TPC<bpf_check+0x30/0x1780>
Sep 27 23:44:40 v445 kernel: [ 1682.966655] CPU[1]: Cheetah+ D-cache parity error at TPC[000000000057bc70]
Sep 27 23:44:40 v445 kernel: [ 1683.065442] TPC<bpf_check+0x30/0x1780>
Sep 27 23:47:05 v445 kernel: [ 1828.099386] CPU[1]: Cheetah+ D-cache parity error at TPC[000000000057bc70]
Sep 27 23:47:05 v445 kernel: [ 1828.198145] TPC<bpf_check+0x30/0x1780>
Sep 27 23:47:37 v445 kernel: [ 1859.857710] CPU[0]: Cheetah+ D-cache parity error at TPC[000000000057bc70]
Sep 27 23:47:37 v445 kernel: [ 1859.956441] TPC<bpf_check+0x30/0x1780>
Sep 27 23:47:47 v445 kernel: [ 1869.732962] CPU[0]: Cheetah+ D-cache parity error at TPC[000000000057bc70]
Sep 27 23:47:47 v445 kernel: [ 1869.831721] TPC<bpf_check+0x30/0x1780>

On V245, it is also gone with current kernel. Here are logs from 4.18.0-rc7-00090-gc1d61e7 to 4.19.0-rc7-00009-g0854ba5:

Aug 13 09:18:13 v245 kernel: [   50.639758] CPU[0]: Cheetah+ D-cache parity error at TPC[00000000006cf28c]
Aug 13 09:18:13 v245 kernel: [   50.743561] TPC<n_tty_set_termios+0x2c/0x3c0>
Aug 13 09:18:13 v245 kernel: [   62.151683] CPU[0]: Cheetah+ D-cache parity error at TPC[00000000006cf28c]
Aug 13 09:18:13 v245 kernel: [   62.252996] TPC<n_tty_set_termios+0x2c/0x3c0>
Aug 26 11:35:37 v245 kernel: [   55.341794] CPU[0]: Cheetah+ D-cache parity error at TPC[00000000006cdc8c]
Aug 26 11:35:37 v245 kernel: [   55.437571] TPC<n_tty_set_termios+0x2c/0x3c0>
Aug 26 13:47:03 v245 kernel: [ 7941.436962] CPU[1]: Cheetah+ D-cache parity error at TPC[00000000006cdc8c]
Aug 26 13:47:03 v245 kernel: [ 7941.531823] TPC<n_tty_set_termios+0x2c/0x3c0>
Aug 26 13:49:07 v245 kernel: [   65.179371] CPU[1]: Cheetah+ D-cache parity error at TPC[00000000006d340c]
Aug 26 13:49:07 v245 kernel: [   65.285928] TPC<n_tty_set_termios+0x2c/0x3c0>
Sep 17 15:45:37 v245 kernel: [   67.099122] CPU[1]: Cheetah+ D-cache parity error at TPC[00000000006d340c]
Sep 17 15:45:37 v245 kernel: [   67.205581] TPC<n_tty_set_termios+0x2c/0x3c0>
Sep 17 20:49:06 v245 kernel: [   47.923877] CPU[1]: Cheetah+ D-cache parity error at TPC[00000000006d352c]
Sep 17 20:49:06 v245 kernel: [   48.021575] TPC<n_tty_set_termios+0x2c/0x3c0>
Sep 23 23:03:07 v245 kernel: [   56.136992] CPU[0]: Cheetah+ D-cache parity error at TPC[00000000006d364c]
Sep 23 23:03:07 v245 kernel: [   56.243463] TPC<n_tty_set_termios+0x2c/0x3c0>
Oct  8 19:02:41 v245 kernel: [   55.197360] CPU[0]: Cheetah+ D-cache parity error at TPC[0000000000860e10]
Oct  8 19:02:41 v245 kernel: [   55.303284] TPC<cheetah_copy_page_insn+0xa4/0x274>

The last one is from 4.19.0-rc7-00009-g0854ba5 and it has happened only on one boot of this kernel, out of 4,
so it is somewhat nondeterministic. This is the same kernel that made me think it does not happen with current
kernels - well, it did with the same image once.

On V210, it has happened since 4.19.0-rc4-00022-gad3273d and is still happening with 4.19.0-rc7-00009-g0854ba5.

Grep from logs:

Sep 23 22:11:23 v210 kernel: [   61.080357] CPU[1]: Cheetah+ D-cache parity error at TPC[0000000000707b2c]
Sep 23 22:11:23 v210 kernel: [   61.184336] TPC<n_tty_set_termios+0x2c/0x3c0>
Sep 23 22:11:24 v210 kernel: [   65.234758] CPU[1]: Cheetah+ D-cache parity error at TPC[0000000000707b2c]
Sep 23 22:11:24 v210 kernel: [   65.341131] TPC<n_tty_set_termios+0x2c/0x3c0>
Oct  8 19:21:08 v210 kernel: [   55.303418] CPU[1]: Cheetah+ D-cache parity error at TPC[0000000000707e8c]
Oct  8 19:21:08 v210 kernel: [   55.406668] TPC<n_tty_set_termios+0x2c/0x3c0>

TPC is different, address relative to n_tty_set_termios is the same.

Disassembly of n_tty_set_termios on V210:

0000000000707e60 <n_tty_set_termios>:
   707e60:       9d e3 bf 50     save  %sp, -176, %sp
   707e64:       02 c6 40 55     brz,pn   %i1, 707fb8 <n_tty_set_termios+0x158>
   707e68:       fa 5e 22 58     ldx  [ %i0 + 0x258 ], %i5
   707e6c:       c2 06 21 1c     ld  [ %i0 + 0x11c ], %g1
   707e70:       05 00 00 40     sethi  %hi(0x10000), %g2
   707e74:       c6 06 60 0c     ld  [ %i1 + 0xc ], %g3
   707e78:       84 10 a0 02     or  %g2, 2, %g2
   707e7c:       86 18 40 03     xor  %g1, %g3, %g3
   707e80:       80 88 c0 02     btst  %g3, %g2
   707e84:       12 48 00 4e     bne  %icc, 707fbc <n_tty_set_termios+0x15c>
   707e88:       b8 10 20 83     mov  0x83, %i4
   707e8c:       c6 0f 60 5d     ldub  [ %i5 + 0x5d ], %g3
   707e90:       83 28 60 02     sll  %g1, 2, %g1
   707e94:       84 08 60 08     and  %g1, 8, %g2
   707e98:       82 08 ff f7     and  %g3, -9, %g1
   707e9c:       82 10 40 02     or  %g1, %g2, %g1
   707ea0:       c2 2f 60 5d     stb  %g1, [ %i5 + 0x5d ]
   707ea4:       84 10 20 1f     mov  0x1f, %g2
   707ea8:       c6 5e 21 10     ldx  [ %i0 + 0x110 ], %g3
   707eac:       85 28 b0 25     sllx  %g2, 0x25, %g2
   707eb0:       84 08 c0 02     and  %g3, %g2, %g2
   707eb4:       0a c0 80 07     brnz,pn   %g2, 707ed0 <n_tty_set_termios+0x70>
   707eb8:       b8 07 60 30     add  %i5, 0x30, %i4
   707ebc:       c4 06 21 1c     ld  [ %i0 + 0x11c ], %g2
   707ec0:       80 88 a0 02     btst  2, %g2
   707ec4:       22 68 00 58     be,a   %xcc, 708024 <n_tty_set_termios+0x1c4>
   707ec8:       c4 06 21 10     ld  [ %i0 + 0x110 ], %g2
   707ecc:       b8 07 60 30     add  %i5, 0x30, %i4
   707ed0:       92 10 20 00     clr  %o1
   707ed4:       90 10 00 1c     mov  %i4, %o0
   707ed8:       40 07 dc 08     call  8feef8 <memset>
   707edc:       94 10 20 20     mov  0x20, %o2
   707ee0:       c4 5e 21 10     ldx  [ %i0 + 0x110 ], %g2
   707ee4:       82 10 20 03     mov  3, %g1
   707ee8:       83 28 70 27     sllx  %g1, 0x27, %g1
   707eec:       82 08 80 01     and  %g2, %g1, %g1
   707ef0:       0a c0 40 b8     brnz,pn   %g1, 7081d0 <n_tty_set_termios+0x370>
   707ef4:       90 10 20 0d     mov  0xd, %o0
   707ef8:       c2 06 21 10     ld  [ %i0 + 0x110 ], %g1
   707efc:       80 88 60 40     btst  0x40, %g1
   707f00:       12 60 00 b0     bne,pn   %xcc, 7081c0 <n_tty_set_termios+0x360>
   707f04:       90 10 20 0a     mov  0xa, %o0
   707f08:       c2 06 21 1c     ld  [ %i0 + 0x11c ], %g1
   707f0c:       80 88 60 02     btst  2, %g1
   707f10:       32 60 00 87     bne,a,pn   %xcc, 70812c <n_tty_set_termios+0x2cc>
   707f14:       d0 0e 21 23     ldub  [ %i0 + 0x123 ], %o0
   707f18:       c2 06 21 10     ld  [ %i0 + 0x110 ], %g1
   707f1c:       80 88 64 00     btst  0x400, %g1
   707f20:       32 60 00 7c     bne,a,pn   %xcc, 708110 <n_tty_set_termios+0x2b0>
   707f24:       d0 0e 21 29     ldub  [ %i0 + 0x129 ], %o0
   707f28:       c2 06 21 1c     ld  [ %i0 + 0x11c ], %g1
   707f2c:       80 88 60 01     btst  1, %g1
   707f30:       32 60 00 6e     bne,a,pn   %xcc, 7080e8 <n_tty_set_termios+0x288>
   707f34:       d0 0e 21 21     ldub  [ %i0 + 0x121 ], %o0
   707f38:       90 10 20 00     clr  %o0
   707f3c:       40 07 db b9     call  8fee20 <clear_bit>
   707f40:       92 10 00 1c     mov  %i4, %o1
   707f44:       c2 0f 60 5d     ldub  [ %i5 + 0x5d ], %g1
   707f48:       82 08 7f cf     and  %g1, -49, %g1
   707f4c:       c2 2f 60 5d     stb  %g1, [ %i5 + 0x5d ]
   707f50:       c2 06 21 10     ld  [ %i0 + 0x110 ], %g1
   707f54:       84 10 20 00     clr  %g2
   707f58:       85 7e 74 01     movrne  %i1, 1, %g2
   707f5c:       83 30 60 0a     srl  %g1, 0xa, %g1
   707f60:       82 18 60 01     xor  %g1, 1, %g1
   707f64:       80 88 40 02     btst  %g1, %g2
   707f68:       02 40 00 0b     be,pn   %icc, 707f94 <n_tty_set_termios+0x134>
   707f6c:       90 06 22 08     add  %i0, 0x208, %o0
   707f70:       c2 06 40 00     ld  [ %i1 ], %g1
   707f74:       80 88 64 00     btst  0x400, %g1
   707f78:       02 60 00 07     be,pn   %xcc, 707f94 <n_tty_set_termios+0x134>
   707f7c:       03 10 00 00     sethi  %hi(0x40000000), %g1
   707f80:       c4 5e 21 d0     ldx  [ %i0 + 0x1d0 ], %g2
   707f84:       82 08 80 01     and  %g2, %g1, %g1
   707f88:       22 c0 40 96     brz,a,pn   %g1, 7081e0 <n_tty_set_termios+0x380>
   707f8c:       90 10 00 18     mov  %i0, %o0
   707f90:       90 06 22 08     add  %i0, 0x208, %o0
   707f94:       92 10 20 01     mov  1, %o1
   707f98:       94 10 20 01     mov  1, %o2
   707f9c:       7f f6 5c a9     call  49f240 <__wake_up>
   707fa0:       96 10 20 00     clr  %o3
   707fa4:       b0 06 22 20     add  %i0, 0x220, %i0
   707fa8:       b2 10 20 01     mov  1, %i1
   707fac:       b4 10 20 01     mov  1, %i2
   707fb0:       7f f6 5c a4     call  49f240 <__wake_up>
   707fb4:       97 e8 20 00     restore  %g0, 0, %o3
   707fb8:       b8 10 20 83     mov  0x83, %i4
   707fbc:       92 10 20 00     clr  %o1
   707fc0:       b9 2f 30 05     sllx  %i4, 5, %i4
   707fc4:       94 10 22 00     mov  0x200, %o2
   707fc8:       b8 07 40 1c     add  %i5, %i4, %i4
   707fcc:       40 07 db cb     call  8feef8 <memset>
   707fd0:       90 10 00 1c     mov  %i4, %o0
   707fd4:       82 10 21 13     mov  0x113, %g1
   707fd8:       83 28 70 05     sllx  %g1, 5, %g1
   707fdc:       c4 5f 40 01     ldx  [ %i5 + %g1 ], %g2
   707fe0:       82 10 24 4d     mov  0x44d, %g1
   707fe4:       83 28 70 03     sllx  %g1, 3, %g1
   707fe8:       c4 77 40 01     stx  %g2, [ %i5 + %g1 ]
   707fec:       c2 06 21 1c     ld  [ %i0 + 0x11c ], %g1
   707ff0:       80 88 60 02     btst  2, %g1
   707ff4:       12 68 00 31     bne  %xcc, 7080b8 <n_tty_set_termios+0x258>
   707ff8:       d0 5f 40 00     ldx  [ %i5 ], %o0
   707ffc:       c2 0f 60 5d     ldub  [ %i5 + 0x5d ], %g1
   708000:       c4 77 60 10     stx  %g2, [ %i5 + 0x10 ]
   708004:       82 08 7f fb     and  %g1, -5, %g1
   708008:       c2 2f 60 5d     stb  %g1, [ %i5 + 0x5d ]
   70800c:       c2 0f 60 5d     ldub  [ %i5 + 0x5d ], %g1
   708010:       d0 77 60 08     stx  %o0, [ %i5 + 8 ]
   708014:       82 08 60 3f     and  %g1, 0x3f, %g1
   708018:       c2 2f 60 5d     stb  %g1, [ %i5 + 0x5d ]
   70801c:       10 6f ff 9c     b  %xcc, 707e8c <n_tty_set_termios+0x2c>
   708020:       c2 06 21 1c     ld  [ %i0 + 0x11c ], %g1
   708024:       80 88 a4 00     btst  0x400, %g2
   708028:       12 6f ff aa     bne  %xcc, 707ed0 <n_tty_set_termios+0x70>
   70802c:       b8 07 60 30     add  %i5, 0x30, %i4
   708030:       c6 5e 21 18     ldx  [ %i0 + 0x118 ], %g3
   708034:       86 08 e0 09     and  %g3, 9, %g3
   708038:       0a f8 ff a7     brnz  %g3, 707ed4 <n_tty_set_termios+0x74>
   70803c:       92 10 20 00     clr  %o1
   708040:       80 88 a0 08     btst  8, %g2
   708044:       12 6f ff a5     bne  %xcc, 707ed8 <n_tty_set_termios+0x78>
   708048:       90 10 00 1c     mov  %i4, %o0
   70804c:       82 10 60 20     or  %g1, 0x20, %g1
   708050:       c2 2f 60 5d     stb  %g1, [ %i5 + 0x5d ]
   708054:       c2 06 21 10     ld  [ %i0 + 0x110 ], %g1
   708058:       80 88 60 01     btst  1, %g1
   70805c:       12 68 00 07     bne  %xcc, 708078 <n_tty_set_termios+0x218>
   708060:       c6 5e 21 10     ldx  [ %i0 + 0x110 ], %g3
   708064:       84 10 20 05     mov  5, %g2
   708068:       85 28 b0 21     sllx  %g2, 0x21, %g2
   70806c:       84 08 c0 02     and  %g3, %g2, %g2
   708070:       2a c8 80 69     brnz,a   %g2, 708214 <n_tty_set_termios+0x3b4>
   708074:       c2 0f 60 5d     ldub  [ %i5 + 0x5d ], %g1
   708078:       82 10 20 05     mov  5, %g1
   70807c:       84 10 20 01     mov  1, %g2
   708080:       83 28 70 22     sllx  %g1, 0x22, %g1
   708084:       85 28 b0 24     sllx  %g2, 0x24, %g2
   708088:       82 08 c0 01     and  %g3, %g1, %g1
   70808c:       80 a0 40 02     cmp  %g1, %g2
   708090:       22 60 00 61     be,a,pn   %xcc, 708214 <n_tty_set_termios+0x3b4>
   708094:       c2 0f 60 5d     ldub  [ %i5 + 0x5d ], %g1
   708098:       c2 5e 20 10     ldx  [ %i0 + 0x10 ], %g1
   70809c:       c2 58 60 68     ldx  [ %g1 + 0x68 ], %g1
   7080a0:       82 08 60 04     and  %g1, 4, %g1
   7080a4:       02 c8 40 5c     brz  %g1, 708214 <n_tty_set_termios+0x3b4>
   7080a8:       c2 0f 60 5d     ldub  [ %i5 + 0x5d ], %g1
   7080ac:       82 10 60 10     or  %g1, 0x10, %g1
   7080b0:       10 6f ff a8     b  %xcc, 707f50 <n_tty_set_termios+0xf0>
   7080b4:       c2 2f 60 5d     stb  %g1, [ %i5 + 0x5d ]
   7080b8:       80 a0 80 08     cmp  %g2, %o0
   7080bc:       02 67 ff d0     be,pn   %xcc, 707ffc <n_tty_set_termios+0x19c>
   7080c0:       92 10 00 1c     mov  %i4, %o1
   7080c4:       90 02 3f ff     add  %o0, -1, %o0
   7080c8:       40 07 db 3b     call  8fedb4 <set_bit>
   7080cc:       90 0a 2f ff     and  %o0, 0xfff, %o0
   7080d0:       c2 0f 60 5d     ldub  [ %i5 + 0x5d ], %g1
   7080d4:       d0 5f 40 00     ldx  [ %i5 ], %o0
   7080d8:       82 10 60 04     or  %g1, 4, %g1
   7080dc:       c2 2f 60 5d     stb  %g1, [ %i5 + 0x5d ]
   7080e0:       10 6f ff cb     b  %xcc, 70800c <n_tty_set_termios+0x1ac>
   7080e4:       d0 77 60 10     stx  %o0, [ %i5 + 0x10 ]
   7080e8:       40 07 db 33     call  8fedb4 <set_bit>
   7080ec:       92 10 00 1c     mov  %i4, %o1
   7080f0:       d0 0e 21 22     ldub  [ %i0 + 0x122 ], %o0
   7080f4:       40 07 db 30     call  8fedb4 <set_bit>
   7080f8:       92 10 00 1c     mov  %i4, %o1
   7080fc:       d0 0e 21 2b     ldub  [ %i0 + 0x12b ], %o0
   708100:       40 07 db 2d     call  8fedb4 <set_bit>
   708104:       92 10 00 1c     mov  %i4, %o1
   708108:       10 6f ff 8d     b  %xcc, 707f3c <n_tty_set_termios+0xdc>
   70810c:       90 10 20 00     clr  %o0
   708110:       40 07 db 29     call  8fedb4 <set_bit>
   708114:       92 10 00 1c     mov  %i4, %o1
   708118:       d0 0e 21 2a     ldub  [ %i0 + 0x12a ], %o0
   70811c:       40 07 db 26     call  8fedb4 <set_bit>
   708120:       92 10 00 1c     mov  %i4, %o1
   708124:       10 6f ff 82     b  %xcc, 707f2c <n_tty_set_termios+0xcc>
   708128:       c2 06 21 1c     ld  [ %i0 + 0x11c ], %g1
   70812c:       40 07 db 22     call  8fedb4 <set_bit>
   708130:       92 10 00 1c     mov  %i4, %o1
   708134:       d0 0e 21 24     ldub  [ %i0 + 0x124 ], %o0
   708138:       40 07 db 1f     call  8fedb4 <set_bit>
   70813c:       92 10 00 1c     mov  %i4, %o1
   708140:       d0 0e 21 25     ldub  [ %i0 + 0x125 ], %o0
   708144:       40 07 db 1c     call  8fedb4 <set_bit>
   708148:       92 10 00 1c     mov  %i4, %o1
   70814c:       90 10 20 0a     mov  0xa, %o0
   708150:       40 07 db 19     call  8fedb4 <set_bit>
   708154:       92 10 00 1c     mov  %i4, %o1
   708158:       d0 0e 21 26     ldub  [ %i0 + 0x126 ], %o0
   70815c:       40 07 db 16     call  8fedb4 <set_bit>
   708160:       92 10 00 1c     mov  %i4, %o1
   708164:       c4 06 21 1c     ld  [ %i0 + 0x11c ], %g2
   708168:       03 00 00 20     sethi  %hi(0x8000), %g1
   70816c:       80 88 80 01     btst  %g2, %g1
   708170:       22 4f ff 6b     be,a   %icc, 707f1c <n_tty_set_termios+0xbc>
   708174:       c2 06 21 10     ld  [ %i0 + 0x110 ], %g1
   708178:       d0 0e 21 2f     ldub  [ %i0 + 0x12f ], %o0
   70817c:       40 07 db 0e     call  8fedb4 <set_bit>
   708180:       92 10 00 1c     mov  %i4, %o1
   708184:       d0 0e 21 30     ldub  [ %i0 + 0x130 ], %o0
   708188:       40 07 db 0b     call  8fedb4 <set_bit>
   70818c:       92 10 00 1c     mov  %i4, %o1
   708190:       d0 0e 21 27     ldub  [ %i0 + 0x127 ], %o0
   708194:       40 07 db 08     call  8fedb4 <set_bit>
   708198:       92 10 00 1c     mov  %i4, %o1
   70819c:       c2 06 21 1c     ld  [ %i0 + 0x11c ], %g1
   7081a0:       80 88 60 08     btst  8, %g1
   7081a4:       22 6f ff 5e     be,a   %xcc, 707f1c <n_tty_set_termios+0xbc>
   7081a8:       c2 06 21 10     ld  [ %i0 + 0x110 ], %g1
   7081ac:       d0 0e 21 2d     ldub  [ %i0 + 0x12d ], %o0
   7081b0:       40 07 db 01     call  8fedb4 <set_bit>
   7081b4:       92 10 00 1c     mov  %i4, %o1
   7081b8:       10 6f ff 59     b  %xcc, 707f1c <n_tty_set_termios+0xbc>
   7081bc:       c2 06 21 10     ld  [ %i0 + 0x110 ], %g1
   7081c0:       40 07 da fd     call  8fedb4 <set_bit>
   7081c4:       92 10 00 1c     mov  %i4, %o1
   7081c8:       10 6f ff 51     b  %xcc, 707f0c <n_tty_set_termios+0xac>
   7081cc:       c2 06 21 1c     ld  [ %i0 + 0x11c ], %g1
   7081d0:       40 07 da f9     call  8fedb4 <set_bit>
   7081d4:       92 10 00 1c     mov  %i4, %o1
   7081d8:       10 6f ff 49     b  %xcc, 707efc <n_tty_set_termios+0x9c>
   7081dc:       c2 06 21 10     ld  [ %i0 + 0x110 ], %g1
   7081e0:       7f ff f7 20     call  705e60 <start_tty>
   7081e4:       b2 10 20 01     mov  1, %i1
   7081e8:       b4 10 20 01     mov  1, %i2
   7081ec:       b6 10 20 00     clr  %i3
   7081f0:       7f ff fe fc     call  707de0 <process_echoes>
   7081f4:       90 10 00 18     mov  %i0, %o0
   7081f8:       90 06 22 08     add  %i0, 0x208, %o0
   7081fc:       92 10 20 01     mov  1, %o1
   708200:       94 10 20 01     mov  1, %o2
   708204:       7f f6 5c 0f     call  49f240 <__wake_up>
   708208:       96 10 20 00     clr  %o3
   70820c:       7f f6 5c 0d     call  49f240 <__wake_up>
   708210:       91 ee 22 20     restore  %i0, 0x220, %o0
   708214:       82 08 7f ef     and  %g1, -17, %g1
   708218:       10 6f ff 4e     b  %xcc, 707f50 <n_tty_set_termios+0xf0>
   70821c:       c2 2f 60 5d     stb  %g1, [ %i5 + 0x5d ]

Disassembly of cheetah_copy_page_insn from V245:

000000000860d6c <cheetah_copy_page_insn>:
   860d6c:       10 68 00 52     b  %xcc, 860eb4 <cheetah_copy_page_insn+0x148>
   860d70:       01 00 00 00     nop
   860d74:       9b 41 80 00     rd  %fprs, %o5
   860d78:       80 8b 60 06     btst  6, %o5
   860d7c:       02 48 00 05     be  %icc, 860d90 <cheetah_copy_page_insn+0x24>
   860d80:       0f 00 21 83     sethi  %hi(0x860c00), %g7
   860d84:       03 00 21 7e     sethi  %hi(0x85f800), %g1
   860d88:       81 c0 63 80     jmp  %g1 + 0x380        ! 85fb80 <VISenter>
   860d8c:       8e 11 e1 90     or  %g7, 0x190, %g7
   860d90:       8d 80 20 04     wr  %g0, 4, %fprs
   860d94:       81 43 e0 0e     membar  #StoreStore|#LoadStore|#StoreLoad
   860d98:       15 00 00 00     sethi  %hi(0), %o2
   860d9c:       82 10 00 08     mov  %o0, %g1
   860da0:       c3 6a 60 00     prefetch  [ %o1 ], #one_read
   860da4:       94 12 a0 7e     or  %o2, 0x7e, %o2
   860da8:       c3 6a 60 40     prefetch  [ %o1 + 0x40 ], #one_read
   860dac:       c3 6a 60 80     prefetch  [ %o1 + 0x80 ], #one_read
   860db0:       c3 6a 60 c0     prefetch  [ %o1 + 0xc0 ], #one_read
   860db4:       c1 1a 60 00     ldd  [ %o1 ], %f0
   860db8:       c3 6a 61 00     prefetch  [ %o1 + 0x100 ], #one_read
   860dbc:       c5 1a 60 08     ldd  [ %o1 + 8 ], %f2
   860dc0:       c3 6a 61 40     prefetch  [ %o1 + 0x140 ], #one_read
   860dc4:       c9 1a 60 10     ldd  [ %o1 + 0x10 ], %f4
   860dc8:       c3 6a 61 80     prefetch  [ %o1 + 0x180 ], #one_read
   860dcc:       a1 b0 0f 00     fsrc2d  %f0, %f16
   860dd0:       cd 1a 60 18     ldd  [ %o1 + 0x18 ], %f6
   860dd4:       a5 b0 0f 02     fsrc2d  %f2, %f18
   860dd8:       d1 1a 60 20     ldd  [ %o1 + 0x20 ], %f8
   860ddc:       a9 b0 0f 04     fsrc2d  %f4, %f20
   860de0:       d5 1a 60 28     ldd  [ %o1 + 0x28 ], %f10
   860de4:       ad b0 0f 06     fsrc2d  %f6, %f22
   860de8:       d9 1a 60 30     ldd  [ %o1 + 0x30 ], %f12
   860dec:       b1 b0 0f 08     fsrc2d  %f8, %f24
   860df0:       dd 1a 60 38     ldd  [ %o1 + 0x38 ], %f14
   860df4:       b5 b0 0f 0a     fsrc2d  %f10, %f26
   860df8:       c1 1a 60 40     ldd  [ %o1 + 0x40 ], %f0
   860dfc:       c5 1a 60 48     ldd  [ %o1 + 0x48 ], %f2
   860e00:       b9 b0 0f 0c     fsrc2d  %f12, %f28
   860e04:       c9 1a 60 50     ldd  [ %o1 + 0x50 ], %f4
   860e08:       bd b0 0f 0e     fsrc2d  %f14, %f30
   860e0c:       e1 ba 1e 00     stda  %f16, [ %o0 ] #ASI_BLK_P
   860e10:       cd 1a 60 58     ldd  [ %o1 + 0x58 ], %f6
   860e14:       a1 b0 0f 00     fsrc2d  %f0, %f16
   860e18:       d1 1a 60 60     ldd  [ %o1 + 0x60 ], %f8
   860e1c:       a5 b0 0f 02     fsrc2d  %f2, %f18
   860e20:       d5 1a 60 68     ldd  [ %o1 + 0x68 ], %f10
   860e24:       a9 b0 0f 04     fsrc2d  %f4, %f20
   860e28:       d9 1a 60 70     ldd  [ %o1 + 0x70 ], %f12
   860e2c:       ad b0 0f 06     fsrc2d  %f6, %f22
   860e30:       dd 1a 60 78     ldd  [ %o1 + 0x78 ], %f14
   860e34:       b1 b0 0f 08     fsrc2d  %f8, %f24
   860e38:       c1 1a 60 80     ldd  [ %o1 + 0x80 ], %f0
   860e3c:       c3 6a 61 80     prefetch  [ %o1 + 0x180 ], #one_read
   860e40:       b5 b0 0f 0a     fsrc2d  %f10, %f26
   860e44:       94 a2 a0 01     deccc  %o2
   860e48:       90 02 20 40     add  %o0, 0x40, %o0
   860e4c:       12 6f ff ec     bne  %xcc, 860dfc <cheetah_copy_page_insn+0x90>
   860e50:       92 02 60 40     add  %o1, 0x40, %o1
   860e54:       c5 1a 60 48     ldd  [ %o1 + 0x48 ], %f2
   860e58:       b9 b0 0f 0c     fsrc2d  %f12, %f28
   860e5c:       c9 1a 60 50     ldd  [ %o1 + 0x50 ], %f4
   860e60:       bd b0 0f 0e     fsrc2d  %f14, %f30
   860e64:       e1 ba 1e 00     stda  %f16, [ %o0 ] #ASI_BLK_P
   860e68:       cd 1a 60 58     ldd  [ %o1 + 0x58 ], %f6
   860e6c:       a1 b0 0f 00     fsrc2d  %f0, %f16
   860e70:       d1 1a 60 60     ldd  [ %o1 + 0x60 ], %f8
   860e74:       a5 b0 0f 02     fsrc2d  %f2, %f18
   860e78:       d5 1a 60 68     ldd  [ %o1 + 0x68 ], %f10
   860e7c:       a9 b0 0f 04     fsrc2d  %f4, %f20
   860e80:       d9 1a 60 70     ldd  [ %o1 + 0x70 ], %f12
   860e84:       ad b0 0f 06     fsrc2d  %f6, %f22
   860e88:       90 02 20 40     add  %o0, 0x40, %o0
   860e8c:       dd 1a 60 78     ldd  [ %o1 + 0x78 ], %f14
   860e90:       b1 b0 0f 08     fsrc2d  %f8, %f24
   860e94:       b5 b0 0f 0a     fsrc2d  %f10, %f26
   860e98:       b9 b0 0f 0c     fsrc2d  %f12, %f28
   860e9c:       bd b0 0f 0e     fsrc2d  %f14, %f30
   860ea0:       e1 ba 1e 00     stda  %f16, [ %o0 ] #ASI_BLK_P
   860ea4:       81 43 e0 40     membar  #Sync
   860ea8:       8d 80 20 00     wr  %g0, 0, %fprs
   860eac:       10 68 00 46     b  %xcc, 860fc4 <cheetah_copy_page_insn+0x258>
   860eb0:       01 00 00 00     nop
   860eb4:       9b 41 80 00     rd  %fprs, %o5
   860eb8:       80 8b 60 06     btst  6, %o5
   860ebc:       02 48 00 05     be  %icc, 860ed0 <cheetah_copy_page_insn+0x164>
   860ec0:       0f 00 21 83     sethi  %hi(0x860c00), %g7
   860ec4:       03 00 21 7e     sethi  %hi(0x85f800), %g1
   860ec8:       81 c0 63 80     jmp  %g1 + 0x380        ! 85fb80 <VISenter>
   860ecc:       8e 11 e2 d0     or  %g7, 0x2d0, %g7
   860ed0:       8d 80 20 04     wr  %g0, 4, %fprs
   860ed4:       c6 09 a0 08     ldub  [ %g6 + 8 ], %g3
   860ed8:       82 10 00 08     mov  %o0, %g1
   860edc:       80 a0 e0 00     cmp  %g3, 0
   860ee0:       87 40 c0 00     rd  %asi, %g3
   860ee4:       22 48 00 03     be,a   %icc, 860ef0 <cheetah_copy_page_insn+0x184>
   860ee8:       87 80 20 f0     wr  %g0, 0xf0, %asi
   860eec:       87 80 20 e0     wr  %g0, 0xe0, %asi
   860ef0:       c1 9a 5e 00     ldda  [ %o1 ] #ASI_BLK_P, %f0
   860ef4:       92 02 60 40     add  %o1, 0x40, %o1
   860ef8:       e1 9a 5e 00     ldda  [ %o1 ] #ASI_BLK_P, %f16
   860efc:       92 02 60 40     add  %o1, 0x40, %o1
   860f00:       15 00 00 08     sethi  %hi(0x2000), %o2
   860f04:       a3 b0 0f 00     fsrc2d  %f0, %f48
   860f08:       a7 b0 0f 02     fsrc2d  %f2, %f50
   860f0c:       ab b0 0f 04     fsrc2d  %f4, %f52
   860f10:       af b0 0f 06     fsrc2d  %f6, %f54
   860f14:       b3 b0 0f 08     fsrc2d  %f8, %f56
   860f18:       b7 b0 0f 0a     fsrc2d  %f10, %f58
   860f1c:       bb b0 0f 0c     fsrc2d  %f12, %f60
   860f20:       bf b0 0f 0e     fsrc2d  %f14, %f62
   860f24:       c3 9a 5e 00     ldda  [ %o1 ] #ASI_BLK_P, %f32
   860f28:       e3 ba 20 00     stda  %f48, [ %o0 ] %asi
   860f2c:       92 02 60 40     add  %o1, 0x40, %o1
   860f30:       94 22 a0 40     sub  %o2, 0x40, %o2
   860f34:       90 02 20 40     add  %o0, 0x40, %o0
   860f38:       a3 b0 0f 10     fsrc2d  %f16, %f48
   860f3c:       a7 b0 0f 12     fsrc2d  %f18, %f50
   860f40:       ab b0 0f 14     fsrc2d  %f20, %f52
   860f44:       af b0 0f 16     fsrc2d  %f22, %f54
   860f48:       b3 b0 0f 18     fsrc2d  %f24, %f56
   860f4c:       b7 b0 0f 1a     fsrc2d  %f26, %f58
   860f50:       bb b0 0f 1c     fsrc2d  %f28, %f60
   860f54:       bf b0 0f 1e     fsrc2d  %f30, %f62
   860f58:       c1 9a 5e 00     ldda  [ %o1 ] #ASI_BLK_P, %f0
   860f5c:       e3 ba 20 00     stda  %f48, [ %o0 ] %asi
   860f60:       92 02 60 40     add  %o1, 0x40, %o1
   860f64:       94 22 a0 40     sub  %o2, 0x40, %o2
   860f68:       90 02 20 40     add  %o0, 0x40, %o0
   860f6c:       a3 b0 0f 01     fsrc2d  %f32, %f48
   860f70:       a7 b0 0f 03     fsrc2d  %f34, %f50
   860f74:       ab b0 0f 05     fsrc2d  %f36, %f52
   860f78:       af b0 0f 07     fsrc2d  %f38, %f54
   860f7c:       b3 b0 0f 09     fsrc2d  %f40, %f56
   860f80:       b7 b0 0f 0b     fsrc2d  %f42, %f58
   860f84:       bb b0 0f 0d     fsrc2d  %f44, %f60
   860f88:       bf b0 0f 0f     fsrc2d  %f46, %f62
   860f8c:       e1 9a 5e 00     ldda  [ %o1 ] #ASI_BLK_P, %f16
   860f90:       e3 ba 20 00     stda  %f48, [ %o0 ] %asi
   860f94:       94 22 a0 40     sub  %o2, 0x40, %o2
   860f98:       92 02 60 40     add  %o1, 0x40, %o1
   860f9c:       80 a2 a0 80     cmp  %o2, 0x80
   860fa0:       12 6f ff d9     bne  %xcc, 860f04 <cheetah_copy_page_insn+0x198>
   860fa4:       90 02 20 40     add  %o0, 0x40, %o0
   860fa8:       81 43 e0 40     membar  #Sync
   860fac:       c1 ba 20 00     stda  %f0, [ %o0 ] %asi
   860fb0:       90 02 20 40     add  %o0, 0x40, %o0
   860fb4:       e1 ba 20 00     stda  %f16, [ %o0 ] %asi
   860fb8:       81 43 e0 40     membar  #Sync
   860fbc:       87 80 e0 00     wr  %g3, 0, %asi
   860fc0:       8d 80 20 00     wr  %g0, 0, %fprs
   860fc4:       c0 f0 4b e0     stxa  %g0, [ %g1 ] #ASI_DMMU_DEMAP
   860fc8:       81 43 e0 40     membar  #Sync
   860fcc:       05 00 00 10     sethi  %hi(0x4000), %g2
   860fd0:       c0 f0 4b e2     stxa  %g0, [ %g1 + %g2 ] #ASI_DMMU_DEMAP
   860fd4:       81 43 e0 40     membar  #Sync
   860fd8:       81 c3 e0 08     retl
   860fdc:       d8 21 a0 30     st  %o4, [ %g6 + 0x30 ]



-- 
Meelis Roos <mroos@linux.ee>
