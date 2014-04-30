From: David Miller <davem@davemloft.net>
Date: Wed, 30 Apr 2014 21:56:05 +0000
Subject: [PATCH 10/10] sparc64: Give more detailed information in {pgd,pmd}_ERROR() and kill pte_ERROR().
Message-Id: <20140430.175605.387378887277685875.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


pte_ERROR() is not used anywhere, delete it.

For pgd_ERROR() and pmd_ERROR(), output something similar to x86, giving the address
of the pgd/pmd as well as it's value.

Also provide the caller, since these macros are invoked from pgd_clear_bad() and
pmd_clear_bad() which provides little context as to what high level operation was
occuring when the BAD state was detected.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_64.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index fd4dbdd..aafa0f0 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -96,9 +96,12 @@ static inline bool kern_addr_valid(unsigned long addr)
 /* Kernel has a separate 44bit address space. */
 #define FIRST_USER_ADDRESS	0
 
-#define pte_ERROR(e)	__builtin_trap()
-#define pmd_ERROR(e)	__builtin_trap()
-#define pgd_ERROR(e)	__builtin_trap()
+#define pmd_ERROR(e)							\
+	pr_err("%s:%d: bad pmd %p(%016lx) seen at (%pS)\n",		\
+	       __FILE__, __LINE__, &(e), pmd_val(e), __builtin_return_address(0))
+#define pgd_ERROR(e)							\
+	pr_err("%s:%d: bad pgd %p(%016lx) seen at (%pS)\n",		\
+	       __FILE__, __LINE__, &(e), pgd_val(e), __builtin_return_address(0))
 
 #endif /* !(__ASSEMBLY__) */
 
-- 
1.8.1.2

