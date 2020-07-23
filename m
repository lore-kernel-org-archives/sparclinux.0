From: Arvind Sankar <nivedita@alum.mit.edu>
Date: Thu, 23 Jul 2020 23:15:44 +0000
Subject: [PATCH 3/3] sparc: Drop unused MAX_PHYSADDR_BITS
Message-Id: <20200723231544.17274-4-nivedita@alum.mit.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20200723231544.17274-1-nivedita@alum.mit.edu>
In-Reply-To: <20200723231544.17274-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org

The macro is not used anywhere, so remove the definition.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/sparc/include/asm/sparsemem.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/include/asm/sparsemem.h b/arch/sparc/include/asm/sparsemem.h
index 1dd1b61432db..aa9a676bc341 100644
--- a/arch/sparc/include/asm/sparsemem.h
+++ b/arch/sparc/include/asm/sparsemem.h
@@ -7,7 +7,6 @@
 #include <asm/page.h>
 
 #define SECTION_SIZE_BITS       30
-#define MAX_PHYSADDR_BITS       MAX_PHYS_ADDRESS_BITS
 #define MAX_PHYSMEM_BITS        MAX_PHYS_ADDRESS_BITS
 
 #endif /* !(__KERNEL__) */
-- 
2.26.2
