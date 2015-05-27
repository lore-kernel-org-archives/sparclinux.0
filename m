From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 27 May 2015 16:00:46 +0000
Subject: [PATCH v3] sparc: Resolve conflict between sparc v9 and M7 on usage of bit 9 of TTE
Message-Id: <1432742446-18731-1-git-send-email-khalid.aziz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, bob.picco@oracle.com, kirill.shutemov@linux.intel.com, akpm@linux-foundation.org, sam@ravnborg.org, rickard_strandqvist@spectrumdigital.se, allen.pais@oracle.com, iamjoonsoo.kim@lge.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

sparc: Resolve conflict between sparc v9 and M7 on usage of bit 9 of TTE

Bit 9 of TTE is CV (Cacheable in V-cache) on sparc v9 processor while
the same bit 9 is MCDE (Memory Corruption Detection Enable) on M7
processor. This creates a conflicting usage of the same bit. Kernel
sets TTE.cv bit on all pages for sun4v architecture which works well
for sparc v9 but enables memory corruption detection on M7 processor
which is not the intent. This patch adds code to determine if kernel
is running on M7 processor and takes steps to not enable memory
corruption detection in TTE erroneously.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
v3:
	- Fixed indentations to match current indentation in sparc code
	- Removed superfluous comments before wmb()

v2:
	- Fixed indentation in pgprot_noncached
	- Reduced the instances of computing right cacheability flag
	  for M7 vs older processor by computing it just once in a new
	  variable "page_cache4v_flag"
	- Tested on a M7 and T4

 arch/sparc/include/asm/pgtable_64.h | 22 ++++++++++-
 arch/sparc/include/asm/trap_block.h |  2 +
 arch/sparc/kernel/entry.h           |  2 +
 arch/sparc/kernel/setup_64.c        | 21 +++++++++++
 arch/sparc/kernel/vmlinux.lds.S     |  5 +++
 arch/sparc/mm/init_64.c             | 74 ++++++++++++++++++++++++++-----------
 6 files changed, 104 insertions(+), 22 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index dc165eb..2a52c91 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -308,12 +308,26 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t prot)
 	"	sllx		%1, 32, %1\n"
 	"	or		%0, %1, %0\n"
 	"	.previous\n"
+	"	.section	.sun_m7_2insn_patch, \"ax\"\n"
+	"	.word		661b\n"
+	"	sethi		%%uhi(%4), %1\n"
+	"	sethi		%%hi(%4), %0\n"
+	"	.word		662b\n"
+	"	or		%1, %%ulo(%4), %1\n"
+	"	or		%0, %%lo(%4), %0\n"
+	"	.word		663b\n"
+	"	sllx		%1, 32, %1\n"
+	"	or		%0, %1, %0\n"
+	"	.previous\n"
 	: "=r" (mask), "=r" (tmp)
 	: "i" (_PAGE_PADDR_4U | _PAGE_MODIFIED_4U | _PAGE_ACCESSED_4U |
 	       _PAGE_CP_4U | _PAGE_CV_4U | _PAGE_E_4U |
 	       _PAGE_SPECIAL | _PAGE_PMD_HUGE | _PAGE_SZALL_4U),
 	  "i" (_PAGE_PADDR_4V | _PAGE_MODIFIED_4V | _PAGE_ACCESSED_4V |
 	       _PAGE_CP_4V | _PAGE_CV_4V | _PAGE_E_4V |
+	       _PAGE_SPECIAL | _PAGE_PMD_HUGE | _PAGE_SZALL_4V),
+	  "i" (_PAGE_PADDR_4V | _PAGE_MODIFIED_4V | _PAGE_ACCESSED_4V |
+	       _PAGE_CP_4V | _PAGE_E_4V |
 	       _PAGE_SPECIAL | _PAGE_PMD_HUGE | _PAGE_SZALL_4V));
 
 	return __pte((pte_val(pte) & mask) | (pgprot_val(prot) & ~mask));
@@ -342,9 +356,15 @@ static inline pgprot_t pgprot_noncached(pgprot_t prot)
 	"	andn		%0, %4, %0\n"
 	"	or		%0, %5, %0\n"
 	"	.previous\n"
+	"	.section	.sun_m7_2insn_patch, \"ax\"\n"
+	"	.word		661b\n"
+	"	andn		%0, %6, %0\n"
+	"	or		%0, %5, %0\n"
+	"	.previous\n"
 	: "=r" (val)
 	: "0" (val), "i" (_PAGE_CP_4U | _PAGE_CV_4U), "i" (_PAGE_E_4U),
-	             "i" (_PAGE_CP_4V | _PAGE_CV_4V), "i" (_PAGE_E_4V));
+	             "i" (_PAGE_CP_4V | _PAGE_CV_4V), "i" (_PAGE_E_4V),
+	             "i" (_PAGE_CP_4V));
 
 	return __pgprot(val);
 }
