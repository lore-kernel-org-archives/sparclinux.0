From: Patrick Finnegan <pat@computer-refuge.org>
Date: Fri, 27 Nov 2009 03:02:45 +0000
Subject: Boot problems on a V880
Message-Id: <200911262202.45791.pat@computer-refuge.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I seem to have a new/different problem with booting on a Sun V880.  I have 
tried Debian/sarge, etch, and lenny installers, each fails.  After reading 
through a bit of this list, I downloaded sparc-next-2.6 via git, and 
compiled a kernel (based on Debian/lenny's 2.6.26-2-sparc64 kernel 
config), and it still won't boot.  I also updated to the latest OpenBoot 
image, hoping that would help, but I didn't see any difference.

Boot with kernel compiled from git (I have the Debian/Lenny installer boot 
below this one):
---------------------------------

Sun Fire 880, No Keyboard
Copyright 2009 Sun Microsystems, Inc.  All rights reserved.
OpenBoot 4.30.4, 16384 MB memory installed, Serial #53419798.
Ethernet address 0:3:ba:2f:1f:16, Host ID: 832f1f16.         




                                                                      
Rebooting with command: boot gem console=ttyS0,9600n1                 
Boot device: /pci@8,600000/network@1  File and args: console=ttyS0,9600n1
Requesting Internet Address for 0:3:ba:2f:1f:16                          
Requesting Internet Address for 0:3:ba:2f:1f:16                          
Requesting Internet Address for 0:3:ba:2f:1f:16                          
Requesting Internet Address for 0:3:ba:2f:1f:16                          
Requesting Internet Address for 0:3:ba:2f:1f:16                          
Requesting Internet Address for 0:3:ba:2f:1f:16                          
\                                                                        
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4 2009/08/19 07:21' 
[    0.000000] PROMLIB: Root node compatible:                            
[    0.000000] Initializing cgroup subsys cpuset                         
[    0.000000] Initializing cgroup subsys cpu                            
[    0.000000] Linux version 2.6.32-rc5 (root@v240) (gcc version 4.3.4 
(Debian 4.3.4-6) ) #1 SMP Thu Nov 26 21:28:06 EST 2009                                   
[    0.000000] bootconsole [earlyprom0] enabled                                 
[    0.000000] ARCH: SUN4U                                                      
[    0.000000] Ethernet address: 00:03:ba:2f:1f:16                              
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.        
[    0.000000] Remapping the kernel... done.                                    
[    0.000000] OF stdout device is: /pci@9,700000/ebus@1/serial@1,400000:a      
[    0.000000] PROM: Built device tree with 160126 bytes of memory.             
[    0.000000] Top of RAM: 0xd0ffb18000, Total RAM: 0x3ff8f4000                 
[    0.000000] Memory hole size: 839682MB                                       
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
[    0.000000] early_node_map[8] active PFN ranges                              
[    0.000000]     0: 0x05000000 -> 0x05080000                                  
[    0.000000]     0: 0x05800000 -> 0x05880000                                  
[    0.000000]     0: 0x06000000 -> 0x06080000                                  
[    0.000000]     0: 0x06800000 -> 0x0687f000                                  
[    0.000000]     0: 0x0687f001 -> 0x0687f7ff                                  
[    0.000000]     0: 0x0687f801 -> 0x0687fc1f                                  
[    0.000000]     0: 0x0687fd0a -> 0x0687fd59                                  
[    0.000000]     0: 0x0687fd7d -> 0x0687fd8c                                  
[    0.000000] Booting Linux...                                                 
[    0.000000] PERCPU: Embedded 7 pages/cpu @fffff8a008c00000 s22528 r8192 
d26624 u524288                                                                       
[    0.000000] pcpu-alloc: s22528 r8192 d26624 u524288 alloc=1*4194304          
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7                                  
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pages: 1895550                                                                     
[    0.000000] Kernel command line: console=ttyS0,9600n1                        
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)             
[    0.000000] Dentry cache hash table entries: 2097152 (order: 11, 
16777216 bytes)                                                                             
[    0.000000] Inode-cache hash table entries: 1048576 (order: 10, 8388608 
bytes)                                                                               
[    0.000000] Memory: 16606504k available (3520k kernel code, 1416k data, 
232k init) [fffff80000000000,000000d0ffb18000]                                       
[    0.000000] Hierarchical RCU implementation.                                 
[    0.000000] NR_IRQS:255                                                      
[    0.000000] clocksource: mult[640000] shift[16]                              
[    0.000000] clockevent: mult[28f5c28] shift[32]                              
[    0.000000] Console: colour dummy device 80x25                               
[   81.669809] Calibrating delay using timer specific routine.. 20.01 
BogoMIPS (lpj@029)                                                                      
[   81.763956] Security Framework initialized                                   
[   81.812808] SELinux:  Disabled at boot.                                      
[   81.858683] Mount-cache hash table entries: 512                              
[   81.913255] Initializing cgroup subsys ns                                    
[   81.960716] Initializing cgroup subsys cpuacct                               
[   82.013842] Initializing cgroup subsys devices                               
[   82.066960] Initializing cgroup subsys freezer                               
[   82.120084] Initializing cgroup subsys net_cls                               
[   82.175348] CPU 0: synchronized TICK with master CPU (last diff 0 
cycles, maxerr 11 cycles)                                                                  
[   82.178350] CPU 1: synchronized TICK with master CPU (last diff 0 
cycles, maxerr 12 cycles)                                                                  
[   82.181381] CPU 2: synchronized TICK with master CPU (last diff 1 
cycles, maxerr 12 cycles)                                                                  
[   82.184509] CPU 3: synchronized TICK with master CPU (last diff 0 
cycles, maxerr 11 cycles)                                                                  
[   82.230434] CPU 4: synchronized TICK with master CPU (last diff 0 
cycles, maxerr 11 cycles)                                                                  
[   82.276159] CPU 5: synchronized TICK with master CPU (last diff -1 
cycles, maxerr 11 cycles)                                                                 
[   82.376179] CPU 6: synchronized TICK with master CPU (last diff 0 
cycles, maxerr 11 cycles)                                                                  
[   82.376196] Brought up 8 CPUs                                                
[   82.911819] regulator: core version 0.5                                      
[   82.956584] NET: Registered protocol family 16                               
[   83.046945] Testing NMI watchdog ... OK.                                     
[   83.170307] Performance events: Supported PMU type is 'ultra3+'              
[   83.244251] /pci@8,700000: SCHIZO PCI Bus Module ver[4:0]                    
[   83.307111] /pci@8,700000: PCI IO[7ffef000000] MEM[7fe00000000]              
[   83.382542] PCI: Scanning PBM /pci@8,700000                                  
[   83.431352] /pci@8,600000: SCHIZO PCI Bus Module ver[4:0]                    
[   83.495334] /pci@8,600000: PCI IO[7ffed000000] MEM[7fd00000000]              
[   83.570789] PCI: Scanning PBM /pci@8,600000                                  
[   83.620030] /pci@9,700000: SCHIZO PCI Bus Module ver[4:0]                    
[   83.683679] /pci@9,700000: PCI IO[7ffeb000000] MEM[7fc00000000]              
[   83.759128] PCI: Scanning PBM /pci@9,700000                                  
[   83.812704] /pci@9,600000: SCHIZO PCI Bus Module ver[4:0]                    
[   83.875548] /pci@9,600000: PCI IO[7ffe9000000] MEM[7fb00000000]              
[   83.950986] PCI: Scanning PBM /pci@9,600000                                  
[   84.013251] bio: create slab <bio-0> at 0                                    
[   84.061107] vgaarb: loaded                                                   
[   84.092296] usbcore: registered new interface driver usbfs                   
[   84.157903] usbcore: registered new interface driver hub                     
[   84.221374] usbcore: registered new device driver usb                        
[   84.283574] /pci@9,700000/ebus@1/rtc@1,300070: RTC regs at 
0x7fc7e300070     
[   84.363324] Switching to clocksource stick                                   
[   84.419213] NET: Registered protocol family 2                                
[   84.470095] IP route cache hash table entries: 524288 (order: 9, 
4194304 bytes)                                                                              
[   84.561116] TCP established hash table entries: 524288 (order: 10, 
8388608 bytes)                                                                            
[   84.682661] TCP bind hash table entries: 65536 (order: 7, 1048576 
bytes)     
[   84.765308] TCP: Hash tables configured (established 524288 bind 65536)      
[   84.842770] TCP reno registered                                              
[   84.880825] NET: Registered protocol family 1                                
[   84.932808] power: Control reg at 7fc7e30002e                                
[   84.985146] chmc: UltraSPARC-III memory controller at /memory-
controller@0,400000 [ACTIVE]                                                                   
[   85.083433] chmc: UltraSPARC-III memory controller at /memory-
controller@1,400000 [ACTIVE]                                                                   
[   85.182384] chmc: UltraSPARC-III memory controller at /memory-
controller@2,400000 [ACTIVE]                                                                   
[   85.281325] chmc: UltraSPARC-III memory controller at /memory-
controller@3,400000 [ACTIVE]                                                                   
[   85.380293] chmc: UltraSPARC-III memory controller at /memory-
controller@4,400000 [ACTIVE]                                                                   
[   85.479259] chmc: UltraSPARC-III memory controller at /memory-
controller@5,400000 [ACTIVE]                                                                   
[   85.578203] chmc: UltraSPARC-III memory controller at /memory-
controller@6,400000 [ACTIVE]                                                                   
[   85.677167] chmc: UltraSPARC-III memory controller at /memory-
controller@7,400000 [ACTIVE]                                                                   
[   85.777350] audit: initializing netlink socket (disabled)                    
[   85.840723] type 00 audit(2.529:1): initialized                            

