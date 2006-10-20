From: Jim Watson <jim@amarooas.com.au>
Date: Fri, 20 Oct 2006 01:34:32 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <45CAEF55-6FE5-41AD-95E3-376DD2A4AE32@amarooas.com.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Apple-Mail-4-464762259"
List-Id: <sparclinux.vger.kernel.org>
References: <200401070729.56891.pkarlsen@mandriva.com>
In-Reply-To: <200401070729.56891.pkarlsen@mandriva.com>
To: sparclinux@vger.kernel.org


--Apple-Mail-4-464762259
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed


On 20/10/2006, at 10:36 AM, Riccardo Tortorici wrote:

>
> Turning off FB works for me also, but only extend the agony.. :)
> this time freezes on:
>
> hda: cache flushes not supported
> hda: hda1 hda2 hda3 hda4
> hdc: max request size: 128KiB

I see different with Juri's kernel, packaged 2.6.18-2 with atyfb:off

hda: cache flushes not supported
hda: hda1 hda2 hda3 hda4 hda5
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.

Full dmesg is attached...

jim

--Apple-Mail-4-464762259
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	x-unix-mode=0644;
	name=dmesg.txt
Content-Disposition: attachment;
	filename=dmesg.txt

PROMLIB: Sun IEEE Boot Prom 'OBP 4.0.45 2001/02/08 14:33'
PROMLIB: Root node compatible: 
Linux version 2.6.18-1-sparc64 (Debian 2.6.18-2) (waldi@debian.org) (gcc version 4.1.2 20061007 (prerelease) (Debian 4.1.1-16)) #1 Wed Oct 18 23:44:13 PDT 2006
ARCH: SUN4U
Ethernet address: 00:03:ba:04:a4:ab
PROM: Built device tree with 53980 bytes of memory.
On node 0 totalpages: 31947
  DMA zone: 31947 pages, LIFO batch:7
CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(262144):line_sz(64)]
Built 1 zonelists.  Total pages: 31947
Kernel command line: root=/dev/hda2 ro video=atyfb:off
PID hash table entries: 1024 (order: 10, 8192 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 4, 131072 bytes)
Memory: 252960k available (2200k kernel code, 784k data, 136k init) [fffff80000000000,000000000ff24000]
Calibrating delay using timer specific routine.. 11.12 BogoMIPS (lpj=22244)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
checking if image is initramfs... it is
Freeing initrd memory: 1026k freed
NET: Registered protocol family 16
PCI: Probing for controllers.
/pci@1f,0: SABRE PCI Bus Module
PCI quirk: region 0800-083f claimed by ali7101 ACPI
PCI quirk: region 0600-061f claimed by ali7101 SMB
PCI0(PBMA): Bus running at 33MHz
isa0: [dma -> (floppy) (parallel)] [power] [serial] [serial]
ebus0: [flashprom] [eeprom] [idprom]
power: Control reg at 1fe02000800 ... powerd running.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
/pci@1f,0/ebus@c/eeprom@1,0: Clock regs at 000001fff1000000
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 16384 bytes)
TCP established hash table entries: 8192 (order: 3, 65536 bytes)
TCP bind hash table entries: 4096 (order: 2, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1161336996.228:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Activating ISA DMA hang workarounds.
Console: switching to mono PROM 80x34
rtc_init: no PC rtc found
[drm] Initialized drm 1.0.1 20051102
serial@0,3f8: ttyS0 at MMIO 0x1fe020003f8 (irq = 9) is a 16550A
serial@0,2e8: ttyS1 at MMIO 0x1fe020002e8 (irq = 9) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
rtc_sun_init: Registered Mostek RTC driver.
usbmon: debugfs is not available
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd 0000:00:0c.3: OHCI Host Controller
ohci_hcd 0000:00:0c.3: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0c.3: irq 12, io mem 0x1ff02000000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ALI15X3: IDE controller at PCI slot 0000:00:0d.0
ALI15X3: chipset revision 195
ALI15X3: 100% native mode on irq 15
    ide0: BM-DMA at 0x1fe02000a20-0x1fe02000a27, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1fe02000a28-0x1fe02000a2f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
usb 1-1: new low speed USB device using ohci_hcd and address 2
hda: ST315320A, ATA DISK drive
usb 1-1: configuration #1 chosen from 1 choice
input: Logitech USB Receiver as /class/input/input0
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:0c.3-1
usb 1-4: new low speed USB device using ohci_hcd and address 3
hdb: LTN485S, ATAPI CD/DVD-ROM drive
ide0 at 0x1fe02000a00-0x1fe02000a07,0x1fe02000a1a on irq 15
Probing IDE interface ide1...
usb 1-4: configuration #1 chosen from 1 choice
input: HID 0430:0005 as /class/input/input1
input: USB HID v1.00 Keyboard [HID 0430:0005] on usb-0000:00:0c.3-4
hda: max request size: 128KiB
hda: 29888820 sectors (15303 MB) w/2048KiB Cache, CHS=29651/16/63, UDMA(66)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4 hda5
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
PHY ID: 437421, addr: 1
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:ba:04:a4:ab 
eth0: Found Generic MII PHY
ieee1394: Initialized config rom entry `ip1394'
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[1ff00420000-1ff004207ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
hdb: ATAPI 48X CD-ROM drive, 120kB Cache
Uniform CD-ROM driver Revision: 3.20
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0003bafffe04a4ab]
eth0: Link is up at 10 Mbps, half-duplex.
Kernel unaligned access at TPC[101780bc] ether1394_reset_priv+0x20/0xac [eth1394]
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ali_stimer_read: stimer is not ready.
Adding 511544k swap on /dev/hda4.  Priority:-1 extents:1 across:511544k
EXT3 FS on hda2, internal journal
Probing IDE interface ide1...
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: Link is up at 10 Mbps, half-duplex.
eth0: Pause is disabled
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present

--Apple-Mail-4-464762259--
