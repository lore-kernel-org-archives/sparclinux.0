From: Will Simoneau <simoneau@ele.uri.edu>
Date: Tue, 20 Jun 2006 17:56:56 +0000
Subject: 2.6.17 + sym53c876 causes many i/o errors
Message-Id: <20060620175656.GA12525@ele.uri.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="V0207lvV8h4k8FAm"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I just tried out 2.6.17 on my U80 (4x450, 2560MB), which boots off the
onboard SCSI card (Symbios 53c876) from a sw raid1 of 2 disks. The disks
are original Sun UW-SCSI Seagate 18G 10k disks, internal cabling is all
original. Filesystem is ext3 with dir_index on. Distro is Gentoo,
running ~sparc.

Result: many I/O errors, leading to some filesystem corruption! I was
lucky to notice and quickly go back to 2.6.15 and run a full fsck, which
found some problems. One of the disks was marked failed by the raid1
driver, since it was returning lots of errors... it looks like the raid1
driver didn't give up as easily on the last disk, allowing the machine
to still function.

The old kernel is 2.6.15-gentoo-r7 installed via portage. Toolchain and
utility versions from ver_linux:

Gnu C                  3.4.6
Gnu make               3.81
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.38
reiserfsprogs          3.6.19
xfsprogs               2.7.11
quota-tools            3.13.
PPP                    2.4.3
Linux C Library        so.6 .> libc
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.96
udev                   090

This is obviously a really dangerous bug, whatever it is, as it will
easily cause corruption on the root filesystem before booting is finished. Both SCSI channels on the dual channel card return errors easily. This wasn't a
problem on 2.6.15.

Full kernel log from 2.6.17 boot to shutdown, and .config are attached.
This kernel is gentoo-sources-2.6.17 from portage, let me know if you
need a list of patches that are included.

BTW, I can't fiddle much with this machine besides testing a couple
patches. Doing a bisect to find the bad patch is out of the question.

What gives?

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-2.6.17"
Content-Transfer-Encoding: quoted-printable

Jun 20 12:55:58 trogdor PROMLIB: Sun IEEE Boot Prom 'OBP 3.23.0 1999/06/30 =
13:53'
Jun 20 12:55:59 trogdor PROMLIB: Root node compatible:=20
Jun 20 12:55:59 trogdor Linux version 2.6.17-gentoo (root@trogdor) (gcc ver=
sion 3.4.6 (Gentoo Linux 3.4.6)) #1 SMP PREEMPT Tue Jun 20 12:16:55 EDT 2006
Jun 20 12:55:59 trogdor ARCH: SUN4U
Jun 20 12:55:59 trogdor Ethernet address: 08:00:20:d1:fb:cf
Jun 20 12:55:59 trogdor On node 0 totalpages: 327076
Jun 20 12:55:59 trogdor DMA zone: 327076 pages, LIFO batch:15
Jun 20 12:55:59 trogdor Built 1 zonelists
Jun 20 12:55:59 trogdor Kernel command line: root=3D/dev/md1
Jun 20 12:55:59 trogdor PID hash table entries: 4096 (order: 12, 32768 byte=
s)
Jun 20 12:55:59 trogdor Console: colour dummy device 80x25
Jun 20 12:55:59 trogdor Dentry cache hash table entries: 524288 (order: 9, =
4194304 bytes)
Jun 20 12:55:59 trogdor Inode-cache hash table entries: 262144 (order: 8, 2=
097152 bytes)
Jun 20 12:55:59 trogdor Memory: 2591712k available (2488k kernel code, 768k=
 data, 152k init) [fffff80000000000,00000000cff1c000]
Jun 20 12:55:59 trogdor Calibrating delay using timer specific routine.. 90=
1.22 BogoMIPS (lpj=3D439688)
Jun 20 12:55:59 trogdor Mount-cache hash table entries: 512
Jun 20 12:55:59 trogdor CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384)=
:line_sz(32)] E[sz(4194304):line_sz(64)]
Jun 20 12:55:59 trogdor Using max_cache_size of 4MB
Jun 20 12:55:59 trogdor Calibrating delay using timer specific routine.. 90=
0.83 BogoMIPS (lpj=3D439535)
Jun 20 12:55:59 trogdor CPU[1]: Caches D[sz(16384):line_sz(32)] I[sz(16384)=
:line_sz(32)] E[sz(4194304):line_sz(64)]
Jun 20 12:55:59 trogdor CPU 1: synchronized TICK with master CPU (last diff=
 -2 cycles,maxerr 534 cycles)
Jun 20 12:55:59 trogdor Calibrating delay using timer specific routine.. 90=
0.83 BogoMIPS (lpj=3D439535)
Jun 20 12:55:59 trogdor CPU[2]: Caches D[sz(16384):line_sz(32)] I[sz(16384)=
:line_sz(32)] E[sz(4194304):line_sz(64)]
Jun 20 12:55:59 trogdor CPU 2: synchronized TICK with master CPU (last diff=
 -2 cycles,maxerr 538 cycles)
Jun 20 12:55:59 trogdor Calibrating delay using timer specific routine.. 90=
0.84 BogoMIPS (lpj=3D439536)
Jun 20 12:55:59 trogdor CPU[3]: Caches D[sz(16384):line_sz(32)] I[sz(16384)=
:line_sz(32)] E[sz(4194304):line_sz(64)]
Jun 20 12:55:59 trogdor CPU 3: synchronized TICK with master CPU (last diff=
 -5 cycles,maxerr 578 cycles)
