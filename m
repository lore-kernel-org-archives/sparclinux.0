From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 04:36:22 +0000
Subject: [PATCH] sparc32: Remove ldXa and stXa defines, unused.
Message-Id: <20120512.003622.2196388880846959984.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


These were for sharing some MMU code between sun4 and sun4c.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/asmmacro.h |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/sparc/include/asm/asmmacro.h b/arch/sparc/include/asm/asmmacro.h
index a995bf8..90db649 100644
--- a/arch/sparc/include/asm/asmmacro.h
+++ b/arch/sparc/include/asm/asmmacro.h
@@ -31,10 +31,4 @@
 /* All traps low-level code here must end with this macro. */
 #define RESTORE_ALL b ret_trap_entry; clr %l6;
 
-/* sun4 probably wants half word accesses to ASI_SEGMAP, while sun4c+
-   likes byte accesses. These are to avoid ifdef mania. */
-
-#define lduXa	lduba
-#define stXa	stba
-
 #endif /* !(_SPARC_ASMMACRO_H) */
-- 
1.7.10

