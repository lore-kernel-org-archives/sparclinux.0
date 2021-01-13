From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Date: Wed, 13 Jan 2021 08:51:03 +0000
Subject: soft lockups on T5120
Message-Id: <65a62b7c6e752dfb1b46624aa579d5e2@sf-tec.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Every one ine a while my T5120 locks up, i.e. some processes get stuck=20
forever.
Starting new screen sessions or logging in via SSH luckily still works,=20
but I
can't get it to properly reboot. Sync via sysrq has worked today which=20
is quite
nice, but the software RAID still needs rebuild :/

This usually happens when I torture the machine with parallel builds and=20
testsuites
when doing package stabilizations for Gentoo.

The kernel currently is 5.10.3, but I hit this for quite a while

Here is what came out of dmesg today. I found no signs of trouble=20
earlier than this:

[1133535.314437] bdi 253:2: the stable_pages_required attribute has been=20
removed. Use the stable_writes queue attribute instead.
[1172057.708692] rcu: INFO: rcu_sched self-detected stall on CPU
[1172057.708938] rcu:   24-....: (2098 ticks this GP)=20
idle=ADe/1/0x4000000000000002 softirq=15784774/15784776 fqs=980
[1172057.709165]        (t!00 jiffies g`946309 q5826)
[1172057.709342]   CPU[ 20]: TSTATE[0000000010001600]=20
TPC[0000000000449df8] TNPC[0000000000449dfc] TASK[ctest:9857]
[1172057.709594]              TPC[do_signal32+0x158/0xa00]=20
O7[0xf774ee3c] I7[do_signal+0x1a0/0x560]=20
RPC[sparc64_next_event+0xc/0x40]
[1172057.709892] * CPU[ 24]: TSTATE[0000000080001603]=20
TPC[00000000005c2060] TNPC[00000000005c2064] TASK[ctest:9870]
[1172057.710097]              TPC[handle_mm_fault+0x8a0/0xec0]=20
O7[handle_mm_fault+0x830/0xec0] I7[do_sparc64_fault+0x484/0x820]=20
RPC[sparc64_realfault_common+0x10/0x20]
[1172120.771626] rcu: INFO: rcu_sched self-detected stall on CPU
[1172120.771860] rcu:   24-....: (8401 ticks this GP)=20
idle=ADe/1/0x4000000000000002 softirq=15784774/15784776 fqs835
[1172120.772070]        (t=8403 jiffies g`946309 q45345)
[1172120.772231]   CPU[ 20]: TSTATE[0000009980001603]=20
TPC[00000000005c1fb4] TNPC[00000000005c1fb8] TASK[ctest:9857]
[1172120.772415]              TPC[handle_mm_fault+0x7f4/0xec0]=20
O7[find_vma+0x8/0x80] I7[do_sparc64_fault+0x484/0x820]=20
RPC[sparc64_realfault_common+0x10/0x20]
[1172120.772621] * CPU[ 24]: TSTATE[0000009980001602]=20
TPC[0000000000af5fbc] TNPC[0000000000af5fc0] TASK[ctest:9870]
[1172120.772972]              TPC[do_sparc64_fault+0x11c/0x820]=20
O7[do_sparc64_fault+0x56c/0x820] I7[sparc64_realfault_common+0x10/0x20]=20
RPC[0xf73a6e3c]
[1172152.508195] rcu: INFO: rcu_sched detected expedited stalls on=20
CPUs/tasks: { 18-... 20-... 24-... } 2104 jiffies s: 429033 root: 0x2/.
[1172152.508485] rcu: blocking rcu_node structures: l=3D1:16-31:0x114/.
[1172152.508627] Task dump for CPU 18:
[1172152.508710] task:ctest           state:R  running task     stack:  =20
  0 pid:10551 ppid:  6321 flags:0x210000005000088
[1172152.508862] Call Trace:
[1172152.508921] [<0000000000cc8048>] 0xcc8048
[1172152.508976] Task dump for CPU 20:
[1172152.509029] task:ctest           state:R  running task     stack:  =20
  0 pid: 9857 ppid:  6321 flags:0x210000005000088
