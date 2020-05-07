From: ira.weiny@intel.com
Date: Thu, 07 May 2020 14:59:49 +0000
Subject: [PATCH V3 01/15] arch/kmap: Remove BUG_ON()
Message-Id: <20200507150004.1423069-2-ira.weiny@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200507150004.1423069-1-ira.weiny@intel.com>
In-Reply-To: <20200507150004.1423069-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

From: Ira Weiny <ira.weiny@intel.com>

Replace the use of BUG_ON(in_interrupt()) in the kmap() and kunmap()
in favor of might_sleep().

Besides the benefits of might_sleep(), this normalizes the
implementations such that they can be made generic in subsequent
patches.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/arc/include/asm/highmem.h        | 2 +-
 arch/arc/mm/highmem.c                 | 2 +-
 arch/arm/mm/highmem.c                 | 2 +-
 arch/csky/mm/highmem.c                | 2 +-
 arch/microblaze/include/asm/highmem.h | 2 +-
 arch/mips/mm/highmem.c                | 2 +-
 arch/nds32/mm/highmem.c               | 2 +-
 arch/powerpc/include/asm/highmem.h    | 2 +-
 arch/sparc/include/asm/highmem.h      | 4 ++--
 arch/x86/mm/highmem_32.c              | 3 +--
 arch/xtensa/include/asm/highmem.h     | 4 ++--
 11 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/arc/include/asm/highmem.h b/arch/arc/include/asm/highmem.h
