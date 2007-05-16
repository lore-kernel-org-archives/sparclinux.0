From: Meelis Roos <mroos@linux.ee>
Date: Wed, 16 May 2007 17:32:38 +0000
Subject: Re: parport_pc BUG in dma-mapping.h
Message-Id: <Pine.SOC.4.64.0705162029120.26905@math>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705121525460.4493@math>
In-Reply-To: <Pine.SOC.4.64.0705121525460.4493@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> This should fix it, thanks for the report:
> 
> commit 9ac6d4a4b85004dbb907f1d3b34412afe16f3758
> Author: David S. Miller <davem@sunset.davemloft.net>
> Date:   Mon May 14 02:56:03 2007 -0700
> 
>     [SPARC64]: Accept ebus_bus_type for generic DMA ops.
>     
>     Based upon a bug report by Meelis Roos.
>     
>     Signed-off-by: David S. Miller <davem@davemloft.net>

Unfortunately it does not seems to fix it. Applied the fix, changed SLUB 
config, did git pull from mainline - empty diff so it's already in 
mainline. Compile, boottested, the BUG is still tehere, plus another 
BUG from SLUB (should Christoph Lameter's patch fix that too?):

BUG: at include/linux/slub_def.h:89 kmalloc_index()

Full dmesg:

PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:36'
PROMLIB: Root node compatible: 
Linux version 2.6.22-rc1-g7b104bcb (mroos@mandariin) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #219 Wed May 16 13:11:47 EEST 2007
ARCH: SUN4U
Ethernet address: 08:00:20:f8:c7:72
PROM: Built device tree with 41786 bytes of memory.
On node 0 totalpages: 64971
  Normal zone: 447 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 64524 pages, LIFO batch:15
CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(262144):line_sz(64)]
Built 1 zonelists.  Total pages: 64524
Kernel command line: root=/dev/hda1 ro
PID hash table entries: 2048 (order: 11, 16384 bytes)
clocksource: mult[2c71c] shift[16]
clockevent: mult[5c28f5c2] shift[32]
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
Memory: 503776k available (2536k kernel code, 832k data, 120k init) [fffff80000000000,000000001ff42000]
SLUB: Genslabs, HWalign2, Order=0-2, MinObjects=8, Processors=1, Nodes=1
Calibrating delay using timer specific routine.. 720.79 BogoMIPS (lpj603975)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing for controllers.
/pci@1f,0: SABRE PCI Bus Module
/pci@1f,0: PCI IO[1fe02000000] MEM[1ff00000000]
PCI: Scanning PBM /pci@1f,0
    create device, devfn: 0, type: pci hostcontroller(1)
    class: 0x60000 device name: 0000:00:00.0
    adding to system ...
PCI: scan_bus[/pci@1f,0] bus no 0
  * /pci@1f,0/pci@1,1
    create device, devfn: 9, type: pci hostcontroller(0)
    class: 0x60400 device name: 0000:00:01.1
    adding to system ...
PCI: dev header type: 1
of_scan_pci_bridge(/pci@1f,0/pci@1,1)
    bus name: PCI Bus 0000:01
PCI: scan_bus[/pci@1f,0/pci@1,1] bus no 1
  * /pci@1f,0/pci@1,1/ebus@1
    create device, devfn: 8, type:  hostcontroller(0)
    class: 0x68000 device name: 0000:01:01.0
    adding to system ...
PCI: dev header type: 0
  * /pci@1f,0/pci@1,1/network@1,1
    create device, devfn: 9, type: network hostcontroller(0)
    class: 0x20000 device name: 0000:01:01.1
    parse addresses (20 bytes) @ fffff800000107c0
  start: 1ffe0000000, end: 1ffe000701f, i: 10
    adding to system ...
PCI: dev header type: 0
  * /pci@1f,0/pci@1,1/SUNW,m64B@2
    create device, devfn: 10, type: display hostcontroller(0)
    class: 0x30000 device name: 0000:01:02.0
    parse addresses (40 bytes) @ fffff80000011780
  start: 1ffe1000000, end: 1ffe1ffffff, i: 10
  start: 1ffe2000000, end: 1ffe2000fff, i: 18
    adding to system ...
PCI: dev header type: 0
  * /pci@1f,0/pci@1,1/ide@3
    create device, devfn: 18, type: ide hostcontroller(0)
    class: 0x1018f device name: 0000:01:03.0
    parse addresses (100 bytes) @ fffff80000012d40
  start: 1fe02c00000, end: 1fe02c00007, i: 10
  start: 1fe02c00008, end: 1fe02c0000b, i: 14
  start: 1fe02c00010, end: 1fe02c00017, i: 18
  start: 1fe02c00018, end: 1fe02c0001b, i: 1c
  start: 1fe02c00020, end: 1fe02c0002f, i: 20
    adding to system ...
PCI: dev header type: 0
  * /pci@1f,0/pci@1
    create device, devfn: 8, type: pci hostcontroller(0)
    class: 0x60400 device name: 0000:00:01.0
    adding to system ...
PCI: dev header type: 1
of_scan_pci_bridge(/pci@1f,0/pci@1)
    bus name: PCI Bus 0000:02
