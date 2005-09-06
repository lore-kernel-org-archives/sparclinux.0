From: Christopher Zimmermann <madroach@zakweb.de>
Date: Tue, 06 Sep 2005 11:46:17 +0000
Subject: Sparc CS4231 sound driver
Message-Id: <20050906114617.GA575@sparc>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
List-Id: <sparclinux.vger.kernel.org>
References: <20050905202913.GA769@sparc>
In-Reply-To: <20050905202913.GA769@sparc>
To: sparclinux@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, 

The CS4231 alsa sound driver in the 2.6 kernel doesn't work on my
Ultra2, although the driver in the 2.4 kernel worked. Maybe you can give
me some hints to debug the driver.
Audio files play way too fast and I won't hear any sound. It's like
playing to /dev/null.
When loading the driver module I hear a "plop" sound.
Increasing the udelay in line 444 will remove some of the "auto
calibration timeout messages.".
The output of the driver with all the debug ifdefs enabled is attached.

Christopher

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="debug.txt"

PROMLIB: Sun IEEE Boot Prom 3.25.0 1999/12/03 11:35
Linux version 2.6.12.5 (madroach@sparc) (gcc version 4.0.1 (Debian 4.0.1-2)) #2 SMP Sat Sep 3 22:31:12 CEST 2005
ARCH: SUN4U
Ethernet address: 08:00:20:86:08:46
On node 0 totalpages: 130567
  DMA zone: 130567 pages, LIFO batch:15
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: root=/dev/sda2 fbcon=font:SUN12x22
PID hash table entries: 4096 (order: 12, 131072 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
Memory: 1034960k available (2096k kernel code, 632k data, 152k init) [fffff80000000000,000000003ff44000]
Calibrating delay loop... 587.77 BogoMIPS (lpj=293888)
Mount-cache hash table entries: 512
Calibrating delay loop... 587.77 BogoMIPS (lpj=293888)
CPU 1: synchronized TICK with master CPU (last diff -7 cycles,maxerr 536 cycles)
Brought up 2 CPUs
Total of 2 processors activated (1175.55 BogoMIPS).
CPU0 attaching sched-domain:
 domain 0: span 3
  groups: 1 2
CPU1 attaching sched-domain:
 domain 0: span 3
  groups: 2 1
NET: Registered protocol family 16
SCSI subsystem initialized
SYSIO: UPA portID 1f, at 000001fe00000000
sbus0: Clock 25.0 MHz
dma0: HME DVMA gate array 
Console: switching to colour frame buffer device 106x46
ffb: FFB at 000001fc00000000 type 8 DAC 10
lp: driver loaded but no devices found
SunZilog: 2 chips.
zs2 at 0x000001fff1000004 (irq = 12,7e8) is a SunZilog
zs3 at 0x000001fff1000000 (irq = 12,7e8) is a SunZilog
ttyS0 at MMIO 0x0 (irq = 7271104) is a SunZilog
ttyS1 at MMIO 0x0 (irq = 7271104) is a SunZilog
parport0: sunbpp at 0x1ffec800000
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
sunhme.c:v2.02 8/24/03 David S. Miller (davem@redhat.com)
eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:86:08:46 
eth1: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:86:08:46 
esp0: IRQ 4,7e0 SCSI ID 7 Clk 40MHz CCYC=25000 CCF=8 TOut 167 NCR53C9XF(espfast)
ESP: Total of 1 ESP hosts found, 1 actually in use.
scsi0 : Sparc ESP366-HME
  Vendor: FUJITSU   Model: MAJ3182M SUN18G   Rev: 0804
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: FUJITSU   Model: MAJ3182M SUN18G   Rev: 0804
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: XM-5401TASUN4XCD  Rev: 1036
  Type:   CD-ROM                             ANSI SCSI revision: 02
esp0: target 0 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sda: 35378533 512-byte hdwr sectors (18114 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 35378533 512-byte hdwr sectors (18114 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 sda5
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
esp0: target 1 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sdb: 35378533 512-byte hdwr sectors (18114 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 35378533 512-byte hdwr sectors (18114 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb2 sdb3 sdb4 sdb5
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
esp0: target 6 asynchronous
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg2 at scsi0, channel 0, id 6, lun 0,  type 5
OBP Flash: RD 1fff0000000[80000] WR 1fff1380000[80000]
rtc_sun_init: Registered Mostek RTC driver.
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP established hash table entries: 65536 (order: 7, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
input: Sun Type 5 keyboard on zs/serio0
input: Sun Mouse on zs/serio1
Adding 1999856k swap on /dev/sda5.  Priority:-1 extents:1
EXT3 FS on sda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth1: Auto-Negotiation unsuccessful, trying force link mode
eth1: Link has been forced up using internal transceiver at 10Mb/s, Half Duplex.
sermouse.c: Switched to the 5-byte MSC mouse protocol.
snd_sun_cs4231: no version for "struct_module" found: kernel tainted.
ALSA sound/sparc/cs4231.c:483: CS4231 REGS:      INDEX = 0x40  ALSA sound/sparc/cs4231.c:485:                  STATUS = 0xcc
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x0 = 0x0
ALSA sound/sparc/cs4231.c:486:   0x00: left input      = 0x00  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x10 = 0x0
ALSA sound/sparc/cs4231.c:487:   0x10: alt 1 (CFIG 2)  = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1 = 0x0
ALSA sound/sparc/cs4231.c:488:   0x01: right input     = 0x00  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x11 = 0x0
ALSA sound/sparc/cs4231.c:489:   0x11: alt 2 (CFIG 3)  = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x2 = 0x88
ALSA sound/sparc/cs4231.c:490:   0x02: GF1 left input  = 0x88  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x12 = 0x88
ALSA sound/sparc/cs4231.c:491:   0x12: left line in    = 0x88
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x3 = 0x88
ALSA sound/sparc/cs4231.c:492:   0x03: GF1 right input = 0x88  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x13 = 0x88
ALSA sound/sparc/cs4231.c:493:   0x13: right line in   = 0x88
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x4 = 0x88
ALSA sound/sparc/cs4231.c:494:   0x04: CD left input   = 0x88  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x14 = 0x88
ALSA sound/sparc/cs4231.c:495:   0x14: timer low       = 0x88
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x5 = 0x88
ALSA sound/sparc/cs4231.c:496:   0x05: CD right input  = 0x88  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x15 = 0x88
ALSA sound/sparc/cs4231.c:497:   0x15: timer high      = 0x88
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x6 = 0x80
ALSA sound/sparc/cs4231.c:498:   0x06: left output     = 0x80  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x16 = 0x80
ALSA sound/sparc/cs4231.c:499:   0x16: left MIC (PnP)  = 0x80
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x7 = 0x80
ALSA sound/sparc/cs4231.c:500:   0x07: right output    = 0x80  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x17 = 0x80
ALSA sound/sparc/cs4231.c:501:   0x17: right MIC (PnP) = 0x80
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x8 = 0x0
ALSA sound/sparc/cs4231.c:502:   0x08: playback format = 0x00  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x18 = 0x0
ALSA sound/sparc/cs4231.c:503:   0x18: IRQ status      = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x9 = 0x8
ALSA sound/sparc/cs4231.c:504:   0x09: iface (CFIG 1)  = 0x08  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x19 = 0x8
ALSA sound/sparc/cs4231.c:505:   0x19: left line out   = 0x08
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xa = 0x0
ALSA sound/sparc/cs4231.c:506:   0x0a: pin control     = 0x00  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1a = 0x0
ALSA sound/sparc/cs4231.c:507:   0x1a: mono control    = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x0
ALSA sound/sparc/cs4231.c:508:   0x0b: init & status   = 0x00  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1b = 0x0
ALSA sound/sparc/cs4231.c:509:   0x1b: right line out  = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xc = 0x8a
ALSA sound/sparc/cs4231.c:510:   0x0c: revision & mode = 0x8a  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1c = 0x8a
ALSA sound/sparc/cs4231.c:511:   0x1c: record format   = 0x8a
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xd = 0x0
ALSA sound/sparc/cs4231.c:512:   0x0d: loopback        = 0x00  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1d = 0x0
ALSA sound/sparc/cs4231.c:513:   0x1d: var freq (PnP)  = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xe = 0x0
ALSA sound/sparc/cs4231.c:514:   0x0e: ply upr count   = 0x00  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1e = 0x0
ALSA sound/sparc/cs4231.c:515:   0x1e: rec upr count   = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xf = 0x0
ALSA sound/sparc/cs4231.c:516:   0x0f: ply lwr count   = 0x00  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1f = 0x0
ALSA sound/sparc/cs4231.c:517:   0x1f: rec lwr count   = 0x00
ALSA sound/sparc/cs4231.c:452: codec out - reg 0xc = 0x40
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xc = 0xca
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x19 = 0xa0
ALSA sound/sparc/cs4231.c:1351: cs4231: port = 000001ffdc000000, id = 0xa
ALSA sound/sparc/cs4231.c:569: (1) timeout = 33564672
ALSA sound/sparc/cs4231.c:573: mce_down [000001ffdc000000] - auto calibration time out (0)
ALSA sound/sparc/cs4231.c:579: mce_down [000001ffdc000000]: serious init problem - codec still busy
ALSA sound/sparc/cs4231.c:445: out: auto calibration time out - reg = 0x0, value = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x0 = 0x0
ALSA sound/sparc/cs4231.c:445: out: auto calibration time out - reg = 0x1, value = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x1 = 0x0
ALSA sound/sparc/cs4231.c:445: out: auto calibration time out - reg = 0x2, value = 0x9f
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x2 = 0x9f
ALSA sound/sparc/cs4231.c:445: out: auto calibration time out - reg = 0x3, value = 0x9f
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x3 = 0x9f
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x4 = 0x9f
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x5 = 0x9f
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x6 = 0xbf
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x7 = 0xbf
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x8 = 0x20
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x9 = 0x8
ALSA sound/sparc/cs4231.c:452: codec out - reg 0xa = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0xb = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0xc = 0x40
ALSA sound/sparc/cs4231.c:452: codec out - reg 0xd = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0xe = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0xf = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x10 = 0x80
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x11 = 0x3
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x12 = 0x9f
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x13 = 0x9f
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x14 = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x15 = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x16 = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x17 = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x18 = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x19 = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x1a = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x1b = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x1c = 0x20
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x1d = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x1e = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x1f = 0x0
ALSA sound/sparc/cs4231.c:569: (1) timeout = 33564672
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:596: (2) timeout = 500, jiffies = 4294785001
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x0
ALSA sound/sparc/cs4231.c:610: (3) jiffies = 4294785031
ALSA sound/sparc/cs4231.c:625: (4) jiffies = 4294785038
ALSA sound/sparc/cs4231.c:626: mce_down - exit = 0xb
ALSA sound/sparc/cs4231.c:569: (1) timeout = 33564672
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x49 = 0x8
ALSA sound/sparc/cs4231.c:569: (1) timeout = 33564672
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:596: (2) timeout = 500, jiffies = 4294785053
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x0
ALSA sound/sparc/cs4231.c:610: (3) jiffies = 4294785079
ALSA sound/sparc/cs4231.c:625: (4) jiffies = 4294785084
ALSA sound/sparc/cs4231.c:626: mce_down - exit = 0xb
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x50 = 0x80
ALSA sound/sparc/cs4231.c:569: (1) timeout = 33564672
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:596: (2) timeout = 500, jiffies = 4294785092
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x0
ALSA sound/sparc/cs4231.c:610: (3) jiffies = 4294785119
ALSA sound/sparc/cs4231.c:625: (4) jiffies = 4294785125
ALSA sound/sparc/cs4231.c:626: mce_down - exit = 0xb
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x11 = 0x3
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x48 = 0x20
ALSA sound/sparc/cs4231.c:569: (1) timeout = 33564672
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:596: (2) timeout = 500, jiffies = 4294785139
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x0
ALSA sound/sparc/cs4231.c:610: (3) jiffies = 4294785169
ALSA sound/sparc/cs4231.c:625: (4) jiffies = 4294785177
ALSA sound/sparc/cs4231.c:626: mce_down - exit = 0xb
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x5c = 0x20
ALSA sound/sparc/cs4231.c:569: (1) timeout = 33564672
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:596: (2) timeout = 500, jiffies = 4294785189
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x0
ALSA sound/sparc/cs4231.c:610: (3) jiffies = 4294785223
ALSA sound/sparc/cs4231.c:625: (4) jiffies = 4294785232
ALSA sound/sparc/cs4231.c:626: mce_down - exit = 0xb



echo Hello >/dev/dsp


ALSA sound/sparc/cs4231.c:452: codec out - reg 0x18 = 0x70
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x18 = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x18 = 0x70
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x18 = 0x0
ALSA sound/sparc/cs4231.c:796: get_format: 0x1 (mode=0x1)
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x48 = 0x0
ALSA sound/sparc/cs4231.c:569: (1) timeout = 33564672
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:596: (2) timeout = 500, jiffies = 4294891267
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x20
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x0
ALSA sound/sparc/cs4231.c:610: (3) jiffies = 4294891295
ALSA sound/sparc/cs4231.c:625: (4) jiffies = 4294891300
ALSA sound/sparc/cs4231.c:626: mce_down - exit = 0xb
ALSA sound/sparc/cs4231.c:732: TRIGGER: what[1] on(1)
ALSA sound/sparc/cs4231.c:452: codec out - reg 0xf = 0xff
ALSA sound/sparc/cs4231.c:452: codec out - reg 0xe = 0xff
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x9 = 0x9
ALSA sound/sparc/cs4231.c:483: CS4231 REGS:      INDEX = 0x09  ALSA sound/sparc/cs4231.c:485:                  STATUS = 0xce
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x0 = 0x0
ALSA sound/sparc/cs4231.c:486:   0x00: left input      = 0x00  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x10 = 0x80
ALSA sound/sparc/cs4231.c:487:   0x10: alt 1 (CFIG 2)  = 0x80
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1 = 0x0
ALSA sound/sparc/cs4231.c:488:   0x01: right input     = 0x00  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x11 = 0x3
ALSA sound/sparc/cs4231.c:489:   0x11: alt 2 (CFIG 3)  = 0x03
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x2 = 0x9f
ALSA sound/sparc/cs4231.c:490:   0x02: GF1 left input  = 0x9f  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x12 = 0x9f
ALSA sound/sparc/cs4231.c:491:   0x12: left line in    = 0x9f
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x3 = 0x9f
ALSA sound/sparc/cs4231.c:492:   0x03: GF1 right input = 0x9f  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x13 = 0x9f
ALSA sound/sparc/cs4231.c:493:   0x13: right line in   = 0x9f
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x4 = 0x9f
ALSA sound/sparc/cs4231.c:494:   0x04: CD left input   = 0x9f  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x14 = 0x0
ALSA sound/sparc/cs4231.c:495:   0x14: timer low       = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x5 = 0x9f
ALSA sound/sparc/cs4231.c:496:   0x05: CD right input  = 0x9f  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x15 = 0x0
ALSA sound/sparc/cs4231.c:497:   0x15: timer high      = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x6 = 0xbf
ALSA sound/sparc/cs4231.c:498:   0x06: left output     = 0xbf  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x16 = 0x0
ALSA sound/sparc/cs4231.c:499:   0x16: left MIC (PnP)  = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x7 = 0xbf
ALSA sound/sparc/cs4231.c:500:   0x07: right output    = 0xbf  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x17 = 0x0
ALSA sound/sparc/cs4231.c:501:   0x17: right MIC (PnP) = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x8 = 0x0
ALSA sound/sparc/cs4231.c:502:   0x08: playback format = 0x00  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x18 = 0x1
ALSA sound/sparc/cs4231.c:503:   0x18: IRQ status      = 0x01
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x9 = 0x9
ALSA sound/sparc/cs4231.c:504:   0x09: iface (CFIG 1)  = 0x09  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x19 = 0xa0
ALSA sound/sparc/cs4231.c:505:   0x19: left line out   = 0xa0
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xa = 0x0
ALSA sound/sparc/cs4231.c:506:   0x0a: pin control     = 0x00  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1a = 0x0
ALSA sound/sparc/cs4231.c:507:   0x1a: mono control    = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x50
ALSA sound/sparc/cs4231.c:508:   0x0b: init & status   = 0x50  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1b = 0x0
ALSA sound/sparc/cs4231.c:509:   0x1b: right line out  = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xc = 0xca
ALSA sound/sparc/cs4231.c:510:   0x0c: revision & mode = 0xca  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1c = 0x20
ALSA sound/sparc/cs4231.c:511:   0x1c: record format   = 0x20
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xd = 0x0
ALSA sound/sparc/cs4231.c:512:   0x0d: loopback        = 0x00  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1d = 0x0
ALSA sound/sparc/cs4231.c:513:   0x1d: var freq (PnP)  = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xe = 0xff
ALSA sound/sparc/cs4231.c:514:   0x0e: ply upr count   = 0xff  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1e = 0x0
ALSA sound/sparc/cs4231.c:515:   0x1e: rec upr count   = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xf = 0xff
ALSA sound/sparc/cs4231.c:516:   0x0f: ply lwr count   = 0xff  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1f = 0x0
ALSA sound/sparc/cs4231.c:517:   0x1f: rec lwr count   = 0x00
ALSA sound/sparc/cs4231.c:732: TRIGGER: what[1] on(0)
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x9 = 0x8
ALSA sound/sparc/cs4231.c:483: CS4231 REGS:      INDEX = 0x09  ALSA sound/sparc/cs4231.c:485:                  STATUS = 0xde
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x0 = 0x0
ALSA sound/sparc/cs4231.c:486:   0x00: left input      = 0x00  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x10 = 0x80
ALSA sound/sparc/cs4231.c:487:   0x10: alt 1 (CFIG 2)  = 0x80
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1 = 0x0
ALSA sound/sparc/cs4231.c:488:   0x01: right input     = 0x00  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x11 = 0x3
ALSA sound/sparc/cs4231.c:489:   0x11: alt 2 (CFIG 3)  = 0x03
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x2 = 0x9f
ALSA sound/sparc/cs4231.c:490:   0x02: GF1 left input  = 0x9f  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x12 = 0x9f
ALSA sound/sparc/cs4231.c:491:   0x12: left line in    = 0x9f
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x3 = 0x9f
ALSA sound/sparc/cs4231.c:492:   0x03: GF1 right input = 0x9f  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x13 = 0x9f
ALSA sound/sparc/cs4231.c:493:   0x13: right line in   = 0x9f
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x4 = 0x9f
ALSA sound/sparc/cs4231.c:494:   0x04: CD left input   = 0x9f  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x14 = 0x0
ALSA sound/sparc/cs4231.c:495:   0x14: timer low       = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x5 = 0x9f
ALSA sound/sparc/cs4231.c:496:   0x05: CD right input  = 0x9f  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x15 = 0x0
ALSA sound/sparc/cs4231.c:497:   0x15: timer high      = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x6 = 0xbf
ALSA sound/sparc/cs4231.c:498:   0x06: left output     = 0xbf  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x16 = 0x0
ALSA sound/sparc/cs4231.c:499:   0x16: left MIC (PnP)  = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x7 = 0xbf
ALSA sound/sparc/cs4231.c:500:   0x07: right output    = 0xbf  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x17 = 0x0
ALSA sound/sparc/cs4231.c:501:   0x17: right MIC (PnP) = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x8 = 0x0
ALSA sound/sparc/cs4231.c:502:   0x08: playback format = 0x00  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x18 = 0x1
ALSA sound/sparc/cs4231.c:503:   0x18: IRQ status      = 0x01
ALSA sound/sparc/cs4231.c:473: codec in - reg 0x9 = 0x8
ALSA sound/sparc/cs4231.c:504:   0x09: iface (CFIG 1)  = 0x08  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x19 = 0xa0
ALSA sound/sparc/cs4231.c:505:   0x19: left line out   = 0xa0
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xa = 0x0
ALSA sound/sparc/cs4231.c:506:   0x0a: pin control     = 0x00  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1a = 0x0
ALSA sound/sparc/cs4231.c:507:   0x1a: mono control    = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xb = 0x50
ALSA sound/sparc/cs4231.c:508:   0x0b: init & status   = 0x50  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1b = 0x0
ALSA sound/sparc/cs4231.c:509:   0x1b: right line out  = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xc = 0xca
ALSA sound/sparc/cs4231.c:510:   0x0c: revision & mode = 0xca  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1c = 0x20
ALSA sound/sparc/cs4231.c:511:   0x1c: record format   = 0x20
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xd = 0x0
ALSA sound/sparc/cs4231.c:512:   0x0d: loopback        = 0x00  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1d = 0x0
ALSA sound/sparc/cs4231.c:513:   0x1d: var freq (PnP)  = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xe = 0xff
ALSA sound/sparc/cs4231.c:514:   0x0e: ply upr count   = 0xff  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1e = 0x0
ALSA sound/sparc/cs4231.c:515:   0x1e: rec upr count   = 0x00
ALSA sound/sparc/cs4231.c:473: codec in - reg 0xf = 0xff
ALSA sound/sparc/cs4231.c:516:   0x0f: ply lwr count   = 0xff  ALSA sound/sparc/cs4231.c:473: codec in - reg 0x1f = 0x0
ALSA sound/sparc/cs4231.c:517:   0x1f: rec lwr count   = 0x00
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x18 = 0x0
ALSA sound/sparc/cs4231.c:452: codec out - reg 0x18 = 0x0

--cWoXeonUoKmBZSoM--
