From: adi@drcomp.erfurt.thur.de (Adrian Knoth)
Date: Tue, 21 Apr 2009 10:35:57 +0000
Subject: Fire V880 hangs at Testing NMI with 2.6.29.1
Message-Id: <20090421103557.GZ15865@ltw.loris.tv>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi!

I have a Sun Fire V880 with eight CPUs, but CPU0 and CPU2 are disabled
due to memory corruption in the corresponding cpu board.

No problems with 2.6.28.9, but booting 2.6.29.1 fails. Last entry I see
in the RSC console:

Brought up 6 CPUs
net_namespace: 1776 bytes
NET: Registered protocol family 16
Testing NMI 

I grep'ed through the kernel source, I guess this line should actually
read "Testing NMI watchdog", but the word "watchdog" is really missing.

I haven't checked 2.6.29, but if need be, I could do.

Here's the log output:

     ERROR: Power On Self Test Failed. Cause: 
CPU0 Bank 1 Dimm 3, J3200 side 1
     ERROR: POST failed.
Rebooting with command: boot
Boot device: disk  File and args: 
SILO Version 1.4.13
boot: broken
Allocated 8 Megs of memory at 0x40000000 for kernel
Loaded kernel version 2.6.29
Loading initial ramdisk (5040244 bytes at 0xD000000000 phys, 0x40C00000 virt)...
\
PROMLIB: Sun IEEE Boot Prom 'OBP 4.17.1 2005/04/11 14:28'
PROMLIB: Root node compatible: 
Linux version 2.6.29.1 (root@fire.inf-ra.uni-jena.de) (gcc version 4.3.3 20090117 (prerelease) (Debian 4.3.2-3) ) #3 SMP Mon Apr 20 17:58:05 CEST 2009
console [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 00:03:ba:2b:c3:e8
Kernel: Using 2 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /pci@9,700000/ebus@1/rsc-console@1,3083f8
PROM: Built device tree with 148670 bytes of memory.
Top of RAM: 0xd1ffb1a000, Total RAM: 0x5ffb0e000
Memory hole size: 835584MB
[0000000360000000-fffff8b000400000] page_structs1072 node=0 entry08/0
[0000000360000000-fffff8b000800000] page_structs1072 node=0 entry09/0
[0000000360800000-fffff8b000c00000] page_structs1072 node=0 entry10/0
[0000000360800000-fffff8b001000000] page_structs1072 node=0 entry11/0
[0000000361000000-fffff8b001400000] page_structs1072 node=0 entry12/0
[0000000361000000-fffff8b001800000] page_structs1072 node=0 entry13/0
[0000000361800000-fffff8b001c00000] page_structs1072 node=0 entry14/0
[0000000361800000-fffff8b002000000] page_structs1072 node=0 entry15/0
[0000000362000000-fffff8b002400000] page_structs1072 node=0 entry16/0
[0000000362000000-fffff8b002800000] page_structs1072 node=0 entry17/0
[0000000362800000-fffff8b002c00000] page_structs1072 node=0 entry18/0
[0000000362800000-fffff8b003000000] page_structs1072 node=0 entry19/0
[0000000363000000-fffff8b003400000] page_structs1072 node=0 entry20/0
[0000000363000000-fffff8b003800000] page_structs1072 node=0 entry21/0
[0000000363800000-fffff8b003c00000] page_structs1072 node=0 entry22/0
[0000000363800000-fffff8b004000000] page_structs1072 node=0 entry23/0
[0000000380000000-fffff8b004400000] page_structs1072 node=0 entry36/0
[0000000380000000-fffff8b004800000] page_structs1072 node=0 entry37/0
[0000000380800000-fffff8b004c00000] page_structs1072 node=0 entry38/0
[0000000380800000-fffff8b005000000] page_structs1072 node=0 entry39/0
[0000000381000000-fffff8b005400000] page_structs1072 node=0 entry40/0
[0000000381000000-fffff8b005800000] page_structs1072 node=0 entry41/0
[0000000381800000-fffff8b005c00000] page_structs1072 node=0 entry42/0
[0000000381800000-fffff8b006000000] page_structs1072 node=0 entry43/0
[0000000382000000-fffff8b006400000] page_structs1072 node=0 entry44/0
[0000000382000000-fffff8b006800000] page_structs1072 node=0 entry45/0
[0000000382800000-fffff8b006c00000] page_structs1072 node=0 entry46/0
[0000000382800000-fffff8b007000000] page_structs1072 node=0 entry47/0
[0000000383000000-fffff8b007400000] page_structs1072 node=0 entry48/0
[0000000383000000-fffff8b007800000] page_structs1072 node=0 entry49/0
[0000000383800000-fffff8b007c00000] page_structs1072 node=0 entry50/0
[0000000383800000-fffff8b008000000] page_structs1072 node=0 entry51/0
[00000003a0000000-fffff8b008400000] page_structs1072 node=0 entry64/0
[00000003a0000000-fffff8b008800000] page_structs1072 node=0 entry65/0
[00000003a0800000-fffff8b008c00000] page_structs1072 node=0 entry66/0
[00000003a0800000-fffff8b009000000] page_structs1072 node=0 entry67/0
[00000003a1000000-fffff8b009400000] page_structs1072 node=0 entry68/0
[00000003a1000000-fffff8b009800000] page_structs1072 node=0 entry69/0
[00000003a1800000-fffff8b009c00000] page_structs1072 node=0 entry70/0
[00000003a1800000-fffff8b00a000000] page_structs1072 node=0 entry71/0
[00000003a2000000-fffff8b00a400000] page_structs1072 node=0 entry72/0
[00000003a2000000-fffff8b00a800000] page_structs1072 node=0 entry73/0
[00000003a2800000-fffff8b00ac00000] page_structs1072 node=0 entry74/0
[00000003a2800000-fffff8b00b000000] page_structs1072 node=0 entry75/0
[00000003a3000000-fffff8b00b400000] page_structs1072 node=0 entry76/0
[00000003a3000000-fffff8b00b800000] page_structs1072 node=0 entry77/0
[00000003a3800000-fffff8b00bc00000] page_structs1072 node=0 entry78/0
[00000003a3800000-fffff8b00c000000] page_structs1072 node=0 entry79/0
Zone PFN ranges:
  Normal   0x05800000 -> 0x068ffd8d
Movable zone start PFN for each node
early_node_map[6] active PFN ranges
    0: 0x05800000 -> 0x05900000
    0: 0x06000000 -> 0x06100000
    0: 0x06800000 -> 0x068ff7ff
    0: 0x068ff800 -> 0x068ffd0a
    0: 0x068ffd0c -> 0x068ffd7b
    0: 0x068ffd7e -> 0x068ffd8d
Booting Linux...
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 3005835
Kernel command line: root=/dev/sda1 console=ttyS0
PID hash table entries: 4096 (order: 12, 32768 bytes)
clocksource: mult[640000] shift[16]
clockevent: mult[28f5c28] shift[32]
Console: colour dummy device 80x25
Dentry cache hash table entries: 4194304 (order: 12, 33554432 bytes)
Inode-cache hash table entries: 2097152 (order: 11, 16777216 bytes)
Memory: 24901376k available (2992k kernel code, 1384k data, 208k init) [fffff80000000000,000000d1ffb1a000]
Calibrating delay using timer specific routine.. 20.04 BogoMIPS (lpj021)
Mount-cache hash table entries: 512
CPU 1: synchronized TICK with master CPU (last diff 0 cycles, maxerr 11 cycles)
CPU 4: synchronized TICK with master CPU (last diff 0 cycles, maxerr 11 cycles)
CPU 5: synchronized TICK with master CPU (last diff 0 cycles, maxerr 11 cycles)
CPU 6: synchronized TICK with master CPU (last diff 0 cycles, maxerr 11 cycles)
CPU 7: synchronized TICK with master CPU (last diff 0 cycles, maxerr 11 cycles)
Brought up 6 CPUs
net_namespace: 1776 bytes
NET: Registered protocol family 16
Testing NMI 


Cheerio

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
