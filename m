From: Meelis Roos <mroos@linux.ee>
Date: Mon, 25 Aug 2014 14:48:37 +0000
Subject: Re: PCI Radeon RV100 detection hang on sparc64
Message-Id: <alpine.SOC.1.00.1408201517210.57@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1309240010220.15075@math.ut.ee>
 <alpine.SOC.1.00.1310011134250.26098@math.ut.ee>
 <20140404.165202.33247787406066736.davem@davemloft.net>
 <20140812.233033.2016564874125097713.davem@davemloft.net>
 <alpine.SOC.1.00.1408190946280.27327@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1408190946280.27327@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, michel@daenzer.net, oftedal@gmail.com, dri-devel@lists.freedesktop.org

> r100 init hangs in a different place. Original dmesg first, then my 
> instrumented dmesg (seems to get further):

The instrumented dmesg had a couple of my local test changes and was 
bad now that I had ROM. Reverted them exept my readb changes (instead 
of direct dereferences of iomapped space) and redid 
logging to be more precise.

> [drm] radeon kernel modesetting enabled.
> PCI: Enabling device: (0000:02:02.0), cmd 82
> [drm] initializing kernel modesetting (RV100 0x1002:0x5159 0x1002:0x0908).
> [drm] register mmio base: 0x10000000
> [drm] register mmio size: 32768
> [drm:radeon_device_init] *ERROR* Unable to find PCI I/O BAR

This was still the unchanged kernel hanging.

Below is a new debug log to pinpoint the hang. It seems to hang in 
r100_gfx_get_rptr but not on first try.

Where should I look next?

PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:36'
PROMLIB: Root node compatible: 
Initializing cgroup subsys cpu
Linux version 3.17.0-rc1-dirty (mroos@u10) (gcc version 4.6.4 (Debian 4.6.4-4) ) #59 Tue Aug 19 22:26:05 EEST 2014
debug: ignoring loglevel setting.
bootconsole [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 08:00:20:9e:82:fd
PAGE_OFFSET is 0xffffff0000000000 (max_phys_bits = 40)
Kernel: Using 3 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /pci@1f,0/pci@1,1/ebus@1/se@14,400000:a
PROM: Built device tree with 87652 bytes of memory.
Top of RAM: 0x3fef0000, Total RAM: 0x3fee0000
Memory hole size: 0MB
Zone ranges:
  Normal   [mem 0x00000000-0x3feeffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x00000000-0x3fec9fff]
  node   0: [mem 0x3feda000-0x3feeffff]
On node 0 totalpages: 130928
  Normal zone: 1023 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 130928 pages, LIFO batch:15
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
CPU CAPS: [vis]
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129905
Kernel command line: root=/dev/sda4 ro debug ignore_loglevel ofpci_debug=1 radeon.modeset=1
PID hash table entries: 4096 (order: 2, 32768 bytes)
Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
Sorting __ex_table...
Memory: 1025424K/1047424K available (3745K kernel code, 319K rwdata, 1064K rodata, 168K init, 6562K bss, 22000K reserved)
SLUB: HWalign2, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:255
clocksource: mult[245d174] shift[24]
clockevent: mult[70a3d70a] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled
bootconsole [earlyprom0] disabled
PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:36'
PROMLIB: Root node compatible: 
Initializing cgroup subsys cpu
Linux version 3.17.0-rc1-dirty (mroos@u10) (gcc version 4.6.4 (Debian 4.6.4-4) ) #59 Tue Aug 19 22:26:05 EEST 2014
debug: ignoring loglevel setting.
bootconsole [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 08:00:20:9e:82:fd
PAGE_OFFSET is 0xffffff0000000000 (max_phys_bits = 40)
Kernel: Using 3 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /pci@1f,0/pci@1,1/ebus@1/se@14,400000:a
PROM: Built device tree with 87652 bytes of memory.
Top of RAM: 0x3fef0000, Total RAM: 0x3fee0000
Memory hole size: 0MB
Zone ranges:
  Normal   [mem 0x00000000-0x3feeffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x00000000-0x3fec9fff]
  node   0: [mem 0x3feda000-0x3feeffff]
On node 0 totalpages: 130928
  Normal zone: 1023 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 130928 pages, LIFO batch:15
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
CPU CAPS: [vis]
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129905
Kernel command line: root=/dev/sda4 ro debug ignore_loglevel ofpci_debug=1 radeon.modeset=1
PID hash table entries: 4096 (order: 2, 32768 bytes)
Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
Sorting __ex_table...
Memory: 1025424K/1047424K available (3745K kernel code, 319K rwdata, 1064K rodata, 168K init, 6562K bss, 22000K reserved)
SLUB: HWalign2, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:255
clocksource: mult[245d174] shift[24]
clockevent: mult[70a3d70a] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled
bootconsole [earlyprom0] disabled
Calibrating delay using timer specific routine.. 880.99 BogoMIPS (lpjD04994)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 16384 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 16384 bytes)
Initializing cgroup subsys net_cls
devtmpfs: initialized
NET: Registered protocol family 16
/pci@1f,0: PCI IO[1fe02000000] MEM[1ff00000000]
/pci@1f,0: SABRE PCI Bus Module ver[0:0]
PCI: Scanning PBM /pci@1f,0
sabre f005f9c0: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1fe02000000-0x1fe02ffffff] (bus address [0x0000-0xffffff])
pci_bus 0000:00: root bus resource [mem 0x1ff00000000-0x1ffffffffff] (bus address [0x00000000-0xffffffff])
pci_bus 0000:00: root bus resource [bus 00-02]
PCI: scan_bus[/pci@1f,0] bus no 0
  * /pci@1f,0/pci@1,1
    create device, devfn: 9, type: pci
    class: 0x60400 device name: 0000:00:01.1
    adding to system ...
