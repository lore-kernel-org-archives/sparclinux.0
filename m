From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 07 Aug 2017 20:38:42 +0000
Subject: [v6 08/15] mm: zero struct pages during initialization
Message-Id: <1502138329-123460-9-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add struct page zeroing as a part of initialization of other fields in
__init_single_page().

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
---
 include/linux/mm.h | 9 +++++++++
 mm/page_alloc.c    | 1 +
 2 files changed, 10 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 46b9ac5e8569..183ac5e733db 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -93,6 +93,15 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #define mm_forbids_zeropage(X)	(0)
 #endif
 
+/*
+ * On some architectures it is expensive to call memset() for small sizes.
+ * Those architectures should provide their own implementation of "struct page"
+ * zeroing by defining this macro in <asm/pgtable.h>.
+ */
+#ifndef mm_zero_struct_page
+#define mm_zero_struct_page(pp)  ((void)memset((pp), 0, sizeof(struct page)))
+#endif
+
 /*
  * Default maximum number of active map areas, this limits the number of vmas
  * per mm struct. Users can overwrite this number by sysctl but there is a
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 983de0a8047b..4d32c1fa4c6c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1168,6 +1168,7 @@ static void free_one_page(struct zone *zone,
 static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid)
 {
+	mm_zero_struct_page(page);
 	set_page_links(page, zone, nid, pfn);
 	init_page_count(page);
 	page_mapcount_reset(page);
-- 
2.14.0

