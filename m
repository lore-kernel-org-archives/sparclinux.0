From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 12 Jan 2021 17:01:37 +0000
Subject: [patch 1/4] sparc/mm/highmem: Flush cache and TLB
Message-Id: <20210112170410.905976187@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20210112170136.078559026@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andreas Larsson <andreas@gaisler.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org

The recent conversion to the generic kmap_local infrastructure failed to
assign the proper pre/post map/unmap flush operations for sparc.

Sparc requires cache flush before map/unmap and tlb flush afterwards.

Fixes: 3293efa97807 ("sparc/mm/highmem: Switch to generic kmap atomic")
Reported-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/highmem.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/arch/sparc/include/asm/highmem.h
+++ b/arch/sparc/include/asm/highmem.h
@@ -50,10 +50,11 @@ extern pte_t *pkmap_page_table;
 
 #define flush_cache_kmaps()	flush_cache_all()
 
-/* FIXME: Use __flush_tlb_one(vaddr) instead of flush_cache_all() -- Anton */
-#define arch_kmap_local_post_map(vaddr, pteval)	flush_cache_all()
-#define arch_kmap_local_post_unmap(vaddr)	flush_cache_all()
-
+/* FIXME: Use __flush_*_one(vaddr) instead of flush_*_all() -- Anton */
+#define arch_kmap_local_pre_map(vaddr, pteval)	flush_cache_all()
+#define arch_kmap_local_pre_unmap(vaddr)	flush_cache_all()
+#define arch_kmap_local_post_map(vaddr, pteval)	flush_tlb_all()
+#define arch_kmap_local_post_unmap(vaddr)	flush_tlb_all()
 
 #endif /* __KERNEL__ */
 
