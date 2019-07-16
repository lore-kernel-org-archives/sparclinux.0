From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 16 Jul 2019 09:11:47 +0000
Subject: Re: [sparc64] soft lockup - CPU stuck , KGDB_TESTS_ON_BOOT
Message-Id: <CADxRZqzoz2LSKv0OzsgJzHWrF1d451Gjd5S39fFCgR=qpKgOmA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqxP8A7+8QdB5Q2df4g_OeBbARB1UAg-acaEL=mGJWr_rw@mail.gmail.com>
In-Reply-To: <CADxRZqxP8A7+8QdB5Q2df4g_OeBbARB1UAg-acaEL=mGJWr_rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Feb 4, 2019 at 6:24 PM Anatoly Pugachev <matorola@gmail.com> wrote:
> > > My current LDOM configuration allocated 3 cores (3x8 = 24 vcpus).
> > > Tried as well with 2 vcpus and 1 vcpu. Any configuration, except 1
> > > vcpu, does not boot, but single vcpu boots ok.
> > >
> > > Enabled the following kernel config options:
> > >
> > > CONFIG_KGDB_TESTS=y
> > > CONFIG_KGDB_TESTS_ON_BOOT=y

still valid for 5.2.0-10808-g9637d517347e , but goes to OOPS even
faster (without first kgdb tests as in previous logs):

[    2.169180] sunvdc: Virtual Hard disk vdiska
[    2.169237] sunvdc: vdiska: 31457280 sectors (15360 MB) protocol 1.2
[    2.170214]  vdiska: vdiska1 vdiska2 vdiska3 vdiska4
[    2.218420] KGDB: Registered I/O driver kgdbts
[    2.219011] kgdbts:RUN plant and detach test

Entering kdb (current=0xfff80024a0f5c020, pid 1) [    2.220160]
------------[ cut here ]------------
[    2.220217] WARNING: CPU: 10 PID: 1 at drivers/tty/vt/vt.c:3846
con_is_visible+0x44/0x80
[    2.220233] Modules linked in:
[    2.220255] CPU: 10 PID: 1 Comm: swapper/0 Not tainted
5.2.0-10808-g9637d517347e #1080
[    2.220272] Call Trace:
[    2.220299]  [00000000004642c0] __warn+0xc0/0x100
[    2.220317]  [0000000000464750] warn_slowpath_null+0x2c/0x3c
[    2.220335]  [00000000008ef624] con_is_visible+0x44/0x80
[    2.220354]  [00000000008f1398] con_scroll+0x58/0x200
[    2.220371]  [00000000008f1574] lf+0x34/0xa0
[    2.220389]  [00000000008f17ec] vt_console_print+0x20c/0x3a0
[    2.220416]  [000000000055d934] vkdb_printf+0x4f4/0xa00
[    2.220435]  [000000000055c98c] kdb_printf+0x2c/0x40
[    2.220453]  [0000000000561580] kdb_main_loop+0x100/0x8a0
[    2.220472]  [0000000000564b24] kdb_stub+0x304/0x460
[    2.220490]  [000000000055a254] kgdb_cpu_enter+0x574/0x800
[    2.220508]  [000000000055a848] kgdb_handle_exception+0x1e8/0x220
[    2.220528]  [0000000000442e70] kgdb_trap+0x50/0xa0
[    2.220548]  [00000000004274d8] sys_call_table+0x7c8/0x970
[    2.220571]  [0000000000405ec4] arch_kgdb_breakpoint+0x0/0xc
[    2.220593]  [000000000091df9c] run_plant_and_detach_test+0x5c/0xe0
[    2.220609] irq event stamp: 460692
[    2.220628] hardirqs last  enabled at (460691):
[<00000000004e2470>] console_unlock+0x630/0x6c0
[    2.220647] hardirqs last disabled at (460692):
[<00000000004274cc>] sys_call_table+0x7bc/0x970
[    2.220670] softirqs last  enabled at (458662):
[<0000000000ac9674>] __do_softirq+0x494/0x500
[    2.220693] softirqs last disabled at (458655):
[<000000000042d014>] do_softirq_own_stack+0x34/0x60
[    2.220726] ---[ end trace 30d9f6bedad411c5 ]---
[    2.220782] ------------[ cut here ]------------
[    2.220800] WARNING: CPU: 10 PID: 1 at drivers/tty/vt/vt.c:3846
con_is_visible+0x44/0x80
[    2.220816] Modules linked in:
[    2.220835] CPU: 10 PID: 1 Comm: swapper/0 Tainted: G        W
   5.2.0-10808-g9637d517347e #1080