PCI: dev header type: 1
of_scan_pci_bridge(/pci@1f,0/pci@1,1)
    Bridge bus range [1 --> 1]
    Bridge ranges[          (null)] simba[1]
    bus name: PCI Bus 0000:01
PCI: scan_bus[/pci@1f,0/pci@1,1] bus no 1
  * /pci@1f,0/pci@1,1/ebus@1
    create device, devfn: 8, type: 
    class: 0x68000 device name: 0000:01:01.0
    adding to system ...
PCI: dev header type: 0
  * /pci@1f,0/pci@1,1/network@1,1
    create device, devfn: 9, type: network
    class: 0x20000 device name: 0000:01:01.1
    parse addresses (20 bytes) @ ffffff003fee21c0
  start: 1ffe0000000, end: 1ffe000701f, i: 10
    adding to system ...
PCI: dev header type: 0
  * /pci@1f,0/pci@1,1/SUNW,m64B@2
    create device, devfn: 10, type: display
    class: 0x30000 device name: 0000:01:02.0
    parse addresses (40 bytes) @ ffffff003fee0e40
  start: 1ffe1000000, end: 1ffe1ffffff, i: 10
  start: 1ffe2000000, end: 1ffe2000fff, i: 18
    adding to system ...
PCI: dev header type: 0
  * /pci@1f,0/pci@1,1/ide@3
    create device, devfn: 18, type: ide
    class: 0x1018f device name: 0000:01:03.0
    parse addresses (100 bytes) @ ffffff003feda400
  start: 1fe02c00000, end: 1fe02c00007, i: 10
  start: 1fe02c00008, end: 1fe02c0000b, i: 14
  start: 1fe02c00010, end: 1fe02c00017, i: 18
  start: 1fe02c00018, end: 1fe02c0001b, i: 1c
  start: 1fe02c00020, end: 1fe02c0002f, i: 20
    adding to system ...
PCI: dev header type: 0
  * /pci@1f,0/pci@1
    create device, devfn: 8, type: pci
    class: 0x60400 device name: 0000:00:01.0
    adding to system ...
