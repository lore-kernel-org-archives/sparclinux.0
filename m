From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 29 Dec 2017 11:55:27 +0000
Subject: SPARC regressions in 4.14.7
Message-Id: <6cb2f5fa-970c-6122-0fb5-47b9b5b5ef82@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi!

I just updated of the Sun Fire T2000 we have in Debian from 4.14.2 to 4.14.7 which
apparently introduced a regression:

Segmentation fault
Segmentation fault
Segmentation fault
Segmentation fault
Segmentation fault
/dev/sda2: clean, 1168989/3448832 files, 12903789/13769712 blocks
Segmentation fault
[   27.780485] run-init[1]: segfault at 38 ip 000000008001069c (rpc 0000000000100500) sp 000007feffd88ec1 error 1 in
klibc-g_9mplOvk_73CeIA8YN-t9vhxyc.so[80000000+14000]
[   27.780994] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   27.780994]
[   27.781204] CPU: 8 PID: 1 Comm: run-init Not tainted 4.14.0-2-sparc64-smp #1 Debian 4.14.7-1
[   27.781255] Call Trace:
[   27.781304]  [000000000046be88] panic+0xe8/0x2a0
[   27.781346]  [0000000000471600] do_exit+0xb60/0xb80
[   27.781433]  [00000000004716cc] do_group_exit+0x2c/0xe0
[   27.781632]  [000000000047d4ac] get_signal+0x3ac/0x640
[   27.781688]  [000000000042db3c] do_signal+0x3c/0x480
[   27.781744]  [000000000042e7d0] do_notify_resume+0x50/0xa0
[   27.781796]  [0000000000404b44] __handle_signal+0xc/0x2c
[   27.782028] OOPS: Bogus kernel PC [0000000000000200] in fault handler
[   27.782034] OOPS: RPC [000000000042ceac]
[   27.782050] OOPS: RPC <arch_cpu_idle+0x6c/0xc0>
[   27.782054] OOPS: Fault was to vaddr[200]
[   27.782065] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.0-2-sparc64-smp #1 Debian 4.14.7-1
[   27.782069] Call Trace:
[   27.782086]  [0000000000a40334] do_sparc64_fault+0x8f4/0x960
[   27.782105]  [0000000000407694] sparc64_realfault_common+0x10/0x20
[   27.782114]  [0000000000000200] 0x200
[   27.782126]  [0000000000a3e308] default_idle_call+0x28/0x60
[   27.782142]  [00000000004b4250] do_idle+0xd0/0x1a0
[   27.782154]  [00000000004b455c] cpu_startup_entry+0x1c/0x40
[   27.782174]  [0000000000a37de0] rest_init+0xa0/0xc0
[   27.782356]  [0000000000cb6b64] start_kernel+0x498/0x4a8
[   27.782371]  [0000000000cb9408] start_early_boot+0x2b8/0x2c8
[   27.782385]  [0000000000a37d38] tlb_fixup_done+0x4c/0x54
[   27.782393]  [00000000000276a4] 0x276a4
[   27.782398] Unable to handle kernel NULL pointer dereference
[   27.782403] tsk->{mm,active_mm}->context = 00000000000000d2
[   27.782407] tsk->{mm,active_mm}->pgd = ffff8001f0e1a000
[   27.782413]               \|/ ____ \|/
[   27.782413]               "@'/ .. \`@"
[   27.782413]               /_| \__/ |_\
[   27.782413]                  \__U_/
[   27.782419] swapper/0(0): Oops [#1]
[   27.782430] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.0-2-sparc64-smp #1 Debian 4.14.7-1
[   27.782437] task: 0000000000c060c0 task.stack: 0000000000bec000
[   27.782445] TSTATE: 0000004480001607 TPC: 0000000000000200 TNPC: 0000000000000204 Y: 00000000    Not tainted
[   27.782451] TPC: <0x200>
[   27.782459] g0: 00000000f027e858 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000
[   27.782467] g4: 0000000000005a20 g5: ffff8001fead0000 g6: 0000000000bec000 g7: 0000000000000000
[   27.782474] o0: 0000000000000200 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000
[   27.782481] o4: 0000000000000000 o5: 0000000000000000 sp: 0000000000bef251 ret_pc: 000000000042ceac
[   27.782494] RPC: <arch_cpu_idle+0x6c/0xc0>
[   27.782503] l0: 0000000040004190 l1: 000000004000407c l2: 0000000040004059 l3: 0000000000000040
[   27.782511] l4: 00000000f027e858 l5: 0000000040004128 l6: 0000000000000000 l7: 00000000f025cfd8
[   27.782518] i0: 000000000000000e i1: 0000000000bec008 i2: 0000000000004000 i3: 0000000000000200
[   27.782525] i4: 00000000fef42ff8 i5: 00000000fef41800 i6: 0000000000bef301 i7: 0000000000a3e308
[   27.782536] I7: <default_idle_call+0x28/0x60>
[   27.782540] Call Trace:
[   27.782551]  [0000000000a3e308] default_idle_call+0x28/0x60
[   27.782564]  [00000000004b4250] do_idle+0xd0/0x1a0
[   27.782575]  [00000000004b455c] cpu_startup_entry+0x1c/0x40
[   27.782590]  [0000000000a37de0] rest_init+0xa0/0xc0
[   27.782603]  [0000000000cb6b64] start_kernel+0x498/0x4a8
[   27.782616]  [0000000000cb9408] start_early_boot+0x2b8/0x2c8
[   27.782630]  [0000000000a37d38] tlb_fixup_done+0x4c/0x54
[   27.782637]  [00000000000276a4] 0x276a4
[   27.782642] Disabling lock debugging due to kernel taint
[   27.782654] Caller[0000000000a3e308]: default_idle_call+0x28/0x60
[   27.782667] Caller[00000000004b4250]: do_idle+0xd0/0x1a0
[   27.782679] Caller[00000000004b455c]: cpu_startup_entry+0x1c/0x40
[   27.782693] Caller[0000000000a37de0]: rest_init+0xa0/0xc0
[   27.782706] Caller[0000000000cb6b64]: start_kernel+0x498/0x4a8
[   27.782719] Caller[0000000000cb9408]: start_early_boot+0x2b8/0x2c8
[   27.782733] Caller[0000000000a37d38]: tlb_fixup_done+0x4c/0x54
[   27.782741] Caller[00000000000276a4]: 0x276a4
[   27.782744] Instruction DUMP:
[   27.782754] Unable to handle kernel NULL pointer dereference
[   27.782759] tsk->{mm,active_mm}->context = 00000000000000d2
[   27.782764] tsk->{mm,active_mm}->pgd = ffff8001f0e1a000
[   27.782769]               \|/ ____ \|/
[   27.782769]               "@'/ .. \`@"
[   27.782769]               /_| \__/ |_\
[   27.782769]                  \__U_/
[   27.782774] swapper/0(0): Oops [#2]
[   27.782786] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D         4.14.0-2-sparc64-smp #1 Debian 4.14.7-1
[   27.782792] task: 0000000000c060c0 task.stack: 0000000000bec000
[   27.782801] TSTATE: 0000008880001603 TPC: 0000000000428dac TNPC: 0000000000428db0 Y: 00000000    Tainted: G      D
[   27.782812] TPC: <die_if_kernel+0x26c/0x300>
[   27.782820] g0: 0000000000000004 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000000
[   27.782827] g4: 0000000000c060c0 g5: ffff8001fead0000 g6: 0000000000bec000 g7: 000000000000000e
[   27.782835] o0: 0000000000000011 o1: 0000000000000020 o2: 00000000000276a4 o3: 0000000000000204
[   27.782842] o4: 0000000000000200 o5: 0000004480001607 sp: 0000000000beee81 ret_pc: 0000000000428d8c
[   27.782851] RPC: <die_if_kernel+0x24c/0x300>
[   27.782859] l0: 0000000000b29090 l1: 0000000000bec000 l2: 0000000000becb80 l3: 0000000000beff40
[   27.782867] l4: 0000000000000004 l5: 0000000000000200 l6: 0000000000bec000 l7: 0000000080001000
[   27.782874] i0: 0000000000d50998 i1: 0000000000bef9b0 i2: 0000000000d51198 i3: fffffffffffffffd
[   27.782882] i4: 0000000000b290c0 i5: 0000000000000200 i6: 0000000000beef71 i7: 0000000000a3fa20
[   27.782893] I7: <unhandled_fault+0x8c/0xac>
[   27.782897] Call Trace:
[   27.782908]  [0000000000a3fa20] unhandled_fault+0x8c/0xac
[   27.782919]  [0000000000a40344] do_sparc64_fault+0x904/0x960
[   27.782936]  [0000000000407694] sparc64_realfault_common+0x10/0x20
[   27.782943]  [0000000000000200] 0x200
[   27.782954]  [0000000000a3e308] default_idle_call+0x28/0x60
[   27.782967]  [00000000004b4250] do_idle+0xd0/0x1a0
[   27.782979]  [00000000004b455c] cpu_startup_entry+0x1c/0x40
[   27.782994]  [0000000000a37de0] rest_init+0xa0/0xc0
[   27.783007]  [0000000000cb6b64] start_kernel+0x498/0x4a8
[   27.783020]  [0000000000cb9408] start_early_boot+0x2b8/0x2c8
[   27.783034]  [0000000000a37d38] tlb_fixup_done+0x4c/0x54
[   27.783042]  [00000000000276a4] 0x276a4
[   27.783055] Caller[0000000000a3fa20]: unhandled_fault+0x8c/0xac
[   27.783066] Caller[0000000000a40344]: do_sparc64_fault+0x904/0x960
[   27.783082] Caller[0000000000407694]: sparc64_realfault_common+0x10/0x20
[   27.783096] Caller[000000000042ceac]: arch_cpu_idle+0x6c/0xc0
[   27.783108] Caller[0000000000a3e308]: default_idle_call+0x28/0x60
[   27.783121] Caller[00000000004b4250]: do_idle+0xd0/0x1a0
[   27.783133] Caller[00000000004b455c]: cpu_startup_entry+0x1c/0x40
[   27.783148] Caller[0000000000a37de0]: rest_init+0xa0/0xc0
[   27.783161] Caller[0000000000cb6b64]: start_kernel+0x498/0x4a8
[   27.783175] Caller[0000000000cb9408]: start_early_boot+0x2b8/0x2c8
[   27.783189] Caller[0000000000a37d38]: tlb_fixup_done+0x4c/0x54
[   27.783197] Caller[00000000000276a4]: 0x276a4
[   27.783200] Instruction DUMP:
[   27.783205]  02400022
[   27.783209]  832ef002
[   27.783214]  92102020
[   27.783218] <d4074001>
[   27.783223]  96102020
[   27.783227]  9532a000
[   27.783232]  40029562
[   27.783236]  9010001c
[   27.783240]  b606e001
[   27.783244]
[   27.802071] OOPS: Bogus kernel PC [0000000000000e80] in fault handler
[   27.802076] OOPS: RPC [000000000042ceac]
[   27.802091] OOPS: RPC <arch_cpu_idle+0x6c/0xc0>
[   27.802096] OOPS: Fault was to vaddr[e80]
[   27.802109] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.14.0-2-sparc64-smp #1 Debian 4.14.7-1
[   27.802112] Call Trace:
[   27.802127]  [0000000000a40334] do_sparc64_fault+0x8f4/0x960
[   27.802145]  [0000000000407694] sparc64_realfault_common+0x10/0x20
[   27.802153]  [0000000000000e80] 0xe80
[   27.802165]  [0000000000a3e308] default_idle_call+0x28/0x60
[   27.802179]  [00000000004b4250] do_idle+0xd0/0x1a0
[   27.802192]  [00000000004b455c] cpu_startup_entry+0x1c/0x40
[   27.802214]  [000000000043fbc0] smp_callin+0x100/0x140
[   27.802222]  [0000000000c0ddb4] 0xc0ddb4
[   27.802229]  [0000000000000000]           (null)
[   27.802234] Unable to handle kernel NULL pointer dereference
[   27.802239] tsk->{mm,active_mm}->context = 00000000000000c6
[   27.802244] tsk->{mm,active_mm}->pgd = ffff8001f4558000
[   27.802249]               \|/ ____ \|/
[   27.802249]               "@'/ .. \`@"
[   27.802249]               /_| \__/ |_\
[   27.802249]                  \__U_/
[   27.802255] swapper/1(0): Oops [#3]
[   27.802268] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.14.0-2-sparc64-smp #1 Debian 4.14.7-1
[   27.802275] task: ffff8000086db400 task.stack: ffff800008704000
[   27.802285] TSTATE: 0000004480001605 TPC: 0000000000000e80 TNPC: 0000000000000e84 Y: 00000000    Tainted: G      D
[   27.802291] TPC: <0xe80>
[   27.802300] g0: 80000000090007c3 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000
[   27.802308] g4: 0000000000005a20 g5: ffff8001feb10000 g6: ffff800008704000 g7: 0000000000000001
[   27.802316] o0: 0000000000000e80 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000
[   27.802324] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8000087073d1 ret_pc: 000000000042ceac
[   27.802338] RPC: <arch_cpu_idle+0x6c/0xc0>
[   27.802346] l0: 0000000000d56610 l1: 0000000000005a10 l2: 0000000000000011 l3: 0000000000400000
[   27.802354] l4: 80000000090007c3 l5: 0000000000000003 l6: 0000000000000003 l7: 0000000000000000
[   27.802362] i0: 000000000000000e i1: ffff800008704008 i2: 0000000000004000 i3: 0000000000000e80
[   27.802371] i4: 00000000fef48ff8 i5: 00000000fef47800 i6: ffff800008707481 i7: 0000000000a3e308
[   27.802382] I7: <default_idle_call+0x28/0x60>
[   27.802386] Call Trace:
[   27.802398]  [0000000000a3e308] default_idle_call+0x28/0x60
[   27.802412]  [00000000004b4250] do_idle+0xd0/0x1a0
[   27.802425]  [00000000004b455c] cpu_startup_entry+0x1c/0x40
[   27.802442]  [000000000043fbc0] smp_callin+0x100/0x140
[   27.802450]  [0000000000c0ddb4] 0xc0ddb4
[   27.802456]  [0000000000000000]           (null)
[   27.802470] Caller[0000000000a3e308]: default_idle_call+0x28/0x60
[   27.802483] Caller[00000000004b4250]: do_idle+0xd0/0x1a0
[   27.802496] Caller[00000000004b455c]: cpu_startup_entry+0x1c/0x40
[   27.802511] Caller[000000000043fbc0]: smp_callin+0x100/0x140
[   27.802519] Caller[0000000000c0ddb4]: 0xc0ddb4
[   27.802525] Caller[0000000000000000]:           (null)
[   27.802528] Instruction DUMP:
[   27.802537] Unable to handle kernel NULL pointer dereference
[   27.802542] tsk->{mm,active_mm}->context = 00000000000000c6
[   27.802547] tsk->{mm,active_mm}->pgd = ffff8001f4558000
[   27.802553]               \|/ ____ \|/
[   27.802553]               "@'/ .. \`@"
[   27.802553]               /_| \__/ |_\
[   27.802553]                  \__U_/
[   27.802559] swapper/1(0): Oops [#4]
[   27.802571] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.14.0-2-sparc64-smp #1 Debian 4.14.7-1
[   27.802578] task: ffff8000086db400 task.stack: ffff800008704000
[   27.802588] TSTATE: 0000008880001601 TPC: 0000000000428dac TNPC: 0000000000428db0 Y: 00000000    Tainted: G      D
[   27.802600] TPC: <die_if_kernel+0x26c/0x300>
[   27.802608] g0: 0000000000000004 g1: fffffffffffffff4 g2: 0000000000000000 g3: 0000000000000001
[   27.802617] g4: ffff8000086db400 g5: ffff8001feb10000 g6: ffff800008704000 g7: 000000000000000e
[   27.802625] o0: 0000000000000011sc>

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
