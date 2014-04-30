From: David Miller <davem@davemloft.net>
Date: Wed, 30 Apr 2014 21:55:48 +0000
Subject: [PATCH 08/10] sparc64: Fix range check in kern_addr_valid().
Message-Id: <20140430.175548.327746802251623616.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


In commit b2d438348024b75a1ee8b66b85d77f569a5dfed8 ("sparc64: Make
PAGE_OFFSET variable."), the MAX_PHYS_ADDRESS_BITS value was increased
(to 47).

This constant reference to '41UL' was missed.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index ac5f708..ff97960 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -916,7 +916,7 @@ static inline bool kern_addr_valid(unsigned long addr)
 {
 	unsigned long paddr = __pa(addr);
 
-	if ((paddr >> 41UL) != 0UL)
+	if ((paddr >> MAX_PHYS_ADDRESS_BITS) != 0UL)
 		return false;
 	return test_bit(paddr >> 22, sparc64_valid_addr_bitmap);
 }
-- 
1.8.1.2

