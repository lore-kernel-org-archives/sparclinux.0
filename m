From: Meelis Roos <mroos@ut.ee>
Date: Fri, 06 Feb 2009 14:55:04 +0000
Subject: Re: SBus HME startup failure
Message-Id: <Pine.SOC.4.64.0902061623460.10784@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0901271205350.17434@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0901271205350.17434@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> it's me again with the E3500 and 2.6.29-rc2+git. I said it was working=20
> fine but I have found 2 glitches and this is one of them.
>=20
> It seems the SBus HME card is detected but initialization fails:
>=20
> [  145.666490] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@dave=
mloft.net)
> [  145.755837] eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:b6:e=
e:e2
> [  145.836295] happymeal: Cannot map MAC TX registers.
> [  145.895305] PCI: Enabling device: (0000:00:01.1), cmd 2
> [  145.897821] eth1: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:=
20:b6:ee:e2
>=20
> PCI one is detected and works fine.

Another data point: SBus+PCI mixed system (HME-s on both buses) breaks=20
for PCI too (I did put a PCI Quad HME into the E3500 for testing).

I did some detective work and found two possible culprits:

First, happy_meal_probe() does first happy_meal_sbus_init() and then=20
happy_meal_pci_init(). All these crashes happen during SBus init=20
routines. These sbus routines are actually just OF init routines=20
nowadays. So happy_meal_sbus_probe_one() get feed all matching OF nodes,=20
both SBus and PCI. The SBus code seems to break with the PCI nodes -=20
this is the "Cannot map MAC TX registers" part.

So, should these routines filter for sbus bus type at some point? Or=20
should they take over PCI too (IMHO a bad idea) and be renamed to of_*=20
instead of sbus_*?

Second, I got a consistent oops in quattro_sbus_interrupt() with PCI=20
Quattro card. This seems to be a related but different problem -=20
happy_meal_sbus_init() does quattro_sbus_register_irqs() unconditionally=20
after registering OF driver and without checking that things get set up=20
correctly. Calling of_register_driver seems to call into the drivers=20
probe() function several times. It seems to return success if any of its=20
probe() invocations returned success, but in hme case we only may enable=20
quattro irqs when all quattro cards were initialized successfully (and=20
one successfully and one unsuccessfully could also breat the interrupts=20
it seems).

Wondering if there are other SBUS+PCI drivers wiht problems like that...=20
a quick grep under drivers/net shows no more drivers using both sbus and=20
pci API-s.

Here is a dmesg excerpt with many debug printks, most should be=20
self-explanatory:

[  131.645707] happy_meal_probe()
[  131.680197] happy_meal_sbus_init()
[  131.721545] hme_sbus_probe(node=FFfff8004fca1600, name=3DSUNW,hme, is_qf=
e=3D0, model=3D<NULL>)
[  131.817763] happy_meal_sbus_probe_one(op=FFfff8004ecdc000, is_qfe=3D0)
[  131.893785] happy_meal_sbus_probe_one continues to alloc_etherdev
[  131.966732] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@daveml=
oft.net)
[  132.058168] eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:b6:ee:=
e2
[  132.138758] happy_meal_sbus_probe_one() returning success
[  132.203038] hme_sbus_probe returning 0
[  132.247906] hme_sbus_probe(node=FFfff8004fc9d0c0, name=3DSUNW,hme, is_qf=
e=3D0, model=3DSUNW,cheerio)
[  132.350987] happy_meal_sbus_probe_one(op=FFfff8004ec7a000, is_qfe=3D0)
[  132.427038] happy_meal_sbus_probe_one continues to alloc_etherdev
[  132.499978] happymeal: Cannot map MAC TX registers.
[  132.558302] happy_meal_sbus_probe_one() returning error -19
[  132.624973] hme_sbus_probe returning -19
[  132.671980] hme_sbus_probe(node=FFfff8004fc99200, name=3DSUNW,qfe, is_qf=
e=3D1, model=3DSUNW,pci-qfe)
[  132.775037] happy_meal_sbus_probe_one(op=FFfff8004ec7e000, is_qfe=3D1)
[  132.851058] happy_meal_sbus_probe_one() found sbus quattro, qp=FFfff8004=
dbe8300
[  132.938592] happy_meal_sbus_probe_one continues to alloc_etherdev
[  133.011527] happymeal: Cannot map MAC TX registers.
[  133.069864] happy_meal_sbus_probe_one() returning error -19
[  133.136530] hme_sbus_probe returning -19
[  133.183527] hme_sbus_probe(node=FFfff8004fc96f40, name=3DSUNW,qfe, is_qf=
e=3D1, model=3DSUNW,pci-qfe)
[  133.286588] happy_meal_sbus_probe_one(op=FFfff8004ec7f000, is_qfe=3D1)
[  133.362622] happy_meal_sbus_probe_one() found sbus quattro, qp=FFfff8004=
dbe8300
[  133.450149] happy_meal_sbus_probe_one continues to alloc_etherdev
[  133.523090] happymeal: Cannot map MAC TX registers.
[  133.581416] happy_meal_sbus_probe_one() returning error -19
[  133.648092] hme_sbus_probe returning -19
[  133.695084] hme_sbus_probe(node=FFfff8004fc94c80, name=3DSUNW,qfe, is_qf=
e=3D1, model=3DSUNW,pci-qfe)
[  133.798147] happy_meal_sbus_probe_one(op=FFfff8004ec7b000, is_qfe=3D1)
[  133.874179] happy_meal_sbus_probe_one() found sbus quattro, qp=FFfff8004=
dbe8300
[  133.961726] happy_meal_sbus_probe_one continues to alloc_etherdev
[  134.034644] happymeal: Cannot map MAC TX registers.
[  134.092976] happy_meal_sbus_probe_one() returning error -19
[  134.159656] hme_sbus_probe returning -19
[  134.206647] hme_sbus_probe(node=FFfff8004fc929c0, name=3DSUNW,qfe, is_qf=
e=3D1, model=3DSUNW,pci-qfe)
[  134.309714] happy_meal_sbus_probe_one(op=FFfff8004ec77000, is_qfe=3D1)
[  134.385739] happy_meal_sbus_probe_one() found sbus quattro, qp=FFfff8004=
dbe8300
[  134.473272] happy_meal_sbus_probe_one continues to alloc_etherdev
[  134.546213] happymeal: Cannot map MAC TX registers.
[  134.604545] happy_meal_sbus_probe_one() returning error -19
[  134.671207] hme_sbus_probe returning -19
[  134.718766] happy_meal_sbus_init() finished of_register_driver successfu=
lly, registering irqs
[  134.820225] quattro_sbus_register_irqs()
[  134.867195] quattro_sbus_register_irqs() requesting irq
[  134.929723] OOPS: Bogus kernel PC [0000000000000000] in fault handler
[  135.006646] OOPS: RPC [00000000005f7fa0]
[  135.053532] OOPS: RPC <quattro_sbus_interrupt+0x40/0x120>
[  135.118120] OOPS: Fault was to vaddr[200804000]


--=20
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