Jun 20 12:55:59 trogdor Brought up 4 CPUs
Jun 20 12:55:59 trogdor Total of 4 processors activated (3603.73 BogoMIPS).
Jun 20 12:55:59 trogdor migration_cost=3D37263
Jun 20 12:55:59 trogdor NET: Registered protocol family 16
Jun 20 12:55:59 trogdor PCI: Probing for controllers.
Jun 20 12:55:59 trogdor PCI: Found PSYCHO, control regs at 000001fe00000000
Jun 20 12:55:59 trogdor PSYCHO: Shared PCI config space at 000001fe01000000
Jun 20 12:55:59 trogdor PCI-IRQ: Routing bus[ 0] slot[ 1] to INO[21]
Jun 20 12:55:59 trogdor PCI-IRQ: Routing bus[ 0] slot[ 3] to INO[20]
Jun 20 12:55:59 trogdor PCI-IRQ: Routing bus[ 0] slot[ 3] to INO[26]
Jun 20 12:55:59 trogdor PCI-IRQ: Routing bus[ 0] slot[ 4] to INO[18]
Jun 20 12:55:59 trogdor PCI-IRQ: Routing bus[ 0] slot[ 4] to INO[19]
Jun 20 12:55:59 trogdor PCI-IRQ: Routing bus[ 0] slot[ 4] to INO[1a]
Jun 20 12:55:59 trogdor PSYCHO0 PBMB: 0001:01:04.0 IRQ Swivel 0001:01:04.0 =
[1:4] -> [1]
Jun 20 12:55:59 trogdor PCI-IRQ: Routing bus[ 1] slot[ 4] to INO[10]
Jun 20 12:55:59 trogdor PSYCHO0 PBMB: 0001:01:05.0 IRQ Swivel 0001:01:05.0 =
[1:5] -> [2]
Jun 20 12:55:59 trogdor PCI-IRQ: Routing bus[ 1] slot[ 5] to INO[11]
Jun 20 12:55:59 trogdor PCI0(PBMB): Bus running at 33MHz
Jun 20 12:55:59 trogdor PCI-IRQ: Routing bus[80] slot[ 1] to INO[00]
Jun 20 12:55:59 trogdor PCI0(PBMA): Bus running at 33MHz
Jun 20 12:55:59 trogdor ebus0: [auxio] [power] [SUNW,pll] [sc] [se] [su] [s=
u] [ecpp] [fdthree] [eeprom] [flashprom] [SUNW,CS4231]
Jun 20 12:55:59 trogdor power: Control reg at 000001fff1724000 ... powerd r=
unning.
Jun 20 12:55:59 trogdor SCSI subsystem initialized
Jun 20 12:55:59 trogdor NET: Registered protocol family 2
Jun 20 12:55:59 trogdor IP route cache hash table entries: 131072 (order: 7=
, 1048576 bytes)
Jun 20 12:55:59 trogdor TCP established hash table entries: 524288 (order: =
10, 8388608 bytes)
Jun 20 12:55:59 trogdor TCP bind hash table entries: 65536 (order: 7, 10485=
76 bytes)
Jun 20 12:55:59 trogdor TCP: Hash tables configured (established 524288 bin=
d 65536)
Jun 20 12:55:59 trogdor TCP reno registered
Jun 20 12:55:59 trogdor Total HugeTLB memory allocated, 0
Jun 20 12:55:59 trogdor Initializing Cryptographic API
Jun 20 12:55:59 trogdor io scheduler noop registered
Jun 20 12:55:59 trogdor io scheduler deadline registered (default)
Jun 20 12:55:59 trogdor Console: switching to mono PROM 80x34
Jun 20 12:55:59 trogdor Console: switching to colour frame buffer device 20=
0x80
Jun 20 12:55:59 trogdor ffb: FFB at 000001fc00000000 type 51 DAC 10
Jun 20 12:55:59 trogdor ffb: FFB at 000001fa00000000 type 51 DAC 10
Jun 20 12:55:59 trogdor su0 at 0x000001fff13062f8 (irq =3D 5,7ea) is a 1655=
0A
Jun 20 12:55:59 trogdor su1 at 0x000001fff13083f8 (irq =3D 9,7e9) is a 1655=
0A
Jun 20 12:55:59 trogdor ttyS0 at MMIO 0x1fff1400000 (irq =3D 7802464) is a =
SAB82532 V3.2
Jun 20 12:55:59 trogdor ttyS1 at MMIO 0x1fff1400040 (irq =3D 7802464) is a =
SAB82532 V3.2
Jun 20 12:55:59 trogdor mice: PS/2 mouse device common for all mice
Jun 20 12:55:59 trogdor sym0: <875> rev 0x14 at pci 0001:00:03.0 irq 5,7e0
Jun 20 12:55:59 trogdor sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
Jun 20 12:55:59 trogdor sym0: SCSI BUS has been reset.
Jun 20 12:55:59 trogdor scsi0 : sym-2.2.3
Jun 20 12:55:59 trogdor isa bounce pool size: 16 pages
Jun 20 12:55:59 trogdor input: Sun Type 5 keyboard as /class/input/input0
Jun 20 12:55:59 trogdor input: Sun Mouse as /class/input/input1
Jun 20 12:55:59 trogdor Vendor: SEAGATE   Model: ST318404LSUN18G   Rev: 4207
Jun 20 12:55:59 trogdor Type:   Direct-Access                      ANSI SCS=
I revision: 03
Jun 20 12:55:59 trogdor target0:0:0: tagged command queuing enabled, comman=
d queue depth 256.
Jun 20 12:55:59 trogdor target0:0:0: Beginning Domain Validation
Jun 20 12:55:59 trogdor target0:0:0: asynchronous
Jun 20 12:55:59 trogdor target0:0:0: wide asynchronous
Jun 20 12:55:59 trogdor target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns,=
 offset 16)
Jun 20 12:55:59 trogdor target0:0:0: Domain Validation skipping write tests
Jun 20 12:55:59 trogdor target0:0:0: Ending Domain Validation
Jun 20 12:55:59 trogdor Vendor: SEAGATE   Model: ST318404LSUN18G   Rev: 4207
Jun 20 12:55:59 trogdor Type:   Direct-Access                      ANSI SCS=
I revision: 03
Jun 20 12:55:59 trogdor target0:0:1: tagged command queuing enabled, comman=
d queue depth 256.
Jun 20 12:55:59 trogdor target0:0:1: Beginning Domain Validation
Jun 20 12:55:59 trogdor target0:0:1: asynchronous
Jun 20 12:55:59 trogdor target0:0:1: wide asynchronous
Jun 20 12:55:59 trogdor target0:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns,=
 offset 16)
