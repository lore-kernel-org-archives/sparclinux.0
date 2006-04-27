From: Per =?iso-8859-1?q?=D8yvind_Karlsen?= <pkarlsen@mandriva.com>
Date: Thu, 27 Apr 2006 22:42:07 +0000
Subject: kernel oops with 2.6.17-rc1 & 2.6.17-rc2
Message-Id: <200604280042.08024.pkarlsen@mandriva.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

When running 2.6.17-rc1 or rc2 I seem to get a lot of these oops, not certa=
in=20
about what exactly causes those, but might seem to happen during a little=20
load..
2.6.16 runs fine without this ever happening.

Machine is a blade 100..

Unable to handle kernel paging request in mna handler<1> at virtual address=
=20
00000000445173d6
current->{active_,}mm->context =3D 00000000000010f8
current->{active_,}mm->pgd =3D fffff80002de6000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
sh(8558): Oops [#1]
TSTATE: 0000000011009406 TPC: 0000000000439e14 TNPC: 0000000000439e18 Y:=20
00000000    Not tainted
TPC: <__flush_tlb_pending+0x34/0x80>
g0: fffff8000bd1efe0 g1: ffffffffffc00000 g2: 00000000000010f8 g3:=20
fffff80007194000
g4: fffff80003665760 g5: 0000000000350049 g6: fffff80007194000 g7:=20
0000000000000096
o0: 00000000000010f8 o1: fffffffffffff2d0 o2: 00000000006fc608 o3:=20
00000000445173d6
o4: 0000000000000010 o5: 000000000000000c sp: fffff80007197431 ret_pc:=20
000000000043a1b8
RPC: <flush_tlb_pending+0x58/0x6c>
l0: 00000000006fc400 l1: 00000000006fc5f0 l2: 00000000fff0c000 l3:=20
00000000fff0c000
l4: fffff8000c2bfc30 l5: fffff8000aff5c30 l6: fffff8000eab8800 l7:=20
fffff80008684800
i0: fffff8000bd1f040 i1: fffff8000bd1e160 i2: fffff80003f0fe78 i3:=20
fffff80002de6004
i4: 00000000fff0c000 i5: fffff80022d16004 i6: fffff800071974f1 i7:=20
0000000000447900
I7: <copy_process+0x9c8/0x1080>
Caller[0000000000447900]: copy_process+0x9c8/0x1080
Caller[0000000000448048]: do_fork+0x90/0x1b4
Caller[0000000000406a94]: linux_sparc_syscall32+0x34/0x40
Caller[00000000f7ea6978]: 0xf7ea6978
Instruction DUMP: 962ae001  02400003  9612e010 <c0f2cae0> c0f2cbe0  8143e04=
0 =20
0afa7ff7  01000000  c4f30b00

--=20
Regards,
Per =D8yvind Karlsen
Mandrakesoft becomes Mandriva
