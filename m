From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Thu, 11 Oct 2007 18:44:56 +0000
Subject: sun4v_data_access_exception on new 2.6.23
Message-Id: <470E6F28.2010709@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I have built a 2.6.23 kernel on a T1000 server. I have seen this
message on system console :

sun4v_data_access_exception: ADDR[000008000001e000] CTX[0000]
TYPE[0004], going.
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
dpkg-split(7958): Dax [#1]
TSTATE: 0000000011f01600 TPC: 0000000000407904 TNPC: 0000000000407908 Y:
00000000    Not tainted
TPC: <tsb_flush+0xc/0x40>
g0: 0000000000000000 g1: 0000000000000026 g2: 0000000000008000 g3:
0000000000002000
g4: fffff800ffc8d680 g5: fffff800020ce000 g6: fffff800d9454000 g7:
0000000000000027
o0: 000008000001ea60 o1: 00000000000003df o2: 000007feffffe000 o3:
fffff800ffecae00
o4: 9800000000000610 o5: ffffffffffffffff sp: fffff800d9456f11 ret_pc:
000000000044f3b0
RPC: <flush_tsb_user+0x78/0xa0>
l0: fffff80002870380 l1: 0000000000000001 l2: 0000080000000000 l3:
0000000000001fff
l4: fffff800ff7890b0 l5: 0000000000000001 l6: 0000000000002000 l7:
000007feffffffff
i0: fffff80002870378 i1: 0000000000000000 i2: fffff8008e95dff8 i3:
bc000000d11766d0
i4: fffff800d116afc0 i5: 00000000000474ae i6: fffff800d9456fd1 i7:
000000000044ebc8
I7: <flush_tlb_pending+0x30/0x80>
Caller[000000000044ebc8]: flush_tlb_pending+0x30/0x80
Caller[000000000044edf8]: tlb_batch_add+0x1e0/0x200
Caller[00000000004a76dc]: mprotect_fixup+0x3a4/0x4a0
Caller[00000000004bf4d4]: setup_arg_pages+0x9c/0x2e0
Caller[000000000044cc74]: load_elf_binary+0x4dc/0x1740
Caller[00000000004be6c0]: search_binary_handler+0xa8/0x2c0
Caller[00000000004eeed0]: compat_do_execve+0x138/0x160
Caller[00000000004481dc]: sparc32_execve+0x44/0xc0
Caller[00000000004061d4]: linux_sparc_syscall32+0x3c/0x40
Caller[00000000f7dfa724]: 0xf7dfa72c
Instruction DUMP: 01000000  01000000  05000020 <c2da0280> 97307020
808ac002  1247fffd  8143e001  80a04009

	After this, I cannot halt system.

	Regards,

	JKB

