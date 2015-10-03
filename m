From: Meelis Roos <mroos@linux.ee>
Date: Sat, 03 Oct 2015 19:33:30 +0000
Subject: Re: blk_mq_register_disk: kobject (00000000009f2dd8): tried to init an initialized object, something
Message-Id: <alpine.LRH.2.20.1510032231300.12322@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1509141548050.31198@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1509141548050.31198@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel list <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

> This is 4.3.0-rc1 on Sun E220R (dual-CPU sparc64). Sometimes it boots, 
> sometimes it fails to boot with looping errors and finally a watchdog 
> timeout. This console log from a failure. Config is below.

I noticed blk-mq related changes in todays git. Retested, loop_init 
still causes the same blk-mq problem.

[...]
> [....] Cleaning up temporary files... /tmp[ ok .
> [  106.370834] kobject (00000000009f2dd8): tried to init an initialized object, something is seriously wrong.
> [  106.485668] CPU: 2 PID: 1155 Comm: modprobe Not tainted 4.3.0-rc1 #65
> [  106.562646] Call Trace:
> [  106.591812]  [0000000000654560] kobject_init+0x80/0xa0
> [  106.653285]  [0000000000640cc0] blk_mq_register_disk+0xa0/0x180
> [  106.724089]  [0000000000636550] blk_register_queue+0x70/0x120
> [  106.792840]  [0000000000643b5c] add_disk+0x19c/0x460
> [  106.852197]  [0000000010033800] loop_add+0x1a0/0x240 [loop]
> [  106.918853]  [000000001003a168] loop_init+0x168/0x1b0 [loop]
> [  106.986531]  [0000000000426c00] do_one_initcall+0x80/0x1c0
> [  107.052155]  [00000000004de3c4] do_init_module+0x48/0x1e4
> [  107.116740]  [00000000004c7654] load_module+0xf14/0x11e0
> [  107.180265]  [00000000004c7ab4] SyS_finit_module+0x74/0xa0
> [  107.245874]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
> [  107.317210] Unable to handle kernel paging request at virtual address 000000018f090000
> [  107.411482] tsk->{mm,active_mm}->context = 00000000000003c4
> [  107.478123] tsk->{mm,active_mm}->pgd = fffff800ada70000
> [  107.540600]               \|/ ____ \|/
> [  107.540600]               "@'/ .. \`@"
> [  107.540600]               /_| \__/ |_\
> [  107.540600]                  \__U_/
> [  107.716705] modprobe(1155): Oops [#1]
> [  107.760362] CPU: 2 PID: 1155 Comm: modprobe Not tainted 4.3.0-rc1 #65
> [  107.837442] task: fffff800af25ba80 ti: fffff800adcec000 task.ti: fffff800adcec000
> [  107.927040] TSTATE: 0000004411001607 TPC: 0000000000481384 TNPC: 0000000000481388 Y: 00000000    Not tainted
> [  108.044741] TPC: <wake_up_process+0x4/0x40>
> [  108.094698] g0: 0000000000908ad2 g1: 0000000000000000 g2: 0000000000000000 g3: 00000000009f2c00
> [  108.198866] g4: fffff800af25ba80 g5: fffff800af01a000 g6: fffff800adcec000 g7: fffff800ad373f68
> [  108.303025] o0: 0000000000919000 o1: 0000000000000040 o2: 0000000000919000 o3: 00000000000000d0
> [  108.407184] o4: 000000000097ea00 o5: 0000000000000040 sp: fffff800adceecd1 ret_pc: 00000000005288a8
> [  108.515510] RPC: <kmem_cache_alloc+0xe8/0x180>
> [  108.568576] l0: fffff800af3a6db8 l1: 000000000000343c l2: fffff800af3a6db8 l3: 0000000000000001
> [  108.672759] l4: 000000000000016e l5: 0000000000000001 l6: 0000000000003000 l7: 0000000000000002
> [  108.776902] i0: 000000018f090680 i1: 000000000097ea00 i2: 000000000097ea00 i3: 0000000000479530
> [  108.881062] i4: 000000000096d800 i5: fffff800af005bc0 i6: fffff800adceed81 i7: 000000000047958c
> [  108.985223] I7: <kthread_create_on_node+0x8c/0x140>
> [  109.043505] Call Trace:
> [  109.072666]  [000000000047958c] kthread_create_on_node+0x8c/0x140
> [  109.145580]  [0000000000476874] __alloc_workqueue_key+0x274/0x460
> [  109.218497]  [000000000062d68c] __bioset_create+0x20c/0x2a0
> [  109.285154]  [0000000000631830] blk_alloc_queue_node+0x50/0x1e0
> [  109.355987]  [000000000063e54c] blk_mq_init_queue+0xc/0x60
> [  109.421594]  [0000000010033710] loop_add+0xb0/0x240 [loop]
> [  109.487212]  [000000001003a168] loop_init+0x168/0x1b0 [loop]
> [  109.554889]  [0000000000426c00] do_one_initcall+0x80/0x1c0
> [  109.620516]  [00000000004de3c4] do_init_module+0x48/0x1e4
> [  109.685081]  [00000000004c7654] load_module+0xf14/0x11e0
> [  109.748623]  [00000000004c7ab4] SyS_finit_module+0x74/0xa0
> [  109.814238]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
> [  109.885052] Disabling lock debugging due to kernel taint
> [  109.948585] Caller[000000000047958c]: kthread_create_on_node+0x8c/0x140
> [  110.027749] Caller[0000000000476874]: __alloc_workqueue_key+0x274/0x460
> [  110.106902] Caller[000000000062d68c]: __bioset_create+0x20c/0x2a0
> [  110.179816] Caller[0000000000631830]: blk_alloc_queue_node+0x50/0x1e0
> [  110.256877] Caller[000000000063e54c]: blk_mq_init_queue+0xc/0x60
> [  110.328760] Caller[0000000010033710]: loop_add+0xb0/0x240 [loop]
> [  110.400607] Caller[000000001003a168]: loop_init+0x168/0x1b0 [loop]
> [  110.474553] Caller[0000000000426c00]: do_one_initcall+0x80/0x1c0
> [  110.546406] Caller[00000000004de3c4]: do_init_module+0x48/0x1e4
> [  110.617242] Caller[00000000004c7654]: load_module+0xf14/0x11e0
> [  110.687015] Caller[00000000004c7ab4]: SyS_finit_module+0x74/0xa0
> [  110.758889] Caller[00000000004061d4]: linux_sparc_syscall32+0x34/0x60
> [  110.835949] Caller[0000000070015738]: 0x70015738
> [  110.891141] Instruction DUMP: 01000000  01000000  9de3bf50 <c25e0000> 8208600c  0ac04005  11002409  b2102003  106fff12 
> 

-- 
Meelis Roos (mroos@linux.ee)
