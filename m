From: Frans Pop <elendil@planet.nl>
Date: Wed, 04 Jul 2007 16:43:00 +0000
Subject: Fwd: Re: Libata PATA status - CMD64X on sparc
Message-Id: <200707041843.01472.elendil@planet.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart394526349.EPLCXuacsu"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--nextPart394526349.EPLCXuacsu
Content-Type: multipart/mixed;
  boundary="Boundary-01=_V48iGOJBpZGnn1h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_V48iGOJBpZGnn1h
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

JFYI.

In reply to [1], I checked the pata-cmd64x driver on my Ultra 10, with the=
=20
results below.

Cheers,
=46JP

[1] http://marc.info/?l=3Dlinux-kernel&m=3D118348475410014&w=3D2

=2D---------  Forwarded Message  ----------
Subject: Re: Libata PATA status - CMD64X on sparc
Date: Wednesday 04 July 2007 18:31
=46rom: Frans Pop <...>
To: Alan Cox <...>

On Wednesday 04 July 2007 14:15, you wrote:
> The main thing to know is simply "does it work". Generally speaking
> you'll get either total failure or success.

Initially I compiled the driver into the kernel and booted without
initrd; that failed.
I then compiled it as a module and used an initrd for the boot; this
booted without any problems. CD drive seems to work fine too.

Guess I must have forgotten to enable something for the first case;
probably the fact that I had scsi generic, disk and maybe target support
modular? Should the kernel config check for that?

Attached the dmesg for the boot and an lspci -nn.

IMHO the dmesg lies a bit:
   sd 0:0:0:0: [sda] Attached SCSI disk
Despite using a PATA driver, they are _not_ scsi disks...

Timing info from hdparm is similar for both drivers.

> Good tests would be to unpack big archives and then verify them

I created a gzipped tarball of my ~ (about 700MB) and then extracted that
to a separate directory.
A diff between the two trees showed no strange differences.

So, good news I guess :-)

Cheers,
=46JP
=2D------------------------------------------------------

--Boundary-01=_V48iGOJBpZGnn1h
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lspci.gimli"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci.gimli"

00:00.0 Host bridge [0600]: Sun Microsystems Computer Corp. Psycho PCI Bus Module [108e:8000]
00:01.0 PCI bridge [0604]: Sun Microsystems Computer Corp. Simba Advanced PCI Bridge [108e:5000] (rev 11)
00:01.1 PCI bridge [0604]: Sun Microsystems Computer Corp. Simba Advanced PCI Bridge [108e:5000] (rev 11)
01:01.0 Bridge [0680]: Sun Microsystems Computer Corp. EBUS [108e:1000] (rev 01)
01:01.1 Ethernet controller [0200]: Sun Microsystems Computer Corp. Happy Meal [108e:1001] (rev 01)
01:02.0 VGA compatible controller [0300]: ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT] [1002:4754] (rev 9a)
01:03.0 IDE interface [0101]: Silicon Image, Inc. PCI0646 [1095:0646] (rev 03)
02:01.0 Communication controller [0782]: Syba Tech Ltd Parallel Port Card 2xEPP [1592:0782] (rev 92)

--Boundary-01=_V48iGOJBpZGnn1h
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg.gimli"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg.gimli"

PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:36'
PROMLIB: Root node compatible:=20
Linux version 2.6.22-rc7 (root@gimli) (gcc version 4.1.3 20070629 (prerelea=
se) (Debian 4.1.2-13)) #2 Wed Jul 4 16:44:13 CEST 2007
ARCH: SUN4U
Ethernet address: 08:00:20:9c:14:f5
PROM: Built device tree with 43301 bytes of memory.
On node 0 totalpages: 130518
  Normal zone: 895 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 129623 pages, LIFO batch:15
