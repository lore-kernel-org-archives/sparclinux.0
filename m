From: David Miller <davem@davemloft.net>
Date: Tue, 06 May 2014 04:08:33 +0000
Subject: [PATCH 05/11] sparc64: Don't use _PAGE_PRESENT in pte_modify() mask.
Message-Id: <20140506.000833.2113522430971267173.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_64.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 50b2d78..ac5f708 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -258,8 +258,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t prot)
 {
 	unsigned long mask, tmp;
 
-	/* SUN4U: 0x630107ffffffecb8 (negated = 0x9cfef80000001347)
-	 * SUN4V: 0x33ffffffffffee17 (negated = 0xcc000000000011e8)
+	/* SUN4U: 0x630107ffffffec38 (negated = 0x9cfef800000013c7)
+	 * SUN4V: 0x33ffffffffffee07 (negated = 0xcc000000000011f8)
 	 *
 	 * Even if we use negation tricks the result is still a 6
 	 * instruction sequence, so don't try to play fancy and just
@@ -289,10 +289,10 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t prot)
 	"	.previous\n"
 	: "=r" (mask), "=r" (tmp)
 	: "i" (_PAGE_PADDR_4U | _PAGE_MODIFIED_4U | _PAGE_ACCESSED_4U |
-	       _PAGE_CP_4U | _PAGE_CV_4U | _PAGE_E_4U | _PAGE_PRESENT_4U |
+	       _PAGE_CP_4U | _PAGE_CV_4U | _PAGE_E_4U |
 	       _PAGE_SPECIAL | _PAGE_PMD_HUGE | _PAGE_SZALL_4U),
 	  "i" (_PAGE_PADDR_4V | _PAGE_MODIFIED_4V | _PAGE_ACCESSED_4V |
-	       _PAGE_CP_4V | _PAGE_CV_4V | _PAGE_E_4V | _PAGE_PRESENT_4V |
+	       _PAGE_CP_4V | _PAGE_CV_4V | _PAGE_E_4V |
 	       _PAGE_SPECIAL | _PAGE_PMD_HUGE | _PAGE_SZALL_4V));
 
 	return __pte((pte_val(pte) & mask) | (pgprot_val(prot) & ~mask));
-- 
1.8.1.2