[    2.220851] Call Trace:
[    2.220868]  [00000000004642c0] __warn+0xc0/0x100
[    2.220885]  [0000000000464750] warn_slowpath_null+0x2c/0x3c
[    2.220903]  [00000000008ef624] con_is_visible+0x44/0x80
[    2.220921]  [00000000008f18f4] vt_console_print+0x314/0x3a0
[    2.220939]  [000000000055d934] vkdb_printf+0x4f4/0xa00
[    2.220957]  [000000000055c98c] kdb_printf+0x2c/0x40
[    2.220974]  [0000000000561580] kdb_main_loop+0x100/0x8a0
[    2.220991]  [0000000000564b24] kdb_stub+0x304/0x460
[    2.221009]  [000000000055a254] kgdb_cpu_enter+0x574/0x800
[    2.221026]  [000000000055a848] kgdb_handle_exception+0x1e8/0x220
[    2.221044]  [0000000000442e70] kgdb_trap+0x50/0xa0
[    2.221061]  [00000000004274d8] sys_call_table+0x7c8/0x970
[    2.221079]  [0000000000405ec4] arch_kgdb_breakpoint+0x0/0xc
[    2.221097]  [000000000091df9c] run_plant_and_detach_test+0x5c/0xe0
[    2.221115]  [000000000091efe8] configure_kgdbts+0x1e8/0x5a0
[    2.221143]  [0000000000dfafb8] init_kgdbts+0x20/0x34
[    2.221159] irq event stamp: 460692
[    2.221177] hardirqs last  enabled at (460691):
[<00000000004e2470>] console_unlock+0x630/0x6c0
[    2.221197] hardirqs last disabled at (460692):
[<00000000004274cc>] sys_call_table+0x7bc/0x970
[    2.221217] softirqs last  enabled at (458662):
[<0000000000ac9674>] __do_softirq+0x494/0x500
[    2.221237] softirqs last disabled at (458655):
[<000000000042d014>] do_softirq_own_stack+0x34/0x60
[    2.221254] ---[ end trace 30d9f6bedad411c6 ]---
on processor 10 [    2.221302] ------------[ cut here ]------------
[    2.221325] WARNING: CPU: 10 PID: 1 at drivers/tty/vt/vt.c:3846
con_is_visible+0x44/0x80
[    2.221342] Modules linked in:
[    2.221362] CPU: 10 PID: 1 Comm: swapper/0 Tainted: G        W
   5.2.0-10808-g9637d517347e #1080
[    2.221378] Call Trace:
[    2.221398]  [00000000004642c0] __warn+0xc0/0x100
[    2.221416]  [0000000000464750] warn_slowpath_null+0x2c/0x3c
[    2.221432]  [00000000008ef624] con_is_visible+0x44/0x80
[    2.221450]  [00000000008f18f4] vt_console_print+0x314/0x3a0
[    2.221469]  [000000000055d934] vkdb_printf+0x4f4/0xa00
[    2.221486]  [000000000055c98c] kdb_printf+0x2c/0x40
[    2.221504]  [0000000000561590] kdb_main_loop+0x110/0x8a0
[    2.221522]  [0000000000564b24] kdb_stub+0x304/0x460
[    2.221540]  [000000000055a254] kgdb_cpu_enter+0x574/0x800
[    2.221560]  [000000000055a848] kgdb_handle_exception+0x1e8/0x220
[    2.221580]  [0000000000442e70] kgdb_trap+0x50/0xa0
[    2.221597]  [00000000004274d8] sys_call_table+0x7c8/0x970
[    2.221617]  [0000000000405ec4] arch_kgdb_breakpoint+0x0/0xc
[    2.221635]  [000000000091df9c] run_plant_and_detach_test+0x5c/0xe0
[    2.221653]  [000000000091efe8] configure_kgdbts+0x1e8/0x5a0
[    2.221670]  [0000000000dfafb8] init_kgdbts+0x20/0x34
[    2.221686] irq event stamp: 460692
[    2.221703] hardirqs last  enabled at (460691):
[<00000000004e2470>] console_unlock+0x630/0x6c0
[    2.221722] hardirqs last disabled at (460692):
[<00000000004274cc>] sys_call_table+0x7bc/0x970
[    2.221742] softirqs last  enabled at (458662):
[<0000000000ac9674>] __do_softirq+0x494/0x500
[    2.221761] softirqs last disabled at (458655):
[<000000000042d014>] do_softirq_own_stack+0x34/0x60
[    2.221778] ---[ end trace 30d9f6bedad411c7 ]---
due to Keyboard Entry
[    2.221815] ------------[ cut here ]------------
[    2.221836] WARNING: CPU: 10 PID: 1 at drivers/tty/vt/vt.c:3846
con_is_visible+0x44/0x80
[    2.221851] Modules linked in:
[    2.221871] CPU: 10 PID: 1 Comm: swapper/0 Tainted: G        W
   5.2.0-10808-g9637d517347e #1080
