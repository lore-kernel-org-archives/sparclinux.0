From: Emanuele Rocca <ema@debian.org>
Date: Mon, 16 Apr 2007 09:22:08 +0000
Subject: Re:   [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <20070416092208.GA26024@darkmoon.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
To: sparclinux@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Emanuele Rocca <ema@debian.org>, [2007-04-15 14:06 +0200]:
>  * David Miller <davem@davemloft.net>, [2007-04-12 14:11 -0700]:
>  >  Please add this debugging patch and boot, let me know what ends up
>  >  in your kernel log.
>  
>  I've applied the patch to 2.6.21-rc6 and booted with atyfb enabled, but
>  unfortunately there seems to be a regression in qla2xxx, see the
>  attached file (dmesg output).

OK, here's the relevant dmesg output after reverting the recent qla2xxx
modifications:

atyfb_init: Invoked
atyfb_init: Registering PCI device
atyfb_pci_probe: Invoked
atyfb: 3D RAGE XL (Mach64 GR, PCI-33) [0x4752 rev 0x27]
atyfb: 8M SGRAM (1:1), 29.498928 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 63 MHz XCLK
Console: switching to colour frame buffer device 80x30
atyfb: fb0: ATY Mach64 frame buffer device on PCI
atyfb_pci_probe: success
/upa@8,480000/SUNW,afb@1,0: AFB at 000007fa00000000, type 35, DAC pnum[36e] rev[0] manuf_rev[1]
ioctl32(Xorg:4213): Unknown cmd fd(6) cmd(40584606){00} arg(ff859a4c) on /dev/fb0
ioctl32(Xorg:4213): Unknown cmd fd(6) cmd(40184600){00} arg(ff859a54) on /dev/fb0

Full log attached.

ciao,
    ema

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=atyfb-printk-dmesg

PROMLIB: Sun IEEE Boot Prom 'OBP 4.5.16 2002/05/01 19:28'
PROMLIB: Root node compatible: 
Linux version 2.6.21-rc6 (ema@aurora) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #2 Sun Apr 15 12:23:37 CEST 2007
ARCH: SUN4U
Ethernet address: 00:03:ba:17:f3:30
PROM: Built device tree with 68830 bytes of memory.
On node 0 totalpages: 129710
  Normal zone: 895 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 128815 pages, LIFO batch:15
CPU[0]: Caches D[sz(65536):line_sz(32)] I[sz(32768):line_sz(32)] E[sz(8388608):line_sz(512)]
Built 1 zonelists.  Total pages: 128815
Kernel command line: root=/dev/sda2 ro
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
Freeing initrd memory: 4950k freed
/memory-controller@0,400000: US3 memory controller at 0000040000400000 [ACTIVE]
audit: initializing netlink socket (disabled)
audit(1176714549.386:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
atyfb_init: Invoked
atyfb_init: Registering PCI device
atyfb_pci_probe: Invoked
atyfb: 3D RAGE XL (Mach64 GR, PCI-33) [0x4752 rev 0x27]
atyfb: 8M SGRAM (1:1), 29.498928 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 63 MHz XCLK
Console: switching to colour frame buffer device 80x30
atyfb: fb0: ATY Mach64 frame buffer device on PCI
atyfb_pci_probe: success
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
qla2xxx 0000:00:04.0: Inconsistent NVRAM detected: checksum=0x0 id=<4>qla2xxx 0000:00:04.0: Falling back to functioning (yet invalid -- WWPN) defaults.
qla2xxx 0000:00:04.0: Verifying loaded RISC code...
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
PHY ID: 18074c1, addr: 0
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:ba:17:f3:30 
eth0: Found Generic MII PHY
ieee1394: Initialized config rom entry `ip1394'
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[14]  MMIO=[7fe00120000-7fe001207ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
sym0: <875> rev 0x37 at pci 0001:00:06.0 irq 16
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi1 : sym-2.2.3
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
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
qla2xxx 0000:00:04.0: Allocated (252 KB) for firmware dump...
qla2xxx 0000:00:04.0: LIP reset occured (f8e8).
scsi0 : qla2xxx
qla2xxx 0000:00:04.0: LIP occured (f8e8).
qla2xxx 0000:00:04.0: LOOP UP detected (1 Gbps).
qla2xxx 0000:00:04.0: 
 QLogic Fibre Channel HBA Driver: 8.01.07-k5
  QLogic QLA22xx - 
  ISP2200: PCI (66 MHz) @ 0000:00:04.0 hdma-, host#=0, fw=2.02.08 TP
scsi 0:0:0:0: Direct-Access     SEAGATE  ST373405FSUN72G  0638 PQ: 0 ANSI: 3
SCSI device sda: 143374738 512-byte hdwr sectors (73408 MB)
sda: Write Protect is off
sda: Mode Sense: db 00 10 08
SCSI device sda: write cache: disabled, read cache: enabled, supports DPO and FUA
SCSI device sda: 143374738 512-byte hdwr sectors (73408 MB)
sda: Write Protect is off
sda: Mode Sense: db 00 10 08
SCSI device sda: write cache: disabled, read cache: enabled, supports DPO and FUA
 sda: sda1 sda2 sda3 sda4 sda5 sda8
sd 0:0:0:0: Attached scsi disk sda
ohci_hcd 0001:00:05.3: OHCI Host Controller
ohci_hcd 0001:00:05.3: new USB bus registered, assigned bus number 1
ohci_hcd 0001:00:05.3: irq 15, io mem 0x7fe01000000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:6:0: Attached scsi CD-ROM sr0
sr 1:0:6:0: Attached scsi generic sg0 type 5
sd 0:0:0:0: Attached scsi generic sg1 type 0
usb 1-1: new low speed USB device using ohci_hcd and address 2
usb 1-1: configuration #1 chosen from 1 choice
input: HID 0430:0100 as /class/input/input0
input: USB HID v1.10 Mouse [HID 0430:0100] on usb-0001:00:05.3-1
usb 1-2: new low speed USB device using ohci_hcd and address 3
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
usb 1-2: configuration #1 chosen from 1 choice
input: HID 0430:0005 as /class/input/input1
input: USB HID v1.00 Keyboard [HID 0430:0005] on usb-0001:00:05.3-2
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Adding 498608k swap on /dev/sda1.  Priority:-1 extents:1 across:498608k
EXT3 FS on sda2, internal journal
i2c-0: Regs at 000007fe7e00002e, 6 devices, own a0, clock 10.
i2c-1: Regs at 000007fe7e000030, 6 devices, own a0, clock 10.
bbc_envctrl: kenvctrld starting...
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
eth0: Link is up at 100 Mbps, full-duplex.
eth0: Pause is disabled
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
eth0: no IPv6 routers present
ioctl32(Xorg:4213): Unknown cmd fd(6) cmd(40584606){00} arg(ff859a4c) on /dev/fb0
ioctl32(Xorg:4213): Unknown cmd fd(6) cmd(40184600){00} arg(ff859a54) on /dev/fb0

--u3/rZRmxL6MmkK24--
