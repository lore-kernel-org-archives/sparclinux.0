From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 02 Aug 2017 20:38:18 +0000
Subject: [v4 09/15] sparc64: optimized struct page zeroing
Message-Id: <1501706304-869240-10-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1501706304-869240-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1501706304-869240-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add an optimized mm_zero_struct_page(), so struct page's are zeroed without
calling memset(). We do eight regular stores, thus avoid cost of membar.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/include/asm/pgtable_64.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 6fbd931f0570..23ad51ea5340 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -230,6 +230,24 @@ extern unsigned long _PAGE_ALL_SZ_BITS;
 extern struct page *mem_map_zero;
 #define ZERO_PAGE(vaddr)	(mem_map_zero)
 
+/* This macro must be updated when the size of struct page changes,
+ * so use static assert to enforce the assumed size.
+ */
+#define	mm_zero_struct_page(pp)					\
+	do {							\
+		unsigned long *_pp = (void *)(pp);		\
+								\
+		BUILD_BUG_ON(sizeof(struct page) != 64);	\
+		_pp[0] = 0;					\
+		_pp[1] = 0;					\
+		_pp[2] = 0;					\
+		_pp[3] = 0;					\
+		_pp[4] = 0;					\
+		_pp[5] = 0;					\
+		_pp[6] = 0;					\
+		_pp[7] = 0;					\
+	} while (0)
+
 /* PFNs are real physical page numbers.  However, mem_map only begins to record
  * per-page information starting at pfn_base.  This is to handle systems where
  * the first physical page in the machine is at some huge physical address,
-- 
2.13.3

