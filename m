From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 13 Oct 2017 17:32:11 +0000
Subject: [PATCH v12 08/11] arm64/kasan: add and use kasan_map_populate()
Message-Id: <20171013173214.27300-9-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171013173214.27300-1-pasha.tatashin@oracle.com>
In-Reply-To: <20171013173214.27300-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

During early boot, kasan uses vmemmap_populate() to establish its shadow
memory. But, that interface is intended for struct pages use.

Because of the current project, vmemmap won't be zeroed during allocation,
but kasan expects that memory to be zeroed. We are adding a new
kasan_map_populate() function to resolve this difference.

Therefore, we must use a new interface to allocate and map kasan shadow
memory, that also zeroes memory for us.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/arm64/mm/kasan_init.c | 72 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 81f03959a4ab..cb4af2951c90 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -28,6 +28,66 @@
 
 static pgd_t tmp_pg_dir[PTRS_PER_PGD] __initdata __aligned(PGD_SIZE);
 
+/* Creates mappings for kasan during early boot. The mapped memory is zeroed */
+static int __meminit kasan_map_populate(unsigned long start, unsigned long end,
+					int node)
+{
+	unsigned long addr, pfn, next;
+	unsigned long long size;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	int ret;
+
+	ret = vmemmap_populate(start, end, node);
+	/*
+	 * We might have partially populated memory, so check for no entries,
+	 * and zero only those that actually exist.
+	 */
+	for (addr = start; addr < end; addr = next) {
+		pgd = pgd_offset_k(addr);
+		if (pgd_none(*pgd)) {
+			next = pgd_addr_end(addr, end);
+			continue;
+		}
+
+		pud = pud_offset(pgd, addr);
+		if (pud_none(*pud)) {
+			next = pud_addr_end(addr, end);
+			continue;
+		}
+		if (pud_sect(*pud)) {
+			/* This is PUD size page */
+			next = pud_addr_end(addr, end);
+			size = PUD_SIZE;
+			pfn = pud_pfn(*pud);
+		} else {
+			pmd = pmd_offset(pud, addr);
+			if (pmd_none(*pmd)) {
+				next = pmd_addr_end(addr, end);
+				continue;
+			}
+			if (pmd_sect(*pmd)) {
+				/* This is PMD size page */
+				next = pmd_addr_end(addr, end);
+				size = PMD_SIZE;
+				pfn = pmd_pfn(*pmd);
+			} else {
+				pte = pte_offset_kernel(pmd, addr);
+				next = addr + PAGE_SIZE;
+				if (pte_none(*pte))
+					continue;
+				/* This is base size page */
+				size = PAGE_SIZE;
+				pfn = pte_pfn(*pte);
+			}
+		}
+		memset(phys_to_virt(PFN_PHYS(pfn)), 0, size);
+	}
+	return ret;
+}
+
 /*
  * The p*d_populate functions call virt_to_phys implicitly so they can't be used
  * directly on kernel symbols (bm_p*d). All the early functions are called too
@@ -161,11 +221,11 @@ void __init kasan_init(void)
 
 	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
 
-	vmemmap_populate(kimg_shadow_start, kimg_shadow_end,
-			 pfn_to_nid(virt_to_pfn(lm_alias(_text))));
+	kasan_map_populate(kimg_shadow_start, kimg_shadow_end,
+			   pfn_to_nid(virt_to_pfn(lm_alias(_text))));
 
 	/*
-	 * vmemmap_populate() has populated the shadow region that covers the
+	 * kasan_map_populate() has populated the shadow region that covers the
 	 * kernel image with SWAPPER_BLOCK_SIZE mappings, so we have to round
 	 * the start and end addresses to SWAPPER_BLOCK_SIZE as well, to prevent
 	 * kasan_populate_zero_shadow() from replacing the page table entries
@@ -191,9 +251,9 @@ void __init kasan_init(void)
 		if (start >= end)
 			break;
 
-		vmemmap_populate((unsigned long)kasan_mem_to_shadow(start),
-				(unsigned long)kasan_mem_to_shadow(end),
-				pfn_to_nid(virt_to_pfn(start)));
+		kasan_map_populate((unsigned long)kasan_mem_to_shadow(start),
+				   (unsigned long)kasan_mem_to_shadow(end),
+				   pfn_to_nid(virt_to_pfn(start)));
 	}
 
 	/*
-- 
2.14.2

