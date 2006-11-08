From: "Paul Williams" <Paul.Williams@eads.com>
Date: Wed, 08 Nov 2006 12:16:11 +0000
Subject: RAMDISK error at 0
Message-Id: <A5E49A0595FB4A489ED566217349B14702DC9553@zaphod1.cogent-dsn.local>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

I've got a CD here which is SUPPOSED to work - trouble is it fails with=20
the following error:-=20

Linux version 2.4.26 (root@localhost) (gcc version 3.3.3 20040217 (Gentoo L=
inux
3.3.3)) #3 Mon Jun 6 08:00:21 GMT 2005
ARCH: SUN4U
Ethernet address: 00:03:ba:b0:9a:79
On node 0 totalpages: 129820
zone(0): 196444 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Found CPU 0 (node=F0072d50,mid=3D0)
Found 1 CPU prom device tree node(s).
Kernel command line: ro ramdisk2768 cdrom
Calibrating delay loop... 1294.33 BogoMIPS
Memory: 1020080k available (1880k kernel code, 320k data, 144k init) [fffff=
80000
000000,00000000dfeb8000]
Dentry cache hash table entries: 131072 (order: 8, 2097152 bytes)
Inode cache hash table entries: 65536 (order: 7, 1048576 bytes)
Mount cache hash table entries: 512 (order: 0, 8192 bytes)
Buffer cache hash table entries: 65536 (order: 6, 524288 bytes)
Page-cache hash table entries: 131072 (order: 7, 1048576 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing for controllers.
PCI: Found SABRE, main regs at 000001fe00000000, wsync at 000001fe00001c20
SABRE: Shared PCI config space at 000001fe01000000
SABRE: DVMA at 60000000 [20000000]
PCI: Address space collision on region 6 [000001ff00080000:000001ff000bffff=
] of
device PCI device 1282:9102
PCI-IRQ: Routing bus[ 0] slot[ 5] map[0] to INO[1c]
PCI-IRQ: Routing bus[ 0] slot[ a] map[0] to INO[24]
PCI-IRQ: Routing bus[ 0] slot[ c] map[0] to INO[06]
PCI-IRQ: Routing bus[ 0] slot[ d] map[0] to INO[0c]
PCI0(PBMA): Bus running at 33MHz
isa0: [dma] [rtc -> (todm5819)] [power] [SUNW,lomh] [serial] [serial] [flas=
hprom]
ebus: No EBus's found.
PCIO serial driver version 1.54
su(serial) at 0x1fe020003f8 (tty 0 irq 12,7eb) is a 16550A
su(serial) at 0x1fe020002e8 (tty 1 irq 12,7eb) is a 16550A
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
udf: registering filesystem
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10f
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ALI15X3: IDE controller at PCI slot 00:0d.0
ALI15X3: chipset revision 195
ALI15X3: 100% native mode on irq 4,7cc
    ide0: BM-DMA at 0x1fe02010220-0x1fe02010227, BIOS settings: hda:pio, hd=
b:pio
    ide1: BM-DMA at 0x1fe02010228-0x1fe0201022f, BIOS settings: hdc:pio, hd=
d:pio
hda: ST380011A, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
hdc: ST380011A, ATA DISK drive
hdd: CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1fe02010200-0x1fe02010207,0x1fe0201021a on irq 4,7cc
ide1 at 0x1fe02010210-0x1fe02010217,0x1fe0201020a on irq 4,7cc
hda: attached ide-disk driver.
hda: host protected area =3D> 1
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(66)
hdc: attached ide-disk driver.
hdc: host protected area =3D> 1
hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(66)
hdd: attached ide-cdrom driver.
hdd: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8
 hdc: hdc2 hdc3
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno =3D 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno =3D 2
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/usb-uhci.c: $Revision: 1.275 $ time 08:04:17 Jun  6 2005
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
host/usb-ohci.c: USB OHCI at membase 0x1ff01000000, IRQ 14,7e4
host/usb-ohci.c: usb-00:0a.0, PCI device 10b9:5237
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
Initializing Cryptographic API
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Couldn't find valid RAM disk image starting at 0.
Freeing initrd memory: 5023k freed
VFS: Cannot open root device "" or 00:00
Please append a correct "root=3D" boot option
Kernel panic: VFS: Unable to mount root fs on 00:00
 Press L1-A to return to the boot prom

Also, heres the relevant silo.conf

partition=3D1
timeout=10
read-only
message=3D/boot/cogent.txt
default=3Dlinux
append=3D"cdrom"
initrd=3D/boot/root.bin.gz
ramdisk2768

# Standard boot images
image[sun4c,sun4d,sun4m]=3D/boot/sparc32.gz
   label=3Dlinux
image[sun4u]=3D/boot/sparc64
   label=3Dlinux

Any ideas?=20
BTW - where do u get the sparc images from in the first place to put on=20
the CD? I'm assuming my predecessor got them from somewhere since they=20
dont seem to be part of the Silo download.=20
end




The information contained within this e-mail and any files attached to this=
 e-mail is private and in addition may include commercially sensitive infor=
mation. The contents of this e-mail are for the intended recipient only and=
 therefore if you wish to disclose the information contained within this e-=
mail or attached files, please contact the sender prior to any such disclos=
ure.=20

If you are not the intended recipient, any disclosure, copying or distribut=
ion is prohibited. Please also contact the sender and inform them of the er=
ror and delete the e-mail, including any attached files from your system.

www.eadsdsuk.com=20


