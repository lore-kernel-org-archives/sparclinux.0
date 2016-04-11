From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 11 Apr 2016 13:11:43 +0000
Subject: Kernel panic under qemu-system-sparc64 when adding kb_ps2/kdmouse DT nodes
Message-Id: <570BA28F.3020407@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all,

I'm working on improving the emulation of qemu-system-sparc64, and one
of the things I'm trying to do is get a framebuffer up and running which
means switching from serial keyboard/mouse devices over to PS/2 devices
currently used in QEMU.

Currently I'm setting up the DT based upon the tree at
http://irtfweb.ifa.hawaii.edu/~spex/computers/spex1/techdocs/111211-guidedog-failed/bigdog.prtconf.txt
and currently the nodes in OpenBIOS look like this:


0 > cd /pci/ebus/8042  ok
0 > ls
ffe2f388 kb_ps2@0
ffe2f6e0 kdmouse@1
 ok
0 > .properties
device_type               "8042"
name                      "8042"
reg                       00000014 00000060   00000008
                          00000014 00000060   00000008
#address-cells            1
#size-cells               0
interrupts                -- 8 : 00 00 00 01 00 00 00 02
 ok
0 > cd kb_ps2  ok
0 > .properties
name                      "kb_ps2"
device_type               "serial"
reg                       00000000
keyboard                  ffffffff
address                   60
 ok
0 > cd ..  ok
0 > cd kdmouse  ok
0 > .properties
name                      "kdmouse"
device_type               "mouse"
reg                       00000001
mouse                     ffffffff
address                   60
 ok


It seems that with these nodes enabled in the DT, I get a kernel panic
on boot:


