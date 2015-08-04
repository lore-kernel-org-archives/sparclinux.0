From: Michal Hocko <mhocko@kernel.org>
Date: Tue, 04 Aug 2015 14:25:52 +0000
Subject: [PATCH] sparc32: do not include swap.h from pgtable_32.h export struct mem_cgroup'
Message-Id: <20150804142552.GI28571@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20150802030220.GA25165@roeck-us.net>
In-Reply-To: <20150802030220.GA25165@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Vladimir Davydov <vdavydov@parallels.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On Sat 01-08-15 20:02:20, Guenter Roeck wrote:
> Hi,
> 
> Commit b65390c6c2178f ("memcg: export struct mem_cgroup") causes several
> build failures in -next (next-20150731) when trying to build
> sparc32:allmodconfig.
> 
> Below are some of the errors, as well as a bisect log.

The following patch should take care of the mess. I've tested it with
all{no,mod}config and defconfig. allyesconfig fails due to unrelated issue but
make mm/ succeeds.
---
From 3ca0dfa93b1418bcb9a8dc2860bf93f095f72399 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Tue, 4 Aug 2015 14:31:28 +0200
Subject: [PATCH] sparc32: do not include swap.h from pgtable_32.h

"memcg: export struct mem_cgroup" has added few includes into linux/memcontro.h
which led to further header dependency issues as reported by Guenter Roeck:

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

The issue is that pgtable_32.h depends on swap.h to get swap_entry_t but
that goes all the way down to linux/mm.h which wants to have VMALLOC_*
which is defined later in pgtable_32.h, though.

swap_entry_t is defined in include/mm_types.h so it should be sufficient
to include this header without more dependencies.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/sparc/include/asm/pgtable_32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index f06b36a00a3b..91b963a887b7 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -14,7 +14,7 @@
 #include <asm-generic/4level-fixup.h>
 
 #include <linux/spinlock.h>
-#include <linux/swap.h>
+#include <linux/mm_types.h>
 #include <asm/types.h>
 #include <asm/pgtsrmmu.h>
 #include <asm/vaddrs.h>
-- 
2.1.4

-- 
Michal Hocko
SUSE Labs