[1172152.509153] Call Trace:
[1172152.509218] [<00000000004d18e4>] hrtimer_interrupt+0xc4/0x220
[1172152.509304] [<0000000000af693c>] timer_interrupt+0x7c/0xc0
[1172152.509381] [<0000000000af693c>] timer_interrupt+0x7c/0xc0
[1172152.509451] [<ffff8007fe907758>] 0xffff8007fe907758
[1172152.509517] Task dump for CPU 24:
[1172152.509571] task:ctest           state:R  running task     stack:  =20
  0 pid: 9870 ppid:  6321 flags:0x210000005000088
[1172152.509693] Call Trace:
[1172152.509747] [<0000000000cc8048>] 0xcc8048
[1172183.834551] rcu: INFO: rcu_sched self-detected stall on CPU
[1172183.834771] rcu:   20-....: (14702 ticks this GP)=20
idle=11e/1/0x4000000000000002 softirq=15160311/15160312 fqsf31
[1172183.834970]        (t=14706 jiffies g`946309 qg5553)
[1172183.835163] * CPU[ 20]: TSTATE[0000004480001602]=20
TPC[00000000004aad90] TNPC[00000000004aad94] TASK[ctest:9857]
[1172183.835385]              TPC[down_read_trylock+0x10/0x60]=20
O7[do_sparc64_fault+0x164/0x820] I7[sparc64_realfault_common+0x10/0x20]=20
RPC[0xf774ee3c]
[1172183.835635]   CPU[ 24]: TSTATE[0000004480001601]=20
TPC[0000000000404c5c] TNPC[0000000000404c60] TASK[ctest:9870]
[1172183.835775]              TPC[rt_continue+0x2c/0xf4]=20
O7[sparc64_realfault_common+0x10/0x20] I7[0xf73a6e3c]=20
RPC[do_signal+0x1a0/0x560]
[1172218.462656] rcu: INFO: rcu_sched detected expedited stalls on=20
CPUs/tasks: { 18-... 20-... 24-... } 8696 jiffies s: 429033 root: 0x2/.
[1172218.462944] rcu: blocking rcu_node structures: l=3D1:16-31:0x114/.
[1172218.463086] Task dump for CPU 18:
[1172218.463170] task:ctest           state:R  running task     stack:  =20
  0 pid:10551 ppid:  6321 flags:0x210000205000088
[1172218.463380] Call Trace:
[1172218.463468] [<0000000000cc8048>] 0xcc8048
[1172218.463551] Task dump for CPU 20:
[1172218.463633] task:ctest           state:R  running task     stack:  =20
  0 pid: 9857 ppid:  6321 flags:0x210000005000088
[1172218.463842] Call Trace:
[1172218.463896] [<0000000000cc8048>] 0xcc8048
[1172218.463950] Task dump for CPU 24:
[1172218.464003] task:ctest           state:R  running task     stack:  =20
  0 pid: 9870 ppid:  6321 flags:0x210000205000088
[1172218.464126] Call Trace:
[1172218.464180] [<0000000000cc8048>] 0xcc8048
[1172246.897456] rcu: INFO: rcu_sched self-detected stall on CPU
[1172246.897672] rcu:   20-....: (21005 ticks this GP)=20
idle=11e/1/0x4000000000000002 softirq=15160311/15160312 fqs=9358
[1172246.897867]        (t!009 jiffies g`946309 qy5901)
[1172246.898058] * CPU[ 20]: TSTATE[0000000080001601]=20
TPC[000000000040770c] TNPC[0000000000407710] TASK[ctest:9857]
[1172246.898277]              TPC[sparc64_realfault_common+0x8/0x20]=20
O7[sparc64_realfault_common+0x10/0x20] I7[0xf774ee3c]=20
RPC[do_signal+0x1a0/0x560]
[1172246.898522]   CPU[ 24]: TSTATE[0000000080001603]=20
TPC[00000000005c17ec] TNPC[00000000005c17f0] TASK[ctest:9870]
[1172246.898683]              TPC[handle_mm_fault+0x2c/0xec0]=20
O7[find_vma+0x8/0x80] I7[do_sparc64_fault+0x484/0x820]=20
RPC[sparc64_realfault_common+0x10/0x20]
[1172274.812273] INFO: task khugepaged:337 blocked for more than 122=20
seconds.
[1172274.812458]       Not tainted 5.10.3-gentoo-sparc64 #1
[1172274.812582] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=20
disables this message.
[1172274.812714] task:khugepaged      state:D stack:    0 pid:  337=20
ppid:     2 flags:0x04000000
[1172274.812855] Call Trace:
[1172274.812954] [<0000000000af0ae0>] schedule+0x40/0xe0
[1172274.813089] [<0000000000af4018>] schedule_timeout+0x1f8/0x380
[1172274.813223] [<0000000000af1c80>] wait_for_completion+0x60/0xc0
[1172274.813360] [<000000000047de70>] __flush_work.isra.0+0xf0/0x220
[1172274.813445] [<00000000005db3b0>] drain_all_pages+0x170/0x260
[1172274.813518] [<00000000005dd94c>]=20
__alloc_pages_slowpath.constprop.0+0x36c/0xd20
[1172274.813592] [<00000000005de4bc>] __alloc_pages_nodemask+0x1bc/0x240
[1172274.813678] [<0000000000603510>] khugepaged_alloc_page+0x10/0xa0
[1172274.813751] [<0000000000605b6c>] khugepaged+0x8ec/0x1e40
[1172274.813824] [<0000000000485a04>] kthread+0x104/0x120
[1172274.813902] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[1172274.813971] [<0000000000000000>] 0x0
[1172274.814059] INFO: task md127_raid1:1099 blocked for more than 122=20
seconds.
[1172274.814361]       Not tainted 5.10.3-gentoo-sparc64 #1
[1172274.814426] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=20
disables this message.
[1172274.814496] task:md127_raid1     state:D stack:    0 pid: 1099=20
ppid:     2 flags:0x01000000
[1172274.814574] Call Trace:
[1172274.814632] [<0000000000af0ae0>] schedule+0x40/0xe0
[1172274.814713] [<00000000007a3694>]=20
percpu_ref_switch_to_atomic_sync+0x34/0x80
[1172274.814794] [<00000000009199e0>] set_in_sync+0x40/0xe0
[1172274.814866] [<0000000000928280>] md_check_recovery+0x520/0x5c0
[1172274.814941] [<00000000008f17f4>] raid1d+0x14/0x1380
[1172274.815013] [<000000000091a54c>] md_thread+0xac/0x1a0
[1172274.815083] [<0000000000485a04>] kthread+0x104/0x120
[1172274.815155] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[1172274.815223] [<0000000000000000>] 0x0
[1172274.815301] INFO: task jbd2/dm-0-8:1197 blocked for more than 122=20
seconds.
[1172274.815370]       Not tainted 5.10.3-gentoo-sparc64 #1
[1172274.815435] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=20
disables this message.
[1172274.815505] task:jbd2/dm-0-8     state:D stack:    0 pid: 1197=20
ppid:     2 flags:0x02000000
[1172274.815583] Call Trace:
[1172274.815640] [<0000000000af0ae0>] schedule+0x40/0xe0
[1172274.815713] [<0000000000af0fec>] io_schedule+0xc/0x40
[1172274.815787] [<0000000000af1484>] bit_wait_io+0x4/0x60
[1172274.815860] [<0000000000af107c>] __wait_on_bit+0x5c/0x100
[1172274.815934] [<0000000000af119c>] out_of_line_wait_on_bit+0x7c/0xa0
[1172274.816020] [<000000000072c14c>]=20
jbd2_journal_commit_transaction+0x160c/0x1a20
[1172274.816099] [<0000000000731190>] kjournald2+0x90/0x1e0
[1172274.816169] [<0000000000485a04>] kthread+0x104/0x120
[1172274.816241] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[1172274.816309] [<0000000000000000>] 0x0
[1172274.816407] INFO: task jbd2/dm-4-8:2254 blocked for more than 122=20
seconds.
[1172274.816477]       Not tainted 5.10.3-gentoo-sparc64 #1
[1172274.816542] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=20
disables this message.
[1172274.816613] task:jbd2/dm-4-8     state:D stack:    0 pid: 2254=20
ppid:     2 flags:0x02000000
[1172274.816692] Call Trace:
[1172274.816751] [<0000000000af0ae0>] schedule+0x40/0xe0
[1172274.816823] [<0000000000af0fec>] io_schedule+0xc/0x40
[1172274.816895] [<0000000000af1484>] bit_wait_io+0x4/0x60
[1172274.816968] [<0000000000af107c>] __wait_on_bit+0x5c/0x100
[1172274.817042] [<0000000000af119c>] out_of_line_wait_on_bit+0x7c/0xa0
[1172274.817119] [<000000000072c14c>]=20
jbd2_journal_commit_transaction+0x160c/0x1a20
[1172274.817195] [<0000000000731190>] kjournald2+0x90/0x1e0
[1172274.817265] [<0000000000485a04>] kthread+0x104/0x120
[1172274.817337] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[1172274.817405] [<0000000000000000>] 0x0
[1172274.817528] INFO: task nagios:61302 blocked for more than 122=20
seconds.
[1172274.817597]       Not tainted 5.10.3-gentoo-sparc64 #1
[1172274.817663] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=20
disables this message.
[1172274.817734] task:nagios          state:D stack:    0 pid:61302=20
ppid:     1 flags:0x310000107000080
[1172274.817815] Call Trace:
[1172274.817874] [<0000000000af0ae0>] schedule+0x40/0xe0
[1172274.817946] [<0000000000730c10>] jbd2_log_wait_commit+0x90/0x100
[1172274.818020] [<00000000007189dc>] ext4_fc_commit+0x13c/0x8c0
[1172274.818096] [<00000000006bd1ac>] ext4_sync_file+0x2ac/0x3c0
[1172274.818170] [<0000000000643988>] vfs_fsync_range+0x28/0x80
[1172274.818241] [<0000000000643a28>] do_fsync+0x28/0x60
[1172274.818311] [<0000000000643d28>] sys_fsync+0x8/0x20
[1172274.818384] [<0000000000406214>] linux_sparc_syscall32+0x34/0x60
[1172274.818640] INFO: task python3.8:6310 blocked for more than 122=20
seconds.
[1172274.818710]       Not tainted 5.10.3-gentoo-sparc64 #1
[1172274.818776] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=20
disables this message.
[1172274.818846] task:python3.8       state:D stack:    0 pid: 6310=20
ppid: 61756 flags:0x410000103000082
[1172274.818927] Call Trace:
[1172274.818985] [<0000000000af0ae0>] schedule+0x40/0xe0
[1172274.822656] [<00000000004c6590>]=20
synchronize_rcu_expedited+0x1b0/0x400
[1172274.822741] [<0000000000630548>] namespace_unlock+0x88/0x160
[1172274.822822] [<0000000000634664>] put_mnt_ns+0x24/0x40
[1172274.822899] [<0000000000486190>] free_nsproxy+0x10/0x140
[1172274.823353] [<0000000000466edc>] do_exit+0x29c/0xa60
[1172274.823429] [<0000000000468678>] do_group_exit+0x38/0xc0
[1172274.823505] [<0000000000468714>] sys_exit_group+0x14/0x20
[1172274.825936] [<0000000000406214>] linux_sparc_syscall32+0x34/0x60
[1172274.825968] INFO: task mandb:9144 blocked for more than 122=20
seconds.
[1172274.825979]       Not tainted 5.10.3-gentoo-sparc64 #1
[1172274.826167] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=20
disables this message.
[1172274.826178] task:mandb           state:D stack:    0 pid: 9144=20
ppid:  9142 flags:0x310000102000080
[1172274.828590] Call Trace:
[1172274.828603] [<0000000000af0ae0>] schedule+0x40/0xe0
[1172274.828616] [<0000000000730c10>] jbd2_log_wait_commit+0x90/0x100
[1172274.828628] [<00000000007189dc>] ext4_fc_commit+0x13c/0x8c0
[1172274.828645] [<00000000006bd1ac>] ext4_sync_file+0x2ac/0x3c0
[1172274.833079] [<0000000000643988>] vfs_fsync_range+0x28/0x80
[1172274.833095] [<00000000005ce6a8>] sys_msync+0x188/0x220
[1172274.834163] [<0000000000406214>] linux_sparc_syscall32+0x34/0x60
[1172285.067416] rcu: INFO: rcu_sched detected expedited stalls on=20
CPUs/tasks: { 18-... 20-... 24-... } 15353 jiffies s: 429033 root: 0x2/.
[1172285.067708] rcu: blocking rcu_node structures: l=3D1:16-31:0x114/.
[1172285.067851] Task dump for CPU 18:
[1172285.067934] task:ctest           state:R  running task     stack:  =20
  0 pid:10551 ppid:  6321 flags:0x210000205000088
