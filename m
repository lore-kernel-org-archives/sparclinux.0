From: Meelis Roos <mroos@ut.ee>
Date: Mon, 15 Sep 2008 10:15:04 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <Pine.SOC.4.64.0809151312590.9542@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> It may be that if you revert the arch/sparc64/kernel/pci_psycho.c
> patch that added the IRQF_SHARED flag to the request_irq() calls,
> the system will boot albeit with those warnings in the log.

Yes, the system booted SMP and found the disks and 10 out of 14 
Ethernets without this IRQF_SHARED patch.

/proc/interrupts:
           CPU6       CPU7       
  0:       8058       7960     <NULL>  timer
  2:      36340          0      sun4u  zs
  4:          0          0      sun4u  SYSIO_UE
  5:          0          0      sun4u  SYSIO_CE
  6:          0          0      sun4u  SYSIO_SBERR
 11:          0          0      sun4u  Quattro
 12:          0          0      sun4u  SYSIO_UE
 13:          0          0      sun4u  SYSIO_CE
 14:          0          0      sun4u  SYSIO_SBERR
 19:         95          0      sun4u  ESP
 20:          0          0      sun4u  Quattro
 21:          0          0      sun4u  PSYCHO_PCIERR
 22:          0          0      sun4u  PSYCHO_UE
 23:          0          0      sun4u  PSYCHO_CE
 28:       1096          0      sun4u  eth9
 29:          0          0      sun4u  PSYCHO_PCIERR
 32:          0          0      sun4u  PSYCHO_PCIERR
 33:          0          0      sun4u  PSYCHO_UE
 34:          0          0      sun4u  PSYCHO_CE
 38:      18714          0      sun4u  qla1280
 39:          0          0      sun4u  PSYCHO_PCIERR

dmesg:

PROMLIB: Sun IEEE Boot Prom 'OBP 3.2.30 2002/10/25 14:03'
PROMLIB: Root node compatible: 
Linux version 2.6.27-rc6 (mroos@korvits) (gcc version 4.3.2 (Debian 4.3.2-1) ) #299 SMP Mon Sep 15 09:54:20 EEST 2008
console [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 08:00:20:b6:ee:e2
Kernel: Using 2 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /central@1f,0/fhc@0,f8800000/zs@0,902000:a
PROM: Built device tree with 97708 bytes of memory.
Top of RAM: 0x4fcfa000, Total RAM: 0x4f8d6000
Memory hole size: 4MB
[0000000200000000-fffff80000c00000] page_structs1072 node=0 entry=0/0
[0000000200000000-fffff80001000000] page_structs1072 node=0 entry=1/0
[0000000200800000-fffff80001400000] page_structs1072 node=0 entry=2/0
[0000000200800000-fffff80001800000] page_structs1072 node=0 entry=3/0
Zone PFN ranges:
  Normal   0x00000000 -> 0x00027e7d
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    0: 0x00000000 -> 0x00027bef
    0: 0x00027e00 -> 0x00027e72
    0: 0x00027e73 -> 0x00027e7d
On node 0 totalpages: 162923
  Normal zone: 161646 pages, LIFO batch:15
Booting Linux...
CENTRAL: Detected 5 slot Enterprise system. cfreg[68] cver[78]
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 5): Version[1] PartID[fa0] Manuf[3e] 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 161646
Kernel command line: root=/dev/sda2 ro debug
PID hash table entries: 4096 (order: 12, 32768 bytes)
clocksource: mult[28000] shift[16]
clockevent: mult[66666666] shift[32]
Console: colour dummy device 80x25
console handover: boot [earlyprom0] -> real [tty0]
Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
Memory: 1278400k available (2712k kernel code, 1008k data, 160k init) [fffff80000000000,000000004fcfa000]
SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
Calibrating delay using timer specific routine.. 801.22 BogoMIPS (lpj@06126)
Mount-cache hash table entries: 512
CPU 7: synchronized TICK with master CPU (last diff -17 cycles, maxerr 709 cycles)
Brought up 2 CPUs
net_namespace: 584 bytes
NET: Registered protocol family 16
PCI: Probing for controllers.
/pci@a,4000: PSYCHO PCI Bus Module ver[4:0]
/pci@a,4000: PCI IO[1d402010000] MEM[1d580000000]
/pci@a,2000: PSYCHO PCI Bus Module ver[4:0]
/pci@a,2000: PCI IO[1d402000000] MEM[1d500000000]
/pci@b,4000: PSYCHO PCI Bus Module ver[4:0]
/pci@b,4000: PCI IO[1d602010000] MEM[1d780000000]
/pci@b,2000: PSYCHO PCI Bus Module ver[4:0]
/pci@b,2000: PCI IO[1d602000000] MEM[1d700000000]
PCI: Scanning PBM /pci@b,2000
PCI: Scanning PBM /pci@b,4000
IRQ handler type mismatch for IRQ 33
current handler: PSYCHO_UE
Call Trace:
 [000000000048a2b0] request_irq+0xb0/0x120
 [00000000007b63a4] psycho_scan_bus+0x98/0x158
 [00000000007b2db8] pcibios_init+0xdc/0x12c
 [0000000000426a5c] do_one_initcall+0x1c/0x160
 [00000000007b0288] kernel_init+0x170/0x1d0
 [0000000000427050] kernel_thread+0x30/0x60
 [0000000000699eb0] rest_init+0x10/0x80