Jun 20 12:55:59 trogdor target0:0:1: Domain Validation skipping write tests
Jun 20 12:55:59 trogdor target0:0:1: Ending Domain Validation
Jun 20 12:55:59 trogdor Vendor: YAMAHA    Model: CDR400t           Rev: 1.0n
Jun 20 12:55:59 trogdor Type:   CD-ROM                             ANSI SCS=
I revision: 02
Jun 20 12:55:59 trogdor target0:0:6: Beginning Domain Validation
Jun 20 12:55:59 trogdor 0:0:6:0: phase change 6-7 6@c0000fa0 resid=3D4.
Jun 20 12:55:59 trogdor target0:0:6: asynchronous
Jun 20 12:55:59 trogdor target0:0:6: Ending Domain Validation
Jun 20 12:55:59 trogdor sym1: <875> rev 0x14 at pci 0001:00:03.1 irq 5,7e6
Jun 20 12:55:59 trogdor sym1: No NVRAM, ID 7, Fast-20, SE, parity checking
Jun 20 12:55:59 trogdor sym1: SCSI BUS has been reset.
Jun 20 12:55:59 trogdor scsi1 : sym-2.2.3
Jun 20 12:55:59 trogdor Vendor: SEAGATE   Model: ST118202LC        Rev: 0004
Jun 20 12:55:59 trogdor Type:   Direct-Access                      ANSI SCS=
I revision: 02
Jun 20 12:55:59 trogdor target1:0:0: tagged command queuing enabled, comman=
d queue depth 256.
Jun 20 12:55:59 trogdor target1:0:0: Beginning Domain Validation
Jun 20 12:55:59 trogdor target1:0:0: asynchronous
Jun 20 12:55:59 trogdor target1:0:0: wide asynchronous
Jun 20 12:55:59 trogdor target1:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns,=
 offset 15)
Jun 20 12:55:59 trogdor target1:0:0: Domain Validation skipping write tests
Jun 20 12:55:59 trogdor target1:0:0: Ending Domain Validation
Jun 20 12:55:59 trogdor SCSI device sda: 35378533 512-byte hdwr sectors (18=
114 MB)
Jun 20 12:55:59 trogdor sda: Write Protect is off
Jun 20 12:55:59 trogdor sda: Mode Sense: cf 00 10 08
Jun 20 12:55:59 trogdor SCSI device sda: drive cache: write through w/ FUA
Jun 20 12:55:59 trogdor SCSI device sda: 35378533 512-byte hdwr sectors (18=
114 MB)
Jun 20 12:55:59 trogdor sda: Write Protect is off
Jun 20 12:55:59 trogdor sda: Mode Sense: cf 00 10 08
Jun 20 12:55:59 trogdor SCSI device sda: drive cache: write through w/ FUA
Jun 20 12:55:59 trogdor sda: sda1 sda2 sda3
Jun 20 12:55:59 trogdor sd 0:0:0:0: Attached scsi disk sda
Jun 20 12:55:59 trogdor SCSI device sdb: 35378533 512-byte hdwr sectors (18=
114 MB)
Jun 20 12:55:59 trogdor sdb: Write Protect is off
Jun 20 12:55:59 trogdor sdb: Mode Sense: cf 00 10 08
Jun 20 12:55:59 trogdor SCSI device sdb: drive cache: write through w/ FUA
Jun 20 12:55:59 trogdor SCSI device sdb: 35378533 512-byte hdwr sectors (18=
114 MB)
Jun 20 12:55:59 trogdor sdb: Write Protect is off
Jun 20 12:55:59 trogdor sdb: Mode Sense: cf 00 10 08
Jun 20 12:55:59 trogdor SCSI device sdb: drive cache: write through w/ FUA
Jun 20 12:55:59 trogdor sdb: sdb1 sdb2 sdb3
Jun 20 12:55:59 trogdor sd 0:0:1:0: Attached scsi disk sdb
Jun 20 12:55:59 trogdor SCSI device sdc: 35566479 512-byte hdwr sectors (18=
210 MB)
Jun 20 12:55:59 trogdor sdc: Write Protect is off
Jun 20 12:55:59 trogdor sdc: Mode Sense: 9f 00 10 08
Jun 20 12:55:59 trogdor SCSI device sdc: drive cache: write through w/ FUA
Jun 20 12:55:59 trogdor SCSI device sdc: 35566479 512-byte hdwr sectors (18=
210 MB)
Jun 20 12:55:59 trogdor sdc: Write Protect is off
Jun 20 12:55:59 trogdor sdc: Mode Sense: 9f 00 10 08
Jun 20 12:55:59 trogdor SCSI device sdc: drive cache: write through w/ FUA
Jun 20 12:55:59 trogdor sdc: sdc1 sdc2 sdc3
Jun 20 12:55:59 trogdor sd 1:0:0:0: Attached scsi disk sdc
Jun 20 12:55:59 trogdor envctrl: I2C device not found.
Jun 20 12:55:59 trogdor rtc_sun_init: Registered Mostek RTC driver.
Jun 20 12:55:59 trogdor md: raid0 personality registered for level 0
Jun 20 12:55:59 trogdor md: raid1 personality registered for level 1
Jun 20 12:55:59 trogdor md: multipath personality registered for level -4
Jun 20 12:55:59 trogdor md: md driver 0.90.3 MAX_MD_DEVS=3D256, MD_SB_DISKS=
=3D27
Jun 20 12:55:59 trogdor md: bitmap version 4.39
Jun 20 12:55:59 trogdor TCP bic registered
Jun 20 12:55:59 trogdor NET: Registered protocol family 1
Jun 20 12:55:59 trogdor NET: Registered protocol family 17
Jun 20 12:55:59 trogdor md: Autodetecting RAID arrays.
Jun 20 12:55:59 trogdor md: autorun ...
Jun 20 12:55:59 trogdor md: considering sdb2 ...
Jun 20 12:55:59 trogdor md:  adding sdb2 ...
Jun 20 12:55:59 trogdor md: sdb1 has different UUID to sdb2
Jun 20 12:55:59 trogdor md:  adding sda2 ...
Jun 20 12:55:59 trogdor md: sda1 has different UUID to sdb2
Jun 20 12:55:59 trogdor md: created md1
Jun 20 12:55:59 trogdor md: bind<sda2>
Jun 20 12:55:59 trogdor md: bind<sdb2>
Jun 20 12:55:59 trogdor md: running: <sdb2><sda2>
Jun 20 12:55:59 trogdor raid1: raid set md1 active with 2 out of 2 mirrors
Jun 20 12:55:59 trogdor md: considering sdb1 ...
Jun 20 12:55:59 trogdor md:  adding sdb1 ...
Jun 20 12:55:59 trogdor md:  adding sda1 ...
Jun 20 12:55:59 trogdor md: created md0
Jun 20 12:55:59 trogdor md: bind<sda1>
Jun 20 12:55:59 trogdor md: bind<sdb1>
Jun 20 12:55:59 trogdor md: running: <sdb1><sda1>
Jun 20 12:55:59 trogdor raid1: raid set md0 active with 2 out of 2 mirrors
Jun 20 12:55:59 trogdor md: ... autorun DONE.
Jun 20 12:55:59 trogdor kjournald starting.  Commit interval 5 seconds
Jun 20 12:55:59 trogdor EXT3-fs: mounted filesystem with ordered data mode.
Jun 20 12:55:59 trogdor VFS: Mounted root (ext3 filesystem) readonly.
Jun 20 12:55:59 trogdor EXT3 FS on md1, internal journal
Jun 20 12:55:59 trogdor sunhme.c:v2.02 8/24/03 David S. Miller (davem@redha=
t.com)
Jun 20 12:55:59 trogdor eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet=
 08:00:20:d1:fb:cf=20
