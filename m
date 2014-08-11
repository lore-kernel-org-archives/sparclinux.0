From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Mon, 11 Aug 2014 17:49:48 +0000
Subject: Re: [PATCH] Fix BREAK handling in sunsab serial driver
Message-Id: <201408111949.48828.cat.schulze@alice-dsl.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201407271519.22272.cat.schulze@alice-dsl.net>
In-Reply-To: <201407271519.22272.cat.schulze@alice-dsl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tuesday 05 August 2014 01:04:23 David Miller wrote:
> From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
> Date: Sun, 3 Aug 2014 14:25:35 +0200
> 
> > IIRC it was a null pointer dereference in perf_event_print_debug(),
> > but I am not quite sure, as we quickly disabled this call to continue
> > working (getting BREAK on the serial console to work was top priority
> > then). We will have to wait for Norman to retrieve this information -
> > he is currently on vacation, however, so it will take another week.
> 
> If it's in perf_event_print_debug() there isn't much to check.
> 
> sparc_pmu is derefernced in the loops, but the first thing this
> function does is check it against NULL and return immediately
> if it is NULL.
> 
> pcr_ops is dereferenced also, but pcr_ops should never be NULL
> if sparc_pmu is not NULL.
> 
> Hmmm... that's setup by pcr_arch_init() which I only see being
> invoked by smp_cpus_done().
> 
> Is this a uniprocessor build?
> 
> 

My colleague has returned from his vacation and provided me the serial
console logs which contain the stacktrace for the crash in
perf_event_print_debug() that was triggered by the register dump request
using SysRq:

[  192.934865] Unable to handle kernel NULL pointer dereference
[  193.002524] tsk->{mm,active_mm}->context = 0000000000001009
[  193.069192] tsk->{mm,active_mm}->pgd = fffffc003aec2000
[  193.131694]               \|/ ____ \|/
[  193.131694]               "@'/ .. \`@"
[  193.131694]               /_| \__/ |_\
[  193.131694]                  \__U_/
[  193.307769] swapper(0): Oops [#1]
[  193.347330] CPU: 0 PID: 0 Comm: swapper Not tainted 3.13.10 #4
[  193.417122] task: 000000000092d7e0 ti: 0000000000918000 task.ti: 0000000000918000
[  193.506717] TSTATE: 0000009980e01604 TPC: 000000000044d630 TNPC: 000000000044d634 Y: 00000000    Not tainted
[  193.624441] TPC: <perf_event_print_debug+0x50/0x100>
[  193.683796] g0: 0000000001016460 g1: 0000000000000000 g2: 0000000000000007 g3: 0000000000000001
[  193.787975] g4: 000000000092d7e0 g5: 0000000000000038 g6: 0000000000918000 g7: 0000000000000720
[  193.892144] o0: 0000000000000000 o1: 000000000089d910 o2: 0000000000000000 o3: 0000000000001fff
[  193.996313] o4: 000000000089d8a0 o5: 0000000000000010 sp: fffffc003febb231 ret_pc: 000000000044d610
[  194.104653] RPC: <perf_event_print_debug+0x30/0x100>
[  194.164018] l0: 0000000000001000 l1: 00000000ffff5511 l2: 00000000004208b0 l3: 0000000000000000
[  194.268197] l4: 0000000000001000 l5: 0000000000000004 l6: 0000000000918000 l7: 0000000080001004
[  194.372368] i0: 0000000000000070 i1: 00000000009cd800 i2: 000000000089d300 i3: 00000000009240d0
[  194.476537] i4: 000000000000000e i5: 0000000000000001 i6: fffffc003febb2f1 i7: 000000000068b2a0
[  194.580715] I7: <__handle_sysrq+0xc0/0x1a0>
[  194.630694] Call Trace:
[  194.659865]  [000000000068b2a0] __handle_sysrq+0xc0/0x1a0
[  194.724458]  [00000000006a5908] sunsab_interrupt+0x468/0x8a0
[  194.792165]  [0000000000498d18] handle_irq_event_percpu+0x78/0x220
[  194.866125]  [0000000000498ee8] handle_irq_event+0x28/0x60
[  194.931754]  [000000000049b7dc] handle_fasteoi_irq+0xfc/0x1a0
[  195.000503]  [0000000000498560] generic_handle_irq+0x40/0x60
[  195.068214]  [000000000042b5d4] handler_irq+0x94/0xc0
[  195.128636]  [00000000004208b4] tl0_irq5+0x14/0x20
[  195.185924]  [000000000042bbfc] arch_cpu_idle+0x5c/0x80
[  195.248426]  [000000000049843c] cpu_startup_entry+0x19c/0x240
[  195.317179]  [000000000099a988] start_kernel+0x4f0/0x520
[  195.380724]  [00000000007e74ac] tlb_fixup_done+0x80/0x94
[  195.444263]  [0000000000000000]           (null)
[  195.499473] Disabling lock debugging due to kernel taint
[  195.563022] Caller[000000000068b2a0]: __handle_sysrq+0xc0/0x1a0
[  195.633855] Caller[00000000006a5908]: sunsab_interrupt+0x468/0x8a0
[  195.707816] Caller[0000000000498d18]: handle_irq_event_percpu+0x78/0x220
[  195.788028] Caller[0000000000498ee8]: handle_irq_event+0x28/0x60
[  195.859905] Caller[000000000049b7dc]: handle_fasteoi_irq+0xfc/0x1a0
[  195.934905] Caller[0000000000498560]: generic_handle_irq+0x40/0x60
[  196.008866] Caller[000000000042b5d4]: handler_irq+0x94/0xc0
[  196.075534] Caller[00000000004208b4]: tl0_irq5+0x14/0x20
[  196.139079] Caller[000000000042bbb8]: arch_cpu_idle+0x18/0x80
[  196.207831] Caller[000000000049843c]: cpu_startup_entry+0x19c/0x240
[  196.282833] Caller[000000000099a988]: start_kernel+0x4f0/0x520
[  196.352626] Caller[00000000007e74ac]: tlb_fixup_done+0x80/0x94
[  196.422418] Caller[0000000000000000]:           (null)
[  196.483877] Instruction DUMP: 953f6000  ba076001  9010000a <c2584000> 9fc04000  d477a7f7  d45fa7f7  96100008  92102000 
[  196.613045] Kernel panic - not syncing: Aiee, killing interrupt handler!
[  196.693264] Press Stop-A (L1-A) to return to the boot prom

Unfortunately, this is less information than I hoped: the only new information is

[  193.624441] TPC: <perf_event_print_debug+0x50/0x100>
[  194.104653] RPC: <perf_event_print_debug+0x30/0x100>

and I am not able to provide any further details (e.g., disassembly of the code
at that location).

The machine is a uniprocessor system. The kernel configuration was taken from
Debian and slightly modified, but I am not sure whether it was based on an SMP
kernel package or not (I would guess that it was a uniprocessor kernel, however).

I hope this can provide at least some further information to you.

Regards,
Alexander Schulze