IRQ handler type mismatch for IRQ 34
current handler: PSYCHO_CE
Call Trace:
 [000000000048a2b0] request_irq+0xb0/0x120
 [00000000007b63c4] psycho_scan_bus+0xb8/0x158
 [00000000007b2db8] pcibios_init+0xdc/0x12c
 [0000000000426a5c] do_one_initcall+0x1c/0x160
 [00000000007b0288] kernel_init+0x170/0x1d0
 [0000000000427050] kernel_thread+0x30/0x60
 [0000000000699eb0] rest_init+0x10/0x80
PCI: Scanning PBM /pci@a,2000
PCI: Scanning PBM /pci@a,4000
IRQ handler type mismatch for IRQ 22
current handler: PSYCHO_UE
Call Trace:
 [000000000048a2b0] request_irq+0xb0/0x120
 [00000000007b63a4] psycho_scan_bus+0x98/0x158
 [00000000007b2db8] pcibios_init+0xdc/0x12c
 [0000000000426a5c] do_one_initcall+0x1c/0x160
 [00000000007b0288] kernel_init+0x170/0x1d0
 [0000000000427050] kernel_thread+0x30/0x60
 [0000000000699eb0] rest_init+0x10/0x80
IRQ handler type mismatch for IRQ 23
current handler: PSYCHO_CE
Call Trace:
 [000000000048a2b0] request_irq+0xb0/0x120
 [00000000007b63c4] psycho_scan_bus+0xb8/0x158
 [00000000007b2db8] pcibios_init+0xdc/0x12c
 [0000000000426a5c] do_one_initcall+0x1c/0x160
 [00000000007b0288] kernel_init+0x170/0x1d0
 [0000000000427050] kernel_thread+0x30/0x60
 [0000000000699eb0] rest_init+0x10/0x80
