From: Arvind Sankar <nivedita@alum.mit.edu>
Date: Thu, 23 Jul 2020 23:15:42 +0000
Subject: [PATCH 1/3] x86/mm: Drop unused MAX_PHYSADDR_BITS
Message-Id: <20200723231544.17274-2-nivedita@alum.mit.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20200723231544.17274-1-nivedita@alum.mit.edu>
In-Reply-To: <20200723231544.17274-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org

The macro is not used anywhere, and has an incorrect value (going by the
comment) on x86_64 since commit
  c898faf91b3e ("x86: 46 bit physical address support on 64 bits")

To avoid confusion, just remove the definition.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/include/asm/sparsemem.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 199218719a86..6bfc878f6771 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -10,24 +10,20 @@
  *    field of the struct page
  *
  * SECTION_SIZE_BITS		2^n: size of each section
- * MAX_PHYSADDR_BITS		2^n: max size of physical address space
- * MAX_PHYSMEM_BITS		2^n: how much memory we can have in that space
+ * MAX_PHYSMEM_BITS		2^n: max size of physical address space
  *
  */
 
 #ifdef CONFIG_X86_32
 # ifdef CONFIG_X86_PAE
 #  define SECTION_SIZE_BITS	29
-#  define MAX_PHYSADDR_BITS	36
 #  define MAX_PHYSMEM_BITS	36
 # else
 #  define SECTION_SIZE_BITS	26
-#  define MAX_PHYSADDR_BITS	32
 #  define MAX_PHYSMEM_BITS	32
 # endif
 #else /* CONFIG_X86_32 */
 # define SECTION_SIZE_BITS	27 /* matt - 128 is convenient right now */
-# define MAX_PHYSADDR_BITS	(pgtable_l5_enabled() ? 52 : 44)
 # define MAX_PHYSMEM_BITS	(pgtable_l5_enabled() ? 52 : 46)
 #endif
 
-- 
2.26.2