diff --git a/arch/sparc/include/asm/trap_block.h b/arch/sparc/include/asm/trap_block.h
index 6fd4436..ec9c04d 100644
--- a/arch/sparc/include/asm/trap_block.h
+++ b/arch/sparc/include/asm/trap_block.h
@@ -79,6 +79,8 @@ struct sun4v_2insn_patch_entry {
 };
 extern struct sun4v_2insn_patch_entry __sun4v_2insn_patch,
 	__sun4v_2insn_patch_end;
+extern struct sun4v_2insn_patch_entry __sun_m7_2insn_patch,
+	__sun_m7_2insn_patch_end;
 
 
 #endif /* !(__ASSEMBLY__) */
diff --git a/arch/sparc/kernel/entry.h b/arch/sparc/kernel/entry.h
index 07cc49e..0f67942 100644
--- a/arch/sparc/kernel/entry.h
+++ b/arch/sparc/kernel/entry.h
@@ -69,6 +69,8 @@ void sun4v_patch_1insn_range(struct sun4v_1insn_patch_entry *,
 			     struct sun4v_1insn_patch_entry *);
 void sun4v_patch_2insn_range(struct sun4v_2insn_patch_entry *,
 			     struct sun4v_2insn_patch_entry *);
+void sun_m7_patch_2insn_range(struct sun4v_2insn_patch_entry *,
+			     struct sun4v_2insn_patch_entry *);
 extern unsigned int dcache_parity_tl1_occurred;
 extern unsigned int icache_parity_tl1_occurred;
 
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index c38d19f..f7b2617 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -255,6 +255,24 @@ void sun4v_patch_2insn_range(struct sun4v_2insn_patch_entry *start,
 	}
 }
 
+void sun_m7_patch_2insn_range(struct sun4v_2insn_patch_entry *start,
+			     struct sun4v_2insn_patch_entry *end)
+{
+	while (start < end) {
+		unsigned long addr = start->addr;
+
+		*(unsigned int *) (addr +  0) = start->insns[0];
+		wmb();
+		__asm__ __volatile__("flush	%0" : : "r" (addr +  0));
+
+		*(unsigned int *) (addr +  4) = start->insns[1];
+		wmb();
+		__asm__ __volatile__("flush	%0" : : "r" (addr +  4));
+
+		start++;
+	}
+}
+
 static void __init sun4v_patch(void)
 {
 	extern void sun4v_hvapi_init(void);
@@ -267,6 +285,9 @@ static void __init sun4v_patch(void)
 
 	sun4v_patch_2insn_range(&__sun4v_2insn_patch,
 				&__sun4v_2insn_patch_end);
+	if (sun4v_chip_type = SUN4V_CHIP_SPARC_M7)
+		sun_m7_patch_2insn_range(&__sun_m7_2insn_patch,
+					 &__sun_m7_2insn_patch_end);
 
 	sun4v_hvapi_init();
 }
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 0924305..f1a2f68 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -138,6 +138,11 @@ SECTIONS
 		*(.pause_3insn_patch)
 		__pause_3insn_patch_end = .;
 	}
+	.sun_m7_2insn_patch : {
+		__sun_m7_2insn_patch = .;
+		*(.sun_m7_2insn_patch)
+		__sun_m7_2insn_patch_end = .;
+	}
 	PERCPU_SECTION(SMP_CACHE_BYTES)
 
 	. = ALIGN(PAGE_SIZE);
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 4ca0d6b..559cb74 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -54,6 +54,7 @@
 #include "init_64.h"
 
 unsigned long kern_linear_pte_xor[4] __read_mostly;
