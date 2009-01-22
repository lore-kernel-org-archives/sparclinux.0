From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Thu, 22 Jan 2009 13:29:34 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090122132934.GB598@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
To: sparclinux@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 19, 2009 at 10:25:14PM -0800, David Miller wrote:

>  ...
> > [   50.390759] CPU 0: synchronized TICK with master CPU (last diff 0 cycles, maxerr 11 cycles)
> > [   50.390776] Brought up 2 CPUs
> > [   50.391634] net_namespace: 1552 bytes
> > [   50.568542] NET: Registered protocol family 16
> > 
> 
> The next thing that probably should run is the PCI controller
> probe.  But I can't say that for certain, so we need more
> info.
> 
> Please reboot this test kernel with the following added boot
> command line options: initcall_debug=1 ignore_loglevel

Compiled 2.6.27.12 today without the CON_BOOT flag and booted with the
options above. The hang seems to be in of_bus_driver_init, see
console output below.

Hope this helps advancing towards the cassini stuff. Thanks.


-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="480R.console"

ERROR: OpenBoot Diagnostics failed
WARNING: Device /pci@8,600000/SUNW,qlc@2 being marked with 'status' == fail
Rebooting with command: boot
Boot device: disk  File and args:
SILO Version 1.4.13
boot: boot:
Linux                    27.x                     LinuxOLD
boot: 27.x
Allocated 8 Megs of memory at 0x40000000 for kernel
Loaded kernel version 2.6.27
Loading initial ramdisk (5350711 bytes at 0xA000400000 phys, 0x40C00000 virt)...
\
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.34 2007/07/23 13:01'
[    0.000000] PROMLIB: Root node compatible:
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.27.12 (hlauer@install1) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #2 SMP Thu Jan 22 14:28:41 CET 2009
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:08:d9:24
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@9,700000/ebus@1/serial@1,400000:a
[    0.000000] PROM: Built device tree with 102802 bytes of memory.
[    0.000000] Top of RAM: 0xa1ffb1a000, Total RAM: 0x1ffb0e000
[    0.000000] Memory hole size: 655360MB
[    0.000000] [0000000318000000-fffff8a000c00000] page_structs=131072 node=0 entry=1120/0
[    0.000000] [0000000318000000-fffff8a001000000] page_structs=131072 node=0 entry=1121/0
[    0.000000] [0000000318700000-fffff8a001400000] page_structs=131072 node=0 entry=1122/0
[    0.000000] [0000000318700000-fffff8a001800000] page_structs=131072 node=0 entry=1123/0
[    0.000000] [0000000318e00000-fffff8a001c00000] page_structs=131072 node=0 entry=1124/0
[    0.000000] [0000000318e00000-fffff8a002000000] page_structs=131072 node=0 entry=1125/0
[    0.000000] [0000000319500000-fffff8a002400000] page_structs=131072 node=0 entry=1126/0
[    0.000000] [0000000319c00000-fffff8a002800000] page_structs=131072 node=0 entry=1127/0
[    0.000000] [0000000319c00000-fffff8a002c00000] page_structs=131072 node=0 entry=1128/0
[    0.000000] [000000031a300000-fffff8a003000000] page_structs=131072 node=0 entry=1129/0
[    0.000000] [000000031a300000-fffff8a003400000] page_structs=131072 node=0 entry=1130/0
[    0.000000] [000000031aa00000-fffff8a003800000] page_structs=131072 node=0 entry=1131/0
[    0.000000] [000000031aa00000-fffff8a003c00000] page_structs=131072 node=0 entry=1132/0
[    0.000000] [000000031b100000-fffff8a004000000] page_structs=131072 node=0 entry=1133/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x05000000 -> 0x050ffd8d
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 0x05000000 -> 0x050ff7ff
[    0.000000]     0: 0x050ff800 -> 0x050ffd09
[    0.000000]     0: 0x050ffd0b -> 0x050ffd7b
[    0.000000]     0: 0x050ffd7e -> 0x050ffd8d
[    0.000000] On node 0 totalpages: 1047943
[    0.000000]   Normal zone: 1040779 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1040779
[    0.000000] Kernel command line: root=/dev/sda1 ro initcall_debug=1 ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[640000] shift[16]
[    0.000000] clockevent: mult[28f5c28] shift[32]
[   45.627252] Console: colour dummy device 80x25
[   45.680346] console [tty0] enabled
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.34 2007/07/23 13:01'
[    0.000000] PROMLIB: Root node compatible:
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.27.12 (hlauer@install1) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #2 SMP Thu Jan 22 14:28:41 CET 2009
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:08:d9:24
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@9,700000/ebus@1/serial@1,400000:a
[    0.000000] PROM: Built device tree with 102802 bytes of memory.
[    0.000000] Top of RAM: 0xa1ffb1a000, Total RAM: 0x1ffb0e000
[    0.000000] Memory hole size: 655360MB
[    0.000000] [0000000318000000-fffff8a000c00000] page_structs=131072 node=0 entry=1120/0
[    0.000000] [0000000318000000-fffff8a001000000] page_structs=131072 node=0 entry=1121/0
[    0.000000] [0000000318700000-fffff8a001400000] page_structs=131072 node=0 entry=1122/0
[    0.000000] [0000000318700000-fffff8a001800000] page_structs=131072 node=0 entry=1123/0
[    0.000000] [0000000318e00000-fffff8a001c00000] page_structs=131072 node=0 entry=1124/0
[    0.000000] [0000000318e00000-fffff8a002000000] page_structs=131072 node=0 entry=1125/0
[    0.000000] [0000000319500000-fffff8a002400000] page_structs=131072 node=0 entry=1126/0
[    0.000000] [0000000319c00000-fffff8a002800000] page_structs=131072 node=0 entry=1127/0
[    0.000000] [0000000319c00000-fffff8a002c00000] page_structs=131072 node=0 entry=1128/0
[    0.000000] [000000031a300000-fffff8a003000000] page_structs=131072 node=0 entry=1129/0
[    0.000000] [000000031a300000-fffff8a003400000] page_structs=131072 node=0 entry=1130/0
[    0.000000] [000000031aa00000-fffff8a003800000] page_structs=131072 node=0 entry=1131/0
[    0.000000] [000000031aa00000-fffff8a003c00000] page_structs=131072 node=0 entry=1132/0
[    0.000000] [000000031b100000-fffff8a004000000] page_structs=131072 node=0 entry=1133/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x05000000 -> 0x050ffd8d
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 0x05000000 -> 0x050ff7ff
[    0.000000]     0: 0x050ff800 -> 0x050ffd09
[    0.000000]     0: 0x050ffd0b -> 0x050ffd7b
[    0.000000]     0: 0x050ffd7e -> 0x050ffd8d
[    0.000000] On node 0 totalpages: 1047943
[    0.000000]   Normal zone: 1040779 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1040779
[    0.000000] Kernel command line: root=/dev/sda1 ro initcall_debug=1 ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[640000] shift[16]
[    0.000000] clockevent: mult[28f5c28] shift[32]
[   45.627252] Console: colour dummy device 80x25
[   45.680346] console [tty0] enabled
[   49.037535] Dentry cache hash table entries: 1048576 (order: 10, 8388608 bytes)
[   49.142619] Inode-cache hash table entries: 524288 (order: 9, 4194304 bytes)
[   49.502995] Memory: 8301680k available (2928k kernel code, 1104k data, 208k init) [fffff80000000000,000000a1ffb1a000]
[   49.707978] Calibrating delay using timer specific routine.. 19.90 BogoMIPS (lpj=39810)
[   49.802194] Security Framework initialized
[   49.851001] SELinux:  Disabled at boot.
[   49.896870] Mount-cache hash table entries: 512
[   49.951499] Initializing cgroup subsys ns
[   49.998912] Initializing cgroup subsys cpuacct
[   50.052031] Initializing cgroup subsys devices
[   50.105342] calling  migration_init+0x0/0x6c
[   50.156316] initcall migration_init+0x0/0x6c returned 1 after 0 msecs
[   50.233290] initcall migration_init+0x0/0x6c returned with error code 1
[   50.313498] calling  spawn_ksoftirqd+0x0/0x64
[   50.365654] initcall spawn_ksoftirqd+0x0/0x64 returned 0 after 0 msecs
[   50.443717] calling  init_call_single_data+0x0/0x68
[   50.502047] initcall init_call_single_data+0x0/0x68 returned 0 after 0 msecs
[   50.586426] calling  spawn_softlockup_task+0x0/0x8c
[   50.644826] initcall spawn_softlockup_task+0x0/0x8c returned 0 after 0 msecs
[   50.729141] calling  relay_init+0x0/0x8
[   50.774973] initcall relay_init+0x0/0x8 returned 0 after 0 msecs
[   50.848299] CPU 0: synchronized TICK with master CPU (last diff -1 cycles, maxerr 11 cycles)
[   50.848316] Brought up 2 CPUs
[   50.848351] CPU0 attaching sched-domain:
[   50.848360]  domain 0: span 0,2 level CPU
[   50.848368]   groups: 0 2
[   50.848380] CPU2 attaching sched-domain:
[   50.848386]  domain 0: span 0,2 level CPU
[   50.848391]   groups: 2 0
[   50.849193] calling  net_ns_init+0x0/0x1a4
[   50.849200] net_namespace: 1552 bytes
[   50.849213] initcall net_ns_init+0x0/0x1a4 returned 0 after 0 msecs
[   50.849231] calling  sparc_globreg_init+0x0/0x1c
[   50.849243] initcall sparc_globreg_init+0x0/0x1c returned 0 after 0 msecs
[   50.849251] calling  sysctl_init+0x0/0x2c
[   50.849663] initcall sysctl_init+0x0/0x2c returned 0 after 0 msecs
[   50.849672] calling  ksysfs_init+0x0/0xc8
[   50.849695] initcall ksysfs_init+0x0/0xc8 returned 0 after 0 msecs
[   50.849704] calling  init_jiffies_clocksource+0x0/0x18
[   50.849716] initcall init_jiffies_clocksource+0x0/0x18 returned 0 after 0 msecs
[   50.849729] calling  filelock_init+0x0/0x38
[   51.982874] initcall filelock_init+0x0/0x38 returned 0 after 1091 msecs
[   52.061688] calling  init_script_binfmt+0x0/0x18
[   52.116898] initcall init_script_binfmt+0x0/0x18 returned 0 after 0 msecs
[   52.198149] calling  init_elf_binfmt+0x0/0x18
[   52.250234] initcall init_elf_binfmt+0x0/0x18 returned 0 after 0 msecs
[   52.328362] calling  init_compat_elf_binfmt+0x0/0x18
[   52.387740] initcall init_compat_elf_binfmt+0x0/0x18 returned 0 after 0 msecs
[   52.473158] calling  debugfs_init+0x0/0x58
[   52.522128] initcall debugfs_init+0x0/0x58 returned 0 after 0 msecs
[   52.597121] calling  securityfs_init+0x0/0x58
[   52.649213] initcall securityfs_init+0x0/0x58 returned 0 after 0 msecs
[   52.727334] calling  random32_init+0x0/0xf0
[   52.777338] initcall random32_init+0x0/0xf0 returned 0 after 0 msecs
[   52.853380] calling  sock_init+0x0/0x64
[   52.899320] initcall sock_init+0x0/0x64 returned 0 after 0 msecs
[   52.971096] calling  netpoll_init+0x0/0x30
[   53.020053] initcall netpoll_init+0x0/0x30 returned 0 after 0 msecs
[   53.095056] calling  netlink_proto_init+0x0/0x238
[   53.151334] NET: Registered protocol family 16
[   53.204465] initcall netlink_proto_init+0x0/0x238 returned 0 after 3 msecs
[   53.286733] calling  of_bus_driver_init+0x0/0xa0

--MGYHOYXEY6WxJCY8--
