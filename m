From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 27 Nov 2017 10:20:12 +0000
Subject: Re: sparc64: git kernel 4.14.0-12995-g0c86a6bd85ff does not boot
Message-Id: <CADxRZqyAiyfeKT_qcXs2h_Bd_A+=-0DdkRtn7ww29hRShhuZiw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
In-Reply-To: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Nov 22, 2017 at 6:40 PM, Anatoly Pugachev <matorola@gmail.com> wrote:
> Hello!
>
> Trying to boot latest git kernel 4.14.0-12995-g0c86a6bd85ff does not
> boot on my sparc64 LDOM [1], kernel config [2].

4.15.0-rc1 a bit different OOPS, but still does not boot:

Loading Linux 4.15.0-rc1 ...
Loading initial ramdisk ...

[    0.000018] PROMLIB: Sun IEEE Boot Prom 'OBP 4.38.8 2017/02/22 13:51'
[    0.000030] PROMLIB: Root node compatible: sun4v
[    0.000074] Linux version 4.15.0-rc1 (mator@ttip) (gcc version
7.2.0 (Debian 7.2.0-16)) #527 SMP Mon Nov 27 12:44:52 MSK 2017
[    0.000367] bootconsole [earlyprom0] enabled
[    0.000414] ARCH: SUN4V
[    0.000467] Ethernet address: 00:14:4f:fa:06:f2
[    0.000524] MM: PAGE_OFFSET is 0xfff8000000000000 (max_phys_bits = 47)
[    0.000591] MM: VMALLOC [0x0000000100000000 --> 0x0006000000000000]
[    0.001681] MM: VMEMMAP [0x0006000000000000 --> 0x000c000000000000]
[    0.014136] Kernel: Using 5 locked TLB entries for main kernel image.
[    0.014224] Remapping the kernel...
[    0.014254] done.
[    0.022778] kmemleak: Kernel memory leak detector disabled
[    0.048367] OF stdout device is: /virtual-devices@100/console@1
[    0.048447] PROM: Built device tree with 74487 bytes of memory.
[    0.048513] MDESC: Size is 30976 bytes.
[    0.048634] PLATFORM: banner-name [SPARC T5-2]
[    0.048687] PLATFORM: name [ORCL,SPARC-T5-2]
[    0.048733] PLATFORM: hostid [84fa06f2]
[    0.048775] PLATFORM: serial# [0035260e]
[    0.048816] PLATFORM: stick-frequency [3b9aca00]
[    0.048864] PLATFORM: mac-address [144ffa06f2]
[    0.048911] PLATFORM: watchdog-resolution [1000 ms]
[    0.048964] PLATFORM: watchdog-max-timeout [31536000000 ms]
[    0.049022] PLATFORM: max-cpus [1024]
[    0.049131] Top of RAM: 0x40bf8b4000, Total RAM: 0x7ff37c000
[    0.049195] Memory hole size: 232453MB
[    0.173656] Allocated 40960 bytes for kernel page tables.
[    0.173782] Zone ranges:
[    0.173826]   Normal   [mem 0x0000000040400000-0x00000040bf8b3fff]
[    0.173898] Movable zone start for each node
[    0.174970] Early memory node ranges
[    0.175029]   node   0: [mem 0x0000000040400000-0x000000007febffff]
[    0.175100]   node   0: [mem 0x000000007ff40000-0x000000007ff47fff]
[    0.175161]   node   0: [mem 0x0000000080000000-0x000000077fffffff]
[    0.175221]   node   0: [mem 0x0000002000000000-0x000000202fffffff]
[    0.176318]   node   0: [mem 0x0000004030000000-0x00000040bf8b3fff]
[    0.176400] Initmem setup node 0 [mem 0x0000000040400000-0x00000040bf8b3fff]
[    0.176522] Kernel unaligned access at TPC[9f8a10]
minmax_subwin_update+0x30/0x100
[    0.176608] Unable to handle kernel NULL pointer dereference in mna handler
[    0.176614]  at virtual address 0000000000000009
[    0.176728] current->{active_,}mm->context = 0000000000000000
[    0.176787] current->{active_,}mm->pgd = fff8004030002000
[    0.176844]               \|/ ____ \|/
[    0.176844]               "@'/ .. \`@"
[    0.176844]               /_| \__/ |_\
[    0.176844]                  \__U_/
[    0.178015] swapper(0): Oops [#1]
[    0.178070] CPU: 0 PID: 0 Comm: swapper Not tainted 4.15.0-rc1 #527
[    0.178133] task: 0000000000c06c80 task.stack: 0000000000be8000
[    0.178190] TSTATE: 0000000080e01607 TPC: 00000000009f8a10 TNPC:
00000000009f8a14 Y: 0000000f    Not tainted
[    0.179325] TPC: <minmax_subwin_update+0x30/0x100>
[    0.179388] g0: 000000000000002d g1: 0000000001fb4000 g2:
0000000000080000 g3: 0000000001512630
[    0.179468] g4: 0000000000c06c80 g5: 0000000000000000 g6:
0000000000be8000 g7: 0000000000d16400
[    0.180578] o0: 0000000000000018 o1: 0000000000b702c8 o2:
00000000014c8968 o3: 0000000000000000
[    0.180681] o4: 000000000000000e o5: 00000000c0000000 sp:
0000000000beb171 ret_pc: 00000000005cd1cc
[    0.180773] RPC: <zone_batchsize.isra.7+0x4c/0x80>
[    0.180824] l0: 0000000000800000 l1: 0000000000d6d000 l2:
0000000000000000 l3: 0000000000cbc2c8
[    0.181938] l4: 0000000000bafe98 l5: 00000000fef195e1 l6:
0000000000c07538 l7: 09740cf2593a0d3c
[    0.182033] i0: 0000000000000001 i1: 0000000000b702c8 i2:
00000000014c8968 i3: 0000000000bebb00
[    0.182113] i4: 0000000000bebb08 i5: 0000000000000000 i6:
0000000000beb221 i7: 0000000000cfb8d8
[    0.183234] I7: <free_area_init_node+0x4ac/0x51c>
[    0.183299] Call Trace:
[    0.183334]  [0000000000cfb8d8] free_area_init_node+0x4ac/0x51c
[    0.183396]  [0000000000cdc960] free_area_init_nodes+0x548/0x574
[    0.184488]  [0000000000ccef1c] paging_init+0xf7c/0xf98
[    0.184557]  [0000000000cc96bc] setup_arch+0x284/0x708
[    0.184615]  [0000000000cc6718] start_kernel+0x60/0x4c8
[    0.184669]  [0000000000cc9394] start_early_boot+0x2c8/0x2d8
[    0.184731]  [0000000000a08400] tlb_fixup_done+0x4c/0x6c
[    0.185821]  [000000000011d8a4] 0x11d8a4
[    0.185878] Disabling lock debugging due to kernel taint
[    0.185945] Caller[0000000000cfb8d8]: free_area_init_node+0x4ac/0x51c
[    0.186012] Caller[0000000000cdc960]: free_area_init_nodes+0x548/0x574
[    0.187103] Caller[0000000000ccef1c]: paging_init+0xf7c/0xf98
[    0.187174] Caller[0000000000cc96bc]: setup_arch+0x284/0x708
[    0.187234] Caller[0000000000cc6718]: start_kernel+0x60/0x4c8
[    0.187289] Caller[0000000000cc9394]: start_early_boot+0x2c8/0x2d8
[    0.188377] Caller[0000000000a08400]: tlb_fixup_done+0x4c/0x6c
[    0.188448] Caller[000000000011d8a4]: 0x11d8a4
[    0.188495] Instruction DUMP:
[    0.188499]  fa062014
[    0.188531]  c4260000
[    0.188558]  c2262004
[    0.188586] <f8262008>
[    0.188614]  fa26200c
[    0.189669]  ce068000
[    0.189710]  ce262010
[    0.189739]  c606a004
[    0.189769]  c6262014
[    0.189798]
[    0.189845] Kernel panic - not syncing: Attempted to kill the idle task!
