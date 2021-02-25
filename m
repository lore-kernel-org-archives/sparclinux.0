From: Meelis Roos <mroos@linux.ee>
Date: Thu, 25 Feb 2021 19:12:47 +0000
Subject: Re: bisected kernel crash on sparc64 with stress-ng
Message-Id: <3d42713e-bff6-63d9-2c0e-781e829d78f8@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
In-Reply-To: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

> 1. If you want to do it just with ng-stress, you could change it so that instead of generating a random opcode and executing it, generate a list of (many) random opcodes on your ssh client, and send them over to the test machine to be executed. If the system doesn't crash or hang, generate a new list and try again. If it does crash, then do a binary search on the list of opcodes to find the culprit.

Well, it generates many opcodes butI do not feel like redesigning stress-ng  opcode stressto client-server solution, I better go with your kernel modifications.
> 
> 2. If that sounds like too much work, we could print the instructions in the kernel when we know we're going to return true. (Sorry the formatting of this will likely be messed up):

Tried it on top of todays git 5.11.0-09786-g3b9cdafb535


[   92.724186] fixing up no fault insn c6c310ca
[   94.675033] fixing up no fault insn c8c6d0de
[   94.742247] fixing up no fault insn c8c6d0de


Login incorrect
v240 login:
Password:

Login incorrect
v240 login: [  125.751204] fixing up no fault insn dad750ec

Login timed out
Debian GNU/Linux stretch/sid v240 ttyS0

v240 login: [  128.809516] fixing up no fault insn ea8fd1cb
[  133.757945] fixing up no fault insn fff21079
[  133.819635] fixing up no fault insn fff21079
[  134.605780] fixing up no fault insn e09810de

Debian GNU/Linux stretch/sid v240 ttyS0

v240 login: [  138.514897] fixing up no fault insn cf95d1ef
[  138.571102] fixing up no fault insn cf95d1ef
[  138.627244] fixing up no fault insn cf95d1ef
[  138.683339] fixing up no fault insn cf95d1ef
[  138.739382] fixing up no fault insn cf95d1ef
[  138.795443] fixing up no fault insn cf95d1ef
[  138.851583] fixing up no fault insn cf95d1ef
[  138.907736] fixing up no fault insn cf95d1ef
[  138.963879] fixing up no fault insn cf95d1ef
[  139.020024] fixing up no fault insn cf95d1ef
[  139.076068] fixing up no fault insn cf95d1ef
[  139.132114] fixing up no fault insn cf95d1ef
[  139.188159] fixing up no fault insn cf95d1ef
[  139.244203] fixing up no fault insn cf95d1ef
[  139.300251] fixing up no fault insn cf95d1ef
[  139.356293] fixing up no fault insn cf95d1ef
[  139.412339] fixing up no fault insn cf95d1ef
[  139.468386] fixing up no fault insn cf95d1ef
[  139.524432] fixing up no fault insn cf95d1ef
[  139.580474] fixing up no fault insn cf95d1ef
[  139.636524] fixing up no fault insn cf95d1ef
[  139.692570] fixing up no fault insn cf95d1ef
[  139.748607] fixing up no fault insn cf95d1ef
[  139.804655] fixing up no fault insn cf95d1ef
[  139.860720] fixing up no fault insn cf95d1ef
[  139.860869] Kernel unaligned access at TPC[4add34] cpuacct_charge+0x74/0x80
[  139.916835] Kernel unaligned access at TPC[469db0] irq_enter_rcu+0x10/0x80


 From two boots, the insn varies among
c798d0c9
c8c6d0de
cf95d1ef
d49cd066
dad750ec
e09810de
e3e790c4
e5a051cb
e7f21165
ea8fd1cb
ebb611fc
f4c551de
fe8690fd
fff21079

On last try, "fixing up no fault insn ebb611fc" appeared many times and the the machine hung with nothing more on seerial console. This was the second hang like that.


> 3. I have a theory that the instruction may be something like this:
> 
>          sta %f0, [ %g0 ] #ASI_PNF
> 
> which should assemble to 0xc1a01040. You could just try this instruction.

Putting 0xc1a01040 at the start of the opcode sequence makes the test spew this in dmesg 26 times:
fixing up no fault insn c1a01040
and then the kernel hangs.
  
> 4. If this does result in a crash, this patch might be the fix:

Yes, with this patch only, it works for multiple minutes and is stable. Nothing in dmesg either.

> 5. Here is another patch to try after the others:


This resulted in a crash (this is different, irq5 during mm code):