[    2.221887] Call Trace:
[    2.221904]  [00000000004642c0] __warn+0xc0/0x100
[    2.221921]  [0000000000464750] warn_slowpath_null+0x2c/0x3c
[    2.221939]  [00000000008ef624] con_is_visible+0x44/0x80
[    2.221956]  [00000000008f174c] vt_console_print+0x16c/0x3a0
[    2.221975]  [000000000055d934] vkdb_printf+0x4f4/0xa00
[    2.221993]  [000000000055c98c] kdb_printf+0x2c/0x40
[    2.222010]  [00000000005616b0] kdb_main_loop+0x230/0x8a0
[    2.222029]  [0000000000564b24] kdb_stub+0x304/0x460
[    2.222046]  [000000000055a254] kgdb_cpu_enter+0x574/0x800
[    2.222064]  [000000000055a848] kgdb_handle_exception+0x1e8/0x220
[    2.222083]  [0000000000442e70] kgdb_trap+0x50/0xa0
[    2.222100]  [00000000004274d8] sys_call_table+0x7c8/0x970
[    2.222121]  [0000000000405ec4] arch_kgdb_breakpoint+0x0/0xc
[    2.222142]  [000000000091df9c] run_plant_and_detach_test+0x5c/0xe0
[    2.222163]  [000000000091efe8] configure_kgdbts+0x1e8/0x5a0
[    2.222187]  [0000000000dfafb8] init_kgdbts+0x20/0x34
[    2.222203] irq event stamp: 460692
[    2.222221] hardirqs last  enabled at (460691):
[<00000000004e2470>] console_unlock+0x630/0x6c0
[    2.222240] hardirqs last disabled at (460692):
[<00000000004274cc>] sys_call_table+0x7bc/0x970
[    2.222259] softirqs last  enabled at (458662):
[<0000000000ac9674>] __do_softirq+0x494/0x500
[    2.222277] softirqs last disabled at (458655):
[<000000000042d014>] do_softirq_own_stack+0x34/0x60
[    2.222296] ---[ end trace 30d9f6bedad411c8 ]---
[    2.222313] ------------[ cut here ]------------
[    2.222332] WARNING: CPU: 10 PID: 1 at drivers/tty/vt/vt.c:3846
con_is_visible+0x44/0x80
[    2.222348] Modules linked in:
[    2.222368] CPU: 10 PID: 1 Comm: swapper/0 Tainted: G        W
   5.2.0-10808-g9637d517347e #1080
