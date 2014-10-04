From: David Miller <davem@davemloft.net>
Date: Sat, 04 Oct 2014 23:26:46 +0000
Subject: [PATCH 2/9] sparc64: Define VA hole at run time, rather than at compile time.
Message-Id: <20141004.192646.1822710057249508337.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Now that we use 4-level page tables, we can provide up to 53-bits of
virtual address space to the user.

Adjust the VA hole based upon the capabilities of the cpu type probed.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/page_64.h | 15 ++++-----------
 arch/sparc/mm/init_64.c          | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index 09ceb68..2211a80 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -102,21 +102,14 @@ typedef unsigned long pgprot_t;
 
 typedef pte_t *pgtable_t;
 
-/* These two values define the virtual address space range in which we
- * must forbid 64-bit user processes from making mappings.  It used to
- * represent precisely the virtual address space hole present in most
- * early sparc64 chips including UltraSPARC-I.  But now it also is
- * further constrained by the limits of our page tables, which is
- * 43-bits of virtual address.
- */
-#define SPARC64_VA_HOLE_TOP	_AC(0xfffffc0000000000,UL)
-#define SPARC64_VA_HOLE_BOTTOM	_AC(0x0000040000000000,UL)
+extern unsigned long sparc64_va_hole_top;
+extern unsigned long sparc64_va_hole_bottom;
 
 /* The next two defines specify the actual exclusion region we
  * enforce, wherein we use a 4GB red zone on each side of the VA hole.
  */
-#define VA_EXCLUDE_START (SPARC64_VA_HOLE_BOTTOM - (1UL << 32UL))
-#define VA_EXCLUDE_END   (SPARC64_VA_HOLE_TOP + (1UL << 32UL))
+#define VA_EXCLUDE_START (sparc64_va_hole_bottom - (1UL << 32UL))
+#define VA_EXCLUDE_END   (sparc64_va_hole_top + (1UL << 32UL))
 
 #define TASK_UNMAPPED_BASE	(test_thread_flag(TIF_32BIT) ? \
 				 _AC(0x0000000070000000,UL) : \
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index a6c0a30..082fde1 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1630,25 +1630,46 @@ static void __init page_offset_shift_patch(unsigned long phys_bits)
 	}
 }
 
+unsigned long sparc64_va_hole_top =    0xfffff80000000000UL;
+unsigned long sparc64_va_hole_bottom = 0x0000080000000000UL;
+
 static void __init setup_page_offset(void)
 {
 	unsigned long max_phys_bits = 40;
 
 	if (tlb_type = cheetah || tlb_type = cheetah_plus) {
+		/* Cheetah/Panther support a full 64-bit virtual
+		 * address, so we can use all that our page tables
+		 * support.
+		 */
+		sparc64_va_hole_top =    0xfff0000000000000UL;
+		sparc64_va_hole_bottom = 0x0010000000000000UL;
+
 		max_phys_bits = 42;
 	} else if (tlb_type = hypervisor) {
 		switch (sun4v_chip_type) {
 		case SUN4V_CHIP_NIAGARA1:
 		case SUN4V_CHIP_NIAGARA2:
+			/* T1 and T2 support 48-bit virtual addresses.  */
+			sparc64_va_hole_top =    0xffff800000000000UL;
+			sparc64_va_hole_bottom = 0x0000800000000000UL;
+
 			max_phys_bits = 39;
 			break;
 		case SUN4V_CHIP_NIAGARA3:
+			/* T3 supports 48-bit virtual addresses.  */
+			sparc64_va_hole_top =    0xffff800000000000UL;
+			sparc64_va_hole_bottom = 0x0000800000000000UL;
+
 			max_phys_bits = 43;
 			break;
 		case SUN4V_CHIP_NIAGARA4:
 		case SUN4V_CHIP_NIAGARA5:
 		case SUN4V_CHIP_SPARC64X:
 		default:
+			/* T4 and later support 52-bit virtual addresses.  */
+			sparc64_va_hole_top =    0xfff8000000000000UL;
+			sparc64_va_hole_bottom = 0x0008000000000000UL;
 			max_phys_bits = 47;
 			break;
 		}
-- 
1.8.1.2

