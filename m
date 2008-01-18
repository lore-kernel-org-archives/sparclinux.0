From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Fri, 18 Jan 2008 10:40:18 +0000
Subject: [2.6.23.12] BUG! in file locking routine
Message-Id: <47908212.9070501@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	In dmesg, I can see this morning :

kernel BUG at fs/locks.c:173!
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
sendmail-mta(31737): Kernel bad sw trap 5 [#1]
TSTATE: 0000009980009600 TPC: 00000000004c71c8 TNPC: 00000000004c71cc Y: 
00000000    Not tainted
TPC: <locks_free_lock+0x90/0xa0>
g0: fffff80035a67221 g1: 0000000000000000 g2: 0000000000000001 g3: 
fffff80035a64000
g4: fffff8007bb65720 g5: fffff7ffff87e000 g6: fffff80035a64000 g7: 
000000000072ea68
o0: 0000000000000021 o1: 00000000006e7840 o2: 00000000000000ad o3: 
00000000004c758c
o4: 7fffffffffffffff o5: 0000000000000000 sp: fffff80035a67271 ret_pc: 
00000000004c71c0
RPC: <locks_free_lock+0x88/0xa0>
l0: 0000000100000000 l1: fffff8007bb65720 l2: 00000000ffd50210 l3: 
00000001ffd4f070
l4: 00000001ffd4f104 l5: 00000001f7daa898 l6: 0000000001000000 l7: 
00000000700fa738
i0: fffff8007d34f9c8 i1: fffff8007d34fb58 i2: fffff8007d34e3e8 i3: 
fffffffffffffe60
i4: fffff80035a67cd0 i5: 0000000000000000 i6: fffff80035a67331 i7: 
00000000004c75e0
I7: <__posix_lock_file+0x88/0x4a0>
Caller[00000000004c75e0]: __posix_lock_file+0x88/0x4a0
Caller[00000000004c7c14]: fcntl_setlk+0xfc/0x2a0
Caller[00000000004c3fa0]: sys_fcntl+0x228/0x360
Caller[00000000004eb448]: compat_sys_fcntl64+0xd0/0x340
Caller[00000000004062d4]: linux_sparc_syscall32+0x3c/0x40
Caller[00000000f79df5cc]: 0xf79df5d4
Instruction DUMP: 921020ad  7ffd8ed8  90122040 <91d02005> 30680005 
01000000  01000000  01000000  01000000
Root fermat:[/etc] >

	Host system is a U2/SMP (2*300 MHz/2 GB RAM) running a 2.6.23.12 
official linux kernel.

	Regards,

	JKB
