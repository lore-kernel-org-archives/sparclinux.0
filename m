From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 02 Aug 2017 20:38:21 +0000
Subject: [v4 12/15] mm: explicitly zero pagetable memory
Message-Id: <1501706304-869240-13-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1501706304-869240-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1501706304-869240-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Soon vmemmap_alloc_block() will no longer zero the block, so zero memory
at its call sites for everything except struct pages.  Struct page memory
is zero'd by struct page initialization.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
---
 mm/sparse-vmemmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index c50b1a14d55e..d40c721ab19f 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -191,6 +191,7 @@ pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
 		void *p = vmemmap_alloc_block(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
+		memset(p, 0, PAGE_SIZE);
 		pmd_populate_kernel(&init_mm, pmd, p);
 	}
 	return pmd;
@@ -203,6 +204,7 @@ pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
 		void *p = vmemmap_alloc_block(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
+		memset(p, 0, PAGE_SIZE);
 		pud_populate(&init_mm, pud, p);
 	}
 	return pud;
@@ -215,6 +217,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 		void *p = vmemmap_alloc_block(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
+		memset(p, 0, PAGE_SIZE);
 		p4d_populate(&init_mm, p4d, p);
 	}
 	return p4d;
@@ -227,6 +230,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 		void *p = vmemmap_alloc_block(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
+		memset(p, 0, PAGE_SIZE);
 		pgd_populate(&init_mm, pgd, p);
 	}
 	return pgd;
-- 
2.13.3

