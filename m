From: Meelis Roos <mroos@linux.ee>
Date: Thu, 11 Sep 2008 14:14:14 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <Pine.SOC.4.64.0809111706470.13096@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Please try this patch:
> 
> sparc64: Fix interrupt register calculations on Psycho and Sabre.
> 
> Use the IMAP offset calculation for OBIO devices as documented in the
> programmer's manual.  Which is "0x10000 + ((ino & 0x1f) << 3)"

Yes, it works, thank you! Boots up as far as Ultra 5 config would go.

There is still some strangeness though. Physically, the machine has 2 
SBus Quad Fast Ethernet cards, SBus I/O module onboard hme, one PC Quad 
fast Ethernet (eth10..eth13) and one PCI I/O module onboard hme (eth9). 
All 14 interfaces were there in 2.6.8 debian kernel, some some PCI 
devices are missing here it seems?

dmesg complains about IRQ handler type mismatches though:

screen not found.
Can't open input device.
Keyboard not present.  Using ttya for input and output.

5-slot Sun Enterprise E3500, No Keyboard
OpenBoot 3.2.30, 1280 MB memory installed, Serial #11988706.
Copyright 2002 Sun Microsystems, Inc.  All rights reserved
Ethernet address 8:0:20:b6:ee:e2, Host ID: 80b6eee2.



Rebooting with command: boot
Boot device: /pci@b,4000/SUNW,isptwo@3/sd@2,0  File and args: 
SILO Version 1.4.13
boot: 
Linux                    LinuxOLD                 test                     
hea                      
boot: test debug
Allocated 8 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 2.6.27

PROMLIB: Sun IEEE Boot Prom 'OBP 3.2.30 2002/10/25 14:03'
PROMLIB: Root node compatible: 
Linux version 2.6.27-rc6-dirty (mroos@mandariin) (gcc version 4.3.2 (Debian 4.3.2-1) ) #141 Thu Sep 11 13:38:10 EEST 2008
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
[0000000200700000-fffff80001400000] page_structs1072 node=0 entry=2/0
[0000000200700000-fffff80001800000] page_structs1072 node=0 entry=3/0
Zone PFN ranges:
  Normal   0x00000000 -> 0x00027e7d
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    0: 0x00000000 -> 0x00027bef
    0: 0x00027e00 -> 0x00027e72
    0: 0x00027e73 -> 0x00027e7d
On node 0 totalpages: 162923
  Normal zone: 161805 pages, LIFO batch:15
Booting Linux...
CENTRAL: Detected 5 slot Enterprise system. cfreg[68] cver[78]
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 5): Version[1] PartID[fa0] Manuf[3e] 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 161805
Kernel command line: root=/dev/sda2 ro debug
PID hash table entries: 4096 (order: 12, 32768 bytes)
clocksource: mult[28000] shift[16]
clockevent: mult[66666666] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled
PROMLIB: Sun IEEE Boot Prom 'OBP 3.2.30 2002/10/25 14:03'
PROMLIB: Root node compatible: 
Linux version 2.6.27-rc6-dirty (mroos@mandariin) (gcc version 4.3.2 (Debian 4.3.2-1) ) #141 Thu Sep 11 13:38:10 EEST 2008
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
[0000000200700000-fffff80001400000] page_structs1072 node=0 entry=2/0
[0000000200700000-fffff80001800000] page_structs1072 node=0 entry=3/0
Zone PFN ranges:
  Normal   0x00000000 -> 0x00027e7d
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    0: 0x00000000 -> 0x00027bef
    0: 0x00027e00 -> 0x00027e72
    0: 0x00027e73 -> 0x00027e7d
On node 0 totalpages: 162923
  Normal zone: 161805 pages, LIFO batch:15
