From: Alexey Nezhdanov <snake@penza-gsm.ru>
Date: Wed, 07 Apr 2004 06:43:30 +0000
Subject: Can't boot linux on sun blade 2000
Message-Id: <200404071043.30060.snake@penza-gsm.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hello. I've already asked my question on debian-sparc and debian boot=20
maillists and got a lot of help but still can't solve the problem entirely.
The problem is (slightly edited minicom log):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Resetting ...

 TTYA not found.
TTYA not found.

SUNW,Sun-Blade-1000 (UltraSPARC-III+) , Keyboard Present
Copyright 1998-2002 Sun Microsystems, Inc.  All rights reserved.
OpenBoot 4.5, 1024 MB memory installed, Serial #53064360.
Ethernet address 0:3:ba:29:b2:a8, Host ID: 8329b2a8.

Initializing Memory
                                                                     =20
Rebooting with command: boot net:dhcp serial console=3DttyS0 -p
Boot device: /pci@8,700000/network@5,1:dhcp  File and args: serial=20
console=3DttyS0 -p

<TFTP COUNTER (booting=20
http://www.phunnypharm.org/pub/for/sparc-folks/disks-sparc/current/sparc64/=
tftpboot.img=20
image)>

PROMLIB: Sun IEEE Boot Prom 4.5.21 2003/02/24 17:23
<4>Linux version 2.4.21 (root@blimpo) (gcc version 3.3.2 (Debian)) #1 Sat N=
ov=20
29 15:40:07 EST 2003
<4>ARCH: SUN4U
Linux version 2.4.21 (root@blimpo) (gcc version 3.3.2 (Debian)) #1 Sat Nov =
29=20
15:40:07 EST 2003
<4>ARCH: SUN4U
ARCH: SUN4U
Ethernet address: 00:03:ba:29:b2:a8
Remapping the kernel... done.
On node 0 totalpages: 130251
zone(0): 130929 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Booting Linux...
Found CPU 0 (node=F006bd10,mid=3D0)
Found 1 CPU prom device tree node(s).
Kernel command line: serial console=3DttyS0 -p
Console: colour dummy device 80x25
Calibrating delay loop... 599.65 BogoMIPS
Memory: 1029680k available (2504k kernel code, 576k data, 184k init)=20
[fffff80000000000,000000003fee2000]
Dentry cache hash table entries: 131072 (order: 8, 2097152 bytes)
Inode cache hash table entries: 65536 (order: 7, 1048576 bytes)
Mount cache hash table entries: 512 (order: 0, 8192 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 524288 bytes)
Page-cache hash table entries: 131072 (order: 7, 1048576 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing for controllers.
SCHIZO0 PBMB: ver[5:0], portid 8, cregs[40004400000] pregs[40004700000]
SCHIZO0 PBMB: PCI CFG[7ffee000000] IO[7ffef000000] MEM[7fe00000000]
SCHIZO0 PBMA: ver[5:0], portid 8, cregs[40004400000] pregs[40004600000]
SCHIZO0 PBMA: PCI CFG[7ffec000000] IO[7ffed000000] MEM[7fd00000000]
PCI-IRQ: Routing bus[ 0] slot[ 1] map[0] to INO[0c]
PCI-IRQ: Routing bus[ 0] slot[ 2] map[0] to INO[10]
PCI-IRQ: Routing bus[ 0] slot[ 5] map[0] to INO[1d]
PCI-IRQ: Routing bus[ 0] slot[ 5] map[0] to INO[1e]
PCI-IRQ: Routing bus[ 0] slot[ 5] map[0] to INO[1f]
PCI-IRQ: Routing bus[ 0] slot[ 6] map[0] to INO[18]
PCI-IRQ: Routing bus[ 0] slot[ 6] map[0] to INO[19]
PCI0(PBMB): Bus running at 33MHz
PCI-IRQ: Routing bus[ 1] slot[ 4] map[0] to INO[04]
PCI0(PBMA): Bus running at 66MHz
ebus0: [flashprom] [bbc] [ppm] [i2c -> (dimm-fru) (dimm-fru) (dimm-fru)=20
(dimm-fru) (nvram) (idprom)] [i2c -> (cpu-fru) (temperature) (fan-control) =

(card-reader) (motherboard-fru) (i2c-bridge)] [beep] [audio] [rtc] [gpio]=20
[pmc] [floppy] [parallel] [serial]
SAB82532 serial driver version 1.65
ttyS00 at 0x7fe7e400000 (irq =3D 12,222) is a SAB82532 V3.2
ttyS01 at 0x7fe7e400040 (irq =3D 12,222) is a SAB82532 V3.2
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
chmc0: US3 memory controller at 0000040000400000 [ACTIVE]
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
atyfb: 3D RAGE (XL) [0x4752 rev 0x27] 8M SGRAM, 29.498928 MHz XTAL, 230 MHz=
=20
PLL, 100 Mhz MCLK
Console: switching to colour frame buffer device 80x30
fb0: ATY Mach64 frame buffer device on PCI
kbd_init: Assuming USB keyboard.
8042(speaker): iobase[000007fe7e000032]
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10e
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
sungem.c:v0.97 3/20/02 David S. Miller (davem@redhat.com)
eth%d: MII PHY ID: 18074c0 Lucent
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:ba:29:b2:a8
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
SCSI subsystem driver Revision: 1.00
qlogicfc0 : Could not read from NVRAM
qlogicfc0 : Loop Reinitialized
qlogicfc0 : Link is Up
scsi0 : QLogic ISP2200 SCSI on PCI bus 01 device 20 irq 7683520 base=20
0x7ffed000300
qlogicfc0 : Port Database
wwn: 200000e08b000000  scsi_id: 0  loop_id: 0
wwn: 500000e010307b31  scsi_id: 1  loop_id: 1
wwn: 21000004cf574692  scsi_id: 2  loop_id: 2
  Vendor: FUJITSU   Model: MAN3735F SUN72G   Rev: 0704
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST373307FSUN72G   Rev: 0207
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym.0.6.0: setting PCI_COMMAND_INVALIDATE.
sym.0.6.1: setting PCI_COMMAND_INVALIDATE.
sym0: <875> rev 0x37 on pci bus 0 device 6 function 0 irq 4,218
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
sym1: <875> rev 0x37 on pci bus 0 device 6 function 1 irq 4,219
sym1: No NVRAM, ID 7, Fast-20, SE, parity checking
sym1: SCSI BUS has been reset.
scsi1 : sym-2.1.17a
scsi2 : sym-2.1.17a
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1401  Rev: 1009
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
SCSI device sda: 143374738 512-byte hdwr sectors (73408 MB)
Partition check:
 /dev/scsi/host0/bus0/target1/lun0: p1 p2 p3 p4 p5 p8
SCSI device sdb: 143374738 512-byte hdwr sectors (73408 MB)
 /dev/scsi/host0/bus0/target2/lun0: p1 p2 p3 p7
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/usb-uhci.c: $Revision: 1.275 $ time 15:49:35 Nov 29 2003
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
host/usb-ohci.c: USB OHCI at membase 0x7fe01000000, IRQ 9,21f
host/usb-ohci.c: usb-00:05.3, PCI device 108e:1103
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 4 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
Linux video capture interface: v1.00
mice: PS/2 mouse device common for all mice
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1229k freed
VFS: Mounted root (ext2 filesystem).
Warning: unable to open an initial console.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DThat's all. =
It hangs here.

If I specify init=3D/bin/sh it attempts to kill init and panics.

If I'm plugging out keyboard or using "real" console or serial port connect=
ion=20
- it not matters and the problem persists.

I've got some hints about "TTYA not found." in the very beginning but I do =
not=20
know what to tell openboot to use insted (And I fear to experiment to not=20
broke openboot - I'm very newbie on sparc but have good experience with=20
linux).

Please help or point me to a proper maillist (may-be ultralinux ? ).

--=20
Respectfully
Alexey Nezhdanov