Jun 20 12:55:59 trogdor e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NA=
PI
Jun 20 12:55:59 trogdor e100: Copyright(c) 1999-2005 Intel Corporation
Jun 20 12:55:59 trogdor ohci_hcd: Unknown symbol usb_hcd_pci_probe
Jun 20 12:55:59 trogdor ohci_hcd: Unknown symbol usb_disabled
Jun 20 12:55:59 trogdor e100: eth1: e100_probe: addr 0x1ff80100000, irq 780=
1600, MAC addr 00:D0:B7:81:DF:3B
Jun 20 12:55:59 trogdor ohci_hcd: Unknown symbol usb_calc_bus_time
Jun 20 12:55:59 trogdor ohci_hcd: Unknown symbol usb_hcd_giveback_urb
Jun 20 12:55:59 trogdor ohci_hcd: Unknown symbol usb_hcd_pci_remove
Jun 20 12:55:59 trogdor ohci_hcd: Unknown symbol usb_hcd_pci_probe
Jun 20 12:55:59 trogdor ohci_hcd: Unknown symbol usb_disabled
Jun 20 12:55:59 trogdor ohci_hcd: Unknown symbol usb_calc_bus_time
Jun 20 12:55:59 trogdor ohci_hcd: Unknown symbol usb_hcd_giveback_urb
Jun 20 12:55:59 trogdor e100: eth2: e100_probe: addr 0x1ff80300000, irq 780=
1632, MAC addr 00:D0:B7:81:DF:3C
Jun 20 12:55:59 trogdor usbcore: registered new driver usbfs
Jun 20 12:55:59 trogdor usbcore: registered new driver hub
Jun 20 12:55:59 trogdor ohci_hcd: Unknown symbol usb_hcd_pci_remove
Jun 20 12:55:59 trogdor ehci_hcd 0001:00:04.2: EHCI Host Controller
Jun 20 12:55:59 trogdor ehci_hcd 0001:00:04.2: new USB bus registered, assi=
gned bus number 1
Jun 20 12:55:59 trogdor ehci_hcd 0001:00:04.2: irq 10,7da, io mem 0x1ff8051=
4000
Jun 20 12:55:59 trogdor ehci_hcd 0001:00:04.2: USB 2.0 started, EHCI 0.95, =
driver 10 Dec 2004
Jun 20 12:55:59 trogdor usb usb1: configuration #1 chosen from 1 choice
Jun 20 12:55:59 trogdor hub 1-0:1.0: USB hub found
Jun 20 12:55:59 trogdor hub 1-0:1.0: 5 ports detected
Jun 20 12:55:59 trogdor usb 1-1: new high speed USB device using ehci_hcd a=
nd address 2
Jun 20 12:55:59 trogdor ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Control=
ler (OHCI) Driver (PCI)
Jun 20 12:55:59 trogdor ohci_hcd 0001:00:04.0: OHCI Host Controller
Jun 20 12:55:59 trogdor ohci_hcd 0001:00:04.0: new USB bus registered, assi=
gned bus number 2
Jun 20 12:55:59 trogdor ohci_hcd 0001:00:04.0: irq 10,7d8, io mem 0x1ff8051=
0000
Jun 20 12:55:59 trogdor usb 1-1: configuration #1 chosen from 1 choice
Jun 20 12:55:59 trogdor sr0: scsi3-mmc drive: 6x/6x writer xa/form2 cdda tr=
ay
Jun 20 12:55:59 trogdor Uniform CD-ROM driver Revision: 3.20
Jun 20 12:55:59 trogdor sr 0:0:6:0: Attached scsi CD-ROM sr0
Jun 20 12:55:59 trogdor usb usb2: configuration #1 chosen from 1 choice
Jun 20 12:55:59 trogdor hub 2-0:1.0: USB hub found
Jun 20 12:55:59 trogdor hub 2-0:1.0: 3 ports detected
Jun 20 12:55:59 trogdor Device not ready. Make sure there is a disc in the =
drive.
Jun 20 12:55:59 trogdor ohci_hcd 0001:00:04.1: OHCI Host Controller
Jun 20 12:55:59 trogdor ohci_hcd 0001:00:04.1: new USB bus registered, assi=
gned bus number 3
Jun 20 12:55:59 trogdor ohci_hcd 0001:00:04.1: irq 10,7d9, io mem 0x1ff8051=
2000
Jun 20 12:55:59 trogdor Initializing USB Mass Storage driver...
Jun 20 12:55:59 trogdor scsi2 : SCSI emulation for USB Mass Storage devices
Jun 20 12:55:59 trogdor usb-storage: device found at 2
Jun 20 12:55:59 trogdor usb-storage: waiting for device to settle before sc=
anning
Jun 20 12:55:59 trogdor usb 2-2: new full speed USB device using ohci_hcd a=
nd address 2
Jun 20 12:55:59 trogdor usb 2-2: configuration #1 chosen from 1 choice
Jun 20 12:55:59 trogdor hub 2-2:1.0: USB hub found
Jun 20 12:55:59 trogdor hub 2-2:1.0: 4 ports detected
Jun 20 12:55:59 trogdor usbcore: registered new driver usb-storage
Jun 20 12:55:59 trogdor USB Mass Storage support registered.
Jun 20 12:55:59 trogdor usb usb3: configuration #1 chosen from 1 choice
Jun 20 12:55:59 trogdor hub 3-0:1.0: USB hub found
Jun 20 12:55:59 trogdor hub 3-0:1.0: 2 ports detected
Jun 20 12:55:59 trogdor usb 2-2.2: new full speed USB device using ohci_hcd=
 and address 3
