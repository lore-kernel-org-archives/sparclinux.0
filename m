From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Fri, 19 Dec 2008 08:56:22 +0000
Subject: Sunfire V880 and 480R 2.6.27.x startup hangs [Was: Re: kernel crashes on Sun Fire 480R with cassini
Message-Id: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Dec 17, 2008 at 07:46:46PM -0800, David Miller wrote:
> > tried 2.6.27.2 today, but this hangs already at loading the kernel.
> > Output is attached. Please tell me what else I can provide.
> 
> Unfortunately, "-p" doesn't do anything any more and the kernel
> is stopping or crashing during the part of the boot between
> when the early prom console is disabled and the real console is
> setup.
> 
> The way to debug this is to manually get rid of the CON_BOOT flag
> in the early prom console structure, like the following patch.

Applied your patch to the 2.6.27.9 vanilla source and booted,
console output up to the hang is below. Just to remember:
2.6.26.5 did not hang.

-------------------------------------------------------------------
Sun Fire 880, No Keyboard
Copyright 2007 Sun Microsystems, Inc.  All rights reserved.
OpenBoot 4.22.34, 8192 MB memory installed, Serial #50911524.
Ethernet address 0:3:ba:8:d9:24, Host ID: 8308d924.

ERROR: OpenBoot Diagnostics failed
WARNING: Device /pci@8,600000/SUNW,qlc@2 being marked with 'status' = fail
Rebooting with command: boot
Boot device: disk  File and args:
SILO Version 1.4.13
boot:
Linux                    27.9                     LinuxOLD
boot: 27.9
Allocated 8 Megs of memory at 0x40000000 for kernel
Loaded kernel version 2.6.27
Loading initial ramdisk (5350711 bytes at 0xA000400000 phys, 0x40C00000 virt)...
\
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.34 2007/07/23 13:01'
[    0.000000] PROMLIB: Root node compatible:
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.27.9 (hlauer@install1) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 SMP Thu Dec 18 17:20:27 CET 2008
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:08:d9:24
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@9,700000/ebus@1/serial@1,400000:a
[    0.000000] PROM: Built device tree with 102802 bytes of memory.
[    0.000000] Top of RAM: 0xa1ffb1a000, Total RAM: 0x1ffb0e000
[    0.000000] Memory hole size: 655360MB
[    0.000000] [0000000318000000-fffff8a000c00000] page_structs1072 node=0 entry20/0
[    0.000000] [0000000318000000-fffff8a001000000] page_structs1072 node=0 entry21/0
[    0.000000] [0000000318700000-fffff8a001400000] page_structs1072 node=0 entry22/0
[    0.000000] [0000000318700000-fffff8a001800000] page_structs1072 node=0 entry23/0
[    0.000000] [0000000318e00000-fffff8a001c00000] page_structs1072 node=0 entry24/0
[    0.000000] [0000000318e00000-fffff8a002000000] page_structs1072 node=0 entry25/0
[    0.000000] [0000000319500000-fffff8a002400000] page_structs1072 node=0 entry26/0
[    0.000000] [0000000319c00000-fffff8a002800000] page_structs1072 node=0 entry27/0
[    0.000000] [0000000319c00000-fffff8a002c00000] page_structs1072 node=0 entry28/0
[    0.000000] [000000031a300000-fffff8a003000000] page_structs1072 node=0 entry29/0
[    0.000000] [000000031a300000-fffff8a003400000] page_structs1072 node=0 entry30/0
[    0.000000] [000000031aa00000-fffff8a003800000] page_structs1072 node=0 entry31/0
[    0.000000] [000000031aa00000-fffff8a003c00000] page_structs1072 node=0 entry32/0
[    0.000000] [000000031b100000-fffff8a004000000] page_structs1072 node=0 entry33/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x05000000 -> 0x050ffd8d
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 0x05000000 -> 0x050ff7ff
[    0.000000]     0: 0x050ff800 -> 0x050ffd09
[    0.000000]     0: 0x050ffd0b -> 0x050ffd7b
[    0.000000]     0: 0x050ffd7e -> 0x050ffd8d
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1040779
[    0.000000] Kernel command line: root=/dev/sda1 ro
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[640000] shift[16]
[    0.000000] clockevent: mult[28f5c28] shift[32]
[   46.108402] Console: colour dummy device 80x25
[   46.161498] console [tty0] enabled
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.34 2007/07/23 13:01'
[    0.000000] PROMLIB: Root node compatible:
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.27.9 (hlauer@install1) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 SMP Thu Dec 18 17:20:27 CET 2008
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:08:d9:24
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@9,700000/ebus@1/serial@1,400000:a
[    0.000000] PROM: Built device tree with 102802 bytes of memory.
[    0.000000] Top of RAM: 0xa1ffb1a000, Total RAM: 0x1ffb0e000
[    0.000000] Memory hole size: 655360MB
[    0.000000] [0000000318000000-fffff8a000c00000] page_structs1072 node=0 entry20/0
[    0.000000] [0000000318000000-fffff8a001000000] page_structs1072 node=0 entry21/0
[    0.000000] [0000000318700000-fffff8a001400000] page_structs1072 node=0 entry22/0
[    0.000000] [0000000318700000-fffff8a001800000] page_structs1072 node=0 entry23/0
[    0.000000] [0000000318e00000-fffff8a001c00000] page_structs1072 node=0 entry24/0
[    0.000000] [0000000318e00000-fffff8a002000000] page_structs1072 node=0 entry25/0
[    0.000000] [0000000319500000-fffff8a002400000] page_structs1072 node=0 entry26/0
[    0.000000] [0000000319c00000-fffff8a002800000] page_structs1072 node=0 entry27/0
[    0.000000] [0000000319c00000-fffff8a002c00000] page_structs1072 node=0 entry28/0
[    0.000000] [000000031a300000-fffff8a003000000] page_structs1072 node=0 entry29/0
[    0.000000] [000000031a300000-fffff8a003400000] page_structs1072 node=0 entry30/0
[    0.000000] [000000031aa00000-fffff8a003800000] page_structs1072 node=0 entry31/0
[    0.000000] [000000031aa00000-fffff8a003c00000] page_structs1072 node=0 entry32/0
[    0.000000] [000000031b100000-fffff8a004000000] page_structs1072 node=0 entry33/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x05000000 -> 0x050ffd8d
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 0x05000000 -> 0x050ff7ff
[    0.000000]     0: 0x050ff800 -> 0x050ffd09
[    0.000000]     0: 0x050ffd0b -> 0x050ffd7b
[    0.000000]     0: 0x050ffd7e -> 0x050ffd8d
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1040779
[    0.000000] Kernel command line: root=/dev/sda1 ro
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[640000] shift[16]
[    0.000000] clockevent: mult[28f5c28] shift[32]
[   46.108402] Console: colour dummy device 80x25
[   46.161498] console [tty0] enabled
[   49.320774] Dentry cache hash table entries: 1048576 (order: 10, 8388608 bytes)
[   49.426009] Inode-cache hash table entries: 524288 (order: 9, 4194304 bytes)
[   49.786779] Memory: 8301680k available (2928k kernel code, 1104k data, 208k init) [fffff80000000000,000000a1ffb1a000]
[   49.991734] Calibrating delay using timer specific routine.. 19.90 BogoMIPS (lpj9810)
[   50.085944] Security Framework initialized
[   50.134751] SELinux:  Disabled at boot.
[   50.180620] Mount-cache hash table entries: 512
[   50.235257] Initializing cgroup subsys ns
[   50.282662] Initializing cgroup subsys cpuacct
[   50.335781] Initializing cgroup subsys devices
[   50.390759] CPU 0: synchronized TICK with master CPU (last diff 0 cycles, maxerr 11 cycles)
[   50.390776] Brought up 2 CPUs
[   50.391634] net_namespace: 1552 bytes
[   50.568542] NET: Registered protocol family 16

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
