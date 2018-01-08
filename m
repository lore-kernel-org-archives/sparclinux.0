From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 08 Jan 2018 04:06:44 +0000
Subject: sparc64 crashes in -next due to 'mm/vmalloc.c: replace opencoded 4-level page walkers'
Message-Id: <20180108040644.GA5972@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Commit 'mm/vmalloc.c: replace opencoded 4-level page walkers' in -next is
supposed to fix a sparc64 crash (or at least that is how I interpret the
commit log). Unfortunately, it actually causes sparc64 images to crash
reliably, at least in my qemu tests.

...
[    1.922450] Calibrating delay using timer specific routine.. 202.24 BogoMIPS (lpj11216)
[    1.923169] pid_max: default: 32768 minimum: 301
[    1.926342] kernel BUG at mm/memory.c:2169!
[    1.927056]               \|/ ____ \|/
[    1.927056]               "@'/ .. \`@"
[    1.927056]               /_| \__/ |_\
[    1.927056]                  \__U_/
[    1.927781] swapper/0(0): Kernel bad sw trap 5 [#1]
[    1.928531] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.0-rc6-next-20180105 #1
[    1.929241] TSTATE: 0000004480001605 TPC: 0000000000561c18 TNPC: 0000000000561c1c Y: 0000242f    Not tainted
[    1.930302] TPC: <apply_to_page_range+0x358/0x420>
[    1.930904] g0: fffff8001f812970 g1: 0000000001127178 g2: 0000000001127178 g3: 0000000000000001
[    1.931527] g4: 0000000001114300 g5: fffff8001e5e8000 g6: 0000000000b04000 g7: 000000000000000e
[    1.932143] o0: 000000000000001f o1: 0000000000a7dec8 o2: 0000000000000879 o3: 000000000116d400
[    1.932871] o4: 0000000000000000 o5: 0000000000a7dec8 sp: 0000000000b070e1 ret_pc: 0000000000561c10
[    1.933563] RPC: <apply_to_page_range+0x350/0x420>
[    1.934238] l0: 0000000000000000 l1: 0000000000002000 l2: fffff8001c10b000 l3: 0000000100080000
[    1.934894] l4: 0000000001381b30 l5: 0000080000000000 l6: 0000000100000000 l7: 000000000116d640
[    1.935512] i0: 000000000116d640 i1: fffffffffffffff4 i2: 0000000100080000 i3: 0000000000570100
[    1.936118] i4: 0000000000b07a88 i5: fffff8001c10c000 i6: 0000000000b071d1 i7: 00000000005705e0
[    1.936807] I7: <vmap_page_range_noflush+0x40/0x80>
[    1.937463] Call Trace:
[    1.938121]  [00000000005705e0] vmap_page_range_noflush+0x40/0x80
[    1.938786]  [0000000000570650] map_vm_area+0x30/0x60
[    1.939352]  [0000000000571444] __vmalloc_node_range+0x144/0x280
[    1.939916]  [00000000005715b0] __vmalloc+0x30/0x40
[    1.940531]  [00000000011d9888] alloc_large_system_hash+0x1f4/0x2e8
[    1.941169]  [00000000011e0cdc] vfs_caches_init+0xa0/0xe0
[    1.941788]  [00000000011c4a08] start_kernel+0x40c/0x44c
[    1.942464]  [0000000000990fc0] tlb_fixup_done+0x4c/0x6c
[    1.943713]  [00000000ffd0e444] 0xffd0e444
[    1.945067] Disabling lock debugging due to kernel taint
[    1.946405] Caller[00000000005705e0]: vmap_page_range_noflush+0x40/0x80
[    1.947770] Caller[0000000000570650]: map_vm_area+0x30/0x60
[    1.948910] Caller[0000000000571444]: __vmalloc_node_range+0x144/0x280
[    1.950058] Caller[00000000005715b0]: __vmalloc+0x30/0x40
[    1.951135] Caller[00000000011d9888]: alloc_large_system_hash+0x1f4/0x2e8
[    1.952149] Caller[00000000011e0cdc]: vfs_caches_init+0xa0/0xe0
[    1.953143] Caller[00000000011c4a08]: start_kernel+0x40c/0x44c
[    1.954209] Caller[0000000000990fc0]: tlb_fixup_done+0x4c/0x6c
[    1.955171] Caller[00000000ffd0e444]: 0xffd0e444
[    1.955892] Instruction DUMP:
[    1.955982]  110029f7 
[    1.956609]  7ffb193c 
[    1.957184]  901222c8 
[    1.957763] <91d02005>
[    1.958392]  ce5fa7d7 
[    1.958922]  c25fa7df 
[    1.959447]  8e01e008 
[    1.959961]  80a08001 
[    1.960519]  02600026 
[    1.961107] 
[    1.962412] Kernel panic - not syncing: Attempted to kill the idle task!

Bisect log is attached. Everything is fine after reverting the commit.

Hmmm .. where does the reference to an e-mail from me in the offending
commit come from ? Puzzled.

Guenter

---
# bad: [990b6a07d18cb30a66db3d18ab7d953806237e6a] Add linux-next specific files for 20180105
# good: [30a7acd573899fd8b8ac39236eff6468b195ac7d] Linux 4.15-rc6
git bisect start 'HEAD' 'v4.15-rc6'
# good: [4411e1d8bfc93afafc74548669d772750432e0b7] Merge remote-tracking branch 'crypto/master'
git bisect good 4411e1d8bfc93afafc74548669d772750432e0b7
# good: [fcdad798ac60727fc0a90c36815d19b1629e45a4] Merge remote-tracking branch 'devicetree/for-next'
git bisect good fcdad798ac60727fc0a90c36815d19b1629e45a4
# good: [fe14c29e6d6772e5fc7bb8dc7a7568ce6a887a8e] Merge remote-tracking branch 'staging/staging-next'
git bisect good fe14c29e6d6772e5fc7bb8dc7a7568ce6a887a8e
# good: [b8be2479df7dda35d0d73fafa3f1d9c95c6a89b6] Merge remote-tracking branch 'gpio/for-next'
git bisect good b8be2479df7dda35d0d73fafa3f1d9c95c6a89b6
# bad: [76248405844bf17c0620aea2f0e5bb751fc680b3] lib/stackdepot.c: use a non-instrumented version of memcmp()
git bisect bad 76248405844bf17c0620aea2f0e5bb751fc680b3
# good: [b852120f0251533f414c35396f151d2ddd4d3bde] mm: get 7% more pages in a pagevec
git bisect good b852120f0251533f414c35396f151d2ddd4d3bde
# bad: [2b7030305a472bd15268818282e37818eec2386b] userfaultfd: convert to use anon_inode_getfd()
git bisect bad 2b7030305a472bd15268818282e37818eec2386b
# good: [b7ebb7ed4b3c8ed9fac1ccb0f32ff3e94e697176] mm, mmu_notifier: annotate mmu notifiers with blockable invalidate callbacks
git bisect good b7ebb7ed4b3c8ed9fac1ccb0f32ff3e94e697176
# bad: [e8d5e9399961eeb8132d1424388177b2fb39d45c] mm-store-compound_dtor-compound_order-as-bytes-fix
git bisect bad e8d5e9399961eeb8132d1424388177b2fb39d45c
# bad: [db5b1040f112876cd727fcba462425c7777044bc] mm: align struct page more aesthetically
git bisect bad db5b1040f112876cd727fcba462425c7777044bc
# good: [ca5d231374d5a9c7c24ab4d40b553f12523df0ff] mm/zsmalloc: simplify shrinker init/destroy
git bisect good ca5d231374d5a9c7c24ab4d40b553f12523df0ff
# bad: [32534d21c2cd1c56e3b0eff16cd6c1bf0bcbe32e] mm/vmalloc.c: replace opencoded 4-level page walkers
git bisect bad 32534d21c2cd1c56e3b0eff16cd6c1bf0bcbe32e
# good: [39a80506addfe8bfb0f510dd00052816a861cbc5] mm-zsmalloc-simplify-shrinker-init-destroy-fix
git bisect good 39a80506addfe8bfb0f510dd00052816a861cbc5
# first bad commit: [32534d21c2cd1c56e3b0eff16cd6c1bf0bcbe32e] mm/vmalloc.c: replace opencoded 4-level page walkers
