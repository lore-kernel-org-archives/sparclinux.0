From: Meelis Roos <mroos@ut.ee>
Date: Sun, 14 Sep 2008 07:27:21 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <Pine.SOC.4.64.0809141026240.3619@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Remove the CON_BOOT flag from the PROM early console struct in
> arch/sparc64/kernel/setup.c

Still the same, only double. But I might not have reproduced the same 
config as before, will see that next.

PROMLIB: Sun IEEE Boot Prom 'OBP 3.2.30 2002/10/25 14:03'
PROMLIB: Root node compatible: 
Linux version 2.6.27-rc6 (mroos@korvits) (gcc version 4.3.2 (Debian 4.3.2-1) ) #295 SMP Sun Sep 14 07:13:13 EEST 2008
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
console [tty0] enabled
PROMLIB: Sun IEEE Boot Prom 'OBP 3.2.30 2002/10/25 14:03'
PROMLIB: Root node compatible: 
Linux version 2.6.27-rc6 (mroos@korvits) (gcc version 4.3.2 (Debian 4.3.2-1) ) #295 SMP Sun Sep 14 07:13:13 EEST 2008
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
console [tty0] enabled
Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
Memory: 1276264k available (2856k kernel code, 1136k data, 168k init) [fffff80000000000,000000004fcfa000]
SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
Calibrating delay using timer specific routine.. 801.65 BogoMIPS (lpj@08283)
Mount-cache hash table entries: 512
Fast Data Access MMU Miss
{7} ok 

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