[  304.847868] Unable to handle kernel paging request at virtual address ffffffffffffe000
[  304.952010] tsk->{mm,active_mm}->context = 00000000000009be
[  305.025294] tsk->{mm,active_mm}->pgd = fff0000000db6000
[  305.093913]               \|/ ____ \|/
[  305.093913]               "@'/ .. \`@"
[  305.093913]               /_| \__/ |_\
[  305.093913]                  \__U_/
[  305.287234] stress-ng-opcod(1517): Oops [#1]
[  305.343363] CPU: 1 PID: 1517 Comm: stress-ng-opcod Not tainted 5.11.0-09786-g3b9cdafb535-dirty #294
[  305.462321] TSTATE: 0000004480001603 TPC: 000000000089ad98 TNPC: 000000000089ad9c Y: 00000000    Not tainted
[  305.591565] TPC: <__inet_lookup_established+0x78/0x1e0>
[  305.660186] g0: fff0000000a993c1 g1: 0000000000000000 g2: 2057cf51ce000000 g3: 000000000057cf51
[  305.774569] g4: fff0000000f152c0 g5: fff000133ee8c000 g6: fff000000107c000 g7: 5973ffef02e64d70
[  305.888946] o0: 00000000000065c8 o1: 30222850b2de49fe o2: 0000000000160000 o3: 6857e211521f25c5
[  306.003325] o4: 0000000340f12326 o5: 0000000000a8f400 sp: fff000133fe1ed81 ret_pc: 000000000089ad4c
[  306.122278] RPC: <__inet_lookup_established+0x2c/0x1e0>
[  306.190900] l0: 0000000000000002 l1: 0000000000000000 l2: fff00000006b2e40 l3: 0000000000010000
[  306.305281] l4: 0000000000000001 l5: fff0000000be8980 l6: fff0000000be8840 l7: fff0000000be8840
[  306.419659] i0: 0000000000b30640 i1: 00000000000065c8 i2: 00000000d98965c8 i3: 0000000000000000
[  306.534037] i4: c0a80101c0a8018e i5: 00000000e4230016 i6: fff000133fe1ee31 i7: 00000000008bee58
[  306.648415] I7: <tcp_v4_early_demux+0x98/0x160>
[  306.707887] Call Trace:
[  306.739910] [<00000000008bee58>] tcp_v4_early_demux+0x98/0x160
[  306.816544] [<000000000088f178>] ip_rcv_finish_core.isra.17+0x318/0x420
[  306.903472] [<000000000088f6cc>] ip_list_rcv_finish.isra.19+0x6c/0x140
[  306.989256] [<000000000088fc5c>] ip_list_rcv+0x11c/0x140
[  307.059025] [<0000000000834658>] __netif_receive_skb_list_core+0x138/0x240
[  307.149386] [<0000000000834970>] netif_receive_skb_list_internal+0x210/0x300
[  307.242031] [<0000000000834a68>] gro_normal_list.part.188+0x8/0x40
[  307.323239] [<0000000000835e8c>] napi_complete_done+0x14c/0x1e0
[  307.401015] [<000000001002fc80>] tg3_poll+0x140/0x460 [tg3]
[  307.474326] [<00000000008360a4>] __napi_poll+0x44/0x1a0
[  307.542948] [<00000000008363c4>] net_rx_action+0xc4/0x240
[  307.613861] [<000000000095e170>] __do_softirq+0xd0/0x260
[  307.683633] [<000000000042c86c>] do_softirq_own_stack+0x2c/0x40
[  307.761410] [<0000000000469fa8>] irq_exit+0xc8/0xe0
[  307.825461] [<000000000095de40>] handler_irq+0xc0/0x100
[  307.894087] [<00000000004208b4>] tl0_irq5+0x14/0x20
[  307.958140] Disabling lock debugging due to kernel taint
[  308.027910] Caller[00000000008bee58]: tcp_v4_early_demux+0x98/0x160
[  308.110263] Caller[000000000088f178]: ip_rcv_finish_core.isra.17+0x318/0x420
[  308.202910] Caller[000000000088f6cc]: ip_list_rcv_finish.isra.19+0x6c/0x140
[  308.294411] Caller[000000000088fc5c]: ip_list_rcv+0x11c/0x140
[  308.369898] Caller[0000000000834658]: __netif_receive_skb_list_core+0x138/0x240
[  308.465981] Caller[0000000000834970]: netif_receive_skb_list_internal+0x210/0x300
[  308.564346] Caller[0000000000834a68]: gro_normal_list.part.188+0x8/0x40
[  308.651270] Caller[0000000000835e8c]: napi_complete_done+0x14c/0x1e0
[  308.734766] Caller[000000001002fc80]: tg3_poll+0x140/0x460 [tg3]
[  308.813791] Caller[00000000008360a4]: __napi_poll+0x44/0x1a0
[  308.888134] Caller[00000000008363c4]: net_rx_action+0xc4/0x240
[  308.964769] Caller[000000000095e170]: __do_softirq+0xd0/0x260
[  309.040257] Caller[000000000042c86c]: do_softirq_own_stack+0x2c/0x40
[  309.123754] Caller[0000000000469fa8]: irq_exit+0xc8/0xe0
[  309.193523] Caller[000000000095de40]: handler_irq+0xc0/0x100
[  309.267869] Caller[00000000004208b4]: tl0_irq5+0x14/0x20
[  309.337640] Caller[000000000055e5d0]: __handle_mm_fault+0x190/0xaa0
[  309.419992] Caller[000000000055ef74]: handle_mm_fault+0x94/0x220
[  309.498913] Caller[0000000000451824]: do_sparc64_fault+0x264/0x6e0
[  309.580120] Caller[0000000000407714]: sparc64_realfault_common+0x10/0x20
[  309.668191] Caller[00000000f7b5f298]: 0xf7b5f298
[  309.728811] Instruction DUMP:
[  309.728815]  808ee001
[  309.767698]  32600043
[  309.798579]  b736f001
[  309.829461] <c206ffa0>
[  309.860342]  80a0401a
[  309.891225]  124ffffa
[  309.922107]  01000000
[  309.952988]  c206ffa4
[  309.983871]  80a74001
[  310.014753]
[  310.065080] Kernel panic - not syncing: Aiee, killing interrupt handler!
[  310.153153] ------------[ cut here ]------------
[  310.213767] WARNING: CPU: 1 PID: 1517 at kernel/smp.c:633 smp_call_function_many_cond+0x3bc/0x400
[  310.330439] Modules linked in: loop flash tg3
[  310.387621] CPU: 1 PID: 1517 Comm: stress-ng-opcod Tainted: G      D           5.11.0-09786-g3b9cdafb535-dirty #294
[  310.524881] Call Trace:
[  310.556899] [<0000000000463ea8>] __warn+0x88/0xe0
[  310.618665] [<0000000000463f58>] warn_slowpath_fmt+0x58/0x80
[  310.693010] [<00000000004ef8bc>] smp_call_function_many_cond+0x3bc/0x400
[  310.781083] [<00000000004efb7c>] smp_call_function+0x1c/0x40
[  310.855426] [<0000000000953e2c>] panic+0x11c/0x334
[  310.918333] [<0000000000468ebc>] do_exit+0x8bc/0xbc0
[  310.983529] [<000000000042a854>] die_if_kernel+0x194/0x300
[  311.055587] [<000000000095389c>] unhandled_fault+0x84/0x90
[  311.127646] [<0000000000451a2c>] do_sparc64_fault+0x46c/0x6e0
[  311.203135] [<0000000000407714>] sparc64_realfault_common+0x10/0x20
[  311.285488] [<000000000089ad98>] __inet_lookup_established+0x78/0x1e0
[  311.370127] [<00000000008bee58>] tcp_v4_early_demux+0x98/0x160
[  311.446760] [<000000000088f178>] ip_rcv_finish_core.isra.17+0x318/0x420
[  311.533687] [<000000000088f6cc>] ip_list_rcv_finish.isra.19+0x6c/0x140
[  311.619471] [<000000000088fc5c>] ip_list_rcv+0x11c/0x140
[  311.689241] [<0000000000834658>] __netif_receive_skb_list_core+0x138/0x240
[  311.779601] ---[ end trace bb4c0255fe0bffe8 ]---
[  311.840221] ------------[ cut here ]------------
[  311.900838] WARNING: CPU: 1 PID: 1517 at kernel/smp.c:498 smp_call_function_single+0x188/0x1c0
[  312.014078] Modules linked in: loop flash tg3
[  312.071261] CPU: 1 PID: 1517 Comm: stress-ng-opcod Tainted: G      D W         5.11.0-09786-g3b9cdafb535-dirty #294
[  312.208523] Call Trace:
[  312.240539] [<0000000000463ea8>] __warn+0x88/0xe0
[  312.302304] [<0000000000463f58>] warn_slowpath_fmt+0x58/0x80
[  312.376652] [<00000000004ef4c8>] smp_call_function_single+0x188/0x1c0
[  312.461291] [<00000000004efb7c>] smp_call_function+0x1c/0x40
[  312.535637] [<0000000000953e2c>] panic+0x11c/0x334
[  312.598543] [<0000000000468ebc>] do_exit+0x8bc/0xbc0
[  312.663739] [<000000000042a854>] die_if_kernel+0x194/0x300
[  312.735796] [<000000000095389c>] unhandled_fault+0x84/0x90
[  312.807856] [<0000000000451a2c>] do_sparc64_fault+0x46c/0x6e0
[  312.883344] [<0000000000407714>] sparc64_realfault_common+0x10/0x20
[  312.965698] [<000000000089ad98>] __inet_lookup_established+0x78/0x1e0
[  313.050337] [<00000000008bee58>] tcp_v4_early_demux+0x98/0x160
[  313.126970] [<000000000088f178>] ip_rcv_finish_core.isra.17+0x318/0x420
[  313.213897] [<000000000088f6cc>] ip_list_rcv_finish.isra.19+0x6c/0x140
[  313.299679] [<000000000088fc5c>] ip_list_rcv+0x11c/0x140
[  313.369450] [<0000000000834658>] __netif_receive_skb_list_core+0x138/0x240
[  313.459809] ---[ end trace bb4c0255fe0bffe9 ]---
[  313.520436] Press Stop-A (L1-A) from sun keyboard or send break
[  313.520436] twice on console to return to the boot prom
[  313.666839] ---[ end Kernel panic - not syncing: Aiee, killing interrupt handler! ]---


> Let me know what you find out from all this and I'll try to come up with more ideas.

OK, I can try more things. And thank you for quick response times!