[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.10.24 1999/01/01 01:01'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.1.0-rc5+ (build@kentang) (gcc version
5.1.0 (GCC) ) #3 SMP Sat Aug 1 18:15:57 BST 2015
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 52:54:00:12:34:56
[    0.000000] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits = 40)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.000000] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1fe,0/ebus@3/su
[    0.000000] PROM: Built device tree with 54608 bytes of memory.
[    0.000000] Top of RAM: 0xfe80000, Total RAM: 0xfe80000
[    0.000000] Memory hole size: 0MB
[    0.000000] Allocated 16384 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   DMA      empty
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000000fe7ffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fe7ffff]
[    0.000000] Initmem setup node 0 [mem
0x0000000000000000-0x000000000fe7ffff]
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    0.000000] CPU CAPS: [vis]
[    0.000000] PERCPU: Embedded 9 pages/cpu @fffff8000f800000 s32384
r8192 d33152 u4194304
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 32321
[    0.000000] Kernel command line:
[    0.000000] PID hash table entries: 1024 (order: 0, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 262144
bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 131072
bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 244976K/260608K available (4046K kernel code,
460K rwdata, 1288K rodata, 264K init, 628K bss, 15632K reserved, 0K
cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf, nr_cpu_ids=1
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[    5.162048] clocksource tick: mask: 0xffffffffffffffff max_cycles:
0x171024e7e0, max_idle_ns: 440795205315 ns
[    5.163050] clocksource: mult[a000000] shift[24]
[    5.163853] clockevent: mult[1999999a] shift[32]
[    5.168727] Console: colour dummy device 80x25
[    5.171411] console [tty0] enabled
[    5.172458] bootconsole [earlyprom0] disabled
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.10.24 1999/01/01 01:01'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.1.0-rc5+ (build@kentang) (gcc version
5.1.0 (GCC) ) #3 SMP Sat Aug 1 18:15:57 BST 2015
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 52:54:00:12:34:56
[    0.000000] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits = 40)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.000000] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1fe,0/ebus@3/su
[    0.000000] PROM: Built device tree with 54608 bytes of memory.
[    0.000000] Top of RAM: 0xfe80000, Total RAM: 0xfe80000
[    0.000000] Memory hole size: 0MB
[    0.000000] Allocated 16384 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   DMA      empty
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000000fe7ffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fe7ffff]
[    0.000000] Initmem setup node 0 [mem
0x0000000000000000-0x000000000fe7ffff]
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    0.000000] CPU CAPS: [vis]
[    0.000000] PERCPU: Embedded 9 pages/cpu @fffff8000f800000 s32384
r8192 d33152 u4194304
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 32321
[    0.000000] Kernel command line:
[    0.000000] PID hash table entries: 1024 (order: 0, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 262144
bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 131072
bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 244976K/260608K available (4046K kernel code,
460K rwdata, 1288K rodata, 264K init, 628K bss, 15632K reserved, 0K
cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf, nr_cpu_ids=1
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[    5.162048] clocksource tick: mask: 0xffffffffffffffff max_cycles:
0x171024e7e0, max_idle_ns: 440795205315 ns
[    5.163050] clocksource: mult[a000000] shift[24]
[    5.163853] clockevent: mult[1999999a] shift[32]
[    5.168727] Console: colour dummy device 80x25
[    5.171411] console [tty0] enabled
[    5.172458] bootconsole [earlyprom0] disabled
[    5.251704] Calibrating delay using timer specific routine.. 203.87
BogoMIPS (lpj@7757)
[    5.251937] pid_max: default: 32768 minimum: 301
[    5.252768] Security Framework initialized
[    5.254079] AppArmor: AppArmor disabled by boot time parameter
[    5.254432] Mount-cache hash table entries: 1024 (order: 0, 8192 bytes)
[    5.254493] Mountpoint-cache hash table entries: 1024 (order: 0, 8192
bytes)
[    5.263099] Initializing cgroup subsys blkio
[    5.263198] Initializing cgroup subsys devices
[    5.263308] Initializing cgroup subsys freezer
[    5.263396] Initializing cgroup subsys net_cls
[    5.263479] Initializing cgroup subsys perf_event
[    5.279949] Brought up 1 CPUs
[    5.288186] devtmpfs: initialized
[    5.291985] Performance events: No support for PMU type 'ultra12'
[    5.294785] clocksource jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    5.310345] NET: Registered protocol family 16
[    5.327377] /pci@1f,0: PCI IO[1fe02000000] MEM[1ff00100000]
[    5.327585] /pci@1f,0: Unable to request IOMMU resource.
[    5.327655] /pci@1f,0: SABRE PCI Bus Module ver[0:0]
[    5.327730] PCI: Scanning PBM /pci@1f,0
[    5.328662] sabre ffe2b5a8: PCI host bridge to bus 0000:00
[    5.329078] pci_bus 0000:00: root bus resource [io
0x1fe02000000-0x1fe0200ffff] (bus address [0x0000-0xffff])
[    5.329186] pci_bus 0000:00: root bus resource [mem
0x1ff00100000-0x1ff100fffff] (bus address [0x00000000-0x0fffffff])
[    5.329364] pci_bus 0000:00: root bus resource [bus 00-02]
[    5.336339] pci 0000:00:01.0: can't claim BAR 13 [io
0x1000000-0x1fffff]: no compatible bridge window
[    5.336458] pci 0000:00:01.1: can't claim BAR 13 [io
0x1000000-0x1fffff]: no compatible bridge window
[    5.358945] vgaarb: setting as boot device: PCI:0000:00:02.0
[    5.359164] vgaarb: device added:
PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    5.359292] vgaarb: loaded
[    5.359382] vgaarb: bridge control possible 0000:00:02.0
[    5.367024] /pci@1f,0/ebus@3/eeprom@14,2000: Mostek regs at 0x1fe02006000
[    5.369048] Switched to clocksource tick
[    5.436155] NET: Registered protocol family 2
[    5.441114] TCP established hash table entries: 2048 (order: 1, 16384
bytes)
[    5.441293] TCP bind hash table entries: 2048 (order: 2, 32768 bytes)
[    5.441451] TCP: Hash tables configured (established 2048 bind 2048)
[    5.442409] UDP hash table entries: 256 (order: 0, 8192 bytes)
[    5.442569] UDP-Lite hash table entries: 256 (order: 0, 8192 bytes)
[    5.444078] NET: Registered protocol family 1
[    5.452357] futex hash table entries: 256 (order: 1, 16384 bytes)
[    5.453130] audit: initializing netlink subsys (disabled)
[    5.453874] audit: type 00 audit(0.280:1): initialized
[    5.457471] HugeTLB registered 8 MB page size, pre-allocated 0 pages
[    5.459739] VFS: Disk quotas dquot_6.6.0
[    5.459973] VFS: Dquot-cache hash table entries: 1024 (order 0, 8192
bytes)
[    5.473751] alg: No test for stdrng (krng)
[    5.474018] bounce: pool size: 64 pages
[    5.474282] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 252)
[    5.474444] io scheduler noop registered
[    5.474535] io scheduler deadline registered
[    5.474838] io scheduler cfq registered (default)
[    5.478315] ffe2ee00: ttyS0 at MMIO 0x1fe020043f8 (irq = 5, base_baud
= 115387) is a 16550A
[    5.478530] Console: ttyS0 (SU)
[    5.510040] console [ttyS0] enabled
[    5.513297] Unable to handle kernel NULL pointer dereference
[    5.513709] tsk->{mm,active_mm}->context = 0000000000000000
[    5.514096] tsk->{mm,active_mm}->pgd = fffff80000402000
[    5.514457]               \|/ ____ \|/
[    5.514457]               "@'/ .. \`@"
[    5.514457]               /_| \__/ |_\
[    5.514457]                  \__U_/
[    5.515389] swapper/0(1): Oops [#1]
[    5.515857] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.1.0-rc5+ #3
[    5.516319] task: fffff8000f0a36a0 ti: fffff8000f0bc000 task.ti:
fffff8000f0bc000
[    5.516828] TSTATE: 0000000080001606 TPC: 00000000006e1c7c TNPC:
00000000006e1c80 Y: 00000002    Not tainted
[    5.517549] TPC: <sparc_i8042_probe+0x1c/0x110>
[    5.517855] g0: fffff8000f02daa8 g1: 0000000000000000 g2:
fffff8000f3f7438 g3: fffff8000f3f7090
[    5.518405] g4: fffff8000f0a36a0 g5: fffff8000ee10000 g6:
fffff8000f0bc000 g7: 000000000000000a
[    5.518941] o0: fffff8000f3f7438 o1: 00000000008eef88 o2:
fffff8000f3f7438 o3: fffff8000f803040
[    5.519476] o4: 0000000000000000 o5: fffff8000f3f7438 sp:
fffff8000f0bed31 ret_pc: 00000000005a9e88
[    5.520079] RPC: <sysfs_do_create_link_sd.isra.0+0x74/0xb0>
[    5.520450] l0: 00000000008ec400 l1: 00000000008e8c00 l2:
fffff8000f803140 l3: fffff8000f803180
[    5.521075] l4: 0000000000000001 l5: 0000000000000000 l6:
0000000000970e70 l7: 0000000000000000
[    5.521619] i0: fffff8000f2fd000 i1: 00000000008e8c00 i2:
00000000008e8400 i3: 00000000008ec400
[    5.522160] i4: fffff8000f3f7438 i5: fffff8000f3f6970 i6:
fffff8000f0bede1 i7: 00000000006c515c
[    5.522707] I7: <platform_drv_probe+0x24/0x78>
[    5.523026] Call Trace:
[    5.523269]  [00000000006c515c] platform_drv_probe+0x24/0x78
[    5.523647]  [00000000006c37c0] driver_probe_device+0xec/0x24c
[    5.524008]  [00000000006c217c] bus_for_each_drv+0x6c/0x84
[    5.524350]  [00000000006c368c] device_attach+0x60/0x8c
[    5.524676]  [00000000006c2d68] bus_probe_device+0x20/0xa0
[    5.525144]  [00000000006c1310] device_add+0x2f0/0x53c
[    5.525475]  [00000000006c4f3c] platform_device_add+0x174/0x214
[    5.525890]  [00000000006c5648] __platform_create_bundle+0x48/0xa0
[    5.526273]  [00000000009dae18] i8042_init+0x118/0x174
[    5.526713]  [0000000000426cc8] do_one_initcall+0x168/0x178
[    5.527262]  [00000000009b6bb4] kernel_init_freeable+0x188/0x22c
[    5.527732]  [00000000007f0354] kernel_init+0x4/0xf0
[    5.528165]  [00000000004060e4] ret_from_fork+0x1c/0x2c
[    5.528583]  [0000000000000000]           (null)
[    5.529062] Disabling lock debugging due to kernel taint
[    5.529511] Caller[00000000006c515c]: platform_drv_probe+0x24/0x78
[    5.529951] Caller[00000000006c37c0]: driver_probe_device+0xec/0x24c
[    5.530371] Caller[00000000006c217c]: bus_for_each_drv+0x6c/0x84
[    5.530748] Caller[00000000006c368c]: device_attach+0x60/0x8c
[    5.531110] Caller[00000000006c2d68]: bus_probe_device+0x20/0xa0
[    5.531483] Caller[00000000006c1310]: device_add+0x2f0/0x53c
[    5.531837] Caller[00000000006c4f3c]: platform_device_add+0x174/0x214
[    5.532234] Caller[00000000006c5648]: __platform_create_bundle+0x48/0xa0
[    5.532649] Caller[00000000009dae18]: i8042_init+0x118/0x174
[    5.533095] Caller[0000000000426cc8]: do_one_initcall+0x168/0x178
[    5.533479] Caller[00000000009b6bb4]: kernel_init_freeable+0x188/0x22c
[    5.533880] Caller[00000000007f0354]: kernel_init+0x4/0xf0
[    5.534229] Caller[00000000004060e4]: ret_from_fork+0x1c/0x2c
[    5.534580] Caller[0000000000000000]:           (null)
[    5.534917] Instruction DUMP: 330023a3  210023b1  230023a3 <fa586048>
b616e3d8  b416a2a8  b2166250  a01423e0  a2146260
[    5.536169] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x00000009
[    5.536169]
[    5.537022] Press Stop-A (L1-A) to return to the boot prom
[    5.537377] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x00000009
[    5.537377]


With various printk()s liberally sprinkled around the 8042 driver what I
see is something like the following:


- sparc_i8042_probe() is called successfully using a platform_device
passed in from the initial device tree scan

- i8042_init() calls platform_create_bundle() to initialise the
platform-specific parts of the keyboard driver in
drivers/input/serio/i8042-sparcio.h.

- platform_create_bundle() calls platform_device_alloc() to create a new
platform_device object.

- The new platform_device object is passed into sparc_i8042_probe() for
a second time which segfaults when trying to access the
platform_device's OF node property with op->dev.of_node.


At the moment I'm confused as to how this can work on real hardware
since platform_device_alloc() creates a new platform_device from scratch
and so the reference to the OF device node dev.of_node, which is
eventually passed onto sparc_i8042_probe() when it is called for the
second time, is never populated.

Can anyone help point me in the right direction and show me what I'm
doing wrong?


Many thanks,

Mark.
