From: Patrick Finnegan <pat@computer-refuge.org>
Date: Sat, 28 Nov 2009 01:52:17 +0000
Subject: Re: Boot problems on a V880
Message-Id: <200911272052.17430.pat@computer-refuge.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200911262202.45791.pat@computer-refuge.org>
In-Reply-To: <200911262202.45791.pat@computer-refuge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Friday 27 November 2009, David Miller wrote:
> From: Patrick Finnegan <pat@computer-refuge.org>
> Date: Thu, 26 Nov 2009 22:02:45 -0500
> 
> > I seem to have a new/different problem with booting on a Sun V880. 
> > I have tried Debian/sarge, etch, and lenny installers, each fails. 
> > After reading through a bit of this list, I downloaded
> > sparc-next-2.6 via git, and compiled a kernel (based on
> > Debian/lenny's 2.6.26-2-sparc64 kernel config), and it still won't
> > boot.  I also updated to the latest OpenBoot image, hoping that
> > would help, but I didn't see any difference.
> 
> sparc-next-2.6 doesn't have the bug fix, sparc-2.6 does

Ok, with sparc-2.6, I get farther.  If I pull the RSC card, it actually 
gets to a point where it tries to mount the root filesystem (and fails, 
because I don't have one for it yet).  With the RSC in, it hangs after 
the following output.  I have tried this with the OpenBoot console set 
to both ttya and rsc-console, and passed a "console=ttyS0" each time. At 
the point that the machine hangs, it locks up hard enough that sending a 
break doesn't send me to an "ok" prompt.

The RSC is running the newest (2.2.3) firmware, and works ok with 
Solaris 10.  Suggestions?

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
[    0.000000] OF stdout device is: /pci@9,700000/ebus@1/rsc-
console@1,3083f8   
[    0.000000] PROM: Built device tree with 160127 bytes of memory.             
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
[    0.000000] PERCPU: Embedded 7 pages/cpu @fffff8a008c00000 s22336 
r8192 d26816 u524288                                                                       
[    0.000000] pcpu-alloc: s22336 r8192 d26816 u524288 alloc=1*4194304          
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7                                  
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pages: 1895581                                                                     
[    0.000000] Kernel command line: console=ttyS0                               
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)             
[    0.000000] Dentry cache hash table entries: 2097152 (order: 11, 
16777216 bytes)                                                                             
[    0.000000] Inode-cache hash table entries: 1048576 (order: 10, 
8388608 bytes)                                                                               
[    0.000000] Memory: 16607592k available (2968k kernel code, 1176k 
data, 208k init) [fffff80000000000,000000d0ffb18000]                                       
[    0.000000] Hierarchical RCU implementation.                                 
[    0.000000] NR_IRQS:255                                                      
[    0.000000] clocksource: mult[640000] shift[16]                              
[    0.000000] clockevent: mult[28f5c28] shift[32]                              
[    0.000000] Console: colour dummy device 80x25                               
[  102.564500] Calibrating delay using timer specific routine.. 20.01 
BogoMIPS (lpj@029)                                                                      
[  102.572566] Security Framework initialized                                   
[  102.576685] Mount-cache hash table entries: 512                              
[  102.581616] Initializing cgroup subsys ns                                    
[  102.585577] Initializing cgroup subsys cpuacct                               
[  102.589994] Initializing cgroup subsys devices                               
[  102.594406] Initializing cgroup subsys freezer                               
[  102.600982] CPU 0: synchronized TICK with master CPU (last diff 0 
cycles, maxerr 11 cycles)                                                                  
[  102.602558] CPU 1: synchronized TICK with master CPU (last diff 0 
cycles, maxerr 11 cycles)                                                                  
[  102.609412] CPU 2: synchronized TICK with master CPU (last diff 0 
cycles, maxerr 11 cycles)                                                                  
[  102.610980] CPU 3: synchronized TICK with master CPU (last diff 0 
cycles, maxerr 12 cycles)                                                                  
[  102.620436] CPU 4: synchronized TICK with master CPU (last diff 0 
cycles, maxerr 11 cycles)                                                                  
[  102.621985] CPU 5: synchronized TICK with master CPU (last diff 0 
cycles, maxerr 11 cycles)                                                                  
[  102.629802] CPU 6: synchronized TICK with master CPU (last diff 0 
cycles, maxerr 11 cycles)                                                                  
[  102.629818] Brought up 8 CPUs                                                
[  102.666637] regulator: core version 0.5                                      
[  102.670746] NET: Registered protocol family 16                               
[  102.704507] Testing NMI watchdog ... OK.                                     
[  102.788369] Performance events: Supported PMU type is 'ultra3+'              
[  102.797454] /pci@8,700000: SCHIZO PCI Bus Module ver[4:0]                    
[  102.802925] /pci@8,700000: PCI IO[7ffef000000] MEM[7fe00000000]              
[  102.813439] PCI: Scanning PBM /pci@8,700000                                  
[  102.818155] /pci@8,600000: SCHIZO PCI Bus Module ver[4:0]                    
[  102.823614] /pci@8,600000: PCI IO[7ffed000000] MEM[7fd00000000]              
[  102.834067] PCI: Scanning PBM /pci@8,600000
[  102.839121] /pci@9,700000: SCHIZO PCI Bus Module ver[4:0]
[  102.844506] /pci@9,700000: PCI IO[7ffeb000000] MEM[7fc00000000]
[  102.854977] PCI: Scanning PBM /pci@9,700000
[  102.864365] /pci@9,600000: SCHIZO PCI Bus Module ver[4:0]
[  102.869711] /pci@9,600000: PCI IO[7ffe9000000] MEM[7fb00000000]
[  102.880231] PCI: Scanning PBM /pci@9,600000
[  102.893534] bio: create slab <bio-0> at 0
[  102.898719] vgaarb: loaded
[  102.903089] /pci@9,700000/ebus@1/rtc@1,300070: RTC regs at 
0x7fc7e300070
[  102.910914] Switching to clocksource stick
[  102.924074] NET: Registered protocol family 2
[  102.928859] IP route cache hash table entries: 524288 (order: 9, 
4194304 bytes)
[  102.941163] TCP established hash table entries: 524288 (order: 10, 
8388608 bytes)
[  102.979862] TCP bind hash table entries: 65536 (order: 7, 1048576 
bytes)
[  102.990442] TCP: Hash tables configured (established 524288 bind 
65536)
[  102.996998] TCP reno registered
[  103.000698] NET: Registered protocol family 1
[  103.005402] power: Control reg at 7fc7e30002e
[  103.010321] chmc: UltraSPARC-III memory controller at /memory-
controller@0,400000 [ACTIVE]
[  103.018579] chmc: UltraSPARC-III memory controller at /memory-
controller@1,400000 [ACTIVE]
[  103.026807] chmc: UltraSPARC-III memory controller at /memory-
controller@2,400000 [ACTIVE]
[  103.035034] chmc: UltraSPARC-III memory controller at /memory-
controller@3,400000 [ACTIVE]
[  103.043264] chmc: UltraSPARC-III memory controller at /memory-
controller@4,400000 [ACTIVE]
[  103.051505] chmc: UltraSPARC-III memory controller at /memory-
controller@5,400000 [ACTIVE]
[  103.059732] chmc: UltraSPARC-III memory controller at /memory-
controller@6,400000 [ACTIVE]
[  103.067970] chmc: UltraSPARC-III memory controller at /memory-
controller@7,400000 [ACTIVE]
[  103.077213] audit: initializing netlink socket (disabled)
[  103.082589] type 00 audit(0.559:1): initialized

Pat
-- 
Purdue University Research Computing ---  http://www.rcac.purdue.edu/
The Computer Refuge                  ---  http://computer-refuge.org
