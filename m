From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 28 Oct 2016 17:18:25 +0000
Subject: Crash in -next due to 'mm/vmalloc: replace opencoded 4-level page walkers'
Message-Id: <20161028171825.GA15116@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>, Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org

Hi,

when running sparc64 images in qemu, I see the following crash.
This is with next-20161028.

[    2.530785] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,max_idle_ns: 19112604462750000 ns
[    2.532359] kernel BUG at mm/memory.c:1881!
[    2.532798]               \|/ ____ \|/
[    2.532798]               "@'/ .. \`@"
[    2.532798]               /_| \__/ |_\
[    2.532798]                  \__U_/
[    2.533250] swapper(1): Kernel bad sw trap 5 [#1]
[    2.533705] CPU: 0 PID: 1 Comm: swapper Not tainted 4.9.0-rc2+ #1
[    2.534129] task: fffff8001f0af620 task.stack: fffff8001f0b0000
[    2.534505] TSTATE: 0000004480001605 TPC: 00000000005124d8 TNPC: 00000000005124dc Y: 00000035    Not tainted
[    2.535112] TPC: <apply_to_page_range+0x2f8/0x3a0>
[    2.535469] g0: 00000000009b1548 g1: 0000000000a4a990 g2: 0000000000a4a990 g3: 0000000000b37694
[    2.535857] g4: fffff8001f0af620 g5: 0000000000000000 g6: fffff8001f0b0000 g7: 0000000000000000
[    2.536236] o0: 000000000000001f o1: 00000000009ac2c0 o2: 0000000000000759 o3: 0000000000122000
[    2.536695] o4: 0000000000000000 o5: 00000000009ac2c0 sp: fffff8001f0b2d61 ret_pc: 00000000005124d0
[    2.537086] RPC: <apply_to_page_range+0x2f0/0x3a0>
[    2.537454] l0: 0000000000000000 l1: 0000000000002000 l2: fffff8001f10b000 l3: 0000000100002000
[    2.537843] l4: 0000000000aef910 l5: 0000000000a5e7e8 l6: 0000000100001fff l7: ffffffffff800000
[    2.538229] i0: 0000000000a5e7e8 i1: 0000000100000000 i2: 0000000100002000 i3: 000000000051e5e0
[    2.538613] i4: fffff8001f0b3708 i5: fffff8001f10c000 i6: fffff8001f0b2e51 i7: 000000000051e8e0
[    2.539007] I7: <vmap_page_range_noflush+0x40/0x80>
[    2.539387] Call Trace:
[    2.539765]  [000000000051e8e0] vmap_page_range_noflush+0x40/0x80
[    2.540139]  [000000000051e970] map_vm_area+0x50/0x80
[    2.540492]  [000000000051f84c] __vmalloc_node_range+0x14c/0x260
[    2.540848]  [000000000051f98c] __vmalloc_node+0x2c/0x40
[    2.541198]  [00000000004d39cc] bpf_prog_alloc+0x2c/0xa0
[    2.541554]  [00000000008129bc] bpf_prog_create+0x3c/0xa0
[    2.541916]  [0000000000adb21c] ptp_classifier_init+0x20/0x4c
[    2.542271]  [0000000000ad9808] sock_init+0x90/0xa0
[    2.542622]  [0000000000426cb0] do_one_initcall+0x30/0x160
[    2.542978]  [0000000000aaeaec] kernel_init_freeable+0x10c/0x1b0
[    2.543332]  [00000000008e3324] kernel_init+0x4/0x100
[    2.543681]  [0000000000405f04] ret_from_fork+0x1c/0x2c

Bisect points to commit 0c79e3331f08 ("mm/vmalloc: replace opencoded 4-level
page walkers"). Reverting this patch fixes the problem.

Bisect log is attached.

Complete log is at:
http://kerneltests.org/builders/qemu-sparc64-next/builds/521/steps/qemubuildcommand/logs/stdio

Scripts to run the tests are at:
https://github.com/groeck/linux-build-test/tree/master/rootfs/sparc64

Guenter

---
# bad: [fee425e048137e29a84b762593886a6c038585fc] Add linux-next specific files for 20161028
# good: [07d9a380680d1c0eb51ef87ff2eab5c994949e69] Linux 4.9-rc2
git bisect start 'HEAD' 'v4.9-rc2'
# good: [13910a183196627add2dac54be41b487014cdce9] Merge remote-tracking branch 'drm/drm-next'
git bisect good 13910a183196627add2dac54be41b487014cdce9
# good: [46146052037ed1f31a3d10740644df959ac86818] Merge remote-tracking branch 'phy-next/next'
git bisect good 46146052037ed1f31a3d10740644df959ac86818
# good: [cf8e732b54b6250086c6bbef22a97e423f90c8f4] staging: bcm2708_vchiq: remove .owner field for driver
git bisect good cf8e732b54b6250086c6bbef22a97e423f90c8f4
# good: [8045588cdbaa627745e1d2af3cad8824196c8ee0] Merge remote-tracking branch 'scsi/for-next'
git bisect good 8045588cdbaa627745e1d2af3cad8824196c8ee0
# bad: [61844692f80b538daa56501c18b1548b377ff2c5] ipc/sem: use proper list api for pending_list wakeups
git bisect bad 61844692f80b538daa56501c18b1548b377ff2c5
# bad: [d74d4836623b156a8d9c8a13b11138d472257b1a] shmem: avoid maybe-uninitialized warning
git bisect bad d74d4836623b156a8d9c8a13b11138d472257b1a
# good: [30dd9d69a7c3749bd68486bf87028fb5ec8a09c8] ocfs2/dlm: clean up useless BUG_ON default case in dlm_finalize_reco_handler()
git bisect good 30dd9d69a7c3749bd68486bf87028fb5ec8a09c8
# good: [355302f5e0b292fa8a2deaabe86a6be28255814d] mm/hugetlb.c: use huge_pte_lock instead of opencoding the lock
git bisect good 355302f5e0b292fa8a2deaabe86a6be28255814d
# bad: [e953ab891cb5e181dc441ac47340ece8fbe61121] mm: make unreserve highatomic functions reliable
git bisect bad e953ab891cb5e181dc441ac47340ece8fbe61121
# bad: [0c79e3331f087a44b1747464f55615b76126618b] mm/vmalloc: replace opencoded 4-level page walkers
git bisect bad 0c79e3331f087a44b1747464f55615b76126618b
# good: [4b43155b994ba7454a9615501cd14393278e9847] kmemleak: fix reference to Documentation
git bisect good 4b43155b994ba7454a9615501cd14393278e9847
# first bad commit: [0c79e3331f087a44b1747464f55615b76126618b] mm/vmalloc: replace opencoded 4-level page walkers
