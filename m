From: David Miller <davem@davemloft.net>
Date: Sat, 21 Sep 2013 05:15:59 +0000
Subject: [PATCH 1/6] sparc64: Clean up 64-bit mmap exclusion defines.
Message-Id: <20130921.011559.2141699869219807525.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Older UltraSPARC chips had an address space hole due to the MMU only
supporting 44-bits of virtual address.

The top end of this hole also has the same value as the current
definition of PAGE_OFFSET, so this can be confusing.

Consolidate the defines for the userspace mmap exclusion range into
page_64.h and use them in sys_sparc_64.c and hugetlbpage.c

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/page_64.h | 17 +++++++++++++++--
 arch/sparc/kernel/sys_sparc_64.c |  3 ---
 arch/sparc/mm/hugetlbpage.c      |  2 --
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index e155388..d959312 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -93,9 +93,22 @@ typedef unsigned long pgprot_t;
 
 typedef pte_t *pgtable_t;
 
+/* These two values define the virtual address space range in which we
+ * must forbid 64-bit user processes from making mappings.  It
+ * represents the virtual address space hole present in most early
+ * sparc64 chips including UltraSPARC-I.  The next two defines specify
+ * the actual exclusion region we enforce, wherein we use a 4GB red
+ * zone on each side of the VA hole.
+ */
+#define SPARC64_VA_HOLE_TOP	_AC(0xfffff80000000000,UL)
+#define SPARC64_VA_HOLE_BOTTOM	_AC(0x0000080000000000,UL)
+
+#define VA_EXCLUDE_START (SPARC64_VA_HOLE_BOTTOM - (1UL << 32UL))
+#define VA_EXCLUDE_END   (SPARC64_VA_HOLE_TOP + (1UL << 32UL))
+
 #define TASK_UNMAPPED_BASE	(test_thread_flag(TIF_32BIT) ? \
-				 (_AC(0x0000000070000000,UL)) : \
-				 (_AC(0xfffff80000000000,UL) + (1UL << 32UL)))
+				 _AC(0x0000000070000000,UL) : \
+				 VA_EXCLUDE_END)
 
 #include <asm-generic/memory_model.h>
 
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 51561b8..d05eb9c 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -39,9 +39,6 @@ asmlinkage unsigned long sys_getpagesize(void)
 	return PAGE_SIZE;
 }
 
-#define VA_EXCLUDE_START (0x0000080000000000UL - (1UL << 32UL))
-#define VA_EXCLUDE_END   (0xfffff80000000000UL + (1UL << 32UL))
-
 /* Does addr --> addr+len fall within 4GB of the VA-space hole or
  * overflow past the end of the 64-bit address space?
  */
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index d2b5944..8545f62 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -21,8 +21,6 @@
 /* Slightly simplified from the non-hugepage variant because by
  * definition we don't have to worry about any page coloring stuff
  */
-#define VA_EXCLUDE_START (0x0000080000000000UL - (1UL << 32UL))
-#define VA_EXCLUDE_END   (0xfffff80000000000UL + (1UL << 32UL))
 
 static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *filp,
 							unsigned long addr,
-- 
1.8.1.2

