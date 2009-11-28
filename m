From: Patrick Finnegan <pat@computer-refuge.org>
Date: Sat, 28 Nov 2009 03:07:09 +0000
Subject: Re: Boot problems on a V880
Message-Id: <200911272207.09314.pat@computer-refuge.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200911262202.45791.pat@computer-refuge.org>
In-Reply-To: <200911262202.45791.pat@computer-refuge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Friday 27 November 2009, David Miller wrote:
> From: Patrick Finnegan <pat@computer-refuge.org>
> Date: Fri, 27 Nov 2009 20:52:17 -0500
> 
> > On Friday 27 November 2009, David Miller wrote:
> >> From: Patrick Finnegan <pat@computer-refuge.org>
> >> Date: Thu, 26 Nov 2009 22:02:45 -0500
> >>
> >> > I seem to have a new/different problem with booting on a Sun
> >> > V880. I have tried Debian/sarge, etch, and lenny installers,
> >> > each fails. After reading through a bit of this list, I
> >> > downloaded
> >> > sparc-next-2.6 via git, and compiled a kernel (based on
> >> > Debian/lenny's 2.6.26-2-sparc64 kernel config), and it still
> >> > won't boot.  I also updated to the latest OpenBoot image, hoping
> >> > that would help, but I didn't see any difference.
> >>
> >> sparc-next-2.6 doesn't have the bug fix, sparc-2.6 does
> >
> > Ok, with sparc-2.6, I get farther.  If I pull the RSC card, it
> > actually gets to a point where it tries to mount the root
> > filesystem (and fails, because I don't have one for it yet).  With
> > the RSC in, it hangs after the following output.  I have tried this
> > with the OpenBoot console set to both ttya and rsc-console, and
> > passed a "console=ttyS0" each time. At the point that the machine
> > hangs, it locks up hard enough that sending a break doesn't send me
> > to an "ok" prompt.
> 
> try booting with "initcall_debug=1 ignore_level" on the kernel
>  command line
> 
> And in the mean time you can install and test with the RSC card
>  removed

I'll try pulling the RSC later tonight or tomorrow.  Booting with the 
args you specified provide this (and it hangs after the
init_per_zone_wmark_min call):


{7} ok boot gem console=ttyS0 initcall_debug=1 ignore_level           
Boot device: /pci@8,600000/network@1  File and args: console=ttyS0 
initcall_debug=1 ignore_level                                                                
Requesting Internet Address for 0:3:ba:2f:1f:16                                 
Requesting Internet Address for 0:3:ba:2f:1f:16                                 
Requesting Internet Address for 0:3:ba:2f:1f:16                                 
Requesting Internet Address for 0:3:ba:2f:1f:16                                 
WARNING: /packages/obp-tftp: Power Supply 2 not receiving AC power              
Requesting Internet Address for 0:3:ba:2f:1f:16                                 
Requesting Internet Address for 0:3:ba:2f:1f:16                                 
\                                                                               
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4 2009/08/19 07:21'        
[    0.000000] PROMLIB: Root node compatible:                                   
[    0.000000] Initializing cgroup subsys cpuset                                
[    0.000000] Initializing cgroup subsys cpu                                   
[    0.000000] Linux version 2.6.32-rc3 (root@v210) (gcc version 4.3.4 
(Debian 4.3.4-6) ) #1 SMP Fri Nov 27 20:17:53 EST 2009                                   
[    0.000000] bootconsole [earlyprom0] enabled                                 
[    0.000000] ARCH: SUN4U                                                      
[    0.000000] Ethernet address: 00:03:ba:2f:1f:16                              
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.        
[    0.000000] Remapping the kernel... done.                                    
[    0.000000] OF stdout device is: /pci@9,700000/ebus@1/serial@1,400000:a      
[    0.000000] PROM: Built device tree with 160133 bytes of memory.             
[    0.000000] Top of RAM: 0xd0ffb18000, Total RAM: 0x3ff932000                 
[    0.000000] Memory hole size: 839681MB                                       
[    0.000000] [0000010140000000-fffff8a000c00000] page_structs1072 
node=0 entry80/0                                                                      
[    0.000000] [0000010140000000-fffff8a001000000] page_structs1072 
node=0 entry81/0                                                                      
[    0.000000] [0000010140800000-fffff8a001400000] page_structs1072 
node=0 entry82/0                                                                      
[    0.000000] [0000010140800000-fffff8a001800000] page_structs1072 
node=0 entry83/0                                                                      
[    0.000000] [0000010141000000-fffff8a001c00000] page_structs1072 
node=0 entry84/0                                                                      
[    0.000000] [0000010141000000-fffff8a002000000] page_structs1072 
node=0 entry85/0                                                                      
[    0.000000] [0000010141800000-fffff8a002400000] page_structs1072 
node=0 entry86/0                                                                      
[    0.000000] [0000010141800000-fffff8a002800000] page_structs1072 
node=0 entry87/0                                                                      
[    0.000000] [0000010160000000-fffff8a002c00000] page_structs1072 
node=0 entry08/0                                                                      
[    0.000000] [0000010160000000-fffff8a003000000] page_structs1072 
node=0 entry09/0                                                                      
[    0.000000] [0000010160800000-fffff8a003400000] page_structs1072 
node=0 entry10/0                                                                      
[    0.000000] [0000010160800000-fffff8a003800000] page_structs1072 
node=0 entry11/0                                                                      
[    0.000000] [0000010161000000-fffff8a003c00000] page_structs1072 
node=0 entry12/0                                                                      
[    0.000000] [0000010161000000-fffff8a004000000] page_structs1072 
node=0 entry13/0                                                                      
[    0.000000] [0000010161800000-fffff8a004400000] page_structs1072 
node=0 entry14/0                                                                      
[    0.000000] [0000010161800000-fffff8a004800000] page_structs1072 
node=0 entry15/0                                                                      
[    0.000000] [0000010180000000-fffff8a004c00000] page_structs1072 
node=0 entry36/0                                                                      
[    0.000000] [0000010180000000-fffff8a005000000] page_structs1072 
node=0 entry37/0                                                                      
[    0.000000] [0000010180800000-fffff8a005400000] page_structs1072 
node=0 entry38/0                                                                      
[    0.000000] [0000010180800000-fffff8a005800000] page_structs1072 
node=0 entry39/0                                                                      
[    0.000000] [0000010181000000-fffff8a005c00000] page_structs1072 
node=0 entry40/0                                                                      
[    0.000000] [0000010181000000-fffff8a006000000] page_structs1072 
node=0 entry41/0                                                                      
[    0.000000] [0000010181800000-fffff8a006400000] page_structs1072 
node=0 entry42/0                                                                      
[    0.000000] [0000010181800000-fffff8a006800000] page_structs1072 
node=0 entry43/0                                                                      
[    0.000000] [00000101a0000000-fffff8a006c00000] page_structs1072 
node=0 entry64/0                                                                      
[    0.000000] [00000101a0000000-fffff8a007000000] page_structs1072 
node=0 entry65/0                                                                      
[    0.000000] [00000101a0800000-fffff8a007400000] page_structs1072 
node=0 entry66/0                                                                      
[    0.000000] [00000101a0800000-fffff8a007800000] page_structs1072 
node=0 entry67/0                                                                      
[    0.000000] [00000101a1000000-fffff8a007c00000] page_structs1072 
node=0 entry68/0                                                                      
[    0.000000] [00000101a1000000-fffff8a008000000] page_structs1072 
node=0 entry69/0                                                                      
[    0.000000] [00000101a1800000-fffff8a008400000] page_structs1072 
node=0 entry70/0                                                                      
[    0.000000] [00000101a1800000-fffff8a008800000] page_structs1072 
node=0 entry71/0                                                                      
[    0.000000] Zone PFN ranges:                                                 
[    0.000000]   Normal   0x05000000 -> 0x0687fd8c                              
[    0.000000] Movable zone start PFN for each node                             
[    0.000000] early_node_map[7] active PFN ranges                              
[    0.000000]     0: 0x05000000 -> 0x05080000                                  
[    0.000000]     0: 0x05800000 -> 0x05880000                                  
[    0.000000]     0: 0x06000000 -> 0x06080000                                  
[    0.000000]     0: 0x06800000 -> 0x0687f7ff                                  
[    0.000000]     0: 0x0687f800 -> 0x0687fc3d                                  
[    0.000000]     0: 0x0687fd0a -> 0x0687fd58                                  
[    0.000000]     0: 0x0687fd7d -> 0x0687fd8c                                  
[    0.000000] Booting Linux...                                                 
[    0.000000] PERCPU: Embedded 7 pages/cpu @fffff8a008c00000 s22336 r8192 
d26816 u524288                                                                       
[    0.000000] pcpu-alloc: s22336 r8192 d26816 u524288 alloc=1*4194304          
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7                                  
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pages: 1895581                                                                     
[    0.000000] Kernel command line: console=ttyS0 initcall_debug=1 
ignore_level 
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)             
[    0.000000] Dentry cache hash table entries: 2097152 (order: 11, 
16777216 bytes)                                                                             
[    0.000000] Inode-cache hash table entries: 1048576 (order: 10, 8388608 
bytes)                                                                               
[    0.000000] Memory: 16607592k available (2968k kernel code, 1176k data, 
208k init) [fffff80000000000,000000d0ffb18000]                                       
[    0.000000] Hierarchical RCU implementation.                                 
[    0.000000] NR_IRQS:255                                                      
[    0.000000] clocksource: mult[640000] shift[16]                              
[    0.000000] clockevent: mult[28f5c28] shift[32]                              
[    0.000000] Console: colour dummy device 80x25                               
[  122.922602] Calibrating delay using timer specific routine.. 20.01 
BogoMIPS (lpj@029)                                                                      
[  123.016764] Security Framework initialized                                   
[  123.065666] Mount-cache hash table entries: 512                              
[  123.120213] Initializing cgroup subsys ns                                    
[  123.167677] Initializing cgroup subsys cpuacct                               
[  123.220801] Initializing cgroup subsys devices                               
[  123.273918] Initializing cgroup subsys freezer                               
[  123.327292] calling  migration_init+0x0/0x68 @ 1                             
[  123.382379] initcall migration_init+0x0/0x68 returned 0 after 0 usecs        
[  123.459346] calling  spawn_ksoftirqd+0x0/0x64 @ 1                            
[  123.515673] initcall spawn_ksoftirqd+0x0/0x64 returned 0 after 0 usecs       
[  123.593729] calling  init_call_single_data+0x0/0xac @ 1                      
[  123.656225] initcall init_call_single_data+0x0/0xac returned 0 after 0 
usecs 
[  123.740601] calling  spawn_softlockup_task+0x0/0x8c @ 1                      
[  123.803167] initcall spawn_softlockup_task+0x0/0x8c returned 0 after 0 
usecs 
[  123.887479] calling  relay_init+0x0/0x8 @ 1                                  
[  123.937476] initcall relay_init+0x0/0x8 returned 0 after 0 usecs             
[  124.009353] calling  tracer_alloc_buffers+0x0/0x1c0 @ 1                      
[  124.072051] initcall tracer_alloc_buffers+0x0/0x1c0 returned 0 after 0 
usecs 
[  124.156234] calling  init_trace_printk+0x0/0x18 @ 1                          
[  124.214567] initcall init_trace_printk+0x0/0x18 returned 0 after 0 
usecs     
[  124.296266] CPU 0: synchronized TICK with master CPU (last diff 0 
cycles, maxerr 11 cycles)                                                                  
[  124.298589] CPU 1: synchronized TICK with master CPU (last diff 0 
cycles, maxerr 11 cycles)                                                                  
[  124.301692] CPU 2: synchronized TICK with master CPU (last diff 0 
cycles, maxerr 11 cycles)                                                                  
[  124.304910] CPU 3: synchronized TICK with master CPU (last diff 0 
cycles, maxerr 11 cycles)                                                                  
[  124.308035] CPU 4: synchronized TICK with master CPU (last diff 0 
cycles, maxerr 11 cycles)                                                                  
[  124.311052] CPU 5: synchronized TICK with master CPU (last diff -1 
cycles, maxerr 11 cycles)                                                                 
[  124.314285] CPU 6: synchronized TICK with master CPU (last diff 0 
cycles, maxerr 11 cycles)                                                                  
[  124.314301] Brought up 8 CPUs                                                
[  125.032092] calling  init_mmap_min_addr+0x0/0x18 @ 1                         
[  125.090847] initcall init_mmap_min_addr+0x0/0x18 returned 0 after 0 
usecs    
[  125.172087] calling  init_cpufreq_transition_notifier_list+0x0/0x28 @ 1      
[  125.251261] initcall init_cpufreq_transition_notifier_list+0x0/0x28 
returned 0 after 0 usecs                                                                 
[  125.352295] calling  net_ns_init+0x0/0xf4 @ 1                                
[  125.404502] initcall net_ns_init+0x0/0xf4 returned 0 after 0 usecs           
[  125.478367] calling  sparc_globreg_init+0x0/0x1c @ 1                         
[  125.537720] initcall sparc_globreg_init+0x0/0x1c returned 0 after 0 
usecs    
[  125.618968] calling  register_sparc64_cpufreq_notifier+0x0/0x20 @ 1          
[  125.693971] initcall register_sparc64_cpufreq_notifier+0x0/0x20 
returned 0 after 0 usecs                                                                     
[  125.790848] calling  sstate_init+0x0/0x78 @ 1                                
[  125.842931] initcall sstate_init+0x0/0x78 returned 0 after 0 usecs           
[  125.916890] calling  ldc_init+0x0/0xdc @ 1                                   
[  125.965850] initcall ldc_init+0x0/0xdc returned -19 after 0 usecs            
[  126.038769] calling  sysctl_init+0x0/0x2c @ 1                                
[  126.091299] initcall sysctl_init+0x0/0x2c returned 0 after 0 usecs           
[  126.164813] calling  ksysfs_init+0x0/0xc4 @ 1                                
[  126.216918] initcall ksysfs_init+0x0/0xc4 returned 0 after 0 usecs           
[  126.290859] calling  async_init+0x0/0x64 @ 1                                 
[  126.341961] initcall async_init+0x0/0x64 returned 0 after 0 usecs            
[  126.414823] calling  init_jiffies_clocksource+0x0/0x18 @ 1                   
[  126.480449] initcall init_jiffies_clocksource+0x0/0x18 returned 0 after 
0 usecs                                                                              
[  126.567947] calling  init_zero_pfn+0x0/0x28 @ 1                              
[  126.622125] initcall init_zero_pfn+0x0/0x28 returned 0 after 0 usecs         
[  126.698158] calling  filelock_init+0x0/0x38 @ 1                              
[  126.752358] initcall filelock_init+0x0/0x38 returned 0 after 0 usecs         
[  126.828368] calling  init_script_binfmt+0x0/0x1c @ 1                         
[  126.887744] initcall init_script_binfmt+0x0/0x1c returned 0 after 0 
usecs    
[  126.968996] calling  init_elf_binfmt+0x0/0x1c @ 1                            
[  127.025246] initcall init_elf_binfmt+0x0/0x1c returned 0 after 0 usecs       
[  127.103373] calling  init_compat_elf_binfmt+0x0/0x1c @ 1                     
[  127.166917] initcall init_compat_elf_binfmt+0x0/0x1c returned 0 after 0 
usecs
[  127.252334] calling  debugfs_init+0x0/0x64 @ 1                               
[  127.305471] initcall debugfs_init+0x0/0x64 returned 0 after 0 usecs          
[  127.380461] calling  securityfs_init+0x0/0x50 @ 1                            
[  127.436722] initcall securityfs_init+0x0/0x50 returned 0 after 0 usecs       
[  127.514843] calling  random32_init+0x0/0xec @ 1                              
[  127.569014] initcall random32_init+0x0/0xec returned 0 after 0 usecs         
[  127.645052] calling  regulator_init+0x0/0x30 @ 1                             
[  127.700256] regulator: core version 0.5                                      
[  127.746245] initcall regulator_init+0x0/0x30 returned 0 after 3906 
usecs     
[  127.826312] calling  cpufreq_core_init+0x0/0xd0 @ 1                          
[  127.884653] initcall cpufreq_core_init+0x0/0xd0 returned 0 after 0 
usecs     
[  127.964848] calling  sock_init+0x0/0x60 @ 1                                  
[  128.014973] initcall sock_init+0x0/0x60 returned 0 after 0 usecs             
[  128.086728] calling  net_inuse_init+0x0/0x2c @ 1                             
[  128.141943] initcall net_inuse_init+0x0/0x2c returned 0 after 0 usecs        
[  128.219021] calling  netlink_proto_init+0x0/0x2a8 @ 1                        
[  128.279456] NET: Registered protocol family 16                               
[  128.332607] initcall netlink_proto_init+0x0/0x2a8 returned 0 after 3906 
usecs
[  128.417983] calling  of_bus_driver_init+0x0/0x54 @ 1                         
[  128.505618] initcall of_bus_driver_init+0x0/0x54 returned 0 after 27343 
usecs
[  128.589389] calling  vio_init+0x0/0x1a4 @ 1                                  
[  128.639396] initcall vio_init+0x0/0x1a4 returned 0 after 0 usecs             
[  128.711279] calling  bdi_class_init+0x0/0x54 @ 1                             
[  128.767139] initcall bdi_class_init+0x0/0x54 returned 0 after 0 usecs        
[  128.843417] calling  kobject_uevent_init+0x0/0x64 @ 1                        
[  128.903934] initcall kobject_uevent_init+0x0/0x64 returned 0 after 0 
usecs   
[  128.986122] calling  pcibus_class_init+0x0/0x20 @ 1                          
[  129.044591] initcall pcibus_class_init+0x0/0x20 returned 0 after 0 
usecs     
[  129.124777] calling  pci_driver_init+0x0/0x18 @ 1                            
[  129.181109] initcall pci_driver_init+0x0/0x18 returned 0 after 0 usecs       
[  129.259070] calling  backlight_class_init+0x0/0x74 @ 1                       
[  129.320622] initcall backlight_class_init+0x0/0x74 returned 0 after 0 
usecs  
[  129.403883] calling  tty_class_init+0x0/0x48 @ 1                             
[  129.459167] initcall tty_class_init+0x0/0x48 returned 0 after 0 usecs        
[  129.536143] calling  vtconsole_class_init+0x0/0xe4 @ 1                       
[  129.597856] initcall vtconsole_class_init+0x0/0xe4 returned 0 after 0 
usecs  
[  129.680938] calling  i2c_init+0x0/0x6c @ 1                                   
[  129.730148] initcall i2c_init+0x0/0x6c returned 0 after 0 usecs              
[  129.800736] calling  cpu_type_probe+0x0/0x234 @ 1                            
[  129.856977] initcall cpu_type_probe+0x0/0x234 returned 0 after 0 usecs       
[  129.935097] calling  pcr_arch_init+0x0/0x130 @ 1                             
[  129.990316] Testing NMI watchdog ... OK.                                     
[  130.115402] Performance events: Supported PMU type is 'ultra3+'              
[  130.186248] initcall pcr_arch_init+0x0/0x130 returned 0 after 89843 
usecs    
[  130.267497] calling  topology_init+0x0/0xe8 @ 1                              
[  130.322659] initcall topology_init+0x0/0xe8 returned 0 after 0 usecs         
[  130.397728] calling  sunfire_init+0x0/0x34 @ 1                               
[  130.451269] initcall sunfire_init+0x0/0x34 returned 0 after 0 usecs          
[  130.525883] calling  sbus_init+0x0/0x45c @ 1                                 
[  130.576896] initcall sbus_init+0x0/0x45c returned 0 after 0 usecs            
[  130.649799] calling  psycho_init+0x0/0x20 @ 1                                
[  130.702309] initcall psycho_init+0x0/0x20 returned 0 after 0 usecs           
[  130.775864] calling  sabre_init+0x0/0x20 @ 1                                 
[  130.827409] initcall sabre_init+0x0/0x20 returned 0 after 0 usecs            
[  130.899826] calling  schizo_init+0x0/0x20 @ 1                                
[  130.952035] /pci@8,700000: SCHIZO PCI Bus Module ver[4:0]                    
[  131.016477] /pci@8,700000: PCI IO[7ffef000000] MEM[7fe00000000]              
[  131.091905] PCI: Scanning PBM /pci@8,700000                                  
[  131.140676] /pci@8,600000: SCHIZO PCI Bus Module ver[4:0]                    
[  131.204725] /pci@8,600000: PCI IO[7ffed000000] MEM[7fd00000000]              
[  131.280134] PCI: Scanning PBM /pci@8,600000                                  
[  131.329132] /pci@9,700000: SCHIZO PCI Bus Module ver[4:0]                    
[  131.392978] /pci@9,700000: PCI IO[7ffeb000000] MEM[7fc00000000]              
[  131.468401] PCI: Scanning PBM /pci@9,700000                                  
[  131.521913] /pci@9,600000: SCHIZO PCI Bus Module ver[4:0]                    
[  131.584722] /pci@9,600000: PCI IO[7ffe9000000] MEM[7fb00000000]              
[  131.660168] PCI: Scanning PBM /pci@9,600000                                  
[  131.710997] initcall schizo_init+0x0/0x20 returned 0 after 66406 usecs       
[  131.787354] calling  pci_sun4v_init+0x0/0x20 @ 1                             
[  131.842973] initcall pci_sun4v_init+0x0/0x20 returned 0 after 0 usecs        
[  131.919647] calling  fire_init+0x0/0x20 @ 1                                  
[  131.969996] initcall fire_init+0x0/0x20 returned 0 after 0 usecs             
[  132.041510] calling  ds_init+0x0/0x3c @ 1                                    
[  132.089617] initcall ds_init+0x0/0x3c returned 0 after 0 usecs               
[  132.159224] calling  param_sysfs_init+0x0/0x280 @ 1                          
[  132.221063] initcall param_sysfs_init+0x0/0x280 returned 0 after 0 
usecs     
[  132.299553] calling  pm_sysrq_init+0x0/0x20 @ 1                              
[  132.353688] initcall pm_sysrq_init+0x0/0x20 returned 0 after 0 usecs         
[  132.429731] calling  audit_watch_init+0x0/0x34 @ 1                           
[  132.487024] initcall audit_watch_init+0x0/0x34 returned 0 after 0 usecs      
[  132.566194] calling  init_slow_work+0x0/0x4c @ 1                             
[  132.621401] initcall init_slow_work+0x0/0x4c returned 0 after 0 usecs        
[  132.698484] calling  default_bdi_init+0x0/0xc0 @ 1                           
[  132.756100] initcall default_bdi_init+0x0/0xc0 returned 0 after 0 usecs      
[  132.835098] calling  init_bio+0x0/0x13c @ 1                                  
[  132.885800] bio: create slab <bio-0> at 0                                    
[  132.932906] initcall init_bio+0x0/0x13c returned 0 after 3906 usecs          
[  133.007870] calling  cryptomgr_init+0x0/0x18 @ 1                             
[  133.063079] initcall cryptomgr_init+0x0/0x18 returned 0 after 0 usecs        
[  133.140163] calling  blk_settings_init+0x0/0x30 @ 1                          
[  133.198499] initcall blk_settings_init+0x0/0x30 returned 0 after 0 
usecs     
[  133.278704] calling  blk_ioc_init+0x0/0x30 @ 1                               
[  133.331865] initcall blk_ioc_init+0x0/0x30 returned 0 after 0 usecs          
[  133.406833] calling  blk_softirq_init+0x0/0x84 @ 1                           
[  133.464130] initcall blk_softirq_init+0x0/0x84 returned 0 after 0 usecs      
[  133.543292] calling  blk_iopoll_setup+0x0/0x84 @ 1                           
[  133.600590] initcall blk_iopoll_setup+0x0/0x84 returned 0 after 0 usecs      
[  133.679754] calling  genhd_device_init+0x0/0x7c @ 1                          
[  133.739047] initcall genhd_device_init+0x0/0x7c returned 0 after 0 
usecs     
[  133.818347] calling  blk_dev_integrity_init+0x0/0x30 @ 1                     
[  133.881880] initcall blk_dev_integrity_init+0x0/0x30 returned 0 after 0 
usecs
[  133.967276] calling  pci_slot_init+0x0/0x4c @ 1                              
[  134.021441] initcall pci_slot_init+0x0/0x4c returned 0 after 0 usecs         
[  134.097476] calling  misc_init+0x0/0xbc @ 1                                  
[  134.147672] initcall misc_init+0x0/0xbc returned 0 after 0 usecs             
[  134.219357] calling  vga_arb_device_init+0x0/0x90 @ 1                        
[  134.279974] vgaarb: loaded                                                   
[  134.312073] initcall vga_arb_device_init+0x0/0x90 returned 0 after 3906 
usecs
[  134.397480] calling  serio_init+0x0/0x90 @ 1                                 
[  134.448762] initcall serio_init+0x0/0x90 returned 0 after 0 usecs            
[  134.521445] calling  input_init+0x0/0x15c @ 1                                
[  134.573700] initcall input_init+0x0/0x15c returned 0 after 0 usecs           
[  134.647487] calling  rtc_init+0x0/0x6c @ 1                                   
[  134.696587] initcall rtc_init+0x0/0x6c returned 0 after 0 usecs              
[  134.767278] calling  proto_init+0x0/0x18 @ 1                                 
[  134.818326] initcall proto_init+0x0/0x18 returned 0 after 0 usecs            
[  134.891236] calling  net_dev_init+0x0/0x1c8 @ 1                              
[  134.945871] initcall net_dev_init+0x0/0x1c8 returned 0 after 0 usecs         
[  135.021453] calling  neigh_init+0x0/0x88 @ 1                                 
[  135.072493] initcall neigh_init+0x0/0x88 returned 0 after 0 usecs            
[  135.145407] calling  fib_rules_init+0x0/0xb4 @ 1                             
[  135.200622] initcall fib_rules_init+0x0/0xb4 returned 0 after 0 usecs        
[  135.277704] calling  genl_init+0x0/0xb4 @ 1                                  
[  135.327765] initcall genl_init+0x0/0xb4 returned 0 after 0 usecs             
[  135.399584] calling  sysctl_init+0x0/0x4c @ 1                                
[  135.451668] initcall sysctl_init+0x0/0x4c returned 0 after 0 usecs           
[  135.525626] calling  clock_init+0x0/0x7c @ 1                                 
[  135.577332] /pci@9,700000/ebus@1/rtc@1,300070: RTC regs at 
0x7fc7e300070     
[  135.657859] initcall clock_init+0x0/0x7c returned 0 after 3906 usecs         
[  135.732925] calling  dma_init+0x0/0x8 @ 1                                    
[  135.780840] initcall dma_init+0x0/0x8 returned 0 after 0 usecs               
[  135.850631] calling  auxio_init+0x0/0x20 @ 1                                 
[  135.901896] initcall auxio_init+0x0/0x20 returned 0 after 0 usecs            
[  135.974598] calling  clocksource_done_booting+0x0/0x38 @ 1                   
[  136.040217] Switching to clocksource stick                                   
[  136.090600] initcall clocksource_done_booting+0x0/0x38 returned 0 after 
4702 usecs                                                                           
[  136.180056] calling  rb_init_debugfs+0x0/0x38 @ 1                            
[  136.236355] initcall rb_init_debugfs+0x0/0x38 returned 0 after 79 usecs      
[  136.315440] calling  tracer_init_debugfs+0x0/0x334 @ 1                       
[  136.377261] initcall tracer_init_debugfs+0x0/0x334 returned 0 after 344 
usecs
[  136.462318] calling  init_trace_printk_function_export+0x0/0x38 @ 1          
[  136.537324] initcall init_trace_printk_function_export+0x0/0x38 
returned 0 after 6 usecs                                                                     
[  136.634206] calling  event_trace_init+0x0/0x24c @ 1                          
[  136.697662] initcall event_trace_init+0x0/0x24c returned 0 after 5008 
usecs  
[  136.779206] calling  init_pipe_fs+0x0/0x4c @ 1                               
[  136.832402] initcall init_pipe_fs+0x0/0x4c returned 0 after 76 usecs         
[  136.908382] calling  eventpoll_init+0x0/0xa8 @ 1                             
[  136.963696] initcall eventpoll_init+0x0/0xa8 returned 0 after 117 usecs      
[  137.042745] calling  anon_inode_init+0x0/0x10c @ 1                           
[  137.100057] initcall anon_inode_init+0x0/0x10c returned 0 after 21 
usecs     
[  137.180263] calling  blk_scsi_ioctl_init+0x0/0x238 @ 1                       
[  137.241709] initcall blk_scsi_ioctl_init+0x0/0x238 returned 0 after 3 
usecs  
[  137.325042] calling  chr_dev_init+0x0/0xd4 @ 1                               
[  137.379931] initcall chr_dev_init+0x0/0xd4 returned 0 after 1720 usecs       
[  137.456539] calling  firmware_class_init+0x0/0x80 @ 1                        
[  137.517082] initcall firmware_class_init+0x0/0x80 returned 0 after 155 
usecs 
[  137.601306] calling  cpufreq_gov_performance_init+0x0/0x1c @ 1               
[  137.671091] initcall cpufreq_gov_performance_init+0x0/0x1c returned 0 
after 2 usecs                                                                          
[  137.762769] calling  sysctl_core_init+0x0/0x3c @ 1                           
[  137.820125] initcall sysctl_core_init+0x0/0x3c returned 0 after 73 
usecs     
[  137.900261] calling  inet_init+0x0/0x28c @ 1                                 
[  137.951478] NET: Registered protocol family 2                                
[  138.003870] IP route cache hash table entries: 524288 (order: 9, 
4194304 bytes)                                                                              
[  138.094977] TCP established hash table entries: 524288 (order: 10, 
8388608 bytes)                                                                            
[  138.216408] TCP bind hash table entries: 65536 (order: 7, 1048576 
bytes)     
[  138.299063] TCP: Hash tables configured (established 524288 bind 65536)      
[  138.376441] TCP reno registered                                              
[  138.414462] initcall inet_init+0x0/0x28c returned 0 after 452290 usecs       
[  138.492059] calling  af_unix_init+0x0/0x5c @ 1                               
[  138.545204] NET: Registered protocol family 1                                
[  138.597288] initcall af_unix_init+0x0/0x5c returned 0 after 50896 usecs      
[  138.676439] calling  populate_rootfs+0x0/0x2f0 @ 1                           
[  138.733919] initcall populate_rootfs+0x0/0x2f0 returned 0 after 197 
usecs    
[  138.814973] calling  power_init+0x0/0x20 @ 1                                 
[  138.866161] power: Control reg at 7fc7e30002e                                
[  138.918526] initcall power_init+0x0/0x20 returned 0 after 51283 usecs        
[  138.995197] calling  mdesc_misc_init+0x0/0x18 @ 1                            
[  139.051621] initcall mdesc_misc_init+0x0/0x18 returned 0 after 186 
usecs     
[  139.131645] calling  us3mc_init+0x0/0xc8 @ 1                                 
[  139.182737] chmc: UltraSPARC-III memory controller at /memory-
controller@0,400000 [ACTIVE]                                                                   
[  139.281678] chmc: UltraSPARC-III memory controller at /memory-
controller@1,400000 [ACTIVE]                                                                   
[  139.380625] chmc: UltraSPARC-III memory controller at /memory-
controller@2,400000 [ACTIVE]                                                                   
[  139.479584] chmc: UltraSPARC-III memory controller at /memory-
controller@3,400000 [ACTIVE]                                                                   
[  139.578560] chmc: UltraSPARC-III memory controller at /memory-
controller@4,400000 [ACTIVE]                                                                   
[  139.677507] chmc: UltraSPARC-III memory controller at /memory-
controller@5,400000 [ACTIVE]                                                                   
[  139.776465] chmc: UltraSPARC-III memory controller at /memory-
controller@6,400000 [ACTIVE]                                                                   
[  139.875436] chmc: UltraSPARC-III memory controller at /memory-
controller@7,400000 [ACTIVE]                                                                   
[  139.974589] initcall us3mc_init+0x0/0xc8 returned 0 after 773345 usecs       
[  140.052493] calling  audit_classes_init+0x0/0xb0 @ 1                         
[  140.111886] initcall audit_classes_init+0x0/0xb0 returned 0 after 19 
usecs   
[  140.194173] calling  init_sched_debug_procfs+0x0/0x34 @ 1                    
[  140.258761] initcall init_sched_debug_procfs+0x0/0x34 returned 0 after 
15 usecs                                                                              
[  140.346247] calling  proc_execdomains_init+0x0/0x30 @ 1                      
[  140.408753] initcall proc_execdomains_init+0x0/0x30 returned 0 after 4 
usecs 
[  140.493133] calling  ioresources_init+0x0/0x50 @ 1                           
[  140.550426] initcall ioresources_init+0x0/0x50 returned 0 after 7 usecs      
[  140.629587] calling  uid_cache_init+0x0/0xa4 @ 1                             
[  140.684848] initcall uid_cache_init+0x0/0xa4 returned 0 after 51 usecs       
[  140.762933] calling  init_posix_timers+0x0/0x174 @ 1                         
[  140.822338] initcall init_posix_timers+0x0/0x174 returned 0 after 38 
usecs   
[  140.904593] calling  init_posix_cpu_timers+0x0/0x104 @ 1                     
[  140.968136] initcall init_posix_cpu_timers+0x0/0x104 returned 0 after 2 
usecs
[  141.053561] calling  nsproxy_cache_init+0x0/0x30 @ 1                         
[  141.112986] initcall nsproxy_cache_init+0x0/0x30 returned 0 after 54 
usecs   
[  141.195223] calling  create_proc_profile+0x0/0x21c @ 1                       
[  141.256681] initcall create_proc_profile+0x0/0x21c returned 0 after 0 
usecs  
[  141.340024] calling  timekeeping_init_device+0x0/0x30 @ 1                    
[  141.404905] initcall timekeeping_init_device+0x0/0x30 returned 0 after 
296 usecs
[  141.493147] calling  init_clocksource_sysfs+0x0/0x64 @ 1
[  141.556970] initcall init_clocksource_sysfs+0x0/0x64 returned 0 after 
274 usecs
[  141.644203] calling  init_timer_list_procfs+0x0/0x34 @ 1
[  141.707739] initcall init_timer_list_procfs+0x0/0x34 returned 0 after 5 
usecs
[  141.793151] calling  init_tstats_procfs+0x0/0x34 @ 1
[  141.852531] initcall init_tstats_procfs+0x0/0x34 returned 0 after 4 
usecs
[  141.933786] calling  futex_init+0x0/0xa0 @ 1
[  141.984871] initcall futex_init+0x0/0xa0 returned 0 after 49 usecs
[  142.058780] calling  proc_modules_init+0x0/0x30 @ 1
[  142.117118] initcall proc_modules_init+0x0/0x30 returned 0 after 4 
usecs
[  142.197333] calling  kallsyms_init+0x0/0x30 @ 1
[  142.251497] initcall kallsyms_init+0x0/0x30 returned 0 after 4 usecs
[  142.327536] calling  pid_namespaces_init+0x0/0x30 @ 1
[  142.387986] initcall pid_namespaces_init+0x0/0x30 returned 0 after 32 
usecs
[  142.471299] calling  audit_init+0x0/0x138 @ 1
[  142.523370] audit: initializing netlink socket (disabled)
[  142.587988] type 00 audit(8.204:1): initialized
[  142.644215] initcall audit_init+0x0/0x138 returned 0 after 118007 usecs
[  142.723377] calling  audit_tree_init+0x0/0x58 @ 1
[  142.779647] initcall audit_tree_init+0x0/0x58 returned 0 after 10 usecs
[  142.858796] calling  hung_task_init+0x0/0x54 @ 1
[  142.914112] initcall hung_task_init+0x0/0x54 returned 0 after 103 usecs
[  142.993178] calling  utsname_sysctl_init+0x0/0x1c @ 1
[  143.053674] initcall utsname_sysctl_init+0x0/0x1c returned 0 after 70 
usecs
[  143.136938] calling  init_tracepoints+0x0/0x18 @ 1
[  143.194221] initcall init_tracepoints+0x0/0x18 returned 0 after 2 usecs
[  143.273388] calling  init_events+0x0/0x84 @ 1
[  143.325491] initcall init_events+0x0/0x84 returned 0 after 10 usecs
[  143.400475] calling  init_sched_switch_trace+0x0/0x18 @ 1
[  143.465064] initcall init_sched_switch_trace+0x0/0x18 returned 0 after 
4 usecs
[  143.551519] calling  init_blk_tracer+0x0/0x64 @ 1
[  143.607781] initcall init_blk_tracer+0x0/0x64 returned 0 after 2 usecs
[  143.685897] calling  perf_event_sysfs_init+0x0/0x20 @ 1
[  143.748421] initcall perf_event_sysfs_init+0x0/0x20 returned 0 after 22 
usecs
[  143.833815] calling  init_per_zone_wmark_min+0x0/0x8c @ 1


Pat
-- 
Purdue University Research Computing ---  http://www.rcac.purdue.edu/
The Computer Refuge                  ---  http://computer-refuge.org
