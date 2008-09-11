From: Meelis Roos <mroos@linux.ee>
Date: Thu, 11 Sep 2008 09:25:52 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <Pine.SOC.4.64.0809111207300.817@math.ut.ee>
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

Allocated 8 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 2.6.27

PROMLIB: Sun IEEE Boot Prom 'OBP 3.2.30 2002/10/25 14:03'
PROMLIB: Root node compatible:
Linux version 2.6.27-rc6-dirty (mroos@mandariin) (gcc version 4.3.2 
(Debian 4.3.2-1) ) #140 Thu Sep 11 11:18:20 EEST 2008
console [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 08:00:20:b6:ee:e2
Kernel: Using 2 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /central@1f,0/fhc@0,f8800000/zs@0,902000:a
PROM: Built device tree with 97708 bytes of memory.
Top of RAM: 0x4fcfa000, Total RAM: 0x4f8d4000
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
    0: 0x00027e01 -> 0x00027e72
    0: 0x00027e73 -> 0x00027e7d
Booting Linux...
CENTRAL: Detected 5 slot Enterprise system. cfreg[68] cver[78]
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
FHC(board 1): Version[1] PartID[fa0] Manuf[3e]
FHC(board 5): Version[1] PartID[fa0] Manuf[3e]
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 
161804
Kernel command line: root=/dev/sda2 ro
PID hash table entries: 4096 (order: 12, 32768 bytes)
clocksource: mult[28000] shift[16]
clockevent: mult[66666666] shift[32]
Console: colour dummy device 80x25
console handover: boot [earlyprom0] -> real [tty0]

(hard hang here)

Here after these lines was the Wacky INO message earlier.

Now if I could reset or power-cycle a 3500 remotely...
Enter Enter ~ ^R
from serial port A does not seem to do the trick.

-- 
Meelis Roos (mroos@linux.ee)
