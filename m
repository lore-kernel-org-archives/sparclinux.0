From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 05 Oct 2017 21:11:20 +0000
Subject: [PATCH v10 06/10] mm/kasan: kasan specific map populate function
Message-Id: <20171005211124.26524-7-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171005211124.26524-1-pasha.tatashin@oracle.com>
In-Reply-To: <20171005211124.26524-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

During early boot, kasan uses vmemmap_populate() to establish its shadow
memory. But, that interface is intended for struct pages use.

Because of the current project, vmemmap won't be zeroed during allocation,
but kasan expects that memory to be zeroed. We are adding a new
kasan_map_populate() function to resolve this difference.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/arm64/include/asm/pgtable.h |  3 ++
 include/linux/kasan.h            |  2 ++
 mm/kasan/kasan_init.c            | 67 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b46e54c2399b..11ff58901519 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -381,6 +381,9 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				 PUD_TYPE_TABLE)
 #endif
 
+#define pmd_large(pmd)		pmd_sect(pmd)
+#define pud_large(pud)		pud_sect(pud)
+
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
 	*pmdp = pmd;
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index a5c7046f26b4..7e13df1722c2 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -78,6 +78,8 @@ size_t kasan_metadata_size(struct kmem_cache *cache);
 
 bool kasan_save_enable_multi_shot(void);
 void kasan_restore_multi_shot(bool enabled);
+int __meminit kasan_map_populate(unsigned long start, unsigned long end,
+				 int node);
 
 #else /* CONFIG_KASAN */
 
diff --git a/mm/kasan/kasan_init.c b/mm/kasan/kasan_init.c
index 554e4c0f23a2..57a973f05f63 100644
--- a/mm/kasan/kasan_init.c
+++ b/mm/kasan/kasan_init.c
@@ -197,3 +197,70 @@ void __init kasan_populate_zero_shadow(const void *shadow_start,
 		zero_p4d_populate(pgd, addr, next);
 	} while (pgd++, addr = next, addr != end);
 }
+
+/* Creates mappings for kasan during early boot. The mapped memory is zeroed */
+int __meminit kasan_map_populate(unsigned long start, unsigned long end,
+				 int node)
+{
+	unsigned long addr, pfn, next;
+	unsigned long long size;
+	pgd_t *pgd;
+	p4d_t *p4d;
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
+		p4d = p4d_offset(pgd, addr);
+		if (p4d_none(*p4d)) {
+			next = p4d_addr_end(addr, end);
+			continue;
+		}
+
+		pud = pud_offset(p4d, addr);
+		if (pud_none(*pud)) {
+			next = pud_addr_end(addr, end);
+			continue;
+		}
+		if (pud_large(*pud)) {
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
+			if (pmd_large(*pmd)) {
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
-- 
2.14.2