----------------
At that point, it hung.

And what I got with Debian/Lenny's installer:

-----------------
Sun Fire 880, No Keyboard
Copyright 2009 Sun Microsystems, Inc.  All rights reserved.
OpenBoot 4.30.4, 16384 MB memory installed, Serial #53419798.
Ethernet address 0:3:ba:2f:1f:16, Host ID: 832f1f16.         




                                                                      
Rebooting with command: boot gem console=ttyS0,9600n1 DEBIAN_FRONTEND=text 
priority=low                                                                         
Boot device: /pci@8,600000/network@1  File and args: console=ttyS0,9600n1 
DEBIAN_FRONTEND=text priority=low                                                     
Requesting Internet Address for 0:3:ba:2f:1f:16                                 
Requesting Internet Address for 0:3:ba:2f:1f:16                                 
Requesting Internet Address for 0:3:ba:2f:1f:16                                 
Requesting Internet Address for 0:3:ba:2f:1f:16                                 
Requesting Internet Address for 0:3:ba:2f:1f:16                                 
Requesting Internet Address for 0:3:ba:2f:1f:16                                 
\                                                                               
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4 2009/08/19 07:21'        
[    0.000000] PROMLIB: Root node compatible:                                   
[    0.000000] Initializing cgroup subsys cpu                                   
[    0.000000] Linux version 2.6.26-2-sparc64 (Debian 2.6.26-19) 
(dannf@debian.org) (gcc version 4.1.3 20080704 (prerelease) (Debian 
4.1.2-25)) #1 Thu Aug 20 15:21:01 UTC 2009                                                                 
[    0.000000] console [earlyprom0] enabled                                     
[    0.000000] ARCH: SUN4U                                                      
[    0.000000] Ethernet address: 00:03:ba:2f:1f:16                              
[    0.000000] Kernel: Using 1 locked TLB entries for main kernel image.        
[    0.000000] Remapping the kernel... done.                                    
[    0.000000] OF stdout device is: /pci@9,700000/ebus@1/serial@1,400000:a      
[    0.000000] PROM: Built device tree with 160167 bytes of memory.             
[    0.000000] Top of RAM: 0xd0ffb18000, Total RAM: 0x3ffaca000                 
[    0.000000] Memory hole size: 839680MB                                       
[    0.000000] [0000000318000000-fffff8a000800000] page_structs1072 
node=0 entry20/0                                                                      
[    0.000000] [0000000318000000-fffff8a000c00000] page_structs1072 
node=0 entry21/0                                                                      
[    0.000000] [0000000318700000-fffff8a001000000] page_structs1072 
node=0 entry22/0                                                                      
[    0.000000] [0000000318700000-fffff8a001400000] page_structs1072 
node=0 entry23/0                                                                      
[    0.000000] [0000000318e00000-fffff8a001800000] page_structs1072 
node=0 entry24/0                                                                      
[    0.000000] [0000000318e00000-fffff8a001c00000] page_structs1072 
node=0 entry25/0                                                                      
[    0.000000] [0000000319500000-fffff8a002000000] page_structs1072 
node=0 entry26/0                                                                      
[    0.000000] [0000000334000000-fffff8a002400000] page_structs1072 
node=0 entry32/0                                                                      
[    0.000000] [0000000334000000-fffff8a002800000] page_structs1072 
node=0 entry33/0                                                                      
[    0.000000] [0000000334700000-fffff8a002c00000] page_structs1072 
node=0 entry34/0                                                                      
[    0.000000] [0000000334700000-fffff8a003000000] page_structs1072 
node=0 entry35/0                                                                      
[    0.000000] [0000000334e00000-fffff8a003400000] page_structs1072 
node=0 entry36/0                                                                      
[    0.000000] [0000000334e00000-fffff8a003800000] page_structs1072 
node=0 entry37/0                                                                      
[    0.000000] [0000000335500000-fffff8a003c00000] page_structs1072 
node=0 entry38/0                                                                      
[    0.000000] [0000000350000000-fffff8a004000000] page_structs1072 
node=0 entry44/0                                                                      
[    0.000000] [0000000350000000-fffff8a004400000] page_structs1072 
node=0 entry45/0                                                                      
[    0.000000] [0000000350700000-fffff8a004800000] page_structs1072 
node=0 entry46/0                                                                      
[    0.000000] [0000000350700000-fffff8a004c00000] page_structs1072 
node=0 entry47/0                                                                      
[    0.000000] [0000000350e00000-fffff8a005000000] page_structs1072 
node=0 entry48/0                                                                      
[    0.000000] [0000000350e00000-fffff8a005400000] page_structs1072 
node=0 entry49/0                                                                      
[    0.000000] [0000000351500000-fffff8a005800000] page_structs1072 
node=0 entry50/0                                                                      
[    0.000000] [000000036c000000-fffff8a005c00000] page_structs1072 
node=0 entry56/0                                                                      
[    0.000000] [000000036c000000-fffff8a006000000] page_structs1072 
node=0 entry57/0                                                                      
[    0.000000] [000000036c700000-fffff8a006400000] page_structs1072 
node=0 entry58/0                                                                      
[    0.000000] [000000036c700000-fffff8a006800000] page_structs1072 
node=0 entry59/0                                                                      
[    0.000000] [000000036ce00000-fffff8a006c00000] page_structs1072 
node=0 entry60/0                                                                      
[    0.000000] [000000036ce00000-fffff8a007000000] page_structs1072 
node=0 entry61/0                                                                      
[    0.000000] [000000036d500000-fffff8a007400000] page_structs1072 
node=0 entry62/0                                                                      
[    0.000000] Zone PFN ranges:                                                 
[    0.000000]   Normal   83886080 -> 109575564                                 
[    0.000000] Movable zone start PFN for each node                             
[    0.000000] early_node_map[7] active PFN ranges                              
[    0.000000]     0: 83886080 -> 84410368                                      
[    0.000000]     0: 92274688 -> 92798976                                      
[    0.000000]     0: 100663296 -> 101187584                                    
[    0.000000]     0: 109051904 -> 109574143                                    
[    0.000000]     0: 109574144 -> 109575432                                    
[    0.000000]     0: 109575434 -> 109575513                                    
[    0.000000]     0: 109575549 -> 109575564                                    
[    0.000000] Booting Linux...                                                 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pages: 1920873                                                                     
[    0.000000] Kernel command line: console=ttyS0,9600n1 
DEBIAN_FRONTEND=text priority=low                                                                      
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)            
[    0.000000] clocksource: mult[640000] shift[16]                              
[    0.000000] clockevent: mult[28f5c28] shift[32]                              
[   80.046124] Console: colour dummy device 80x25                               
[   80.116437] Dentry cache hash table entries: 2097152 (order: 11, 
16777216 bytes)                                                                             
[   80.271680] Inode-cache hash table entries: 1048576 (order: 10, 8388608 
bytes)                                                                               
[   82.210743] Memory: 16623600k available (2592k kernel code, 944k data, 
176k init) [fffff80000000000,000000d0ffb18000]                                        
[   82.415501] Calibrating delay using timer specific routine.. 19.85 
BogoMIPS (lpj9718)                                                                      
[   82.509640] Security Framework initialized                                   
[   82.558492] SELinux:  Disabled at boot.                                      
[   82.604316] Capability LSM initialized                                       
[   82.649137] Mount-cache hash table entries: 512                              
[   82.703688] Initializing cgroup subsys ns                                    
[   82.751194] Initializing cgroup subsys cpuacct                               
[   82.804310] Initializing cgroup subsys devices                               
[   82.857708] Kernel unaligned access at TPC[46d24c] 
notifier_chain_register+0x10/0x38                                                                         
[   82.950154] Unable to handle kernel paging request in mna handler<1> at 
virtual address e00000a006000046                                                     
[   83.063683] current->{active_,}mm->context = 0000000000000000                
[   83.132435] current->{active_,}mm->pgd = fffff8a0003b2104                    
[   83.197021]               \|/ ____ \|/                                       
[   83.197025]               "@'/ .. \`@"                                       
[   83.197028]               /_| \__/ |_\                                       
[   83.197031]                  \__U_/                                          
[   83.373066] swapper(1): Oops [#1]                                            
[   83.412652] TSTATE: 0000008880f01605 TPC: 000000000046d24c TNPC: 
000000000046d250 Y: 00000000    Not tainted                                                 
[   83.530363] TPC: <notifier_chain_register+0x10/0x38>                         
[   83.589737] g0: 00000000000200d0 g1: 0000000000000001 g2: 
0000000000000000 g3: e00000a006000036                                                              
[   83.693906] g4: fffff8d0ff02f6e0 g5: 0000000000000000 g6: 
fffff8d0ff03c000 g7: 00000000007b6e58                                                              
[   83.798075] o0: 00000000007b7aa8 o1: 0000000000748528 o2: 
0000000000000000 o3: fffff8d0fe93dff9                                                              
[   83.902244] o4: 0000000000774000 o5: 0000000000000005 sp: 
fffff8d0ff03f581 ret_pc: 000000000046d33c                                                          
[   84.010582] RPC: <atomic_notifier_chain_register+0x1c/0x44>                  
[   84.077249] l0: fffff8d0ff03c000 l1: fffff8d0ff02f6e0 l2: 
fffff8d0ff02f140 l3: fffff8d0ff02f3c0                                                              
[   84.181417] l4: 0000000000000002 l5: 000000000073c040 l6: 
0000000000000020 l7: 0000000000000010                                                              
[   84.285585] i0: 00000000007b7aa8 i1: 0000000000000000 i2: 
0000000000426df4 i3: 0000000000000000                                                              
[   84.389754] i4: 0000000000000000 i5: 0000000000000000 i6: 
fffff8d0ff03f641 i7: 0000000000782128                                                              
[   84.493928] I7: <kernel_init+0x38/0x204>                                     
[   84.540798] Caller[0000000000782128]: kernel_init+0x38/0x204                 
[   84.608506] Caller[0000000000426df8]: kernel_thread+0x38/0x48                
[   84.677258] Caller[000000000067bae0]: rest_init+0x18/0x60                    
[   84.741842] Instruction DUMP: 01000000  10680008  c65a0000 <c200e010> 
80a08001  34400007  c6726008  9000e008  c65a0000                                       
[   84.871017] Kernel panic - not syncing: Attempted to kill init!              
[   84.941849] Kernel unaligned access at TPC[46d2c4] 
notifier_call_chain+0x18/0x74                                                                             
[   85.030392] Unable to handle kernel paging request in mna handler<1> at 
virtual address e00000a006000036                                                     
[   85.143935] current->{active_,}mm->context = 0000000000000000                
[   85.212686] current->{active_,}mm->pgd = fffff8a0003b2104                    
[   85.277271]               \|/ ____ \|/                                       
[   85.277274]               "@'/ .. \`@"                                       
[   85.277277]               /_| \__/ |_\                                       
[   85.277280]                  \__U_/                                          
[   85.453316] swapper(1): Oops [#2]                                            
[   85.492904] TSTATE: 0000000080f09605 TPC: 000000000046d2c4 TNPC: 
000000000046d2c8 Y: 00000000    Tainted: G      D                                           
[   85.618947] TPC: <notifier_call_chain+0x18/0x74>                             
[   85.674154] g0: 0000000000744000 g1: 0000000000000001 g2: 
0000000000000001 g3: 00000000007440c0                                                              
[   85.778323] g4: fffff8d0ff02f6e0 g5: 0000000000000000 g6: 
fffff8d0ff03c000 g7: 0000000000000001                                                              
[   85.882493] o0: e00000a006000036 o1: 0000000000000000 o2: 
00000000007b7ad0 o3: fffff8d0ff03f8e8                                                              
[   85.986661] o4: 0000000000744000 o5: 00000000007bc400 sp: 
fffff8d0ff03ee01 ret_pc: 0000000000557fcc                                                          
[   86.095009] RPC: <bust_spinlocks+0x48/0x4c>                                  
[   86.144997] l0: e00000a006000036 l1: 0000000000000000 l2: 
00000000007b7ed0 l3: ffffffffffffe048                                                              
[   86.249166] l4: 00000000007b7ad0 l5: 000000000073c040 l6: 
0000000000000020 l7: 0000000000000010                                                              
[   86.353334] i0: 0000000000000000 i1: 0000000000000000 i2: 
00000000007b7ad0 i3: fffffffffffffffe                                                              
[   86.457504] i4: 0000000000000000 i5: 0000000000004000 i6: 
fffff8d0ff03eec1 i7: 0000000000456e88                                                              
[   86.561675] I7: <panic+0x6c/0x164>                                           
[   86.602296] Caller[0000000000456e88]: panic+0x6c/0x164                       
[   86.663757] Caller[000000000045a250]: do_exit+0x6c/0x6f8                     
[   86.727299] Caller[0000000000428c40]: die_if_kernel+0x238/0x2d4              
[   86.798134] Caller[00000000004344b8]: kernel_mna_trap_fault+0xc8/0xfc        
[   86.875218] Caller[00000000004349c8]: kernel_unaligned_trap+0x4dc/0x520      
[   86.954386] Caller[0000000000428750]: mem_address_unaligned+0x58/0x90        
[   87.031472] Caller[0000000000405e08]: do_mna+0x44/0x4c                       
[   87.092931] Caller[000000000046d33c]: 
atomic_notifier_chain_register+0x1c/0x44                                                                               
[   87.179392] Caller[0000000000782128]: kernel_init+0x38/0x204                 
[   87.247100] Caller[0000000000426df8]: kernel_thread+0x38/0x48                
[   87.315853] Caller[000000000067bae0]: rest_init+0x18/0x60                    
[   87.380437] Instruction DUMP: e05e0000  1068000f  b0102000 <c25c0000> 
e05c2008  9fc04000  01000000  03000020  b0100008                                       
[   87.509607] Fixing recursive fault but reboot is needed!                     
------------

And it hangs here.

Pat
-- 
Purdue University Research Computing ---  http://www.rcac.purdue.edu/
The Computer Refuge                  ---  http://computer-refuge.org
