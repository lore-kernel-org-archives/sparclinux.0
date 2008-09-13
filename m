From: Meelis Roos <mroos@linux.ee>
Date: Sat, 13 Sep 2008 12:09:39 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <Pine.SOC.4.64.0809131332500.17283@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Please get me that bootup log with the sunhme.c debugging patch
> applied so we can fix that too.

I can not understanda what I have right now - I applied to what I think 
was the right kernel, the resulting kernel hung like below. Then I 
reversed the hme patch and the resulting kernel still hangs the same 
way. Maybe I botched something... anyway, here is the hang. An by the 
way, it used to stop at {6} ok, now it's {7} ok so it's a different CPU.

boot: test debug
Allocated 8 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 2.6.27

PROMLIB: Sun IEEE Boot Prom 'OBP 3.2.30 2002/10/25 14:03'
PROMLIB: Root node compatible:
Linux version 2.6.27-rc6-dirty (mroos@mandariin) (gcc version 4.3.2 
(Debian 4.3.2-1) ) #143 SMP Fri Sep 12 18:17:16 EEST 28
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
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 
161805
Kernel command line: root=/dev/sda2 ro debug
PID hash table entries: 4096 (order: 12, 32768 bytes)
clocksource: mult[28000] shift[16]
clockevent: mult[66666666] shift[32]
Console: colour dummy device 80x25
console handover: boot [earlyprom0] -> real [tty0]
Fast Data Access MMU Miss
{7} ok

-- 
Meelis Roos (mroos@linux.ee)
