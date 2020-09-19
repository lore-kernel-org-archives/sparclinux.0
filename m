From: Thomas Gleixner <tglx@linutronix.de>
Date: Sat, 19 Sep 2020 09:17:55 +0000
Subject: [patch RFC 04/15] arc/mm/highmem: Use generic kmap atomic implementation
Message-Id: <20200919092616.204352647@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20200919091751.011116649@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dri-devel <dri-devel@lists.freedesktop.org>, Ben Segall <bsegall@google.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-arch@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Herbert Xu <herbert@gondor.apana.org.au>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, David Airlie <airlied@linux.ie>, Mel Gorman <mgorman@suse.de>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Paul McKenney <paulmck@kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linuxfoundation.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Linux-MM <linux-mm@kvack.org>, Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, "David S. Miller" <davem@davemloft.net>, Greentime Hu <green.hu@gmail.com>

Adopt the map ordering to match the other architectures and the generic
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
---
Note: Completely untested
---
 arch/arc/Kconfig               |    1 
 arch/arc/include/asm/highmem.h |    8 ++++++-
 arch/arc/mm/highmem.c          |   44 -----------------------------------------
 3 files changed, 9 insertions(+), 44 deletions(-)

--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -508,6 +508,7 @@ config LINUX_RAM_BASE
 config HIGHMEM
 	bool "High Memory Support"
 	select ARCH_DISCONTIGMEM_ENABLE
+	select KMAP_ATOMIC_GENERIC
 	help
 	  With ARC 2G:2G address split, only upper 2G is directly addressable by
 	  kernel. Enable this to potentially allow access to rest of 2G and PAE
--- a/arch/arc/include/asm/highmem.h
+++ b/arch/arc/include/asm/highmem.h
@@ -15,7 +15,10 @@
 #define FIXMAP_BASE		(PAGE_OFFSET - FIXMAP_SIZE - PKMAP_SIZE)
 #define FIXMAP_SIZE		PGDIR_SIZE	/* only 1 PGD worth */
 #define KM_TYPE_NR		((FIXMAP_SIZE >> PAGE_SHIFT)/NR_CPUS)
-#define FIXMAP_ADDR(nr)		(FIXMAP_BASE + ((nr) << PAGE_SHIFT))
+
+#define FIX_KMAP_BEGIN		(0)
+#define FIX_KMAP_END		((FIXMAP_SIZE >> PAGE_SHIFT) - 1)
+#define FIXADDR_TOP		(FIXMAP_BASE + FIXMAP_SIZE - PAGE_SIZE)
 
 /* start after fixmap area */
 #define PKMAP_BASE		(FIXMAP_BASE + FIXMAP_SIZE)
@@ -29,6 +32,9 @@
 
 extern void kmap_init(void);
 
+#define arch_kmap_temp_post_unmap(vaddr)			\
+	local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE)
+
 static inline void flush_cache_kmaps(void)
 {
 	flush_cache_all();
--- a/arch/arc/mm/highmem.c
+++ b/arch/arc/mm/highmem.c
@@ -47,48 +47,6 @@
  */
 
 extern pte_t * pkmap_page_table;
-static pte_t * fixmap_page_table;
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	int idx, cpu_idx;
-	unsigned long vaddr;
-
-	cpu_idx = kmap_atomic_idx_push();
-	idx = cpu_idx + KM_TYPE_NR * smp_processor_id();
-	vaddr = FIXMAP_ADDR(idx);
-
-	set_pte_at(&init_mm, vaddr, fixmap_page_table + idx,
-		   mk_pte(page, prot));
-
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kv)
-{
-	unsigned long kvaddr = (unsigned long)kv;
-
-	if (kvaddr >= FIXMAP_BASE && kvaddr < (FIXMAP_BASE + FIXMAP_SIZE)) {
-
-		/*
-		 * Because preemption is disabled, this vaddr can be associated
-		 * with the current allocated index.
-		 * But in case of multiple live kmap_atomic(), it still relies on
-		 * callers to unmap in right order.
-		 */
-		int cpu_idx = kmap_atomic_idx();
-		int idx = cpu_idx + KM_TYPE_NR * smp_processor_id();
-
-		WARN_ON(kvaddr != FIXMAP_ADDR(idx));
-
-		pte_clear(&init_mm, kvaddr, fixmap_page_table + idx);
-		local_flush_tlb_kernel_range(kvaddr, kvaddr + PAGE_SIZE);
-
-		kmap_atomic_idx_pop();
-	}
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
 
 static noinline pte_t * __init alloc_kmap_pgtable(unsigned long kvaddr)
 {
@@ -113,5 +71,5 @@ void __init kmap_init(void)
 	pkmap_page_table = alloc_kmap_pgtable(PKMAP_BASE);
 
 	BUILD_BUG_ON(LAST_PKMAP > PTRS_PER_PTE);
-	fixmap_page_table = alloc_kmap_pgtable(FIXMAP_BASE);
+	alloc_kmap_pgtable(FIXMAP_BASE);
 }
