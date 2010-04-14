From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Wed, 14 Apr 2010 15:48:04 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100414154802.GF5142@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Apr 13, 2010 at 06:59:31PM -0700, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Tue, 13 Apr 2010 16:56:39 -0700 (PDT)
> 
> > I'll dig further.
> 
> Ok Frederic, I think I figured it out.  We only save 128 bytes
> of stack space in the mcount stubs, but that's not enough.
> 
> 128 bytes is enough for the register window, but any function we call
> is allowed to save the first six incoming arguments to pre-assigned
> stack frame slots.
> 
> That means we have to allocate, at a minimum, 176 bytes of stack space
> if we call any C functions.  (176 = 128 + (8 * 6))
> 
> These arg save stores only happen in functions where there is a
> bit of register pressure, that's why we only sometimes see this.
> 
> The net result is that when we hit this, the parent's stack frame gets
> writtenw ith garbage.  And that's why the crashes look so random.
> 
> I'll commit this to sparc-2.6 and push it out to Linus.  I'm beating
> up a machine pretty hard with various tracers enabled and I haven't
> see any suspicious symptoms yet :-)
> 
> --------------------
> sparc64: Allocate sufficient stack space in ftrace stubs.
> 
> 128 bytes is sufficient for the register window save area, but the
> calling conventions allow the callee to save up to 6 incoming argument
> registers into the stack frame after the register window save area.
> 
> This means a minimal stack frame is 176 bytes (128 + (6 * 8)).
> 
> This fixes random crashes when using the function tracer.
> 
> Reported-by: Frederic Weisbecker <fweisbec@gmail.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>


Ok, I've applied the two patches and it fixes the problems
partially.

The crashes happen less likely as run into a manual
loop of

	echo function_graph > current_tracer
	echo nop > current_tracer

But after some trials:

[  711.854617] hrtimer: interrupt took 8050861 ns
[  746.124873] ------------[ cut here ]------------
[  746.410622] WARNING: at kernel/sched.c:3568 ftrace_graph_caller+0x10/0x18()
[  746.697698] Modules linked in: loop usbhid ehci_hcd ohci_hcd e1000e sg sr_mod cdrom
[  747.034140] Call Trace:
[  747.036503]  [00000000005e331c] ftrace_graph_caller+0x10/0x18
[  747.040395]  [00000000005e331c] ftrace_graph_caller+0x10/0x18
[  747.044273] ---[ end trace 5213554e436b8b78 ]---
[  747.059057] Unable to handle kernel NULL pointer dereference
[  747.062799] tsk->{mm,active_mm}->context = 0000000000000661


Or another kind:

(note the hrtimer warnings are normals. This is a hanging prevention
that has been added because of the function graph tracer first but
eventually serves as a general protection for hrtimer. It's about
similar to the balancing problem scheme: the time to service timers
is so slow that timers re-expire before we exit the servicing loop,
so we risk an endless loop).


