From: Vince Weaver <vince@deater.net>
Date: Fri, 26 Jan 2007 03:21:00 +0000
Subject: Re: kernel BUG at arch/sparc64/mm/fault.c:413!
Message-Id: <Pine.LNX.4.64.0701252219310.22683@pianoman.cluster.toy>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0701181328230.8124@pianoman.cluster.toy>
In-Reply-To: <Pine.LNX.4.64.0701181328230.8124@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


>> Note, this patch is pretty straight forward, but I've only compile
>> tested it.  I'm about to test boot it myself right now.
>
> FWIW, it works fine for me :)

Unfortunately it didn't seem to fix things.  It ran a lot longer this=20
time, but eventually stopped with

[  597.730241] VMW: fault_code=3D4 address=FF564000 regs->tpcp179660
[  597.730266] kernel BUG at arch/sparc64/mm/fault.c:417!
[  597.730284]               \|/ ____ \|/
[  597.730290]               "@'/ .. \`@"
[  597.730296]               /_| \__/ |_\
[  597.730302]                  \__U_/
[  597.730315] sh(8775): Kernel bad sw trap 5 [#1]
[  597.730331] TSTATE: 0000000011001607 TPC: 00000000006903ec TNPC: 0000000=
0006903f0 Y: 00000000    Not tainted
[  597.730359] TPC: <do_sparc64_fault+0x394/0x700>
[  597.730374] g0: fffff801f91ac000 g1: 0000000000000000 g2: 00000000000000=
01 g3: 0000000000000000
[  597.730395] g4: fffff801fc8c9ae0 g5: fffff80003ca3fc0 g6: fffff801f91ac0=
00 g7: 0000000000000000
[  597.730414] o0: 000000000000003d o1: 00000000007182a0 o2: 00000000000001=
a1 o3: 0000000070179660
[  597.730436] o4: 4849001106491d49 o5: fffff801fa57c140 sp: fffff801f91af5=
c1 ret_pc: 00000000006903e4
[  597.730456] RPC: <do_sparc64_fault+0x38c/0x700>
[  597.730472] l0: fffff801fd945a88 l1: 0000000000000004 l2: fffff801fa57c1=
40 l3: 00000000ff564000
[  597.730493] l4: 0000000000000000 l5: fffff801fa57c1a0 l6: fffff801f91ac0=
00 l7: 0000000011009006
[  597.730512] i0: fffff801f91aff60 i1: 0000000000000033 i2: 0000000000024f=
d2 i3: 0000000000000003
[  597.730531] i4: 0000000000000000 i5: 0000000000000003 i6: fffff801f91af6=
a1 i7: 0000000000404d6c
[  597.730555] I7: <sparc64_realfault_common+0x18/0x20>
[  597.730566] Caller[0000000000404d6c]: sparc64_realfault_common+0x18/0x20
[  597.730587] Caller[000000000001a368]: 0x1a370
[  597.730617] Instruction DUMP: 921021a1  7ff62ae7  901222a0 <91d02005> 12=
480032  8208e002  8208e005  02c84066  030000c0

Vince
