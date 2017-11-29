From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 29 Nov 2017 08:56:49 +0000
Subject: Re: sparc64: git kernel 4.14.0-12995-g0c86a6bd85ff does not boot
Message-Id: <CADxRZqxiENSMC4aET5pzxCRa=DPDWmot2x_TiyDTZQAd_+PwcA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
In-Reply-To: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Nov 27, 2017 at 1:20 PM, Anatoly Pugachev <matorola@gmail.com> wrote:
> On Wed, Nov 22, 2017 at 6:40 PM, Anatoly Pugachev <matorola@gmail.com> wrote:
>> Hello!
>>
>> Trying to boot latest git kernel 4.14.0-12995-g0c86a6bd85ff does not
>> boot on my sparc64 LDOM [1], kernel config [2].
>
> 4.15.0-rc1 a bit different OOPS, but still does not boot:

tried with debian sparc64 default kernel config file, and git kernel
v4.15-rc1-24-g43570f0383d6
still this LDOM doesn't boot. Kernel boot log is below.

Going to try git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git
to boot and bisect...

Loading Linux 4.15.0-rc1+ ...
Loading initial ramdisk ...

[    0.000014] PROMLIB: Sun IEEE Boot Prom 'OBP 4.38.8 2017/02/22 13:51'
[    0.000018] PROMLIB: Root node compatible: sun4v
[    0.000050] Linux version 4.15.0-rc1+ (mator@ttip) (gcc version
7.2.0 (Debian 7.2.0-16)) #528 SMP Wed Nov 29 11:28:51 MSK 2017
[    0.000304] bootconsole [earlyprom0] enabled
[    0.000344] ARCH: SUN4V
[    0.000386] Ethernet address: 00:14:4f:fa:06:f2
[    0.000434] MM: PAGE_OFFSET is 0xfff8000000000000 (max_phys_bits = 47)
[    0.000494] MM: VMALLOC [0x0000000100000000 --> 0x0006000000000000]
[    0.000551] MM: VMEMMAP [0x0006000000000000 --> 0x000c000000000000]
[    0.010204] Kernel: Using 3 locked TLB entries for main kernel image.
[    0.010274] Remapping the kernel...
[    0.010294] done.
[    0.040080] OF stdout device is: /virtual-devices@100/console@1
[    0.040150] PROM: Built device tree with 68631 bytes of memory.
[    0.040212] MDESC: Size is 30976 bytes.
[    0.040310] PLATFORM: banner-name [SPARC T5-2]
[    0.040355] PLATFORM: name [ORCL,SPARC-T5-2]
[    0.040395] PLATFORM: hostid [84fa06f2]
[    0.040432] PLATFORM: serial# [0035260e]
[    0.040469] PLATFORM: stick-frequency [3b9aca00]
[    0.040512] PLATFORM: mac-address [144ffa06f2]
[    0.040553] PLATFORM: watchdog-resolution [1000 ms]
[    0.040599] PLATFORM: watchdog-max-timeout [31536000000 ms]
[    0.040649] PLATFORM: max-cpus [1024]
[    0.040747] Top of RAM: 0x40bf8b8000, Total RAM: 0x7ff380000
[    0.040804] Memory hole size: 232453MB
[    0.068288] Allocated 40960 bytes for kernel page tables.
[    0.068391] Zone ranges:
[    0.068428]   Normal   [mem 0x0000000040400000-0x00000040bf8b7fff]
[    0.068491] Movable zone start for each node
[    0.068532] Early memory node ranges
[    0.068568]   node   0: [mem 0x0000000040400000-0x000000007febffff]
[    0.068624]   node   0: [mem 0x000000007ff40000-0x000000007ff47fff]
[    0.068681]   node   0: [mem 0x0000000080000000-0x000000077fffffff]
[    0.068738]   node   0: [mem 0x0000002000000000-0x000000202fffffff]
[    0.068794]   node   0: [mem 0x0000004030000000-0x00000040bf8b7fff]
[    0.068851] Initmem setup node 0 [mem 0x0000000040400000-0x00000040bf8b7fff]
[    0.068940] Kernel unaligned access at TPC[9b75bc] secpath_set+0x3c/0x80
[    0.069009] Unable to handle kernel NULL pointer dereference in mna handler
[    0.069011]  at virtual address 0000000000000069
[    0.069115] current->{active_,}mm->context = 0000000000000000
[    0.069167] current->{active_,}mm->pgd = fff8004030002000
[    0.069219]               \|/ ____ \|/
[    0.069219]               "@'/ .. \`@"
[    0.069219]               /_| \__/ |_\
[    0.069219]                  \__U_/
[    0.069346] swapper(0): Oops [#1]
[    0.069382] CPU: 0 PID: 0 Comm: swapper Not tainted 4.15.0-rc1+ #528
[    0.069441] task: 0000000000c121c0 task.stack: 0000000000bf8000
[    0.069496] TSTATE: 0000000080e01607 TPC: 00000000009b75bc TNPC:
00000000009b75c0 Y: 00000170    Not tainted
[    0.069582] TPC: <secpath_set+0x3c/0x80>
[    0.069621] g0: 000000000000002d g1: fffffffffffffff4 g2:
0000000000080000 g3: 0000000000d06400
[    0.069698] g4: 0000000000c121c0 g5: 0000000000000000 g6:
0000000000bf8000 g7: 0000000000d06400
[    0.069776] o0: 0000000000000018 o1: 0000000000bfbaa8 o2:
0000000000000088 o3: 0000000000ca5980
[    0.069853] o4: 0000000000000000 o5: 0000000000c53a98 sp:
0000000000bfb171 ret_pc: 00000000005a32ec
[    0.069939] RPC: <zone_batchsize.isra.8+0x4c/0x80>
[    0.069984] l0: 0000000000800000 l1: 0000000000d63000 l2:
0000000000000000 l3: 0000000000cb83c8
[    0.070061] l4: 0000000000b96cd8 l5: 00000000fef195e1 l6:
0000000000000082 l7: 0000000000d6eee8
[    0.070137] i0: 0000000000000001 i1: 0000000000b53658 i2:
0000000000000000 i3: 0000000000bfbb00
[    0.070214] i4: 0000000000bfbb08 i5: 0000000000000018 i6:
0000000000bfb221 i7: 0000000000cfb200
[    0.070294] I7: <free_area_init_node+0x468/0x4cc>
[    0.070338] Call Trace:
[    0.070366]  [0000000000cfb200] free_area_init_node+0x468/0x4cc
[    0.070424]  [0000000000cd8c7c] free_area_init_nodes+0x548/0x568
[    0.070482]  [0000000000ccae70] paging_init+0xf74/0xf90
[    0.070533]  [0000000000cc562c] setup_arch+0x284/0x6ec
[    0.070581]  [0000000000cc2728] start_kernel+0x5c/0x4a0
[    0.070631]  [0000000000cc5304] start_early_boot+0x2b8/0x2c8
[    0.070686]  [0000000000a41000] tlb_fixup_done+0x4c/0x6c
[    0.070737]  [000000000011d8a4] 0x11d8a4
[    0.070775] Disabling lock debugging due to kernel taint
[    0.070827] Caller[0000000000cfb200]: free_area_init_node+0x468/0x4cc
[    0.070886] Caller[0000000000cd8c7c]: free_area_init_nodes+0x548/0x568
[    0.070945] Caller[0000000000ccae70]: paging_init+0xf74/0xf90
[    0.070998] Caller[0000000000cc562c]: setup_arch+0x284/0x6ec
[    0.071051] Caller[0000000000cc2728]: start_kernel+0x5c/0x4a0
[    0.071105] Caller[0000000000cc5304]: start_early_boot+0x2b8/0x2c8
[    0.071162] Caller[0000000000a41000]: tlb_fixup_done+0x4c/0x6c
[    0.071217] Caller[000000000011d8a4]: 0x11d8a4
[    0.071259] Instruction DUMP:
[    0.071261]  ba100008
[    0.071292]  02c2000c
[    0.071317]  82103ff4
[    0.071342] <f85e2068>
[    0.071368]  02c70007
[    0.071392]  9210001c
[    0.071417]  4002014a
[    0.071443]  90102001
[    0.071468]  80a22000
[    0.071494]
[    0.071538] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.071679] Unable to handle kernel NULL pointer dereference
...