[  100.159892] hrtimer: interrupt took 8747191 ns
[  128.534074] huh, entered softirq 1 TIMER 000000000047ed70 preempt_count 00000103, exited with 00000100?
[  129.128339] ------------[ cut here ]------------
[  129.450705] Unable to handle kernel NULL pointer dereference
[  129.599834] tsk->{mm,active_mm}->context = 000000000000067b
[  129.741548] tsk->{mm,active_mm}->pgd = fffff803f0fac000
[  129.880609]               \|/ ____ \|/
[  129.881840]               "@'/ .. \`@"
[  129.883098]               /_| \__/ |_\
[  129.884410]                  \__U_/
[  130.433709] ksoftirqd/35(109): Oops [#1]
[  130.568083] TSTATE: 0000000080e01607 TPC: 0000000000476570 TNPC: 0000000000476574 Y: 00000000    Not tainted
[  130.846883] TPC: <irq_exit+0xd4/0xdc>
[  130.980036] g0: 000000000049c19c g1: 0000000000000000 g2: 00000000000012a8 g3: 00000000008ff7b8
[  131.250929] g4: fffff803f7fad900 g5: fffff80011244000 g6: fffff803f7fd4000 g7: 0000000000000002
[  131.543092] o0: 0000000000000001 o1: 0000000000000000 o2: 0000000000000001 o3: fffff803ff9533e8
l NULL pointer dereference
[  132.598525] tsk->{mm,active_mm}->context = 0000000000000513
[  132.598549] tsk->{mm,active_mm}->pgd = fffff803f0ba8000
[  132.598573]               \|/ ____ \|/
[  132.598585]               "@'/ .. \`@"
[  132.598597]               /_| \__/ |_\
[  132.598611]                  \__U_/
[  132.598637] events/0(195): Oops [#3]
[  132.598683] TSTATE: 0000004480e01606 TPC: 0000000000466424 TNPC: 0000000000466428 Y: 00000000    Tainted: G      
D   
[  132.598772] TPC: <set_next_entity+0x10/0xa8>
[  132.598798] g0: 00000000008e7aa0 g1: 0000000000000001 g2: 00000000000012a8 g3: 00000000008ff7b8
[  132.598832] g4: 00000000008e7aa0 g5: fffff80011244000 g6: 00000000008cc000 g7: 0000000000000002
[  132.598861] o0: 00000000008f0d50 o1: 0000000000466520 o2: 00000000008cf401 o3: 0000000000000000
[  132.598890] o4: fffff803f6d60000 o5: 0000000000000000 sp: 00000000008cf281 ret_pc: 000000000046641c
[  132.598927] RPC: <set_next_entity+0x8/0xa8>
[  132.598948] l0: 00000000007602d0 l1: 00000000008cf401 l2: ffffffffffffffff l3: 0000000000000400
[  132.598977] l4: 00000000008e7aa0 l5: 0006000000000000 l6: 000000000000000e l7: 0000000000000008
[  132.599005] i0: fffff80011dc5d18 i1: 0000000000000000 i2: 0000000000000001 i3: 0000000000000000
[  132.599033] i4: 0000000000000002 i5: 0000000000000000 i6: 00000000008cf341 i7: 00000000004665d8
[  132.599067] I7: <pick_next_task_fair+0xc8/0xe8>
[  132.599084] Instruction DUMP: 110023c3  4005f3ad  90122150 <c2066038> 80a06000  02480011  84063f68  90100018  
7fffffa6 
[  132.599160] note: events/0[195] exited with preempt_count 2
[  131.546191] o4: 0000000000855960 o5: 0000000000000001 sp: fffff803ff952aa1 ret_pc: 0000000000476568
[  131.549532] RPC: <irq_exit+0xcc/0xdc>
[  131.551039] l0: 000000000000804e l1: 0000000000bf3d10 l2: 0000000000bf3d20 l3: 00000000008d0180
[  131.554218] l4: 000000000076457c l5: fffff800163c2c88 l6: 0000000000000001 l7: fffff803eccaa038
[  131.557243] i0: 0000000000000000 i1: 0000001616202980 i2: fffff803ff952b81 i3: 00000000005e3328
[  131.560247] i4: 0000000000000001 i5: fffff800163c2c88 i6: 0000000000000001 i7: fffff803eccaa038
[  131.564010] I7: <0xfffff803eccaa038>
[  131.565656] Instruction DUMP: 90102000  7fffabd9  90102001 <81cfe008> 01000000  9de3bf40  110023cd  4005b354  
901220c0 
[  131.575366] Unable to handle kernel NULL pointer dereference
[  131.577418] tsk->{mm,active_mm}->context = 000000000000067b
[  131.579556] tsk->{mm,active_mm}->pgd = fffff803f0fac000
[  131.581611]               \|/ ____ \|/
[  131.582683]               "@'/ .. \`@"
[  131.583668]               /_| \__/ |_\
[  131.584740]                  \__U_/
[  131.586339] ksoftirqd/35(109): Oops [#2]
[  131.588374] TSTATE: 0000004480e01604 TPC: 00000000004730b8 TNPC: 00000000004af1c4 Y: 00000000    Tainted: G      
D   
[  131.591849] TPC: <do_exit+0x2bc/0x77c>
[  131.593318] g0: 0000000000000000 g1: 0000000000000000 g2: 00000000000012a8 g3: 0000000000000015
[  131.596339] g4: fffff803f7fad900 g5: fffff80011244000 g6: fffff803f7fd4000 g7: 0000000000000002
[  131.599249] o0: 0000000000000001 o1: fffff803f7f52624 o2: 0000000000000001 o3: 0000000000000000
[  131.602059] o4: 0000000000855960 o5: 0000000000000001 sp: fffff803ff952561 ret_pc: 00000000004730b4
[  131.605016] RPC: <do_exit+0x2b8/0x77c>
[  131.606452] l0: fffff803ff9532a0 l1: fffff803f7fad900 l2: fffff803f7fad900 l3: 0000000080e01607
[  131.609228] l4: 0000000000000000 l5: 00000000008f2700 l6: 0000000000000001 l7: 000000003b9aca00
[  131.612125] i0: 0000000000000009 i1: 0000000000000020 i2: 00000000901220c0 i3: 0000000000000020
[  131.615054] i4: 00000000000000ff i5: 000000000000000b i6: fffff803ff952631 i7: 00000000005e331c
[  131.618120] I7: <ftrace_graph_caller+0x10/0x18>
[  131.619877] Instruction DUMP: a4100011  c2586030  4000f044 <d0586048> 4001abd1  90100011  8207a7df  90100011  
c277a7e7 
[  131.627682] Fixing recursive fault but reboot is needed!
[  132.598442] ------------[ cut hrnel NULL
p<4>>[  1 32329.48944] Unabointer de efehraenndclee <1>[  132.598499] kerne[  132.890947] WARNING: at 
kernel/trace/trace_functions_graph.c:144 ftrace_return_to_handler+0x94/0x128()
[  132.911378] Bad frame pointer: expected 8cefc1, received fffff803f6d630a1
[  132.911389]   from func get_fault_insn return to 44ed0c
[  132.925314] Modules linked in: loop usbhid ehci_hcd ohci_hcd e1000e sg sr_mod cdrom
[  132.939710] Call Trace:
[  132.946238]  [000000000046ece0] warn_slowpath_common+0x50/0x84
[  132.952799]  [000000000046ed74] warn_slowpath_fmt+0x34/0x44
[  132.959135]  [00000000004d03cc] ftrace_return_to_handler+0x94/0x128
[  132.965529]  [00000000005e3328] return_to_handler+0x4/0x1c
[  132.971834]  [00000000005e331c] ftrace_graph_caller+0x10/0x18
[  132.977974]  [00000000005e331c] ftrace_graph_caller+0x10/0x18
[  132.983840]  [000000000046427c] load_balance+0xcb8/0x111c
[  132.989524]  [00000000005e331c] ftrace_graph_caller+0x10/0x18
[  132.995075]  [0000000000489ab4] worker_thread+0x90/0x358
[  133.000470]  [000000000048e974] kthread+0x64/0x78
[  133.005645]  [000000000042ba68] kernel_thread+0x3c/0x54
[  133.010717]  [000000000048ea4c] kthreadd+0xc4/0x118
[  133.015704] ---[ end trace 04c19b1c514a2c20 ]---
[  133.020612] Kernel panic - not syncing: 
                                           [  133.025362] Call Trace:
[  133.029992]  [000000000075f9a0] panic+0x64/0x130
[  133.034638]  [00000000005e331c] ftrace_graph_caller+0x10/0x18
[  133.039272]  [000000000046427c] load_balance+0xcb8/0x111c
[  133.043798]  [00000000005e331c] ftrace_graph_caller+0x10/0x18
[  133.048261]  [0000000000489ab4] worker_thread+0x90/0x358
[  133.052606]  [000000000048e974] kthread+0x64/0x78
[  133.056797]  [000000000042ba68] kernel_thread+0x3c/0x54
[  133.060914]  [000000000048ea4c] kthreadd+0xc4/0x118


