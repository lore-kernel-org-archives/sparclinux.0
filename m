From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 15 Aug 2017 18:44:03 +0000
Subject: Re: 4.13.0-rc4 sparc64: can't allocate MSI-X affinity masks for 2 vectors
Message-Id: <20170815184403.GB4099@bhelgaas-glaptop.roam.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1708151742360.29628@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1708151742360.29628@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Meelis Roos <mroos@linux.ee>
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, qla2xxx-upstream@qlogic.com, Linux Kernel list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>

[+cc Christoph]

On Tue, Aug 15, 2017 at 05:54:27PM +0300, Meelis Roos wrote:
> I noticed that in 4.13.0-rc4 there is a new error in dmesg on my sparc64 =

> t5120 server: can't allocate MSI-X affinity masks.
>=20
> [   30.274284] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Dr=
iver: 10.00.00.00-k.
> [   30.274648] qla2xxx [0000:10:00.0]-001d: : Found an ISP2432 irq 21 iob=
ase 0x000000c100d00000.
> [   30.275447] qla2xxx 0000:10:00.0: can't allocate MSI-X affinity masks =
for 2 vectors
> [   30.816882] scsi host1: qla2xxx
> [   30.877294] qla2xxx: probe of 0000:10:00.0 failed with error -22
> [   30.877578] qla2xxx [0000:10:00.1]-001d: : Found an ISP2432 irq 22 iob=
ase 0x000000c100d04000.
> [   30.878387] qla2xxx 0000:10:00.1: can't allocate MSI-X affinity masks =
for 2 vectors
> [   31.367083] scsi host1: qla2xxx
> [   31.427500] qla2xxx: probe of 0000:10:00.1 failed with error -22
>=20
> I do not know if the driver works since nothing is attached to the FC=20
> HBA at the moment, but from the error messages it looks like the driver=20
> fails to load.
>=20
> I booted 4.12 and 4.11 - the red error is not there but the failure=20
> seems to be the same error -22:

-22 is -EINVAL, so not very specific.  Many failures probably use this
code.

There were several IRQ affinity changes between v4.12 and v4.13; it'll
probably be obvious to Christoph.

> [2478900.385223] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA =
Driver: 9.00.00.00-k.
> [2478900.385610] qla2xxx [0000:10:00.0]-001d: : Found an ISP2432 irq 21 i=
obase 0x000000c100d00000.
> [2478900.930517] scsi host1: qla2xxx
> [2478900.990939] qla2xxx: probe of 0000:10:00.0 failed with error -22
> [2478900.991222] qla2xxx [0000:10:00.1]-001d: : Found an ISP2432 irq 22 i=
obase 0x000000c100d04000.
> [2478901.510715] scsi host1: qla2xxx
> [2478901.581106] qla2xxx: probe of 0000:10:00.1 failed with error -22
>=20
> Will try older kernels too if it is useful for bisection.
>=20
> On an older sparc64 (t1-200) with 4.13.0-rc4, qla2xxx loads fine (nothing=
 is attached there either):
>=20
> [   30.590064] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Dr=
iver: 10.00.00.00-k.
> [   30.699053] PCI: Enabling device: (0000:02:05.0), cmd 3
> [   30.699122] qla2xxx [0000:02:05.0]-001d: : Found an ISP2200 irq 12 iob=
ase 0x000001ff0000a000.
> [   52.463403] scsi host2: qla2xxx
> [   52.545973] qla2xxx [0000:02:05.0]-4800:2: DPC handler sleeping.
> [   52.627163] qla2xxx [0000:02:05.0]-00fb:2: QLogic QLA22xx - .
> [   52.705428] qla2xxx [0000:02:05.0]-00fc:2: ISP2200: PCI (33 MHz) @ 000=
0:02:05.0 hdma- host#=3D2 fw=3D2.02.08 TP.
> [   53.503221] qla2xxx [0000:02:05.0]-480f:2: Loop resync scheduled.
> [   73.796964] qla2xxx [0000:02:05.0]-8038:2: Cable is unplugged...
> [   73.876036] qla2xxx [0000:02:05.0]-883a:2: fw_state=3D4 (ffff, ffff, f=
fff, ffff ffff) curr time=FFffa61d.
> [   73.999845] qla2xxx [0000:02:05.0]-286c:2: qla2x00_loop_resync *** FAI=
LED ***.
> [   74.094861] qla2xxx [0000:02:05.0]-4810:2: Loop resync end.
> [   74.168188] qla2xxx [0000:02:05.0]-4800:2: DPC handler sleeping.
>=20
>=20
> --=20
> Meelis Roos (mroos@linux.ee)
