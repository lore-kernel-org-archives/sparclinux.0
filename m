From: Vincent Cojot <coyote@step.polymtl.ca>
Date: Thu, 18 Mar 2004 16:33:57 +0000
Subject: Re: 'Inconsistent console: input 3, output 3' with 2.4.25
Message-Id: <Pine.GSO.4.58.0403181129480.12102@step.polymtl.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.58.0403180843540.12102@step.polymtl.ca>
In-Reply-To: <Pine.GSO.4.58.0403180843540.12102@step.polymtl.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Just a quick follow-up, sorry about the noise.

Got a nice Oops by using 'boot net -p console=ssp-serial'. Log below..

Vincent

{e0} ok boot net -p console=ssp-serial
Boot device: /pci@fc,700000/pci@1/network@0  File and args: -p console=ssp-serial
100 Mbps HDX Link up
Timeout waiting for ARP/RARP packet
Timeout waiting for ARP/RARP packet
Timeout waiting for ARP/RARP packet
Timeout waiting for ARP/RARP packet
Timeout waiting for ARP/RARP packet
1f5000 TILO
Selecting sun4u kernel...
/
PROMLIB: Sun IEEE Boot Prom 4.7.6 2003/02/13 18:57
<4>Linux version 2.4.25-0.1sparcBOOT (root@u1sparc.j-son.org) (gcc driver version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release) executing gcc version egcs-2.92.11) #1 Wed Mar 10 18:55:19 CET 2004
<4>ARCH: SUN4U
Linux version 2.4.25-0.1sparcBOOT (root@u1sparc.j-son.org) (gcc driver version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release) executing gcc version egcs-2.92.11) #1 Wed Mar 10 18:55:19 CET 2004
<4>ARCH: SUN4U
ARCH: SUN4U
Ethernet address: 00:00:be:a9:03:3f
Remapping the kernel... done.
TRAPLOG: Error at trap level 0x2, dumping track stack.
TRAPLOG: Trap level 1 TSTATE[0000008880001401] TPC[00000000f01462a4] TNPC[00000000f01462a8] TT[64]
TRAPLOG: Trap level 2 TSTATE[0000009880041401] TPC[000000000040f32c] TNPC[000000000040f330] TT[32]
TRAPLOG: Trap level 3 TSTATE[0000000000000000] TPC[fffffffffffffffc] TNPC[fffffffffffffffc] TT[1ff]
TRAPLOG: Trap level 4 TSTATE[0000000000000000] TPC[fffffffffffffffc] TNPC[fffffffffffffffc] TT[1ff]
              \|/ ____ \|/
<4>              "@'/ .. \`@"
<4>              /_| \__/ |_\
<4>                 \__U_/
              "@'/ .. \`@"
<4>              /_| \__/ |_\
<4>                 \__U_/
              /_| \__/ |_\
<4>                 \__U_/
                 \__U_/
swapper(0): TL1: Data Access Exception
TSTATE: 0000009880041401 TPC: 000000000040f32c TNPC: 000000000040f330 Y: 00000000    Not tainted
g0: 0000000000000000 g1: 0000000000000001 g2: 00000000f0000000 g3: 00000000fff78000
g4: 0000000000000007 g5: 00000000f0029830 g6: 00000000fea0a678 g7: 00000000fea097a0
o0: 00000000f0014f24 o1: 0000000000000000 o2: 000000000000000d o3: 0000000000612230
o4: 000000000072e400 o5: 0000000000000006 sp: 00000000fef7b471 ret_pc: 00000000f000fe90
l0: 00000000f01462a4 l1: 00000000f014629f l2: 0000000000000001 l3: 0000000000000000
l4: 0000000000000004 l5: 0000000000000004 l6: 0000000000090420 l7: 00000000fef083c0
i0: 00000000007302f0 i1: 00000000006c6100 i2: 00000000006c6280 i3: 0000000000000180
i4: 00000000006c6410 i5: 0000000000653000 i6: 00000000fef7b571 i7: 00000000005c7fb0
Instruction DUMP: 8d313017  8c09a7ff  8d29b002 <ca814286> 02f16684  8b29700b  8d31300d  8c09a3ff  8d29b003
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 Press L1-A to return to the boot prom


