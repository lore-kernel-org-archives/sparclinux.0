From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sun, 04 Jan 2004 15:59:49 +0000
Subject: [SPARC32] Early kernel panic with 2.6.1rc1
Message-Id: <1073231988.22653.23.camel@zorak>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

This panic happens when I've got a keyboard on it too, I just can't get
it all, unless I pull the keyboard and boot it -p over serial.
NOTE: This is an UP kernel, even though the SS20 is SMP.

SILO boot: 2.6 -p
Loading initial ramdisk....
PROMLIB: obio_ranges 5
PROMLIB: Sun Boot Prom Version 3 Revision 2
Linux version 2.6.0-1.23sparc2 (root@arthur.devel.redhat.com) (gcc
version 3.3.1 20030915 (Aurora Linux 3.3.1-5sparc)) #1 Sun J4ARCH: SUN4M
TYPE: Sun4m SparcStation10/20
Ethernet address: 8:0:20:73:b8:f
Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz).
Patching kernel for srmmu[TI Viking/MXCC]/iommu
31MB HIGHMEM available.
On node 0 totalpages: 23663
  DMA zone: 15648 pages, LIFO batch:3
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 8015 pages, LIFO batch:1
HighMem zone: 8015 pages, LIFO batch:1
Booting Linux...
Found CPU 0 <node=FFd6f150,mid=3D8>
Found CPU 1 <node=FFd6f510,mid=10>
Found 2 CPU prom device tree node(s).
Power off control detected.
Building zonelist for node : 0
Kernel command line: root=3D/dev/sda2 ro -p
PID hash table entries: 2048 (order 11: 16384 bytes)
Console: colour dummy device 80x25
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context =3D ffffffff
tsk->{mm,active_mm}->pgd =3D fc000000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#1]
PSR: 40901fc0 PC: f00f29f0 NPC: f00f29f4 Y: 00000000    Not tainted
PC: <serial_out+0x24/0x50>
%G: 00000000 000003f8  00000000 00000000  0000000d f01ca800  f01bca90
000002e8
%O: f022d728 00000001  00000000 00000000  0001c200 00000000  f01be718
f00f4988
RPC: <serial8250_set_termios+0x210/0x35c>
%L: 00000013 0000000c  409010e1 0000000c  00000000 00000000  0000000b
00000e00
%I: f022d728 f01be7e0  00002580 00000010  f00d1d90 00000000  f01be780
f0207ac4
Caller[f0207ac4]: uart_set_options+0xc8/0x12c

Caller[f0207cf4]: serial8250_console_setup+0xa0/0xb0

Caller[f0032a60]: register_console+0x190/0x208

Caller[f0207d14]: serial8250_console_init+0x10/0x20

Caller[f0206c28]: console_init+0x34/0x50

Caller[f01f5cd0]: start_kernel+0xcc/0x228

Caller[f01f5790]: sun4c_continue_boot+0x314/0x324

Caller[00000000]: 0x0

Instruction DUMP: 22800003  c2022004  c2020000 <d4284009> 30800008=20
c20a2074  c6020000  82004009  82007fff
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 <0>Press L1-A to return to the boot prom

*****

I stripped the symbols from the kernel to make it small enough to build,
I'm going to rebuild it and run ksymoops on it (I assume that still is
the path in 2.6?)

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE=20
Red Hat Sales Engineer || Aurora SPARC Linux Project Leader

"The author's mathematical treatment of the conception of purpose is
novel and highly ingenious, but heretical and, so far as the present
social order is concerned, dangerous and potentially subversive. Not to
be published." -- Aldous Huxley's "Brave New World"

