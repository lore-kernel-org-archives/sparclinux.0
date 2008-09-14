From: Meelis Roos <mroos@ut.ee>
Date: Sun, 14 Sep 2008 20:13:25 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <Pine.SOC.4.64.0809142310230.19219@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> That's very very strange.  What's the most odd is that the firmware message
> and error is from cpu #7, which from your e3500 prtconf we shouldn't even
> be running on yet.  The system should boot on cpu #6.  So I suspect that
> perhaps we are somehow corrupting some piece of firmware state on cpu #6
> and this is why cpu #7 crashes us out to the firmware prompt.

I found out that the hangs started when I changed the config to be 
somewaht compatible with E3500 instead of U5 (turning on SMP etc). I 
swtched back to the original U5 custom configa and this kernel boots 
again (will deal with the other config hang later when PCi is sorted 
out).

So, with the latest patchset applied, I get the following oops instead:

PROMLIB: Sun IEEE Boot Prom 'OBP 3.2.30 2002/10/25 14:03'
PROMLIB: Root node compatible: 
Linux version 2.6.27-rc6-dirty (mroos@korvits) (gcc version 4.3.2 (Debian 4.3.2-1) ) #297 Sun Sep 14 19:33:10 EEST 2008
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
Linux version 2.6.27-rc6-dirty (mroos@korvits) (gcc version 4.3.2 (Debian 4.3.2-1) ) #297 Sun Sep 14 19:33:10 EEST 2008
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
mem_init(): ENTER
mem_init(): memset() on sparc64_valid_addr_bitmap(fffff8000031d180)
mem_init(): setup_valid_addr_bitmap_from_pavail()
mem_init(): free_bootmem()
mem_init(): Allocate mem_map_zero()
Memory: 1278552k available (2792k kernel code, 992k data, 152k init) [fffff80000000000,000000004fcfa000]
SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Calibrating delay using timer specific routine.. 800.85 BogoMIPS (lpj@04285)
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
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000000
tsk->{mm,active_mm}->pgd = fffff800007e905c
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(1): Oops [#1]
TSTATE: 0000000080f01601 TPC: 000000000043dd48 TNPC: 000000000043dd4c Y: 00000000    Not tainted
TPC: <psycho_pcierr_intr+0xa8/0x360>
g0: fffff8004e9a8fc0 g1: 0000000000000000 g2: fffff8004e9af800 g3: 000000020000010f
g4: fffff8004e850000 g5: 0000000000000000 g6: fffff8004e854000 g7: 0000000000000001
o0: 00000000007ae580 o1: 0000000000000040 o2: 0000000000000006 o3: fffff8004e857b0e
o4: 0000000000001008 o5: 0000000000006000 sp: fffff8004e857251 ret_pc: 00000000004836cc
RPC: <setup_irq+0x12c/0x300>
l0: 0000000000000000 l1: 0000000000000000 l2: 0000000000000cc0 l3: 0000000000789c68
l4: 000000000078a950 l5: 0000000000000000 l6: 0000000000799b28 l7: 0000000000744538
i0: 0000000000000000 i1: fffff8004e9af000 i2: fffff8004fcc92c0 i3: 000000000043aae0
i4: fffff8004e9af098 i5: 0000000000744500 i6: fffff8004e857321 i7: 000000000048397c
I7: <request_irq+0xdc/0x120>
Caller[000000000048397c]: request_irq+0xdc/0x120
Caller[00000000007c5fac]: psycho_scan_bus+0xd8/0x158
Caller[00000000007c2bc0]: pcibios_init+0xdc/0x12c
Caller[0000000000426a5c]: do_one_initcall+0x1c/0x160
Caller[00000000007c0180]: kernel_init+0x9c/0xfc
Caller[0000000000427050]: kernel_thread+0x30/0x60
Caller[00000000006ae1d0]: rest_init+0x10/0x60
Instruction DUMP: 94102006  9607a7ed  c258a038 <d2006038> 4004cb15  d0586010  d417a7ed  0300001e  82106100 
Kernel panic - not syncing: Attempted to kill init!
Press Stop-A (L1-A) to return to the boot prom

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
