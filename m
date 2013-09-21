From: David Miller <davem@davemloft.net>
Date: Sat, 21 Sep 2013 05:16:30 +0000
Subject: [PATCH 5/6] sparc64: Fix inconsistent max-physical-address defines.
Message-Id: <20130921.011630.1418111133842440021.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Some parts of the code use '41' others use '42', make them
all use the same value.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/sparsemem.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/sparsemem.h b/arch/sparc/include/asm/sparsemem.h
index b99d4e4..e5e1752 100644
--- a/arch/sparc/include/asm/sparsemem.h
+++ b/arch/sparc/include/asm/sparsemem.h
@@ -3,9 +3,11 @@
 
 #ifdef __KERNEL__
 
+#include <asm/page.h>
+
 #define SECTION_SIZE_BITS       30
-#define MAX_PHYSADDR_BITS       42
-#define MAX_PHYSMEM_BITS        42
+#define MAX_PHYSADDR_BITS       MAX_PHYS_ADDRESS_BITS
+#define MAX_PHYSMEM_BITS        MAX_PHYS_ADDRESS_BITS
 
 #endif /* !(__KERNEL__) */
 
-- 
1.8.1.2

