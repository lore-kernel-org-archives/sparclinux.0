From: ira.weiny@intel.com
Date: Sun, 26 Apr 2020 05:54:05 +0000
Subject: [PATCH 4/5] arch/kmap_atomic: Consolidate duplicate code
Message-Id: <20200426055406.134198-5-ira.weiny@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200426055406.134198-1-ira.weiny@intel.com>
In-Reply-To: <20200426055406.134198-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

From: Ira Weiny <ira.weiny@intel.com>

Every arch has the same check for a not HIGHMEM page.  Define
kmap_atomic_fast() to quickly return already mapped pages and reduce the
code duplication by lifting this check to the core.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/arc/mm/highmem.c        | 7 +++----
 arch/arm/mm/highmem.c        | 8 +++-----
 arch/csky/mm/highmem.c       | 7 +++----
 arch/microblaze/mm/highmem.c | 8 +++-----
 arch/mips/mm/highmem.c       | 7 +++----
 arch/nds32/mm/highmem.c      | 7 +++----
 arch/powerpc/mm/highmem.c    | 7 +++----
 arch/sparc/mm/highmem.c      | 7 +++----
 arch/x86/mm/highmem_32.c     | 8 +++-----
 arch/xtensa/mm/highmem.c     | 7 +++----
 include/linux/highmem.h      | 9 +++++++++
 11 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/arch/arc/mm/highmem.c b/arch/arc/mm/highmem.c
