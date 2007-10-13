From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Sat, 13 Oct 2007 20:16:23 +0000
Subject: Re: [Bug 9160] New: kernel oops in firewire_ohci
Message-Id: <47112797.7060003@s5r6.in-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

For the linux1394-devel and sparclinux mailinglists to see:

Since Linux 2.6.23, the firewire-ohci driver oopses on startup when it
sets up its AR DMA contexts (AR =3D asynchronous reception).  See quote
from bugzilla below.

The last modification that directly affected firewire-ohci's AR DMA was
already before 2.6.22 (firewire: fix async reception on big endian
machines).
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dhist=
ory;f=3Ddrivers/firewire/fw-ohci.c

Patches to fw-ohci.c in 2.6.23 which are not in 2.6.22.9:

	firewire: missing newline in printk
	firewire: fw-ohci: flush MMIO write before msleep
	firewire: fw-ohci: dma_free_coherent needs IRQs enabled

They are all obviously unrelated to the bug.

bugme-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=9160
>=20
>            Summary: kernel oops in firewire_ohci
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.23.1
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: IEEE1394
>         AssignedTo: drivers_ieee1394@kernel-bugs.osdl.org
>         ReportedBy: seraph@xs4all.nl
>=20
>=20
> Most recent kernel where this bug did not occur: 2.6.22.9
> Distribution: Gentoo
> Hardware Environment: Sparc64 (Blade 100 UltraSPARC 2e)
> Software Environment:
> Problem Description:
>=20
> I found a kernel oops in /var/log/messages after booting both my Blade 10=
0s.
> The oops appears to have triggered by firewire_ohci, but I'm no kernel ha=
cker
> and could be mistaken.
>=20
> Here is the text of one of them. The one from the other machine is identi=
cal
> except for the timestamps and machine name.
>=20
> Oct 13 20:26:04 succubus OOPS: Bogus kernel PC [0000000000000000] in faul=
t handler
> Oct 13 20:26:04 succubus OOPS: RPC [0000000010068cd0]
> Oct 13 20:26:04 succubus RPC: <ar_context_add_page+0xd8/0x160 [firewire_o=
hci]>
> Oct 13 20:26:04 succubus OOPS: Fault was to vaddr[1004e000]
> Oct 13 20:26:04 succubus Call Trace:
> Oct 13 20:26:04 succubus [00000000004076f4] sparc64_realfault_common+0x18=
/0x20
> Oct 13 20:26:04 succubus [0000000010068cd0] ar_context_add_page+0xd8/0x16=
0 [firewire_ohci]
> Oct 13 20:26:04 succubus [0000000010068d90] ar_context_init+0x38/0x60 [fi=
rewire_ohci]
> Oct 13 20:26:04 succubus [000000001006ac50] pci_probe+0xf8/0x340 [firewir=
e_ohci]
> Oct 13 20:26:04 succubus [00000000005299bc] pci_device_probe+0x64/0xa0
> Oct 13 20:26:04 succubus [0000000000550a28] driver_probe_device+0x90/0x1c0
> Oct 13 20:26:04 succubus [0000000000550bc0] __driver_attach+0x68/0x80
> Oct 13 20:26:04 succubus [000000000054fe5c] bus_for_each_dev+0x44/0x80
> Oct 13 20:26:04 succubus [0000000000550218] bus_add_driver+0x80/0x1c0
> Oct 13 20:26:04 succubus [0000000000529b7c] __pci_register_driver+0x44/0x=
a0
> Oct 13 20:26:04 succubus [000000000047d5cc] sys_init_module+0x134/0x1400
> Oct 13 20:26:04 succubus [0000000000406094] linux_sparc_syscall32+0x3c/0x=
40
> Oct 13 20:26:04 succubus [00000000000133d8] 0x133e0
> Oct 13 20:26:04 succubus Unable to handle kernel NULL pointer dereference
> Oct 13 20:26:04 succubus tsk->{mm,active_mm}->context =3D 00000000000001f9
> Oct 13 20:26:04 succubus tsk->{mm,active_mm}->pgd =3D fffff8004f9f8000
> Oct 13 20:26:04 succubus \|/ ____ \|/
> Oct 13 20:26:04 succubus "@'/ .. \`@"
> Oct 13 20:26:04 succubus /_| \__/ |_\
> Oct 13 20:26:04 succubus \__U_/
> Oct 13 20:26:04 succubus modprobe(648): Oops [#1]
> Oct 13 20:26:04 succubus TSTATE: 0000001911009601 TPC: 0000000000000000 T=
NPC: 0000000000000004 Y: 00000000    Not tainted
> Oct 13 20:26:04 succubus TPC: <0x8>
> Oct 13 20:26:04 succubus g0: 0000000000470a40 g1: 00000000005d2b28 g2: 00=
00000000000000 g3: 0000000000000000
> Oct 13 20:26:04 succubus g4: fffff8004f393480 g5: 0000000000000098 g6: ff=
fff8004fa74000 g7: 00c06500180065c0
> Oct 13 20:26:04 succubus o0: fffff8004effb870 o1: 00000000c0650000 o2: 00=
00000000002000 o3: 0000000000000000
> Oct 13 20:26:04 succubus o4: 0000000000000004 o5: 000001ff00420000 sp: ff=
fff8004fa76e71 ret_pc: 0000000010068cd0
> Oct 13 20:26:04 succubus RPC: <ar_context_add_page+0xd8/0x160 [firewire_o=
hci]>
> Oct 13 20:26:04 succubus l0: fffff8004fba4000 l1: 00000000c0650000 l2: ff=
fff8004effb870 l3: fffff8004f608d90
> Oct 13 20:26:04 succubus l4: 000000000063cc00 l5: 0000000000ff0000 l6: ff=
fff8004fa776e0 l7: fffffffffffffff0
> Oct 13 20:26:04 succubus i0: 000000000000ff00 i1: 0000000010069cc0 i2: ff=
fff8004f608d90 i3: 0000000000000000
> Oct 13 20:26:04 succubus i4: 0000000000000040 i5: 0000000000000000 i6: ff=
fff8004fa76f31 i7: 0000000010068d90
> Oct 13 20:26:04 succubus I7: <ar_context_init+0x38/0x60 [firewire_ohci]>
> Oct 13 20:26:04 succubus Caller[0000000010068d90]: ar_context_init+0x38/0=
x60 [firewire_ohci]
> Oct 13 20:26:04 succubus Caller[000000001006ac50]: pci_probe+0xf8/0x340 [=
firewire_ohci]
> Oct 13 20:26:04 succubus Caller[00000000005299bc]: pci_device_probe+0x64/=
0xa0
> Oct 13 20:26:04 succubus Caller[0000000000550a28]: driver_probe_device+0x=
90/0x1c0
> Oct 13 20:26:04 succubus Caller[0000000000550bc0]: __driver_attach+0x68/0=
x80
> Oct 13 20:26:04 succubus Caller[000000000054fe5c]: bus_for_each_dev+0x44/=
0x80
> Oct 13 20:26:04 succubus Caller[0000000000550218]: bus_add_driver+0x80/0x=
1c0
> Oct 13 20:26:04 succubus Caller[0000000000529b7c]: __pci_register_driver+=
0x44/0xa0
> Oct 13 20:26:04 succubus Caller[000000000047d5cc]: sys_init_module+0x134/=
0x1400
> Oct 13 20:26:04 succubus Caller[0000000000406094]: linux_sparc_syscall32+=
0x3c/0x40
> Oct 13 20:26:04 succubus Caller[00000000000133d8]: 0x133e0
> Oct 13 20:26:04 succubus Instruction DUMP: 01000000  01000000  01000000
> <1>Unable to handle kernel NULL pointer dereference
> Oct 13 20:26:04 succubus tsk->{mm,active_mm}->context =3D 00000000000001f9
> Oct 13 20:26:04 succubus tsk->{mm,active_mm}->pgd =3D fffff8004f9f8000
> Oct 13 20:26:04 succubus \|/ ____ \|/
> Oct 13 20:26:04 succubus "@'/ .. \`@"
> Oct 13 20:26:04 succubus /_| \__/ |_\
> Oct 13 20:26:04 succubus \__U_/
> Oct 13 20:26:04 succubus modprobe(648): Oops [#2]
> Oct 13 20:26:04 succubus TSTATE: 0000004480009605 TPC: 0000000000428a5c T=
NPC: 0000000000428a60 Y: 00000000    Tainted: G      D
> Oct 13 20:26:04 succubus TPC: <instruction_dump+0x44/0xa0>
> Oct 13 20:26:04 succubus g0: 78745f6164645f70 g1: 000000000063def0 g2: 00=
00000000000000 g3: 000000000063dc00
> Oct 13 20:26:04 succubus g4: fffff8004f393480 g5: 0000000000000098 g6: ff=
fff8004fa74000 g7: 000000000063def0
> Oct 13 20:26:04 succubus o0: 00000000006050d0 o1: 000000000000003c o2: 00=
00000001000000 o3: 000000000000003e
> Oct 13 20:26:04 succubus o4: 0000000010068d90 o5: 000000000068d168 sp: ff=
fff8004fa76aa1 ret_pc: 0000000000428a80
> Oct 13 20:26:04 succubus RPC: <instruction_dump+0x68/0xa0>
> Oct 13 20:26:04 succubus l0: 0000000000000000 l1: 0000000000605000 l2: 00=
00000000000000 l3: 0000001911009601
> Oct 13 20:26:04 succubus l4: 0000000000000000 l5: 000000000063dc00 l6: 00=
0000000063dc00 l7: 0000000000000000
> Oct 13 20:26:04 succubus i0: 0000000000000000 i1: 00000000000133e0 i2: ff=
fff8004fa775d0 i3: 0000000000000000
> Oct 13 20:26:04 succubus i4: 00000000000000ff i5: 000000000000000b i6: ff=
fff8004fa76b61 i7: 00000000004294b8
> Oct 13 20:26:04 succubus I7: <die_if_kernel+0x160/0x2c0>
> Oct 13 20:26:04 succubus Caller[00000000004294b8]: die_if_kernel+0x160/0x=
2c0
> Oct 13 20:26:04 succubus Caller[000000000044d130]: unhandled_fault+0x78/0=
xe0
> Oct 13 20:26:04 succubus Caller[00000000004076f4]: sparc64_realfault_comm=
on+0x18/0x20
> Oct 13 20:26:04 succubus Caller[0000000010068cd0]: ar_context_add_page+0x=
d8/0x160 [firewire_ohci]
> Oct 13 20:26:04 succubus Caller[0000000010068d90]: ar_context_init+0x38/0=
x60 [firewire_ohci]
> Oct 13 20:26:04 succubus Caller[000000001006ac50]: pci_probe+0xf8/0x340 [=
firewire_ohci]
> Oct 13 20:26:04 succubus Caller[00000000005299bc]: pci_device_probe+0x64/=
0xa0
> Oct 13 20:26:04 succubus Caller[0000000000550a28]: driver_probe_device+0x=
90/0x1c0
> Oct 13 20:26:04 succubus Caller[0000000000550bc0]: __driver_attach+0x68/0=
x80
> Oct 13 20:26:04 succubus Caller[000000000054fe5c]: bus_for_each_dev+0x44/=
0x80
> Oct 13 20:26:04 succubus Caller[0000000000550218]: bus_add_driver+0x80/0x=
1c0
> Oct 13 20:26:04 succubus Caller[0000000000529b7c]: __pci_register_driver+=
0x44/0xa0
> Oct 13 20:26:04 succubus Caller[000000000047d5cc]: sys_init_module+0x134/=
0x1400
> Oct 13 20:26:04 succubus Caller[0000000000406094]: linux_sparc_syscall32+=
0x3c/0x40
> Oct 13 20:26:04 succubus Caller[00000000000133d8]: 0x133e0
> Oct 13 20:26:04 succubus Instruction DUMP: 80a42000  12480005  9610203e <=
d4060000> 4000cf10  a0102001  833c2000  901460d0  83287002
>=20
>=20

--=20
Stefan Richter
-=3D=3D=3D-=3D-=3D=3D =3D-=3D- -=3D-http://arcgraph.de/sr/