[    2.222384] Call Trace:
[    2.222402]  [00000000004642c0] __warn+0xc0/0x100
[    2.222420]  [0000000000464750] warn_slowpath_null+0x2c/0x3c
[    2.222437]  [00000000008ef624] con_is_visible+0x44/0x80
[    2.222456]  [00000000008f1398] con_scroll+0x58/0x200
[    2.222473]  [00000000008f1574] lf+0x34/0xa0
[    2.222491]  [00000000008f17ec] vt_console_print+0x20c/0x3a0
[    2.222509]  [000000000055d934] vkdb_printf+0x4f4/0xa00
[    2.222527]  [000000000055c98c] kdb_printf+0x2c/0x40
[    2.222546]  [00000000005616b0] kdb_main_loop+0x230/0x8a0
[    2.222565]  [0000000000564b24] kdb_stub+0x304/0x460
[    2.222585]  [000000000055a254] kgdb_cpu_enter+0x574/0x800
[    2.222604]  [000000000055a848] kgdb_handle_exception+0x1e8/0x220
[    2.222623]  [0000000000442e70] kgdb_trap+0x50/0xa0
[    2.222642]  [00000000004274d8] sys_call_table+0x7c8/0x970
[    2.222663]  [0000000000405ec4] arch_kgdb_breakpoint+0x0/0xc
[    2.222682]  [000000000091df9c] run_plant_and_detach_test+0x5c/0xe0
[    2.222698] irq event stamp: 460692
[    2.222715] hardirqs last  enabled at (460691):
[<00000000004e2470>] console_unlock+0x630/0x6c0
[    2.222733] hardirqs last disabled at (460692):
[<00000000004274cc>] sys_call_table+0x7bc/0x970
[    2.222752] softirqs last  enabled at (458662):
[<0000000000ac9674>] __do_softirq+0x494/0x500
[    2.222774] softirqs last disabled at (458655):
[<000000000042d014>] do_softirq_own_stack+0x34/0x60
[    2.222790] ---[ end trace 30d9f6bedad411c9 ]---
[    2.222817] ------------[ cut here ]------------
[    2.222836] WARNING: CPU: 10 PID: 1 at drivers/tty/vt/vt.c:3846
con_is_visible+0x44/0x80
[    2.222852] Modules linked in:
[    2.222871] CPU: 10 PID: 1 Comm: swapper/0 Tainted: G        W
   5.2.0-10808-g9637d517347e #1080
[    2.222887] Call Trace:
[    2.222905]  [00000000004642c0] __warn+0xc0/0x100
[    2.222923]  [0000000000464750] warn_slowpath_null+0x2c/0x3c
[    2.222941]  [00000000008ef624] con_is_visible+0x44/0x80
[    2.222959]  [00000000008f174c] vt_console_print+0x16c/0x3a0
[    2.222978]  [000000000055d934] vkdb_printf+0x4f4/0xa00
[    2.222997]  [000000000055c98c] kdb_printf+0x2c/0x40
[    2.223013]  [00000000005616b0] kdb_main_loop+0x230/0x8a0
[    2.223030]  [0000000000564b24] kdb_stub+0x304/0x460
[    2.223047]  [000000000055a254] kgdb_cpu_enter+0x574/0x800
[    2.223064]  [000000000055a848] kgdb_handle_exception+0x1e8/0x220
[    2.223083]  [0000000000442e70] kgdb_trap+0x50/0xa0
[    2.223100]  [00000000004274d8] sys_call_table+0x7c8/0x970
[    2.223119]  [0000000000405ec4] arch_kgdb_breakpoint+0x0/0xc
[    2.223138]  [000000000091df9c] run_plant_and_detach_test+0x5c/0xe0
[    2.223156]  [000000000091efe8] configure_kgdbts+0x1e8/0x5a0
[    2.223182]  [0000000000dfafb8] init_kgdbts+0x20/0x34
[    2.223199] irq event stamp: 460692
[    2.223218] hardirqs last  enabled at (460691):
[<00000000004e2470>] console_unlock+0x630/0x6c0
[    2.223237] hardirqs last disabled at (460692):
[<00000000004274cc>] sys_call_table+0x7bc/0x970
[    2.223257] softirqs last  enabled at (458662):
[<0000000000ac9674>] __do_softirq+0x494/0x500
[    2.223277] softirqs last disabled at (458655):
[<000000000042d014>] do_softirq_own_stack+0x34/0x60
[    2.223294] ---[ end trace 30d9f6bedad411ca ]---
[    2.223311] ------------[ cut here ]------------
[    2.223330] WARNING: CPU: 10 PID: 1 at drivers/tty/vt/vt.c:3846
con_is_visible+0x44/0x80
[    2.223346] Modules linked in:
[    2.223365] CPU: 10 PID: 1 Comm: swapper/0 Tainted: G        W
   5.2.0-10808-g9637d517347e #1080
