From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 16 Dec 2016 18:35:28 +0000
Subject: [RFC PATCH 05/14] sparc64: Add PAGE_SHR_CTX flag
Message-Id: <1481913337-9331-6-git-send-email-mike.kravetz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1481913337-9331-1-git-send-email-mike.kravetz@oracle.com>
In-Reply-To: <1481913337-9331-1-git-send-email-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Bob Picco <bob.picco@oracle.com>, Nitin Gupta <nitin.m.gupta@oracle.com>, Vijay Kumar <vijay.ac.kumar@oracle.com>, Julian Calaby <julian.calaby@gmail.com>, Adam Buchbinder <adam.buchbinder@gmail.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Kravetz <mike.kravetz@oracle.com>

This new page flag is used to identify pages which are associated with
a shared context ID.  It is needed at page fault time when we only
have access to the PTE and need to determine whether the associated
TSB entry should be associated with the regular ot shared context TSB.

A new helper routine is_sharedctx_pte() is also added.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 arch/sparc/include/asm/pgtable_64.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 1fb317f..f2fd088 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -166,6 +166,7 @@ bool kern_addr_valid(unsigned long addr);
 #define _PAGE_EXEC_4V	  _AC(0x0000000000000080,UL) /* Executable Page      */
 #define _PAGE_W_4V	  _AC(0x0000000000000040,UL) /* Writable             */
 #define _PAGE_SOFT_4V	  _AC(0x0000000000000030,UL) /* Software bits        */
+#define _PAGE_SHR_CTX_4V  _AC(0x0000000000000020,UL) /* Shared Context       */
 #define _PAGE_PRESENT_4V  _AC(0x0000000000000010,UL) /* Present              */
 #define _PAGE_RESV_4V	  _AC(0x0000000000000008,UL) /* Reserved             */
 #define _PAGE_SZ16GB_4V	  _AC(0x0000000000000007,UL) /* 16GB Page            */
@@ -426,6 +427,18 @@ static inline bool is_hugetlb_pte(pte_t pte)
 }
 #endif
 
+#if defined(CONFIG_SHARED_MMU_CTX)
+static inline bool is_sharedctx_pte(pte_t pte)
+{
+	return !!(pte_val(pte) & _PAGE_SHR_CTX_4V);
+}
+#else
+static inline bool is_sharedctx_pte(pte_t pte)
+{
+	return false;
+}
+#endif
+
 static inline pte_t pte_mkdirty(pte_t pte)
 {
 	unsigned long val = pte_val(pte), tmp;
-- 
2.7.4

