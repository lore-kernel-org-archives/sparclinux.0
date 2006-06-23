From: Daniel Smolik <marvin@sitour.cz>
Date: Fri, 23 Jun 2006 09:52:05 +0000
Subject: Prom console
Message-Id: <449BB9C5.1070701@sitour.cz>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I install on my E250 2.6.17 and enable PROM console (I have Raptor FB) 
and after few minutes I have in dmesg this:
             \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
gpm(1859): Kernel illegal instruction [#1]
TSTATE: 0000008811f09601 TPC: 00000000f00606b8 TNPC: 00000000f003c6b0 Y: 
0000000                                 0    Not tainted
TPC: <0xf00606b8>
g0: 0000000000000000 g1: 000000000070ec90 g2: 00000000f0000000 g3: 
00000000fffe0                                 000
g4: 0000000040404040 g5: 00000000f00606a8 g6: 00000000fffefe28 g7: 
00000000fffee                                 f98
o0: 00000000f0014a38 o1: 0000000000000f20 o2: 0000000000000010 o3: 
0000000000000                                 027
o4: 0000000000000000 o5: 0000000000000000 sp: 00000000fff895c1 ret_pc: 
00000000f                                 006069c
RPC: <0xf006069c>
l0: 000000000003c6b0 l1: 00000000f00b7faf l2: 0000000000000001 l3: 
0000000000000                                 000
l4: 0000000000000005 l5: 0000000000000005 l6: 0000000000000000 l7: 
0000000000000                                 000
i0: 000000000070ec98 i1: 0000000000000a4e i2: 00000000ff8d5d1d i3: 
0000000000000                                 04e
i4: 00000000004f0000 i5: 0000000000210000 i6: 00000000fff89681 i7: 
0000000000517                                 ce0
I7: <prom_cif_interface+0x20/0x3c>
Instruction DUMP: 00008964  7ffe9e59  8c21a008 <00043048> 0003c5e0 
00008964  7f                                 fe9e54  8c21a008  000087cc

What does it mean ?

			Thanks
					Dan


