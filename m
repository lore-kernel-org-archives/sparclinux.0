From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 29 Oct 2020 22:18:20 +0000
Subject: [patch V2 14/18] mm/highmem: Remove the old kmap_atomic cruft
Message-Id: <20201029222651.992069499@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20201029221806.189523375@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Paul McKenney <paulmck@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ard Biesheuvel <ardb@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Christoph Hellwig <hch@lst.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org

All users gone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/highmem.h |   61 ++----------------------------------------------
 mm/highmem.c            |   28 ++++++++++++++++++----
 2 files changed, 27 insertions(+), 62 deletions(-)

--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -88,31 +88,16 @@ static inline void kunmap(struct page *p
  * be used in IRQ contexts, so in some (very limited) cases we need
  * it.
  */
-
-#ifndef CONFIG_KMAP_LOCAL
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot);
-void kunmap_atomic_high(void *kvaddr);
-
 static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 {
 	preempt_disable();
 	pagefault_disable();
-	if (!PageHighMem(page))
-		return page_address(page);
-	return kmap_atomic_high_prot(page, prot);
-}
-
-static inline void __kunmap_atomic(void *vaddr)
-{
-	kunmap_atomic_high(vaddr);
+	return __kmap_local_page_prot(page, prot);
 }
-#else /* !CONFIG_KMAP_LOCAL */
 
-static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
+static inline void *kmap_atomic(struct page *page)
 {
-	preempt_disable();
-	pagefault_disable();
-	return __kmap_local_page_prot(page, prot);
+	return kmap_atomic_prot(page, kmap_prot);
 }
 
 static inline void *kmap_atomic_pfn(unsigned long pfn)
@@ -127,13 +112,6 @@ static inline void __kunmap_atomic(void
 	kunmap_local_indexed(addr);
 }
 
-#endif /* CONFIG_KMAP_LOCAL */
-
-static inline void *kmap_atomic(struct page *page)
-{
-	return kmap_atomic_prot(page, kmap_prot);
-}
-
 /* declarations for linux/mm/highmem.c */
 unsigned int nr_free_highpages(void);
 extern atomic_long_t _totalhigh_pages;
@@ -226,39 +204,6 @@ static inline void __kunmap_atomic(void
 
 #endif /* CONFIG_HIGHMEM */
 
-#if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_32)
-
-DECLARE_PER_CPU(int, __kmap_atomic_idx);
-
-static inline int kmap_atomic_idx_push(void)
-{
-	int idx = __this_cpu_inc_return(__kmap_atomic_idx) - 1;
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	WARN_ON_ONCE(in_irq() && !irqs_disabled());
-	BUG_ON(idx >= KM_TYPE_NR);
-#endif
-	return idx;
-}
-
-static inline int kmap_atomic_idx(void)
-{
-	return __this_cpu_read(__kmap_atomic_idx) - 1;
-}
-
-static inline void kmap_atomic_idx_pop(void)
-{
-#ifdef CONFIG_DEBUG_HIGHMEM
-	int idx = __this_cpu_dec_return(__kmap_atomic_idx);
-
-	BUG_ON(idx < 0);
-#else
-	__this_cpu_dec(__kmap_atomic_idx);
-#endif
-}
-
-#endif
-
 /*
  * Prevent people trying to call kunmap_atomic() as if it were kunmap()
  * kunmap_atomic() should get the return value of kmap_atomic, not the page.
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -32,10 +32,6 @@
 #include <linux/vmalloc.h>
 #include <asm/fixmap.h>
 
-#if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_32)
-DEFINE_PER_CPU(int, __kmap_atomic_idx);
-#endif
-
 /*
  * Virtual_count is not a pure "count".
  *  0 means that it is not mapped, and has not been mapped
@@ -370,6 +366,30 @@ EXPORT_SYMBOL(kunmap_high);
 #endif /* CONFIG_HIGHMEM */
 
 #ifdef CONFIG_KMAP_LOCAL
+
+static DEFINE_PER_CPU(int, __kmap_atomic_idx);
+
+static inline int kmap_atomic_idx_push(void)
+{
+	int idx = __this_cpu_inc_return(__kmap_atomic_idx) - 1;
+
+	WARN_ON_ONCE(in_irq() && !irqs_disabled());
+	BUG_ON(idx >= KM_TYPE_NR);
+	return idx;
+}
+
+static inline int kmap_atomic_idx(void)
+{
+	return __this_cpu_read(__kmap_atomic_idx) - 1;
+}
+
+static inline void kmap_atomic_idx_pop(void)
+{
+	int idx = __this_cpu_dec_return(__kmap_atomic_idx);
+
+	BUG_ON(idx < 0);
+}
+
 #ifndef arch_kmap_local_post_map
 # define arch_kmap_local_post_map(vaddr, pteval)	do { } while (0)
 #endif