PCI: scan_bus[/pci@1f,0/pci@1] bus no 2
ebus0: [auxio] [power] [SUNW,pll] [se] [su] [su] [ecpp] [fdthree] [eeprom] [flashprom] [SUNW,CS4231]
power: Control reg at 1fff1724000 ... powerd running.
SCSI subsystem initialized
libata version 2.20 loaded.
AUXIO: Found device at /pci@1f,0/pci@1,1/ebus@1/auxio@14,726000
/pci@1f,0/pci@1,1/ebus@1/eeprom@14,0: Clock regs at 000001fff1000000
Time: tick clocksource has been installed.
Switched to high resolution mode on CPU 0
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 32768 bytes)
TCP established hash table entries: 16384 (order: 5, 262144 bytes)
TCP bind hash table entries: 16384 (order: 4, 131072 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Enabling device: (0000:01:02.0), cmd 82
rtc_init: no PC rtc found
/pci@1f,0/pci@1,1/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 6
/pci@1f,0/pci@1,1/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 7
f0061c64: ttyS0 at MMIO 0x1fff1400000 (irq = 5) is a SAB82532 V3.2
Console: ttyS0 (SAB82532)
f0061c64: ttyS1 at MMIO 0x1fff1400040 (irq = 5) is a SAB82532 V3.2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: module loaded
PCI: Enabling device: (0000:01:01.1), cmd 2
sunhme.c:v3.00 June 23, 2006 David S. Miller (davem@davemloft.net)
eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:f8:c7:72 
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CMD646: IDE controller at PCI slot 0000:01:03.0
CMD646: chipset revision 3
CMD646: chipset revision 0x03, MultiWord DMA Force Limited
CMD646: 100% native mode on irq 14
    ide0: BM-DMA at 0x1fe02c00020-0x1fe02c00027, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1fe02c00028-0x1fe02c0002f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: WDC WD1200JB-75CRA0, ATA DISK drive
hda: selected mode 0x22
ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 14
Probing IDE interface ide1...
hdc: CRD-8322B, ATAPI CD/DVD-ROM drive
hdc: selected mode 0x22
ide1 at 0x1fe02c00010-0x1fe02c00017,0x1fe02c0001a on irq 14 (shared with ide0)
hda: max request size: 128KiB
hda: Host Protected Area detected.
	current capacity is 234375000 sectors (120000 MB)
	native  capacity is 234441648 sectors (120034 MB)
hda: Host Protected Area disabled.
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHSe535/16/63, (U)DMA
hda: cache flushes not supported
 hda: hda1 hda2 hda3
rtc_sun_init: Registered Mostek RTC driver.
mice: PS/2 mouse device common for all mice
input: Sun Mouse as /class/input/input0
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
hdc: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
Adding 1843616k swap on /dev/hda2.  Priority:-1 extents:1 across:1843616k
EXT3 FS on hda1, internal journal
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
fuse init (API version 7.8)
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
parport0: PC-style at 0x1fff13043bc (0x1fff13047bc), irq 8, dma 0 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
kernel BUG at include/asm/dma-mapping.h:38!
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
modprobe(1279): Kernel bad sw trap 5 [#1]
TSTATE: 0000000011009605 TPC: 0000000010078728 TNPC: 000000001007872c Y: 00000000    Not tainted
TPC: <parport_pc_probe_port+0xfb0/0xfc0 [parport_pc]>
g0: 0000000100088000 g1: 000000000079d000 g2: 0000000000000001 g3: 000000000071cc00
g4: fffff8001fc8e500 g5: 006d6f6475000000 g6: fffff8001e15c000 g7: 000000000071cf68
o0: 000000000000002f o1: 000000001007be70 o2: 0000000000000026 o3: fffff8001f57e2c0
o4: 0000000000000001 o5: 0000000000000000 sp: fffff8001e15f3e1 ret_pc: 0000000010078720
RPC: <parport_pc_probe_port+0xfa8/0xfc0 [parport_pc]>
l0: 0000000010080000 l1: fffff8001fec76c0 l2: 00000000068dbc00 l3: fffff8001fec76c0
l4: ffffffffffffffff l5: 000001fff13043bc l6: fffff8001fec7700 l7: fffff8001fec7e00
i0: fffff8001ece8000 i1: 000001fff13047bc i2: 000000000071d000 i3: fffff8001fec76e8
i4: fffff8001fe99800 i5: 0000000010080400 i6: fffff8001e15f4a1 i7: 0000000010084780
I7: <parport_pc_init+0x668/0x780 [parport_pc]>
Caller[0000000010084780]: parport_pc_init+0x668/0x780 [parport_pc]
Caller[000000000046d5ec]: sys_init_module+0x134/0x1400
Caller[0000000000406994]: linux_sparc_syscall32+0x3c/0x40
Caller[00000000000133b4]: 0x133bc
Instruction DUMP: 92102026  7c0e8a08  90122270 <91d02005> 30680005  01000000  01000000  01000000  01000000 
lp: driver loaded but no devices found
end_request: I/O error, dev fd0, sector 0
BUG: at include/linux/slub_def.h:89 kmalloc_index()
Call Trace:
 [00000000004ce0a8] compat_core_sys_select+0x50/0x1c0
 [00000000004d045c] compat_sys_select+0xc4/0x1a0
 [0000000000406994] linux_sparc_syscall32+0x3c/0x40
 [00000000f7e68090] 0xf7e68098
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Mobile IPv6
eth0: no IPv6 routers present

-- 
Meelis Roos (mroos@linux.ee)
