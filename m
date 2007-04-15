From: Emanuele Rocca <ema@debian.org>
Date: Sun, 15 Apr 2007 12:06:12 +0000
Subject: Re:  [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <20070415120612.GA27755@darkmoon.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
To: sparclinux@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello David,

* David Miller <davem@davemloft.net>, [2007-04-12 14:11 -0700]:
>  Please add this debugging patch and boot, let me know what ends up
>  in your kernel log.

I've applied the patch to 2.6.21-rc6 and booted with atyfb enabled, but
unfortunately there seems to be a regression in qla2xxx, see the
attached file (dmesg output).

The last kernel I've tried that wasn't affected by the qla2xxx problem
was 2.6.20.1. On the other hand, I've not been able to boot it correctly
with atyfb enabled. 

I've noticed there's been some work on atyfb recently, so maybe I could
try backporting the changes to 2.6.20 and see what happens. 
I'm open to suggestions. :)

Thanks.
ciao,
    ema

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.21-rc6-regression-dmesg"

MLIB: Root node compatible: 
Linux version 2.6.21-rc6 (ema@aurora) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #2 Sun Apr 15 12:23:37 CEST 2007
ARCH: SUN4U
Ethernet address: 00:03:ba:17:f3:30
PROM: Built device tree with 68830 bytes of memory.
On node 0 totalpages: 129709
  Normal zone: 895 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 128814 pages, LIFO batch:15
CPU[0]: Caches D[sz(65536):line_sz(32)] I[sz(32768):line_sz(32)] E[sz(8388608):line_sz(512)]
Built 1 zonelists.  Total pages: 128814
Kernel command line: root=/dev/sda2 ro video=atyfb:off
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
Memory: 1028120k available (2296k kernel code, 824k data, 144k init) [fffff80000000000,000000003fede000]
Calibrating delay using timer specific routine.. 10.00 BogoMIPS (lpj=5000)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing for controllers.
/pci@8,700000: SCHIZO PCI Bus Module ver[5:0]
/pci@8,700000: PCI CFG[7ffee000000] IO[7ffef000000] MEM[7fe00000000]
/pci@8,600000: SCHIZO PCI Bus Module ver[5:0]
/pci@8,600000: PCI CFG[7ffec000000] IO[7ffed000000] MEM[7fd00000000]
PCI0(PBMB): Bus running at 33MHz
PCI0(PBMA): Bus running at 66MHz
ebus0: [flashprom] [bbc] [ppm] [i2c -> (dimm-fru) (dimm-fru) (dimm-fru) (dimm-fru) (nvram) (idprom)] [i2c -> (cpu-fru) (temperature) (fan-control) (card-reader) (motherboard-fru) (i2c-bridge)] [beep] [audio] [rtc] [gpio] [pmc] [floppy] [parallel] [serial]
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
/pci@8,700000/ebus@5/rtc@1,300070: Clock regs at 000007fe7e300070
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 65536 bytes)
TCP established hash table entries: 32768 (order: 6, 524288 bytes)
TCP bind hash table entries: 32768 (order: 5, 262144 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 4952k freed
/memory-controller@0,400000: US3 memory controller at 0000040000400000 [ACTIVE]
audit: initializing netlink socket (disabled)
audit(1176636994.381:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
atyfb_init: Invoked
Console: switching to colour frame buffer device 144x56
/upa@8,480000/SUNW,afb@1,0: AFB at 000007fa00000000, type 35, DAC pnum[36e] rev[0] manuf_rev[1]
Real Time Clock Driver v1.12ac
[drm] Initialized drm 1.1.0 20060810
f0086c34: ttyS0 at MMIO 0x7fe7e400000 (irq = 12) is a SAB82532 V3.2
f0086c34: ttyS1 at MMIO 0x7fe7e400040 (irq = 12) is a SAB82532 V3.2
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
SCSI subsystem initialized
QLogic Fibre Channel HBA Driver
qla2xxx 0000:00:04.0: Found an ISP2200, irq 21, iobase 0x000007fd00100000
qla2xxx 0000:00:04.0: Configuring PCI space...
qla2xxx 0000:00:04.0: Configure NVRAM parameters...
qla2xxx 0000:00:04.0: Inconsistent NVRAM detected: checksum=0x0 id=<6>scsi0 : qla2xxx
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
PHY ID: 18074c1, addr: 0
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:ba:17:f3:30 
eth0: Found Generic MII PHY
ieee1394: Initialized config rom entry `ip1394'
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000388
tsk->{mm,active_mm}->pgd = fffff8003fbe0000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
modprobe(1546): Oops [#1]
TSTATE: 0000000011009604 TPC: 0000000010058cb0 TNPC: 0000000010058cb4 Y: 00000000    Not tainted
TPC: <qla2x00_init_host_attr+0x1c/0xf4 [qla2xxx]>
g0: fffffffffffffff8 g1: 0000000000000000 g2: fffff8003efec000 g3: fffff8003e247228
g4: fffff8003fe60d60 g5: 006e616c69000000 g6: fffff8003e0a8000 g7: 0000000000000001
o0: fffff8003efec4a8 o1: fffff8003efec160 o2: fffff8003f810000 o3: 00000000fffb7739
o4: fffff8003efec000 o5: 0000000000000000 sp: fffff8003e0aaed1 ret_pc: 000000001004150c
RPC: <qla2x00_probe_one+0x117c/0x1268 [qla2xxx]>
l0: 0000000000002300 l1: fffff8003efee7a8 l2: 0000000000742000 l3: fffff8003efec000
l4: fffff8003efec4a8 l5: 0000000000000000 l6: 00000000007421e8 l7: 0000000000000009
i0: 0000000000000000 i1: 0000000010067850 i2: 0000000000695d38 i3: 000000000064bb28
i4: 0000000000000000 i5: fffff800008b4800 i6: fffff8003e0ab011 i7: 0000000000529d68
I7: <pci_device_probe+0x5c/0x8c>
Caller[0000000000529d68]: pci_device_probe+0x5c/0x8c
Caller[0000000000585358]: really_probe+0xc8/0x170
Caller[0000000000585500]: __driver_attach+0x44/0x68
Caller[0000000000584950]: bus_for_each_dev+0x38/0x6c
Caller[0000000000584c8c]: bus_add_driver+0x60/0x19c
Caller[0000000000529f14]: __pci_register_driver+0x88/0xcc
Caller[000000001006c0c8]: qla2x00_module_init+0xd0/0xf8 [qla2xxx]
Caller[000000000046429c]: sys_init_module+0x1310/0x143c
Caller[0000000000406994]: linux_sparc_syscall32+0x3c/0x40
Caller[00000000000133b4]: 0x133bc
Instruction DUMP: 83287008  c25a0001  d458a4a0 <ce086001> c4084000  c6086003  8f29f030  da086002  8528b038 
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[14]  MMIO=[7fe00120000-7fe001207ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
ohci_hcd 0001:00:05.3: OHCI Host Controller
ohci_hcd 0001:00:05.3: new USB bus registered, assigned bus number 1
ohci_hcd 0001:00:05.3: irq 15, io mem 0x7fe01000000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
sym0: <875> rev 0x37 at pci 0001:00:06.0 irq 16
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi1 : sym-2.2.3
usb 1-1: new low speed USB device using ohci_hcd and address 2
usb 1-1: configuration #1 chosen from 1 choice
input: HID 0430:0100 as /class/input/input0
input: USB HID v1.10 Mouse [HID 0430:0100] on usb-0001:00:05.3-1
usb 1-2: new low speed USB device using ohci_hcd and address 3
usb 1-2: configuration #1 chosen from 1 choice
input: HID 0430:0005 as /class/input/input1
input: USB HID v1.00 Keyboard [HID 0430:0005] on usb-0001:00:05.3-2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0003bafffe17f330]
eth0: Link is up at 100 Mbps, full-duplex.
scsi 1:0:6:0: CD-ROM            TOSHIBA  DVD-ROM SD-M1401 1009 PQ: 0 ANSI: 2
 target1:0:6: Beginning Domain Validation
 target1:0:6: asynchronous
 target1:0:6: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
 target1:0:6: Domain Validation skipping write tests
 target1:0:6: Ending Domain Validation
sym1: <875> rev 0x37 at pci 0001:00:06.1 irq 17
sym1: No NVRAM, ID 7, Fast-20, SE, parity checking
sym1: SCSI BUS has been reset.
scsi2 : sym-2.2.3
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:6:0: Attached scsi CD-ROM sr0
sr 1:0:6:0: Attached scsi generic sg0 type 5
eth0: Link is up at 100 Mbps, full-duplex.
eth0: Pause is disabled

--45Z9DzgjV8m4Oswq--
