From: James Clarke <jrtc27@jrtc27.com>
Date: Tue, 29 Nov 2016 12:25:11 +0000
Subject: Re: git kernel (4.9.0-rc5; was 4.9.0-rc3) hard lockup on cpu
Message-Id: <AC436031-CF1F-43BE-8609-C7BC6C8A746D@jrtc27.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

Here’s a more detailed dump for a 4.9.0-rc5+ kernel (commit
81bcfe5e48f9b8c42cf547f1c74c7f60c44c34c8). If I’m interpreting the output
correctly, it seems the kworkers are all blocked on RCU barriers, waiting for
an outstanding request, presumably because CPU 64 didn’t perform its requested
action (is the 0xfff8000ea7097c48 some kind of PC corruption, or just a user
space address?). Thoughts?

Regards,
James

[8752781.281403] Watchdog detected hard LOCKUP on cpu 64[8752781.281524] ------------[ cut here ]------------
[8752781.281542] WARNING: CPU: 64 PID: 204238 at arch/sparc/kernel/nmi.c:80 perfctr_irq+0x310/0x360
[8752781.281559] Modules linked in:c tcp_diagc inet_diagc unix_diagc netlink_diagc dccp_ipv4c dccpc tunc xt_tcpudpc xt_multiportc xt_conntrackc iptable_filterc iptable_natc nf_conntrack_ipv4c nf_defrag_ipv4c nf_nat_ipv4c nf_natc nf_conntrackc n2_rngc flashc rng_corec camellia_sparc64c des_sparc64c des_genericc aes_sparc64c md5_sparc64c sha512_sparc64c sha256_sparc64c sha1_sparc64c ip_tablesc x_tablesc autofs4c ext4c crc16c jbd2c fscryptoc mbcachec btrfsc xorc zlib_deflatec raid6_pqc crc32c_sparc64c sunvnetc sunvdcc
[8752781.281609] CPU: 64 PID: 204238 Comm: cc1plus Tainted: G             L  4.9.0-rc5+ #2
[8752781.281623] Call Trace:
[8752781.281632]  [0000000000468520] __warn+0xc0/0xe0
[8752781.281641]  [0000000000468574] warn_slowpath_fmt+0x34/0x60
[8752781.281650]  [0000000000a70d10] perfctr_irq+0x310/0x360
[8752781.281660]  [00000000004209f4] tl0_irq15+0x14/0x20
[8752781.281670] ---[ end trace 7e95909338ac2698 ]---
[8752842.316164] INFO: rcu_sched detected stalls on CPUs/tasks:
[8752842.316212] 	64-...: (0 ticks this GP) idle=2ad/140000000000000/0 softirq=12887641/12887641 fqs=0 
[8752842.316232] 	(detected by 20, t=6502 jiffies, g=9924284, c=9924283, q=104887)
[8752842.316278] Task dump for CPU 64:
[8752842.316287] cc1plus         R  running task        0 210491 210470 0x208000102000000
[8752842.316306] Call Trace:
[8752842.316318]  [fff8000ea7097c48] 0xfff8000ea7097c48
[8752842.316332] rcu_sched kthread starved for 6502 jiffies! g9924284 c9924283 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1
[8752842.316345] rcu_sched       S    0     7      2 0x06000000
[8752842.316357] Call Trace:
[8752842.316378]  [0000000000a6a930] schedule+0x30/0xc0
[8752842.316391]  [0000000000a6f284] schedule_timeout+0x224/0x480
[8752842.316410]  [00000000004f777c] rcu_gp_kthread+0x75c/0x1f00
[8752842.316428]  [0000000000491c00] kthread+0xc0/0x100
[8752842.316445]  [0000000000406084] ret_from_fork+0x1c/0x2c
[8752842.316455]  [0000000000000000]           (null)
[8752869.431088] INFO: rcu_sched detected stalls on CPUs/tasks:
[8752869.431133] 	64-...: (33 GPs behind) idle=eac/0/0 softirq=12887641/12887641 fqs=1 
[8752869.431152] 	(detected by 26, t=6502 jiffies, g=9924317, c=9924316, q=43778)
[8752869.431204] Task dump for CPU 64:
[8752869.431215] swapper/64      R  running task        0     0      1 0x05000000
[8752869.431236] Call Trace:
[8752869.431259]  [00000000005134c0] tick_nohz_idle_enter+0x40/0xa0
[8752869.431276] rcu_sched kthread starved for 6498 jiffies! g9924317 c9924316 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1
[8752869.431292] rcu_sched       S    0     7      2 0x06000000
[8752869.431306] Call Trace:
[8752869.431326]  [0000000000a6a930] schedule+0x30/0xc0
[8752869.431341]  [0000000000a6f284] schedule_timeout+0x224/0x480
[8752869.431360]  [00000000004f777c] rcu_gp_kthread+0x75c/0x1f00
[8752869.431381]  [0000000000491c00] kthread+0xc0/0x100
[8752869.431400]  [0000000000406084] ret_from_fork+0x1c/0x2c
[8752869.431413]  [0000000000000000]           (null)
[8752925.429157] INFO: task kworker/66:38:113388 blocked for more than 120 seconds.
[8752925.429193]       Tainted: G        W    L  4.9.0-rc5+ #2
[8752925.429206] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[8752925.429223] kworker/66:38   D    0 113388      2 0x06000000
[8752925.429255] Workqueue: cgroup_destroy css_free_work_fn
[8752925.429268] Call Trace:
[8752925.429290]  [0000000000a6a930] schedule+0x30/0xc0
[8752925.429305]  [0000000000a6adb8] schedule_preempt_disabled+0x18/0x40
[8752925.429319]  [0000000000a6bc0c] mutex_lock_nested+0x18c/0x3e0
[8752925.429338]  [00000000004f1f0c] _rcu_barrier+0x4c/0x2a0
[8752925.429351]  [00000000004f2190] rcu_barrier+0x10/0x20
[8752925.429365]  [00000000005df674] release_caches+0x54/0x80
[8752925.429378]  [00000000005df738] memcg_destroy_kmem_caches+0x98/0xe0
[8752925.429400]  [000000000062b660] mem_cgroup_css_free+0xe0/0x140
[8752925.429413]  [000000000052e194] css_free_work_fn+0x34/0x8a0
[8752925.429429]  [000000000048977c] process_one_work+0x21c/0x7a0
[8752925.429442]  [0000000000489e30] worker_thread+0x130/0x540
[8752925.429458]  [0000000000491c00] kthread+0xc0/0x100
[8752925.429476]  [0000000000406084] ret_from_fork+0x1c/0x2c
[8752925.429487]  [0000000000000000]           (null)
[8752925.429495] 
[8752925.429495] Showing all locks held in the system:
[8752925.429619] 2 locks held by khungtaskd/777:
[8752925.429628]  #0: [8752925.429633]  (
rcu_read_lock[8752925.429643] ){......}
, at: [8752925.429663] [<000000000054e97c>] watchdog+0xfc/0x7e0
[8752925.429671]  #1: [8752925.429675]  (
tasklist_lock[8752925.429685] ){.+.+..}
, at: [8752925.429705] [<00000000004c9904>] debug_show_all_locks+0x64/0x1c0
[8752925.429753] 1 lock held by in:imklog/195203:
[8752925.429762]  #0: [8752925.429766]  (
&f->f_pos_lock[8752925.429776] ){+.+.+.}
, at: [8752925.429795] [<000000000065e12c>] __fdget_pos+0x4c/0x60
[8752925.429823] 3 locks held by kworker/66:38/113388:
[8752925.429832]  #0: [8752925.429836]  (
"cgroup_destroy"[8752925.429847] ){.+.+..}
, at: [8752925.429858] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.429867]  #1: [8752925.429871]  (
(&css->destroy_work)[8752925.429881] #3
){+.+...}[8752925.429890] , at: 
[8752925.429898] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.429907]  #2: [8752925.429910]  (
rcu_sched_state.barrier_mutex[8752925.429921] ){+.+...}
, at: [8752925.429931] [<00000000004f1f0c>] _rcu_barrier+0x4c/0x2a0
[8752925.429943] 3 locks held by kworker/119:7/135688:
[8752925.429951]  #0: [8752925.429954]  (
"cgroup_destroy"[8752925.429963] ){.+.+..}
, at: [8752925.429973] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.429982]  #1: [8752925.429985]  (
(&css->destroy_work)[8752925.429995] #3
){+.+...}[8752925.430004] , at: 
[8752925.430011] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.430019]  #2: [8752925.430023]  (
rcu_sched_state.barrier_mutex[8752925.430032] ){+.+...}
, at: [8752925.430043] [<00000000004f1f0c>] _rcu_barrier+0x4c/0x2a0
[8752925.430103] 3 locks held by kworker/55:59/152023:
[8752925.430111]  #0: [8752925.430114]  (
"cgroup_destroy"[8752925.430124] ){.+.+..}
, at: [8752925.430134] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.430142]  #1: [8752925.430146]  (
(&css->destroy_work)[8752925.430155] #3
){+.+...}[8752925.430164] , at: 
[8752925.430172] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.430180]  #2: [8752925.430183]  (
rcu_sched_state.barrier_mutex[8752925.430193] ){+.+...}
, at: [8752925.430204] [<00000000004f1f0c>] _rcu_barrier+0x4c/0x2a0
[8752925.430341] 3 locks held by kworker/121:33/193553:
[8752925.430351]  #0: [8752925.430355]  (
"cgroup_destroy"[8752925.430364] ){.+.+..}
, at: [8752925.430374] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.430382]  #1: [8752925.430386]  (
(&css->destroy_work)[8752925.430395] #3
){+.+...}[8752925.430404] , at: 
[8752925.430411] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.430419]  #2: [8752925.430422]  (
rcu_sched_state.barrier_mutex[8752925.430432] ){+.+...}
, at: [8752925.430442] [<00000000004f1f0c>] _rcu_barrier+0x4c/0x2a0
[8752925.430459] 3 locks held by kworker/127:13/193573:
[8752925.430466]  #0: [8752925.430470]  (
"cgroup_destroy"[8752925.430479] ){.+.+..}
, at: [8752925.430489] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.430497]  #1: [8752925.430501]  (
(&css->destroy_work)[8752925.430510] #3
){+.+...}[8752925.430519] , at: 
[8752925.430527] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.430535]  #2: [8752925.430538]  (
rcu_sched_state.barrier_mutex[8752925.430548] ){+.+...}
, at: [8752925.430558] [<00000000004f1f0c>] _rcu_barrier+0x4c/0x2a0
[8752925.430658] 3 locks held by kworker/10:4/194206:
[8752925.430667]  #0: [8752925.430671]  (
"cgroup_destroy"[8752925.430680] ){.+.+..}
, at: [8752925.430690] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.430698]  #1: [8752925.430702]  (
(&css->destroy_work)[8752925.430711] #3
){+.+...}[8752925.430720] , at: 
[8752925.430727] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.430735]  #2: [8752925.430739]  (
rcu_sched_state.barrier_mutex[8752925.430748] ){+.+...}
, at: [8752925.430759] [<00000000004f1f0c>] _rcu_barrier+0x4c/0x2a0
[8752925.430899] 3 locks held by kworker/76:3/194799:
[8752925.430908]  #0: [8752925.430912]  (
"cgroup_destroy"[8752925.430922] ){.+.+..}
, at: [8752925.430932] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.430941]  #1: [8752925.430944]  (
(&css->destroy_work)[8752925.430954] #3
){+.+...}[8752925.430962] , at: 
[8752925.430970] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.430978]  #2: [8752925.430982]  (
rcu_sched_state.barrier_mutex[8752925.430992] ){+.+...}
, at: [8752925.431002] [<00000000004f1f0c>] _rcu_barrier+0x4c/0x2a0
[8752925.431029] 3 locks held by kworker/5:3/194929:
[8752925.431036]  #0: [8752925.431041]  (
"cgroup_destroy"[8752925.431051] ){.+.+..}
, at: [8752925.431061] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.431071]  #1: [8752925.431074]  (
(&css->destroy_work)[8752925.431084] #3
){+.+...}[8752925.431093] , at: 
[8752925.431100] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.431108]  #2: [8752925.431112]  (
rcu_sched_state.barrier_mutex[8752925.431121] ){+.+...}
, at: [8752925.431131] [<00000000004f1f0c>] _rcu_barrier+0x4c/0x2a0
[8752925.431341] 3 locks held by kworker/86:39/197523:
[8752925.431352]  #0: [8752925.431356]  (
"cgroup_destroy"[8752925.431365] ){.+.+..}
, at: [8752925.431376] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.431384]  #1: [8752925.431387]  (
(&css->destroy_work)[8752925.431396] #3
){+.+...}[8752925.431405] , at: 
[8752925.431413] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.431420]  #2: [8752925.431424]  (
rcu_sched_state.barrier_mutex[8752925.431433] ){+.+...}
, at: [8752925.431444] [<00000000004f1f0c>] _rcu_barrier+0x4c/0x2a0
[8752925.431480] 3 locks held by kworker/81:2/203371:
[8752925.431488]  #0: [8752925.431491]  (
"cgroup_destroy"[8752925.431500] ){.+.+..}
, at: [8752925.431510] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.431518]  #1: [8752925.431521]  (
(&css->destroy_work)[8752925.431531] #3
){+.+...}[8752925.431540] , at: 
[8752925.431547] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.431555]  #2: [8752925.431559]  (
rcu_sched_state.barrier_mutex[8752925.431568] ){+.+...}
, at: [8752925.431578] [<00000000004f1f0c>] _rcu_barrier+0x4c/0x2a0
[8752925.431609] 3 locks held by kworker/17:6/203710:
[8752925.431616]  #0: [8752925.431619]  (
"cgroup_destroy"[8752925.431629] ){.+.+..}
, at: [8752925.431639] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.431647]  #1: [8752925.431651]  (
(&css->destroy_work)[8752925.431660] #3
){+.+...}[8752925.431669] , at: 
[8752925.431677] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.431685]  #2: [8752925.431688]  (
rcu_sched_state.barrier_mutex[8752925.431698] ){+.+...}
, at: [8752925.431708] [<00000000004f1f0c>] _rcu_barrier+0x4c/0x2a0
[8752925.431766] 3 locks held by kworker/74:5/203912:
[8752925.431775]  #0: [8752925.431780]  (
"cgroup_destroy"[8752925.431789] ){.+.+..}
, at: [8752925.431801] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.431809]  #1: [8752925.431813]  (
(&css->destroy_work)[8752925.431822] #3
){+.+...}[8752925.431831] , at: 
[8752925.431838] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.431846]  #2: [8752925.431850]  (
rcu_sched_state.barrier_mutex[8752925.431859] ){+.+...}
, at: [8752925.431870] [<00000000004f1f0c>] _rcu_barrier+0x4c/0x2a0
[8752925.431910] 3 locks held by kworker/106:11/204148:
[8752925.431918]  #0: [8752925.431922]  (
"cgroup_destroy"[8752925.431932] ){.+.+..}
, at: [8752925.431942] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.431951]  #1: [8752925.431954]  (
(&css->destroy_work)[8752925.431963] #3
){+.+...}[8752925.431972] , at: 
[8752925.431980] [<00000000004896dc>] process_one_work+0x17c/0x7a0
[8752925.431988]  #2: [8752925.431991]  (
rcu_sched_state.barrier_mutex[8752925.432000] ){+.+...}
, at: [8752925.432011] [<00000000004f1f0c>] _rcu_barrier+0x4c/0x2a0
[8752925.432027] 
[8752925.432034] =============================================
