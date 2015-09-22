From: Meelis Roos <mroos@linux.ee>
Date: Tue, 22 Sep 2015 06:59:41 +0000
Subject: Re: blk_mq_register_disk: kobject (00000000009f2dd8): tried to init an initialized object, something
Message-Id: <alpine.LRH.2.20.1509220957510.21274@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1509141548050.31198@math.ut.ee> <CACVXFVN2fgG_rLTMby=bY+1sWzoGryKq_aCU2S0=chAX9MUvog@mail.gmail.com> <alpine.LRH.2.20.1509211024110.530@math.ut.ee> <CACVXFVNe5TrYr9gPrR4ggtg1cSbCcNt4_=vkBsGOv3fKocCzPg@mail.gmail.com>
 <alpine.LRH.2.20.1509211338410.530@math.ut.ee> <CACVXFVO4cp7W7K=rkrD3j+EWzmJu1zbwmi1myTEA24bovdi9MQ@mail.gmail.com>
In-Reply-To: <CACVXFVO4cp7W7K=rkrD3j+EWzmJu1zbwmi1myTEA24bovdi9MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Ming Lei <tom.leiming@gmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>

> > Yes, sorry - I applied the last chunk by hand because it was mangled by
> > the web UI, and added ti to a wrong struct.
> >
> > Now I tested it on top of 4.3.0-rc1. COmpiles, rebooted fine 6 times,
> > but now it hangs again, seems to be the same message:
> >
> > [  107.143910] kobject (00000000009f2dd8): tried to init an initialized object, something is seriously wrong.
> 
> Looks a bit odd since blk_mq_register_disk is run only once per device,
> could you apply the attached debug patch and post the boot log when the
> warning is triggered?

Applied it, below is serial console poutput rfom one good boot and one 
failing boot.


Sun Enterprise 220R (2 X UltraSPARC-II 360MHz), No Keyboard
OpenBoot 3.31, 1024 MB memory installed, Serial #13083521.
Ethernet address 8:0:20:c7:a3:81, Host ID: 80c7a381.



Initializing Memory \                                                                      Initializing Memory /-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\                                                                      Initializing Memory \|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/
 -\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-                                                                      Initializing Memory \|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-                                                                      Initializing Memory \|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-
 \|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-                                                                      Rebooting with command: boot
