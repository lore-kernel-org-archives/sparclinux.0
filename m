From: "Pieter-Paul Giesberts" <pieterpg@broadcom.com>
Date: Thu, 11 Aug 2011 15:52:05 +0000
Subject: Bug report: booting 3.1-rc1 on Sunfire V120 fails
Message-Id: <400C43189542CE41BC0A5B252FC90136A995C8D7EB@SJEXCHCCR02.corp.ad.broadcom.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi, 

I have just compiled the latest 3.1.0-rc1 kernel from Greg's staging repository and tried to boot it on a Sunfire V120, but it crashes during boot, the log is shown below. The 3.0.0 and older kernels from the same repository worked fine on the same machine. ali7101 seems to be the culprit.

Regards, Pieter-Paul Giesberts

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.0.12 2002/01/08 13:01'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Linux version 3.1.0-rc1+ (developer@LB-BUN-53) (gcc version 4.2.4 (Ubuntu 4.2.4-1ubuntu4)) #2 Thu Aug 11 14:21:38 CEST 2011
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:5c:42:91
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1f,0/pci@1,1/isa@7/serial@0,3f8
[    0.000000] PROM: Built device tree with 57546 bytes of memory.
[    0.000000] Top of RAM: 0x1feb8000, Total RAM: 0x1fe30000
[    0.000000] Memory hole size: 0MB
[    0.000000] [0000010000000000-fffff80000400000] page_structs1072 node=0 entry=0/8192
[    0.000000] [0000010000000000-fffff80000800000] page_structs1072 node=0 entry=1/8192
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x0000ff5c
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000f7ff
[    0.000000]     0: 0x0000f800 -> 0x0000ff00
[    0.000000]     0: 0x0000ff40 -> 0x0000ff4d
[    0.000000]     0: 0x0000ff50 -> 0x0000ff5c
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    0.000000] CPU CAPS: [vis]
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64793
[    0.000000] Kernel command line: root=/dev/disk/by-uuid/99a7d284-3a7b-4fe0-ae6b-9a68c3486038 ro console=ttyS0
[    0.000000] PID hash table entries: 2048 (order: 1, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
[    0.000000] Memory: 503328k available (3056k kernel code, 1496k data, 184k init) [fffff80000000000,000000001feb8000]
[    0.000000] SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:255
[    0.000000] clocksource: mult[5a00000f] shift[24]
[    0.000000] clockevent: mult[2d82d82] shift[32]
[    0.000000] Console: colour dummy device 80x25
[   55.174535] Calibrating delay using timer specific routine.. 22.24 BogoMIPS (lpjD491)
[   55.269355] pid_max: default: 32768 minimum: 301
[   55.324687] Security Framework initialized
[   55.373458] Mount-cache hash table entries: 512
[   55.430712] NET: Registered protocol family 16
[   55.490600] /pci@1f,0: PCI IO[1fe02000000] MEM[1ff00000000]
[   55.556390] /pci@1f,0: SABRE PCI Bus Module ver[0:0]
[   55.615613] PCI: Scanning PBM /pci@1f,0
[   55.661840] pci 0000:01:03.0: quirk: [io  0x1fe02002000-0x1fe0200203f] claimed by ali7101 ACPI
[   55.764361] pci 0000:01:03.0: quirk: [io  0x1fe02004000-0x1fe0200401f] claimed by ali7101 SMB
[   55.868757]               \|/ ____ \|/
[   55.868764]               "@'/ .. \`@"
[   55.868769]               /_| \__/ |_\
[   55.868773]                  \__U_/
[   56.043741] swapper(1): Kernel bad sw trap 7f [#1]
[   56.100941] TSTATE: 0000004480001606 TPC: 00000000004062d0 TNPC: 00000000004062d4 Y: 00000000    Not tainted
[   56.218497] TPC: <sun4v_get_version+0xc/0x1c>
[   56.270478] g0: 0000000000863f18 g1: 0000000000000000 g2: 0000000000000001 g3: 0000000000000000
[   56.374490] g4: fffff8001e054000 g5: 0000000000000000 g6: fffff8001e058000 g7: fffff8000000c1a0
[   56.478502] o0: 0000000000000110 o1: fffff8001e05bda8 o2: fffff8001e05bda0 o3: fffff8001e05bda8
[   56.582514] o4: fffff8001e05bda0 o5: 0000000000000003 sp: fffff8001e05b4f1 ret_pc: 00000000008857ac
[   56.690698] RPC: <ds_init+0xc/0xa0>
[   56.732293] l0: 0000000000869800 l1: 0000000000935c00 l2: 000000000083dbe0 l3: 0000000000000000
[   56.836305] l4: 0000000000842000 l5: 000000000091f800 l6: 000000000000000f l7: 00000000007d3000
[   56.940318] i0: 00000000007cf000 i1: 00000000007cf000 i2: 0000000000000000 i3: fffff8001e0426e0
[   57.044330] i4: 00000000004c94c0 i5: 00000000005b8d80 i6: fffff8001e05b5c1 i7: 0000000000426ba8
[   57.148349] I7: <do_one_initcall+0xe8/0x160>
[   57.199307] Call Trace:
[   57.228437]  [0000000000426ba8] do_one_initcall+0xe8/0x160
[   57.293965]  [000000000087e23c] kernel_init+0x9c/0x140
[   57.355338]  [000000000042b150] kernel_thread+0x30/0x60
[   57.417755]  [00000000006ef0b0] rest_init+0x10/0x80
[   57.475981] Disabling lock debugging due to kernel taint
[   57.539435] Caller[0000000000426ba8]: do_one_initcall+0xe8/0x160
[   57.611202] Caller[000000000087e23c]: kernel_init+0x9c/0x140
[   57.678812] Caller[000000000042b150]: kernel_thread+0x30/0x60
[   57.747461] Caller[00000000006ef0b0]: rest_init+0x10/0x80
[   57.811939] Instruction DUMP: 9a102003  96100009  9810000a <91d020ff> d272c000  81c3e008  d4730000  9a102000  9810000b
[   57.940935] Kernel panic - not syncing: Attempted to kill init!
[   58.011644] Call Trace:
[   58.040783]  [000000000045faec] do_exit+0x72c/0x740
[   58.099023]  [0000000000427f6c] die_if_kernel+0x18c/0x340
[   58.163510]  [0000000000429bc0] bad_trap+0xe0/0x100
[   58.221767]  [0000000000422ff0] tl0_resv17d+0x50/0x60
[   58.282086]  [00000000004062d0] sun4v_get_version+0xc/0x1c
[   58.347612]  [0000000000426ba8] do_one_initcall+0xe8/0x160
[   58.413139]  [000000000087e23c] kernel_init+0x9c/0x140
[   58.474508]  [000000000042b150] kernel_thread+0x30/0x60
[   58.536916]  [00000000006ef0b0] rest_init+0x10/0x80
[   58.595161] Press Stop-A (L1-A) to return to the boot prom

