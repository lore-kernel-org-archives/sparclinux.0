From: Christian Guggenberger
Date: Fri, 30 Jan 2004 10:37:32 +0000
Subject: Re: SILO 1.4.2 released
Message-Id: <20040130113732.A21900@pc9391.uni-regensburg.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_sm4nu43k4a2Rpi"
List-Id: <sparclinux.vger.kernel.org>
References: <20040129182954.GK532@phunnypharm.org>
In-Reply-To: <20040129182954.GK532@phunnypharm.org>
To: sparclinux@vger.kernel.org


--=_sm4nu43k4a2Rpi
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

> I'm a little disappointed. I haven't gotten any feedback from people
> testing this new version. So either no one cares, or it works good and
> people don't want to waste their time sending "worked for me" emails :)

well, I get this  (attached) on a Dual UE2, running debian/unstable, with 
silo-1.4.3
(deb package) and linux-2.6.2-rc2 (3.5 MB).
On the other side, linux-2.4.23-rc4 (2.9 MB) boots fine. both kernels booted 
nicely with silo-1.3.2.

cheers.
Christian
  

--=_sm4nu43k4a2Rpi
Content-Type: text/plain
Content-Disposition: attachment; filename="dmesg.txt"

Jan 30 11:10:38 eclipse kernel: kjournald starting.  Commit interval 5 seconds
Jan 30 11:10:38 eclipse kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan 30 11:10:38 eclipse kernel: VFS: Mounted root (ext3 filesystem) readonly.
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: Badness in map_area_pte at mm/vmalloc.c:101
Jan 30 11:10:38 eclipse kernel: [000000000048f85c] [000000000048fe8c] [0000000000493920] [0000000000411174] [0000000000010d3c] 
Jan 30 11:10:38 eclipse kernel: TRAPLOG: Error at trap level 0x2, dumping track stack.
Jan 30 11:10:38 eclipse kernel: TRAPLOG: Trap level 1 TSTATE[0000004411009606] TPC[000000000048f678] TNPC[000000000048f67c] TT[c0]
Jan 30 11:10:38 eclipse kernel: TRAPLOG: Trap level 2 TSTATE[0000004411009505] TPC[0000000000409828] TNPC[000000000040982c] TT[32]
Jan 30 11:10:38 eclipse kernel: TRAPLOG: Trap level 3 TSTATE[0000004411009505] TPC[000000000040d904] TNPC[000000000040d908] TT[68]
Jan 30 11:10:38 eclipse kernel: TRAPLOG: Trap level 4 TSTATE[0000009911049405] TPC[0000000000408d20] TNPC[0000000000408d24] TT[68]
Jan 30 11:10:38 eclipse kernel:               \|/ ____ \|/
Jan 30 11:10:38 eclipse kernel:               "@'/ .. \`@"
Jan 30 11:10:38 eclipse kernel:               /_| \__/ |_\
Jan 30 11:10:38 eclipse kernel:                  \__U_/
Jan 30 11:10:38 eclipse kernel: swapon(34): TL1: Data Access Exception [#1]
Jan 30 11:10:38 eclipse kernel: TSTATE: 0000004411009505 TPC: 0000000000409828 TNPC: 000000000040982c Y: 00000000    Not tainted
Jan 30 11:10:38 eclipse kernel: TPC: <tl0_f0n+0x28/0x80>
Jan 30 11:10:38 eclipse kernel: g0: 0000000000000065 g1: fffff800479bf2e8 g2: 0000000000000000 g3: 0000000000000000
Jan 30 11:10:38 eclipse kernel: g4: fffff800478186a0 g5: 0000000000000000 g6: fffff80047478000 g7: 0000000000000000
Jan 30 11:10:38 eclipse kernel: o0: fffffc045907f8a8 o1: 000000000002a000 o2: fffff80000f4b528 o3: 8000000000000fb6
Jan 30 11:10:38 eclipse kernel: o4: fffff8004747bdb8 o5: 0000000000000000 sp: fffff8004747b381 ret_pc: 000000000048f6d8
Jan 30 11:10:38 eclipse kernel: RPC: <map_area_pmd+0x58/0xa0>
Jan 30 11:10:38 eclipse kernel: l0: 0000000000800000 l1: 000000000064e800 l2: ffffffffff800000 l3: fffff8004747bbb0
Jan 30 11:10:38 eclipse kernel: l4: fffff80047f007f0 l5: fffff80047f00830 l6: 0000000000000000 l7: 0000000000000000
Jan 30 11:10:38 eclipse kernel: i0: ffffff000d008a04 i1: 0000000140000000 i2: ffffffffffffffff i3: 0000000003ffffff
Jan 30 11:10:38 eclipse kernel: i4: fffff80000f7b220 i5: 00000000ffff9078 i6: fffff8004747ae41 i7: 000000000045e1f4
Jan 30 11:10:38 eclipse kernel: I7: <__mod_timer+0x254/0x380>
Jan 30 11:10:38 eclipse kernel: Instruction DUMP: ee5ba837  f05ba83f  f25ba847 <f45ba84f> f65ba857  f85ba85f  fa5ba867  fc5ba86f  fe5ba877 
Jan 30 11:10:38 eclipse kernel: note: swapon[34] exited with preempt_count 1
Jan 30 11:10:38 eclipse kernel: EXT3 FS on sda1, internal journal
Jan 30 11:10:38 eclipse kernel: kjournald starting.  Commit interval 5 seconds

--=_sm4nu43k4a2Rpi--

