From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 02 Aug 2015 03:02:20 +0000
Subject: Build failure (sparc32:allmodconfig) in -next due to 'memcg: export struct mem_cgroup'
Message-Id: <20150802030220.GA25165@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Hocko <mhocko@suse.cz>
Cc: Vladimir Davydov <vdavydov@parallels.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Hi,

Commit b65390c6c2178f ("memcg: export struct mem_cgroup") causes several
build failures in -next (next-20150731) when trying to build
sparc32:allmodconfig.

Below are some of the errors, as well as a bisect log.

Guenter

---
In file included from include/linux/pid_namespace.h:6:0,
                 from include/linux/ptrace.h:8,
                 from include/linux/ftrace.h:13,
                 from include/linux/init_task.h:8,
                 from init/init_task.c:1:
include/linux/mm.h: At top level:
include/linux/mm.h:888:7: error: conflicting types for 'page_address'
./arch/sparc/include/asm/highmem.h:59:10: note: previous implicit declaration of 'page_address' was here

In file included from include/linux/highmem.h:7:0,
                 from include/linux/bio.h:23,
                 from include/linux/writeback.h:192,
                 from include/linux/memcontrol.h:30,
                 from include/linux/swap.h:8,
                 from ./arch/sparc/include/asm/pgtable_32.h:17,
                 from ./arch/sparc/include/asm/pgtable.h:6,
                 from arch/sparc/kernel/traps_32.c:23:
include/linux/mm.h: In function 'is_vmalloc_addr':
include/linux/mm.h:371:17: error: 'VMALLOC_START' undeclared (first use in this function)
include/linux/mm.h:371:17: note: each undeclared identifier is reported only once for each function it appears in
include/linux/mm.h:371:41: error: 'VMALLOC_END' undeclared (first use in this function)
include/linux/mm.h: In function 'maybe_mkwrite':
include/linux/mm.h:556:3: error: implicit declaration of function 'pte_mkwrite'

In file included from include/linux/highmem.h:7:0,
                 from include/linux/bio.h:23,
                 from include/linux/writeback.h:192,
                 from include/linux/memcontrol.h:30,
                 from include/linux/swap.h:8,
                 from ./arch/sparc/include/asm/pgtable_32.h:17,
                 from ./arch/sparc/include/asm/pgtable.h:6,
                 from ./arch/sparc/include/asm/pgalloc_32.h:8,
                 from ./arch/sparc/include/asm/pgalloc.h:6,
                 from arch/sparc/kernel/sun4m_irq.c:16:
include/linux/mm.h: In function 'pte_lockptr':
include/linux/mm.h:1422:2: error: implicit declaration of function 'pmd_page' [-Werror=implicit-function-declaration]
include/linux/mm.h:1422:2: error: passing argument 1 of 'ptlock_ptr' makes pointer from integer without a cast [-Werror]
include/linux/mm.h:1396:27: note: expected 'struct page *' but argument is of type 'int'
include/linux/mm.h: In function 'pgtable_init':
include/linux/mm.h:1465:2: error: implicit declaration of function 'pgtable_cache_init'

---

Bisect log:

# bad: [37bd1ea52d362219b1882814cb75bb365736890f] Add linux-next specific files for 20150731
# good: [cbfe8fa6cd672011c755c3cd85c9ffd4e2d10a6f] Linux 4.2-rc4
git bisect start 'HEAD' 'v4.2-rc4'
# good: [dee8e3fb6da725af9f6576203043e28e1fc24112] Merge remote-tracking branch 'drm/drm-next'
git bisect good dee8e3fb6da725af9f6576203043e28e1fc24112
# good: [18e555796935152bb99fba6225e119e334e46e0b] Merge remote-tracking branch 'usb-serial/usb-next'
git bisect good 18e555796935152bb99fba6225e119e334e46e0b
# good: [d130dd99924fd8bd36a2d6469fb4650555885674] Merge remote-tracking branch 'pinctrl/for-next'
git bisect good d130dd99924fd8bd36a2d6469fb4650555885674
# bad: [0fc5899188276020bf18bbd081adb8d904f19c36] lib: Add CRC64 ECMA module
git bisect bad 0fc5899188276020bf18bbd081adb8d904f19c36
# good: [0ce35077894da68fe4b428239ba78565a85f873a] ext4: huge page fault support
git bisect good 0ce35077894da68fe4b428239ba78565a85f873a
# bad: [ab75dc42ab76dc589ba9ebc3ac4559bf16ad9b9e] hwpoison: use page_cgroup_ino for filtering by memcg
git bisect bad ab75dc42ab76dc589ba9ebc3ac4559bf16ad9b9e
# bad: [4ae161e1a34b0251fdcad1f1200e4aa024bf15a1] mm-page_isolation-remove-bogus-tests-for-isolated-pages-fix
git bisect bad 4ae161e1a34b0251fdcad1f1200e4aa024bf15a1
# good: [2f2a822d1ade8faed5d5faa36f7ce672d8032560] fs: do not prefault sys_write() user buffer pages
git bisect good 2f2a822d1ade8faed5d5faa36f7ce672d8032560
# good: [7e6c8c501cc9e471227ce852a8214c9653a9a93e] mm/dmapool: allow NULL `pool' pointer in dma_pool_destroy()
git bisect good 7e6c8c501cc9e471227ce852a8214c9653a9a93e
# bad: [f1a893781a72f9b8dffe98fc73e57949497a1e0f] memcg: get rid of extern for functions in memcontrol.h
git bisect bad f1a893781a72f9b8dffe98fc73e57949497a1e0f
# bad: [1b9131b73abd4324ea3f6b8005a1b586a0c44a5f] memcg-export-struct-mem_cgroup-fix
git bisect bad 1b9131b73abd4324ea3f6b8005a1b586a0c44a5f
# bad: [b65390c6c2178f51faa396a6b2f1d64ebbd3c373] memcg: export struct mem_cgroup
git bisect bad b65390c6c2178f51faa396a6b2f1d64ebbd3c373
# first bad commit: [b65390c6c2178f51faa396a6b2f1d64ebbd3c373] memcg: export struct mem_cgroup
