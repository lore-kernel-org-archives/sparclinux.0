From: Anatoly Pugachev <matorola@gmail.com>
Date: Thu, 10 Sep 2020 11:43:13 +0000
Subject: [sparc64] kernel OOPS bisected from "lockdep: improve current->(hard|soft)irqs_enabled synchronisati
Message-Id: <CADxRZqwGH3c5SvByBB3WSQhR_0NLCY=3RZ6541m8afX-scA4HA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sparc kernel list <sparclinux@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>

Hello!

The following git patch 044d0d6de9f50192f9697583504a382347ee95ca
(linux git master branch) introduced the following kernel OOPS upon
kernel boot on my sparc64 T5-2 ldom (VM):

$ uname -a
Linux ttip 5.9.0-rc2-00011-g044d0d6de9f5 #59 SMP Thu Sep 10 13:07:45
MSK 2020 sparc64 GNU/Linux

(OOPS is from the latest tag, but the same on commit above)
...
rcu: Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:4875 check_flags+0x9c/0x2c0
DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc4 #36
Call Trace:
[<00000000004727a8>] __warn+0xa8/0x120
[<0000000000472c10>] warn_slowpath_fmt+0x64/0x74
[<00000000004e859c>] check_flags+0x9c/0x2c0
[<0000000000c17ca0>] lock_is_held_type+0x20/0x140
[<00000000005095f4>] rcu_read_lock_sched_held+0x54/0xa0
[<00000000004ed4c0>] lock_acquire+0x120/0x480
[<0000000000c21610>] _raw_spin_lock+0x30/0x60
[<00000000009b9bdc>] p1275_cmd_direct+0x1c/0x60
[<00000000009b9ab0>] prom_startcpu_cpuid+0x30/0x40
[<00000000004427e4>] __cpu_up+0x184/0x3a0
[<0000000000474600>] bringup_cpu+0x20/0x120
[<000000000047378c>] cpuhp_invoke_callback+0xec/0x340
[<00000000004753d4>] cpu_up+0x154/0x220
[<0000000000475c60>] bringup_nonboot_cpus+0x60/0xa0
[<0000000000fbc338>] smp_init+0x28/0xa0
[<0000000000fad3b4>] kernel_init_freeable+0x18c/0x300
irq event stamp: 5135
hardirqs last  enabled at (5135): [<0000000000c21a28>]
_raw_spin_unlock_irqrestore+0x28/0x60
hardirqs last disabled at (5134): [<0000000000c217e0>]
_raw_spin_lock_irqsave+0x20/0x80
softirqs last  enabled at (1474): [<0000000000c245a0>] __do_softirq+0x4e0/0x560
softirqs last disabled at (1467): [<000000000042d394>]
do_softirq_own_stack+0x34/0x60
random: get_random_bytes called from __warn+0xc8/0x120 with crng_init=0
---[ end trace 4cf960ae85148e2e ]---
possible reason: unannotated irqs-off.
irq event stamp: 5135
hardirqs last  enabled at (5135): [<0000000000c21a28>]
_raw_spin_unlock_irqrestore+0x28/0x60
hardirqs last disabled at (5134): [<0000000000c217e0>]
_raw_spin_lock_irqsave+0x20/0x80
softirqs last  enabled at (1474): [<0000000000c245a0>] __do_softirq+0x4e0/0x560
softirqs last disabled at (1467): [<000000000042d394>]
do_softirq_own_stack+0x34/0x60
smp: Brought up 1 node, 32 CPUs
devtmpfs: initialized
...

full boot log in [1], kernel config in [2]

linux-2.6$ git bisect log
git bisect start
# good: [d012a7190fc1fd72ed48911e77ca97ba4521bccd] Linux 5.9-rc2
git bisect good d012a7190fc1fd72ed48911e77ca97ba4521bccd
# bad: [34d4ddd359dbcdf6c5fb3f85a179243d7a1cb7f8] Merge tag
'linux-kselftest-5.9-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
git bisect bad 34d4ddd359dbcdf6c5fb3f85a179243d7a1cb7f8
# bad: [e1d0126ca3a66c284a02b083a42e2b39558002cd] Merge tag
'xfs-5.9-fixes-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect bad e1d0126ca3a66c284a02b083a42e2b39558002cd
# good: [24148d8648e37f8c15bedddfa50d14a31a0582c5] Merge tag
'io_uring-5.9-2020-08-28' of git://git.kernel.dk/linux-block
git bisect good 24148d8648e37f8c15bedddfa50d14a31a0582c5
# bad: [b69bea8a657b681442765b06be92a2607b1bd875] Merge tag
'locking-urgent-2020-08-30' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad b69bea8a657b681442765b06be92a2607b1bd875
# good: [20934c0de13b49a072fb1e0ca79fe0fe0e40eae5] usb: storage: Add
unusual_uas entry for Sony PSZ drives
git bisect good 20934c0de13b49a072fb1e0ca79fe0fe0e40eae5
# good: [c4011283a7d5d64a50991dd3baa9acdf3d49092c] Merge tag
'dma-mapping-5.9-2' of git://git.infradead.org/users/hch/dma-mapping
git bisect good c4011283a7d5d64a50991dd3baa9acdf3d49092c
# good: [8bb5021cc2ee5d5dd129a9f2f5ad2bb76eea297d] Merge tag
'powerpc-5.9-4' of
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good 8bb5021cc2ee5d5dd129a9f2f5ad2bb76eea297d
# good: [00b0ed2d4997af6d0a93edef820386951fd66d94] locking/lockdep: Cleanup
git bisect good 00b0ed2d4997af6d0a93edef820386951fd66d94
# bad: [044d0d6de9f50192f9697583504a382347ee95ca] lockdep: Only trace IRQ edges
git bisect bad 044d0d6de9f50192f9697583504a382347ee95ca
# good: [021c109330ebc1f54b546c63a078ea3c31356ecb] arm64: Implement
arch_irqs_disabled()
git bisect good 021c109330ebc1f54b546c63a078ea3c31356ecb
# good: [99dc56feb7932020502d40107a712fa302b32082] mips: Implement
arch_irqs_disabled()
git bisect good 99dc56feb7932020502d40107a712fa302b32082
# first bad commit: [044d0d6de9f50192f9697583504a382347ee95ca]
lockdep: Only trace IRQ edges


1. https://github.com/mator/sparc64-dmesg/blob/master/dmesg-5.9.0-rc4
2. https://github.com/mator/sparc64-dmesg/blob/master/config-5.9.0-rc4.gz
