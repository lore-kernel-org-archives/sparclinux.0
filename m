From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 13 Oct 2017 17:32:13 +0000
Subject: [PATCH v12 10/11] sparc64: optimized struct page zeroing
Message-Id: <20171013173214.27300-11-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171013173214.27300-1-pasha.tatashin@oracle.com>
In-Reply-To: <20171013173214.27300-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add an optimized mm_zero_struct_page(), so struct page's are zeroed without
calling memset(). We do eight to ten regular stores based on the size of
struct page. Compiler optimizes out the conditions of switch() statement.

SPARC-M6 with 15T of memory, single thread performance:

                               BASE            FIX  OPTIMIZED_FIX
        bootmem_init   28.440467985s   2.305674818s   2.305161615s
free_area_init_nodes  202.845901673s 225.343084508s 172.556506560s
                      --------------------------------------------
Total                 231.286369658s 227.648759326s 174.861668175s

BASE:  current linux
FIX:   This patch series without "optimized struct page zeroing"
OPTIMIZED_FIX: This patch series including the current patch.

bootmem_init() is where memory for struct pages is zeroed during
allocation. Note, about two seconds in this function is a fixed time: it
does not increase as memory is increased.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Acked-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_64.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 4fefe3762083..8ed478abc630 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -230,6 +230,36 @@ extern unsigned long _PAGE_ALL_SZ_BITS;
 extern struct page *mem_map_zero;
 #define ZERO_PAGE(vaddr)	(mem_map_zero)
 
+/* This macro must be updated when the size of struct page grows above 80
+ * or reduces below 64.
+ * The idea that compiler optimizes out switch() statement, and only
+ * leaves clrx instructions
+ */
+#define	mm_zero_struct_page(pp) do {					\
+	unsigned long *_pp = (void *)(pp);				\
+									\
+	 /* Check that struct page is either 64, 72, or 80 bytes */	\
+	BUILD_BUG_ON(sizeof(struct page) & 7);				\
+	BUILD_BUG_ON(sizeof(struct page) < 64);				\
+	BUILD_BUG_ON(sizeof(struct page) > 80);				\
+									\
+	switch (sizeof(struct page)) {					\
+	case 80:							\
+		_pp[9] = 0;	/* fallthrough */			\
+	case 72:							\
+		_pp[8] = 0;	/* fallthrough */			\
+	default:							\
+		_pp[7] = 0;						\
+		_pp[6] = 0;						\
+		_pp[5] = 0;						\
+		_pp[4] = 0;						\
+		_pp[3] = 0;						\
+		_pp[2] = 0;						\
+		_pp[1] = 0;						\
+		_pp[0] = 0;						\
+	}								\
+} while (0)
+
 /* PFNs are real physical page numbers.  However, mem_map only begins to record
  * per-page information starting at pfn_base.  This is to handle systems where
  * the first physical page in the machine is at some huge physical address,
-- 
2.14.2

