From: Meelis Roos <mroos@linux.ee>
Date: Wed, 07 Jul 2004 14:37:28 +0000
Subject: 2.6.7+BK: PCI scan gives lots of "bad: scheduling while atomic!"
Message-Id: <Pine.GSO.4.44.0407071734050.18568-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is a Ultra 5 with a couple of PCI cards (USB, VGA and SCSI). Tried
todays Bk snapshot, it came up and works but gave lots of errors:

PROMLIB: Sun IEEE Boot Prom 3.31.0 2001/07/25 20:36
Linux version 2.6.7 (mroos@mandariin) (gcc version 3.3.4 (Debian 1:3.3.4-2)) #66 Wed Jul 7 17:10:45 EEST 2004
ARCH: SUN4U
Ethernet address: 08:00:20:f8:c7:72
On node 0 totalpages: 40401
  DMA zone: 40401 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro
PID hash table entries: 2048 (order 11: 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
Memory: 318336k available (2072k kernel code, 1112k data, 136k init) [fffff80000000000,000000001ff42000]
Calibrating delay loop... 716.80 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
NET: Registered protocol family 16
PCI: Probing for controllers.
PCI: Found SABRE, main regs at 000001fe00000000, wsync at 000001fe00001c20
SABRE: Shared PCI config space at 000001fe01000000
SABRE: DVMA at c0000000 [20000000]
bad: scheduling while atomic!
Call Trace:
 [000000000045a88c] call_usermodehelper+0xac/0xc0
 [00000000005052bc] kset_hotplug+0x1bc/0x240
 [00000000005054fc] kobject_add+0x7c/0x100
 [000000000054cd70] class_device_add+0x50/0x140
 [00000000005214e8] pci_scan_bus_parented+0xe8/0x180
 [00000000007304bc] sabre_scan_bus+0x5c/0x1e0
 [000000000072c690] pci_scan_each_controller_bus+0x30/0x80
 [000000000072c79c] pcibios_init+0x1c/0x80
 [00000000007286dc] do_initcalls+0x3c/0xe0
 [00000000004142c4] init+0x44/0x180
 [0000000000417330] kernel_thread+0x30/0x60
 [0000000000414190] rest_init+0x10/0x80
bad: scheduling while atomic!
Call Trace:
 [000000000045a88c] call_usermodehelper+0xac/0xc0
 [00000000005052bc] kset_hotplug+0x1bc/0x240
 [00000000005054fc] kobject_add+0x7c/0x100
 [000000000054cd70] class_device_add+0x50/0x140
 [0000000000520ab0] pci_alloc_child_bus+0x70/0xe0
 [0000000000520bf8] pci_scan_bridge+0x98/0x200
 [0000000000521394] pci_scan_child_bus+0x94/0xc0
 [0000000000521538] pci_scan_bus_parented+0x138/0x180
 [00000000007304bc] sabre_scan_bus+0x5c/0x1e0
 [000000000072c690] pci_scan_each_controller_bus+0x30/0x80
 [000000000072c79c] pcibios_init+0x1c/0x80
 [00000000007286dc] do_initcalls+0x3c/0xe0
 [00000000004142c4] init+0x44/0x180
 [0000000000417330] kernel_thread+0x30/0x60
 [0000000000414190] rest_init+0x10/0x80
bad: scheduling while atomic!
Call Trace:
 [000000000045a88c] call_usermodehelper+0xac/0xc0
 [00000000005052bc] kset_hotplug+0x1bc/0x240
 [00000000005054fc] kobject_add+0x7c/0x100
 [000000000054cd70] class_device_add+0x50/0x140
 [0000000000520ab0] pci_alloc_child_bus+0x70/0xe0
 [0000000000520bf8] pci_scan_bridge+0x98/0x200
 [0000000000521394] pci_scan_child_bus+0x94/0xc0
 [0000000000521538] pci_scan_bus_parented+0x138/0x180
 [00000000007304bc] sabre_scan_bus+0x5c/0x1e0
 [000000000072c690] pci_scan_each_controller_bus+0x30/0x80
 [000000000072c79c] pcibios_init+0x1c/0x80
 [00000000007286dc] do_initcalls+0x3c/0xe0
 [00000000004142c4] init+0x44/0x180
 [0000000000417330] kernel_thread+0x30/0x60
 [0000000000414190] rest_init+0x10/0x80
bad: scheduling while atomic!
Call Trace:
 [000000000045a88c] call_usermodehelper+0xac/0xc0
 [00000000005052bc] kset_hotplug+0x1bc/0x240
 [00000000005054fc] kobject_add+0x7c/0x100
 [000000000054acf0] device_add+0x50/0x120
 [00000000005201ec] pci_bus_add_devices+0x10c/0x1a0
 [0000000000521548] pci_scan_bus_parented+0x148/0x180
 [00000000007304bc] sabre_scan_bus+0x5c/0x1e0
 [000000000072c690] pci_scan_each_controller_bus+0x30/0x80
 [000000000072c79c] pcibios_init+0x1c/0x80
 [00000000007286dc] do_initcalls+0x3c/0xe0
 [00000000004142c4] init+0x44/0x180
 [0000000000417330] kernel_thread+0x30/0x60
 [0000000000414190] rest_init+0x10/0x80
bad: scheduling while atomic!
Call Trace:
 [000000000045a88c] call_usermodehelper+0xac/0xc0
 [00000000005052bc] kset_hotplug+0x1bc/0x240
 [00000000005054fc] kobject_add+0x7c/0x100
 [000000000054acf0] device_add+0x50/0x120
 [00000000005201ec] pci_bus_add_devices+0x10c/0x1a0
 [0000000000521548] pci_scan_bus_parented+0x148/0x180
 [00000000007304bc] sabre_scan_bus+0x5c/0x1e0
 [000000000072c690] pci_scan_each_controller_bus+0x30/0x80
 [000000000072c79c] pcibios_init+0x1c/0x80
 [00000000007286dc] do_initcalls+0x3c/0xe0
 [00000000004142c4] init+0x44/0x180
 [0000000000417330] kernel_thread+0x30/0x60
 [0000000000414190] rest_init+0x10/0x80
bad: scheduling while atomic!
Call Trace:
 [000000000045a88c] call_usermodehelper+0xac/0xc0
 [00000000005052bc] kset_hotplug+0x1bc/0x240
 [00000000005054fc] kobject_add+0x7c/0x100
 [000000000054acf0] device_add+0x50/0x120
 [00000000005201ec] pci_bus_add_devices+0x10c/0x1a0
 [0000000000521548] pci_scan_bus_parented+0x148/0x180
 [00000000007304bc] sabre_scan_bus+0x5c/0x1e0
 [000000000072c690] pci_scan_each_controller_bus+0x30/0x80
 [000000000072c79c] pcibios_init+0x1c/0x80
 [00000000007286dc] do_initcalls+0x3c/0xe0
 [00000000004142c4] init+0x44/0x180
 [0000000000417330] kernel_thread+0x30/0x60
 [0000000000414190] rest_init+0x10/0x80
bad: scheduling while atomic!
Call Trace:
 [000000000045a88c] call_usermodehelper+0xac/0xc0
 [00000000005052bc] kset_hotplug+0x1bc/0x240
 [00000000005054fc] kobject_add+0x7c/0x100
 [000000000054acf0] device_add+0x50/0x120
 [00000000005201ec] pci_bus_add_devices+0x10c/0x1a0
 [00000000005201a4] pci_bus_add_devices+0xc4/0x1a0
 [0000000000521548] pci_scan_bus_parented+0x148/0x180
 [00000000007304bc] sabre_scan_bus+0x5c/0x1e0
 [000000000072c690] pci_scan_each_controller_bus+0x30/0x80
 [000000000072c79c] pcibios_init+0x1c/0x80
 [00000000007286dc] do_initcalls+0x3c/0xe0
 [00000000004142c4] init+0x44/0x180
 [0000000000417330] kernel_thread+0x30/0x60
 [0000000000414190] rest_init+0x10/0x80
bad: scheduling while atomic!
Call Trace:
 [000000000045a88c] call_usermodehelper+0xac/0xc0
 [00000000005052bc] kset_hotplug+0x1bc/0x240
 [00000000005054fc] kobject_add+0x7c/0x100
 [000000000054acf0] device_add+0x50/0x120
 [00000000005201ec] pci_bus_add_devices+0x10c/0x1a0
 [00000000005201a4] pci_bus_add_devices+0xc4/0x1a0
 [0000000000521548] pci_scan_bus_parented+0x148/0x180
 [00000000007304bc] sabre_scan_bus+0x5c/0x1e0
 [000000000072c690] pci_scan_each_controller_bus+0x30/0x80
 [000000000072c79c] pcibios_init+0x1c/0x80
 [00000000007286dc] do_initcalls+0x3c/0xe0
 [00000000004142c4] init+0x44/0x180
 [0000000000417330] kernel_thread+0x30/0x60
 [0000000000414190] rest_init+0x10/0x80
bad: scheduling while atomic!
Call Trace:
 [000000000045a88c] call_usermodehelper+0xac/0xc0
 [00000000005052bc] kset_hotplug+0x1bc/0x240
 [00000000005054fc] kobject_add+0x7c/0x100
 [000000000054acf0] device_add+0x50/0x120
 [00000000005201ec] pci_bus_add_devices+0x10c/0x1a0
 [00000000005201a4] pci_bus_add_devices+0xc4/0x1a0
 [0000000000521548] pci_scan_bus_parented+0x148/0x180
 [00000000007304bc] sabre_scan_bus+0x5c/0x1e0
 [000000000072c690] pci_scan_each_controller_bus+0x30/0x80
 [000000000072c79c] pcibios_init+0x1c/0x80
 [00000000007286dc] do_initcalls+0x3c/0xe0
 [00000000004142c4] init+0x44/0x180
 [0000000000417330] kernel_thread+0x30/0x60
 [0000000000414190] rest_init+0x10/0x80
bad: scheduling while atomic!
Call Trace:
 [000000000045a88c] call_usermodehelper+0xac/0xc0
 [00000000005052bc] kset_hotplug+0x1bc/0x240
 [00000000005054fc] kobject_add+0x7c/0x100
 [000000000054acf0] device_add+0x50/0x120
 [00000000005201ec] pci_bus_add_devices+0x10c/0x1a0
 [00000000005201a4] pci_bus_add_devices+0xc4/0x1a0
 [0000000000521548] pci_scan_bus_parented+0x148/0x180
 [00000000007304bc] sabre_scan_bus+0x5c/0x1e0
 [000000000072c690] pci_scan_each_controller_bus+0x30/0x80
 [000000000072c79c] pcibios_init+0x1c/0x80
 [00000000007286dc] do_initcalls+0x3c/0xe0
 [00000000004142c4] init+0x44/0x180
 [0000000000417330] kernel_thread+0x30/0x60
 [0000000000414190] rest_init+0x10/0x80
bad: scheduling while atomic!
Call Trace:
 [000000000045a88c] call_usermodehelper+0xac/0xc0
 [00000000005052bc] kset_hotplug+0x1bc/0x240
 [00000000005054fc] kobject_add+0x7c/0x100
 [000000000054acf0] device_add+0x50/0x120
 [00000000005201ec] pci_bus_add_devices+0x10c/0x1a0
 [00000000005201a4] pci_bus_add_devices+0xc4/0x1a0
 [0000000000521548] pci_scan_bus_parented+0x148/0x180
 [00000000007304bc] sabre_scan_bus+0x5c/0x1e0
 [000000000072c690] pci_scan_each_controller_bus+0x30/0x80
 [000000000072c79c] pcibios_init+0x1c/0x80
 [00000000007286dc] do_initcalls+0x3c/0xe0
 [00000000004142c4] init+0x44/0x180
 [0000000000417330] kernel_thread+0x30/0x60
 [0000000000414190] rest_init+0x10/0x80
bad: scheduling while atomic!
Call Trace:
 [000000000045a88c] call_usermodehelper+0xac/0xc0
 [00000000005052bc] kset_hotplug+0x1bc/0x240
 [00000000005054fc] kobject_add+0x7c/0x100
 [000000000054acf0] device_add+0x50/0x120
 [00000000005201ec] pci_bus_add_devices+0x10c/0x1a0
 [00000000005201a4] pci_bus_add_devices+0xc4/0x1a0
 [0000000000521548] pci_scan_bus_parented+0x148/0x180
 [00000000007304bc] sabre_scan_bus+0x5c/0x1e0
 [000000000072c690] pci_scan_each_controller_bus+0x30/0x80
 [000000000072c79c] pcibios_init+0x1c/0x80
 [00000000007286dc] do_initcalls+0x3c/0xe0
 [00000000004142c4] init+0x44/0x180
 [0000000000417330] kernel_thread+0x30/0x60
 [0000000000414190] rest_init+0x10/0x80
bad: scheduling while atomic!
Call Trace:
 [000000000045a88c] call_usermodehelper+0xac/0xc0
 [00000000005052bc] kset_hotplug+0x1bc/0x240
 [00000000005054fc] kobject_add+0x7c/0x100
 [000000000054acf0] device_add+0x50/0x120
 [00000000005201ec] pci_bus_add_devices+0x10c/0x1a0
 [00000000005201a4] pci_bus_add_devices+0xc4/0x1a0
 [0000000000521548] pci_scan_bus_parented+0x148/0x180
 [00000000007304bc] sabre_scan_bus+0x5c/0x1e0
 [000000000072c690] pci_scan_each_controller_bus+0x30/0x80
 [000000000072c79c] pcibios_init+0x1c/0x80
 [00000000007286dc] do_initcalls+0x3c/0xe0
 [00000000004142c4] init+0x44/0x180
 [0000000000417330] kernel_thread+0x30/0x60
 [0000000000414190] rest_init+0x10/0x80
PCI-IRQ: Routing bus[ 2] slot[ 1] map[0] to INO[10]
PCI-IRQ: Routing bus[ 2] slot[ 2] map[0] to INO[14]
PCI-IRQ: Routing bus[ 2] slot[ 3] map[0] to INO[18]
PCI0(PBMA): Bus running at 33MHz
PCI-IRQ: Routing bus[ 1] slot[ 1] map[0] to INO[21]
PCI-IRQ: Routing bus[ 1] slot[ 2] map[0] to INO[0f]
PCI-IRQ: Routing bus[ 1] slot[ 3] map[0] to INO[20]
PCI0(PBMB): Bus running at 33MHz
ebus0: [auxio] [power] [SUNW,pll] [se] [su] [su] [ecpp] [fdthree] [eeprom] [flashprom] [SUNW,CS4231]
power: Control reg at 000001fff1724000 ... powerd running.
Initializing Cryptographic API
rtc_init: no PC rtc found
su0 at 0x000001fff13062f8 (irq = 4,7ea) is a 16550A
su1 at 0x000001fff13083f8 (irq = 9,7e9) is a 16550A
ttyS0 at MMIO 0x1fff1400000 (irq = 7713632) is a SAB82532 V3.2
ttyS1 at MMIO 0x1fff1400040 (irq = 7713632) is a SAB82532 V3.2
Console: ttyS0 (SAB82532)
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
sunhme.c:v2.02 24/Aug/2003 David S. Miller (davem@redhat.com)
divert: allocating divert_blk for eth0
eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:f8:c7:72
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CMD646: IDE controller at PCI slot 0000:01:03.0
CMD646: chipset revision 3
CMD646: chipset revision 0x03, MultiWord DMA Force Limited
CMD646: 100% native mode on irq 4,7e0
    ide0: BM-DMA at 0x1fe02c00020-0x1fe02c00027, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1fe02c00028-0x1fe02c0002f, BIOS settings: hdc:pio, hdd:pio
hda: ST38410A, ATA DISK drive
ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 4,7e0
hdc: CRD-8322B, ATAPI CD/DVD-ROM drive
ide1 at 0x1fe02c00010-0x1fe02c00017,0x1fe02c0001a on irq 4,7e0 (shared with ide0)
hda: max request size: 128KiB
hda: 16841664 sectors (8622 MB) w/512KiB Cache, CHS708/16/63, (U)DMA
 hda: hda1 hda2 hda3
mice: PS/2 mouse device common for all mice
input: Sun Mouse on su/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 65536 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Adding 944984k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
md: md driver 0.90.0 MAX_MD_DEVS%6, MD_SB_DISKS'
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 80 td 96
ohci_hcd 0000:02:02.0: OPTi Inc. 82C861
ohci_hcd 0000:02:02.0: irq 10,7d4, pci mem 000001ff02040000
ohci_hcd 0000:02:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:02:02.0: WARNING: OPTi workarounds unavailable
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
SCSI subsystem initialized
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
NET: Registered protocol family 15
NET: Registered protocol family 10
Disabled Privacy Extensions on device 00000000006a1540(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
eth0: no IPv6 routers present
nfs warning: mount version older than kernel

-- 
Meelis Roos (mroos@linux.ee)

