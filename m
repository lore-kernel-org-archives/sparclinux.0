From: Jason Wever <weeve@gentoo.org>
Date: Thu, 23 Sep 2004 00:26:14 +0000
Subject: Re: Ultra 2 Enterprise: All 2.6.xx SMP kernels hardlock
Message-Id: <Pine.LNX.4.61.0409221820560.28580@stargazer.weeve.org>
List-Id: <sparclinux.vger.kernel.org>
References: <703d4eaa04092018404389859@mail.gmail.com>
In-Reply-To: <703d4eaa04092018404389859@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 21 Sep 2004, David S. Miller wrote:

> I see this too, try two things (which I haven't gotten around
> to trying yet):
>
> 1) boot with the "-p" option, this will log early
>   console messages

This in fact does yield the problem, which is a kernel panic or two.  Text 
is as follows;

Allocated 8 Megs of memory at 0x40000000 for kernel
Loaded kernel version 2.6.9

PROMLIB: Sun IEEE Boot Prom 4.13.4 2004/05/19 18:35
Linux version 2.6.9-rc2 (root@excelsior.weeve.org) (gcc version 3.3.4 
20040623 (
Gentoo Linux 3.3.4)) #7 Tue Sep 21 20:53:14 MDT 2004
ARCH: SUN4U
Ethernet address: 00:03:ba:0e:60:2e
Remapping the kernel... done.
Booting Linux...
Built 1 zonelists
Kernel command line: root=/dev/hda4 ro -p
PID hash table entries: 4096 (order: 12, 131072 bytes)
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000000
tsk->{mm,active_mm}->pgd = fffff8007f00ec00
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
swapper(0): Oops [#1]
TSTATE: 0000009980f09602 TPC: 00000000004507ac TNPC: 00000000004507b0 Y: 
00000000    Not tainted
TPC: <time_interpolator_update+0xc/0x260>
g0: 0000000000000000 g1: 00000000000f41a8 g2: 0000000000000000 g3: 
00000000000f41a8
g4: 000000000062a140 g5: 0000000000000000 g6: 0000000000626140 g7: 
0000000000000000
o0: 00000000246f0d06 o1: 000000000044bc20 o2: 0000000000000000 o3: 
0000000000020000
o4: 0000000000000080 o5: 0000000000000000 sp: 0000000000629041 ret_pc: 
000000000041ca64
RPC: <hbtick_get_tick+0x4/0x20>
l0: 0000000000001000 l1: 0000000000000018 l2: 00000000006fd000 l3: 
0000000000000004
l4: 00000000006fe3b0 l5: ffffffffffffffff l6: 0000000000704800 l7: 
00000000003a5400
i0: 00000000000f41a8 i1: 000000000044bcc0 i2: 0000000000000000 i3: 
000000000000000b
i4: 00000000006c2200 i5: 00000000006fd000 i6: 0000000000629101 i7: 
000000000044f988
I7: <update_wall_time_one_tick+0xa8/0x120>
Instruction DUMP: 9de3bf40  25001bf4  c45ca358 <c208a003> 80a06000 
0248006f  e0108000  c25ca358  80a42002
Kernel panic - not syncing: Aiee, killing interrupt handler!
  <0>Press L1-A to return to the boot prom
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000000
tsk->{mm,active_mm}->pgd = fffff8007f00ec00
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
swapper(0): Oops [#2]
TSTATE: 0000009980f09600 TPC: 00000000004507ac TNPC: 00000000004507b0 Y: 
00000000    Not tainted
TPC: <time_interpolator_update+0xc/0x260>
g0: 8000000000000000 g1: 00000000001e8350 g2: 0000000000000000 g3: 
00000000000f41a8
g4: 000000000062a140 g5: 0000000000000000 g6: 0000000000626140 g7: 
0000000000000000
o0: 0000000024f67d21 o1: 00000000006f6861 o2: 00000000006f6800 o3: 
0000000000000020
o4: 000000000044f988 o5: 00000000006f6818 sp: 0000000000628411 ret_pc: 
000000000041ca64
RPC: <hbtick_get_tick+0x4/0x20>
l0: 0000000000000006 l1: 000000000062a140 l2: 00000000006fd000 l3: 
fffffffffffffff0
l4: 0000000000000004 l5: 0000000000000004 l6: 00000000fff59701 l7: 
00000000f0055310
i0: 00000000000f41a8 i1: 0000000000000001 i2: 0000000000629420 i3: 
00000000005eeb00
i4: 0000000000000001 i5: 00000000006fd000 i6: 00000000006284d1 i7: 
000000000044f988
I7: <update_wall_time_one_tick+0xa8/0x120>
Instruction DUMP: 9de3bf40  25001bf4  c45ca358 <c208a003> 80a06000 
0248006f  e0108000  c25ca358  80a42002
Kernel panic - not syncing: Aiee, killing interrupt handler!
  <0>Press L1-A to return to the boot prom


> 2) try also "console=prom" and make sure CONFIG_PROM_CONSOLE

This had the same result as a regular boot where it just appeared to stop 
with no useful information.

- -- 
Jason Wever
Gentoo/Sparc Co-Team Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBUhgpdKvgdVioq28RAihPAJ0V+nnJuIiJhH9bVF4sR583kgQPIgCeJHVe
ReMIYbhoPY9fRLXyjxvreME=EKxN
-----END PGP SIGNATURE-----