PCI: dev header type: 1
of_scan_pci_bridge(/pci@1f,0/pci@1)
    Bridge bus range [2 --> 2]
    Bridge ranges[          (null)] simba[1]
    bus name: PCI Bus 0000:02
PCI: scan_bus[/pci@1f,0/pci@1] bus no 2
  * /pci@1f,0/pci@1/scsi@1
    create device, devfn: 8, type: scsi-2
    class: 0x10000 device name: 0000:02:01.0
    parse addresses (40 bytes) @ ffffff003febeac0
  start: 1ff00002000, end: 1ff000020ff, i: 14
  start: 1ff00010000, end: 1ff0001ffff, i: 30
    adding to system ...
PCI: dev header type: 0
  * /pci@1f,0/pci@1/SUNW,XVR-100@2
    create device, devfn: 10, type: display
    class: 0x30000 device name: 0000:02:02.0
    parse addresses (80 bytes) @ ffffff003febc8c0
  start: 1ff08000000, end: 1ff0bffffff, i: 10
  start: 1ff00000400, end: 1ff000004ff, i: 14
  start: 1ff10000000, end: 1ff10007fff, i: 18
  start: 1ff10020000, end: 1ff1003ffff, i: 30
    adding to system ...
pci 0000:02:02.0: supports D1 D2
PCI: dev header type: 0
  * /pci@1f,0/pci@1/SUNW,m64B@3
    create device, devfn: 18, type: display
    class: 0x30000 device name: 0000:02:03.0
    parse addresses (60 bytes) @ ffffff003feba700
  start: 1ff11000000, end: 1ff11ffffff, i: 10
  start: 1ff12000000, end: 1ff12000fff, i: 18
  start: 1ff12020000, end: 1ff1203ffff, i: 30
    adding to system ...
pci 0000:02:03.0: supports D1 D2
PCI: dev header type: 0
  * /pci@1f,0/pci@1/FJSV,pgsb@4
    create device, devfn: 20, type: network
    class: 0x20000 device name: 0000:02:04.0
    parse addresses (20 bytes) @ ffffff003feb8740
  start: 1ff12040000, end: 1ff1204ffff, i: 10
    adding to system ...
