From: Willem de Groot <willem@byte.nl>
Date: Mon, 22 Mar 2004 09:33:20 +0000
Subject: temp solution: sun fire v100 / gcc 3 woes
Message-Id: <Pine.LNX.4.58.0403212214380.24178@passoa.internal>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


After spending 3 days tweaking, I figured it out! Gcc 3.2 / 3.3 seems
unable to build a kernel for my Sun Fire V100. It compiles without fatal
errors, but upon booting the Sun crashes:

SILO Version 1.4.4
boot: 2.4.25 -p
Allocated 8 Megs of memory at 0x40000000 for kernel
Loaded kernel version 2.4.25
Illegal Instruction
ok

I tried kernels 2.4.25, 2.4.26-pre3 and 2.6.4 and gcc 3.2 and 3.3 (from
Debian Testing) but to no avail.

Also, the Debian package kernel-image-2.4.24-sparc64_35_sparc.deb gives
the same error.

Luckily, compiling with egcs64_19980921 works ok! (through editing
arch/sparc64/Makefile)

The Sun Fire V100 is actually a Netra X1 plus a CDrom drive and upgraded
PROM (4.0.18 in stead of 4.0.6). The Netra X1 works fine though with a
gcc3 compiled kernel. Strange huh? But it gets stranger... Some years ago
I bougt two Sun Fire V100's. Only this week I found out that they give
different bootup messages:

Sun Fire V100 (UltraSPARC-IIe 548MHz), No Keyboard
OpenBoot 4.0, 768 MB memory installed, Serial #51606773.
Ethernet address 0:3:ba:13:74:f5, Host ID: 831374f5.

opposite to:

Sun Netra X1 (UltraSPARC-IIe 548MHz), No Keyboard
OpenBoot 4.0, 768 MB memory installed, Serial #51800813.
Ethernet address 0:3:ba:16:6a:ed, Host ID: 83166aed.

They have the same PROM (4.0.16) though. But.. the V100 which names itself
X1, actually boots fine with a gcc3 compiled kernel. The other V100, which
seems to be a true V100 (but also PROM 4.0.16) will only boot an
egcs64-compiled kernel.

I hope this information is useful for someone :)

Willem