index 4db13a6b9f3b..1cae4b911a33 100644
--- a/arch/arc/mm/highmem.c
+++ b/arch/arc/mm/highmem.c
@@ -53,11 +53,10 @@ void *kmap_atomic(struct page *page)
 {
 	int idx, cpu_idx;
 	unsigned long vaddr;
+	void *addr = kmap_atomic_fast(page);
 
-	preempt_disable();
-	pagefault_disable();
-	if (!PageHighMem(page))
-		return page_address(page);
+	if (addr)
+		return addr;
 
 	cpu_idx = kmap_atomic_idx_push();
 	idx = cpu_idx + KM_TYPE_NR * smp_processor_id();
diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index c700b32350ee..4a629f616a6a 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -35,13 +35,11 @@ void *kmap_atomic(struct page *page)
 {
 	unsigned int idx;
 	unsigned long vaddr;
-	void *kmap;
+	void *kmap = kmap_atomic_fast(page);
 	int type;
 
-	preempt_disable();
-	pagefault_disable();
-	if (!PageHighMem(page))
-		return page_address(page);
+	if (kmap)
+		return kmap;
 
 #ifdef CONFIG_DEBUG_HIGHMEM
 	/*
diff --git a/arch/csky/mm/highmem.c b/arch/csky/mm/highmem.c
index 69b1931986ae..1191f57f53ae 100644
--- a/arch/csky/mm/highmem.c
+++ b/arch/csky/mm/highmem.c
@@ -25,12 +25,11 @@ EXPORT_SYMBOL(kmap);
 void *kmap_atomic(struct page *page)
 {
 	unsigned long vaddr;
+	void *addr = kmap_atomic_fast(page);
 	int idx, type;
 
-	preempt_disable();
-	pagefault_disable();
-	if (!PageHighMem(page))
-		return page_address(page);
+	if (addr)
+		return addr;
 
 	type = kmap_atomic_idx_push();
 	idx = type + KM_TYPE_NR*smp_processor_id();
diff --git a/arch/microblaze/mm/highmem.c b/arch/microblaze/mm/highmem.c
index d7569f77fa15..99fdf826edc2 100644
--- a/arch/microblaze/mm/highmem.c
+++ b/arch/microblaze/mm/highmem.c
@@ -36,13 +36,11 @@ void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 {
 
 	unsigned long vaddr;
+	void *addr = kmap_atomic_fast(page);
 	int idx, type;
 
-	preempt_disable();
-	pagefault_disable();
-	if (!PageHighMem(page))
-		return page_address(page);
-
+	if (addr)
+		return addr;
 
 	type = kmap_atomic_idx_push();
 	idx = type + KM_TYPE_NR*smp_processor_id();
diff --git a/arch/mips/mm/highmem.c b/arch/mips/mm/highmem.c
index c3c9fe962f0f..ba03ca75d4a1 100644
--- a/arch/mips/mm/highmem.c
+++ b/arch/mips/mm/highmem.c
@@ -33,12 +33,11 @@ EXPORT_SYMBOL(kmap);
 void *kmap_atomic(struct page *page)
 {
 	unsigned long vaddr;
+	void *addr = kmap_atomic_fast(page);
 	int idx, type;
 
-	preempt_disable();
-	pagefault_disable();
-	if (!PageHighMem(page))
-		return page_address(page);
+	if (addr)
+		return addr;
 
 	type = kmap_atomic_idx_push();
 	idx = type + KM_TYPE_NR*smp_processor_id();
diff --git a/arch/nds32/mm/highmem.c b/arch/nds32/mm/highmem.c
index f9348bec0ecb..4aabde586489 100644
--- a/arch/nds32/mm/highmem.c
+++ b/arch/nds32/mm/highmem.c
@@ -14,13 +14,12 @@ void *kmap_atomic(struct page *page)
 {
 	unsigned int idx;
 	unsigned long vaddr, pte;
+	void *addr = kmap_atomic_fast(page);
 	int type;
 	pte_t *ptep;
 
-	preempt_disable();
-	pagefault_disable();
-	if (!PageHighMem(page))
-		return page_address(page);
+	if (addr)
+		return addr;
 
 	type = kmap_atomic_idx_push();
 
diff --git a/arch/powerpc/mm/highmem.c b/arch/powerpc/mm/highmem.c
index 320c1672b2ae..cdf5b716801a 100644
--- a/arch/powerpc/mm/highmem.c
+++ b/arch/powerpc/mm/highmem.c
@@ -33,12 +33,11 @@
 void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 {
 	unsigned long vaddr;
+	void *addr = kmap_atomic_fast(page);
 	int idx, type;
 
-	preempt_disable();
-	pagefault_disable();
-	if (!PageHighMem(page))
-		return page_address(page);
+	if (addr)
+		return addr;
 
 	type = kmap_atomic_idx_push();
 	idx = type + KM_TYPE_NR*smp_processor_id();
diff --git a/arch/sparc/mm/highmem.c b/arch/sparc/mm/highmem.c
index d4a80adea7e5..178641805567 100644
--- a/arch/sparc/mm/highmem.c
+++ b/arch/sparc/mm/highmem.c
@@ -56,12 +56,11 @@ void __init kmap_init(void)
 void *kmap_atomic(struct page *page)
 {
 	unsigned long vaddr;
+	void *addr = kmap_atomic_fast(page);
 	long idx, type;
 
-	preempt_disable();
-	pagefault_disable();
-	if (!PageHighMem(page))
-		return page_address(page);
+	if (addr)
+		return addr;
 
 	type = kmap_atomic_idx_push();
 	idx = type + KM_TYPE_NR*smp_processor_id();
diff --git a/arch/x86/mm/highmem_32.c b/arch/x86/mm/highmem_32.c
index c4ebfd0ae401..34770499b0ff 100644
--- a/arch/x86/mm/highmem_32.c
+++ b/arch/x86/mm/highmem_32.c
@@ -15,13 +15,11 @@
 void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 {
 	unsigned long vaddr;
+	void *addr = kmap_atomic_fast(page);
 	int idx, type;
 
-	preempt_disable();
-	pagefault_disable();
-
-	if (!PageHighMem(page))
-		return page_address(page);
+	if (addr)
+		return addr;
 
 	type = kmap_atomic_idx_push();
 	idx = type + KM_TYPE_NR*smp_processor_id();
diff --git a/arch/xtensa/mm/highmem.c b/arch/xtensa/mm/highmem.c
index 184ceadccc1a..38c14e0b578c 100644
--- a/arch/xtensa/mm/highmem.c
+++ b/arch/xtensa/mm/highmem.c
@@ -41,11 +41,10 @@ void *kmap_atomic(struct page *page)
 {
 	enum fixed_addresses idx;
 	unsigned long vaddr;
+	void *addr = kmap_atomic_fast(page);
 
-	preempt_disable();
-	pagefault_disable();
-	if (!PageHighMem(page))
-		return page_address(page);
+	if (addr)
+		return addr;
 
 	idx = kmap_idx(kmap_atomic_idx_push(),
 		       DCACHE_ALIAS(page_to_phys(page)));
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 1a3b7690c78c..eee53e151900 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -60,6 +60,15 @@ static inline void kunmap(struct page *page)
 	kunmap_high(page);
 }
 
+static inline void *kmap_atomic_fast(struct page *page)
+{
+	preempt_disable();
+	pagefault_disable();
+	if (!PageHighMem(page))
+		return page_address(page);
+	return NULL;
+}
+
 /* declarations for linux/mm/highmem.c */
 unsigned int nr_free_highpages(void);
 extern atomic_long_t _totalhigh_pages;
-- 
2.25.1
