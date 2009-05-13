From: Denys Fedoryschenko <denys@visp.net.lb>
Date: Wed, 13 May 2009 00:00:11 +0000
Subject: Sun fire T2000,BUG: NMI Watchdog detected LOCKUP on CPU12
Message-Id: <200905130300.12084.denys@visp.net.lb>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi

Got recently lockups on T2000 machine. Machine is relatively new.
While compiling with crazy makeflags "-j17" getting such messages.
Process which was being compiled stuck, and i cannot terminate it.

Please CC me on reply.
Do i need to submit bugzilla message?

Full dmesg: http://www.nuclearcat.com/files/t2000-dmesg-1.txt
Kernel config: http://www.nuclearcat.com/files/t2000-config-1.txt

Here it relevant part (unwrapped available in dmesg):
[110645.897910] BUG: NMI Watchdog detected LOCKUP on CPU12, ip 0046630c, 
registers:
[110645.898120] TSTATE: 0000004480e01607 TPC: 000000000046630c TNPC: 
0000000000466310 Y: 00000000    Not tainted
[110645.898280] TPC: <run_timer_softirq+0x1a4/0x1d0>
[110645.898379] g0: 000000000000000c g1: fffff801ffc2fe60 g2: fffff801fc684138 
g3: fffff801ffc2fe60
[110645.898611] g4: fffff801fc662e00 g5: fffff801ff494000 g6: fffff801fc6a0000 
g7: fffff801fc684138
[110645.898697] o0: 0000000000000003 o1: fffff801ffc2fd90 o2: 0000000104514312 
o3: 0000000000000100
[110645.898783] o4: 0000000000000080 o5: fffff801ffc2fe60 sp: fffff801ffc2f5b1 
ret_pc: 00000000004661c0
[110645.898971] RPC: <run_timer_softirq+0x58/0x1d0>
[110645.899163] l0: fffff801fc684000 l1: 0000000000000012 l2: 000000000046d358 
l3: 000000000000000a
[110645.899249] l4: 000000000000000c l5: 0000000000000000 l6: fffff801fc6a0000 
l7: 0000000080001002
[110645.899480] i0: 000000000082d5c8 i1: fffff801ffd02010 i2: 0000000000000100 
i3: 00000000f025c8a0
[110645.899575] i4: 00000000fef42760 i5: 00000000fef417f8 i6: fffff801ffc2f681 
i7: 0000000000461ca4
[110645.899762] I7: <__do_softirq+0x4c/0x110>
[110645.899902] Call Trace:
[110645.900001]  [00000000004209f4] tl0_irq15+0x14/0x20
[110645.900113]  [000000000046630c] run_timer_softirq+0x1a4/0x1d0
[110645.900324]  [0000000000461ca4] __do_softirq+0x4c/0x110
[110645.900396]  [000000000042a750] do_softirq+0x60/0x8c
[110645.900505]  [00000000004617c0] irq_exit+0x3c/0x94
[110645.900610]  [000000000042e694] timer_interrupt+0xa0/0xbc
[110645.900820]  [00000000004209d4] tl0_irq14+0x14/0x20
[110645.900883]  [000000000042bc5c] cpu_idle+0xb0/0x148
[110645.901050]  [00000000006face0] after_lock_tlb+0x1b4/0x1cc
[110645.901256]  [0000000000000000] (null)
[111203.146591] INFO: task emerge:9830 blocked for more than 480 seconds.
[111203.146775] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[111203.146906] emerge        D 00000000006fdaf0     0  9830   9806
[111203.147132] Call Trace:
[111203.147279]  [00000000006fe7c0] schedule_timeout+0x18/0xa4
[111203.147390]  [00000000006fdaf0] wait_for_common+0xbc/0x148
[111203.147486]  [000000000046cd58] flush_cpu_workqueue+0x74/0x88
[111203.147672]  [000000000046cde0] flush_workqueue+0x34/0x60
[111203.147912]  [00000000005988a0] tty_ldisc_release+0x30/0x1e0
[111203.147978]  [0000000000592efc] tty_release_dev+0x400/0x430
[111203.148138]  [0000000000592f38] tty_release+0xc/0x24
[111203.148372]  [00000000004c4dd8] __fput+0xdc/0x1a4
[111203.148430]  [00000000004c2694] filp_close+0x68/0x7c
[111203.148620]  [00000000004c2718] SyS_close+0x70/0xb4
[111203.148692]  [0000000000406214] linux_sparc_syscall32+0x34/0x40

