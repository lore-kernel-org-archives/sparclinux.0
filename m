From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Thu, 03 Sep 2020 07:01:22 +0000
Subject: [PATCH v4 3/4] mm/pageblock: work around multiple arch's cmpxchg support issue
Message-Id: <1599116482-7410-3-git-send-email-alex.shi@linux.alibaba.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1599116482-7410-1-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1599116482-7410-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anshuman Khandual <anshuman.khandual@arm.com>, David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Alexander Duyck <alexander.duyck@gmail.com>
Cc: Chris Zankel <chris@zankel.net>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Max Filippov <jcmvbkbc@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org

Armv6, sh2, sparc32 and xtensa can not do cmpxchg1, so we have to use
cmpxchg4 on it.

Here we mark above 4 arch's NO_CMPXCHG_BYTE, and would add more if we
found.

This is the first usages of cmpxchg flase sharing change. We'd better
check more cmpxchg usages in current kernel...

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-mm@kvack.org
---
 arch/Kconfig           |  3 +++
 arch/arm/Kconfig       |  1 +
 arch/sh/Kconfig        |  1 +
 arch/sparc/Kconfig     |  1 +
 arch/xtensa/Kconfig    |  1 +
 include/linux/mmzone.h | 15 ++++++++++++---
 mm/page_alloc.c        | 22 +++++++++++-----------
 7 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index af14a567b493..3514570c0f5f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -431,6 +431,9 @@ config HAVE_CMPXCHG_LOCAL
 config HAVE_CMPXCHG_DOUBLE
 	bool
 
+config NO_CMPXCHG_BYTE
+	bool
+
 config ARCH_WEAK_RELEASE_ACQUIRE
 	bool
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e00d94b16658..03a6c7fd999d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -48,6 +48,7 @@ config ARM
 	select GENERIC_ALLOCATOR
 	select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
 	select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
+	select NO_CMPXCHG_BYTE if CPU_V6
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d20927128fce..4c7f0ad5b93f 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -155,6 +155,7 @@ menu "System type"
 config CPU_SH2
 	bool
 	select SH_INTC
+	select NO_CMPXCHG_BYTE
 
 config CPU_SH2A
 	bool
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index efeff2c896a5..51ae5c8ede87 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -58,6 +58,7 @@ config SPARC32
 	select CLZ_TAB
 	select HAVE_UID16
 	select OLD_SIGACTION
+	select NO_CMPXCHG_BYTE
 
 config SPARC64
 	def_bool 64BIT
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index e997e0119c02..862b008ab09e 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -42,6 +42,7 @@ config XTENSA
 	select MODULES_USE_ELF_RELA
 	select PERF_USE_VMALLOC
 	select VIRT_TO_BUS
+	select NO_CMPXCHG_BYTE
 	help
 	  Xtensa processors are 32-bit RISC machines designed by Tensilica
 	  primarily for embedded systems.  These processors are both
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index be676e659fb7..0bc5ac0f8cd7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -406,6 +406,15 @@ enum zone_type {
 
 #ifndef __GENERATING_BOUNDS_H
 
+/* cmpxchg only support 32-bits operands on ARMv6, SPARC32, sh2, XTENSA.*/
+#ifdef CONFIG_NO_CMPXCHG_BYTE
+#define BITS_PER_FLAGS	BITS_PER_LONG
+typedef unsigned long pageblockflags_t;
+#else
+#define BITS_PER_FLAGS	BITS_PER_BYTE
+typedef unsigned char pageblockflags_t;
+#endif
+
 struct zone {
 	/* Read-mostly fields */
 
@@ -437,7 +446,7 @@ struct zone {
 	 * Flags for a pageblock_nr_pages block. See pageblock-flags.h.
 	 * In SPARSEMEM, this map is stored in struct mem_section
 	 */
-	unsigned char		*pageblock_flags;
+	pageblockflags_t	*pageblock_flags;
 #endif /* CONFIG_SPARSEMEM */
 
 	/* zone_start_pfn = zone_start_paddr >> PAGE_SHIFT */
@@ -1159,7 +1168,7 @@ struct mem_section_usage {
 	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
 #endif
 	/* See declaration of similar field in struct zone */
-	unsigned char	pageblock_flags[0];
+	pageblockflags_t	pageblock_flags[0];
 };
 
 void subsection_map_init(unsigned long pfn, unsigned long nr_pages);
@@ -1212,7 +1221,7 @@ struct mem_section {
 extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
 #endif
 
-static inline unsigned char *section_to_usemap(struct mem_section *ms)
+static inline pageblockflags_t *section_to_usemap(struct mem_section *ms)
 {
 	return ms->usage->pageblock_flags;
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3688e6b83318..8b65d83d8be6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -445,7 +445,7 @@ static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 #endif
 
 /* Return a pointer to the bitmap storing bits affecting a block of pages */
-static inline unsigned char *get_pageblock_bitmap(struct page *page,
+static inline pageblockflags_t *get_pageblock_bitmap(struct page *page,
 							unsigned long pfn)
 {
 #ifdef CONFIG_SPARSEMEM
@@ -474,24 +474,24 @@ static inline int pfn_to_bitidx(struct page *page, unsigned long pfn)
  * Return: pageblock_bits flags
  */
 static __always_inline
-unsigned char __get_pfnblock_flags_mask(struct page *page,
+pageblockflags_t __get_pfnblock_flags_mask(struct page *page,
 					unsigned long pfn,
 					unsigned long mask)
 {
-	unsigned char *bitmap;
+	pageblockflags_t *bitmap;
 	unsigned long bitidx, byte_bitidx;
-	unsigned char byte;
+	pageblockflags_t byte;
 
 	bitmap = get_pageblock_bitmap(page, pfn);
 	bitidx = pfn_to_bitidx(page, pfn);
-	byte_bitidx = bitidx / BITS_PER_BYTE;
-	bitidx &= (BITS_PER_BYTE-1);
+	byte_bitidx = bitidx / BITS_PER_FLAGS;
+	bitidx &= (BITS_PER_FLAGS - 1);
 
 	byte = bitmap[byte_bitidx];
 	return (byte >> bitidx) & mask;
 }
 
-unsigned char get_pfnblock_flags_mask(struct page *page, unsigned long pfn,
+pageblockflags_t get_pfnblock_flags_mask(struct page *page, unsigned long pfn,
 					unsigned long mask)
 {
 	return __get_pfnblock_flags_mask(page, pfn, mask);
@@ -513,16 +513,16 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 					unsigned long pfn,
 					unsigned long mask)
 {
-	unsigned char *bitmap;
+	pageblockflags_t *bitmap;
 	unsigned long bitidx, byte_bitidx;
-	unsigned char old_byte, byte;
+	pageblockflags_t old_byte, byte;
 
-	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != BITS_PER_BYTE);
+	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != BITS_PER_FLAGS);
 	BUILD_BUG_ON(MIGRATE_TYPES > (1 << PB_migratetype_bits));
 
 	bitmap = get_pageblock_bitmap(page, pfn);
 	bitidx = pfn_to_bitidx(page, pfn);
-	byte_bitidx = bitidx / BITS_PER_BYTE;
+	byte_bitidx = bitidx / BITS_PER_FLAGS;
 
 	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
 
-- 
1.8.3.1
