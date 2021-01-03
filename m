From: Anatoly Pugachev <matorola@gmail.com>
Date: Sun, 03 Jan 2021 12:56:31 +0000
Subject: [sparc64] running stress-ng and a sparc64 hardware / kernel woes
Message-Id: <CADxRZqwARwrMeJZTWLeUtGyjStuz=ze2dwNqov0EyfHkRBM1fw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Sparc kernel list <sparclinux@vger.kernel.org>

Hello!

Running a simple stress-ng as a non-privileged (non root) user :

stress-ng --opcode 1 --timeout 60 --metrics-brief

will almost always bring the linux kernel to an unusable state,
starting from "Unable to handle kernel NULL pointer dereference",
"Bogus kernel PC [0000000000000000] in fault handler", "Kernel
unaligned access at TPC", "Unable to handle kernel paging request at
virtual address" and "rcu: INFO: rcu_sched detected stalls on
CPUs/tasks"...

Can you please suggest a basic linux kernel config "debug" option(s)
to start with to try to debug this issue(s) and report kernel logs ?

Thanks.

PS: kernel logs with the last run:

[  144.386901] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  144.386954] rcu:     0-...!: (3 GPs behind) idleW4/0/0x0
softirqB7/427 fqs=3D1  (false positive?)
[  144.387029]  (detected by 13, tR52 jiffies, g145, q"4)
[  144.387161]   CPU[  0]: TSTATE[0000004480001600]
TPC[000000000042c324] TNPC[000000000042c328] TASK[swapper/0:0]
[  144.387202]              TPC[arch_cpu_idle+0xa4/0xc0]
O7[arch_cpu_idle+0x90/0xc0] I7[default_idle_call+0xd8/0x1a0]
RPC[do_idle+0x110/0x1a0]
[  144.387278] rcu: rcu_sched kthread starved for 5248 jiffies! g3145
f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu#
[  144.387317] rcu:     Unless rcu_sched kthread gets sufficient CPU
time, OOM is now expected behavior.
[  144.387349] rcu: RCU grace-period kthread stack dump:
[  144.387371] task:rcu_sched       state:I stack:    0 pid:   10
ppid:     2 flags:0x07000000
[  144.387410] Call Trace:
[  144.387425] [<0000000000bf9c4c>] schedule+0x8c/0x100
[  144.387455] [<0000000000bfef2c>] schedule_timeout+0x16c/0x1a0
[  144.387481] [<00000000004f2290>] rcu_gp_fqs_loop+0x1d0/0x5e0
[  144.387508] [<00000000004f5318>] rcu_gp_kthread+0x258/0x2a0
[  144.387534] [<000000000048c0e0>] kthread+0x100/0x120
[  144.387558] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[  144.387591] [<0000000000000000>] 0x0
[  165.393918] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  165.393975] rcu:     23-...0: (1 GPs behind)
idle=16a/1/0x4000000000000000 softirq=1365/1366 fqs=1750
[  165.394041]  (detected by 13, tR52 jiffies, g149, q=182)
[  165.394185]   CPU[ 23]: TSTATE[0000000000000000]
TPC[0000000000000000] TNPC[0000000000000000] TASK[NULL:-1]
[  165.394223]              TPC[0] O7[0] I7[0] RPC[0]
[  205.290596] Unable to handle kernel paging request at virtual
address 0000000001900000
[  205.290657] tsk->{mm,active_mm}->context =3D 0000000000000b3c
[  205.290683] tsk->{mm,active_mm}->pgd =3D fff8000045abc000
[  205.290707]               \|/ ____ \|/
[  205.290707]               "@'/ .. \`@"
[  205.290707]               /_| \__/ |_\
[  205.290707]                  \__U_/
[  205.290760] kworker/u512:3(394): Oops [#1]
[  205.290786] CPU: 20 PID: 394 Comm: kworker/u512:3 Tainted: G
    E     5.11.0-rc1-00073-g3516bd729358 #172
[  205.290831] Workqueue: events_unbound flush_to_ldisc
[  205.290868] TSTATE: 0000000080e01605 TPC: 000000000049c0d4 TNPC:
000000000049c0d8 Y: 00000000    Tainted: G            E
[  205.290911] TPC: <task_curr+0x34/0x60>
[  205.290943] g0: 0000000000000000 g1: 0000000001900100 g2:
00000000010fbd00 g3: 0000000001100100
[  205.290977] g4: fff800003c27d680 g5: fff80021a9c20000 g6:
fff800003df98000 g7: fff8000035e58880
[  205.291013] o0: fff800003041ca80 o1: 00000000004743d8 o2:
0000000000000a20 o3: 0000000000000001
[  205.291048] o4: fff800003df9b0d8 o5: dfccfb3737fbd15f sp:
fff800003df9a841 ret_pc: 000000000068db94
[  205.291083] RPC: <kmem_cache_alloc+0x3f4/0x4c0>
[  205.291114] l0: 00000000010e11c0 l1: 000000000000000e l2:
0000000000474300 l3: 0000000000de1250
[  205.291149] l4: 0000000000e20ad0 l5: 0000000000edcc00 l6:
fff8000037482a98 l7: 000000000114a888
[  205.291184] i0: 0000000000000000 i1: 0000000000000a20 i2:
fff8000040443078 i3: 0000000000edc800
[  205.291219] i4: 0000000000edbc78 i5: fff800003041ca80 i6:
fff800003df9a8f1 i7: 0000000000474c3c
[  205.291253] I7: <complete_signal+0x5c/0x2e0>
[  205.291279] Call Trace:
[  205.291295] [<0000000000474c3c>] complete_signal+0x5c/0x2e0
[  205.291322] [<00000000004754c4>] __send_signal+0x2c4/0x4a0
[  205.291348] [<0000000000476cd0>] send_signal+0x170/0x180
[  205.291375] [<0000000000478a20>] group_send_sig_info+0xa0/0xe0
[  205.291404] [<0000000000478a98>] __kill_pgrp_info+0x38/0x80
[  205.291430] [<0000000000478b00>] kill_pgrp+0x20/0x40
[  205.291455] [<00000000009a1490>] isig+0x70/0x140
[  205.291485] [<00000000009a1770>] n_tty_receive_signal_char+0x10/0x80
[  205.291514] [<00000000009a2cac>] n_tty_receive_char_special+0xcc/0x6a0
[  205.291544] [<00000000009a3408>] n_tty_receive_buf_fast+0x188/0x220
[  205.291573] [<00000000009a396c>] __receive_buf+0x1cc/0x300
[  205.291600] [<00000000009a3bfc>] n_tty_receive_buf_common+0x15c/0x2e0
[  205.291629] [<00000000009a3d9c>] n_tty_receive_buf2+0x1c/0x40
[  205.291656] [<00000000009a6864>] tty_ldisc_receive_buf+0x24/0x80
[  205.291686] [<00000000009a74b8>] tty_port_default_receive_buf+0x38/0x60
[  205.291716] [<00000000009a6e30>] flush_to_ldisc+0xb0/0x120
[  205.291741] Disabling lock debugging due to kernel taint
[  205.291750] Caller[0000000000474c3c]: complete_signal+0x5c/0x2e0
[  205.291760] Caller[00000000004754c4]: __send_signal+0x2c4/0x4a0
[  205.291770] Caller[0000000000476cd0]: send_signal+0x170/0x180
[  205.291780] Caller[0000000000478a20]: group_send_sig_info+0xa0/0xe0
[  205.291790] Caller[0000000000478a98]: __kill_pgrp_info+0x38/0x80
[  205.291800] Caller[0000000000478b00]: kill_pgrp+0x20/0x40
[  205.291809] Caller[00000000009a1490]: isig+0x70/0x140
[  205.291819] Caller[00000000009a1770]: n_tty_receive_signal_char+0x10/0x80
[  205.291829] Caller[00000000009a2cac]: n_tty_receive_char_special+0xcc/0x=
6a0
[  205.291840] Caller[00000000009a3408]: n_tty_receive_buf_fast+0x188/0x220
[  205.291850] Caller[00000000009a396c]: __receive_buf+0x1cc/0x300
[  205.291860] Caller[00000000009a3bfc]: n_tty_receive_buf_common+0x15c/0x2=
e0
[  205.291871] Caller[00000000009a3d9c]: n_tty_receive_buf2+0x1c/0x40
[  205.291881] Caller[00000000009a6864]: tty_ldisc_receive_buf+0x24/0x80
[  205.291891] Caller[00000000009a74b8]: tty_port_default_receive_buf+0x38/=
0x60
[  205.291901] Caller[00000000009a6e30]: flush_to_ldisc+0xb0/0x120
[  205.291910] Caller[0000000000484eb0]: process_one_work+0x390/0x620
[  205.291925] Caller[00000000004853f0]: worker_thread+0x2b0/0x4a0
[  205.291935] Caller[000000000048c0e0]: kthread+0x100/0x120
[  205.291946] Caller[00000000004060c8]: ret_from_fork+0x1c/0x2c
[  205.291962] Caller[0000000000000000]: 0x0
[  205.291971] Instruction DUMP:
[  205.291974]  83306010
[  205.291980]  83287008
[  205.291987]  8200c001
[  205.291992] <c25860f8>
[  205.291999]  84004002
[  205.292005]  c258aa28
[  205.292011]  8e19c001
[  205.292017]  81cfe008
[  205.292023]  9179e401
[  205.292029]
[  228.411239] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  228.411273] rcu:     23-...0: (1 GPs behind)
idle=16a/1/0x4000000000000000 softirq=1365/1366 fqsp02
[  228.411312]  (detected by 9, t!007 jiffies, g149, q"4)
[  228.411439]   CPU[ 23]: TSTATE[0000000000000000]
TPC[0000000000000000] TNPC[0000000000000000] TASK[NULL:-1]
[  228.411451]              TPC[0] O7[0] I7[0] RPC[0]
[  291.429047] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  291.429084] rcu:     23-...0: (1 GPs behind)
idle=16a/1/0x4000000000000000 softirq=1365/1366 fqs=12254
[  291.429129]  (detected by 9, t6762 jiffies, g149, q&5)
[  291.429256]   CPU[ 23]: TSTATE[0000000000000000]
TPC[0000000000000000] TNPC[0000000000000000] TASK[NULL:-1]
[  291.429269]              TPC[0] O7[0] I7[0] RPC[0]
[  312.540280] watchdog: BUG: soft lockup - CPU#16 stuck for 23s!
[systemd-logind:652]
[  312.540318] Modules linked in: tun(E) binfmt_misc(E)
camellia_sparc64(E) des_sparc64(E) aes_sparc64(E) n2_rng(E)
md5_sparc64(E) rng_core(E) flash(E) sha512_sparc64(E)
sha256_sparc64(E) sha1_sparc64(E) nft_ct(E) nf_conntrack(E)
nf_defrag_ipv6(E) nf_defrag_ipv4(E) nft_counter(E) nf_tables(E)
nfnetlink(E) sunrpc(E) fuse(E) configfs(E) ip_tables(E) x_tables(E)
autofs4(E) raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E)
async_pq(E) raid6_pq(E) async_xor(E) xor(E) async_tx(E) raid1(E)
raid0(E) multipath(E) linear(E) md_mod(E) dm_mod(E) crc32c_sparc64(E)
sunvnet(E) sunvnet_common(E)
[  312.540485] CPU: 16 PID: 652 Comm: systemd-logind Tainted: G      D
W   E     5.11.0-rc1-00073-g3516bd729358 #172
[  312.540501] TSTATE: 0000000011001601 TPC: 00000000005183ec TNPC:
00000000005183f0 Y: 00000006    Tainted: G      D W   E
[  312.540514] TPC: <smp_call_function_many_cond+0x38c/0x3e0>
[  312.540529] g0: 000000000069952c g1: 0000000000000011 g2:
fff80021aade3420 g3: 0000000000000017
[  312.540540] g4: fff8000044eb6180 g5: fff80021a9b20000 g6:
fff8000044f7c000 g7: 0000000000c00000
[  312.540551] o0: 0000000000000017 o1: fff80021aac1ccc8 o2:
fff80021aaddcc80 o3: fff80021aac1cce8
[  312.540562] o4: 0000000000000000 o5: fff80021aac1cce8 sp:
fff8000044f7e931 ret_pc: 0000000000518408
[  312.540572] RPC: <smp_call_function_many_cond+0x3a8/0x3e0>
[  312.540582] l0: 0000000000000100 l1: fff80021aac1ccc8 l2:
0000000000edbe64 l3: 0000000001100100
[  312.540592] l4: 0000000001103420 l5: fff80021aac1cce8 l6:
0000000000000017 l7: 0000000000000100
[  312.540602] i0: fff80021aac1ccc0 i1: 000000000043f000 i2:
fff8000044f7f358 i3: 0000000000000001
[  312.540612] i4: 0000000000000000 i5: 0000000001100100 i6:
fff8000044f7e9f1 i7: 000000000051845c
[  312.540622] I7: <smp_call_function_many+0x1c/0x40>
[  312.540632] Call Trace:
[  312.540639] [<000000000051845c>] smp_call_function_many+0x1c/0x40
[  312.540649] [<00000000004402d4>] smp_flush_tlb_pending+0x34/0x60
[  312.540662] [<000000000044ed14>] flush_tlb_pending+0x74/0xa0
[  312.540676] [<000000000044eea4>] arch_leave_lazy_mmu_mode+0x24/0x40
[  312.540687] [<000000000064a81c>] zap_pte_range+0x59c/0x6c0
[  312.540698] [<000000000064aac8>] unmap_page_range+0x188/0x240
[  312.540708] [<000000000064ac40>] unmap_single_vma+0xc0/0xe0
[  312.540717] [<000000000064ad7c>] unmap_vmas+0x1c/0x60
[  312.540726] [<00000000006543cc>] exit_mmap+0x14c/0x1e0
[  312.540742] [<000000000045fcf8>] mmput+0x58/0x120
[  312.540754] [<0000000000469cf8>] exit_mm+0x1b8/0x200
[  312.540766] [<000000000046a1f4>] do_exit+0x4b4/0x500
[  312.540776] [<000000000046a364>] do_group_exit+0xa4/0xc0
[  312.540786] [<00000000004786c0>] get_signal+0x600/0x680
[  312.540800] [<000000000042d52c>] do_signal+0x4c/0x1c0
[  312.540817] [<000000000042de70>] do_notify_resume+0x30/0x80
[  354.446709] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  354.446747] rcu:     23-...0: (1 GPs behind)
idle=16a/1/0x4000000000000000 softirq=1365/1366 fqs=17506
[  354.446792]  (detected by 13, tR517 jiffies, g149, q(8)
[  354.446920]   CPU[ 23]: TSTATE[0000000000000000]
TPC[0000000000000000] TNPC[0000000000000000] TASK[NULL:-1]
[  354.446933]              TPC[0] O7[0] I7[0] RPC[0]
[  417.464277] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  417.464314] rcu:     23-...0: (1 GPs behind)
idle=16a/1/0x4000000000000000 softirq=1365/1366 fqs"758
[  417.464359]  (detected by 13, th272 jiffies, g149, q(8)
[  417.464487]   CPU[ 23]: TSTATE[0000000000000000]
TPC[0000000000000000] TNPC[0000000000000000] TASK[NULL:-1]
[  417.464500]              TPC[0] O7[0] I7[0] RPC[0]
[  480.481809] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  480.481847] rcu:     23-...0: (1 GPs behind)
idle=16a/1/0x4000000000000000 softirq=1365/1366 fqs(010
[  480.481890]  (detected by 13, t=84027 jiffies, g149, q(8)
[  480.482018]   CPU[ 23]: TSTATE[0000000000000000]
TPC[0000000000000000] TNPC[0000000000000000] TASK[NULL:-1]
[  480.482031]              TPC[0] O7[0] I7[0] RPC[0]
[  543.499328] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  543.499366] rcu:     23-...0: (1 GPs behind)
idle=16a/1/0x4000000000000000 softirq=1365/1366 fqs3262
[  543.499411]  (detected by 13, t=99782 jiffies, g149, q(8)
[  543.499538]   CPU[ 23]: TSTATE[0000000000000000]
TPC[0000000000000000] TNPC[0000000000000000] TASK[NULL:-1]
[  543.499550]              TPC[0] O7[0] I7[0] RPC[0]
[  606.516843] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  606.516881] rcu:     23-...0: (1 GPs behind)
idle=16a/1/0x4000000000000000 softirq=1365/1366 fqs8514
[  606.516924]  (detected by 13, t=115537 jiffies, g149, q(8)
[  606.517052]   CPU[ 23]: TSTATE[0000000000000000]
TPC[0000000000000000] TNPC[0000000000000000] TASK[NULL:-1]
[  606.517065]              TPC[0] O7[0] I7[0] RPC[0]
[  624.568155] BUG: workqueue lockup - pool cpus=3D2 node=3D0 flags=3D0x0
nice=3D0 stuck for 306s!
[  624.568322] Showing busy workqueues and worker pools:
[  624.568374] workqueue events: flags=3D0x0
[  624.568639]   pwq 4: cpus=3D2 node=3D0 flags=3D0x0 nice=3D0 active=3D1/2=
56 refcnt=3D2
[  624.568663]     pending: psi_avgs_work
[  624.568685]   pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1/2=
56 refcnt=3D2
[  624.568707]     pending: vmstat_shepherd
[  624.568813] workqueue events_unbound: flags=3D0x2
[  624.568822]   pwq 512: cpus=3D0-255 flags=3D0x4 nice=3D0 active=3D2/1024=
 refcnt=3D4
[  624.568850]     in-flight: 394:flush_to_ldisc flush_to_ldisc
[  624.569131] workqueue mm_percpu_wq: flags=3D0x8
[  624.569356]   pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1/2=
56 refcnt=3D2
[  624.569377]     pending: vmstat_update
[  624.573421] pool 512: cpus=3D0-255 flags=3D0x4 nice=3D0 hung02s
workers=3D5 idle: 395 166 7 281
[  669.534354] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  669.534393] rcu:     23-...0: (1 GPs behind)
idle=16a/1/0x4000000000000000 softirq=1365/1366 fqsC766
[  669.534439]  (detected by 16, t=131292 jiffies, g149, q)2)
[  669.534568]   CPU[ 23]: TSTATE[0000000000000000]
TPC[0000000000000000] TNPC[0000000000000000] TASK[NULL:-1]
[  669.534581]              TPC[0] O7[0] I7[0] RPC[0]
[  696.525288] watchdog: BUG: soft lockup - CPU#16 stuck for 22s!
[systemd-logind:652]
[  696.525330] Modules linked in: tun(E) binfmt_misc(E)
camellia_sparc64(E) des_sparc64(E) aes_sparc64(E) n2_rng(E)
md5_sparc64(E) rng_core(E) flash(E) sha512_sparc64(E)
sha256_sparc64(E) sha1_sparc64(E) nft_ct(E) nf_conntrack(E)
nf_defrag_ipv6(E) nf_defrag_ipv4(E) nft_counter(E) nf_tables(E)
nfnetlink(E) sunrpc(E) fuse(E) configfs(E) ip_tables(E) x_tables(E)
autofs4(E) raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E)
async_pq(E) raid6_pq(E) async_xor(E) xor(E) async_tx(E) raid1(E)
raid0(E) multipath(E) linear(E) md_mod(E) dm_mod(E) crc32c_sparc64(E)
sunvnet(E) sunvnet_common(E)
[  696.525498] CPU: 16 PID: 652 Comm: systemd-logind Tainted: G      D
W   EL    5.11.0-rc1-00073-g3516bd729358 #172
[  696.525514] TSTATE: 0000000011001601 TPC: 00000000005183dc TNPC:
00000000005183e0 Y: 00000006    Tainted: G      D W   EL
[  696.525526] TPC: <smp_call_function_many_cond+0x37c/0x3e0>
[  696.525542] g0: 000000000069952c g1: 0000000000000011 g2:
fff80021aade3420 g3: 0000000000000017
[  696.525553] g4: fff8000044eb6180 g5: fff80021a9b20000 g6:
fff8000044f7c000 g7: 0000000000c00000
[  696.525563] o0: 0000000000000017 o1: fff80021aac1ccc8 o2:
fff80021aaddcc80 o3: fff80021aac1cce8
[  696.525574] o4: 0000000000000000 o5: fff80021aac1cce8 sp:
fff8000044f7e931 ret_pc: 0000000000518408
[  696.525584] RPC: <smp_call_function_many_cond+0x3a8/0x3e0>
[  696.525594] l0: 0000000000000100 l1: fff80021aac1ccc8 l2:
0000000000edbe64 l3: 0000000001100100
[  696.525604] l4: 0000000001103420 l5: fff80021aac1cce8 l6:
0000000000000017 l7: 0000000000000100
[  696.525615] i0: fff80021aac1ccc0 i1: 000000000043f000 i2:
fff8000044f7f358 i3: 0000000000000001
[  696.525625] i4: 0000000000000000 i5: 0000000001100100 i6:
fff8000044f7e9f1 i7: 000000000051845c
[  696.525635] I7: <smp_call_function_many+0x1c/0x40>
[  696.525645] Call Trace:
[  696.525652] [<000000000051845c>] smp_call_function_many+0x1c/0x40
[  696.525663] [<00000000004402d4>] smp_flush_tlb_pending+0x34/0x60
[  696.525675] [<000000000044ed14>] flush_tlb_pending+0x74/0xa0
[  696.525689] [<000000000044eea4>] arch_leave_lazy_mmu_mode+0x24/0x40
[  696.525700] [<000000000064a81c>] zap_pte_range+0x59c/0x6c0
[  696.525712] [<000000000064aac8>] unmap_page_range+0x188/0x240
[  696.525722] [<000000000064ac40>] unmap_single_vma+0xc0/0xe0
[  696.525731] [<000000000064ad7c>] unmap_vmas+0x1c/0x60
[  696.525741] [<00000000006543cc>] exit_mmap+0x14c/0x1e0
[  696.525756] [<000000000045fcf8>] mmput+0x58/0x120
[  696.525769] [<0000000000469cf8>] exit_mm+0x1b8/0x200
[  696.525781] [<000000000046a1f4>] do_exit+0x4b4/0x500
[  696.525791] [<000000000046a364>] do_group_exit+0xa4/0xc0
[  696.525801] [<00000000004786c0>] get_signal+0x600/0x680
[  696.525815] [<000000000042d52c>] do_signal+0x4c/0x1c0
[  696.525832] [<000000000042de70>] do_notify_resume+0x30/0x80
