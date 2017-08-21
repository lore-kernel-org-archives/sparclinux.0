From: mroos@linux.ee
Date: Mon, 21 Aug 2017 19:20:22 +0000
Subject: Re: 4.13.0-rc4 sparc64: can't allocate MSI-X affinity masks for 2 vectors
Message-Id: <alpine.LRH.2.20.1708212209280.31611@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1708152321150.11510@math.ut.ee> <alpine.LRH.2.20.1708162136220.16834@math.ut.ee> <20170816190241.GD28977@bhelgaas-glaptop.roam.corp.google.com> <20170821.112747.1532639515902173100.davem@davemloft.net>
 <20170821183458.GA23205@lst.de>
In-Reply-To: <20170821183458.GA23205@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Christoph Hellwig <hch@lst.de>
Cc: David Miller <davem@davemloft.net>, helgaas@kernel.org, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, qla2xxx-upstream@qlogic.com, linux-kernel@vger.kernel.org

> I think with this patch from -rc6 the symptoms should be cured:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=C005390374957baacbc38eef96ea360559510aa7
>=20
> if that theory is right.

The result with 4.13-rc6 is positive but mixed: the message about MSI-X=20
affinty maks are still there but the rest of the detection works and the=20
driver is loaded successfully:

[   29.924282] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driv=
er: 10.00.00.00-k.
[   29.924710] qla2xxx [0000:10:00.0]-001d: : Found an ISP2432 irq 21 iobas=
e 0x000000c100d00000.
[   29.925581] qla2xxx 0000:10:00.0: can't allocate MSI-X affinity masks fo=
r 2 vectors
[   30.483422] scsi host1: qla2xxx
[   35.495031] qla2xxx [0000:10:00.0]-00fb:1: QLogic QLE2462 - SG-(X)PCIE2F=
C-QF4, Sun StorageTek 4 Gb FC Enterprise PCI-Express Dual Channel H.
[   35.495274] qla2xxx [0000:10:00.0]-00fc:1: ISP2432: PCIe (2.5GT/s x4) @ =
0000:10:00.0 hdma- host#=3D1 fw=3D7.03.00 (9496).
[   35.495615] qla2xxx [0000:10:00.1]-001d: : Found an ISP2432 irq 22 iobas=
e 0x000000c100d04000.
[   35.496409] qla2xxx 0000:10:00.1: can't allocate MSI-X affinity masks fo=
r 2 vectors
[   35.985355] scsi host2: qla2xxx
[   40.996991] qla2xxx [0000:10:00.1]-00fb:2: QLogic QLE2462 - SG-(X)PCIE2F=
C-QF4, Sun StorageTek 4 Gb FC Enterprise PCI-Express Dual Channel H.
[   40.997251] qla2xxx [0000:10:00.1]-00fc:2: ISP2432: PCIe (2.5GT/s x4) @ =
0000:10:00.1 hdma- host#=3D2 fw=3D7.03.00 (9496).
[   51.880945] qla2xxx [0000:10:00.0]-8038:1: Cable is unplugged...
[   57.402900] qla2xxx [0000:10:00.1]-8038:2: Cable is unplugged...

With Dave Millers patch on top of 4.13-rc6, I see the following before=20
both MSI-X messages:

irq_create_affinity_masks: nvecs[2] affd->pre_vectors[2] affd->post_vectors=
[0]

--=20
Meelis Roos (mroos@linux.ee)
