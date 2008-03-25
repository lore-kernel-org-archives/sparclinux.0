From: Dennis Gilmore <dennis@ausil.us>
Date: Tue, 25 Mar 2008 17:00:56 +0000
Subject: Netra X1 opps
Message-Id: <200803251201.02181.dennis@ausil.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1612248.3bTaqi4EyR"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--nextPart1612248.3bTaqi4EyR
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Im getting an opps switching to init with kernel-2.6.25-0.151.rc6.git7.fc9 =
=20
build logs from the kernel can be found at
http://sparc.koji.fedoraproject.org/packages/kernel/2.6.25/0.151.rc6.git7.f=
c9/data/logs/sparc64/

the kernel was built with gcc-4.3.0-3 it has the recent patches for big ker=
nel=20
images applied.

Sun Netra X1 (UltraSPARC-IIe 400MHz), No Keyboard
OpenBoot 4.0, 1024 MB memory installed, Serial #50714290.
Ethernet address 0:3:ba:5:d6:b2, Host ID: 8305d6b2.



Executing last command: boot                                         =20
Boot device: disk  File and args:=20
SILO Version 1.4.13
\
Welcome to Aurora!
Hit <TAB> for boot options

boot:=20
2.6.25-0.151.rc          2.6.23.1-26.5.a         =20
boot: 2.6.25-0.151.rc enforcing=3D0
Allocated 64 Megs of memory at 0x40000000 for kernel
Loaded kernel version 2.6.25
Loading initial ramdisk (7471887 bytes at 0x6F000000 phys, 0x40C00000 virt)=
=2E..
=2D
PROMLIB: Sun IEEE Boot Prom 'OBP 4.0.6 2001/02/19 09:56'
PROMLIB: Root node compatible: sun4u
Initializing cgroup subsys cpu
Linux version 2.6.25-0.151.rc6.git7.fc9 (mockbuild@) (gcc version 4.3.0=20
20080314 (Red Hat 4.3.0-3) (GCC) ) #1 Mon Mar 24 23:44:17 EDT 2008
console [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 00:03:ba:05:d6:b2
Kernel: Using 2 locked TLB entries for main kernel image.
Remapping the kernel... done.
[0000000200000000-fffff80000400000] page_structs=3D262144 node=3D0 entry=3D=
0/0
[0000000200000000-fffff80000800000] page_structs=3D262144 node=3D0 entry=3D=
1/0
[0000000200000000-fffff80000c00000] page_structs=3D262144 node=3D0 entry=3D=
2/0
[0000000200000000-fffff80001000000] page_structs=3D262144 node=3D0 entry=3D=
3/0
Allocated 1056768 bytes for kernel page tables.
OF stdout device is: /pci@1f,0/isa@7/serial@0,3f8
PROM: Built device tree with 45756 bytes of memory.
Booting Linux...
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 128740
Kernel command line: root=3D/dev/VolGroup00/LogVol00 ro console=3DttyS0,960=
0n8=20
enforcing=3D0
PID hash table entries: 4096 (order: 12, 32768 bytes)
clocksource: mult[b40001] shift[16]
clockevent: mult[16c16bf] shift[32]
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
Memory: 1014992k available (2672k kernel code, 1176k data, 160k init)=20
[fffff80000000000,000000006fec8000]
SLUB: Genslabs=3D13, HWalign=3D32, Order=3D0-2, MinObjects=3D8, CPUs=3D1, N=
odes=3D1
Calibrating delay using timer specific routine.. 11.14 BogoMIPS (lpj=3D5570=
2)
Security Framework initialized
SELinux:  Initializing.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
khelper used greatest stack depth: 10384 bytes left
net_namespace: 1040 bytes
NET: Registered protocol family 16
PCI: Probing for controllers.
/pci@1f,0: SABRE PCI Bus Module
/pci@1f,0: PCI IO[1fe02000000] MEM[1ff00000000]
PCI: Scanning PBM /pci@1f,0
pci 0000:00:03.0: quirk: region 2000-203f claimed by ali7101 ACPI
pci 0000:00:03.0: quirk: region 4000-401f claimed by ali7101 SMB
isa0: [dma] [rtc] [power] [SUNW,lomh] [serial] [serial] [flashprom]
ebus: No EBus's found.
power: Control reg at 1fe02002000
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NetLabel: Initializing
NetLabel:  domain hash size =3D 128
NetLabel:  protocols =3D UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
/pci@1f,0/isa@7/rtc@0,70: Clock regs at 000001fe02000070
Time: hbtick clocksource has been installed.
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 65536 bytes)
TCP established hash table entries: 32768 (order: 6, 524288 bytes)
TCP bind hash table entries: 32768 (order: 7, 1048576 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
checking if image is initramfs... it is
=46reeing initrd memory: 7296k freed
Mini RTC Driver
audit: initializing netlink socket (disabled)
type=3D2000 audit(1206463038.364:1): initialized
Total HugeTLB memory allocated, 0
khelper used greatest stack depth: 10048 bytes left
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:00:07.0: Activating ISA DMA hang workarounds
f0075d40: ttyS0 at MMIO 0x1fe020003f8 (irq =3D 7) is a 16550A
Console: ttyS0 (SU)
console handover: boot [earlyprom0] -> real [ttyS0]
f0077a2c: ttyS1 at MMIO 0x1fe020002e8 (irq =3D 7) is a 16550A
khelper used greatest stack depth: 10016 bytes left
brd: module loaded
mice: PS/2 mouse device common for all mice
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
registered taskstats version 1
Red Hat nash version 6.0.40 starting
Mounting proc filesystem
Mounting sysfs filesystem
Creating /dev
Creating initial device nodes
Setting up hotplug.
Creating block device nodes.
Loading ehci-hcd mmodprobe used greatest stack depth: 0 bytes left
odule
Loading ohci-hcd module
ohci_hcd 0000:00:0a.0: OHCI Host Controller
ohci_hcd 0000:00:0a.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0a.0: irq 11, io mem 0x1ff01000000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0001
usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.25-0.151.rc6.git7.fc9 ohci_hcd
usb usb1: SerialNumber: 0000:00:0a.0
Loading uhci-hcd module
USB Universal Host Controller Interface driver v3.0
Loading ext3 module
Loading scsi_mod module
SCSI subsystem initialized
Loading sd_mod module
Driver 'sd' needs updating - please use bus_type methods
Loading libata module
Loading pata_ali module
scsi0 : pata_ali
scsi1 : pata_ali
ata1: PATA max UDMA/66 cmd 0x1fe02010200 ctl 0x1fe02010218 bmdma 0x1fe02010=
220=20
irq 12
ata2: PATA max UDMA/66 cmd 0x1fe02010210 ctl 0x1fe02010208 bmdma 0x1fe02010=
228=20
irq 12
ata1.00: ATA-5: QUANTUM FIREBALLP LM10.2, A35.0700, max UDMA/66
ata1.00: 19925880 sectors, multi 0: LBA=20
ata1.00: configured for UDMA/66
ata2.00: ATA-6: WDC WD800BB-22FJA0, 13.03G13, max UDMA/100
ata2.00: 156301488 sectors, multi 0: LBA=20
ata2.00: configured for UDMA/66
scsi 0:0:0:0: Direct-Access     ATA      QUANTUM FIREBALL A35. PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 19925880 512-byte hardware sectors (10202 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't suppor=
t=20
DPO or FUA
sd 0:0:0:0: [sda] 19925880 512-byte hardware sectors (10202 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't suppor=
t=20
DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: Direct-Access     ATA      WDC WD800BB-22FJ 13.0 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 156301488 512-byte hardware sectors (80026 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't suppor=
t=20
DPO or FUA
sd 1:0:0:0: [sdb] 156301488 512-byte hardware sectors (80026 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't suppor=
t=20
DPO or FUA
 sdb: sdb1 sdb3
sd 1:0:0:0: [sdb] Attached SCSI disk
Waiting for driver initialization.
Loading ata_generic module
Loading dm-mod module
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised:=20
dm-devel@redhat.com
Loading dm-mirror module
Loading dm-zero module
Loading dm-snapshot module
Making device-mapper control node
Scanning logical volumes
  Reading all physical volumes.  This may take a while...
  Found volume group "VolGroup00" using metadata type lvm2
Activating logical volumes
  2 logical volume(s) in volume group "VolGroup00" now active
Creating root device.
Mounting root filesystem.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Setting up other filesystems.
Setting up new root fs
no fstab.sys, mounting internal defaults
security:  class memprotect not defined in policy
security:  class peer not defined in policy
security:  class capability2 not defined in policy
security:  permission recvfrom in class node not defined in policy
security:  permission sendto in class node not defined in policy
security:  permission ingress in class netif not defined in policy
security:  permission egress in class netif not defined in policy
security:  permission setfcap in class capability not defined in policy
security:  permission forward_in in class packet not defined in policy
security:  permission forward_out in class packet not defined in policy
SELinux: policy loaded with handle_unknown=3Ddeny
type=3D1403 audit(1206463052.898:2): policy loaded auid=3D4294967295=20
ses=3D4294967295
Switching to new root and running init.
unmounting old /dev
unmounting old /proc
unmounting old /sys
Unable to handle kernel paging request at virtual address fffff8006cbe0000
tsk->{mm,active_mm}->context =3D 0000000000000027
tsk->{mm,active_mm}->pgd =3D fffff8006c1ce000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
sh(388): Oops [#1]
TSTATE: 0000004411009605 TPC: 0000000000563390 TNPC: 0000000000563394 Y:=20
00000000    Not tainted
TPC: <___copy_to_user+0x1218/0x13c0>
g0: 0000000000330000 g1: 0000000000000011 g2: 0000000000000000 g3:=20
0000000000000000
g4: fffff8006e1af020 g5: 0000000000260100 g6: fffff8006cbdc000 g7:=20
0000000000000080
o0: 000007feffac8d68 o1: fffff8006cbe0000 o2: 0000000000000000 o3:=20
00000ffe92ee8d68
o4: 000007feffac8d68 o5: fffff80100260120 sp: fffff8006cbdf521 ret_pc:=20
0000000000432f68
RPC: <do_notify_resume+0x200/0x584>
l0: fffff801004917c8 l1: 0000000000000005 l2: fffff8006e1af490 l3:=20
0000000000000000
l4: 0000000000000000 l5: 0000000000000014 l6: 0000000000000000 l7:=20
fffff8010048c000
i0: fffff8006cbdff60 i1: 000007feffac8d68 i2: fffff8006cbe0000 i3:=20
000007feffac8b60
i4: 0000000000000000 i5: 0000000000000000 i6: fffff8006cbdf6a1 i7:=20
0000000000404a9c
I7: <__handle_signal+0x18/0x34>
Caller[0000000000404a9c]: __handle_signal+0x18/0x34
Caller[000000000013b91c]: 0x13b924
Instruction DUMP: 96220009  8e2aa00f  940aa00f <da5a6000> c25a6008  8ea1e01=
0 =20
daf2422b  92026008  c2f2422b=20
init: rcS main process (388) killed by KILL signal

--nextPart1612248.3bTaqi4EyR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iEYEABECAAYFAkfpL84ACgkQkSxm47BaWfdqkACfeFciwDEcrTpuE4u79ViSIxZu
ZuwAn3Aq95/autT3ghAHOU8NxnL2Kgjm
=gCh5
-----END PGP SIGNATURE-----

--nextPart1612248.3bTaqi4EyR--