Boot device: disk  File and args: 
SILO Version 1.4.14
boot: @@@@@@@@@@@@@@@@@@@@@@                      test
Allocated 64 Megs of memory at 0x40000000 for kernel
\Uncompressing image...
|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-
 \|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-Loaded kernel version 4.3.0

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:31'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Linux version 4.3.0-rc1-dirty (mroos@e220r) (gcc version 4.9.2 (Debian 4.9.2-20) ) #67 SMP Tue Sep 22 09:27:08 EEST 2015
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:c7:a3:81
[    0.000000] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits = 40)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.000000] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] OF stdout device is: /pci@1f,4000/ebus@1/se@14,400000:a
[    0.000000] PROM: Built device tree with 91663 bytes of memory.
[    0.000000] Top of RAM: 0xaff18000, Total RAM: 0x3ff06000
[    0.000000] Memory hole size: 1792MB
[    0.000000] Allocated 16384 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x00000000aff17fff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000]   node   0: [mem 0x0000000020000000-0x000000002fffffff]
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000008fffffff]
[    0.000000]   node   0: [mem 0x00000000a0000000-0x00000000afeedfff]
[    0.000000]   node   0: [mem 0x00000000aff00000-0x00000000aff17fff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000000aff17fff]
[    0.000000] On node 0 totalpages: 130947
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 130947 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    0.000000] CPU CAPS: [vis]
[    0.000000] PERCPU: Embedded 8 pages/cpu @fffff800af800000 s22976 r8192 d34368 u2097152
[    0.000000] pcpu-alloc: s22976 r8192 d34368 u2097152 alloc=1*4194304
[    0.000000] pcpu-alloc: [0] 0 2 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129923
[    0.000000] Kernel command line: root=/dev/sda2 ro ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 1022624K/1047576K available (4205K kernel code, 251K rwdata, 1288K rodata, 264K init, 418K bss, 24952K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign2, Order=0-3, MinObjects=0, CPUs=3, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=3.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leafd, nr_cpu_ids=3
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[  175.096110] clocksource: tick: mask: 0xffffffffffffffff max_cycles: 0x53092a6475, max_idle_ns: 440795218020 ns
[  175.215583] clocksource: mult[2c70935] shift[24]
[  175.270782] clockevent: mult[5c2b7411] shift[32]
[  175.326224] Console: colour dummy device 80x25
[  175.379156] console [tty0] enabled
[  175.419734] bootconsole [earlyprom0] disabled
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:31'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Linux version 4.3.0-rc1-dirty (mroos@e220r) (gcc version 4.9.2 (Debian 4.9.2-20) ) #67 SMP Tue Sep 22 09:27:08 EEST 2015
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:c7:a3:81
[    0.000000] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits = 40)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.000000] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] OF stdout device is: /pci@1f,4000/ebus@1/se@14,400000:a
[    0.000000] PROM: Built device tree with 91663 bytes of memory.
[    0.000000] Top of RAM: 0xaff18000, Total RAM: 0x3ff06000
[    0.000000] Memory hole size: 1792MB
[    0.000000] Allocated 16384 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x00000000aff17fff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000]   node   0: [mem 0x0000000020000000-0x000000002fffffff]
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000008fffffff]
[    0.000000]   node   0: [mem 0x00000000a0000000-0x00000000afeedfff]
[    0.000000]   node   0: [mem 0x00000000aff00000-0x00000000aff17fff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000000aff17fff]
[    0.000000] On node 0 totalpages: 130947
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 130947 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    0.000000] CPU CAPS: [vis]
[    0.000000] PERCPU: Embedded 8 pages/cpu @fffff800af800000 s22976 r8192 d34368 u2097152
[    0.000000] pcpu-alloc: s22976 r8192 d34368 u2097152 alloc=1*4194304
[    0.000000] pcpu-alloc: [0] 0 2 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129923
[    0.000000] Kernel command line: root=/dev/sda2 ro ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 1022624K/1047576K available (4205K kernel code, 251K rwdata, 1288K rodata, 264K init, 418K bss, 24952K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign2, Order=0-3, MinObjects=0, CPUs=3, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=3.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leafd, nr_cpu_ids=3
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[  175.096110] clocksource: tick: mask: 0xffffffffffffffff max_cycles: 0x53092a6475, max_idle_ns: 440795218020 ns
[  175.215583] clocksource: mult[2c70935] shift[24]
[  175.270782] clockevent: mult[5c2b7411] shift[32]
[  175.326224] Console: colour dummy device 80x25
[  175.379156] console [tty0] enabled
[  175.419734] bootconsole [earlyprom0] disabled
[  175.471836] kmemleak: Early log buffer exceeded (1388), please increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
[  175.621937] Calibrating delay using timer specific routine.. 721.54 BogoMIPS (lpj607746)
[  175.621986] pid_max: default: 32768 minimum: 301
[  175.622289] Mount-cache hash table entries: 2048 (order: 1, 16384 bytes)
[  175.622331] Mountpoint-cache hash table entries: 2048 (order: 1, 16384 bytes)
[  175.655087] CPU 2: synchronized TICK with master CPU (last diff 0 cycles, maxerr 437 cycles)
[  175.655189] Brought up 2 CPUs
[  175.656405] devtmpfs: initialized
[  175.664539] Performance events: No support for PMU type 'ultra12'
[  175.722735] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[  175.723442] kworker/u4:0 (19) used greatest stack depth: 11240 bytes left
[  175.724312] NET: Registered protocol family 16
[  175.727838] kworker/u4:1 (31) used greatest stack depth: 10904 bytes left
[  175.732898] kworker/u4:0 (50) used greatest stack depth: 10440 bytes left
[  175.735779] kworker/u4:1 (61) used greatest stack depth: 9496 bytes left
[  175.750488] /pci@1f,4000: PCI IO[1fe02010000] MEM[1ff80000000]
[  175.750577] /pci@1f,4000: PSYCHO PCI Bus Module ver[4:0]
[  175.750610] PCI: Scanning PBM /pci@1f,4000
[  175.751151] psycho f005fd74: PCI host bridge to bus 0000:00
[  175.751258] pci_bus 0000:00: root bus resource [io  0x1fe02010000-0x1fe0201ffff] (bus address [0x0000-0xffff])
[  175.751348] pci_bus 0000:00: root bus resource [mem 0x1ff80000000-0x1ffffffffff] (bus address [0x00000000-0x7fffffff])
[  175.751436] pci_bus 0000:00: root bus resource [bus 00]
[  175.756522] /pci@1f,2000: PCI IO[1fe02000000] MEM[1ff00000000]
[  175.756587] /pci@1f,2000: PSYCHO PCI Bus Module ver[4:0]
[  175.756633] PCI: Scanning PBM /pci@1f,2000
[  175.757034] psycho f00605f0: PCI host bridge to bus 0001:80
[  175.757101] pci_bus 0001:80: root bus resource [io  0x1fe02000000-0x1fe0200ffff] (bus address [0x0000-0xffff])
[  175.757195] pci_bus 0001:80: root bus resource [mem 0x1ff00000000-0x1ff7fffffff] (bus address [0x00000000-0x7fffffff])
[  175.757282] pci_bus 0001:80: root bus resource [bus 80]
[  175.806058] vgaarb: loaded
[  175.806776] SCSI subsystem initialized
[  175.809017] /pci@1f,4000/ebus@1/eeprom@14,0: Mostek regs at 0x1fff1000000
[  175.809971] AUXIO: Found device at /pci@1f,4000/ebus@1/auxio@14,726000
[  175.811480] clocksource: Switched to clocksource tick
[  175.839950] NET: Registered protocol family 2
[  175.841477] TCP established hash table entries: 8192 (order: 3, 65536 bytes)
[  175.841796] TCP bind hash table entries: 8192 (order: 4, 131072 bytes)
[  175.842297] TCP: Hash tables configured (established 8192 bind 8192)
[  175.842571] UDP hash table entries: 512 (order: 1, 16384 bytes)
[  175.842714] UDP-Lite hash table entries: 512 (order: 1, 16384 bytes)
[  175.843324] NET: Registered protocol family 1
[  175.843631] PCI: CLS 0 bytes, default 64
[  175.844134] power: Control reg at 1fff1724000
[  175.847330] futex hash table entries: 512 (order: 2, 32768 bytes)
[  175.848819] HugeTLB registered 8 MB page size, pre-allocated 0 pages
[  175.891430] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[  175.891529] io scheduler noop registered
[  175.892011] io scheduler cfq registered (default)
[  175.893043] f0061cc8: ttyS0 at MMIO 0x1fff1400000 (irq = 7, base_baud = 115200) is a SAB82532 V3.2
[  175.893130] Console: ttyS0 (SAB82532)
[  183.363122] console [ttyS0] enabled
[  183.405538] f0061cc8: ttyS1 at MMIO 0x1fff1400040 (irq = 7, base_baud = 115200) is a SAB82532 V3.2
[  183.513594] PCI: Enabling device: (0000:00:03.0), cmd 147
[  183.578637] sym0: <875> rev 0x14 at pci 0000:00:03.0 irq 13
[  183.731542] sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
[  183.807861] sym0: SCSI BUS has been reset.
[  183.855933] scsi host0: sym-2.2.3
[  183.900767] PCI: Enabling device: (0000:00:03.1), cmd 3
[  183.963654] sym1: <875> rev 0x14 at pci 0000:00:03.1 irq 14
[  184.116607] sym1: No NVRAM, ID 7, Fast-20, SE, parity checking
[  184.192881] sym1: SCSI BUS has been reset.
[  184.240940] scsi host1: sym-2.2.3
[  184.285181] PCI: Enabling device: (0000:00:02.0), cmd 3
[  184.348074] sym2: <875> rev 0x14 at pci 0000:00:02.0 irq 15
[  184.500830] sym2: No NVRAM, ID 7, Fast-20, SE, parity checking
[  184.577148] sym2: SCSI BUS has been reset.
[  184.625173] scsi host2: sym-2.2.3
[  184.669508] PCI: Enabling device: (0000:00:02.1), cmd 3
[  184.732372] sym3: <875> rev 0x14 at pci 0000:00:02.1 irq 16
[  184.885176] sym3: No NVRAM, ID 7, Fast-20, SE, parity checking
[  184.961450] sym3: SCSI BUS has been reset.
[  185.009471] scsi host3: sym-2.2.3
[  185.053834] PCI: Enabling device: (0000:00:04.0), cmd 3
[  185.116707] sym4: <875> rev 0x14 at pci 0000:00:04.0 irq 17
[  185.269559] sym4: No NVRAM, ID 7, Fast-20, SE, parity checking
[  185.345863] sym4: SCSI BUS has been reset.
[  185.393901] scsi host4: sym-2.2.3
[  185.438245] PCI: Enabling device: (0000:00:04.1), cmd 3
[  185.501123] sym5: <875> rev 0x14 at pci 0000:00:04.1 irq 18
[  185.653920] sym5: No NVRAM, ID 7, Fast-20, SE, parity checking
[  185.730130] sym5: SCSI BUS has been reset.
[  185.778208] scsi host5: sym-2.2.3
[  185.823413] mousedev: PS/2 mouse device common for all mice
[  185.890824] rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
[  185.972931] NET: Registered protocol family 10
[  186.027535] NET: Registered protocol family 17
[  186.079853] Key type dns_resolver registered
[  186.133649] cryptomgr_probe (470) used greatest stack depth: 9376 bytes left
[  186.218399] Key type encrypted registered
[  186.266458] console [netcon0] enabled
[  186.309401] netconsole: network logging started
[  186.363654] rtc-m48t59 rtc-m48t59.0: setting system clock to 2015-09-22 06:39:49 UTC (1442903989)?  187.000528] scsi 0:0:0:0: Direct-Access     QUANTUM  ATLAS10K3_36_SCA 020W PQ: 0 ANSI: 3
[  187.096534] scsi target0:0:0: tagged command queuing enabled, command queue depth 16.
[  187.190272] scsi target0:0:0: Beginning Domain Validation
[  187.258221] scsi target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 16)
[  187.346698] scsi target0:0:0: Domain Validation skipping write tests
[  187.421856] scsi target0:0:0: Ending Domain Validation
[  188.933613] scsi 0:0:6:0: CD-ROM            TOSHIBA  XM6201TASUN32XCD 1103 PQ: 0 ANSI: 2
[  189.029677] scsi target0:0:6: Beginning Domain Validation
[  189.096755] scsi target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 16)
[  189.180134] scsi target0:0:6: Domain Validation skipping write tests
[  189.255457] scsi target0:0:6: Ending Domain Validation
[  191.658798] sd 0:0:0:0: [sda] 71833096 512-byte logical blocks: (36.7 GB/34.2 GiB)
[  191.750304] sd 0:0:0:0: [sda] Write Protect is off
[  191.806772] sd 0:0:0:0: [sda] Mode Sense: e5 00 10 08
[  191.868497] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[  191.976632]  sda: sda1 sda2 sda3 sda4
[  192.021663] blk_mq_sysfs_init: init mq_kobj fffff800af2c0470
[  192.088609] blk_mq_sysfs_init: init hctx_kobj fffff800af2385f8 0
[  192.160422] blk_mq_sysfs_init: init ctx_kobj fffff800af80acd8 0
[  192.231225] blk_mq_sysfs_init: init ctx_kobj 00000000009f0cd8 1
[  192.302022] blk_mq_sysfs_init: init ctx_kobj fffff800afa0acd8 2
[  192.377221] sd 0:0:0:0: [sda] Attached SCSI disk
[  193.583171] EXT4-fs (sda2): couldn't mount as ext3 due to feature incompatibilities
[  193.674503] EXT4-fs (sda2): couldn't mount as ext2 due to feature incompatibilities
[  193.790583] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[  193.881437] VFS: Mounted root (ext4 filesystem) readonly on device 259:262144.
[  193.999230] devtmpfs: mounted
Mount failed for selinuxfs on /sys/fs/selinux:  No such file or directory
???????ɹ?????ѥ???
[  194.841127] stty (585) used greatest stack depth: 8216 bytes left
[  195.136962] tput (589) used greatest stack depth: 8088 bytes left
[info] Using makefile-style concurrent boot in runlevel S.
unparseable line (c! /dev/autofs 0600 - - - 10:235)
unparseable line (c! /dev/fuse 0600 - - - 10:229)
unparseable line (c! /dev/cuse 0600 - - - 10:20[  195.990845] random: udevd urandom read with 18 bits of entropy available
3)
unparseable line (c! /dev/loop-control 0600 - - - 10:237)
unparseable line (c! /dev/net/tun 0600 - - - 10:200)
unparseable line (c! /dev/uhid 0600 - - - 10:239)
[....] Starting the hotplug events dispatcher: udevdstarting version 218
[ ok .
[....] Synthesizing the initial hotplug events...[ ok done.
[  196.658099] net.agent (719) used greatest stack depth: 7976 bytes left
[  196.750984] PCI: Enabling device: (0000:00:01.1), cmd 2
[  196.812769] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
[.[  196.903997] eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:c7:a3:81
...] Waitin[  197.004993] sd 0:0:0:0: Attached scsi generic sg0 type 0
g for /[  197.075009] sr 0:0:6:0: [sr0] scsi-1 drive
[  197.115667] sr 0:0:6:0: Attached scsi generic sg1 type 5
[  197.187540] cdrom: Uniform CD-ROM driver Revision: 3.20
d[  197.251658] blk_mq_sysfs_init: init mq_kobj fffff800af2c19d0
[  197.318822] blk_mq_sysfs_init: init hctx_kobj fffff800af2529f8 0
[  197.390677] blk_mq_sysfs_init: init ctx_kobj fffff800af80c318 0
[  197.461483] blk_mq_sysfs_init: init ctx_kobj 00000000009f2318 1
[  197.532279] blk_mq_sysfs_init: init ctx_kobj fffff800afa0c318 2
[  197.603365] sr 0:0:6:0: Attached scsi CD-ROM sr0
[  197.622273] net.agent (727) used greatest stack depth: 7896 bytes left
ev to be fully populated...[  197.804005] cdrom_id (730) used greatest stack depth: 7736 bytes left
[  197.892384] scsi_id (731) used greatest stack depth: 7680 bytes left
[ ok done.
[....] Setting preliminary keymap...[ ok done.
[....] Activating swap...[  200.599946] Adding 1582392k swap on /dev/sda4.  Priority:-1 extents:1 across:1582392k 
[ ok done.
[  200.827742] EXT4-fs (sda2): re-mounted. Opts: (null)
[....] Checking root file system...fsck from util-linux 2.26.2
/dev/sda2: clean, 134577/2142112 files, 1454691/8558628 blocks
[ ok   201.168486] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
5hdone.
[....] Activating lvm and md swap...[ ok done.
[....] Checking file systems...fsck from util-lin[  202.194423] logsave (1100) used greatest stack depth: 7672 bytes left
ux 2.26.2
/dev/sda1: clean, 42/48192 files, 47510/96390 blocks
[ ok done.
[....] Cleaning up temporary files... /tmp[ ok   202.646587] blk_mq_sysfs_init: init mq_kobj fffff800af7e12b0
[  202.713415] blk_mq_sysfs_init: init hctx_kobj fffff800ad8555f8 0
[  202.785235] blk_mq_sysfs_init: init ctx_kobj fffff800af80b5d8 0
[  202.856058] blk_mq_sysfs_init: init ctx_kobj 00000000009f15d8 1
[  202.926871] blk_mq_sysfs_init: init ctx_kobj fffff800afa0b5d8 2
c[  202.999398] blk_mq_sysfs_init: init mq_kobj fffff800af7e0470
[  203.066520] blk_mq_sysfs_init: init hctx_kobj fffff800ae7ff9f8 0
[  203.138319] blk_mq_sysfs_init: init ctx_kobj fffff800af80bad8 0
[  203.209147] blk_mq_sysfs_init: init ctx_kobj 00000000009f1ad8 1
[  203.279953] blk_mq_sysfs_init: init ctx_kobj fffff800afa0bad8 2
.[  203.352436] blk_mq_sysfs_init: init mq_kobj fffff800af7e19d0
[  203.419522] blk_mq_sysfs_init: init hctx_kobj fffff800ae7fe9f8 0
[  203.491379] blk_mq_sysfs_init: init ctx_kobj fffff800af80c458 0
[  203.562219] blk_mq_sysfs_init: init ctx_kobj 00000000009f2458 1
[  203.633028] blk_mq_sysfs_init: init ctx_kobj fffff800afa0c458 2
[  203.705518] blk_mq_sysfs_init: init mq_kobj fffff800af7e20f0
[  203.772585] blk_mq_sysfs_init: init hctx_kobj fffff800ae7fd9f8 0
[  203.844456] blk_mq_sysfs_init: init ctx_kobj fffff800af80c6d8 0
[  203.915264] blk_mq_sysfs_init: init ctx_kobj 00000000009f26d8 1
[  203.986093] blk_mq_sysfs_init: init ctx_kobj fffff800afa0c6d8 2

[  204.059256] blk_mq_sysfs_init: init mq_kobj fffff800af7e2810
[  204.126114] blk_mq_sysfs_init: init hctx_kobj fffff800ae7fc9f8 0
[  204.197933] blk_mq_sysfs_init: init ctx_kobj fffff800af80c9d8 0
[  204.268743] blk_mq_sysfs_init: init ctx_kobj 00000000009f29d8 1
[  204.339578] blk_mq_sysfs_init: init ctx_kobj fffff800afa0c9d8 2
[  204.413525] blk_mq_sysfs_init: init mq_kobj fffff800af2c52d0
[  204.480310] blk_mq_sysfs_init: init hctx_kobj fffff800ad85a9f8 0
[  204.552162] blk_mq_sysfs_init: init ctx_kobj fffff800af80ccd8 0
[  204.622972] blk_mq_sysfs_init: init ctx_kobj 00000000009f2cd8 1
[  204.693784] blk_mq_sysfs_init: init ctx_kobj fffff800afa0ccd8 2
[  204.766557] blk_mq_sysfs_init: init mq_kobj fffff800af2c2f30
[  204.833356] blk_mq_sysfs_init: init hctx_kobj fffff800ad8589f8 0
[  204.905219] blk_mq_sysfs_init: init ctx_kobj fffff800af80cfd8 0
[  204.976032] blk_mq_sysfs_init: init ctx_kobj 00000000009f2fd8 1
[  205.046865] blk_mq_sysfs_init: init ctx_kobj fffff800afa0cfd8 2
[  205.120271] blk_mq_sysfs_init: init mq_kobj fffff800af2c59f0
[  205.187071] blk_mq_sysfs_init: init hctx_kobj fffff800adbfc1f8 0
[  205.258906] blk_mq_sysfs_init: init ctx_kobj fffff800af80d2d8 0
[  205.329737] blk_mq_sysfs_init: init ctx_kobj 00000000009f32d8 1
[  205.400550] blk_mq_sysfs_init: init ctx_kobj fffff800afa0d2d8 2
[  205.471598] loop: module loaded
[info] Loading kernel module loop.
[info] Loading kernel module openprom.
[  205.758331] EXT4-fs (sda1): mounting ext2 file system using the ext4 subsystem
[  205.861068] EXT4-fs (sda1): mounted filesystem without journal. Opts: (null)
[....] Mounting local filesystems...[ ok done.
[....] Activating swapfile swap...[ ok done.
[....] Cleaning up temporary files...[ ok .
[....] Setting kernel variables ...[ ok done.
[  207.021394] ip (1387) used greatest stack depth: 7352 bytes left
[....] Configuring network interfaces...Internet Systems Consortium DHCP Client 4.3.2
Copyright 2004-2015 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/eth0/08:00:20:c7:a3:81
Sending on   LPF/eth0/08:00:20:c7:a3:81
Sending on   Socket/fallback
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 6
[  211.108469] eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 15
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPOFFER from 192.168.78.2
DHCPACK from 192.168.78.2
bound to 192.168.78.24 -- renewal in 2866 seconds.
[ ok done.
[....] Cleaning up temporary files...[ ok .
[info] Setting console screen modes.
setterm: cannot (un)set powersave mode: Inappropriate ioctl for device
[....] Setting up console font and keymap...[ ok done.
[  215.417567] rc (584) used greatest stack depth: 6248 bytes left
INIT: Entering runlevel: 2
[info] Using makefile-style concurrent boot in runlevel 2.
[....] Starting uuid generator: uuidd[ ok .
[....] Starting enhanced syslogd: rsyslogd[ ok .
[....] Starting deferred execution scheduler: atd[ ok .
[....] Starting periodic command scheduler: cron[ ok .
[....] Starting SMP IRQ Balancer: irqbalance[ ok .
[....] Starting OpenBSD Secure Shell server: sshd[ ok .
[....] Starting MTA: exim4[ ok .

Debian GNU/Linux stretch/sid e220r ttyS0

e220r login: root
Password: 
Last login: Mon Sep 21 14:25:47 EEST 2015 on ttyS0
Linux e220r 4.3.0-rc1-dirty #67 SMP Tue Sep 22 09:27:08 EEST 2015 sparc64
root@e220r:~# reboot

Broadcast message from root@e220r (ttyS0) (Tue Sep 22 09:40:29 2015):

The system is going down for reboot NOW!
INIT: Switching to runlevel: 6ng MTA: exim4_listener[ ok .
[....] Asking all remaining processes to terminate...[ ok done.
[....] All processes ended within 1 seconds...[ ok done.
[....] Stopping enhanced syslogd: rsyslogd[ ok .
[....] Deconfiguring network interfaces...Removed stale PID file
Internet Systems Consortium DHCP Client 4.3.2
Copyright 2004-2015 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/eth0/08:00:20:c7:a3:81
Sending on   LPF/eth0/08:00:20:c7:a3:81
Sending on   Socket/fallback
DHCPRELEASE on eth0 to 192.168.78.2 port 67
[ ok done.
[info] Saving the system clock.
[info] Hardware Clock updated to Tue Sep 22 09:40:33 EEST 2015.
[....] Deactivating swap...[ ok done.
[....] Unmounting local filesystems...[[  230.701214] EXT4-fs (sda2): re-mounted. Opts: (null)
 ok done.
[info] Will now restart.
[  232.928945] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  232.990340] reboot: Restarting system
Resetting ... 


Sun Enterprise 220R (2 X UltraSPARC-II 360MHz), No Keyboard
OpenBoot 3.31, 1024 MB memory installed, Serial #13083521.
Ethernet address 8:0:20:c7:a3:81, Host ID: 80c7a381.



Initializing Memory \                                                                      Initializing Memory /-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\                                                                      Initializing Memory \|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/
 -\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-                                                                      Initializing Memory \|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-                                                                      Initializing Memory \|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-
 \|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-                                                                      Rebooting with command: boot
Boot device: disk  File and args: 
SILO Version 1.4.14
boot: boot: 
Allocated 64 Megs of memory at 0x40000000 for kernel
\Uncompressing image...
|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-
 \|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-Loaded kernel version 4.3.0

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:31'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Linux version 4.3.0-rc1-dirty (mroos@e220r) (gcc version 4.9.2 (Debian 4.9.2-20) ) #67 SMP Tue Sep 22 09:27:08 EEST 2015
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:c7:a3:81
[    0.000000] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits = 40)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.000000] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] OF stdout device is: /pci@1f,4000/ebus@1/se@14,400000:a
[    0.000000] PROM: Built device tree with 91663 bytes of memory.
[    0.000000] Top of RAM: 0xaff18000, Total RAM: 0x3ff06000
[    0.000000] Memory hole size: 1792MB
[    0.000000] Allocated 16384 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x00000000aff17fff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000]   node   0: [mem 0x0000000020000000-0x000000002fffffff]
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000008fffffff]
[    0.000000]   node   0: [mem 0x00000000a0000000-0x00000000afeedfff]
[    0.000000]   node   0: [mem 0x00000000aff00000-0x00000000aff17fff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000000aff17fff]
[    0.000000] On node 0 totalpages: 130947
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 130947 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    0.000000] CPU CAPS: [vis]
[    0.000000] PERCPU: Embedded 8 pages/cpu @fffff800af800000 s22976 r8192 d34368 u2097152
[    0.000000] pcpu-alloc: s22976 r8192 d34368 u2097152 alloc=1*4194304
[    0.000000] pcpu-alloc: [0] 0 2 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129923
[    0.000000] Kernel command line: root=/dev/sda2 ro ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 1022624K/1047576K available (4205K kernel code, 251K rwdata, 1288K rodata, 264K init, 418K bss, 24952K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign2, Order=0-3, MinObjects=0, CPUs=3, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=3.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leafd, nr_cpu_ids=3
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[   70.662658] clocksource: tick: mask: 0xffffffffffffffff max_cycles: 0x53091067f2, max_idle_ns: 440795206913 ns
[   70.782131] clocksource: mult[2c70a13] shift[24]
[   70.837330] clockevent: mult[5c2b573e] shift[32]
[   70.892771] Console: colour dummy device 80x25
[   70.945703] console [tty0] enabled
[   70.986280] bootconsole [earlyprom0] disabled
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:31'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Linux version 4.3.0-rc1-dirty (mroos@e220r) (gcc version 4.9.2 (Debian 4.9.2-20) ) #67 SMP Tue Sep 22 09:27:08 EEST 2015
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:c7:a3:81
[    0.000000] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits = 40)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.000000] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] OF stdout device is: /pci@1f,4000/ebus@1/se@14,400000:a
[    0.000000] PROM: Built device tree with 91663 bytes of memory.
[    0.000000] Top of RAM: 0xaff18000, Total RAM: 0x3ff06000
[    0.000000] Memory hole size: 1792MB
[    0.000000] Allocated 16384 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x00000000aff17fff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000]   node   0: [mem 0x0000000020000000-0x000000002fffffff]
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000008fffffff]
[    0.000000]   node   0: [mem 0x00000000a0000000-0x00000000afeedfff]
[    0.000000]   node   0: [mem 0x00000000aff00000-0x00000000aff17fff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000000aff17fff]
[    0.000000] On node 0 totalpages: 130947
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 130947 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    0.000000] CPU CAPS: [vis]
[    0.000000] PERCPU: Embedded 8 pages/cpu @fffff800af800000 s22976 r8192 d34368 u2097152
[    0.000000] pcpu-alloc: s22976 r8192 d34368 u2097152 alloc=1*4194304
[    0.000000] pcpu-alloc: [0] 0 2 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129923
[    0.000000] Kernel command line: root=/dev/sda2 ro ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 1022624K/1047576K available (4205K kernel code, 251K rwdata, 1288K rodata, 264K init, 418K bss, 24952K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign2, Order=0-3, MinObjects=0, CPUs=3, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=3.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leafd, nr_cpu_ids=3
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[   70.662658] clocksource: tick: mask: 0xffffffffffffffff max_cycles: 0x53091067f2, max_idle_ns: 440795206913 ns
[   70.782131] clocksource: mult[2c70a13] shift[24]
[   70.837330] clockevent: mult[5c2b573e] shift[32]
[   70.892771] Console: colour dummy device 80x25
[   70.945703] console [tty0] enabled
[   70.986280] bootconsole [earlyprom0] disabled
[   71.038382] kmemleak: Early log buffer exceeded (1388), please increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
[   71.188479] Calibrating delay using timer specific routine.. 721.52 BogoMIPS (lpj607625)
[   71.188529] pid_max: default: 32768 minimum: 301
[   71.188830] Mount-cache hash table entries: 2048 (order: 1, 16384 bytes)
[   71.188872] Mountpoint-cache hash table entries: 2048 (order: 1, 16384 bytes)
[   71.221630] CPU 2: synchronized TICK with master CPU (last diff 0 cycles, maxerr 436 cycles)
[   71.221732] Brought up 2 CPUs
[   71.222941] devtmpfs: initialized
[   71.231050] Performance events: No support for PMU type 'ultra12'
[   71.289274] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[   71.290001] kworker/u4:0 (19) used greatest stack depth: 11240 bytes left
[   71.291075] NET: Registered protocol family 16
[   71.300156] kworker/u4:0 (50) used greatest stack depth: 10440 bytes left
[   71.302892] kworker/u4:0 (60) used greatest stack depth: 9496 bytes left
[   71.317996] /pci@1f,4000: PCI IO[1fe02010000] MEM[1ff80000000]
[   71.318087] /pci@1f,4000: PSYCHO PCI Bus Module ver[4:0]
[   71.318120] PCI: Scanning PBM /pci@1f,4000
[   71.318664] psycho f005fd74: PCI host bridge to bus 0000:00
[   71.318727] pci_bus 0000:00: root bus resource [io  0x1fe02010000-0x1fe0201ffff] (bus address [0x0000-0xffff])
[   71.318959] pci_bus 0000:00: root bus resource [mem 0x1ff80000000-0x1ffffffffff] (bus address [0x00000000-0x7fffffff])
[   71.319048] pci_bus 0000:00: root bus resource [bus 00]
[   71.324468] /pci@1f,2000: PCI IO[1fe02000000] MEM[1ff00000000]
[   71.324533] /pci@1f,2000: PSYCHO PCI Bus Module ver[4:0]
[   71.324580] PCI: Scanning PBM /pci@1f,2000
[   71.325022] psycho f00605f0: PCI host bridge to bus 0001:80
[   71.325090] pci_bus 0001:80: root bus resource [io  0x1fe02000000-0x1fe0200ffff] (bus address [0x0000-0xffff])
[   71.325181] pci_bus 0001:80: root bus resource [mem 0x1ff00000000-0x1ff7fffffff] (bus address [0x00000000-0x7fffffff])
[   71.325268] pci_bus 0001:80: root bus resource [bus 80]
[   71.362709] vgaarb: loaded
[   71.363602] SCSI subsystem initialized
[   71.366158] /pci@1f,4000/ebus@1/eeprom@14,0: Mostek regs at 0x1fff1000000
[   71.367204] AUXIO: Found device at /pci@1f,4000/ebus@1/auxio@14,726000
[   71.367777] clocksource: Switched to clocksource tick
[   71.398831] NET: Registered protocol family 2
[   71.400476] TCP established hash table entries: 8192 (order: 3, 65536 bytes)
[   71.400975] TCP bind hash table entries: 8192 (order: 4, 131072 bytes)
[   71.401858] TCP: Hash tables configured (established 8192 bind 8192)
[   71.402150] UDP hash table entries: 512 (order: 1, 16384 bytes)
[   71.402334] UDP-Lite hash table entries: 512 (order: 1, 16384 bytes)
[   71.402980] NET: Registered protocol family 1
[   71.403259] PCI: CLS 0 bytes, default 64
[   71.403620] power: Control reg at 1fff1724000
[   71.406483] futex hash table entries: 512 (order: 2, 32768 bytes)
[   71.407736] kworker/u4:0 (282) used greatest stack depth: 9408 bytes left
[   71.408180] HugeTLB registered 8 MB page size, pre-allocated 0 pages
[   71.451610] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[   71.451707] io scheduler noop registered
[   71.452191] io scheduler cfq registered (default)
[   71.453381] f0061cc8: ttyS0 at MMIO 0x1fff1400000 (irq = 7, base_baud = 115200) is a SAB82532 V3.2
[   71.453467] Console: ttyS0 (SAB82532)
[   78.923416] console [ttyS0] enabled
[   78.965771] f0061cc8: ttyS1 at MMIO 0x1fff1400040 (irq = 7, base_baud = 115200) is a SAB82532 V3.2
[   79.074073] PCI: Enabling device: (0000:00:03.0), cmd 147
[   79.139138] sym0: <875> rev 0x14 at pci 0000:00:03.0 irq 13
[   79.292057] sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
[   79.368413] sym0: SCSI BUS has been reset.
[   79.416518] scsi host0: sym-2.2.3
[   79.461462] PCI: Enabling device: (0000:00:03.1), cmd 3
[   79.524375] sym1: <875> rev 0x14 at pci 0000:00:03.1 irq 14
[   79.677160] sym1: No NVRAM, ID 7, Fast-20, SE, parity checking
[   79.753384] sym1: SCSI BUS has been reset.
[   79.801440] scsi host1: sym-2.2.3
[   79.845576] PCI: Enabling device: (0000:00:02.0), cmd 3
[   79.908475] sym2: <875> rev 0x14 at pci 0000:00:02.0 irq 15
[   80.061202] sym2: No NVRAM, ID 7, Fast-20, SE, parity checking
[   80.137382] sym2: SCSI BUS has been reset.
[   80.185458] scsi host2: sym-2.2.3
[   80.229651] PCI: Enabling device: (0000:00:02.1), cmd 3
[   80.292563] sym3: <875> rev 0x14 at pci 0000:00:02.1 irq 16
[   80.445379] sym3: No NVRAM, ID 7, Fast-20, SE, parity checking
[   80.521602] sym3: SCSI BUS has been reset.
[   80.569655] scsi host3: sym-2.2.3
[   80.613878] PCI: Enabling device: (0000:00:04.0), cmd 3
[   80.676846] sym4: <875> rev 0x14 at pci 0000:00:04.0 irq 17
[   80.829660] sym4: No NVRAM, ID 7, Fast-20, SE, parity checking
[   80.905923] sym4: SCSI BUS has been reset.
[   80.953995] scsi host4: sym-2.2.3
[   80.998338] PCI: Enabling device: (0000:00:04.1), cmd 3
[   81.061220] sym5: <875> rev 0x14 at pci 0000:00:04.1 irq 18
[   81.214066] sym5: No NVRAM, ID 7, Fast-20, SE, parity checking
[   81.290357] sym5: SCSI BUS has been reset.
[   81.338397] scsi host5: sym-2.2.3
[   81.383608] mousedev: PS/2 mouse device common for all mice
[   81.451031] rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
[   81.533056] NET: Registered protocol family 10
[   81.587390] NET: Registered protocol family 17
[   81.639671] Key type dns_resolver registered
[   81.695033] Key type encrypted registered
[   81.743139] console [netcon0] enabled
[   81.786042] netconsole: network logging started
[   81.840275] rtc-m48t59 rtc-m48t59.0: setting system clock to 2015-09-22 06:41:57 UTC (1442904117)?   82.497780] scsi 0:0:0:0: Direct-Access     QUANTUM  ATLAS10K3_36_SCA 020W PQ: 0 ANSI: 3
[   82.593817] scsi target0:0:0: tagged command queuing enabled, command queue depth 16.
[   82.687549] scsi target0:0:0: Beginning Domain Validation
[   82.755499] scsi target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 16)
[   82.844004] scsi target0:0:0: Domain Validation skipping write tests
[   82.919133] scsi target0:0:0: Ending Domain Validation
[   84.494158] scsi 0:0:6:0: CD-ROM            TOSHIBA  XM6201TASUN32XCD 1103 PQ: 0 ANSI: 2
[   84.590177] scsi target0:0:6: Beginning Domain Validation
[   84.656337] scsi target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 16)
[   84.740053] scsi target0:0:6: Domain Validation skipping write tests
[   84.815221] scsi target0:0:6: Ending Domain Validation
[   87.219111] sd 0:0:0:0: [sda] 71833096 512-byte logical blocks: (36.7 GB/34.2 GiB)
[   87.310497] sd 0:0:0:0: [sda] Write Protect is off
[   87.366868] sd 0:0:0:0: [sda] Mode Sense: e5 00 10 08
[   87.428652] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   87.536801]  sda: sda1 sda2 sda3 sda4
[   87.581984] blk_mq_sysfs_init: init mq_kobj fffff800af350470
[   87.648825] blk_mq_sysfs_init: init hctx_kobj fffff800af254df8 0
[   87.720681] blk_mq_sysfs_init: init ctx_kobj fffff800af80acd8 0
[   87.791500] blk_mq_sysfs_init: init ctx_kobj 00000000009f0cd8 1
[   87.862308] blk_mq_sysfs_init: init ctx_kobj fffff800afa0acd8 2
[   87.937619] sd 0:0:0:0: [sda] Attached SCSI disk
[   89.143794] EXT4-fs (sda2): couldn't mount as ext3 due to feature incompatibilities
[   89.235227] EXT4-fs (sda2): couldn't mount as ext2 due to feature incompatibilities
[   89.351151] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[   89.441934] VFS: Mounted root (ext4 filesystem) readonly on device 259:262144.
[   89.559842] devtmpfs: mounted
Mount failed for selinuxfs on /sys/fs/selinux:  No such file or directory
???????ɹ?????ѥ???
[   90.377824] stty (586) used greatest stack depth: 8216 bytes left
[   90.619803] tput (590) used greatest stack depth: 8088 bytes left
[info] Using makefile-style concurrent boot in runlevel S.
unparseable line (c! /dev/autofs 0600 - - - 10:235)
unparseable line (c! /dev/fuse 0600 - - - 10:229)
unparseable line (c! /dev/cuse 0600 - - - 10:203)
un[   91.467690] random: udevd urandom read with 18 bits of entropy available
parseable line (c! /dev/loop-control 0600 - - - 10:237)
unparseable line (c! /dev/net/tun 0600 - - - 10:200)
unparseable line (c! /dev/uhid 0600 - - - 10:239)
[....] Starting the hotplug events dispatcher: udevdstarting version 218
[ ok .
[....] Synthesizing the initial hotplug events...[ ok done.
[   92.140289] net.agent (719) used greatest stack depth: 7976 bytes left
[....] Waiting for /d[   92.245495] PCI: Enabling device: (0000:00:01.1), cmd 2
[   92.307871] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
ev[   92.399229] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   92.401521] sr 0:0:6:0: [sr0] scsi-1 drive
[   92.401532] cdrom: Uniform CD-ROM driver Revision: 3.20
[   92.403651] blk_mq_sysfs_init: init mq_kobj fffff800af353650
[   92.403659] blk_mq_sysfs_init: init hctx_kobj fffff800af2555f8 0
[   92.403665] blk_mq_sysfs_init: init ctx_kobj fffff800af80c718 0
[   92.403671] blk_mq_sysfs_init: init ctx_kobj 00000000009f2718 1
[   92.403678] blk_mq_sysfs_init: init ctx_kobj fffff800afa0c718 2
[   92.403944] sr 0:0:6:0: Attached scsi CD-ROM sr0
[   92.517235] eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:c7:a3:81
[   92.763783] net.agent (726) used greatest stack depth: 7800 bytes left
[   93.148709] sr 0:0:6:0: Attached scsi generic sg1 type 5
 to be fully populated...[   93.250985] cdrom_id (730) used greatest stack depth: 7680 bytes left
[ ok done.
[....] Setting preliminary keymap...[   94.508385] pidof (760) used greatest stack depth: 7152 bytes left
[ ok done.
[....] Activating swap...[   96.250321] Adding 1582392k swap on /dev/sda4.  Priority:-1 extents:1 across:1582392k 
[ ok done.
[   96.478514] EXT4-fs (sda2): re-mounted. Opts: (null)
[....] Checking root file system...fsck from util-linux 2.26.2
/dev/sda2: clean, 134577/2142112 files, 1454712/8558628 blocks
[ ok [   96.794961] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
done.
[....] Activating lvm and md swap...[ ok done.
[....] Checking file systems...fsck from util-linux 2.26.2
/dev/sda1: clean, 42/48192 files, 47510/96390 blocks
[ ok done.
[....] Cleaning up temporary files... /tmp[ ok .
[   98.231131] blk_mq_sysfs_init: init mq_kobj fffff800ae6f99d0
[   98.297976] blk_mq_sysfs_init: init hctx_kobj fffff800ad8c51f8 0
[   98.369808] blk_mq_sysfs_init: init ctx_kobj fffff800af80b5d8 0
[   98.440618] blk_mq_sysfs_init: init ctx_kobj 00000000009f15d8 1
[   98.511427] blk_mq_sysfs_init: init ctx_kobj fffff800afa0b5d8 2
[   98.583949] blk_mq_sysfs_init: init mq_kobj fffff800ae6f8470
[   98.650792] blk_mq_sysfs_init: init hctx_kobj fffff800ad8c45f8 0
[   98.722652] blk_mq_sysfs_init: init ctx_kobj fffff800af80b9d8 0
[   98.793494] blk_mq_sysfs_init: init ctx_kobj 00000000009f19d8 1
[   98.864321] blk_mq_sysfs_init: init ctx_kobj fffff800afa0b9d8 2
[   98.937090] blk_mq_sysfs_init: init mq_kobj fffff800ae6f8b90
[   99.003879] blk_mq_sysfs_init: init hctx_kobj fffff800ad8c75f8 0
[   99.075742] blk_mq_sysfs_init: init ctx_kobj fffff800af80c4d8 0
[   99.146544] blk_mq_sysfs_init: init ctx_kobj 00000000009f24d8 1
[   99.217387] blk_mq_sysfs_init: init ctx_kobj fffff800afa0c4d8 2
[   99.289866] blk_mq_sysfs_init: init mq_kobj fffff800ae6f92b0
[   99.356737] blk_mq_sysfs_init: init hctx_kobj fffff800ad8bb5f8 0
[   99.428575] blk_mq_sysfs_init: init ctx_kobj fffff800af80c858 0
[   99.499416] blk_mq_sysfs_init: init ctx_kobj 00000000009f2858 1
[   99.570225] blk_mq_sysfs_init: init ctx_kobj fffff800afa0c858 2
[   99.642729] blk_mq_sysfs_init: init mq_kobj fffff800ae6fa0f0
[   99.709602] blk_mq_sysfs_init: init hctx_kobj fffff800ad8ba5f8 0
[   99.781450] blk_mq_sysfs_init: init ctx_kobj fffff800af80cad8 0
[   99.852263] blk_mq_sysfs_init: init ctx_kobj 00000000009f2ad8 1
[   99.923092] blk_mq_sysfs_init: init ctx_kobj fffff800afa0cad8 2
[   99.996428] blk_mq_sysfs_init: init mq_kobj fffff800ae6fa810
[  100.063323] blk_mq_sysfs_init: init hctx_kobj fffff800ad8b95f8 0
[  100.135151] blk_mq_sysfs_init: init ctx_kobj fffff800af80cdd8 0
[  100.205952] blk_mq_sysfs_init: init ctx_kobj 00000000009f2dd8 1
[  100.276785] kobject (00000000009f2dd8): tried to init an initialized object, something is seriously wrong.
[  100.392427] CPU: 2 PID: 1156 Comm: modprobe Not tainted 4.3.0-rc1-dirty #67
[  100.475720] Call Trace:
[  100.504872]  [00000000006545c0] kobject_init+0x80/0xa0
[  100.566333]  [0000000000640cc4] blk_mq_register_disk+0xa4/0x1e0
[  100.637162]  [0000000000636550] blk_register_queue+0x70/0x120
[  100.705886]  [0000000000643bbc] add_disk+0x19c/0x460
[  100.765265]  [000000001003f800] loop_add+0x1a0/0x240 [loop]
[  100.831926]  [0000000010046168] loop_init+0x168/0x1b0 [loop]
[  100.899606]  [0000000000426c00] do_one_initcall+0x80/0x1c0
[  100.965233]  [00000000004de3c4] do_init_module+0x48/0x1e4
[  101.029799]  [00000000004c7654] load_module+0xf14/0x11e0
[  101.093339]  [00000000004c7ab4] SyS_finit_module+0x74/0xa0
[  101.158957]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  101.229772] blk_mq_sysfs_init: init ctx_kobj fffff800afa0cdd8 2
[  101.301112] Unable to handle kernel paging request at virtual address 000000018f090000
[  101.395395] tsk->{mm,active_mm}->context = 00000000000003c4
[  101.462008] tsk->{mm,active_mm}->pgd = fffff800ada44000
[  101.524508]               \|/ ____ \|/
[  101.524508]               "@'/ .. \`@"
[  101.524508]               /_| \__/ |_\
[  101.524508]                  \__U_/
[  101.700608] modprobe(1156): Oops [#1]
[  101.744262] CPU: 2 PID: 1156 Comm: modprobe Not tainted 4.3.0-rc1-dirty #67
[  101.827598] task: fffff800af2e1a00 ti: fffff800adbec000 task.ti: fffff800adbec000
[  101.917177] TSTATE: 0000004411001607 TPC: 0000000000481384 TNPC: 0000000000481388 Y: 00000000    Not tainted
[  102.034906] TPC: <wake_up_process+0x4/0x40>
[  102.084837] g0: 0000000000908b12 g1: 0000000000000000 g2: 0000000000000000 g3: 00000000009f2c00
[  102.189020] g4: fffff800af2e1a00 g5: fffff800af01a000 g6: fffff800adbec000 g7: fffff800ad00c6e8
[  102.293162] o0: 0000000000919000 o1: 0000000000000040 o2: 0000000000919000 o3: 00000000000000d0
[  102.397321] o4: 000000000097ea00 o5: 0000000000000040 sp: fffff800adbeecd1 ret_pc: 00000000005288a8
[  102.505646] RPC: <kmem_cache_alloc+0xe8/0x180>
[  102.558731] l0: fffff800af3a6db8 l1: 000000000000343c l2: fffff800af3a6db8 l3: 0000000000000001
[  102.662895] l4: 000000000000016e l5: 0000000000000001 l6: 0000000000003000 l7: 0000000000000002
[  102.767064] i0: 000000018f090680 i1: 000000000097ea00 i2: 000000000097ea00 i3: 0000000000479530
[  102.871197] i4: 000000000096d800 i5: fffff800af005bc0 i6: fffff800adbeed81 i7: 000000000047958c
[  102.975380] I7: <kthread_create_on_node+0x8c/0x140>
[  103.033642] Call Trace:
[  103.062810]  [000000000047958c] kthread_create_on_node+0x8c/0x140
[  103.135737]  [0000000000476874] __alloc_workqueue_key+0x274/0x460
[  103.208633]  [000000000062d68c] __bioset_create+0x20c/0x2a0
[  103.275312]  [0000000000631830] blk_alloc_queue_node+0x50/0x1e0
[  103.346118]  [000000000063e54c] blk_mq_init_queue+0xc/0x60
[  103.411753]  [000000001003f710] loop_add+0xb0/0x240 [loop]
[  103.477348]  [0000000010046168] loop_init+0x168/0x1b0 [loop]
[  103.545044]  [0000000000426c00] do_one_initcall+0x80/0x1c0
[  103.610650]  [00000000004de3c4] do_init_module+0x48/0x1e4
[  103.675237]  [00000000004c7654] load_module+0xf14/0x11e0
[  103.738758]  [00000000004c7ab4] SyS_finit_module+0x74/0xa0
[  103.804386]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  103.875186] Disabling lock debugging due to kernel taint
[  103.938742] Caller[000000000047958c]: kthread_create_on_node+0x8c/0x140
[  104.017885] Caller[0000000000476874]: __alloc_workqueue_key+0x274/0x460
[  104.097050] Caller[000000000062d68c]: __bioset_create+0x20c/0x2a0
[  104.169946] Caller[0000000000631830]: blk_alloc_queue_node+0x50/0x1e0
[  104.247032] Caller[000000000063e54c]: blk_mq_init_queue+0xc/0x60
[  104.318894] Caller[000000001003f710]: loop_add+0xb0/0x240 [loop]
[  104.390761] Caller[0000000010046168]: loop_init+0x168/0x1b0 [loop]
[  104.464688] Caller[0000000000426c00]: do_one_initcall+0x80/0x1c0
[  104.536562] Caller[00000000004de3c4]: do_init_module+0x48/0x1e4
[  104.607376] Caller[00000000004c7654]: load_module+0xf14/0x11e0
[  104.677170] Caller[00000000004c7ab4]: SyS_finit_module+0x74/0xa0
[  104.749022] Caller[00000000004061d4]: linux_sparc_syscall32+0x34/0x60
[  104.826097] Caller[0000000070015738]: 0x70015738
[  104.881275] Instruction DUMP: 01000000  01000000  9de3bf50 <c25e0000> 8208600c  0ac04005  11002409  b2102003  106fff12 
[ 105.012619] spitfire_data_access_exception: SFSR[000000000080100d] SFAR[0000066666666640], going.
[  105.118767]               \|/ ____ \|/
[  105.118767]               "@'/ .. \`@"
[  105.118767]               /_| \__/ |_\
[  105.118767]                  \__U_/
[  105.294806] kmod(1150): Dax [#2]
[  105.333276] CPU: 0 PID: 1150 Comm: kmod Tainted: G      D         4.3.0-rc1-dirty #67
[  105.427034] task: fffff800af2e6800 ti: fffff800adc4c000 task.ti: fffff800adc4c000
[  105.516604] TSTATE: 0000004411e01600 TPC: 0000000000477618 TNPC: 000000000047761c Y: 00000000    Tainted: G      D        
[  105.648904] TPC: <alloc_pid+0x418/0x480>
[  105.695716] g0: 0000000000000100 g1: 0000000000007790 g2: 6a20666666666638 g3: fffff800ae50b000
[  105.799895] g4: fffff800af2e6800 g5: fffff800aee1a000 g6: fffff800adc4c000 g7: 00000000009fa570
[  105.904044] o0: 000000000096a100 o1: 000000000097e470 o2: 0000000000000001 o3: 0000000000000001
[  106.008197] o4: 000000000096d800 o5: 4798000000000000 sp: fffff800adc4f351 ret_pc: 0000000000000040
[  106.116512] RPC: <0x40>
[  106.145643] l0: 0000000000000001 l1: ffffffffffffffff l2: 0000000000000000 l3: 0000000000000000
[  106.249828] l4: 000000000097e470 l5: fffff800ae50afc0 l6: 000000000097e468 l7: 000000000000048b
[  106.353978] i0: 00000000009f2de0 i1: 000000000097e970 i2: fffff800ae50afe0 i3: 000000000096a000
[  106.458128] i4: 00000000009f2de0 i5: 0000000000000034 i6: fffff800adc4f411 i7: 000000000045cb5c
[  106.562291] I7: <copy_process.isra.61.part.62+0xb7c/0x10e0>
[  106.628905] Call Trace:
[  106.658072]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  106.739318]  [000000000045d1f4] _do_fork+0x94/0x340
[  106.797646]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  106.860142]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  106.930956] Caller[000000000045cb5c]: copy_process.isra.61.part.62+0xb7c/0x10e0
[  107.018461] Caller[000000000045d1f4]: _do_fork+0x94/0x340
[  107.083013] Caller[000000000042cc14]: sparc_do_fork+0x34/0x60
[  107.151754] Caller[00000000004061d4]: linux_sparc_syscall32+0x34/0x60
[  107.228821] Caller[00000000f7bce714]: 0xf7bce714
[  107.284011] Instruction DUMP: c470c000  c6770001  2ac88002 <c670a008> c458fff8  8600ffe0  80a0c01a  c200a41c  82006001 
[  107.413153] BUG: sleeping function called from invalid context at include/linux/sched.h:2756
[  107.514215] in_atomic(): 1, irqs_disabled(): 1, pid: 1150, name: kmod
[  107.591269] CPU: 0 PID: 1150 Comm: kmod Tainted: G      D         4.3.0-rc1-dirty #67
[  107.685017] Call Trace:
[  107.714168]  [000000000046b590] exit_signals+0x10/0x160
[  107.776661]  [000000000045f8a4] do_exit+0x84/0xae0
[  107.833938]  [0000000000428758] die_if_kernel+0x198/0x320
[  107.898515]  [0000000000428be4] spitfire_data_access_exception.part.4+0x44/0x60
[  107.986024]  [00000000004290d0] spitfire_data_access_exception+0x50/0xa0
[  108.066203]  [000000000040587c] __spitfire_data_access_exception+0x34/0x44
[  108.148481]  [0000000000477618] alloc_pid+0x418/0x480
[  108.208884]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  108.290121]  [000000000045d1f4] _do_fork+0x94/0x340
[  108.348446]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  108.410937]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  108.481755] note: kmod[1150] exited with preempt_count 1
[  108.545310] ------------[ cut here ]------------
[  108.600509] WARNING: CPU: 0 PID: 1150 at kernel/smp.c:417 smp_call_function_many+0x1ec/0x280()
[  108.703616] Modules linked in: loop(+) sr_mod sunhme sg cdrom
[  108.772326] CPU: 0 PID: 1150 Comm: kmod Tainted: G      D         4.3.0-rc1-dirty #67
[  108.866087] Call Trace:
[  108.895233]  [000000000045dd60] warn_slowpath_common+0x60/0xa0
[  108.965021]  [00000000004c290c] smp_call_function_many+0x1ec/0x280
[  109.038982]  [000000000043ec0c] smp_flush_tlb_pending+0x4c/0xc0
[  109.109806]  [000000000044d120] flush_tlb_pending+0x80/0xc0
[  109.176450]  [000000000044d29c] arch_leave_lazy_mmu_mode+0x1c/0x40
[  109.250403]  [0000000000504388] unmap_single_vma+0x548/0x820
[  109.318089]  [000000000050501c] unmap_vmas+0x3c/0x60
[  109.377461]  [000000000050d440] exit_mmap+0x80/0x140
[  109.436818]  [000000000045bd58] mmput+0x58/0x100
[  109.492019]  [000000000045faa4] do_exit+0x284/0xae0
[  109.550344]  [0000000000428758] die_if_kernel+0x198/0x320
[  109.614919]  [0000000000428be4] spitfire_data_access_exception.part.4+0x44/0x60
[  109.702427]  [00000000004290d0] spitfire_data_access_exception+0x50/0xa0
[  109.782607]  [000000000040587c] __spitfire_data_access_exception+0x34/0x44
[  109.864887]  [0000000000477618] alloc_pid+0x418/0x480
[  109.925287]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  110.006522] ---[ end trace 1a1f6ea2c4a133bc ]---
[  110.062202] kmod (1150) used greatest stack depth: 6904 bytes left
[36minfo] Loading kernel module loop.

-- 
Meelis Roos (mroos@linux.ee)
