From: BERTRAND Joel <joel.bertrand@systella.fr>
Date: Mon, 21 Apr 2008 21:43:20 +0000
Subject: [2.6.25] Oops on U60/SMP
Message-Id: <480D0A78.6020408@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	Regression found in 2.6.25: seems only occurs with 2.6.25 (I cannot 
reproduce this bug, but it only occurs when I run program that mkes a 
lot of fork()). 2.6.24.3 does not have this bug. I haven't tried 2.6.24.4.

Unable to handle kernel paging request in mna handler<1> at virtual 
address 0000000023de8a74
current->{active_,}mm->context = 00000000000016ad
current->{active_,}mm->pgd = fffff800ad12e000
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
optimisation.rp(7920): Oops [#1]
TSTATE: 0000004411009601 TPC: 0000000000633290 TNPC: 00000000006331c0 Y: 
00000000    Not tainted
TPC: <skb_drop_list+0x18/0x40>
g0: fffff80027252340 g1: 0000000023de8a74 g2: fffff8002cbd7ec0 g3: 
0000000013000800
g4: fffff800a1207900 g5: fffff8001f83a000 g6: fffff8002f0a0000 g7: 
0000000000000798
o0: 0000000023de8a74 o1: fffff800272523dc o2: 0000000000000001 o3: 
00000000ff8d5ba0
o4: 0000000000000000 o5: 0000000000000034 sp: fffff8002f0a2ed1 ret_pc: 
000000000063328c
RPC: <skb_drop_list+0x14/0x40>
l0: fffff80027252340 l1: 00000000000005a8 l2: 0000000000000000 l3: 
00000000ff8d5a38
l4: 00000000f4761e50 l5: 0000000000000000 l6: 0000000000000000 l7: 
00000000f7c0a314
i0: fffff8002cbd7ed0 i1: fffff800ad219230 i2: 0000000000000001 i3: 
0000000000000032
i4: 00000000f4707015 i5: 0000000000000004 i6: fffff8002f0a2f91 i7: 
0000000000633370
I7: <skb_release_data+0xb8/0xe0>
Caller[0000000000633370]: skb_release_data+0xb8/0xe0
Caller[0000000000633104]: __kfree_skb+0xc/0xc0
Caller[000000000066d6bc]: tcp_recvmsg+0x6e4/0x900
Caller[000000000062dd94]: sock_common_recvmsg+0x3c/0x60
Caller[000000000062c388]: sock_recvmsg+0x90/0xc0
Caller[000000000062d434]: sys_recvfrom+0xbc/0x120
Caller[0000000000406214]: linux_sparc_syscall32+0x3c/0x40
Caller[00000000f7bbf608]: 0xf7bbf610
Instruction DUMP: d05e0000  c0760000  7fffffcd <e05a0000> 0afc3ffe 
90100010  81cfe008  01000000  30680007

	Regards,

	JKB