+static unsigned long page_cache4v_flag;
 
 /* A bitmap, two bits for every 256MB of physical memory.  These two
  * bits determine what page size we use for kernel linear
@@ -1909,11 +1910,24 @@ static void __init sun4u_linear_pte_xor_finalize(void)
 
 static void __init sun4v_linear_pte_xor_finalize(void)
 {
+	unsigned long pagecv_flag;
+
+	/* Bit 9 of TTE is no longer CV bit on M7 processor and it instead
+	 * enables MCD error. Do not set bit 9 on M7 processor.
+	 */
+	switch (sun4v_chip_type) {
+	case SUN4V_CHIP_SPARC_M7:
+		pagecv_flag = 0x00;
+		break;
+	default:
+		pagecv_flag = _PAGE_CV_4V;
+		break;
+	}
 #ifndef CONFIG_DEBUG_PAGEALLOC
 	if (cpu_pgsz_mask & HV_PGSZ_MASK_256MB) {
 		kern_linear_pte_xor[1] = (_PAGE_VALID | _PAGE_SZ256MB_4V) ^
 			PAGE_OFFSET;
-		kern_linear_pte_xor[1] |= (_PAGE_CP_4V | _PAGE_CV_4V |
+		kern_linear_pte_xor[1] |= (_PAGE_CP_4V | pagecv_flag |
 					   _PAGE_P_4V | _PAGE_W_4V);
 	} else {
 		kern_linear_pte_xor[1] = kern_linear_pte_xor[0];
@@ -1922,7 +1936,7 @@ static void __init sun4v_linear_pte_xor_finalize(void)
 	if (cpu_pgsz_mask & HV_PGSZ_MASK_2GB) {
 		kern_linear_pte_xor[2] = (_PAGE_VALID | _PAGE_SZ2GB_4V) ^
 			PAGE_OFFSET;
-		kern_linear_pte_xor[2] |= (_PAGE_CP_4V | _PAGE_CV_4V |
+		kern_linear_pte_xor[2] |= (_PAGE_CP_4V | pagecv_flag |
 					   _PAGE_P_4V | _PAGE_W_4V);
 	} else {
 		kern_linear_pte_xor[2] = kern_linear_pte_xor[1];
@@ -1931,7 +1945,7 @@ static void __init sun4v_linear_pte_xor_finalize(void)
 	if (cpu_pgsz_mask & HV_PGSZ_MASK_16GB) {
 		kern_linear_pte_xor[3] = (_PAGE_VALID | _PAGE_SZ16GB_4V) ^
 			PAGE_OFFSET;
-		kern_linear_pte_xor[3] |= (_PAGE_CP_4V | _PAGE_CV_4V |
+		kern_linear_pte_xor[3] |= (_PAGE_CP_4V | pagecv_flag |
 					   _PAGE_P_4V | _PAGE_W_4V);
 	} else {
 		kern_linear_pte_xor[3] = kern_linear_pte_xor[2];
@@ -1958,6 +1972,13 @@ static phys_addr_t __init available_memory(void)
 	return available;
 }
 
+#define _PAGE_CACHE_4U	(_PAGE_CP_4U | _PAGE_CV_4U)
+#define _PAGE_CACHE_4V	(_PAGE_CP_4V | _PAGE_CV_4V)
+#define __DIRTY_BITS_4U	 (_PAGE_MODIFIED_4U | _PAGE_WRITE_4U | _PAGE_W_4U)
+#define __DIRTY_BITS_4V	 (_PAGE_MODIFIED_4V | _PAGE_WRITE_4V | _PAGE_W_4V)
+#define __ACCESS_BITS_4U (_PAGE_ACCESSED_4U | _PAGE_READ_4U | _PAGE_R)
+#define __ACCESS_BITS_4V (_PAGE_ACCESSED_4V | _PAGE_READ_4V | _PAGE_R)
+
 /* We need to exclude reserved regions. This exclusion will include
  * vmlinux and initrd. To be more precise the initrd size could be used to
  * compute a new lower limit because it is freed later during initialization.
@@ -2034,6 +2055,25 @@ void __init paging_init(void)
 	memset(swapper_4m_tsb, 0x40, sizeof(swapper_4m_tsb));
 #endif
 
+	/* TTE.cv bit on sparc v9 occupies the same position as TTE.mcde
+	 * bit on M7 processor. This is a conflicting usage of the same
+	 * bit. Enabling TTE.cv on M7 would turn on Memory Corruption
+	 * Detection error on all pages and this will lead to problems
+	 * later. Kernel does not run with MCD enabled and hence rest
+	 * of the required steps to fully configure memory corruption
+	 * detection are not taken. We need to ensure TTE.mcde is not
+	 * set on M7 processor. Compute the value of cacheability
+	 * flag for use later taking this into consideration.
+	 */
+	switch (sun4v_chip_type) {
+	case SUN4V_CHIP_SPARC_M7:
+		page_cache4v_flag = _PAGE_CP_4V;
+		break;
+	default:
+		page_cache4v_flag = _PAGE_CACHE_4V;
+		break;
+	}
+
 	if (tlb_type = hypervisor)
 		sun4v_pgprot_init();
 	else
@@ -2274,13 +2314,6 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 }
 #endif
 
-#define _PAGE_CACHE_4U	(_PAGE_CP_4U | _PAGE_CV_4U)
-#define _PAGE_CACHE_4V	(_PAGE_CP_4V | _PAGE_CV_4V)
-#define __DIRTY_BITS_4U	 (_PAGE_MODIFIED_4U | _PAGE_WRITE_4U | _PAGE_W_4U)
-#define __DIRTY_BITS_4V	 (_PAGE_MODIFIED_4V | _PAGE_WRITE_4V | _PAGE_W_4V)
-#define __ACCESS_BITS_4U (_PAGE_ACCESSED_4U | _PAGE_READ_4U | _PAGE_R)
-#define __ACCESS_BITS_4V (_PAGE_ACCESSED_4V | _PAGE_READ_4V | _PAGE_R)
-
 pgprot_t PAGE_KERNEL __read_mostly;
 EXPORT_SYMBOL(PAGE_KERNEL);
 
@@ -2312,8 +2345,7 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
 		    _PAGE_P_4U | _PAGE_W_4U);
 	if (tlb_type = hypervisor)
 		pte_base = (_PAGE_VALID | _PAGE_SZ4MB_4V |
-			    _PAGE_CP_4V | _PAGE_CV_4V |
-			    _PAGE_P_4V | _PAGE_W_4V);
+			    page_cache4v_flag | _PAGE_P_4V | _PAGE_W_4V);
 
 	pte_base |= _PAGE_PMD_HUGE;
 
@@ -2450,14 +2482,14 @@ static void __init sun4v_pgprot_init(void)
 	int i;
 
 	PAGE_KERNEL = __pgprot (_PAGE_PRESENT_4V | _PAGE_VALID |
-				_PAGE_CACHE_4V | _PAGE_P_4V |
+				page_cache4v_flag | _PAGE_P_4V |
 				__ACCESS_BITS_4V | __DIRTY_BITS_4V |
 				_PAGE_EXEC_4V);
 	PAGE_KERNEL_LOCKED = PAGE_KERNEL;
 
 	_PAGE_IE = _PAGE_IE_4V;
 	_PAGE_E = _PAGE_E_4V;
-	_PAGE_CACHE = _PAGE_CACHE_4V;
+	_PAGE_CACHE = page_cache4v_flag;
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	kern_linear_pte_xor[0] = _PAGE_VALID ^ PAGE_OFFSET;
@@ -2465,8 +2497,8 @@ static void __init sun4v_pgprot_init(void)
 	kern_linear_pte_xor[0] = (_PAGE_VALID | _PAGE_SZ4MB_4V) ^
 		PAGE_OFFSET;
 #endif
-	kern_linear_pte_xor[0] |= (_PAGE_CP_4V | _PAGE_CV_4V |
-				   _PAGE_P_4V | _PAGE_W_4V);
+	kern_linear_pte_xor[0] |= (page_cache4v_flag | _PAGE_P_4V |
+				   _PAGE_W_4V);
 
 	for (i = 1; i < 4; i++)
 		kern_linear_pte_xor[i] = kern_linear_pte_xor[0];
@@ -2479,12 +2511,12 @@ static void __init sun4v_pgprot_init(void)
 			     _PAGE_SZ4MB_4V | _PAGE_SZ512K_4V |
 			     _PAGE_SZ64K_4V | _PAGE_SZ8K_4V);
 
-	page_none = _PAGE_PRESENT_4V | _PAGE_ACCESSED_4V | _PAGE_CACHE_4V;
-	page_shared = (_PAGE_VALID | _PAGE_PRESENT_4V | _PAGE_CACHE_4V |
+	page_none = _PAGE_PRESENT_4V | _PAGE_ACCESSED_4V | page_cache4v_flag;
+	page_shared = (_PAGE_VALID | _PAGE_PRESENT_4V | page_cache4v_flag |
 		       __ACCESS_BITS_4V | _PAGE_WRITE_4V | _PAGE_EXEC_4V);
-	page_copy   = (_PAGE_VALID | _PAGE_PRESENT_4V | _PAGE_CACHE_4V |
+	page_copy   = (_PAGE_VALID | _PAGE_PRESENT_4V | page_cache4v_flag |
 		       __ACCESS_BITS_4V | _PAGE_EXEC_4V);
-	page_readonly = (_PAGE_VALID | _PAGE_PRESENT_4V | _PAGE_CACHE_4V |
+	page_readonly = (_PAGE_VALID | _PAGE_PRESENT_4V | page_cache4v_flag |
 			 __ACCESS_BITS_4V | _PAGE_EXEC_4V);
 
 	page_exec_bit = _PAGE_EXEC_4V;
@@ -2542,7 +2574,7 @@ static unsigned long kern_large_tte(unsigned long paddr)
 	       _PAGE_EXEC_4U | _PAGE_L_4U | _PAGE_W_4U);
 	if (tlb_type = hypervisor)
 		val = (_PAGE_VALID | _PAGE_SZ4MB_4V |
-		       _PAGE_CP_4V | _PAGE_CV_4V | _PAGE_P_4V |
+		       page_cache4v_flag | _PAGE_P_4V |
 		       _PAGE_EXEC_4V | _PAGE_W_4V);
 
 	return val | paddr;
-- 
1.9.1

