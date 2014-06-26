From: Meelis Roos <mroos@linux.ee>
Date: Thu, 26 Jun 2014 12:29:11 +0000
Subject: problem booting kernel compiled with gcc-4.9
Message-Id: <alpine.SOC.1.00.1406261446590.16879@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I noticed that gcc 4.9.0 for sparc has landed on Debian unstable so I 
gave it a try on V210. Does not boot with strange error about user 
windows. This is reproducible. Since the same kernel comiled with gcc 
4.6 booted fine, it's probably a gcc 4.9 difference.


[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4.a 2010/01/06 14:48'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Linux version 3.16.0-rc2-00211-gd7933ab (mroos@v210) (gcc version 4.9.0 (Debian 4.9.0-7) ) #96 SMP Thu Jun 26 14:56:25 EEST 2014
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:0a:f3:85
[    0.000000] PAGE_OFFSET is 0xfffffc0000000000 (max_phys_bits = 42)
[    0.000000] Kernel: Using 3 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1e,600000/isa@7/serial@0,3f8
[    0.000000] PROM: Built device tree with 118209 bytes of memory.
[    0.000000] Top of RAM: 0x10000000, Total RAM: 0x10000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x00000000-0x0fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0x0fffffff]
[    0.000000] On node 0 totalpages: 32768
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32768 pages, LIFO batch:7
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,ultra3,mul32,div32]
[    0.000000] CPU CAPS: [v8plus,vis,vis2]
[    0.000000] PERCPU: Embedded 6 pages/cpu @fffffc000f000000 s13184 r8192 d27776 u2097152
[    0.000000] pcpu-alloc: s13184 r8192 d27776 u2097152 alloc=1*4194304
[    0.000000] pcpu-alloc: [0] 0 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: root=/dev/sda2 ro mem%6M debug ignore_loglevel
[    0.000000] PID hash table entries: 1024 (order: 0, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 131072 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 253112K/262144K available (3478K kernel code, 306K rwdata, 760K rodata, 160K init, 4477K bss, 9032K reserved)
[    0.000000] SLUB: HWalign2, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Additional per-CPU info printed with stalls.
[    0.000000] NR_IRQS:255
[   27.652437] clocksource: mult[53555555] shift[24]
[   27.708683] clockevent: mult[3126e98] shift[32]
[   27.762932] Console: colour dummy device 80x25
[   27.816114] console [tty0] enabled
[   27.856850] bootconsole [earlyprom0] disabled
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4.a 2010/01/06 14:48'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Linux version 3.16.0-rc2-00211-gd7933ab (mroos@v210) (gcc version 4.9.0 (Debian 4.9.0-7) ) #96 SMP Thu Jun 26 14:56:25 EEST 2014
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:0a:f3:85
[    0.000000] PAGE_OFFSET is 0xfffffc0000000000 (max_phys_bits = 42)
[    0.000000] Kernel: Using 3 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1e,600000/isa@7/serial@0,3f8
[    0.000000] PROM: Built device tree with 118209 bytes of memory.
[    0.000000] Top of RAM: 0x10000000, Total RAM: 0x10000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x00000000-0x0fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0x0fffffff]
[    0.000000] On node 0 totalpages: 32768
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32768 pages, LIFO batch:7
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,ultra3,mul32,div32]
[    0.000000] CPU CAPS: [v8plus,vis,vis2]
[    0.000000] PERCPU: Embedded 6 pages/cpu @fffffc000f000000 s13184 r8192 d27776 u2097152
[    0.000000] pcpu-alloc: s13184 r8192 d27776 u2097152 alloc=1*4194304
[    0.000000] pcpu-alloc: [0] 0 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: root=/dev/sda2 ro mem%6M debug ignore_loglevel
[    0.000000] PID hash table entries: 1024 (order: 0, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 131072 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 253112K/262144K available (3478K kernel code, 306K rwdata, 760K rodata, 160K init, 4477K bss, 9032K reserved)
[    0.000000] SLUB: HWalign2, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Additional per-CPU info printed with stalls.
[    0.000000] NR_IRQS:255
[   27.652437] clocksource: mult[53555555] shift[24]
[   27.708683] clockevent: mult[3126e98] shift[32]
[   27.762932] Console: colour dummy device 80x25
[   27.816114] console [tty0] enabled
[   27.856850] bootconsole [earlyprom0] disabled
[   28.058966] Calibrating delay using timer specific routine.. 24.01 BogoMIPS (lpj0052)
[   28.058980] pid_max: default: 32768 minimum: 301
[   28.059076] Mount-cache hash table entries: 1024 (order: 0, 8192 bytes)
[   28.059087] Mountpoint-cache hash table entries: 1024 (order: 0, 8192 bytes)
[   28.061436] CPU 0: synchronized TICK with master CPU (last diff 0 cycles, maxerr 5 cycles)
[   28.061468] Brought up 2 CPUs
[   28.061501] Testing NMI watchdog ... OK.
[   28.262078] devtmpfs: initialized
[   28.319234] prandom: seed boundary self test passed
[   28.321039] prandom: 100 self tests passed
[   28.323810] NET: Registered protocol family 16
[   28.328148] /pci@1f,700000: TOMATILLO PCI Bus Module ver[4:0]
[   28.328167] /pci@1f,700000: PCI IO[7f601000000] MEM[7f700000000]
[   28.330186] PCI: Scanning PBM /pci@1f,700000
[   28.330303] schizo f0069c00: PCI host bridge to bus 0000:00
[   28.330321] pci_bus 0000:00: root bus resource [io  0x7f601000000-0x7f601ffffff] (bus address [0x0000-0xffffff])
[   28.330337] pci_bus 0000:00: root bus resource [mem 0x7f700000000-0x7f7ffffffff] (bus address [0x00000000-0xffffffff])
[   28.330352] pci_bus 0000:00: root bus resource [bus 00]
[   28.330456] pci 0000:00:02.0: PME# supported from D3hot
[   28.330673] pci 0000:00:02.1: PME# supported from D3hot
[   28.330994] /pci@1e,600000: TOMATILLO PCI Bus Module ver[4:0]
[   28.331010] /pci@1e,600000: PCI IO[7fe01000000] MEM[7ff00000000]
[   28.333184] PCI: Scanning PBM /pci@1e,600000
[   28.333321] schizo f00732d0: PCI host bridge to bus 0001:00
[   28.333345] pci_bus 0001:00: root bus resource [io  0x7fe01000000-0x7fe01ffffff] (bus address [0x0000-0xffffff])
[   28.333374] pci_bus 0001:00: root bus resource [mem 0x7ff00000000-0x7ffffffffff] (bus address [0x00000000-0xffffffff])
[   28.333401] pci_bus 0001:00: root bus resource [bus 00]
[   28.333648] pci 0001:00:06.0: quirk: [io  0x7fe01000800-0x7fe0100083f] claimed by ali7101 ACPI
[   28.333677] pci 0001:00:06.0: quirk: [io  0x7fe01000600-0x7fe0100061f] claimed by ali7101 SMB
[   28.333885] pci 0001:00:0a.0: PME# supported from D3cold
[   28.334429] /pci@1c,600000: TOMATILLO PCI Bus Module ver[4:0]
[   28.334449] /pci@1c,600000: PCI IO[7ce01000000] MEM[7cf00000000]
[   28.336598] PCI: Scanning PBM /pci@1c,600000
[   28.336724] schizo f007c6ac: PCI host bridge to bus 0002:00
[   28.336747] pci_bus 0002:00: root bus resource [io  0x7ce01000000-0x7ce01ffffff] (bus address [0x0000-0xffffff])
[   28.336773] pci_bus 0002:00: root bus resource [mem 0x7cf00000000-0x7cfffffffff] (bus address [0x00000000-0xffffffff])
[   28.336798] pci_bus 0002:00: root bus resource [bus 00]
[   28.336895] pci 0002:00:02.0: supports D1 D2
[   28.337081] pci 0002:00:02.1: supports D1 D2
[   28.337398] /pci@1d,700000: TOMATILLO PCI Bus Module ver[4:0]
[   28.337416] /pci@1d,700000: PCI IO[7c601000000] MEM[7c700000000]
[   28.339479] PCI: Scanning PBM /pci@1d,700000
[   28.339606] schizo f00859d4: PCI host bridge to bus 0003:00
[   28.339630] pci_bus 0003:00: root bus resource [io  0x7c601000000-0x7c601ffffff] (bus address [0x0000-0xffffff])
[   28.339657] pci_bus 0003:00: root bus resource [mem 0x7c700000000-0x7c7ffffffff] (bus address [0x00000000-0xffffffff])
[   28.339682] pci_bus 0003:00: root bus resource [bus 00]
[   28.339807] pci 0003:00:02.0: PME# supported from D3hot
[   28.340049] pci 0003:00:02.1: PME# supported from D3hot
[   28.370210] vgaarb: loaded
[   28.370520] SCSI subsystem initialized
[   28.371306] /pci@1e,600000/isa@7/rtc@0,70: RTC regs at 0x7fe01000070
[   28.371970] Switched to clocksource stick
[   28.376783] NET: Registered protocol family 2
[   28.377246] TCP established hash table entries: 2048 (order: 1, 16384 bytes)
[   28.377322] TCP bind hash table entries: 2048 (order: 2, 32768 bytes)
[   28.377437] TCP: Hash tables configured (established 2048 bind 2048)
[   28.377526] TCP: reno registered
[   28.377542] UDP hash table entries: 256 (order: 0, 8192 bytes)
[   28.377584] UDP-Lite hash table entries: 256 (order: 0, 8192 bytes)
[   28.377782] NET: Registered protocol family 1
[   28.377856] pci 0001:00:07.0: Activating ISA DMA hang workarounds
[   28.377893] PCI: Enabling device: (0001:00:0a.0), cmd 2
[   28.432020] PCI: CLS 64 bytes, default 64
[   28.432229] power: Control reg at 7fe01000800
[   28.432710] chmc: UltraSPARC-IIIi memory controller at /memory-controller@0,0
[   28.432746] chmc: UltraSPARC-IIIi memory controller at /memory-controller@1,0
[   28.433354] futex hash table entries: 512 (order: 2, 32768 bytes)
[   28.441892] msgmni has been set to 494
[   28.442452] io scheduler noop registered
[   28.442604] io scheduler cfq registered (default)
[   28.443225] f00aba6c: ttyS0 at MMIO 0x7fe010003f8 (irq = 15, base_baud = 115387) is a 16550A
[   28.443251] Console: ttyS0 (SU)
[   37.128656] console [ttyS0] enabled
[   37.174662] f00ad5ec: ttyS1 at MMIO 0x7fe010002e8 (irq = 15, base_baud = 115387) is a 16550A
[   37.286248] PCI: Enabling device: (0002:00:02.0), cmd 147
[   37.357777] sym0: <1010-66> rev 0x1 at pci 0002:00:02.0 irq 24
[   37.436603] sym0: No NVRAM, ID 7, Fast-80, LVD, parity checking
[   37.555033] sym0: SCSI BUS has been reset.
[   37.608823] scsi0 : sym-2.2.3
[   40.583144] scsi 0:0:0:0: Direct-Access     FUJITSU  MAW3073NCSUN72G  1703 PQ: 0 ANSI: 4
[   40.689631] scsi target0:0:0: tagged command queuing enabled, command queue depth 16.
[   40.792643] scsi target0:0:0: Beginning Domain Validation
[   40.869395] scsi target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
[   41.075788] scsi target0:0:0: Ending Domain Validation
[   45.255432] PCI: Enabling device: (0002:00:02.1), cmd 147
[   45.327001] sym1: <1010-66> rev 0x1 at pci 0002:00:02.1 irq 25
[   45.405837] sym1: No NVRAM, ID 7, Fast-80, LVD, parity checking
[   45.524248] sym1: SCSI BUS has been reset.
[   45.578043] scsi1 : sym-2.2.3
[   53.004044] mousedev: PS/2 mouse device common for all mice
[   53.004902] sd 0:0:0:0: [sda] 143374738 512-byte logical blocks: (73.4 GB/68.3 GiB)
[   53.007810] sd 0:0:0:0: [sda] Write Protect is off
[   53.007816] sd 0:0:0:0: [sda] Mode Sense: c7 00 00 08
[   53.008945] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   53.428182] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[   53.511742] rtc_cmos rtc_cmos: no alarms, 114 bytes nvram
[   53.583109] TCP: cubic registered
[   53.626603] NET: Registered protocol family 17
[   53.685941] rtc_cmos rtc_cmos: setting system clock to 2014-06-26 12:05:58 UTC (1403784358)
[   53.693569]  sda: sda1 sda2 sda3 sda4
[   53.699149] sd 0:0:0:0: [sda] Attached SCSI disk
[   53.910103] EXT4-fs (sda2): couldn't mount as ext3 due to feature incompatibilities
[   54.011911] EXT4-fs (sda2): couldn't mount as ext2 due to feature incompatibilities
[   54.136507] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[   54.237263] VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
[   54.340199] devtmpfs: mounted
[   54.451346] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
[   54.451346] 
[   54.571516] CPU: 1 PID: 1 Comm: init Not tainted 3.16.0-rc2-00211-gd7933ab #96
[   54.666431] Call Trace:
[   54.698453]  [0000000000762f8c] panic+0xb0/0x224
[   54.759071]  [000000000045cf68] do_exit+0x948/0x960
[   54.823123]  [000000000042cbc0] fault_in_user_windows+0xe0/0x100
[   54.902036]  [0000000000404ad0] __handle_user_windows+0x0/0x10
[   54.978662] Press Stop-A (L1-A) to return to the boot prom
[   55.050713] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004


-- 
Meelis Roos (mroos@linux.ee)