[    2.223382] Call Trace:
[    2.223404]  [00000000004642c0] __warn+0xc0/0x100
[    2.223421]  [0000000000464750] warn_slowpath_null+0x2c/0x3c
[    2.223441]  [00000000008ef624] con_is_visible+0x44/0x80
[    2.223460]  [00000000008f1398] con_scroll+0x58/0x200
[    2.223478]  [00000000008f1574] lf+0x34/0xa0
[    2.223496]  [00000000008f17ec] vt_console_print+0x20c/0x3a0
[    2.223516]  [000000000055d934] vkdb_printf+0x4f4/0xa00
[    2.223534]  [000000000055c98c] kdb_printf+0x2c/0x40
[    2.223551]  [00000000005616b0] kdb_main_loop+0x230/0x8a0
[    2.223569]  [0000000000564b24] kdb_stub+0x304/0x460
[    2.223589]  [000000000055a254] kgdb_cpu_enter+0x574/0x800
[    2.223609]  [000000000055a848] kgdb_handle_exception+0x1e8/0x220
[    2.223635]  [0000000000442e70] kgdb_trap+0x50/0xa0
[    2.223654]  [00000000004274d8] sys_call_table+0x7c8/0x970
[    2.223676]  [0000000000405ec4] arch_kgdb_breakpoint+0x0/0xc
[    2.223695]  [000000000091df9c] run_plant_and_detach_test+0x5c/0xe0
[    2.223711] irq event stamp: 460692
[    2.223730] hardirqs last  enabled at (460691):
[<00000000004e2470>] console_unlock+0x630/0x6c0
[    2.223748] hardirqs last disabled at (460692):
[<00000000004274cc>] sys_call_table+0x7bc/0x970
[    2.223767] softirqs last  enabled at (458662):
[<0000000000ac9674>] __do_softirq+0x494/0x500
[    2.223788] softirqs last disabled at (458655):
[<000000000042d014>] do_softirq_own_stack+0x34/0x60
[    2.223804] ---[ end trace 30d9f6bedad411cb ]---
[10]kdb> [    2.223857] ------------[ cut here ]------------
[    2.223879] WARNING: CPU: 10 PID: 1 at drivers/tty/vt/vt.c:3846
con_is_visible+0x44/0x80
[    2.223895] Modules linked in:
[    2.223915] CPU: 10 PID: 1 Comm: swapper/0 Tainted: G        W
   5.2.0-10808-g9637d517347e #1080
[    2.223931] Call Trace:
[    2.223950]  [00000000004642c0] __warn+0xc0/0x100
[    2.223967]  [0000000000464750] warn_slowpath_null+0x2c/0x3c
[    2.223984]  [00000000008ef624] con_is_visible+0x44/0x80
[    2.224001]  [00000000008f18f4] vt_console_print+0x314/0x3a0
[    2.224020]  [000000000055d934] vkdb_printf+0x4f4/0xa00
[    2.224038]  [000000000055c98c] kdb_printf+0x2c/0x40
[    2.224055]  [000000000055d418] kdb_getstr+0x38/0x60
[    2.224072]  [0000000000561930] kdb_main_loop+0x4b0/0x8a0
[    2.224091]  [0000000000564b24] kdb_stub+0x304/0x460
[    2.224109]  [000000000055a254] kgdb_cpu_enter+0x574/0x800
[    2.224128]  [000000000055a848] kgdb_handle_exception+0x1e8/0x220
[    2.224148]  [0000000000442e70] kgdb_trap+0x50/0xa0
[    2.224166]  [00000000004274d8] sys_call_table+0x7c8/0x970
[    2.224185]  [0000000000405ec4] arch_kgdb_breakpoint+0x0/0xc
[    2.224204]  [000000000091df9c] run_plant_and_detach_test+0x5c/0xe0
[    2.224222]  [000000000091efe8] configure_kgdbts+0x1e8/0x5a0
[    2.224238] irq event stamp: 460692
[    2.224256] hardirqs last  enabled at (460691):
[<00000000004e2470>] console_unlock+0x630/0x6c0
[    2.224274] hardirqs last disabled at (460692):
[<00000000004274cc>] sys_call_table+0x7bc/0x970
[    2.224293] softirqs last  enabled at (458662):
[<0000000000ac9674>] __do_softirq+0x494/0x500
[    2.224312] softirqs last disabled at (458655):
[<000000000042d014>] do_softirq_own_stack+0x34/0x60
[    2.224329] ---[ end trace 30d9f6bedad411cc ]---
