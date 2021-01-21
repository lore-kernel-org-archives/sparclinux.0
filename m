From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Date: Thu, 21 Jan 2021 07:23:44 +0000
Subject: Re: soft lockups on T5120
Message-Id: <d9e79cfa4b80373e2c54e1358d110335@sf-tec.de>
List-Id: <sparclinux.vger.kernel.org>
References: <65a62b7c6e752dfb1b46624aa579d5e2@sf-tec.de>
In-Reply-To: <65a62b7c6e752dfb1b46624aa579d5e2@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Am 2021-01-13 09:51, schrieb Rolf Eike Beer:
> Every one ine a while my T5120 locks up, i.e. some processes get stuck=20
> forever.
> Starting new screen sessions or logging in via SSH luckily still works,=20
> but I
> can't get it to properly reboot. Sync via sysrq has worked today which=20
> is quite
> nice, but the software RAID still needs rebuild :/
>=20
> This usually happens when I torture the machine with parallel builds
> and testsuites
> when doing package stabilizations for Gentoo.
>=20
> The kernel currently is 5.10.3, but I hit this for quite a while
>=20
> Here is what came out of dmesg today. I found no signs of trouble
> earlier than this:

And here it is again:

[667028.274283] many-headers[40569]: segfault at 0 ip 00000000700007c0=20
(rpc 000000007000073c) sp 00000000ff9eddf8 error 1 in=20
many-headers[70000000+2000]
[671105.790298] rcu: INFO: rcu_sched self-detected stall on CPU
[671105.790512] rcu:    24-....: (2099 ticks this GP)=20
idle=C3a/1/0x4000000000000002 softirq=12392985/12392985 fqs=1033
[671105.790709]         (t!00 jiffies g7879413 qY92)
[671105.790859] * CPU[ 24]: TSTATE[0000000080001601]=20
TPC[000000000040770c] TNPC[0000000000407710] TASK[ctest:50100]
[671105.791083]              TPC[sparc64_realfault_common+0x8/0x20]=20
O7[sparc64_realfault_common+0x10/0x20] I7[0xf76e6e3c]=20
RPC[do_signal+0x1a0/0x560]
[671168.853244] rcu: INFO: rcu_sched self-detected stall on CPU
[671168.853475] rcu:    24-....: (8402 ticks this GP)=20
idle=C3a/1/0x4000000000000002 softirq=12392985/12392985 fqsA00
[671168.853684]         (t=8403 jiffies g7879413 qd804)
[671168.853843] * CPU[ 24]: TSTATE[0000000080001601]=20
TPC[000000000040770c] TNPC[0000000000407710] TASK[ctest:50100]
[671168.854072]              TPC[sparc64_realfault_common+0x8/0x20]=20
O7[sparc64_realfault_common+0x10/0x20] I7[0xf76e6e3c]=20
RPC[do_signal+0x1a0/0x560]
[671231.926163] rcu: INFO: rcu_sched self-detected stall on CPU
[671231.926395] rcu:    24-....: (14706 ticks this GP)=20
idle=C3a/1/0x4000000000000002 softirq=12392985/12392985 fqsg38
[671231.926610]         (t=14707 jiffies g7879413 q=82515)
[671231.926781] * CPU[ 24]: TSTATE[0000000080001602]=20
TPC[0000000000af61e0] TNPC[0000000000af61e4] TASK[ctest:50100]
[671231.927033]              TPC[do_sparc64_fault+0x340/0x820]=20
O7[do_sparc64_fault+0x56c/0x820] I7[sparc64_realfault_common+0x10/0x20]=20
RPC[0xf76e6e3c]
[671277.260094] INFO: task khugepaged:337 blocked for more than 122=20
seconds.
[671277.260277]       Not tainted 5.10.3-gentoo-sparc64 #1
[671277.260399] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=20
disables this message.
[671277.260528] task:khugepaged      state:D stack:    0 pid:  337 ppid:=20
     2 flags:0x01000000
[671277.260666] Call Trace:
[671277.260765] [<0000000000af0ae0>] schedule+0x40/0xe0
[671277.260898] [<0000000000af4018>] schedule_timeout+0x1f8/0x380
[671277.261028] [<0000000000af1c80>] wait_for_completion+0x60/0xc0
[671277.261163] [<000000000047de70>] __flush_work.isra.0+0xf0/0x220
[671277.261234] [<0000000000597954>] lru_add_drain_all+0x1b4/0x240
[671277.261306] [<00000000006052c4>] khugepaged+0x44/0x1e40
[671277.261377] [<0000000000485a04>] kthread+0x104/0x120
[671277.261453] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[671277.261520] [<0000000000000000>] 0x0
[671277.261605] INFO: task md127_raid1:1100 blocked for more than 122=20
seconds.
[671277.261673]       Not tainted 5.10.3-gentoo-sparc64 #1
[671277.261737] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"=20
disables this message.
[671277.261806] task:md127_raid1     state:D stack:    0 pid: 1100 ppid:=20
     2 flags:0x01000000
[671277.261883] Call Trace:
[671277.261939] [<0000000000af0ae0>] schedule+0x40/0xe0
[671277.262018] [<00000000007a3694>]=20
percpu_ref_switch_to_atomic_sync+0x34/0x80
[671277.262097] [<00000000009199e0>] set_in_sync+0x40/0xe0
[671277.262168] [<0000000000928280>] md_check_recovery+0x520/0x5c0
[671277.262242] [<00000000008f17f4>] raid1d+0x14/0x1380
[671277.262313] [<000000000091a54c>] md_thread+0xac/0x1a0
[671277.262382] [<0000000000485a04>] kthread+0x104/0x120
[671277.262453] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
[671277.262519] [<0000000000000000>] 0x0
[671277.262601] INFO: task jbd2/dm-0-8:1208 blocked for more than 122=20
seconds.
[671277.262670]       Not tainted 5.10.3-gentoo-sparc64 #1

and so on.
