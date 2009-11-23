From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Mon, 23 Nov 2009 21:11:27 +0000
Subject: Re: Sparc release requalification
Message-Id: <20091123211127.GB25948@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Nov 23, 2009 at 12:24:46PM -0800, David Miller wrote:
> As promised long ago, here is a 2.6.31.6 kernel built with you
> 2.6.31 config file.  Let me know if it exhibits the bootup problem
> so we can diagnose further:
> 
> 	http://vger.kernel.org/~davem/josip_test_2631_6.img

Tested on my SunFire480, output until hang is attached.
Greetings
  Hermann

Rebooting with command: boot gem:dhcp
Boot device: /pci@8,600000/network@2:dhcp  File and args: 
Timed out waiting for BOOTP/DHCP reply
Timed out waiting for BOOTP/DHCP reply
Timed out waiting for BOOTP/DHCP reply
\
PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.34 2007/07/23 13:01'
PROMLIB: Root node compatible: 
Linux version 2.6.31.6 (davem@huronp11) (gcc version 4.2.4 (Ubuntu 4.2.4-1ubuntu3)) #2 SMP Mon Nov 23 12:18:05 PST 2009
console [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 00:03:ba:29:7c:9f
Kernel: Using 1 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /pci@9,700000/ebus@1/rsc-console@1,3083f8
PROM: Built device tree with 104327 bytes of memory.
Top of RAM: 0xa3ffb22000, Total RAM: 0x3ffad6000
Memory hole size: 655360MB
[0000000340000000-fffff8a000800000] page_structs1072 node=0 entry80/0
[0000000340000000-fffff8a000c00000] page_structs1072 node=0 entry81/0
[0000000340800000-fffff8a001000000] page_structs1072 node=0 entry82/0
[0000000340800000-fffff8a001400000] page_structs1072 node=0 entry83/0
[0000000341000000-fffff8a001800000] page_structs1072 node=0 entry84/0
[0000000341000000-fffff8a001c00000] page_structs1072 node=0 entry85/0
[0000000341800000-fffff8a002000000] page_structs1072 node=0 entry86/0
[0000000341800000-fffff8a002400000] page_structs1072 node=0 entry87/0
[0000000342000000-fffff8a002800000] page_structs1072 node=0 entry88/0
[0000000342000000-fffff8a002c00000] page_structs1072 node=0 entry89/0
[0000000342800000-fffff8a003000000] page_structs1072 node=0 entry90/0
[0000000342800000-fffff8a003400000] page_structs1072 node=0 entry91/0
[0000000343000000-fffff8a003800000] page_structs1072 node=0 entry92/0
[0000000343000000-fffff8a003c00000] page_structs1072 node=0 entry93/0
[0000000343800000-fffff8a004000000] page_structs1072 node=0 entry94/0
[0000000343800000-fffff8a004400000] page_structs1072 node=0 entry95/0
[0000000344000000-fffff8a004800000] page_structs1072 node=0 entry96/0
[0000000344000000-fffff8a004c00000] page_structs1072 node=0 entry97/0
[0000000344800000-fffff8a005000000] page_structs1072 node=0 entry98/0
[0000000344800000-fffff8a005400000] page_structs1072 node=0 entry99/0
[0000000345000000-fffff8a005800000] page_structs1072 node=0 entry00/0
[0000000345000000-fffff8a005c00000] page_structs1072 node=0 entry01/0
[0000000345800000-fffff8a006000000] page_structs1072 node=0 entry02/0
[0000000345800000-fffff8a006400000] page_structs1072 node=0 entry03/0
[0000000346000000-fffff8a006800000] page_structs1072 node=0 entry04/0
[0000000346000000-fffff8a006c00000] page_structs1072 node=0 entry05/0
[0000000346800000-fffff8a007000000] page_structs1072 node=0 entry06/0
[0000000346800000-fffff8a007400000] page_structs1072 node=0 entry07/0
[0000000347000000-fffff8a007800000] page_structs1072 node=0 entry08/0
[0000000347000000-fffff8a007c00000] page_structs1072 node=0 entry09/0
[0000000347800000-fffff8a008000000] page_structs1072 node=0 entry10/0
[0000000347800000-fffff8a008400000] page_structs1072 node=0 entry11/0
Zone PFN ranges:
  Normal   0x05000000 -> 0x051ffd91
Movable zone start PFN for each node
early_node_map[4] active PFN ranges
    0: 0x05000000 -> 0x051ff7ff
    0: 0x051ff800 -> 0x051ffd5c
    0: 0x051ffd80 -> 0x051ffd8f
    0: 0x051ffd90 -> 0x051ffd91
Booting Linux...
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2080111
Kernel command line: 
PID hash table entries: 4096 (order: 12, 32768 bytes)
Dentry cache hash table entries: 2097152 (order: 11, 16777216 bytes)
Inode-cache hash table entries: 1048576 (order: 10, 8388608 bytes)
Memory: 16610992k available (2488k kernel code, 936k data, 192k init) [fffff80000000000,000000a3ffb22000]
NR_IRQS:255
clocksource: mult[640000] shift[16]
clockevent: mult[28f5c28] shift[32]

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