Built 1 zonelists.  Total pages: 129623
Kernel command line: root=3D/dev/sda2 ro
PID hash table entries: 4096 (order: 12, 32768 bytes)
clocksource: mult[35555] shift[16]
clockevent: mult[4ccccccc] shift[32]
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
Memory: 1024688k available (2488k kernel code, 904k data, 152k init) [fffff=
80000000000,000000003ff4a000]
Calibrating delay using timer specific routine.. 599.74 BogoMIPS (lpj=3D119=
9497)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing for controllers.
/pci@1f,0: SABRE PCI Bus Module
/pci@1f,0: PCI IO[1fe02000000] MEM[1ff00000000]
PCI: Scanning PBM /pci@1f,0
ebus0: [auxio] [power] [SUNW,pll] [se] [su] [su] [ecpp] [fdthree] [eeprom] =
[flashprom] [SUNW,CS4231]
power: Control reg at 1fff1724000 ... powerd running.
SCSI subsystem initialized
libata version 2.21 loaded.
AUXIO: Found device at /pci@1f,0/pci@1,1/ebus@1/auxio@14,726000
/pci@1f,0/pci@1,1/ebus@1/eeprom@14,0: Clock regs at 000001fff1000000
Time: tick clocksource has been installed.
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 65536 bytes)
TCP established hash table entries: 32768 (order: 6, 524288 bytes)
TCP bind hash table entries: 32768 (order: 5, 262144 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
checking if image is initramfs... it is
=46reeing initrd memory: 2685k freed
audit: initializing netlink socket (disabled)
audit(1183560724.064:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Enabling device: (0000:01:02.0), cmd 82
Console: switching to mono PROM 80x34
rtc_init: no PC rtc found
[drm] Initialized drm 1.1.0 20060810
/pci@1f,0/pci@1,1/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 6
/pci@1f,0/pci@1,1/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 7
f0061c64: ttyS0 at MMIO 0x1fff1400000 (irq =3D 5) is a SAB82532 V3.2
Console: ttyS0 (SAB82532)
f0061c64: ttyS1 at MMIO 0x1fff1400040 (irq =3D 5) is a SAB82532 V3.2
=46loppy drive(s): fd0 is 1.44M
=46DC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: module loaded
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
rtc_sun_init: Registered Mostek RTC driver.
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
input: Sun Mouse as /class/input/input0
PCI: Enabling device: (0000:01:01.1), cmd 2
sunhme.c:v3.00 June 23, 2006 David S. Miller (davem@davemloft.net)
eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:9c:14:f5=20
scsi0 : pata_cmd64x
scsi1 : pata_cmd64x
ata1: PATA max MWDMA2 cmd 0x000001fe02c00000 ctl 0x000001fe02c0000a bmdma 0=
x000001fe02c00020 irq 0
ata2: PATA max MWDMA2 cmd 0x000001fe02c00010 ctl 0x000001fe02c0001a bmdma 0=
x000001fe02c00028 irq 0
ata1.00: ATA-2: ST34342A, 0.42, max UDMA/33
ata1.00: 8404830 sectors, multi 0: LBA=20
pata_cmd64x: active 3 recovery 1 setup 1.
ata1.00: configured for MWDMA2
ata2.00: ATA-7: Maxtor 6E040L0, NAR61590, max UDMA/133
ata2.00: 80293248 sectors, multi 0: LBA=20
ata2.01: ATAPI: CD-ROM 56X/AKH, A8E, max MWDMA2
pata_cmd64x: active 3 recovery 1 setup 1.
pata_cmd64x: active 3 recovery 1 setup 1.
ata2.00: configured for MWDMA2
ata2.01: configured for MWDMA2
scsi 0:0:0:0: Direct-Access     ATA      ST34342A         0.42 PQ: 0 ANSI: 5
scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6E040L0   NAR6 PQ: 0 ANSI: 5
scsi 1:0:1:0: CD-ROM            E-IDE    CD-ROM 56X/AKH   A8E  PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 8404830 512-byte hardware sectors (4303 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't suppo=
rt DPO or FUA
sd 0:0:0:0: [sda] 8404830 512-byte hardware sectors (4303 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't suppo=
rt DPO or FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
sd 1:0:0:0: [sdb] 80293248 512-byte hardware sectors (41110 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
sd 1:0:0:0: [sdb] 80293248 512-byte hardware sectors (41110 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
 sdb: sdb1 sdb2 sdb3 sdb4
sd 1:0:0:0: [sdb] Attached SCSI disk
sr0: scsi3-mmc drive: 4x/52x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:1:0: Attached scsi CD-ROM sr0
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sr 1:0:1:0: Attached scsi generic sg2 type 5
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x1fff13043bc (0x1fff13047bc), irq 8 [PCSPP,TRISTATE]
PCI: Enabling device: (0000:02:01.0), cmd 1
PCI parallel port detected: 14f2:0121, I/O at 0x1fe02000478(0x0)
parport1: PC-style at 0x1fe02000478 [PCSPP,TRISTATE,EPP]
PCI parallel port detected: 14f2:0121, I/O at 0x1fe02000578(0x0)
parport2: PC-style at 0x1fe02000578 [PCSPP,TRISTATE,EPP]
EXT3 FS on sda2, internal journal
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redha=
t.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 214024k swap on /dev/sda4.  Priority:-1 extents:1 across:214024k
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.

--Boundary-01=_V48iGOJBpZGnn1h--

--nextPart394526349.EPLCXuacsu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGi84Vgm/Kwh6ICoQRArRdAJ4+ntA52jUM6I13fepu1CRDZ9JOUwCfYLsW
0nYv8MV6K5VfN1tmTmPqINk=
=xt2q
-----END PGP SIGNATURE-----

--nextPart394526349.EPLCXuacsu--