Jun 20 12:55:59 trogdor usb 2-2.2: not running at top speed; connect to a h=
igh speed hub
Jun 20 12:55:59 trogdor usb 2-2.2: configuration #1 chosen from 1 choice
Jun 20 12:55:59 trogdor scsi3 : SCSI emulation for USB Mass Storage devices
Jun 20 12:55:59 trogdor usb-storage: device found at 3
Jun 20 12:55:59 trogdor usb-storage: waiting for device to settle before sc=
anning
Jun 20 12:55:59 trogdor usb 3-2: new low speed USB device using ohci_hcd an=
d address 2
Jun 20 12:55:59 trogdor usb 3-2: configuration #1 chosen from 1 choice
Jun 20 12:55:59 trogdor usbcore: registered new driver hiddev
Jun 20 12:55:59 trogdor input: Logitech USB Trackball as /class/input/input2
Jun 20 12:55:59 trogdor input: USB HID v1.10 Mouse [Logitech USB Trackball]=
 on usb-0001:00:04.1-2
Jun 20 12:55:59 trogdor usbcore: registered new driver usbhid
Jun 20 12:55:59 trogdor drivers/usb/input/hid-core.c: v2.6:USB HID core dri=
ver
Jun 20 12:55:59 trogdor EXT3 FS on md1, internal journal
Jun 20 12:55:59 trogdor Netfilter messages via NETLINK v0.30.
Jun 20 12:55:59 trogdor ip_conntrack version 2.4 (8192 buckets, 65536 max) =
- 304 bytes per conntrack
Jun 20 12:55:59 trogdor sd 0:0:0:0: Attached scsi generic sg0 type 0
Jun 20 12:55:59 trogdor sd 0:0:1:0: Attached scsi generic sg1 type 0
Jun 20 12:55:59 trogdor sr 0:0:6:0: Attached scsi generic sg2 type 5
Jun 20 12:55:59 trogdor sd 1:0:0:0: Attached scsi generic sg3 type 0
Jun 20 12:55:59 trogdor Vendor: SONY      Model: DVD RW DRU-720A   Rev: JY02
Jun 20 12:55:59 trogdor Type:   CD-ROM                             ANSI SCS=
I revision: 00
Jun 20 12:55:59 trogdor sr1: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2=
 cdda tray
