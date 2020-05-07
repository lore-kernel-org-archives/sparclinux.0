From: ira.weiny@intel.com
Date: Thu, 07 May 2020 15:00:00 +0000
Subject: [PATCH V3 12/15] kmap: Remove kmap_atomic_to_page()
Message-Id: <20200507150004.1423069-13-ira.weiny@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200507150004.1423069-1-ira.weiny@intel.com>
In-Reply-To: <20200507150004.1423069-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

From: Ira Weiny <ira.weiny@intel.com>

kmap_atomic_to_page() has no callers and is only defined on 1 arch and
declared on another.  Remove it.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V2:
	New Patch for this series
---
 arch/csky/include/asm/highmem.h  |  1 -
 arch/csky/mm/highmem.c           | 13 -------------
 arch/nds32/include/asm/highmem.h |  1 -
 3 files changed, 15 deletions(-)

diff --git a/arch/csky/include/asm/highmem.h b/arch/csky/include/asm/highmem.h
index 263fbddcd0a3..ea2f3f39174d 100644
--- a/arch/csky/include/asm/highmem.h
+++ b/arch/csky/include/asm/highmem.h
@@ -33,7 +33,6 @@ extern pte_t *pkmap_page_table;
 #define ARCH_HAS_KMAP_FLUSH_TLB
 extern void kmap_flush_tlb(unsigned long addr);
 extern void *kmap_atomic_pfn(unsigned long pfn);
-extern struct page *kmap_atomic_to_page(void *ptr);
 
 #define flush_cache_kmaps() do {} while (0)
 
diff --git a/arch/csky/mm/highmem.c b/arch/csky/mm/highmem.c
index 3ae5c8cd7619..3b3f622f5ae9 100644
--- a/arch/csky/mm/highmem.c
+++ b/arch/csky/mm/highmem.c
@@ -81,19 +81,6 @@ void *kmap_atomic_pfn(unsigned long pfn)
 	return (void *) vaddr;
 }
 
-struct page *kmap_atomic_to_page(void *ptr)
-{
-	unsigned long idx, vaddr = (unsigned long)ptr;
-	pte_t *pte;
-
-	if (vaddr < FIXADDR_START)
-		return virt_to_page(ptr);
-
-	idx = virt_to_fix(vaddr);
-	pte = kmap_pte - (idx - FIX_KMAP_BEGIN);
-	return pte_page(*pte);
-}
-
 static void __init kmap_pages_init(void)
 {
 	unsigned long vaddr;
diff --git a/arch/nds32/include/asm/highmem.h b/arch/nds32/include/asm/highmem.h
index 4d21308549c9..a48a6536d41a 100644
--- a/arch/nds32/include/asm/highmem.h
+++ b/arch/nds32/include/asm/highmem.h
@@ -52,7 +52,6 @@ extern void kmap_init(void);
  */
 #ifdef CONFIG_HIGHMEM
 extern void *kmap_atomic_pfn(unsigned long pfn);
-extern struct page *kmap_atomic_to_page(void *ptr);
 #endif
 
 #endif
-- 
2.25.1