Booting Linux...
CENTRAL: Detected 5 slot Enterprise system. cfreg[68] cver[78]
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 5): Version[1] PartID[fa0] Manuf[3e] 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 161805
Kernel command line: root=/dev/sda2 ro debug
PID hash table entries: 4096 (order: 12, 32768 bytes)
clocksource: mult[28000] shift[16]
clockevent: mult[66666666] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled
Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
Memory: 1278552k available (2792k kernel code, 992k data, 152k init) [fffff80000000000,000000004fcfa000]
SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Calibrating delay using timer specific routine.. 800.81 BogoMIPS (lpj@04096)
Mount-cache hash table entries: 512
Initializing cgroup subsys ns
Initializing cgroup subsys devices
net_namespace: 1456 bytes
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
 [000000000048394c] request_irq+0xac/0x120
 [00000000007c5f6c] psycho_scan_bus+0x98/0x158
 [00000000007c2bc0] pcibios_init+0xdc/0x12c
 [0000000000426a5c] do_one_initcall+0x1c/0x160
 [00000000007c0180] kernel_init+0x9c/0xfc
 [0000000000427050] kernel_thread+0x30/0x60
 [00000000006ae1d0] rest_init+0x10/0x60
IRQ handler type mismatch for IRQ 34
current handler: PSYCHO_CE
Call Trace:
 [000000000048394c] request_irq+0xac/0x120
 [00000000007c5f8c] psycho_scan_bus+0xb8/0x158
 [00000000007c2bc0] pcibios_init+0xdc/0x12c
 [0000000000426a5c] do_one_initcall+0x1c/0x160
 [00000000007c0180] kernel_init+0x9c/0xfc
 [0000000000427050] kernel_thread+0x30/0x60
 [00000000006ae1d0] rest_init+0x10/0x60
PCI: Scanning PBM /pci@a,2000
PCI: Scanning PBM /pci@a,4000
IRQ handler type mismatch for IRQ 22
current handler: PSYCHO_UE
Call Trace:
 [000000000048394c] request_irq+0xac/0x120
 [00000000007c5f6c] psycho_scan_bus+0x98/0x158
 [00000000007c2bc0] pcibios_init+0xdc/0x12c
 [0000000000426a5c] do_one_initcall+0x1c/0x160
 [00000000007c0180] kernel_init+0x9c/0xfc
 [0000000000427050] kernel_thread+0x30/0x60
 [00000000006ae1d0] rest_init+0x10/0x60
IRQ handler type mismatch for IRQ 23
current handler: PSYCHO_CE
Call Trace:
 [000000000048394c] request_irq+0xac/0x120
 [00000000007c5f8c] psycho_scan_bus+0xb8/0x158
 [00000000007c2bc0] pcibios_init+0xdc/0x12c
 [0000000000426a5c] do_one_initcall+0x1c/0x160
 [00000000007c0180] kernel_init+0x9c/0xfc
 [0000000000427050] kernel_thread+0x30/0x60
 [00000000006ae1d0] rest_init+0x10/0x60
