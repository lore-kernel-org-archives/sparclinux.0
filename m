From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Mon, 08 Dec 2014 15:43:31 +0000
Subject: 3.18 fails in firmware init of qla on V880
Message-Id: <20141208154331.GB13837@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hello,
after sucess with 3.17.x kernels (x>3 still to be tested) vanilla 3.18 fail
with V880 internal fc controller firmware init - see below. It drops then
into an initramfs shell.

Greetings
  Hermann

[   62.156575] SCSI subsystem initialized
[   62.201834] sungem.c:v1.0 David S. Miller <davem@redhat.com>
[   62.304598] sym0: <875> rev 0x4 at pci 0000:00:01.0 irq 6
[   62.379582] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driv=
er: 8.07.00.16-k.
[   62.571122] sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
[   62.649898] sym0: SCSI BUS has been reset.
[   62.697931] scsi host0: sym-2.2.3
[   62.774210] gem 0001:00:01.0 eth0: Sun GEM (PCI) 10/100/1000BaseT Ethern=
et 00:03:ba:08:d9:25
[   62.874619] qla2xxx [0001:00:02.0]-001d: : Found an ISP2200 irq 10 iobas=
e 0x000007fd00400000.
[   62.977938] gem 0002:00:01.1 eth1: Sun GEM (PCI) 10/100/1000BaseT Ethern=
et 00:03:ba:08:d9:24
[   63.094423] qla2xxx [0001:00:02.0]-0050:1: No matching ROM signature.
[   63.266177] qla2xxx [0001:00:02.0]-0064:1: Inconsistent NVRAM detected: =
checksum=3D0x0 id=3D=EF=BF=BD version=3D0xff.
[   63.377728] qla2xxx [0001:00:02.0]-0065:1: Falling back to functioning (=
yet invalid -- WWPN) defaults.
[   63.489177] qla2xxx [0001:00:02.0]-0069:1: NVRAM configuration failed.
[   67.481656] scsi 0:0:6:0: CD-ROM            TOSHIBA  DVD-ROM SD-M1401 10=
09 PQ: 0 ANSI: 2
[   67.577774] scsi target0:0:6: Beginning Domain Validation
[   67.654254] scsi target0:0:6: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 1=
6)
[   67.745192] scsi target0:0:6: Domain Validation skipping write tests
[   67.820352] scsi target0:0:6: Ending Domain Validation
[   70.292139] sr 0:0:6:0: [sr0] out of memory.
[   70.342341] cdrom: Uniform CD-ROM driver Revision: 3.20
[   70.413641] sr 0:0:6:0: Attached scsi generic sg0 type 5
[   74.360439] qla2xxx [0001:00:02.0]-00d2:1: Init Firmware **** FAILED ***=
*.
[   74.441843] qla2xxx [0001:00:02.0]-00d6:1: Failed to initialize adapter =
- Adapter flags 2.


--=20
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres=20
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
