From: seb@frankengul.org
Date: Wed, 08 Apr 2009 21:36:20 +0000
Subject: Re: SunFire V240 hangs
Message-Id: <20090408213620.GC1142@frankengul.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="rJwd6BRFiFCcLxzm"
List-Id: <sparclinux.vger.kernel.org>
References: <20090408200711.GA1142@frankengul.org>
In-Reply-To: <20090408200711.GA1142@frankengul.org>
To: sparclinux@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 08, 2009 at 11:29:50PM +0200, Sam Ravnborg wrote:
> [snip]
> Looked a bit closer - and it is obviously not the same.
> But I found another thread where Hermann Lauer had a similar problem.
> 
> David asked:
> =================
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
> 
> Let us see the console log output that generates.
> ================
> 
> But reading further in that thread did not result in any
> solution..
> 
> Try to google for "Sunfire V880 and 480R 2.6.27.x startup hangs"
> 
> 
> 	Sam

Ok, here's the log. It hangs in the middle of an output.

--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="boot2.log"

Rebooting with command: boot                                          
Boot device: disk1  File and args: 
SILO Version 1.4.14
boot: Linu
Fatal error: 
Default partition could not be found
boot: Linux
Fatal error: 
Default partition could not be found
boot:      
Linux                    LinuxOLD                 Linux-rescue             
LinuxOLD-rescue          Linux2628                
boot: LinuxOLD-rescue initcall_debug=1 ignore_loglevel
Allocated 64 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 2.6.29
Loading initial ramdisk (8158130 bytes at 0x103F000000 phys, 0x40C00000 virt)...
\
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.33 2007/06/18 12:45'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.29.1 (seb@raptor2) (gcc version 4.3.3 (Ubuntu 4.3.3-5ubuntu4) ) #4 SMP Wed Apr 8 21:49:56 CEST 2009
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:83:9d:e5
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1e,600000/isa@7/serial@0,3f8
[    0.000000] PROM: Built device tree with 90020 bytes of memory.
[    0.000000] [0000000200000000-fffff80000400000] page_structs=131072 node=0 entry=0/0
[    0.000000] [0000000200000000-fffff80000800000] page_structs=131072 node=0 entry=1/0
[    0.000000] [0000000204000000-fffff80000c00000] page_structs=131072 node=0 entry=16/0
[    0.000000] [0000000204000000-fffff80001000000] page_structs=131072 node=0 entry=17/0
[    0.000000] [0000000206000000-fffff80001400000] page_structs=131072 node=0 entry=24/0
[    0.000000] [0000000206000000-fffff80001800000] page_structs=131072 node=0 entry=25/0
[    0.000000] [0000000220000000-fffff81000800000] page_structs=131072 node=1 entry=128/0
[    0.000000] [0000000220000000-fffff81000c00000] page_structs=131072 node=1 entry=129/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x0081ff74
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[8] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00020000
[    0.000000]     0: 0x00100000 -> 0x00120000
[    0.000000]     0: 0x00180000 -> 0x001a0000
[    0.000000]     1: 0x00800000 -> 0x0081f7ff
[    0.000000]     1: 0x0081f800 -> 0x0081ff30
[    0.000000]     1: 0x0081ff38 -> 0x0081ff40
[    0.000000]     1: 0x0081ff48 -> 0x0081ff49
[    0.000000]     1: 0x0081ff70 -> 0x0081ff74
[    0.000000] On node 0 totalpages: 393216
[    0.000000]   Normal zone: 13312 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 379904 pages, LIFO batch:15
[    0.000000] On node 1 totalpages: 130876
[    0.000000]   Normal zone: 1023 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 129853 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 509757
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: root=/dev/mapper/vgsys-root ro single initcall_debug=1 ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[535555] shift[16]
[    0.000000] clockevent: mult[3126e97] shift[32]
[   57.420319] Console: colour dummy device 80x25
[   57.478730] console [tty0] enabled
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.33 2007/06/18 12:45'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.29.1 (seb@raptor2) (gcc version 4.3.3 (Ubuntu 4.3.3-5ubuntu4) ) #4 SMP Wed Apr 8 21:49:56 CEST 2009
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:83:9d:e5
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1e,600000/isa@7/serial@0,3f8
[    0.000000] PROM: Built device tree with 90020 bytes of memory.
[    0.000000] [0000000200000000-fffff80000400000] page_structs=131072 node=0 entry=0/0
[    0.000000] [0000000200000000-fffff80000800000] page_structs=131072 node=0 entry=1/0
[    0.000000] [0000000204000000-fffff80000c00000] page_structs=131072 node=0 entry=16/0
[    0.000000] [0000000204000000-fffff80001000000] page_structs=131072 node=0 entry=17/0
[    0.000000] [0000000206000000-fffff80001400000] page_structs=131072 node=0 entry=24/0
[    0.000000] [0000000206000000-fffff80001800000] page_structs=131072 node=0 entry=25/0
[    0.000000] [0000000220000000-fffff81000800000] page_structs=131072 node=1 entry=128/0
[    0.000000] [0000000220000000-fffff81000c00000] page_structs=131072 node=1 entry=129/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x0081ff74
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[8] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00020000
[    0.000000]     0: 0x00100000 -> 0x00120000
[    0.000000]     0: 0x00180000 -> 0x001a0000
[    0.000000]     1: 0x00800000 -> 0x0081f7ff
[    0.000000]     1: 0x0081f800 -> 0x0081ff30
[    0.000000]     1: 0x0081ff38 -> 0x0081ff40
[    0.000000]     1: 0x0081ff48 -> 0x0081ff49
[    0.000000]     1: 0x0081ff70 -> 0x0081ff74
[    0.000000] On node 0 totalpages: 393216
[    0.000000]   Normal zone: 13312 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 379904 pages, LIFO batch:15
[    0.000000] On node 1 totalpages: 130876
[    0.000000]   Normal zone: 1023 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 129853 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 509757
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: root=/dev/mapper/vgsys-root ro single initcall_debug=1 ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[535555] shift[16]
[    0.000000] clockevent: mult[3126e97] shift[32]
[   57.420319] Console: colour dummy device 80x25
[   57.478730] console [tty0] enabled
[   61.004403] Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
[   61.117276] Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
[   61.369136] Memory: 4131160k available (3456k kernel code, 1552k data, 208k init) [fffff80000000000,000000103fee8000]
[   61.509120] SLUB: Genslabs=14, HWalign=32, Order=0-3, MinObjects=0, CPUs=2, Nodes=16
[   61.691001] Calibrating delay using timer specific routine.. 24.01 BogoMIPS (lpj=48021)
[   61.796354] Security Framework initialized
[   61.850142] SELinux:  Disabled at boot.
[   61.900519] Mount-cache hash table entries: 512
[   61.960598] Initializing cgroup subsys ns
[   62.013273] Initializing cgroup subsys devices
[   62.071595] Initializing cgroup subsys freezer
[   62.129923] Initializing cgroup subsys net_cls
[   62.188427] calling  migration_init+0x0/0x6c @ 1
[   62.249157] initcall migration_init+0x0/0x6c returned 1 after 0 usecs
[   62.333823] initcall migration_init+0x0/0x6c returned with error code 1 
[   62.421888] calling  spawn_ksoftirqd+0x0/0x64 @ 1
[   62.483705] initcall spawn_ksoftirqd+0x0/0x64 returned 0 after 0 usecs
[   62.569537] calling  init_call_single_data+0x0/0xe4 @ 1
[   62.638155] initcall init_call_single_data+0x0/0xe4 returned 0 after 0 usecs
[   62.730799] calling  spawn_softlockup_task+0x0/0x94 @ 1
[   62.799470] initcall spawn_softlockup_task+0x0/0x94 returned 0 after 0 usecs
[   62.892167] calling  relay_init+0x0/0x1c @ 1
[   62.948209] initcall relay_init+0x0/0x1c returned 0 after 0 usecs
[   63.029258] CPU 0: synchronized TICK with master CPU (last difftransition_notifier_list+0x0/0x28 @ 1
[   63.030033] initcall init_cpufreq_transition_notifier_list+0x0/0x28 returned 0 after 0 usecs
[   63.030040] calling  net_ns_init+0x0/0x104 @ 1
[   63.030044] net_namespace: 1808 bytes
[   63.030121] initcall net_ns_init+0x0/0x104 returned 0 after 0 usecs
[   63.030127] calling  sparc_globreg_init+0x0/0xb4 @ 1
[   63.030133] initcall sparc_globreg_init+0x0/0xb4 returned 0 after 0 usecs
[   63.030140] calling  register_sparc64_cpufreq_notifier+0x0/0x20 @ 1
[   63.030146] initcall register_sparc64_cpufreq_notifier+0x0/0x20 returned 0 after 0 usecs
[   63.030152] calling  sstate_init+0x0/0x80 @ 1
[   63.030157] initcall sstate_init+0x0/0x80 returned 0 after 0 usecs
[   63.030163] calling  ldc_init+0x0/0xdc @ 1
[   63.030168] initcall ldc_init+0x0/0xdc returned -19 after 0 usecs
[   63.030174] calling  sysctl_init+0x0/0x20 @ 1
[   63.030193] initcall sysctl_init+0x0/0x20 returned 0 after 0 usecs
[   63.030199] calling  ksysfs_init+0x0/0xb4 @ 1
[   63.030217] initcall ksysfs_init+0x0/0xb4 returned 0 after 0 usecs
[   63.030222] calling  async_init+0x0/0x5c @ 1
[   63.030227] initcall async_init+0x0/0x5c returned 0 after 0 usecs
[   63.030233] calling  init_jiffies_clocksource+0x0/0x1c @ 1
[   63.030240] initcall init_jiffies_clocksource+0x0/0x1c returned 0 after 0 usecs
[   63.030248] calling  filelock_init+0x0/0x38 @ 1
[   63.030256] initcall filelock_init+0x0/0x38 returned 0 after 0 usecs
[   63.030261] calling  init_script_binfmt+0x0/0x1c @ 1
[   63.030267] initcall init_script_binfmt+0x0/0x1c returned 0 after 0 usecs
[   63.030272] calling  init_elf_binfmt+0x0/0x1c @ 1
[   63.030277] initcall init_elf_binfmt+0x0/0x1c returned 0 after 0 usecs
[   63.030283] calling  init_compat_elf_binfmt+0x0/0x1c @ 1
[   63.030288] initcall init_compat_elf_binfmt+0x0/0x1c returned 0 after 0 usecs
[   63.030294] calling  debugfs_init+0x0/0x50 @ 1
[   63.030305] initcall debugfs_init+0x0/0x50 returned 0 after 0 usecs
[   63.030311] calling  securityfs_init+0x0/0x50 @ 1
[   63.030320] initcall securityfs_init+0x0/0x50 returned 0 after 0 usecs
[   63.030326] calling  random32_init+0x0/0x11c @ 1
[   63.030333] initcall random32_init+0x0/0x11c returned 0 after 0 usecs
[   63.030340] calling  regulator_init+0x0/0x38 @ 1
[   63.030344] regulator: core version 0.5
[   63.030358] initcall regulator_init+0x0/0x38 returned 0 after 0 usecs
[   63.030363] calling  cpufreq_core_init+0x0/0xb4 @ 1
[   63.030368] initcall cpufreq_core_init+0x0/0xb4 returned 0 after 0 usecs
[   63.030373] calling  sock_init+0x0/0x64 @ 1
[   63.030423] initcall sock_init+0x0/0x64 returned 0 after 0 usecs
[   63.030428] calling  net_inuse_init+0x0/0x34 @ 1
[   63.030449] initcall net_inuse_init+0x0/0x34 returned 0 after 0 usecs
[   63.030454] calling  netpoll_init+0x0/0x28 @ 1
[   63.030459] initcall netpoll_init+0x0/0x28 returned 0 after 0 usecs
[   63.030465] calling  netlink_proto_init+0x0/0x280 @ 1
[   63.030475] NET: Registered protocol family 16
[   63.030497] initcall netlink_proto_init+0x0/0x280 returned 0 after 0 usecs
[   63.030503] calling  of_bus_driver_init+0x0/0x5c @ 1
[   63.033039] initcall of_bus_driver_init+0x0/0x5c returned 0 after 3906 usecs
[   63.033046] calling  vio_init+0x0/0x1bc @ 1
[   63.033068] initcall vio_init+0x0/0x1bc returned 0 after 0 usecs
[   63.033074] calling  bdi_class_init+0x0/0x54 @ 1
[   63.033120] initcall bdi_class_init+0x0/0x54 returned 0 after 0 usecs
[   63.033128] calling  kobject_uevent_init+0x0/0x54 @ 1
[   63.033141] initcall kobject_uevent_init+0x0/0x54 returned 0 after 0 usecs
[   63.033147] calling  gpiolib_sysfs_init+0x0/0xa4 @ 1
[   63.033184] initcall gpiolib_sysfs_init+0x0/0xa4 returned 0 after 0 usecs
[   63.033191] calling  pcibus_class_init+0x0/0x24 @ 1
[   63.033206] initcall pcibus_class_init+0x0/0x24 returned 0 after 0 usecs
[   63.033213] calling  pci_driver_init+0x0/0x1c @ 1
[   63.033253] initcall pci_driver_init+0x0/0x1c returned 0 after 0 usecs
[   63.033259] calling  backlight_class_init+0x0/0x74 @ 1
[   63.033275] initcall backlight_class_init+0x0/0x74 returned 0 after 0 usecs
[   63.033281] calling  tty_class_init+0x0/0x38 @ 1
[   63.033296] initcall tty_class_init+0x0/0x38 returned 0 after 0 usecs
[   63.033302] calling  vtconsole_class_init+0x0/0xe8 @ 1
[   63.033345] initcall vtconsole_class_init+0x0/0xe8 returned 0 after 0 usecs
[   63.033352] calling  register_node_type+0x0/0x9c @ 1
[   63.033372] initcall register_node_type+0x0/0x9c returned 0 after 0 usecs
[   63.033378] calling  spi_init+0x0/0x7c @ 1
[   63.033408] initcall spi_init+0x0/0x7c returned 0 after 0 usecs
[   63.033414] calling  i2c_init+0x0/0x70 @ 1
[   63.033463] initcall i2c_init+0x0/0x70 returned 0 after 0 usecs
[   63.033468] calling  cpu_type_probe+0x0/0x274 @ 1
[   63.033476] initcall cpu_type_probe+0x0/0x274 returned 0 after 0 usecs
[   63.033482] calling  pcr_arch_init+0x0/0x14c @ 1
[   


--rJwd6BRFiFCcLxzm--