ebus: No EBus's found.
SCSI subsystem initialized
libata version 3.00 loaded.
SYSIO: UPA portID 2, at 000001c400000000
sbus0: Clock 25.0 MHz
SYSIO: UPA portID 3, at 000001c600000000
sbus1: Clock 25.0 MHz
dma0: HME DVMA gate array 
/central/fhc@0,f8800000/eeprom@0,908000: Clock regs at 000001fff8908000
NET: Registered protocol family 2
Switched to high resolution mode on CPU 0
IP route cache hash table entries: 65536 (order: 6, 524288 bytes)
TCP established hash table entries: 262144 (order: 9, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 6, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
NET: Registered protocol family 1
Mini RTC Driver
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
msgmni has been set to 2498
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
f005de3c: ttyS0 at MMIO 0x1fff8902000 (irq = 2) is a zs (ESCC)
Console: ttyS0 (SunZilog zs0)
console [ttyS0] enabled
PROMLIB: Sun IEEE Boot Prom 'OBP 3.2.30 2002/10/25 14:03'
PROMLIB: Sun IEEE Boot Prom 'OBP 3.2.30 2002/10/25 14:03'
PROMLIB: Root node compatible: 
PROMLIB: Root node compatible: 
Linux version 2.6.27-rc6-dirty (mroos@mandariin) (gcc version 4.3.2 (Debian 4.3.2-1) ) #141 Thu Sep 11 13:38:10 EEST 2008
Linux version 2.6.27-rc6-dirty (mroos@mandariin) (gcc version 4.3.2 (Debian 4.3.2-1) ) #141 Thu Sep 11 13:38:10 EEST 2008
console [earlyprom0] enabled
console [earlyprom0] enabled
ARCH: SUN4U
ARCH: SUN4U
Ethernet address: 08:00:20:b6:ee:e2
Ethernet address: 08:00:20:b6:ee:e2
Kernel: Using 2 locked TLB entries for main kernel image.
Kernel: Using 2 locked TLB entries for main kernel image.
Remapping the kernel... done.
Remapping the kernel... done.
OF stdout device is: /central@1f,0/fhc@0,f8800000/zs@0,902000:a
OF stdout device is: /central@1f,0/fhc@0,f8800000/zs@0,902000:a
PROM: Built device tree with 97708 bytes of memory.
PROM: Built device tree with 97708 bytes of memory.
Top of RAM: 0x4fcfa000, Total RAM: 0x4f8d6000
Top of RAM: 0x4fcfa000, Total RAM: 0x4f8d6000
Memory hole size: 4MB
Memory hole size: 4MB
[0000000200000000-fffff80000c00000] page_structs1072 node=0 entry=0/0
[0000000200000000-fffff80000c00000] page_structs1072 node=0 entry=0/0
[0000000200000000-fffff80001000000] page_structs1072 node=0 entry=1/0
[0000000200000000-fffff80001000000] page_structs1072 node=0 entry=1/0
[0000000200700000-fffff80001400000] page_structs1072 node=0 entry=2/0
[0000000200700000-fffff80001400000] page_structs1072 node=0 entry=2/0
[0000000200700000-fffff80001800000] page_structs1072 node=0 entry=3/0
[0000000200700000-fffff80001800000] page_structs1072 node=0 entry=3/0
Zone PFN ranges:
Zone PFN ranges:
  Normal   0x00000000 -> 0x00027e7d
  Normal   0x00000000 -> 0x00027e7d
Movable zone start PFN for each node
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
early_node_map[3] active PFN ranges
    0: 0x00000000 -> 0x00027bef
    0: 0x00000000 -> 0x00027bef
    0: 0x00027e00 -> 0x00027e72
    0: 0x00027e00 -> 0x00027e72
    0: 0x00027e73 -> 0x00027e7d
    0: 0x00027e73 -> 0x00027e7d
On node 0 totalpages: 162923
On node 0 totalpages: 162923
  Normal zone: 161805 pages, LIFO batch:15
  Normal zone: 161805 pages, LIFO batch:15
Booting Linux...
Booting Linux...
CENTRAL: Detected 5 slot Enterprise system. cfreg[68] cver[78]
CENTRAL: Detected 5 slot Enterprise system. cfreg[68] cver[78]
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 5): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 5): Version[1] PartID[fa0] Manuf[3e] 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 161805
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 161805
Kernel command line: root=/dev/sda2 ro debug
Kernel command line: root=/dev/sda2 ro debug
PID hash table entries: 4096 (order: 12, 32768 bytes)
PID hash table entries: 4096 (order: 12, 32768 bytes)
clocksource: mult[28000] shift[16]
clocksource: mult[28000] shift[16]
clockevent: mult[66666666] shift[32]
clockevent: mult[66666666] shift[32]
Console: colour dummy device 80x25
Console: colour dummy device 80x25
console [tty0] enabled
console [tty0] enabled
Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
Memory: 1278552k available (2792k kernel code, 992k data, 152k init) [fffff80000000000,000000004fcfa000]
Memory: 1278552k available (2792k kernel code, 992k data, 152k init) [fffff80000000000,000000004fcfa000]
SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Calibrating delay using timer specific routine.. 800.81 BogoMIPS (lpj@04096)
Calibrating delay using timer specific routine.. 800.81 BogoMIPS (lpj@04096)
Mount-cache hash table entries: 512
Mount-cache hash table entries: 512
Initializing cgroup subsys ns
Initializing cgroup subsys ns
Initializing cgroup subsys devices
Initializing cgroup subsys devices
net_namespace: 1456 bytes
net_namespace: 1456 bytes
NET: Registered protocol family 16
NET: Registered protocol family 16
PCI: Probing for controllers.
PCI: Probing for controllers.
/pci@a,4000: PSYCHO PCI Bus Module ver[4:0]
/pci@a,4000: PSYCHO PCI Bus Module ver[4:0]
/pci@a,4000: PCI IO[1d402010000] MEM[1d580000000]
/pci@a,4000: PCI IO[1d402010000] MEM[1d580000000]
/pci@a,2000: PSYCHO PCI Bus Module ver[4:0]
/pci@a,2000: PSYCHO PCI Bus Module ver[4:0]
/pci@a,2000: PCI IO[1d402000000] MEM[1d500000000]
/pci@a,2000: PCI IO[1d402000000] MEM[1d500000000]
/pci@b,4000: PSYCHO PCI Bus Module ver[4:0]
/pci@b,4000: PSYCHO PCI Bus Module ver[4:0]
/pci@b,4000: PCI IO[1d602010000] MEM[1d780000000]
/pci@b,4000: PCI IO[1d602010000] MEM[1d780000000]
/pci@b,2000: PSYCHO PCI Bus Module ver[4:0]
/pci@b,2000: PSYCHO PCI Bus Module ver[4:0]
/pci@b,2000: PCI IO[1d602000000] MEM[1d700000000]
/pci@b,2000: PCI IO[1d602000000] MEM[1d700000000]
PCI: Scanning PBM /pci@b,2000
PCI: Scanning PBM /pci@b,2000
PCI: Scanning PBM /pci@b,4000
PCI: Scanning PBM /pci@b,4000
IRQ handler type mismatch for IRQ 33
IRQ handler type mismatch for IRQ 33
current handler: PSYCHO_UE
current handler: PSYCHO_UE
Call Trace:
Call Trace:
 [000000000048394c] request_irq+0xac/0x120
 [000000000048394c] request_irq+0xac/0x120
 [00000000007c5f6c] psycho_scan_bus+0x98/0x158
 [00000000007c5f6c] psycho_scan_bus+0x98/0x158
 [00000000007c2bc0] pcibios_init+0xdc/0x12c
 [00000000007c2bc0] pcibios_init+0xdc/0x12c
 [0000000000426a5c] do_one_initcall+0x1c/0x160
 [0000000000426a5c] do_one_initcall+0x1c/0x160
 [00000000007c0180] kernel_init+0x9c/0xfc
 [00000000007c0180] kernel_init+0x9c/0xfc
 [0000000000427050] kernel_thread+0x30/0x60
 [0000000000427050] kernel_thread+0x30/0x60
 [00000000006ae1d0] rest_init+0x10/0x60
 [00000000006ae1d0] rest_init+0x10/0x60