index 1af00accb37f..042e92921c4c 100644
--- a/arch/arc/include/asm/highmem.h
+++ b/arch/arc/include/asm/highmem.h
@@ -45,7 +45,7 @@ static inline void flush_cache_kmaps(void)
 
 static inline void kunmap(struct page *page)
 {
-	BUG_ON(in_interrupt());
+	might_sleep();
 	if (!PageHighMem(page))
 		return;
 	kunmap_high(page);
diff --git a/arch/arc/mm/highmem.c b/arch/arc/mm/highmem.c
index fc8849e4f72e..39ef7b9a3aa9 100644
--- a/arch/arc/mm/highmem.c
+++ b/arch/arc/mm/highmem.c
@@ -51,7 +51,7 @@ static pte_t * fixmap_page_table;
 
 void *kmap(struct page *page)
 {
-	BUG_ON(in_interrupt());
+	might_sleep();
 	if (!PageHighMem(page))
 		return page_address(page);
 
diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index a76f8ace9ce6..cc6eb79ef20c 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -42,7 +42,7 @@ EXPORT_SYMBOL(kmap);
 
 void kunmap(struct page *page)
 {
-	BUG_ON(in_interrupt());
+	might_sleep();
 	if (!PageHighMem(page))
 		return;
 	kunmap_high(page);
diff --git a/arch/csky/mm/highmem.c b/arch/csky/mm/highmem.c
index 813129145f3d..690d678649d1 100644
--- a/arch/csky/mm/highmem.c
+++ b/arch/csky/mm/highmem.c
@@ -29,7 +29,7 @@ EXPORT_SYMBOL(kmap);
 
 void kunmap(struct page *page)
 {
-	BUG_ON(in_interrupt());
+	might_sleep();
 	if (!PageHighMem(page))
 		return;
 	kunmap_high(page);
diff --git a/arch/microblaze/include/asm/highmem.h b/arch/microblaze/include/asm/highmem.h
index 332c78e15198..99ced7278b5c 100644
--- a/arch/microblaze/include/asm/highmem.h
+++ b/arch/microblaze/include/asm/highmem.h
@@ -66,7 +66,7 @@ static inline void *kmap(struct page *page)
 
 static inline void kunmap(struct page *page)
 {
-	BUG_ON(in_interrupt());
+	might_sleep();
 	if (!PageHighMem(page))
 		return;
 	kunmap_high(page);
diff --git a/arch/mips/mm/highmem.c b/arch/mips/mm/highmem.c
index d08e6d7d533b..edd889f6cede 100644
--- a/arch/mips/mm/highmem.c
+++ b/arch/mips/mm/highmem.c
@@ -28,7 +28,7 @@ EXPORT_SYMBOL(kmap);
 
 void kunmap(struct page *page)
 {
-	BUG_ON(in_interrupt());
+	might_sleep();
 	if (!PageHighMem(page))
 		return;
 	kunmap_high(page);
diff --git a/arch/nds32/mm/highmem.c b/arch/nds32/mm/highmem.c
index 022779af6148..4c7c28e994ea 100644
--- a/arch/nds32/mm/highmem.c
+++ b/arch/nds32/mm/highmem.c
@@ -24,7 +24,7 @@ EXPORT_SYMBOL(kmap);
 
 void kunmap(struct page *page)
 {
-	BUG_ON(in_interrupt());
+	might_sleep();
 	if (!PageHighMem(page))
 		return;
 	kunmap_high(page);
diff --git a/arch/powerpc/include/asm/highmem.h b/arch/powerpc/include/asm/highmem.h
index a4b65b186ec6..529512f6d65a 100644
--- a/arch/powerpc/include/asm/highmem.h
+++ b/arch/powerpc/include/asm/highmem.h
@@ -74,7 +74,7 @@ static inline void *kmap(struct page *page)
 
 static inline void kunmap(struct page *page)
 {
-	BUG_ON(in_interrupt());
+	might_sleep();
 	if (!PageHighMem(page))
 		return;
 	kunmap_high(page);
diff --git a/arch/sparc/include/asm/highmem.h b/arch/sparc/include/asm/highmem.h
index 18d776925c45..7dd2d4b3f980 100644
--- a/arch/sparc/include/asm/highmem.h
+++ b/arch/sparc/include/asm/highmem.h
@@ -55,7 +55,7 @@ void kunmap_high(struct page *page);
 
 static inline void *kmap(struct page *page)
 {
-	BUG_ON(in_interrupt());
+	might_sleep();
 	if (!PageHighMem(page))
 		return page_address(page);
 	return kmap_high(page);
@@ -63,7 +63,7 @@ static inline void *kmap(struct page *page)
 
 static inline void kunmap(struct page *page)
 {
-	BUG_ON(in_interrupt());
+	might_sleep();
 	if (!PageHighMem(page))
 		return;
 	kunmap_high(page);
diff --git a/arch/x86/mm/highmem_32.c b/arch/x86/mm/highmem_32.c
index 0a1898b8552e..8af66382672b 100644
--- a/arch/x86/mm/highmem_32.c
+++ b/arch/x86/mm/highmem_32.c
@@ -15,8 +15,7 @@ EXPORT_SYMBOL(kmap);
 
 void kunmap(struct page *page)
 {
-	if (in_interrupt())
-		BUG();
+	might_sleep();
 	if (!PageHighMem(page))
 		return;
 	kunmap_high(page);
diff --git a/arch/xtensa/include/asm/highmem.h b/arch/xtensa/include/asm/highmem.h
index 04e9340eac4b..413848cc1e56 100644
--- a/arch/xtensa/include/asm/highmem.h
+++ b/arch/xtensa/include/asm/highmem.h
@@ -73,7 +73,7 @@ static inline void *kmap(struct page *page)
 	 */
 	BUILD_BUG_ON(PKMAP_BASE <
 		     TLBTEMP_BASE_1 + TLBTEMP_SIZE);
-	BUG_ON(in_interrupt());
+	might_sleep();
 	if (!PageHighMem(page))
 		return page_address(page);
 	return kmap_high(page);
@@ -81,7 +81,7 @@ static inline void *kmap(struct page *page)
 
 static inline void kunmap(struct page *page)
 {
-	BUG_ON(in_interrupt());
+	might_sleep();
 	if (!PageHighMem(page))
 		return;
 	kunmap_high(page);
-- 
2.25.1
