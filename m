From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 07 Nov 2016 12:11:22 +0000
Subject: Re: git kernel (4.9.0-rc3) hard lockup on cpu
Message-Id: <CADxRZqyq4gJ9M0HZ74tZG9bXjCBjOA=QmJ-8GUVhaz-ncmpLiw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqxOUEaPExMNC9E5sUe777CxOsFmzmHC8EcwtHJO2OC5hQ@mail.gmail.com>
In-Reply-To: <CADxRZqxOUEaPExMNC9E5sUe777CxOsFmzmHC8EcwtHJO2OC5hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Nov 6, 2016 at 2:56 PM, Anatoly Pugachev <matorola@gmail.com> wrote:
> Hello!
>
> We've got kernel cpu lockup after running for about 3.5 days
> (machine/ldom is a buildd instance for debian ports for sparc64 arch).
>
> Kernel is built from git 0c183d92b20b5c84ca655b45ef57b3318b83eb9e
>
> Nov 06 13:17:34 landau kernel: Watchdog detected hard LOCKUP on cpu 1
> Nov 06 13:17:34 landau kernel: ------------[ cut here ]------------
> Nov 06 13:17:34 landau kernel: WARNING: CPU: 1 PID: 45713 at
> arch/sparc/kernel/nmi.c:80 perfctr_irq+0x2ec/0x340
> Nov 06 13:17:34 landau kernel: [478B blob data]
> Nov 06 13:17:34 landau kernel: CPU: 1 PID: 45713 Comm: llvm-nm Not
> tainted 4.9.0-rc3+ #1
> Nov 06 13:17:34 landau kernel: Call Trace:
> Nov 06 13:17:34 landau kernel:  [00000000004670a0] __warn+0xc0/0xe0
> Nov 06 13:17:34 landau kernel:  [00000000004670f4] warn_slowpath_fmt+0x34/0x60
> Nov 06 13:17:34 landau kernel:  [00000000009943ec] perfctr_irq+0x2ec/0x340
> Nov 06 13:17:34 landau kernel:  [00000000004209f4] tl0_irq15+0x14/0x20
> Nov 06 13:17:34 landau kernel:  [0000000000993afc]
> _raw_spin_lock_irqsave+0x1c/0x40
> Nov 06 13:17:34 landau kernel:  [000000000057cd08] pagevec_lru_move_fn+0x68/0xe0
> Nov 06 13:17:34 landau kernel:  [000000000057e0f0] lru_add_drain_cpu+0x110/0x120
> Nov 06 13:17:34 landau kernel:  [000000000057e38c] lru_add_drain+0xc/0x20
> Nov 06 13:17:34 landau kernel:  [00000000005a8bb8] unmap_region+0x18/0xc0
> Nov 06 13:17:34 landau kernel:  [00000000005aa7c4] do_munmap+0x1e4/0x380
> Nov 06 13:17:34 landau kernel:  [00000000005ab9d0] mmap_region+0xf0/0x5a0
> Nov 06 13:17:34 landau kernel:  [00000000005ac1f4] do_mmap+0x374/0x400
> Nov 06 13:17:34 landau kernel:  [000000000058e1a0] vm_mmap_pgoff+0x60/0xa0
> Nov 06 13:17:34 landau kernel:  [00000000005a9f64] SyS_mmap_pgoff+0xa4/0x240
> Nov 06 13:17:34 landau kernel:  [000000000042efd4] SyS_mmap+0x54/0x80
> Nov 06 13:17:34 landau kernel:  [00000000004061f4] linux_sparc_syscall+0x34/0x44
> Nov 06 13:17:34 landau kernel: ---[ end trace 9fdbc358eb6eb335 ]---

another one:

Nov 07 09:01:32 landau: INFO: task kworker/42:2:239256 blocked for
more than 120 seconds.
Nov 07 09:01:32 landau:       Not tainted 4.9.0-rc3+ #1
Nov 07 09:01:32 landau: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Nov 07 09:01:32 landau: kworker/42:2    D 0000000000992e70     0
239256      2 0x07000000
Nov 07 09:01:32 landau: Workqueue: cgroup_destroy css_free_work_fn
Nov 07 09:01:32 landau: Call Trace:
Nov 07 09:01:32 landau:  [0000000000990304] schedule+0x24/0xa0
Nov 07 09:01:32 landau:  [0000000000992e70] schedule_timeout+0x210/0x360
Nov 07 09:01:32 landau:  [0000000000990d74] wait_for_common+0x94/0x140
Nov 07 09:01:32 landau:  [0000000000990e38] wait_for_completion+0x18/0x40
Nov 07 09:01:32 landau:  [00000000004cefb4] _rcu_barrier+0x194/0x1e0
Nov 07 09:01:32 landau:  [00000000004cf030] rcu_barrier+0x10/0x20
Nov 07 09:01:32 landau:  [0000000000597734] release_caches+0x54/0x80
Nov 07 09:01:32 landau:  [00000000005977f4] memcg_destroy_kmem_caches+0x94/0xe0
Nov 07 09:01:32 landau:  [00000000005dbfe0] mem_cgroup_css_free+0xe0/0x140
Nov 07 09:01:32 landau:  [00000000004fd9b4] css_free_work_fn+0x34/0x420
Nov 07 09:01:32 landau:  [000000000048172c] process_one_work+0x16c/0x460
Nov 07 09:01:32 landau:  [0000000000481b40] worker_thread+0x120/0x520
Nov 07 09:01:32 landau:  [000000000048804c] kthread+0xac/0xe0
Nov 07 09:01:32 landau:  [0000000000406044] ret_from_fork+0x1c/0x2c
Nov 07 09:01:32 landau:  [0000000000000000]           (null)
Nov 07 09:02:38 landau: Watchdog detected hard LOCKUP on cpu 25
Nov 07 09:02:38 landau: ------------[ cut here ]------------
Nov 07 09:02:38 landau: WARNING: CPU: 25 PID: 245304 at
arch/sparc/kernel/nmi.c:80 perfctr_irq+0x2ec/0x340
Nov 07 09:02:38 landau: [478B blob data]
Nov 07 09:02:38 landau: CPU: 25 PID: 245304 Comm: cc1 Not tainted 4.9.0-rc3+ #1
Nov 07 09:02:38 landau: Call Trace:
Nov 07 09:02:38 landau:  [00000000004670a0] __warn+0xc0/0xe0
Nov 07 09:02:38 landau:  [00000000004670f4] warn_slowpath_fmt+0x34/0x60
Nov 07 09:02:38 landau:  [00000000009943ec] perfctr_irq+0x2ec/0x340
Nov 07 09:02:38 landau:  [00000000004209f4] tl0_irq15+0x14/0x20
Nov 07 09:02:38 landau: ---[ end trace ef8661be81a54612 ]---
