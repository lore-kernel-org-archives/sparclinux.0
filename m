From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Tue, 13 Apr 2010 22:05:43 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100413220542.GG5602@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Apr 13, 2010 at 02:56:38PM -0700, David Miller wrote:
> From: Frederic Weisbecker <fweisbec@gmail.com>
> Date: Tue, 13 Apr 2010 23:51:46 +0200
> 
> > More than that actually, I tried and it just crashed :-)
> 
> Strange, something to debug :-)  I'll try to take a look
> at what might cause this.


Here is another, again by enabling the tracer.
One problem with the function graph tracer is that it tends
to infect the backtraces, since it overrides return values.

We have hooks to bypass that in x86, IIRC.


[  126.704213] hrtimer: interrupt took 8360145 ns
[  127.898433] ------------[ cut here ]------------
[  127.900406] WARNING: at kernel/sched.c:3568 sub_preempt_count+0x98/0xb8()
[  127.902768] Modules linked in: loop usbhid ehci_hcd ohci_hcd e1000e sg sr_mod cdrom
[  127.908524] Call Trace:
[  127.909615] ---[ end trace a6e237ec24a26f8b ]---
[  127.911796] FAULT[bash:2183]: 32-bit process reports 64-bit fault address [1dc5d706cc]
[  127.914233] TSTATE: 0000004480001603 TPC: 0000001dc5d706cc TNPC: 0000000000404b40 Y: 0000001d    Tainted: G        
W 
[  127.918356] TPC: <0x1dc5d706cc>
[  127.920107] g0: 0000000000000000 g1: 000000000000ee30 g2: 0000000000000004 g3: 04a0000000000000
[  127.923431] g4: fffff803f233d5c0 g5: fffff80011244000 g6: fffff803f0e4c000 g7: 0000001dc5a27c8f
[  127.926759] o0: 000000000000000e o1: 000000000000001b o2: 0000000000200000 o3: 000000000020009e
[  127.930243] o4: 0000000000000000 o5: fffff803ff992fe8 sp: fffff803ff992761 ret_pc: 0000001dc5cf88b7
[  127.933926] RPC: <0x1dc5cf88b7>
[  127.935311] l0: 000000000049dd30 l1: fffff803ec4c9ae0 l2: fffff803f78edec0 l3: 000000000000000e
[  127.938713] l4: fffff800153c2c88 l5: fffffffffff00000 l6: 00000000f8000000 l7: 00000000000fffff
[  127.942043] i0: 000000000049dd38 i1: 0000000000461494 i2: fffff803ff992971 i3: fffffffffff00000
[  127.945419] i4: 0000000001492088 i5: fffff803ff993008 i6: fffff803ff992831 i7: 0000001dc5d75f38
[  127.948925] I7: <0x1dc5d75f38>
[  127.950669] FAULT[bash:2183]: 32-bit process reports 64-bit fault address [1dc5d70000]
[  127.953950] TSTATE: 0000004480001606 TPC: 000000000044e350 TNPC: 000000000044e400 Y: 00000000    Tainted: G        
W 
[  127.957602] TPC: <get_fault_insn+0x40/0xf8>
[  127.959187] g0: 000000000044e318 g1: 0000000000000400 g2: 00000000000012a8 g3: 0000001dc5d706cc
[  127.962599] g4: fffff803f233d5c0 g5: fffff80011244000 g6: fffff803f0e4c000 g7: 0000000000000002
[  127.965623] o0: 00000000008f0500 o1: fffff803f233da68 o2: 0000000000000887 o3: 0000001dc5d706cc
[  127.968722] o4: 0000000000000000 o5: fffff803ff992bc8 sp: fffff803ff9923e1 ret_pc: 000000000044e318
[  127.972222] RPC: <get_fault_insn+0x8/0xf8>
[  127.974159] l0: 0000000000407b08 l1: fffff803ff992601 l2: 0000000000404b3c l3: 0000000000000400
[  127.976987] l4: 0000000000000000 l5: 000000000000001d l6: 0000000000000000 l7: 0000000000000008
[  127.980147] i0: fffff803ff992ec0 i1: 0000000000000000 i2: 0000000000404b40 i3: 0000000000000000
[  127.982703] i4: 0000000000000000 i5: fffff803ff992d28 i6: fffff803ff9924a1 i7: 000000000044eccc
[  127.985441] I7: <do_sparc64_fault+0x670/0x6d0>
[  127.986733] kernel BUG at kernel/sched.c:1164!
[  127.989690] Unable to handle kernel paging request at virtual address 0000001dc5d70000
[  127.992283]               \|/ ____ \|/
[  127.994536]               "@'/ .. \`@"
[  127.996649]               /_| \__/ |_\
[  127.998611]                  \__U_/
[  128.000931] tsk->{mm,active_mm}->context = 0000000000000677
[  128.002756] swapper(0): Kernel bad sw trap 5 [#1]
[  128.005625] tsk->{mm,active_mm}->pgd = fffff803f0f34000
[  128.007538] TSTATE: 0000004480e01607 TPC: 000000000045c40c TNPC: 000000000045c410 Y: 00000000    Tainted: G        
W 
[  128.013332]               \|/ ____ \|/
[  128.014336]               "@'/ .. \`@"
[  128.015289]               /_| \__/ |_\
[  128.016379]                  \__U_/
[  128.018249] TPC: <resched_task+0x50/0xb4>
[  128.020817] bash(2183): Oops [#2]
[  128.021929] g0: 0000000000000000 g1: 000000000000000a g2: 00000000000012a8 g3: fffff803ec624aa0
[  128.027022] TSTATE: 0000004480001606 TPC: 000000000044e350 TNPC: 000000000044e400 Y: 00000000    Tainted: G        
W 
[  128.029768] g4: fffff803f7de4480 g5: fffff80014444000 g6: fffff803f7df0000 g7: 0000000000000001
[  128.035114] TPC: <get_fault_insn+0x40/0xf8>
[  128.036524] o0: 0000000000853cf8 o1: 000000000000048c o2: fffff803ff9a3171 o3: 0000000000000000
[  128.041318] g0: 000000000044e318 g1: 0000000000000400 g2: 00000000000012a8 g3: 0000001dc5d706cc
[  128.043706] o4: 0000000000000002 o5: 0000000000000001 sp: fffff803ff9a2ff1 ret_pc: 00000000005e32dc
[  128.048627] g4: fffff803f233d5c0 g5: fffff80011244000 g6: fffff803f0e4c000 g7: 0000000000000002
[  128.051391] RPC: <ftrace_graph_caller+0x10/0x18>
[  128.054114] o0: 00000000008f0500 o1: fffff803f233da68 o2: 0000000000000887 o3: 0000001dc5d706cc
[  128.056845] l0: 00000000004631c4 l1: fffff803ff9a3171 l2: ffffffffffffffff l3: fffff803ff9a39a0
[  128.061499] o4: 0000000000000000 o5: fffff803ff992bc8 sp: fffff803ff9923e1 ret_pc: 000000000044e318
[  128.064283] l4: fffff803f7de4480 l5: 0006000000000000 l6: 000000000000000e l7: 00000000008d0180
[  128.069543] RPC: <get_fault_insn+0x8/0xf8>
[  128.070915] i0: fffff803f233d5c0 i1: fffff803f7e297a0 i2: 0000000000000001 i3: 0000000000000000
[  128.076055] l0: 0000000000407b08 l1: fffff803ff992601 l2: 0000000000404b3c l3: 0000000000000400
[  128.079017] i4: 0000000000000002 i5: 0000000000b84340 i6: fffff803ff9a30b1 i7: 00000000005e32dc
[  128.083496] l4: 0000000000000000 l5: 000000000000001d l6: 0000000000000000 l7: 0000000000000008
[  128.085823] I7: <ftrace_graph_caller+0x10/0x18>
[  128.088213] i0: fffff803ff992ec0 i1: 0000000000000000 i2: 0000000000404b40 i3: 0000000000000000
[  128.090874] Caller[00000000005e32dc]: ftrace_graph_caller+0x10/0x18
[  128.094238] i4: 0000000000000000 i5: fffff803ff992d28 i6: fffff803ff9924a1 i7: 000000000044eccc
[  128.096690] Caller[00000000005e32dc]: ftrace_graph_caller+0x10/0x18
[  128.100142] I7: <do_sparc64_fault+0x670/0x6d0>
[  128.101565] Caller[00000000005e32dc]: ftrace_graph_caller+0x10/0x18
[  128.104808] Instruction DUMP:Caller[00000000005e32dc]: ftrace_graph_caller+0x10/0x18
[  128.108516]  22c84004 Caller[00000000005e32dc]: ftrace_graph_caller+0x10/0x18
[  128.111996]  c2592238 Caller[00000000005e32dc]: ftrace_graph_caller+0x10/0x18
[  128.115527]  1068002d Caller[00000000005e32dc]: ftrace_graph_caller+0x10/0x18
[  128.118550] <f200c000>Caller[00000000005e32dc]: ftrace_graph_caller+0x10/0x18
[  128.121330]  8530f022 Caller[00000000005e32dc]: ftrace_graph_caller+0x10/0x18
[  128.124087]  8408a7ff Caller[00000000005e32dc]: ftrace_graph_caller+0x10/0x18
[  128.126775]  c2586048 Caller[0000000000426b04]: valid_addr_bitmap_patch+0xbc/0x238
[  128.129547]  8528b002 Caller[0000000000461428]: finish_task_switch+0x28/0x8c
[  128.132215]  c4004002 Caller[00000000005e32dc]: ftrace_graph_caller+0x10/0x18
[  128.134553] 
[  128.135119] Caller[000000000042cae8]: cpu_idle+0x14c/0x164
[  128.137717] Caller[000000000075c318]: after_lock_tlb+0x1b4/0x1cc
[  128.140182] Caller[0000000000000000]: (null)
[  128.141819] Instruction DUMP: 9210248c  7fff372b  901220f8 <91d02005> c25a6008  82086008  0ac84014  92026008  
4006199a 
[  128.147653] Kernel panic - not syncing: Aiee, killing interrupt handler!
[  128.148442] Call Trace:
[  128.148795]  [00000000005e32dc] ftrace_graph_caller+0x10/0x18
[  128.149401]  [00000000005e32dc] ftrace_graph_caller+0x10/0x18
[  128.150005]  [00000000005e32dc] ftrace_graph_caller+0x10/0x18
[  128.150612]  [00000000005e32dc] ftrace_graph_caller+0x10/0x18
[  128.151217]  [00000000005e32dc] ftrace_graph_caller+0x10/0x18
[  128.151823]  [000000000045c40c] resched_task+0x50/0xb4
[  128.152394]  [00000000005e32dc] ftrace_graph_caller+0x10/0x18
[  128.153004]  [00000000005e32dc] ftrace_graph_caller+0x10/0x18
[  128.153613]  [00000000005e32dc] ftrace_graph_caller+0x10/0x18
[  128.154217]  [00000000005e32dc] ftrace_graph_caller+0x10/0x18
[  128.154822]  [00000000005e32dc] ftrace_graph_caller+0x10/0x18
[  128.155427]  [00000000005e32dc] ftrace_graph_caller+0x10/0x18
[  128.156032]  [00000000005e32dc] ftrace_graph_caller+0x10/0x18
[  128.156640]  [00000000005e32dc] ftrace_graph_caller+0x10/0x18
[  128.157245]  [00000000005e32dc] ftrace_graph_caller+0x10/0x18
[  128.157850]  [00000000005e32dc] ftrace_graph_caller+0x10/0x18
[  128.158693] Press Stop-A (L1-A) to return to the boot prom
[  128.160671] Unable to handle kernel NULL pointer dereference
[  128.161055] tsk->{mm,active_mm}->context = 0000000000000677
[  128.161606] tsk->{mm,active_mm}->pgd = fffff803f0f34000
[  128.162121]               \|/ ____ \|/
[  128.162427]               "@'/ .. \`@"
[  128.162730]               /_| \__/ |_\
[  128.163035]                  \__U_/
[  128.163421] bash(2183): Oops [#3]
[  128.163849] TSTATE: 0000004480001603 TPC: 0000000000473078 TNPC: 00000000004af184 Y: 00000000    Tainted: G      
D W 
[  128.164835] TPC: <do_exit+0x2bc/0x77c>
[  128.165245] g0: 0000000000000000 g1: 0000000000000000 g2: 00000000000012a8 g3: 00000000008ff7b8
[  128.166036] g4: fffff803f233d5c0 g5: fffff80011244000 g6: fffff803f0e4c000 g7: 0000000000000002
[  128.166829] o0: 0000000000000001 o1: fffff803f6ff7c04 o2: 0000000000000001 o3: 0000000000000000
[  128.167621] o4: 0000000000855960 o5: 0000000000000001 sp: fffff803ff991ea1 ret_pc: 0000000000473074
[  128.168483] RPC: <do_exit+0x2b8/0x77c>
[  128.168896] l0: fffff803ff992be0 l1: fffff803f233d5c0 l2: fffff803f233d5c0 l3: 0000004480001606
[  128.169687] l4: 0000000000000000 l5: 00000000008f2700 l6: 0000000000000001 l7: 000000003b9aca00
[  128.170482] i0: 0000000000000009 i1: 0000000000000020 i2: 00000000c4004002 i3: 0000000000000020
[  128.171281] i4: 00000000000000ff i5: 000000000000000b i6: fffff803ff991f71 i7: 00000000005e32dc
[  128.172114] I7: <ftrace_graph_caller+0x10/0x18>
[  128.172592] Instruction DUMP: a4100011  c2586030  4000f044 <d0586048> 4001abd1  90100011  8207a7df  90100011  
c277a7e7 
[  128.174516] Fixing recursive fault but reboot is needed!