[1172285.068144] Call Trace:
[1172285.068232] [<0000000000cc8048>] 0xcc8048
[1172285.068315] Task dump for CPU 20:
[1172285.068397] task:ctest           state:R  running task     stack:  =20
  0 pid: 9857 ppid:  6321 flags:0x210000005000088
[1172285.068519] Call Trace:
[1172285.068573] [<0000000000cc8048>] 0xcc8048
[1172285.068628] Task dump for CPU 24:
[1172285.068710] task:ctest           state:R  running task     stack:  =20
  0 pid: 9870 ppid:  6321 flags:0x210000205000088
[1172285.068832] Call Trace:
[1172285.068897] [<00000000004d18e4>] hrtimer_interrupt+0xc4/0x220
[1172285.068968] [<ffff8007fea07758>] 0xffff8007fea07758
[1172309.960387] rcu: INFO: rcu_sched self-detected stall on CPU
[1172309.960606] rcu:   24-....: (27310 ticks this GP)=20
idle=ADe/1/0x4000000000000002 softirq=15784774/15784776 fqs=12044
[1172309.960804]        (t'312 jiffies g`946309 q=975185)
[1172309.960995]   CPU[ 20]: TSTATE[0000000080001601]=20
TPC[000000000040770c] TNPC[0000000000407710] TASK[ctest:9857]
[1172309.961217]              TPC[sparc64_realfault_common+0x8/0x20]=20
O7[sparc64_realfault_common+0x10/0x20] I7[0xf774ee3c]=20
RPC[do_signal+0x1a0/0x560]
[1172309.961466] * CPU[ 24]: TSTATE[0000004480001602]=20
TPC[0000000000af6410] TNPC[00000000004aac40] TASK[ctest:9870]
[1172309.961619]              TPC[do_sparc64_fault+0x570/0x820]=20
O7[do_sparc64_fault+0x56c/0x820] I7[sparc64_realfault_common+0x10/0x20]=20
RPC[0xf73a6e3c]
[1172351.652200] rcu: INFO: rcu_sched detected expedited stalls on=20
CPUs/tasks: { 18-... 20-... 24-... } 22008 jiffies s: 429033 root: 0x2/.
[1172351.652500] rcu: blocking rcu_node structures: l=3D1:16-31:0x114/.
[1172351.652646] Task dump for CPU 18:
[1172351.652732] task:ctest           state:R  running task     stack:  =20
  0 pid:10551 ppid:  6321 flags:0x210000205000088
[1172351.652949] Call Trace:
[1172351.653039] [<0000000000cc8048>] 0xcc8048
[1172351.653125] Task dump for CPU 20:
[1172351.653209] task:ctest           state:R  running task     stack:  =20
  0 pid: 9857 ppid:  6321 flags:0x210000005000088
[1172351.653423] Call Trace:
[1172351.653511] [<0000000000cc8048>] 0xcc8048
[1172351.653568] Task dump for CPU 24:
[1172351.653624] task:ctest           state:R  running task     stack:  =20
  0 pid: 9870 ppid:  6321 flags:0x210000205000088
[1172351.653750] Call Trace:
[1172351.653818] [<00000000004d18e4>] hrtimer_interrupt+0xc4/0x220
[1172351.653906] [<0000000000af693c>] timer_interrupt+0x7c/0xc0
[1172351.653985] [<0000000000af693c>] timer_interrupt+0x7c/0xc0
[1172351.654061] [<00000000004209d4>] tl0_irq14+0x14/0x20
[1172351.654148] [<00000000005c7728>] find_vma+0x8/0x80
[1172351.654227] [<0000000000af6324>] do_sparc64_fault+0x484/0x820
[1172351.654313] [<0000000000407714>] sparc64_realfault_common+0x10/0x20
[1172351.654398] [<0000000000449df8>] do_signal32+0x158/0xa00
[1172351.654481] [<000000000042ce60>] do_signal+0x1a0/0x560
[1172351.654560] [<000000000042da00>] do_notify_resume+0x40/0x60
[1172351.654638] [<0000000000404b48>] __handle_signal+0xc/0x30


[1192375.940199] sysrq: Show Global CPU Regs
[1192375.940392]   CPU[  0]: TSTATE[0000004480001605]=20
TPC[000000000042bee0] TNPC[000000000042bee4] TASK[swapper/0:0]
[1192375.940610]              TPC[arch_cpu_idle+0x80/0xa0]=20
O7[arch_cpu_idle+0x6c/0xa0] I7[default_idle_call+0x48/0x120]=20
RPC[do_idle+0xd8/0x180]
[1192375.940829] * CPU[  1]: TSTATE[0000004482000a24]=20
TPC[00000000f78a6a8c] TNPC[00000000f78a6a90] TASK[bash:58668]
[1192375.940943]              TPC[f78a6a8c] O7[f78a6a6c] I7[0] RPC[0]
[1192375.941023]   CPU[  2]: TSTATE[0000004480001604]=20
TPC[000000000042bee0] TNPC[000000000042bee4] TASK[swapper/2:0]
[1192375.941131]              TPC[arch_cpu_idle+0x80/0xa0]=20
O7[arch_cpu_idle+0x6c/0xa0] I7[default_idle_call+0x48/0x120]=20
RPC[do_idle+0xd8/0x180]
[1192375.944772]   CPU[ 18]: TSTATE[0000004480001603]=20
TPC[000000000080902c] TNPC[0000000000809030] TASK[ctest:10551]
[1192375.944898]              TPC[atomic64_add_return+0x8/0x54]=20
O7[up_read+0x8/0x60] I7[do_sparc64_fault+0x56c/0x820]=20
RPC[sparc64_realfault_common+0x10/0x20]
[1192375.945515]   CPU[ 21]: TSTATE[0000004480001602]=20
TPC[0000000000af61fc] TNPC[0000000000af6200] TASK[ctest:9857]
[1192375.945621]              TPC[do_sparc64_fault+0x35c/0x820]=20
O7[do_sparc64_fault+0x164/0x820] I7[sparc64_realfault_common+0x10/0x20]=20
RPC[0xf774ee3c]
[1192375.951558]   CPU[ 24]: TSTATE[0000000082000a05]=20
TPC[00000000f777ae20] TNPC[00000000f777ae24] TASK[openssl:58755]
[1192375.966040]              TPC[f777ae20] O7[f778bb24] I7[f77859f0]=20
RPC[f7785b70]
[1192375.966131]   CPU[ 25]: TSTATE[0000009980001602]=20
TPC[0000000000af643c] TNPC[0000000000af6440] TASK[ctest:9870]
[1192375.966237]              TPC[do_sparc64_fault+0x59c/0x820]=20
O7[do_sparc64_fault+0x56c/0x820] I7[sparc64_realfault_common+0x10/0x20]=20
RPC[0xf73a6e3c]

All other CPUs are in the same state as CPU2, just with a different=20
instance of swapper/*
