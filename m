From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Mon, 18 May 2009 12:45:04 +0000
Subject: Sunfire V880 and 480R 2.6.27x-2.6.29.3 startup hangs
Message-Id: <20090518124504.GA22849@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 05, 2009 at 04:39:18PM +0100, Hermann Lauer wrote:
> On Thu, Mar 05, 2009 at 12:04:17AM -0800, David Miller wrote:
> > 
> > So kernel_thread() is where it hangs...
> > 
> > The only big thing changing in sparc64 between 2.6.26.5 (which works)
> > and 2.6.27 are IRQ stacks.
> > 
> > Here is a test patch which reverts sparc64 IRQ stacks.  If this makes
> > your machine work it will be a big clue.
> 
> Applied your patch to 2.6.27.19 - hangs at the same point. Output
> is on the web.

Tried 2.6.29.3 today on the SunFire V880 - seems to hang at the same point.
Output is attached. The debug patches for the 2.6.27.x series did not apply
cleanly any more, so I'd like to ask if I can get new debugging patches.

Or are there any other ideas now ?

Thanks,
  Hermann 

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="console20090518.txt"

boot: 29.x
Allocated 8 Megs of memory at 0x40000000 for kernel
Loaded kernel version 2.6.29
Loading initial ramdisk (5350676 bytes at 0xA000400000 phys, 0x40C00000 virt)...
\
PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.34 2007/07/23 13:01'
PROMLIB: Root node compatible: 
Linux version 2.6.29.3 (hlauer@install1) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #2 SMP Mon May 18 13:58:14 CEST 2009
console [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 00:03:ba:08:d9:24
Kernel: Using 2 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /pci@9,700000/ebus@1/serial@1,400000:a
PROM: Built device tree with 102794 bytes of memory.
Top of RAM: 0xa0ffb1a000, Total RAM: 0xffb0e000
Memory hole size: 655360MB
[0000000340000000-fffff8a000c00000] page_structs=131072 node=0 entry=1280/0
[0000000340000000-fffff8a001000000] page_structs=131072 node=0 entry=1281/0
[0000000340800000-fffff8a001400000] page_structs=131072 node=0 entry=1282/0
[0000000340800000-fffff8a001800000] page_structs=131072 node=0 entry=1283/0
[0000000341000000-fffff8a001c00000] page_structs=131072 node=0 entry=1284/0
[0000000341000000-fffff8a002000000] page_structs=131072 node=0 entry=1285/0
[0000000341800000-fffff8a002400000] page_structs=131072 node=0 entry=1286/0
[0000000341800000-fffff8a002800000] page_structs=131072 node=0 entry=1287/0
Zone PFN ranges:
  Normal   0x05000000 -> 0x0507fd8d
Movable zone start PFN for each node
early_node_map[4] active PFN ranges
    0: 0x05000000 -> 0x0507f7ff
    0: 0x0507f800 -> 0x0507fd09
    0: 0x0507fd0b -> 0x0507fd7b
    0: 0x0507fd7e -> 0x0507fd8d
Booting Linux...
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 519563
Kernel command line: root=/dev/sda1 ro console=ttyS0
PID hash table entries: 4096 (order: 12, 32768 bytes)
clocksource: mult[640000] shift[16]
clockevent: mult[28f5c28] shift[32]
Console: colour dummy device 80x25
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Memory: 4136712k available (2968k kernel code, 1400k data, 208k init) [fffff80000000000,000000a0ffb1a000]
Calibrating delay using timer specific routine.. 20.05 BogoMIPS (lpj=10026)
Mount-cache hash table entries: 512
CPU 0: synchronized TICK with master CPU (last diff 0 cycles, maxerr 11 cycles)
Brought up 2 CPUs
net_namespace: 1776 bytes
NET: Registered protocol family 16

--W/nzBZO5zC0uMSeA--