pci 0000:02:04.0: PME# supported from D3hot
PCI: dev header type: 0
PCI: Claiming 0000:00:01.1: Resource 7: 000001fe02c00000..000001fe02ffffff [100]
PCI: Claiming 0000:00:01.1: Resource 8: 000001ffe0000000..000001ffffffffff [200]
PCI: Claiming 0000:00:01.0: Resource 7: 000001fe02000000..000001fe02bfffff [100]
PCI: Claiming 0000:00:01.0: Resource 8: 000001ff00000000..000001ffbfffffff [200]
pci 0000:00:01.0: can't claim BAR 8 [mem 0x1ff00000000-0x1ffbfffffff]: address conflict with Video RAM area [??? 0x1ff000a0000-0x1ff000bffff flags 0x80000000]
PCI: Claiming 0000:01:01.1: Resource 0: 000001ffe0000000..000001ffe000701f [200]
PCI: Claiming 0000:01:02.0: Resource 0: 000001ffe1000000..000001ffe1ffffff [200]
PCI: Claiming 0000:01:02.0: Resource 2: 000001ffe2000000..000001ffe2000fff [200]
PCI: Claiming 0000:01:03.0: Resource 0: 000001fe02c00000..000001fe02c00007 [101]
PCI: Claiming 0000:01:03.0: Resource 1: 000001fe02c00008..000001fe02c0000b [101]
PCI: Claiming 0000:01:03.0: Resource 2: 000001fe02c00010..000001fe02c00017 [101]
PCI: Claiming 0000:01:03.0: Resource 3: 000001fe02c00018..000001fe02c0001b [101]
PCI: Claiming 0000:01:03.0: Resource 4: 000001fe02c00020..000001fe02c0002f [101]
PCI: Claiming 0000:02:01.0: Resource 1: 000001ff00002000..000001ff000020ff [200]
PCI: Claiming 0000:02:01.0: Resource 6: 000001ff00010000..000001ff0001ffff [4c200]
PCI: Claiming 0000:02:02.0: Resource 0: 000001ff08000000..000001ff0bffffff [200]
PCI: Claiming 0000:02:02.0: Resource 1: 000001ff00000400..000001ff000004ff [200]
PCI: Claiming 0000:02:02.0: Resource 2: 000001ff10000000..000001ff10007fff [200]
PCI: Claiming 0000:02:02.0: Resource 6: 000001ff10020000..000001ff1003ffff [4c200]
PCI: Claiming 0000:02:03.0: Resource 0: 000001ff11000000..000001ff11ffffff [200]
PCI: Claiming 0000:02:03.0: Resource 2: 000001ff12000000..000001ff12000fff [200]
PCI: Claiming 0000:02:03.0: Resource 6: 000001ff12020000..000001ff1203ffff [4c200]
PCI: Claiming 0000:02:04.0: Resource 0: 000001ff12040000..000001ff1204ffff [204]
vgaarb: device added: PCI:0000:01:02.0,decodes=io+mem,owns=none,locks=none
vgaarb: device added: PCI:0000:02:02.0,decodes=io+mem,owns=none,locks=none
vgaarb: device added: PCI:0000:02:03.0,decodes=io+mem,owns=none,locks=none
vgaarb: loaded
vgaarb: no bridge control possible 0000:02:03.0
vgaarb: no bridge control possible 0000:02:02.0
vgaarb: bridge control possible 0000:01:02.0
SCSI subsystem initialized
/pci@1f,0/pci@1,1/ebus@1/eeprom@14,0: Mostek regs at 0x1fff1000000
AUXIO: Found device at /pci@1f,0/pci@1,1/ebus@1/auxio@14,726000
Switched to clocksource tick
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 3, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 512 (order: 1, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 1, 16384 bytes)
NET: Registered protocol family 1
PCI: CLS 64 bytes, default 64
power: Control reg at 1fff1724000
futex hash table entries: 256 (order: -1, 6144 bytes)
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
msgmni has been set to 2002
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
start plist test
end plist test
PCI: Enabling device: (0000:01:02.0), cmd 82
atyfb: 3D RAGE PRO (Mach64 GP, PQFP, PCI) [0x4750 rev 0x7c]
atyfb: 4M SGRAM (1:1), 14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK, 100 MHz XCLK
Console: switching to colour frame buffer device 80x30
atyfb: fb0: ATY Mach64 frame buffer device on PCI
PCI: Enabling device: (0000:02:03.0), cmd 82
atyfb: 3D RAGE XL (Mach64 GR, PCI-33) [0x4752 rev 0x27]
atyfb: 8M SGRAM (1:1), 29.498928 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 63 MHz XCLK
atyfb: fb1: ATY Mach64 frame buffer device on PCI
/SUNW,ffb@1e,0: FFB at 000001fc00000000, type 51, DAC pnum[236e] rev[10] manuf_rev[1]
/pci@1f,0/pci@1,1/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 6
/pci@1f,0/pci@1,1/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 7
f0061c64: ttyS0 at MMIO 0x1fff1400000 (irq = 5, base_baud = 115200) is a SAB82532 V3.2
Console: ttyS0 (SAB82532)
console [ttyS0] enabled
[sched_delayed] sched: RT throttling activated
f0061c64: ttyS1 at MMIO 0x1fff1400040 (irq = 5, base_baud = 115200) is a SAB82532 V3.2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
scsi host0: Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

