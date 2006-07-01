From: Rene Rebe <rene@exactcode.de>
Date: Sat, 01 Jul 2006 12:21:56 +0000
Subject: Oops in tcp_sendmsg on T1000
Message-Id: <200607011421.56811.rene@exactcode.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi all,

I just test the freshly installed T1000 under load and got a single stray o=
ops
after 5 hours of uptime with excessive load (software compilation). The
software is the T2 release from this week (software compiled from
vanilla sources) with GCC 4.1.1, Kernel 2.6.17.2:

Linux version 2.6.17.2-dist (root@localhost) (gcc version 4.1.1) #1 SMP Fri=
 Jun 30 14:30:38 /TOOLCHAIN/localtime 2006

The same kernel binary runs on Ultra30 and Ultra5 since days without any
problem, however I already can imagine that David will slap me for using
GCC 4.1.1. Maybe someone is interested anyway:

kernel BUG at include/linux/skbuff.h:457!
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
sshd(21849): Kernel bad sw trap 5 [#1]
TSTATE: 0000000011001601 TPC: 00000000005c5c2c TNPC: 00000000005c5c30 Y: 00=
000000    Not tainted
TPC: <tcp_sendmsg+0x3b0/0xcb0>
g0: 0000000000000830 g1: 0000000000656400 g2: 0000000000714400 g3: 00000000=
00002bb9
g4: fffff8018cde7060 g5: fffff80003d660c0 g6: fffff8016f6f0000 g7: 00000000=
00000000
o0: 000000000000002d o1: 0000000000621e30 o2: 00000000000001c9 o3: 00000000=
00000240
o4: 00000000ff1e8eef o5: 0000000000000240 sp: fffff8016f6f2fb1 ret_pc: 0000=
0000005c5c24
RPC: <tcp_sendmsg+0x3a8/0xcb0>
l0: fffff801248057a0 l1: 0000000000000100 l2: 000000000041220c l3: 00000000=
0008ad78
l4: 0000000000000010 l5: 000000000000000b l6: fffff8016f6f0000 l7: 00000000=
000cc950
i0: 0000000000004000 i1: fffff8017f4b2780 i2: 0000000000000000 i3: 00000000=
00000040
i4: 0000000000004000 i5: 0000000000000240 i6: fffff8016f6f30a1 i7: 00000000=
005e1928
I7: <inet_sendmsg+0x44/0x58>
Caller[00000000005e1928]: inet_sendmsg+0x44/0x58
Caller[000000000059019c]: do_sock_write+0xa0/0xb4
Caller[0000000000590960]: sock_aio_write+0x48/0x5c
Caller[000000000048e3a0]: do_sync_write+0x80/0xc0
Caller[000000000048ec5c]: vfs_write+0x88/0x120
Caller[000000000048f12c]: sys_write+0x2c/0x60
Caller[0000000000406c94]: linux_sparc_syscall32+0x34/0x40
Caller[000000000003473c]: 0x3473c
Instruction DUMP: 90122230  7ff95253  01000000 <91d02005> 84050012  c424208=
8  8204c001  80a04003  08680007

--=20
Ren=E9 Rebe - ExactCODE - Berlin (Europe / Germany)
            http://exactcode.de | http://t2-project.org | http://rene.rebe.=
name
            +49 (0)30 / 255 897 45
