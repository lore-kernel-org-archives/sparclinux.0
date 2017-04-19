From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 19 Apr 2017 15:04:33 +0000
Subject: Panic enabling bochs_drm on qemu-system-sparc64 (sun4u)
Message-Id: <50fde122-c0ab-4b0e-2cc7-4fd4d0051c3e@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all,

Today I tried cross-compiling a kernel with bochs_drm enabled to see if
I can get a working framebuffer under qemu-system-sparc64 and came up
with the following panic on boot:

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.10.24 1999/01/01 01:01'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Linux version 4.11.0-rc7+ (build@kentang) (gcc version
5.1.0 (GCC) ) #2 SMP Wed Apr 19 15:08:22 BST 2017
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 52:54:00:12:34:56
[    0.000000] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits = 40)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.000000] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel...
[    0.000000] done.
[    0.000000] OF stdout device is: /pci@1fe,0/ebus@3/su
[    0.000000] PROM: Built device tree with 52516 bytes of memory.
[    0.000000] Top of RAM: 0x7e80000, Total RAM: 0x7e80000
[    0.000000] Memory hole size: 0MB
[    0.000000] Allocated 16384 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x0000000007e7ffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000007e7ffff]
[    0.000000] Initmem setup node 0 [mem
0x0000000000000000-0x0000000007e7ffff]
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    0.000000] CPU CAPS: [vis]
[    0.000000] percpu: Embedded 11 pages/cpu @fffff80007800000 s50688
r8192 d31232 u4194304
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 16065
[    0.000000] Kernel command line: console=ttyS0
[    0.000000] PID hash table entries: 512 (order: -1, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 131072
bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 65536 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 83056K/129536K available (4866K kernel code, 581K
rwdata, 1488K rodata, 312K init, 541K bss, 46480K reserved, 0K cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 64.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leafd, nr_cpu_ids=1
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
...
...
[    5.861058] [drm] Found bochs VGA, ID 0xb0c5.
[    5.861396] [drm] Framebuffer size 16384 kB @ 0x1ff01000000, mmio @
0x1ff02000000.
[    5.862632] [TTM] Zone  kernel: Available graphics memory: 56492 kiB
[    5.863098] [TTM] Initializing pool allocator
[    5.897695] Unable to handle kernel paging request at virtual address
000001ff01000000
[    5.897722] tsk->{mm,active_mm}->context = 0000000000000000
[    5.897742] tsk->{mm,active_mm}->pgd = fffff80000402000
[    5.897769]               \|/ ____ \|/
[    5.897769]               "@'/ .. \`@"
[    5.897769]               /_| \__/ |_\
[    5.897769]                  \__U_/
[    5.897793] swapper/0(1): Oops [#1]
[    5.898093] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc7+ #2
[    5.898167] task: fffff80004097800 task.stack: fffff80004098000
[    5.898197] TSTATE: 0000000080001607 TPC: 00000000006f3a44 TNPC:
00000000006f3a50 Y: 00000000    Not tainted
[    5.898500] TPC: <sys_imageblit+0x1cc/0x428>
[    5.898531] g0: 0000000000000000 g1: fffff80004426000 g2:
0000000000000000 g3: 0000000000000007
[    5.898553] g4: fffff80004097800 g5: fffff80006cea000 g6:
fffff80004098000 g7: 000000000090dfc0
[    5.898573] o0: fffff8000400dc00 o1: 0000000000000001 o2:
000000000000000f o3: 000001ff01000000
[    5.898593] o4: 0000000000000007 o5: 0000000000000000 sp:
fffff8000409a0a1 ret_pc: 0000000000000008
[    5.898730] RPC: <0x8>
[    5.898780] l0: 0000000000000020 l1: 0000000000000008 l2:
0000000000000080 l3: 0000000000000001
[    5.898801] l4: 0000000000b93800 l5: 0000000000000080 l6:
0000000000000030 l7: 0000000000000000
[    5.898821] i0: fffff80004416800 i1: fffff80004426000 i2:
0000000000000001 i3: 0000000000000000
[    5.898842] i4: 0000000000000001 i5: 000001ff01000000 i6:
fffff8000409a151 i7: 0000000000737f64
[    5.898875] I7: <drm_fb_helper_sys_imageblit+0x8/0x28>
[    5.898928] Call Trace:
[    5.899009]  [0000000000737f64] drm_fb_helper_sys_imageblit+0x8/0x28
[    5.899053]  [00000000006e6acc] soft_cursor+0x174/0x19c
[    5.899069]  [00000000006e6574] bit_cursor+0x45c/0x490
[    5.899085]  [00000000006e307c] fbcon_cursor+0x16c/0x17c
[    5.899102]  [0000000000710d80] hide_cursor+0x2c/0xa8
[    5.899117]  [0000000000711f1c] redraw_screen+0xc4/0x208
[    5.899133]  [00000000006e2158] fbcon_prepare_logo+0x288/0x358
[    5.899148]  [00000000006e25fc] fbcon_init+0x3d4/0x448
[    5.899164]  [0000000000711204] visual_init+0xa4/0x100
[    5.899179]  [00000000007129c0] do_bind_con_driver+0x1c8/0x300
[    5.899194]  [0000000000712e6c] do_take_over_console+0x170/0x198
[    5.899209]  [00000000006e26f4] do_fbcon_takeover+0x84/0xe8
[    5.899229]  [000000000047477c] notifier_call_chain+0x38/0x74
[    5.899246]  [00000000004749fc] __blocking_notifier_call_chain+0x28/0x44
[    5.899263]  [00000000006ec044] register_framebuffer+0x2b8/0x2ec
[    5.899278]  [0000000000739744] drm_fb_helper_initial_config+0x2d0/0x36c
[    5.899329] Disabling lock debugging due to kernel taint
[    5.899410] Caller[0000000000737f64]:
drm_fb_helper_sys_imageblit+0x8/0x28
[    5.899448] Caller[00000000006e6acc]: soft_cursor+0x174/0x19c
[    5.899464] Caller[00000000006e6574]: bit_cursor+0x45c/0x490
[    5.899480] Caller[00000000006e307c]: fbcon_cursor+0x16c/0x17c
[    5.899496] Caller[0000000000710d80]: hide_cursor+0x2c/0xa8
[    5.899510] Caller[0000000000711f1c]: redraw_screen+0xc4/0x208
[    5.899526] Caller[00000000006e2158]: fbcon_prepare_logo+0x288/0x358
[    5.899541] Caller[00000000006e25fc]: fbcon_init+0x3d4/0x448
[    5.899557] Caller[0000000000711204]: visual_init+0xa4/0x100
[    5.899572] Caller[00000000007129c0]: do_bind_con_driver+0x1c8/0x300
[    5.899587] Caller[0000000000712e6c]: do_take_over_console+0x170/0x198
[    5.899602] Caller[00000000006e26f4]: do_fbcon_takeover+0x84/0xe8
[    5.899618] Caller[000000000047477c]: notifier_call_chain+0x38/0x74
[    5.899635] Caller[00000000004749fc]:
__blocking_notifier_call_chain+0x28/0x44
[    5.899652] Caller[00000000006ec044]: register_framebuffer+0x2b8/0x2ec
[    5.899667] Caller[0000000000739744]:
drm_fb_helper_initial_config+0x2d0/0x36c
[    5.899684] Caller[0000000000761a58]: bochs_fbdev_init+0x60/0x98
[    5.899699] Caller[00000000007607ec]: bochs_load+0x84/0xa8
[    5.899715] Caller[00000000007419a4]: drm_dev_register+0x114/0x1e8
[    5.899731] Caller[000000000074272c]: drm_get_pci_dev+0xa8/0x118
[    5.899748] Caller[00000000006c8214]: pci_device_probe+0x70/0xdc
[    5.899763] Caller[0000000000768898]: driver_probe_device+0x148/0x2a4
[    5.899778] Caller[0000000000768a6c]: __driver_attach+0x78/0xa8
[    5.899793] Caller[0000000000767094]: bus_for_each_dev+0x58/0x7c
[    5.899808] Caller[0000000000767f64]: bus_add_driver+0xd0/0x1fc
[    5.899823] Caller[0000000000769508]: driver_register+0xa8/0x100
[    5.899839] Caller[0000000000426cb0]: do_one_initcall+0x80/0x10c
[    5.899870] Caller[0000000000ad6bdc]: kernel_init_freeable+0x1a8/0x244
[    5.899886] Caller[00000000008be4ec]: kernel_init+0x4/0xfc
[    5.899902] Caller[0000000000406064]: ret_from_fork+0x1c/0x2c
[    5.899923] Instruction DUMP:
[    5.900005]  840ec002
[    5.900038]  8418800d
[    5.900044]  12480004
[    5.900050] <c422c000>
[    5.900056]  b2066001
[    5.900061]  86102008
[    5.900067]  106fffef
[    5.900072]  9602e004
[    5.900078]  c4062120
[    5.900088]
[    5.902180] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x00000009
[    5.902180]
[    5.930530] Press Stop-A (L1-A) from sun keyboard or send break
[    5.930530] twice on console to return to the boot prom
[    5.931265] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x00000009
[    5.931265]

The address 0x1ff01000000 looks correct in that it is the start of the
framebuffer, but according to the above stack trace we have no
0x1ff01000000 (virt) to 0x1ff01000000 (phys) mapping in place.

Having a peek at the source code it looks like this should be handled
somewhere in the drm core. Are there any stub methods for sun4u that
need to be filled in somewhere in order for drm memory mappings to take
place? Or is something else amiss?


ATB,

Mark.
