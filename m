From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 02 Jun 2017 09:17:18 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <20170602091717.GA7452@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20170531193431.GA26922@waldemar-brodkorb.de>
 <20170531.171008.528800003662477033.davem@davemloft.net>
In-Reply-To: <20170531.171008.528800003662477033.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: wbx@openadk.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Wed, May 31, 2017 at 05:10:08PM -0400, David Miller wrote:
> A fix for this is in Linus's tree and was submitted to -stable last
> night:

What remains to be fixed though is that the gcc-7 testsuite
*reproducibly* kills the kernel on sparc64 when building with more than
around 20 jobs:

[617633.376777] fib.exe[242839]: segfault at fff8000100045a20 ip fff800010095c180 (rpc fff800010095cfb4) sp fff8000100045b10 error 30002 in libc-2.24.so[fff80001008dc000+15e000]
[617635.588137] Kernel unaligned access at TPC[4a3c4c] idle_cpu+0x2c/0x60
[617635.588202] Unable to handle kernel paging request in mna handler
[617635.588209]  at virtual address 8000000000db742f
[617635.588227] Kernel unaligned access at TPC[4a3c4c] idle_cpu+0x2c/0x60
[617635.588235] Unable to handle kernel paging request in mna handler
[617635.588240]  at virtual address 8000000000db742f
[617635.588244] current->{active_,}mm->context = 0000000000000f52
[617635.588248] current->{active_,}mm->pgd = fff80004b8072000
[617635.588253]               \|/ ____ \|/
[617635.588253]               "@'/ .. \`@"
[617635.588253]               /_| \__/ |_\
[617635.588253]                  \__U_/
[617635.588258] cilk_for_ptr_it(243636): Oops [#1]
[617635.588270] CPU: 0 PID: 243636 Comm: cilk_for_ptr_it Tainted: G           O    4.12.0-rc3-00011-gf511c0b17b08-dirty #331
[617635.588276] task: fff80005047dc8e0 task.stack: fff80006c807c000
[617635.588284] TSTATE: 0000000011e01603 TPC: 00000000004a3c4c TNPC: 00000000004a3c50 Y: 00000000    Tainted: G           O   
[617635.588290] TPC: <idle_cpu+0x2c/0x60>
[617635.588296] g0: 0000000000000000 g1: 8000000000db6abf g2: 7fffffffffffffff g3: fff80004b82c9480
[617635.588302] g4: fff80005047dc8e0 g5: fff80040bc256000 g6: fff80006c807c000 g7: 0000000000000010
[617635.588307] o0: 0000000000000016 o1: 0000000000000100 o2: 0000000000000000 o3: 0000000000000000
[617635.588312] o4: 0000000000000000 o5: 0000000000000001 sp: fff80006c807f001 ret_pc: 00000000007df7b0
[617635.588328] RPC: <find_next_bit+0x10/0x20>
[617635.588334] l0: 0000000000ca7800 l1: 0000000000c609b8 l2: 000000000000000e l3: 00000000004aca78
[617635.588340] l4: fff8000170000078 l5: 0000000000000110 l6: fff8000170000020 l7: fff80001008d4000
[617635.588346] i0: 0000000000000000 i1: 0000000000000100 i2: 0000000000000017 i3: 0000000000000100
[617635.588353] i4: 0000000000000e84 i5: fff800409ed96ac0 i6: fff80006c807f0b1 i7: 00000000004ad114
[617635.588366] I7: <select_task_rq_fair+0x7f4/0x1160>
[617635.588369] Call Trace:
[617635.588378]  [00000000004ad114] select_task_rq_fair+0x7f4/0x1160
[617635.588396]  [00000000004a14ac] try_to_wake_up+0x34c/0x7e0
[617635.588403]  [00000000004a19d0] wake_up_q+0x50/0xa0
[617635.588419]  [0000000000511808] futex_wake+0x128/0x160
[617635.588427]  [0000000000513160] do_futex+0x100/0xa80
[617635.588434]  [0000000000513bec] SyS_futex+0x10c/0x180
[617635.588447]  [0000000000406234] linux_sparc_syscall+0x34/0x44
[617635.588461] Caller[00000000004ad114]: select_task_rq_fair+0x7f4/0x1160
[617635.588470] Caller[00000000004a14ac]: try_to_wake_up+0x34c/0x7e0
[617635.588478] Caller[00000000004a19d0]: wake_up_q+0x50/0xa0
[617635.588485] Caller[0000000000511808]: futex_wake+0x128/0x160
[617635.588492] Caller[0000000000513160]: do_futex+0x100/0xa80
[617635.588501] Caller[0000000000513bec]: SyS_futex+0x10c/0x180
[617635.588508] Caller[0000000000406234]: linux_sparc_syscall+0x34/0x44
[617635.588515] Caller[fff80001007cd5b0]: 0xfff80001007cd5b0
[617635.588518] Instruction DUMP:
[617635.588522]  821062c0 
[617635.588526]  b0102000 
[617635.588529]  82004002 
[617635.588534] <c6586970>
[617635.588537]  c4586978 
[617635.588540]  80a0c002 
[617635.588545]  12680008 
[617635.588548]  01000000 
[617635.588552]  c4006038 
[617635.588555] 
[617635.588561] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:33
[617635.588566] in_atomic(): 1, irqs_disabled(): 1, pid: 243636, name: cilk_for_ptr_it
[617635.588570] INFO: lockdep is turned off.
[617635.588575] irq event stamp: 0
[617635.588580] hardirqs last  enabled at (0): [<          (null)>]           (null)
[617635.588599] hardirqs last disabled at (0): [<00000000004689d0>] copy_process.isra.1+0x450/0x19e0
[617635.588608] softirqs last  enabled at (0): [<00000000004689d0>] copy_process.isra.1+0x450/0x19e0
[617635.588612] softirqs last disabled at (0): [<          (null)>]           (null)
[617635.588620] CPU: 0 PID: 243636 Comm: cilk_for_ptr_it Tainted: G      D    O    4.12.0-rc3-00011-gf511c0b17b08-dirty #331
[617635.588623] Call Trace:
[617635.588632]  [000000000049cf5c] ___might_sleep+0x21c/0x240
[617635.588640]  [000000000049cfe8] __might_sleep+0x68/0xa0
[617635.588651]  [0000000000480098] exit_signals+0x18/0x280
[617635.588658]  [00000000004716ec] do_exit+0x10c/0xcc0
[617635.588667]  [000000000042a298] die_if_kernel+0x298/0x320
[617635.588676]  [0000000000433f44] kernel_mna_trap_fault+0xe4/0x120
[617635.588682]  [00000000004341ac] kernel_unaligned_trap+0x20c/0x520
[617635.588689]  [000000000042b234] sun4v_do_mna+0x54/0xa0
[617635.588698]  [0000000000406d10] sun4v_mna+0x5c/0x6c
[617635.588704]  [00000000004a3c4c] idle_cpu+0x2c/0x60
[617635.588711]  [00000000004ad114] select_task_rq_fair+0x7f4/0x1160
[617635.588719]  [00000000004a14ac] try_to_wake_up+0x34c/0x7e0

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
