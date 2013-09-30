From: David Miller <davem@davemloft.net>
Date: Mon, 30 Sep 2013 16:31:43 +0000
Subject: [PATCH 2/9] sparc64: Use PAGE_OFFSET instead of a magic constant.
Message-Id: <20130930.123143.1113842638319768748.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This pertains to all of the computations of the kernel fast
TLB miss xor values.

Based upon a patch by Bob Picco.

Signed-off-by: David S. Miller <davem@davemloft.net>
Acked-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/mm/init_64.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index ed82eda..e295a5b 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1722,7 +1722,7 @@ static void __init sun4v_linear_pte_xor_finalize(void)
 #ifndef CONFIG_DEBUG_PAGEALLOC
 	if (cpu_pgsz_mask & HV_PGSZ_MASK_256MB) {
 		kern_linear_pte_xor[1] = (_PAGE_VALID | _PAGE_SZ256MB_4V) ^
-			0xfffff80000000000UL;
+			PAGE_OFFSET;
 		kern_linear_pte_xor[1] |= (_PAGE_CP_4V | _PAGE_CV_4V |
 					   _PAGE_P_4V | _PAGE_W_4V);
 	} else {
@@ -1731,7 +1731,7 @@ static void __init sun4v_linear_pte_xor_finalize(void)
 
 	if (cpu_pgsz_mask & HV_PGSZ_MASK_2GB) {
 		kern_linear_pte_xor[2] = (_PAGE_VALID | _PAGE_SZ2GB_4V) ^
-			0xfffff80000000000UL;
+			PAGE_OFFSET;
 		kern_linear_pte_xor[2] |= (_PAGE_CP_4V | _PAGE_CV_4V |
 					   _PAGE_P_4V | _PAGE_W_4V);
 	} else {
@@ -1740,7 +1740,7 @@ static void __init sun4v_linear_pte_xor_finalize(void)
 
 	if (cpu_pgsz_mask & HV_PGSZ_MASK_16GB) {
 		kern_linear_pte_xor[3] = (_PAGE_VALID | _PAGE_SZ16GB_4V) ^
-			0xfffff80000000000UL;
+			PAGE_OFFSET;
 		kern_linear_pte_xor[3] |= (_PAGE_CP_4V | _PAGE_CV_4V |
 					   _PAGE_P_4V | _PAGE_W_4V);
 	} else {
@@ -2261,10 +2261,10 @@ static void __init sun4u_pgprot_init(void)
 		     __ACCESS_BITS_4U | _PAGE_E_4U);
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-	kern_linear_pte_xor[0] = _PAGE_VALID ^ 0xfffff80000000000UL;
+	kern_linear_pte_xor[0] = _PAGE_VALID ^ PAGE_OFFSET;
 #else
 	kern_linear_pte_xor[0] = (_PAGE_VALID | _PAGE_SZ4MB_4U) ^
-		0xfffff80000000000UL;
+		PAGE_OFFSET;
 #endif
 	kern_linear_pte_xor[0] |= (_PAGE_CP_4U | _PAGE_CV_4U |
 				   _PAGE_P_4U | _PAGE_W_4U);
@@ -2308,10 +2308,10 @@ static void __init sun4v_pgprot_init(void)
 	_PAGE_CACHE = _PAGE_CACHE_4V;
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-	kern_linear_pte_xor[0] = _PAGE_VALID ^ 0xfffff80000000000UL;
+	kern_linear_pte_xor[0] = _PAGE_VALID ^ PAGE_OFFSET;
 #else
 	kern_linear_pte_xor[0] = (_PAGE_VALID | _PAGE_SZ4MB_4V) ^
-		0xfffff80000000000UL;
+		PAGE_OFFSET;
 #endif
 	kern_linear_pte_xor[0] |= (_PAGE_CP_4V | _PAGE_CV_4V |
 				   _PAGE_P_4V | _PAGE_W_4V);
-- 
1.8.1.2

