From: Arvind Sankar <nivedita@alum.mit.edu>
Date: Thu, 23 Jul 2020 23:15:43 +0000
Subject: [PATCH 2/3] sh/mm: Drop unused MAX_PHYSADDR_BITS
Message-Id: <20200723231544.17274-3-nivedita@alum.mit.edu>
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
 arch/sh/include/asm/sparsemem.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sh/include/asm/sparsemem.h b/arch/sh/include/asm/sparsemem.h
index 4eb899751e45..084706bb8cca 100644
--- a/arch/sh/include/asm/sparsemem.h
+++ b/arch/sh/include/asm/sparsemem.h
@@ -5,11 +5,9 @@
 #ifdef __KERNEL__
 /*
  * SECTION_SIZE_BITS		2^N: how big each section will be
- * MAX_PHYSADDR_BITS		2^N: how much physical address space we have
- * MAX_PHYSMEM_BITS		2^N: how much memory we can have in that space
+ * MAX_PHYSMEM_BITS		2^N: how much physical address space we have
  */
 #define SECTION_SIZE_BITS	26
-#define MAX_PHYSADDR_BITS	32
 #define MAX_PHYSMEM_BITS	32
 
 #endif
-- 
2.26.2