IRQ handler type mismatch for IRQ 34
IRQ handler type mismatch for IRQ 34
current handler: PSYCHO_CE
current handler: PSYCHO_CE
Call Trace:
Call Trace:
 [000000000048394c] request_irq+0xac/0x120
 [000000000048394c] request_irq+0xac/0x120
 [00000000007c5f8c] psycho_scan_bus+0xb8/0x158
 [00000000007c5f8c] psycho_scan_bus+0xb8/0x158
 [00000000007c2bc0] pcibios_init+0xdc/0x12c
 [00000000007c2bc0] pcibios_init+0xdc/0x12c
 [0000000000426a5c] do_one_initcall+0x1c/0x160
 [0000000000426a5c] do_one_initcall+0x1c/0x160
 [00000000007c0180] kernel_init+0x9c/0xfc
 [00000000007c0180] kernel_init+0x9c/0xfc
 [0000000000427050] kernel_thread+0x30/0x60
 [0000000000427050] kernel_thread+0x30/0x60
 [00000000006ae1d0] rest_init+0x10/0x60
 [00000000006ae1d0] rest_init+0x10/0x60
PCI: Scanning PBM /pci@a,2000
PCI: Scanning PBM /pci@a,2000
PCI: Scanning PBM /pci@a,4000
PCI: Scanning PBM /pci@a,4000
IRQ handler type mismatch for IRQ 22
IRQ handler type mismatch for IRQ 22
current handler: PSYCHO_UE
current handler: PSYCHO_UE
Call Trace:
Call Trace:
 [000000000048394c] request_irq+0xac/0x120
 [000000000048394c] request_irq+0xac/0x120
 [00000000007c5f6c] psycho_scan_bus+0x98/0x158
 [00000000007c5f6c] psycho_scan_bus+0x98/0x158
 [00000000007c2bc0] pcibios_init+0xdc/0x12c
 [00000000007c2bc0] pcibios_init+0xdc/0x12c
 [0000000000426a5c] do_one_initcall+0x1c/0x160
 [0000000000426a5c] do_one_initcall+0x1c/0x160
 [00000000007c0180] kernel_init+0x9c/0xfc
 [00000000007c0180] kernel_init+0x9c/0xfc
 [0000000000427050] kernel_thread+0x30/0x60
 [0000000000427050] kernel_thread+0x30/0x60
 [00000000006ae1d0] rest_init+0x10/0x60
 [00000000006ae1d0] rest_init+0x10/0x60