PCI: Enabling device: (0000:01:01.1), cmd 2
sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:9e:82:fd
mousedev: PS/2 mouse device common for all mice
scsi 0:0:0:0: Direct-Access     QUANTUM  ATLAS IV 18 WLS  0909 PQ: 0 ANSI: 3
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi target0:0:0: Beginning Domain Validation
rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
hidraw: raw HID events driver (C) Jiri Kosina
TCP: cubic registered
NET: Registered protocol family 17
Key type dns_resolver registered
rtc-m48t59 rtc-m48t59.0: setting system clock to 2014-08-21 11:11:22 UTC (1408619482)
scsi target0:0:0: wide asynchronous
scsi target0:0:0: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 8)
scsi target0:0:0: Domain Validation skipping write tests
scsi target0:0:0: Ending Domain Validation
input: Sun Mouse as /devices/root/f005f9c0/f00601b4/f0061504/f0064df4/serio1/input/input1
sd 0:0:0:0: [sda] 35885168 512-byte logical blocks: (18.3 GB/17.1 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: e3 00 10 08
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
EXT4-fs (sda4): couldn't mount as ext3 due to feature incompatibilities
EXT4-fs (sda4): couldn't mount as ext2 due to feature incompatibilities
EXT4-fs (sda4): INFO: recovery required on readonly filesystem
EXT4-fs (sda4): write access will be enabled during recovery
EXT4-fs (sda4): orphan cleanup on readonly fs
EXT4-fs (sda4): 4 orphan inodes deleted
EXT4-fs (sda4): recovery complete
EXT4-fs (sda4): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) readonly on device 8:4.
devtmpfs: mounted
Mount failed for selinuxfs on /sys/fs/selinux:  No such file or directory
???????ɹ?????ѥ???
[info] Using makefile-style concurrent boot in runlevel S.
[....] Starting the hotplug events dispatcher: udevdsystemd-udevd[145]: starting version 204
[ ok .
[.random: nonblocking pool is initialized
...] Synthesizing the initial hotplug events...[ ok done.
[....] Waiting for /dev to be fully populated...pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[drm] Initialized drm 1.1.0 20060810
libata version 3.00 loaded.
scsi host1: pata_cmd64x
PTP clock support registered
scsi host2: pata_cmd64x
ata1: PATA max MWDMA2 cmd 0x1fe02c00000 ctl 0x1fe02c00008 bmdma 0x1fe02c00020 irq 14
ata2: PATA max MWDMA2 cmd 0x1fe02c00010 ctl 0x1fe02c00018 bmdma 0x1fe02c00028 irq 14
pata_cmd64x: active 10 recovery 10 setup 3.
pata_cmd64x: active 10 recovery 10 setup 3.
pata_cmd64x: active 10 recovery 10 setup 3.
pata_cmd64x: active 10 recovery 10 setup 3.
tg3.c:v3.137 (May 11, 2014)
PCI: Enabling device: (0000:02:04.0), cmd 2
tg3 0000:02:04.0 eth1: Tigon3 [partno(none) rev 1002] (PCI:33MHz:32-bit) MAC address 00:e0:00:a9:09:6a
tg3 0000:02:04.0 eth1: attached PHY is serdes (1000Base-SX Ethernet) (WireSpeed[0], EEE[0])
tg3 0000:02:04.0 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
tg3 0000:02:04.0 eth1: dma_rwctrl[763f0000] dma_mask[32-bit]
[drm] radeon kernel modesetting enabled.
PCI: Enabling device: (0000:02:02.0), cmd 82
[drm] initializing kernel modesetting (RV100 0x1002:0x5159 0x1002:0x0908).
[drm] register mmio base: 0x000001FF10000000
[drm] register mmio size: 32768
[drm:radeon_device_init] *ERROR* Unable to find PCI I/O BAR
[drm] r100_init start
[drm] r100_init before render disable
[drm] r100_init before scratch
[drm] r100_init before surface
[drm] r100_init before sanity restore
[drm] r100_init before get_gios
[drm] radeon_get_bios atrm
[drm] radeon_get_bios vfct
[drm] radeon_get_bios vram
[drm] radeon_get_bios read
[drm] radeon_read_bios 1
[drm] radeon_read_bios: pci_resource_start(ROM) 0001FF10020000
[drm] radeon_read_bios 2
[drm] radeon_read_bios 4, bios 0001ff10020000, pci_resource_start(ROM) 0001FF10020000, sizeF592
[drm] radeon_read_bios: found ROM signature at 000001ff10020000
[drm] radeon_read_bios 7: bios 0001ff10020000, sizeF592
[drm] mydup done!
[drm] radeon_read_bios 8
[drm] radeon_read_bios b
[drm] radeon_read_bios c
[drm] radeon_get_bios disabled
[drm] radeon_get_bios platform
[drm] Not an x86 BIOS ROM, not using.
[drm] r100_init before AVIVO
[drm] r100_init before atom_bios
[drm] r100_init before combios init
[drm] r100_init after combios init 
[drm] r100_init before asic reset
[drm] r100_init before boot test post card
[drm] Using device-tree clock info
radeon 0000:02:02.0: VRAM: 64M 0x000001FF08000000 - 0x000001FF0BFFFFFF (64M used)
radeon 0000:02:02.0: GTT: 512M 0x000001FF0C000000 - 0x000001FF2BFFFFFF
[drm] Detected VRAM RAMdM, BARdM
[drm] RAM width 64bits DDR
[TTM] Zone  kernel: Available graphics memory: 512796 kiB
[TTM] Initializing pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 65536, num gpu pages 131072
[drm] PCI GART of 512M enabled (table at 0x00000000C1F9E000).
radeon 0000:02:02.0: WB disabled
radeon 0000:02:02.0: fence driver on ring 0 use gpu addr 0x000001ff0c000000 and cpu addr 0xffffff003c00a000
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
[drm] radeon: irq initialized.
[drm] Loading R100 Microcode
[drm] radeon_ring_lockup_update start
[drm] r100_gfx_get_rptr start
[drm] r100_gfx_get_rptr case 2
[drm] r100_gfx_get_rptr end
[drm] radeon_ring_lockup_update middle
[drm] radeon_ring_lockup_update end
[drm] radeon: ring at 0x000001FF0C002000
[drm] radeon_ring_lock start
[drm] radeon_ring_lock got mutex
[drm] radeon_ring_alloc start
[drm] radeon_ring_alloc before radeon_ring_free_size
[drm] radeon_ring_free_size before radeon_ring_get_rptr
[drm] r100_gfx_get_rptr start
[drm] r100_gfx_get_rptr case 2
[drm] r100_gfx_get_rptr end
[drm] radeon_ring_free_size after radeon_ring_get_rptr
[drm] radeon_ring_free_size before radeon_ring_lockup_update
[drm] radeon_ring_lockup_update start
[drm] r100_gfx_get_rptr start
[drm] r100_gfx_get_rptr case 2
[drm] r100_gfx_get_rptr end
[drm] radeon_ring_lockup_update middle
[drm] radeon_ring_lockup_update end
[drm] radeon_ring_alloc after radeon_ring_free_size
[drm] radeon_ring_alloc end
[drm] radeon_ring_lock after alloc, r=0
[drm] radeon_ring_lock end (locked)
[drm] radeon_ring_unlock_commit unlocking
[drm] r100_ring_test start
[drm] r100_ring_test: after radeon_scratch_get, r 000000d
[drm] r100_ring_test before radeon_ring_lock
[drm] radeon_ring_lock start
[drm] radeon_ring_lock got mutex
[drm] radeon_ring_alloc start
[drm] radeon_ring_alloc before radeon_ring_free_size
[drm] radeon_ring_free_size before radeon_ring_get_rptr
[drm] r100_gfx_get_rptr start
[drm] r100_gfx_get_rptr case 2

-- 
Meelis Roos (mroos@linux.ee)
