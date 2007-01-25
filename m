From: Vince Weaver <vince@deater.net>
Date: Thu, 25 Jan 2007 03:00:12 +0000
Subject: Re: kernel BUG at arch/sparc64/mm/fault.c:413!
Message-Id: <Pine.LNX.4.64.0701242153330.19586@pianoman.cluster.toy>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0701181328230.8124@pianoman.cluster.toy>
In-Reply-To: <Pine.LNX.4.64.0701181328230.8124@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


> What distribution and version are you running?  I tried to dump
> the code at address 0x1a368 of the /bin/sh binary running on
> Ubuntu Dapper and it didn't show a code location which could
> trigger this code path.

I am running Ubuntu Feisty.  (probably a bit too new, I was having=20
problems getting ldap/autofs working and thought maybe newer would be=20
better).

The code surrounding that address is:

1a360:       01 00 00 00     nop
1a364:       9d e3 bf 90     save  %sp, -112, %sp
1a368:       40 00 70 33     call  36434 <malloc@plt>
1a36c:       90 10 00 18     mov  %i0, %o0
1a370:       80 a2 20 00     cmp  %o0, 0
1a374:       02 80 00 04     be  1a384 <_IO_stdin_used-0x8b84>
1a378:       b0 10 00 08     mov  %o0, %i0
1a37c:       81 c7 e0 08     ret


> Try to print out the "fault_code", "address", and regs->tpc value
> when this triggers.

I've reproduced it, here are the results (the bug is still at line 413,=20
my debug code pushed it down a bit):


[  263.773194] VMW: fault_code=3D4 address=FF0cc000 regs->tpcp131660

[  263.773220] kernel BUG at arch/sparc64/mm/fault.c:417!
[  263.773238]               \|/ ____ \|/
[  263.773244]               "@'/ .. \`@"
[  263.773250]               /_| \__/ |_\
[  263.773256]                  \__U_/
[  263.773269] sh(6396): Kernel bad sw trap 5 [#1]
[  263.773286] TSTATE: 0000000011001607 TPC: 00000000006903ec TNPC: 0000000=
0006903f0 Y: 00000000    Not tainted
[  263.773314] TPC: <do_sparc64_fault+0x394/0x700>
[  263.773328] g0: fffff801f9e4c000 g1: 0000000000000000 g2: 00000000000000=
01 g3: 0000000000000000
[  263.773350] g4: fffff801fd760540 g5: fffff80003ce3fc0 g6: fffff801f9e4c0=
00 g7: 0000000000000000
[  263.773368] o0: 000000000000003d o1: 00000000007182a0 o2: 00000000000001=
a1 o3: 0000000070131660
[  263.773391] o4: 4849001106491d49 o5: fffff801fb8f1060 sp: fffff801f9e4f5=
c1 ret_pc: 00000000006903e4
[  263.773411] RPC: <do_sparc64_fault+0x38c/0x700>
[  263.773427] l0: fffff801ffa8f9e0 l1: 0000000000000004 l2: fffff801fb8f10=
60 l3: 00000000ff0cc000
[  263.773447] l4: 0000000000000000 l5: fffff801fb8f10c0 l6: fffff801f9e4c0=
00 l7: 0000000011009006
[  263.773466] i0: fffff801f9e4ff60 i1: 0000000000000033 i2: 0000000000024f=
d2 i3: 0000000000000003
[  263.773485] i4: 0000000000000000 i5: 0000000000000003 i6: fffff801f9e4f6=
a1 i7: 0000000000404d6c
[  263.773509] I7: <sparc64_realfault_common+0x18/0x20>
[  263.773521] Caller[0000000000404d6c]: sparc64_realfault_common+0x18/0x20
[  263.773542] Caller[000000000001a368]: 0x1a370
[  263.773573] Instruction DUMP: 921021a1  7ff62ae7  901222a0 <91d02005> 12=
480032  8208e002  8208e005  02c84066  030000c0

Let me know if you need more info,

Thanks

Vince
