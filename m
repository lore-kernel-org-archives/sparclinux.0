From: "Michael Marineau" <mike@marineau.org>
Date: Thu, 01 Mar 2007 07:13:20 +0000
Subject: Oops in tcp_sendmsg on T[12]000
Message-Id: <c0526ddf0702282313i4c815b1ta31cdb159ae84ba4@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This bug was originally reported for a T1000 a while back:
http://thread.gmane.org/gmane.linux.ports.sparc/6361/focusd13

On a T2000 I am able to trigger the Oops in 5 to 50 minutes by pushing
a ton of traffic over lo with netcat:
nc -l -p 9000 >/dev/null
nc localhost </dev/zero

This works on 2.6.19, 2.6.20, and 2.6.21-rc2.  I have added the
debugging statement suggested in the original thread, and it's result
along with the Oops is posted below.  I've dug through the code a bit,
but so far the issue is far beyond me. Thanks for any help!

[ 3416.753596] TCP DEBUG: Bogus skb->nohdr, word[58080000]
[ 3416.753618] kernel BUG at include/linux/skbuff.h:482!
[ 3416.753634]               \|/ ____ \|/
[ 3416.753639]               "@'/ .. \`@"
[ 3416.753645]               /_| \__/ |_\
[ 3416.753651]                  \__U_/
[ 3416.753697] nc(4770): Kernel bad sw trap 5 [#1]
[ 3416.753712] TSTATE: 0000000011001604 TPC: 000000000063ca1c TNPC:
000000000063ca20 Y: 00000000    Not tainted
[ 3416.753738] TPC: <tcp_sendmsg+0x420/0xc68>
[ 3416.753750] g0: 00000000000001c0 g1: 0000000000000001 g2:
0000000000730f08 g3: 0000000000730f10
[ 3416.753770] g4: fffff807fc07c960 g5: fffff8000e5d7d40 g6:
fffff807fd41c000 g7: 0000000000000000
[ 3416.753788] o0: 000000000000003c o1: 00000000006dfb60 o2:
00000000000001e2 o3: ffffffffffffffff
[ 3416.753808] o4: 0000000000002000 o5: fffff807fcf9c140 sp:
fffff807fd41f051 ret_pc: 000000000063ca14
[ 3416.753829] RPC: <tcp_sendmsg+0x418/0xc68>
[ 3416.753842] l0: 0000000008000000 l1: fffff807fd085ca0 l2:
000000000041220c l3: 0000000000000000
[ 3416.753860] l4: 0000000000000010 l5: 0000000000000003 l6:
fffff807fd41c000 l7: 00000000004953b0
[ 3416.753879] i0: ffffffffffffffe0 i1: fffff807fad93260 i2:
0000000000000000 i3: 0000000000000000
[ 3416.753897] i4: 0000000000002000 i5: 0000000000026080 i6:
fffff807fd41f151 i7: 000000000065b95c
[ 3416.753920] I7: <inet_sendmsg+0x48/0x54>
[ 3416.753934] Caller[000000000065b95c]: inet_sendmsg+0x48/0x54
[ 3416.753952] Caller[000000000060d310]: sock_aio_write+0xe4/0xf0
[ 3416.753972] Caller[00000000004951f8]: do_sync_write+0x88/0xd0
[ 3416.753994] Caller[00000000004952cc]: vfs_write+0x8c/0x108
[ 3416.754011] Caller[00000000004953dc]: sys_write+0x34/0x60
[ 3416.754028] Caller[0000000000406b94]: linux_sparc_syscall32+0x3c/0x40
[ 3416.754053] Caller[0000000000012e10]: 0x12e18
[ 3416.754069] Instruction DUMP: 11001b7e  7ff76ec3  90122360
<91d02005> c65c60d8  84050010  8204c001  c4246088  80a04003

-- 
Michael Marineau
Oregon State University
mike@marineau.org
