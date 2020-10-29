From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 29 Oct 2020 22:18:19 +0000
Subject: [patch V2 13/18] xtensa/mm/highmem: Switch to generic kmap atomic
Message-Id: <20201029222651.885593433@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20201029221806.189523375@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Paul McKenney <paulmck@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ard Biesheuvel <ardb@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Christoph Hellwig <hch@lst.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

No reason having the same code in every architecture

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org

---
 arch/xtensa/Kconfig               |    1 
 arch/xtensa/include/asm/highmem.h |    9 +++++++
 arch/xtensa/mm/highmem.c          |   44 +++-----------------------------------
 3 files changed, 14 insertions(+), 40 deletions(-)

--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -666,6 +666,7 @@ endchoice
 config HIGHMEM
 	bool "High Memory Support"
 	depends on MMU
+        select KMAP_LOCAL
 	help
 	  Linux can use the full amount of RAM in the system by
 	  default. However, the default MMUv2 setup only maps the
--- a/arch/xtensa/include/asm/highmem.h
+++ b/arch/xtensa/include/asm/highmem.h
@@ -68,6 +68,15 @@ static inline void flush_cache_kmaps(voi
 	flush_cache_all();
 }
 
+enum fixed_addresses kmap_local_map_idx(int type, unsigned long pfn);
+#define arch_kmap_local_map_idx		kmap_local_map_idx
+
+enum fixed_addresses kmap_local_unmap_idx(int type, unsigned long addr);
+#define arch_kmap_local_unmap_idx	kmap_local_unmap_idx
+
+#define arch_kmap_local_post_unmap(vaddr)	\
+	local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE)
+
 void kmap_init(void);
 
 #endif
--- a/arch/xtensa/mm/highmem.c
+++ b/arch/xtensa/mm/highmem.c
@@ -12,8 +12,6 @@
 #include <linux/highmem.h>
 #include <asm/tlbflush.h>
 
-static pte_t *kmap_pte;
-
 #if DCACHE_WAY_SIZE > PAGE_SIZE
 unsigned int last_pkmap_nr_arr[DCACHE_N_COLORS];
 wait_queue_head_t pkmap_map_wait_arr[DCACHE_N_COLORS];
@@ -37,55 +35,21 @@ static inline enum fixed_addresses kmap_
 		color;
 }
 
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
+enum fixed_addresses kmap_local_map_idx(int type, unsigned long pfn)
 {
-	enum fixed_addresses idx;
-	unsigned long vaddr;
-
-	idx = kmap_idx(kmap_atomic_idx_push(),
-		       DCACHE_ALIAS(page_to_phys(page)));
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte + idx)));
-#endif
-	set_pte(kmap_pte + idx, mk_pte(page, prot));
-
-	return (void *)vaddr;
+	return kmap_idx(type, DCACHE_ALIAS(pfn << PAGE_SHIFT);
 }
-EXPORT_SYMBOL(kmap_atomic_high_prot);
 
-void kunmap_atomic_high(void *kvaddr)
+enum fixed_addresses kmap_local_unmap_idx(int type, unsigned long addr)
 {
-	if (kvaddr >= (void *)FIXADDR_START &&
-	    kvaddr < (void *)FIXADDR_TOP) {
-		int idx = kmap_idx(kmap_atomic_idx(),
-				   DCACHE_ALIAS((unsigned long)kvaddr));
-
-		/*
-		 * Force other mappings to Oops if they'll try to access this
-		 * pte without first remap it.  Keeping stale mappings around
-		 * is a bad idea also, in case the page changes cacheability
-		 * attributes or becomes a protected page in a hypervisor.
-		 */
-		pte_clear(&init_mm, kvaddr, kmap_pte + idx);
-		local_flush_tlb_kernel_range((unsigned long)kvaddr,
-					     (unsigned long)kvaddr + PAGE_SIZE);
-
-		kmap_atomic_idx_pop();
-	}
+	return kmap_idx(type, DCACHE_ALIAS(addr));
 }
-EXPORT_SYMBOL(kunmap_atomic_high);
 
 void __init kmap_init(void)
 {
-	unsigned long kmap_vstart;
-
 	/* Check if this memory layout is broken because PKMAP overlaps
 	 * page table.
 	 */
 	BUILD_BUG_ON(PKMAP_BASE < TLBTEMP_BASE_1 + TLBTEMP_SIZE);
-	/* cache the first kmap pte */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
-	kmap_pte = virt_to_kpte(kmap_vstart);
 	kmap_waitqueues_init();
 }