ebus: No EBus's found.
SCSI subsystem initialized
SYSIO: UPA portID 2, at 000001c400000000
sbus0: Clock 25.0 MHz
SYSIO: UPA portID 3, at 000001c600000000
sbus1: Clock 25.0 MHz
dma0: HME DVMA gate array 
/central/fhc@0,f8800000/eeprom@0,908000: Clock regs at 000001fff8908000
NET: Registered protocol family 2
Switched to high resolution mode on CPU 6
Switched to high resolution mode on CPU 7
IP route cache hash table entries: 65536 (order: 6, 524288 bytes)
TCP established hash table entries: 262144 (order: 9, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 2097152 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
NET: Registered protocol family 1
Mini RTC Driver
HugeTLB registered 4 MB page size, pre-allocated 0 pages
msgmni has been set to 2498
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Console: switching to mono PROM 80x34
f005de3c: ttyS0 at MMIO 0x1fff8902000 (irq = 2) is a zs (ESCC)
Console: ttyS0 (SunZilog zs0)
console [ttyS0] enabled
f005de3c: ttyS1 at MMIO 0x1fff8902004 (irq = 2) is a zs (ESCC)
f005df14: Keyboard at MMIO 0x1fff8904000 (irq = 2) is a zs
f005df14: Mouse at MMIO 0x1fff8904004 (irq = 2) is a zs
sunhme.c:v3.00 June 23, 2006 David S. Miller (davem@davemloft.net)
eth0: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:08
eth1: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:09
eth2: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:0a
eth3: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:0b
eth4: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:b6:ee:e2
eth5: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:94
eth6: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:95
eth7: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:96
eth8: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:97
sunhme: Probing PCI device bus[0] devfn[0x9]
PCI: Enabling device: (0000:00:01.1), cmd 2
eth9: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:b6:ee:e2
sunhme: Success
SysKonnect FDDI PCI Adapter driver v2.07 for
  SK-55xx/SK-58xx adapters (SK-NET FDDI-FP/UP/LP)
PCI: Enabling device: (0003:80:02.0), cmd 3
fddi0: SysKonnect FDDI PCI adapter found (SK-5821)
qla1280: QLA1040 found on PCI bus 0, dev 3
PCI: Enabling device: (0002:00:03.0), cmd 7
scsi(0:0): Resetting SCSI BUS
scsi0 : QLogic QLA1040 PCI to SCSI Host Adapter
       Firmware version:  7.65.06, Driver version 3.26
scsi 0:0:2:0: Direct-Access     IBM      DDYS-T18350M     S96H PQ: 0 ANSI: 3
scsi(0:0:2:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
scsi 0:0:3:0: Direct-Access     IBM      DDYS-T18350M     S93E PQ: 0 ANSI: 3
scsi(0:0:3:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
scsi 0:0:4:0: Direct-Access     HP       9.10GB A 80-6331      PQ: 0 ANSI: 2
scsi(0:0:4:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
scsi 0:0:5:0: Direct-Access     IBM      DDRS-34560D      DC1B PQ: 0 ANSI: 2
scsi(0:0:5:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
scsi 0:0:8:0: Direct-Access     HP       4.26GB A 80-0430 0430 PQ: 0 ANSI: 2
scsi(0:0:8:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
scsi 0:0:9:0: Direct-Access     HP       2.13GB A 80-0430 0430 PQ: 0 ANSI: 2
scsi(0:0:9:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
esp: esp0, regs[1c738810000:1c738800000] irq[19]
esp: esp0 is a FASHME, 40 MHz (ccf=0), SCSI ID 7
scsi1 : esp
scsi 1:0:6:0: CD-ROM            TOSHIBA  XM6201TASUN32XCD 1103 PQ: 0 ANSI: 2
 target1:0:6: Beginning Domain Validation
 target1:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
 target1:0:6: Domain Validation skipping write tests
 target1:0:6: Ending Domain Validation
Driver 'sd' needs updating - please use bus_type methods
sd 0:0:2:0: [sda] 35843670 512-byte hardware sectors (18352 MB)
sd 0:0:2:0: [sda] Write Protect is off
sd 0:0:2:0: [sda] Mode Sense: cb 00 00 08
sd 0:0:2:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:2:0: [sda] 35843670 512-byte hardware sectors (18352 MB)
sd 0:0:2:0: [sda] Write Protect is off
sd 0:0:2:0: [sda] Mode Sense: cb 00 00 08
sd 0:0:2:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:2:0: [sda] Attached SCSI disk
sd 0:0:3:0: [sdb] 35843670 512-byte hardware sectors (18352 MB)
sd 0:0:3:0: [sdb] Write Protect is off
sd 0:0:3:0: [sdb] Mode Sense: cb 00 00 08
sd 0:0:3:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:3:0: [sdb] 35843670 512-byte hardware sectors (18352 MB)
sd 0:0:3:0: [sdb] Write Protect is off
sd 0:0:3:0: [sdb] Mode Sense: cb 00 00 08
sd 0:0:3:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdb: unknown partition table
sd 0:0:3:0: [sdb] Attached SCSI disk
sd 0:0:4:0: [sdc] 17773524 512-byte hardware sectors (9100 MB)
sd 0:0:4:0: [sdc] Write Protect is off
sd 0:0:4:0: [sdc] Mode Sense: 9f 00 10 08
sd 0:0:4:0: [sdc] Write cache: disabled, read cache: enabled, supports DPO and FUA
sd 0:0:4:0: [sdc] 17773524 512-byte hardware sectors (9100 MB)
sd 0:0:4:0: [sdc] Write Protect is off
sd 0:0:4:0: [sdc] Mode Sense: 9f 00 10 08
sd 0:0:4:0: [sdc] Write cache: disabled, read cache: enabled, supports DPO and FUA
 sdc: unknown partition table
sd 0:0:4:0: [sdc] Attached SCSI disk
sd 0:0:5:0: [sdd] 8925000 512-byte hardware sectors (4570 MB)
sd 0:0:5:0: [sdd] Write Protect is off
sd 0:0:5:0: [sdd] Mode Sense: b9 00 00 08
sd 0:0:5:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:5:0: [sdd] 8925000 512-byte hardware sectors (4570 MB)
sd 0:0:5:0: [sdd] Write Protect is off
sd 0:0:5:0: [sdd] Mode Sense: b9 00 00 08
sd 0:0:5:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: unknown partition table
sd 0:0:5:0: [sdd] Attached SCSI disk
sd 0:0:8:0: [sde] 8330543 512-byte hardware sectors (4265 MB)
sd 0:0:8:0: [sde] Write Protect is off
sd 0:0:8:0: [sde] Mode Sense: 9f 00 10 08
sd 0:0:8:0: [sde] Write cache: disabled, read cache: enabled, supports DPO and FUA
sd 0:0:8:0: [sde] 8330543 512-byte hardware sectors (4265 MB)
sd 0:0:8:0: [sde] Write Protect is off
sd 0:0:8:0: [sde] Mode Sense: 9f 00 10 08
sd 0:0:8:0: [sde] Write cache: disabled, read cache: enabled, supports DPO and FUA
 sde: unknown partition table
sd 0:0:8:0: [sde] Attached SCSI disk
sd 0:0:9:0: [sdf] 4165272 512-byte hardware sectors (2133 MB)
sd 0:0:9:0: [sdf] Write Protect is off
sd 0:0:9:0: [sdf] Mode Sense: 9f 00 10 08
sd 0:0:9:0: [sdf] Write cache: disabled, read cache: enabled, supports DPO and FUA
sd 0:0:9:0: [sdf] 4165272 512-byte hardware sectors (2133 MB)
sd 0:0:9:0: [sdf] Write Protect is off
sd 0:0:9:0: [sdf] Mode Sense: 9f 00 10 08
sd 0:0:9:0: [sdf] Write cache: disabled, read cache: enabled, supports DPO and FUA
 sdf: unknown partition table
sd 0:0:9:0: [sdf] Attached SCSI disk
Driver 'sr' needs updating - please use bus_type methods
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
sr 1:0:6:0: Attached scsi CD-ROM sr0
sd 0:0:2:0: Attached scsi generic sg0 type 0
sd 0:0:3:0: Attached scsi generic sg1 type 0
sd 0:0:4:0: Attached scsi generic sg2 type 0
sd 0:0:5:0: Attached scsi generic sg3 type 0
sd 0:0:8:0: Attached scsi generic sg4 type 0
sd 0:0:9:0: Attached scsi generic sg5 type 0
sr 1:0:6:0: Attached scsi generic sg6 type 5
Driver 'ses' needs updating - please use bus_type methods
envctrl: I2C device not found.
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Adding 787168k swap on /dev/sda4.  Priority:-1 extents:1 across:787168k
EXT3 FS on sda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth9: Link is up using internal transceiver at 100Mb/s, Full Duplex.

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
