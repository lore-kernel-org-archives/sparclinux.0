From: David Miller <davem@davemloft.net>
Date: Tue, 06 May 2014 04:08:27 +0000
Subject: [PATCH 04/11] sparc64: Fix hex values in comment above pte_modify().
Message-Id: <20140506.000827.1399413312639226136.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


When _PAGE_SPECIAL and _PAGE_PMD_HUGE were added to the mask, the
comment was not updated.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 1f28103..50b2d78 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -258,8 +258,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t prot)
 {
 	unsigned long mask, tmp;
 
-	/* SUN4U: 0x600307ffffffecb8 (negated = 0x9ffcf80000001347)
-	 * SUN4V: 0x30ffffffffffee17 (negated = 0xcf000000000011e8)
+	/* SUN4U: 0x630107ffffffecb8 (negated = 0x9cfef80000001347)
+	 * SUN4V: 0x33ffffffffffee17 (negated = 0xcc000000000011e8)
 	 *
 	 * Even if we use negation tricks the result is still a 6
 	 * instruction sequence, so don't try to play fancy and just
-- 
1.8.1.2