Jun 20 12:55:59 trogdor sr 2:0:0:0: Attached scsi CD-ROM sr1
Jun 20 12:55:59 trogdor sr 2:0:0:0: Attached scsi generic sg4 type 5
Jun 20 12:55:59 trogdor usb-storage: device scan complete
Jun 20 12:55:59 trogdor ReiserFS: sdc2: found reiserfs format "3.6" with st=
andard journal
Jun 20 12:55:59 trogdor Vendor: FUJITSU   Model: MHV2040AH         Rev: 0000
Jun 20 12:55:59 trogdor Type:   Direct-Access                      ANSI SCS=
I revision: 00
Jun 20 12:55:59 trogdor SCSI device sdd: 78140160 512-byte hdwr sectors (40=
008 MB)
Jun 20 12:55:59 trogdor sdd: Write Protect is off
Jun 20 12:55:59 trogdor sdd: Mode Sense: 00 14 00 00
Jun 20 12:55:59 trogdor sdd: assuming drive cache: write through
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 34461696
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 34199552
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 33937408
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 33413120
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 33150976
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 32888832
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 32626688
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 32364544
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 32102400
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 31578112
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 31315968
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 31053824
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 30791680
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 30529536
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 30267392
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 30005248
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 29743104
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 29480960
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 29218816
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 28956672
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 28694528
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 28170240
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 27908096
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 27383808
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 27121664
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 26859520
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 26597376
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 26073088
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 25810944
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 25548800
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 25286656
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 24762368
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 24500224
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 24238080
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 23975936
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 23713792
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 23451648
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 23189504
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 22927360
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 22665216
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 22403072
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 22140928
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 21878784
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 21616640
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 21354496
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 20830208
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 20568064
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 20305920
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 20043776
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 19781632
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 19519488
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 25024512
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 26335232
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 27645952
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 28432384
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 31840256
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 33675264
Jun 20 12:55:59 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:55:59 trogdor end_request: I/O error, dev sdc, sector 34723840
Jun 20 12:55:59 trogdor SCSI device sdd: 78140160 512-byte hdwr sectors (40=
008 MB)
Jun 20 12:55:59 trogdor sdd: Write Protect is off
Jun 20 12:55:59 trogdor sdd: Mode Sense: 00 14 00 00
Jun 20 12:55:59 trogdor sdd: assuming drive cache: write through
Jun 20 12:55:59 trogdor sdd:<4>ReiserFS: sdc2: warning: sh-2029: reiserfs r=
ead_bitmaps: bitmap block (#2195456) reading failed
Jun 20 12:55:59 trogdor ReiserFS: sdc2: warning: jmacd-8: reiserfs_fill_sup=
er: unable to read bitmap
Jun 20 12:55:59 trogdor sdd1 sdd2
Jun 20 12:55:59 trogdor sd 3:0:0:0: Attached scsi disk sdd
Jun 20 12:55:59 trogdor sd 3:0:0:0: Attached scsi generic sg5 type 0
Jun 20 12:55:59 trogdor usb-storage: device scan complete
Jun 20 12:55:59 trogdor ip_tables: (C) 2000-2006 Netfilter Core Team
Jun 20 12:55:59 trogdor Ethernet Channel Bonding Driver: v3.0.3 (March 23, =
2006)
Jun 20 12:55:59 trogdor bonding: MII link monitoring set to 100 ms
Jun 20 12:55:59 trogdor e100: eth1: e100_watchdog: link up, 100Mbps, full-d=
uplex
Jun 20 12:55:59 trogdor e100: eth2: e100_watchdog: link up, 100Mbps, full-d=
uplex
Jun 20 12:55:59 trogdor e100: eth1: e100_watchdog: link up, 100Mbps, full-d=
uplex
Jun 20 12:55:59 trogdor bonding: bond0: enslaving eth1 as an active interfa=
ce with an up link.
Jun 20 12:55:59 trogdor e100: eth2: e100_watchdog: link up, 100Mbps, full-d=
uplex
Jun 20 12:55:59 trogdor bonding: bond0: enslaving eth2 as an active interfa=
ce with an up link.
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22552064
Jun 20 12:56:14 trogdor raid1: sda2: rescheduling sector 22488576
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22547448
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22547384
Jun 20 12:56:14 trogdor raid1: sda2: rescheduling sector 22483896
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22547168
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22547160
Jun 20 12:56:14 trogdor raid1: sda2: rescheduling sector 22483672
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22547008
Jun 20 12:56:14 trogdor raid1: sda2: rescheduling sector 22483520
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22543504
Jun 20 12:56:14 trogdor raid1: sda2: rescheduling sector 22480016
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22543472
Jun 20 12:56:14 trogdor raid1: sda2: rescheduling sector 22479984
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22543432
Jun 20 12:56:14 trogdor raid1: sda2: rescheduling sector 22479944
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22542248
Jun 20 12:56:14 trogdor raid1: sda2: rescheduling sector 22478760
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22542232
Jun 20 12:56:14 trogdor raid1: sda2: rescheduling sector 22478744
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22541952
Jun 20 12:56:14 trogdor raid1: sda2: rescheduling sector 22478464
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22541936
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22541648
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22541608
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22541448
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22541432
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22541136
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22541008
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22540968
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22540816
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22540640
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22540608
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22540536
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22540528
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22540472
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22540456
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22540440
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22540416
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22540312
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22540256
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22540232
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22540192
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22540152
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22539720
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22539664
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22539616
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22539568
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22539496
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22539256
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22539240
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22539176
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22539152
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22539120
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22539008
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22538376
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22537408
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22552072
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22539576
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22540656
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22541024
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22541144
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22543512
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22547016
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22541624
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22540264
Jun 20 12:56:14 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:56:14 trogdor end_request: I/O error, dev sda, sector 22547184
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21044344
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21044096
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21043664
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21043632
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21043472
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21043392
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21042568
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21042472
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21042464
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21042376
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21042344
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21042280
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21042088
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21041992
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21041424
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21041152
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21041064
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21041032
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21040576
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21040448
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21040408
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21040304
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21040240
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21040192
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0028
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21044488
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21040312
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21040248
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0028
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21042488
Jun 20 12:56:15 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0028
Jun 20 12:56:15 trogdor end_request: I/O error, dev sdb, sector 21043408
Jun 20 12:56:30 trogdor Installing knfsd (copyright (C) 1996 okir@monad.swb=
=2Ede).
Jun 20 12:57:01 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:01 trogdor end_request: I/O error, dev sdb, sector 31258624
Jun 20 12:57:01 trogdor raid1: Disk failure on sdb2, disabling device.=20
Jun 20 12:57:01 trogdor 	Operation continuing on 1 devices
Jun 20 12:57:01 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:01 trogdor end_request: I/O error, dev sdb, sector 30948984
Jun 20 12:57:01 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:01 trogdor end_request: I/O error, dev sdb, sector 30734992
Jun 20 12:57:01 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:01 trogdor end_request: I/O error, dev sdb, sector 30734392
Jun 20 12:57:01 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:01 trogdor end_request: I/O error, dev sdb, sector 30734344
Jun 20 12:57:01 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:01 trogdor end_request: I/O error, dev sdb, sector 30734336
Jun 20 12:57:01 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0028
Jun 20 12:57:01 trogdor end_request: I/O error, dev sdb, sector 31260496
Jun 20 12:57:01 trogdor sd 0:0:1:0: SCSI error: return code =3D 0xb0028
Jun 20 12:57:01 trogdor end_request: I/O error, dev sdb, sector 27850752
Jun 20 12:57:01 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:01 trogdor end_request: I/O error, dev sda, sector 31260496
Jun 20 12:57:01 trogdor printk: 152 messages suppressed.
Jun 20 12:57:01 trogdor Buffer I/O error on device md1, logical block 38996=
26
Jun 20 12:57:01 trogdor lost page write due to I/O error on md1
Jun 20 12:57:01 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:01 trogdor end_request: I/O error, dev sda, sector 31258624
Jun 20 12:57:01 trogdor Buffer I/O error on device md1, logical block 38993=
92
Jun 20 12:57:01 trogdor lost page write due to I/O error on md1
Jun 20 12:57:01 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:01 trogdor end_request: I/O error, dev sda, sector 30948984
Jun 20 12:57:01 trogdor Buffer I/O error on device md1, logical block 38606=
87
Jun 20 12:57:01 trogdor lost page write due to I/O error on md1
Jun 20 12:57:01 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:01 trogdor end_request: I/O error, dev sda, sector 30734992
Jun 20 12:57:01 trogdor Buffer I/O error on device md1, logical block 38339=
38
Jun 20 12:57:01 trogdor lost page write due to I/O error on md1
Jun 20 12:57:01 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:01 trogdor end_request: I/O error, dev sda, sector 30734392
Jun 20 12:57:01 trogdor Buffer I/O error on device md1, logical block 38338=
63
Jun 20 12:57:01 trogdor lost page write due to I/O error on md1
Jun 20 12:57:01 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:57:01 trogdor end_request: I/O error, dev sda, sector 31260528
Jun 20 12:57:01 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:57:01 trogdor end_request: I/O error, dev sda, sector 30734344
Jun 20 12:57:01 trogdor Buffer I/O error on device md1, logical block 38338=
57
Jun 20 12:57:01 trogdor lost page write due to I/O error on md1
Jun 20 12:57:01 trogdor RAID1 conf printout:
Jun 20 12:57:01 trogdor --- wd:1 rd:2
Jun 20 12:57:01 trogdor disk 0, wo:0, o:1, dev:sda2
Jun 20 12:57:01 trogdor disk 1, wo:1, o:0, dev:sdb2
Jun 20 12:57:01 trogdor RAID1 conf printout:
Jun 20 12:57:01 trogdor --- wd:1 rd:2
Jun 20 12:57:01 trogdor disk 0, wo:0, o:1, dev:sda2
Jun 20 12:57:07 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:07 trogdor end_request: I/O error, dev sda, sector 15282736
Jun 20 12:57:07 trogdor Buffer I/O error on device md1, logical block 19024=
06
Jun 20 12:57:07 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:07 trogdor end_request: I/O error, dev sda, sector 15282704
Jun 20 12:57:07 trogdor Buffer I/O error on device md1, logical block 19024=
02
Jun 20 12:57:07 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:07 trogdor end_request: I/O error, dev sda, sector 15282640
Jun 20 12:57:07 trogdor Buffer I/O error on device md1, logical block 19023=
94
Jun 20 12:57:07 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:07 trogdor end_request: I/O error, dev sda, sector 15282520
Jun 20 12:57:07 trogdor Buffer I/O error on device md1, logical block 19023=
79
Jun 20 12:57:07 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:07 trogdor end_request: I/O error, dev sda, sector 15282456
Jun 20 12:57:07 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:07 trogdor end_request: I/O error, dev sda, sector 15282432
Jun 20 12:57:07 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:07 trogdor end_request: I/O error, dev sda, sector 15282376
Jun 20 12:57:07 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:07 trogdor end_request: I/O error, dev sda, sector 15282360
Jun 20 12:57:07 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:07 trogdor end_request: I/O error, dev sda, sector 15282312
Jun 20 12:57:07 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:07 trogdor end_request: I/O error, dev sda, sector 15282256
Jun 20 12:57:07 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:07 trogdor end_request: I/O error, dev sda, sector 15282232
Jun 20 12:57:07 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:57:07 trogdor end_request: I/O error, dev sda, sector 15282128
Jun 20 12:57:07 trogdor sd 0:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:57:07 trogdor end_request: I/O error, dev sda, sector 15283000
Jun 20 12:57:41 trogdor ReiserFS: sdc2: found reiserfs format "3.6" with st=
andard journal
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 34461696
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 34199552
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 33937408
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 33675264
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 33413120
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 33150976
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 32888832
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 32626688
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 32364544
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 32102400
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 31840256
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 31578112
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 31053824
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 30791680
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 30529536
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 30267392
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 29743104
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 29480960
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 29218816
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 28956672
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 28694528
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 28432384
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 28170240
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 27908096
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 27645952
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 27383808
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 27121664
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 26859520
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 26597376
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 26335232
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 26073088
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 25810944
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 25548800
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 25286656
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 25024512
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 24762368
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 24500224
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 24238080
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 23975936
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 23713792
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 23451648
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 22927360
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 22665216
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 22403072
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 22140928
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 21878784
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 21616640
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 21354496
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 21092352
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 20830208
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 20568064
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 20305920
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 20043776
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0000
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 19781632
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 30005248
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 31315968
Jun 20 12:57:41 trogdor sd 1:0:0:0: SCSI error: return code =3D 0xb0028
Jun 20 12:57:41 trogdor end_request: I/O error, dev sdc, sector 34723840
Jun 20 12:57:41 trogdor ReiserFS: sdc2: warning: sh-2029: reiserfs read_bit=
maps: bitmap block (#2228224) reading failed
Jun 20 12:57:41 trogdor ReiserFS: sdc2: warning: jmacd-8: reiserfs_fill_sup=
er: unable to read bitmap
Jun 20 13:11:11 trogdor nfsd: last server has exited
Jun 20 13:11:11 trogdor nfsd: unexporting all filesystems

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dotconfig-2.6.17"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.17-gentoo
# Tue Jun 20 13:46:30 2006
#
CONFIG_SPARC=y
CONFIG_SPARC64=y
CONFIG_64BIT=y
CONFIG_MMU=y
CONFIG_TIME_INTERPOLATION=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_SPARC64_PAGE_SIZE_8KB=y
# CONFIG_SPARC64_PAGE_SIZE_64KB is not set
# CONFIG_SPARC64_PAGE_SIZE_512KB is not set
# CONFIG_SPARC64_PAGE_SIZE_4MB is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_CPUSETS is not set
CONFIG_RELAY=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Block layer
#
CONFIG_BLK_DEV_IO_TRACE=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_IOSCHED_CFQ is not set
# CONFIG_DEFAULT_AS is not set
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"
CONFIG_SYSVIPC_COMPAT=y

#
# General machine setup
#
CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_NR_CPUS=4
# CONFIG_CPU_FREQ is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_HUGETLB_PAGE_SIZE_4MB=y
# CONFIG_HUGETLB_PAGE_SIZE_512K is not set
# CONFIG_HUGETLB_PAGE_SIZE_64K is not set
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_LARGE_ALLOCS=y
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
# CONFIG_DISCONTIGMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPARSEMEM_EXTREME=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_GENERIC_ISA_DMA=y
CONFIG_SBUS=y
CONFIG_SBUSCHAR=y
CONFIG_SUN_AUXIO=y
CONFIG_SUN_IO=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_SUN_OPENPROMFS=m
CONFIG_SPARC32_COMPAT=y
CONFIG_COMPAT=y
CONFIG_BINFMT_ELF32=y
CONFIG_BINFMT_AOUT32=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_SUNOS_EMUL is not set
# CONFIG_SOLARIS_EMUL is not set
# CONFIG_SCHED_SMT is not set
# CONFIG_CMDLINE_BOOL is not set

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_XTABLES=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
# CONFIG_NETFILTER_XT_TARGET_CONNMARK is not set
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
# CONFIG_NETFILTER_XT_MATCH_ESP is not set
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CONNTRACK_MARK=y
CONFIG_IP_NF_CONNTRACK_EVENTS=y
CONFIG_IP_NF_CONNTRACK_NETLINK=m
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_NETBIOS_NS=m
CONFIG_IP_NF_TFTP=m
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_PPTP is not set
# CONFIG_IP_NF_H323 is not set
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH is not set
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_HASHLIMIT=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
# CONFIG_IP_NF_TARGET_DSCP is not set
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
# CONFIG_IP_NF_RAW is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=500
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=256
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=256
CONFIG_SCSI_SYM53C8XX_MMIO=y
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLOGICPTI is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_SUNESP is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=m
CONFIG_MD_RAID5=m
CONFIG_MD_RAID5_RESHAPE=y
CONFIG_MD_RAID6=m
CONFIG_MD_MULTIPATH=y
# CONFIG_MD_FAULTY is not set
# CONFIG_BLK_DEV_DM is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_IEEE1394_OUI_DB=y
CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
# CONFIG_IEEE1394_CONFIG_ROM_IP1394 is not set
# CONFIG_IEEE1394_EXPORT_FULL_API is not set

#
# Device Drivers
#

#
# Texas Instruments PCILynx requires I2C
#
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
# CONFIG_IEEE1394_VIDEO1394 is not set
CONFIG_IEEE1394_SBP2=m
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
# CONFIG_IEEE1394_ETH1394 is not set
# CONFIG_IEEE1394_DV1394 is not set
CONFIG_IEEE1394_RAWIO=m

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
CONFIG_BONDING=m
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
CONFIG_PHYLIB=m

#
# MII PHY device drivers
#
CONFIG_MARVELL_PHY=m
CONFIG_DAVICOM_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_LXT_PHY=m
CONFIG_CICADA_PHY=m

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_SUNLANCE is not set
CONFIG_HAPPYMEAL=m
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
CONFIG_SUNGEM=m
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=m
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ATKBD is not set
CONFIG_KEYBOARD_SUNKBD=y
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_SPARCSPKR is not set
# CONFIG_INPUT_UINPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
# CONFIG_SERIO_I8042 is not set
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_RAW=y
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#

#
# Non-8250 serial port support
#
CONFIG_SERIAL_SUNCORE=y
# CONFIG_SERIAL_SUNZILOG is not set
CONFIG_SERIAL_SUNSU=y
CONFIG_SERIAL_SUNSU_CONSOLE=y
CONFIG_SERIAL_SUNSAB=y
CONFIG_SERIAL_SUNSAB_CONSOLE=y
# CONFIG_SERIAL_SUNHV is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
# CONFIG_WATCHDOG_CP1XXX is not set
# CONFIG_WATCHDOG_RIO is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_DRM is not set
# CONFIG_RAW_DRIVER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Misc devices
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set
CONFIG_VIDEO_V4L2=y

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_USB_DABUSB is not set

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CFB_FILLRECT is not set
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_FIRMWARE_EDID=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_SBUS=y
# CONFIG_FB_BW2 is not set
# CONFIG_FB_CG3 is not set
# CONFIG_FB_CG6 is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_FFB=y
# CONFIG_FB_TCX is not set
# CONFIG_FB_CG14 is not set
# CONFIG_FB_P9100 is not set
# CONFIG_FB_LEO is not set
# CONFIG_FB_PCI is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_PROM_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_SUN8x16=y
# CONFIG_FONT_SUN12x22 is not set

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_LOGO_SUN_CLUT224 is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
CONFIG_SPEAKUP_DEFAULT="none"

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1X=m
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# ALSA Sparc devices
#
# CONFIG_SND_SUN_AMD7930 is not set
CONFIG_SND_SUN_CS4231=m
# CONFIG_SND_SUN_DBRI is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_TOUCHSCREEN is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
CONFIG_USB_MON=y

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
CONFIG_USB_LD=m
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#

#
# Real Time Clock
#
# CONFIG_RTC_CLASS is not set

#
# Misc Linux/SPARC drivers
#
# CONFIG_SUN_OPENPROMIO is not set
CONFIG_SUN_MOSTEK_RTC=y
CONFIG_OBP_FLASH=m
CONFIG_SUN_BPP=m
# CONFIG_BBC_I2C is not set
CONFIG_ENVCTRL=y
# CONFIG_DISPLAY7SEG is not set

#
# Fibre Channel support
#
# CONFIG_FC4 is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
CONFIG_XFS_FS=m
CONFIG_XFS_EXPORT=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_SECURITY is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
CONFIG_CONFIGFS_FS=m

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=m

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SUN_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=17
# CONFIG_DETECT_SOFTLOCKUP is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_PREEMPT is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_VM is not set
# CONFIG_UNWIND_INFO is not set
CONFIG_FORCED_INLINING=y
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_DCFLUSH is not set
# CONFIG_STACK_DEBUG is not set
# CONFIG_DEBUG_BOOTMEM is not set
# CONFIG_DEBUG_PAGEALLOC is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_DEBUG_PROC_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
CONFIG_CRYPTO_SHA1=m
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#

#
# Library routines
#
CONFIG_CRC_CCITT=m
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=m
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m

--fUYQa+Pmc3FrFX/N--

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEmDboLYBaX8VDLLURAi1uAKCrTC989IYoFzPbNyuXiBX8/+R0rgCgk5+R
1wUZCF4kcidPR7RlV5QBrmo=
=5JwQ
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
