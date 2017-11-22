From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 22 Nov 2017 15:40:08 +0000
Subject: sparc64: git kernel 4.14.0-12995-g0c86a6bd85ff does not boot
Message-Id: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello!

Trying to boot latest git kernel 4.14.0-12995-g0c86a6bd85ff does not
boot on my sparc64 LDOM [1], kernel config [2].

If I revert latest git sparc tree merge, with

$ git show 1deab8ce2c91e3b16563b7a7ea150f82334262ec --oneline
1deab8ce2c91 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc

mator@ttip:linux-2.6$ git revert -n -m 1
1deab8ce2c91e3b16563b7a7ea150f82334262ec

it is able to boot successfully.

Can you please teach me on how to git bisect merge commit? Thanks.

[1]. http://paste.debian.net/plain/997067
[2]. http://paste.debian.net/plain/997071

LDOM console boot log (first 100 lines. Full log in the URL[1] above):

Loading Linux 4.14.0-12995-g0c86a6bd85ff ...
Loading initial ramdisk ...

[    0.000017] PROMLIB: Sun IEEE Boot Prom 'OBP 4.38.8 2017/02/22 13:51'
[    0.000028] PROMLIB: Root node compatible: sun4v
[    0.000070] Linux version 4.14.0-12995-g0c86a6bd85ff (mator@ttip)
(gcc version 7.2.0 (Debian 7.2.0-16)) #523 SMP Wed Nov 22 18:03:05 MSK
2017
[    0.000358] bootconsole [earlyprom0] enabled
[    0.000404] ARCH: SUN4V
[    0.000452] Ethernet address: 00:14:4f:fa:06:f2
[    0.000504] MM: PAGE_OFFSET is 0xfff8000000000000 (max_phys_bits = 47)
[    0.000568] MM: VMALLOC [0x0000000100000000 --> 0x0006000000000000]
[    0.000630] MM: VMEMMAP [0x0006000000000000 --> 0x000c000000000000]
[    0.012719] Kernel: Using 5 locked TLB entries for main kernel image.
[    0.012787] Remapping the kernel...
[    0.012816] done.
[    0.020800] kmemleak: Kernel memory leak detector disabled
[    0.044638] OF stdout device is: /virtual-devices@100/console@1
[    0.044700] PROM: Built device tree with 74487 bytes of memory.
[    0.044758] MDESC: Size is 30976 bytes.
[    0.044865] PLATFORM: banner-name [SPARC T5-2]
[    0.044912] PLATFORM: name [ORCL,SPARC-T5-2]
[    0.044958] PLATFORM: hostid [84fa06f2]
[    0.044997] PLATFORM: serial# [0035260e]
[    0.045041] PLATFORM: stick-frequency [3b9aca00]
[    0.045086] PLATFORM: mac-address [144ffa06f2]
[    0.045132] PLATFORM: watchdog-resolution [1000 ms]
[    0.045181] PLATFORM: watchdog-max-timeout [31536000000 ms]
[    0.045236] PLATFORM: max-cpus [1024]
[    0.045324] Top of RAM: 0x40bf8b4000, Total RAM: 0x7ff37c000
[    0.045380] Memory hole size: 232453MB
[    0.168499] Allocated 40960 bytes for kernel page tables.
[    0.168615] Zone ranges:
[    0.168657]   Normal   [mem 0x0000000040400000-0x00000040bf8b3fff]
[    0.168724] Movable zone start for each node
[    0.168771] Early memory node ranges
[    0.168809]   node   0: [mem 0x0000000040400000-0x000000007febffff]
[    0.168869]   node   0: [mem 0x000000007ff40000-0x000000007ff47fff]
[    0.168927]   node   0: [mem 0x0000000080000000-0x000000077fffffff]
[    0.168988]   node   0: [mem 0x0000002000000000-0x000000202fffffff]
[    0.169045]   node   0: [mem 0x0000004030000000-0x00000040bf8b3fff]
[    0.169107] Initmem setup node 0 [mem 0x0000000040400000-0x00000040bf8b3fff]
[    0.169200] Unable to handle kernel NULL pointer dereference
[    0.169258] tsk->{mm,active_mm}->context = 0000000000000000
[    0.169311] tsk->{mm,active_mm}->pgd = fff8004030002000
[    0.169364]               \|/ ____ \|/
[    0.169364]               "@'/ .. \`@"
[    0.169364]               /_| \__/ |_\
[    0.169364]                  \__U_/
[    0.169488] swapper(0): Oops [#1]
[    0.169535] CPU: 0 PID: 0 Comm: swapper Not tainted
4.14.0-12995-g0c86a6bd85ff #523
[    0.169607] task: 0000000000c06c80 task.stack: 0000000000be8000
[    0.169663] TSTATE: 0000000080e01600 TPC: 00000000009f8c04 TNPC:
00000000009f8c08 Y: 0000000f    Not tainted
[    0.169756] TPC: <minmax_running_max+0x4/0xa0>
[    0.169801] g0: 0000000000000000 g1: 0000000001fb4000 g2:
0000000000080000 g3: 0000000001512730
[    0.169879] g4: 0000000000c06c80 g5: 0000000000000000 g6:
0000000000be8000 g7: 0000000000d16400
[    0.169957] o0: 0000000000cac148 o1: 0000000000b701f0 o2:
00000000014c8970 o3: 0000000000000000
[    0.170037] o4: 000000000000000e o5: 00000000014b9c00 sp:
0000000000beb0b1 ret_pc: 00000000004cfc74
[    0.170121] RPC: <lockdep_init_map+0x14/0x40>
[    0.170166] l0: 000000000000000e l1: 0000000000c29c00 l2:
0000000000000000 l3: 0000000000000002
[    0.170243] l4: 000000000000002d l5: 000000000000000c l6:
000000000000001b l7: 0000000000c571d0
[    0.171323] i0: 0000000000000018 i1: 0000000000b701f0 i2:
00000000014c8970 i3: 0000000000000000
[    0.171400] i4: 000000000000000e i5: 00000000c0000000 i6:
0000000000beb171 i7: 00000000005cd34c
[    0.171482] I7: <zone_batchsize.isra.7+0x4c/0x80>
[    0.171528] Call Trace:
[    0.171560]  [00000000005cd34c] zone_batchsize.isra.7+0x4c/0x80
[    0.171620]  [0000000000cfb8f8] free_area_init_node+0x4ac/0x51c
[    0.171681]  [0000000000cdc968] free_area_init_nodes+0x548/0x574
[    0.171744]  [0000000000ccef1c] paging_init+0xf7c/0xf98
[    0.171796]  [0000000000cc96bc] setup_arch+0x284/0x708
[    0.171848]  [0000000000cc6718] start_kernel+0x60/0x4c8
[    0.171900]  [0000000000cc9394] start_early_boot+0x2c8/0x2d8
[    0.171958]  [0000000000a08500] tlb_fixup_done+0x4c/0x6c
[    0.172011]  [000000000011d8a4] 0x11d8a4
[    0.172053] Disabling lock debugging due to kernel taint
[    0.172103] Caller[00000000005cd34c]: zone_batchsize.isra.7+0x4c/0x80
[    0.172162] Caller[0000000000cfb8f8]: free_area_init_node+0x4ac/0x51c
[    0.172223] Caller[0000000000cdc968]: free_area_init_nodes+0x548/0x574
[    0.172282] Caller[0000000000ccef1c]: paging_init+0xf7c/0xf98
[    0.172335] Caller[0000000000cc96bc]: setup_arch+0x284/0x708
[    0.172388] Caller[0000000000cc6718]: start_kernel+0x60/0x4c8
[    0.172443] Caller[0000000000cc9394]: start_early_boot+0x2c8/0x2d8
[    0.172499] Caller[0000000000a08500]: tlb_fixup_done+0x4c/0x6c
[    0.172553] Caller[000000000011d8a4]: 0x11d8a4
[    0.172597] Instruction DUMP:
[    0.172600]  01000000
[    0.172632]  01000000
[    0.172658]  9de3bf40
[    0.172685] <c2062004>
[    0.172712]  f627a7fb
[    0.172737]  80a0401b
[    0.172764]  08400007
[    0.172792]  f427a7f7
[    0.172818]  c2062010
[    0.172845]
[    0.172890] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.173132] Unable to handle kernel NULL pointer dereference
[    0.173186] tsk->{mm,active_mm}->context = 0000000000000000
[    0.173238] tsk->{mm,active_mm}->pgd = fff8004030002000