IRQ handler type mismatch for IRQ 23
IRQ handler type mismatch for IRQ 23
current handler: PSYCHO_CE
current handler: PSYCHO_CE
Call Trace:
Call Trace:
 [000000000048394c] request_irq+0xac/0x120
 [000000000048394c] request_irq+0xac/0x120
 [00000000007c5f8c] psycho_scan_bus+0xb8/0x158
 [00000000007c5f8c] psycho_scan_bus+0xb8/0x158
 [00000000007c2bc0] pcibios_init+0xdc/0x12c
 [00000000007c2bc0] pcibios_init+0xdc/0x12c
 [0000000000426a5c] do_one_initcall+0x1c/0x160
 [0000000000426a5c] do_one_initcall+0x1c/0x160
 [00000000007c0180] kernel_init+0x9c/0xfc
 [00000000007c0180] kernel_init+0x9c/0xfc
 [0000000000427050] kernel_thread+0x30/0x60
 [0000000000427050] kernel_thread+0x30/0x60
 [00000000006ae1d0] rest_init+0x10/0x60
 [00000000006ae1d0] rest_init+0x10/0x60
ebus: No EBus's found.
ebus: No EBus's found.
SCSI subsystem initialized
SCSI subsystem initialized
libata version 3.00 loaded.
libata version 3.00 loaded.
SYSIO: UPA portID 2, at 000001c400000000
SYSIO: UPA portID 2, at 000001c400000000
sbus0: Clock 25.0 MHz
sbus0: Clock 25.0 MHz
SYSIO: UPA portID 3, at 000001c600000000
SYSIO: UPA portID 3, at 000001c600000000
sbus1: Clock 25.0 MHz
sbus1: Clock 25.0 MHz
dma0: HME DVMA gate array 
dma0: HME DVMA gate array 
/central/fhc@0,f8800000/eeprom@0,908000: Clock regs at 000001fff8908000
/central/fhc@0,f8800000/eeprom@0,908000: Clock regs at 000001fff8908000
NET: Registered protocol family 2
NET: Registered protocol family 2
Switched to high resolution mode on CPU 0
Switched to high resolution mode on CPU 0
IP route cache hash table entries: 65536 (order: 6, 524288 bytes)
IP route cache hash table entries: 65536 (order: 6, 524288 bytes)
TCP established hash table entries: 262144 (order: 9, 4194304 bytes)
TCP established hash table entries: 262144 (order: 9, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 6, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP reno registered
NET: Registered protocol family 1
NET: Registered protocol family 1
Mini RTC Driver
Mini RTC Driver
VFS: Disk quotas dquot_6.5.1
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
msgmni has been set to 2498
msgmni has been set to 2498
io scheduler noop registered
io scheduler noop registered
io scheduler anticipatory registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler deadline registered
io scheduler cfq registered (default)
io scheduler cfq registered (default)
f005de3c: ttyS0 at MMIO 0x1fff8902000 (irq = 2) is a zs (ESCC)
f005de3c: ttyS0 at MMIO 0x1fff8902000 (irq = 2) is a zs (ESCC)
Console: ttyS0 (SunZilog zs0)
Console: ttyS0 (SunZilog zs0)
console [ttyS0] enabled
console [ttyS0] enabled
f005de3c: ttyS1 at MMIO 0x1fff8902004 (irq = 2) is a zs (ESCC)
f005de3c: ttyS1 at MMIO 0x1fff8902004 (irq = 2) is a zs (ESCC)
f005df14: Keyboard at MMIO 0x1fff8904000 (irq = 2) is a zs
f005df14: Keyboard at MMIO 0x1fff8904000 (irq = 2) is a zs
f005df14: Mouse at MMIO 0x1fff8904004 (irq = 2) is a zs
f005df14: Mouse at MMIO 0x1fff8904004 (irq = 2) is a zs
loop: module loaded
loop: module loaded
sunhme.c:v3.00 June 23, 2006 David S. Miller (davem@davemloft.net)
sunhme.c:v3.00 June 23, 2006 David S. Miller (davem@davemloft.net)
eth0: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet eth0: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:08
08:00:20:9d:77:08
eth1: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet eth1: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:09
08:00:20:9d:77:09
eth2: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet eth2: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:0a
08:00:20:9d:77:0a
eth3: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet eth3: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:0b
08:00:20:9d:77:0b
eth4: HAPPY MEAL (SBUS) 10/100baseT Ethernet eth4: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:b6:ee:e2
08:00:20:b6:ee:e2
eth5: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet eth5: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:94
08:00:20:93:79:94
eth6: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet eth6: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:95
08:00:20:93:79:95
eth7: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet eth7: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:96
08:00:20:93:79:96
eth8: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet eth8: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:97
08:00:20:93:79:97
PCI: Enabling device: (0000:00:01.1), cmd 2
PCI: Enabling device: (0000:00:01.1), cmd 2
eth9: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet eth9: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:b6:ee:e2
08:00:20:b6:ee:e2
Uniform Multi-Platform E-IDE driver
Uniform Multi-Platform E-IDE driver
mice: PS/2 mouse device common for all mice
mice: PS/2 mouse device common for all mice
TCP cubic registered
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 17
registered taskstats version 1
registered taskstats version 1
input: Sun Mouse as /devices/root/f005da70/f005db8c/f005df14/serio1/input/input0
input: Sun Mouse as /devices/root/f005da70/f005db8c/f005df14/serio1/input/input0
VFS: Cannot open root device "sda2" or unknown-block(0,0)
VFS: Cannot open root device "sda2" or unknown-block(0,0)
Please append a correct "root=" boot option; here are the available partitions:
Please append a correct "root=" boot option; here are the available partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
Press Stop-A (L1-A) to return to the boot prom
Press Stop-A (L1-A) to return to the boot prom

-- 
Meelis Roos (mroos@linux.ee)
