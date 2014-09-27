From: David Miller <davem@davemloft.net>
Date: Sat, 27 Sep 2014 18:28:52 +0000
Subject: [PATCH 6/8] sparc64: Increase MAX_PHYS_ADDRESS_BITS to 53.
Message-Id: <20140927.142852.1583970678243070733.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Make sure, at compile time, that the kernel can properly support
whatever MAX_PHYS_ADDRESS_BITS is defined to.

On M7 chips, use a max_phys_bits value of 49.

Based upon a patch by Bob Picco.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/page_64.h    | 8 ++++----
 arch/sparc/include/asm/pgtable_64.h | 4 ++++
 arch/sparc/mm/init_64.c             | 9 ++++++++-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index 732ba17..6784a33 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -122,11 +122,11 @@ extern unsigned long PAGE_OFFSET;
 
 #endif /* !(__ASSEMBLY__) */
 
-/* The maximum number of physical memory address bits we support, this
- * is used to size various tables used to manage kernel TLB misses and
- * also the sparsemem code.
+/* The maximum number of physical memory address bits we support.  The
+ * largest value we can support is whatever "KPGD_SHIFT + KPTE_BITS"
+ * evaluates to.
  */
-#define MAX_PHYS_ADDRESS_BITS	47
+#define MAX_PHYS_ADDRESS_BITS	53
 
 #define ILOG2_4MB		22
 #define ILOG2_256MB		28
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index a305b22..0552957 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -67,6 +67,10 @@
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 #define PGDIR_BITS	(PAGE_SHIFT - 3)
 
+#if (MAX_PHYS_ADDRESS_BITS > PGDIR_SHIFT + PGDIR_BITS)
+#error MAX_PHYS_ADDRESS_BITS exceeds what kernel page tables can support
+#endif
+
 #if (PGDIR_SHIFT + PGDIR_BITS) != 53
 #error Page table parameters do not cover virtual address space properly.
 #endif
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index bbfc6f2..7f34a47 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1690,12 +1690,19 @@ static void __init setup_page_offset(void)
 		case SUN4V_CHIP_NIAGARA4:
 		case SUN4V_CHIP_NIAGARA5:
 		case SUN4V_CHIP_SPARC64X:
-		default:
+		case SUN4V_CHIP_SPARC_M6:
 			/* T4 and later support 52-bit virtual addresses.  */
 			sparc64_va_hole_top =    0xfff8000000000000UL;
 			sparc64_va_hole_bottom = 0x0008000000000000UL;
 			max_phys_bits = 47;
 			break;
+		case SUN4V_CHIP_SPARC_M7:
+		default:
+			/* M7 and later support 52-bit virtual addresses.  */
+			sparc64_va_hole_top =    0xfff8000000000000UL;
+			sparc64_va_hole_bottom = 0x0008000000000000UL;
+			max_phys_bits = 49;
+			break;
 		}
 	}
 
-- 
1.8.1.2

