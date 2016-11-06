From: Anatoly Pugachev <matorola@gmail.com>
Date: Sun, 06 Nov 2016 11:56:17 +0000
Subject: git kernel (4.9.0-rc3) hard lockup on cpu
Message-Id: <CADxRZqxOUEaPExMNC9E5sUe777CxOsFmzmHC8EcwtHJO2OC5hQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello!

We've got kernel cpu lockup after running for about 3.5 days
(machine/ldom is a buildd instance for debian ports for sparc64 arch).

Kernel is built from git 0c183d92b20b5c84ca655b45ef57b3318b83eb9e

Nov 06 13:17:34 landau kernel: Watchdog detected hard LOCKUP on cpu 1
Nov 06 13:17:34 landau kernel: ------------[ cut here ]------------
Nov 06 13:17:34 landau kernel: WARNING: CPU: 1 PID: 45713 at
arch/sparc/kernel/nmi.c:80 perfctr_irq+0x2ec/0x340
Nov 06 13:17:34 landau kernel: [478B blob data]
Nov 06 13:17:34 landau kernel: CPU: 1 PID: 45713 Comm: llvm-nm Not
tainted 4.9.0-rc3+ #1
Nov 06 13:17:34 landau kernel: Call Trace:
Nov 06 13:17:34 landau kernel:  [00000000004670a0] __warn+0xc0/0xe0
Nov 06 13:17:34 landau kernel:  [00000000004670f4] warn_slowpath_fmt+0x34/0x60
Nov 06 13:17:34 landau kernel:  [00000000009943ec] perfctr_irq+0x2ec/0x340
Nov 06 13:17:34 landau kernel:  [00000000004209f4] tl0_irq15+0x14/0x20
Nov 06 13:17:34 landau kernel:  [0000000000993afc]
_raw_spin_lock_irqsave+0x1c/0x40
Nov 06 13:17:34 landau kernel:  [000000000057cd08] pagevec_lru_move_fn+0x68/0xe0
Nov 06 13:17:34 landau kernel:  [000000000057e0f0] lru_add_drain_cpu+0x110/0x120
Nov 06 13:17:34 landau kernel:  [000000000057e38c] lru_add_drain+0xc/0x20
Nov 06 13:17:34 landau kernel:  [00000000005a8bb8] unmap_region+0x18/0xc0
Nov 06 13:17:34 landau kernel:  [00000000005aa7c4] do_munmap+0x1e4/0x380
Nov 06 13:17:34 landau kernel:  [00000000005ab9d0] mmap_region+0xf0/0x5a0
Nov 06 13:17:34 landau kernel:  [00000000005ac1f4] do_mmap+0x374/0x400
Nov 06 13:17:34 landau kernel:  [000000000058e1a0] vm_mmap_pgoff+0x60/0xa0
Nov 06 13:17:34 landau kernel:  [00000000005a9f64] SyS_mmap_pgoff+0xa4/0x240
Nov 06 13:17:34 landau kernel:  [000000000042efd4] SyS_mmap+0x54/0x80
Nov 06 13:17:34 landau kernel:  [00000000004061f4] linux_sparc_syscall+0x34/0x44
Nov 06 13:17:34 landau kernel: ---[ end trace 9fdbc358eb6eb335 ]---
