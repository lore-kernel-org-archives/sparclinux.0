From: Meelis Roos <mroos@linux.ee>
Date: Sat, 25 Oct 2014 21:35:28 +0000
Subject: NULL dereference in schizo error handler
Message-Id: <alpine.LRH.2.11.1410260022340.19758@adalberg.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

I understand there is a bug in earlier revisions of Schizo PCI bridge=20
(that I have in my V480) and we do not have a workaround for that. Now=20
when I happen to hit it, I get a crash in the handler and that seems a=20
bug whether or not we have the workaround.

In particular, it seems that pbm->pci_bus->self is NULL and that causes=20
a NULL pointer dereference in schizo_pcierr_intr_other:

pci_read_config_word(pbm->pci_bus->self, PCI_STATUS, &stat);

Since the error happens during PCI scanning, maybe we just do not have=20
this field initialized yet - in pci_scan_one_pbm() or in something it=20
calls?

This dmesg excerpt from annotated source, mostly for background.

[   61.300577] PCI: Scanning PBM /pci@9,600000
[   61.304867] schizo f009b070: PCI host bridge to bus 0003:00
[   61.310385] pci_bus 0003:00: root bus resource [io  0x7ffe9000000-0x7ffe=
9ffffff] (bus address [0x0000-0xffffff])
[   61.320515] pci_bus 0003:00: root bus resource [mem 0x7fb00000000-0x7fbf=
fffffff] (bus address [0x00000000-0xffffffff])
[   61.331173] pci_bus 0003:00: root bus resource [bus 00]
[   61.337539] schizo_pcierr_intr, pbm=FFf000b0fdb34000
[   61.342444] schizo_pcierr_intr, afarA94496
[   61.346690] schizo_pcierr_intr, afsr=13421772800
[   61.351280] schizo_pcierr_intr, calling schizo_pcierr_intr_other
[   61.357259] schizo_pcierr_intr_other: start
[   61.361421] schizo_pcierr_intr_other, csr=1688858467696703
[   61.366879] schizo_pcierr_intr_other, pbm=FFf000b0fdb34000
[   61.372339] schizo_pcierr_intr_other, pbm->pci_bus=FFf000b0fdb34800
[   61.378580] schizo_pcierr_intr_other, pbm->pci_bus->self=3D          (nu=
ll)
[   61.385344] Unable to handle kernel NULL pointer dereference
[   61.390970] tsk->{mm,active_mm}->context =3D 0000000000000000
[   61.396515] tsk->{mm,active_mm}->pgd =3D fff000b000002000
[   61.401716]               \|/ ____ \|/
[   61.401716]               "@'/ .. \`@"
[   61.401716]               /_| \__/ |_\
[   61.401716]                  \__U_/
[   61.416362] swapper/0(0): Oops [#1]
[   61.419837] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.18.0-rc1-00422-g=
2cc9188-dirty #24
[   61.427975] task: fff000b0fd8e9c40 ti: fff000b0fd928000 task.ti: fff000b=
0fd928000
[   61.435426] TSTATE: 0000004480e01602 TPC: 00000000004455e4 TNPC: 0000000=
0004455e8 Y: 00000000    Not tainted
[   61.445230] TPC: <schizo_pcierr_intr+0x104/0x560>
[   61.449897] g0: 0000000000000000 g1: 0000000000000000 g2: 0000000000a10f=
78 g3: 000000000000000a
[   61.458563] g4: fff000b0fd8e9c40 g5: fff000b0fdd82000 g6: fff000b0fd9280=
00 g7: 000000000000000a
[   61.467229] o0: 000000000000003d o1: 0000000000000000 o2: 00000000000000=
06 o3: fff000b0ffa5fc7e
[   61.475894] o4: 0000000000060000 o5: c000000000000000 sp: fff000b0ffa5f3=
c1 ret_pc: 00000000004455cc
[   61.484909] RPC: <schizo_pcierr_intr+0xec/0x560>
[   61.489500] l0: fff000b0fd8e9c40 l1: 0000000000a20800 l2: 00000000000000=
00 l3: 000000000119a430
[   61.498164] l4: 0000000001742400 l5: 00000000011cfbe0 l6: 00000000011319=
c0 l7: fff000b0fd8ea348
[   61.506830] i0: 0000000000000000 i1: fff000b0fdb34000 i2: 00000003200000=
00 i3: 0000000000000000
[   61.515497] i4: 00060002010b003f i5: 0000040004e02000 i6: fff000b0ffa5f4=
81 i7: 00000000004a9920
[   61.524175] I7: <handle_irq_event_percpu+0x40/0x140>
[   61.529099] Call Trace:
[   61.531531]  [00000000004a9920] handle_irq_event_percpu+0x40/0x140
[   61.537681]  [00000000004a9a58] handle_irq_event+0x38/0x80
[   61.543145]  [00000000004ac77c] handle_fasteoi_irq+0xbc/0x200
[   61.548860]  [00000000004a9084] generic_handle_irq+0x24/0x40
[   61.554500]  [000000000042be0c] handler_irq+0xac/0x100

--=20
Meelis Roos (mroos@linux.ee)
