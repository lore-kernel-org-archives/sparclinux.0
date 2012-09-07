From: David Miller <davem@davemloft.net>
Date: Fri, 07 Sep 2012 05:34:29 +0000
Subject: [PATCH 3/3] sparc64: Use cpu_pgsz_mask for linear kernel mapping config.
Message-Id: <20120907.013429.2122262574523574196.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This required a little bit of reordering of how we set up the memory
management early on.

We now only know the final values of kern_linear_pte_xor[] after we
take over the trap table and start processing TLB misses ourselves.

So once we fill those values in we re-clear the kernel's 4M TSB and
flush the TLBs.  That way if we find we support larger than 4M pages
we won't have any stale smaller page size entries in the TSB.

SUN4U Panther support for larger page sizes should now be extremely
trivial but I have no hardware on which to test it and I believe
that some of the sun4u TLB miss assembler needs to be audited first
to make sure it really can handle larger than 4M PTEs properly.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/mm/init_64.c |  104 +++++++++++++++++++++++++++++------------------
 1 file changed, 65 insertions(+), 39 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 4453691..696bb09 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1660,10 +1660,11 @@ static void __init sun4v_ktsb_init(void)
 		   ((unsigned long)&swapper_4m_tsb[0] - KERNBASE));
 
 	ktsb_descr[1].pgsz_idx = HV_PGSZ_IDX_4MB;
-	ktsb_descr[1].pgsz_mask = (HV_PGSZ_MASK_4MB |
-				   HV_PGSZ_MASK_256MB);
-	if (sun4v_chip_type = SUN4V_CHIP_NIAGARA4)
-		ktsb_descr[1].pgsz_mask |= HV_PGSZ_MASK_2GB;
+	ktsb_descr[1].pgsz_mask = ((HV_PGSZ_MASK_4MB |
+				    HV_PGSZ_MASK_256MB |
+				    HV_PGSZ_MASK_2GB |
+				    HV_PGSZ_MASK_16GB) &
+				   cpu_pgsz_mask);
 	ktsb_descr[1].assoc = 1;
 	ktsb_descr[1].num_ttes = KERNEL_TSB4M_NENTRIES;
 	ktsb_descr[1].ctx_idx = 0;
@@ -1686,6 +1687,47 @@ void __cpuinit sun4v_ktsb_register(void)
 	}
 }
 
+static void __init sun4u_linear_pte_xor_finalize(void)
+{
+#ifndef CONFIG_DEBUG_PAGEALLOC
+	/* This is where we would add Panther support for
+	 * 32MB and 256MB pages.
+	 */
+#endif
+}
+
+static void __init sun4v_linear_pte_xor_finalize(void)
+{
+#ifndef CONFIG_DEBUG_PAGEALLOC
+	if (cpu_pgsz_mask & HV_PGSZ_MASK_256MB) {
+		kern_linear_pte_xor[1] = (_PAGE_VALID | _PAGE_SZ256MB_4V) ^
+			0xfffff80000000000UL;
+		kern_linear_pte_xor[1] |= (_PAGE_CP_4V | _PAGE_CV_4V |
+					   _PAGE_P_4V | _PAGE_W_4V);
+	} else {
+		kern_linear_pte_xor[1] = kern_linear_pte_xor[0];
+	}
+
+	if (cpu_pgsz_mask & HV_PGSZ_MASK_2GB) {
+		kern_linear_pte_xor[2] = (_PAGE_VALID | _PAGE_SZ2GB_4V) ^
+			0xfffff80000000000UL;
+		kern_linear_pte_xor[2] |= (_PAGE_CP_4V | _PAGE_CV_4V |
+					   _PAGE_P_4V | _PAGE_W_4V);
+	} else {
+		kern_linear_pte_xor[2] = kern_linear_pte_xor[1];
+	}
+
+	if (cpu_pgsz_mask & HV_PGSZ_MASK_16GB) {
+		kern_linear_pte_xor[3] = (_PAGE_VALID | _PAGE_SZ16GB_4V) ^
+			0xfffff80000000000UL;
+		kern_linear_pte_xor[3] |= (_PAGE_CP_4V | _PAGE_CV_4V |
+					   _PAGE_P_4V | _PAGE_W_4V);
+	} else {
+		kern_linear_pte_xor[3] = kern_linear_pte_xor[2];
+	}
+#endif
+}
+
 /* paging_init() sets up the page tables */
 
 static unsigned long last_valid_pfn;
@@ -1745,10 +1787,8 @@ void __init paging_init(void)
 		ktsb_phys_patch();
 	}
 
-	if (tlb_type = hypervisor) {
+	if (tlb_type = hypervisor)
 		sun4v_patch_tlb_handlers();
-		sun4v_ktsb_init();
-	}
 
 	/* Find available physical memory...
 	 *
@@ -1807,9 +1847,6 @@ void __init paging_init(void)
 
 	__flush_tlb_all();
 
-	if (tlb_type = hypervisor)
-		sun4v_ktsb_register();
-
 	prom_build_devicetree();
 	of_populate_present_mask();
 #ifndef CONFIG_SMP
@@ -1823,6 +1860,11 @@ void __init paging_init(void)
 		mdesc_fill_in_cpu_data(cpu_all_mask);
 #endif
 		mdesc_get_page_sizes(cpu_all_mask, &cpu_pgsz_mask);
+
+		sun4v_linear_pte_xor_finalize();
+
+		sun4v_ktsb_init();
+		sun4v_ktsb_register();
 	} else {
 		unsigned long impl, ver;
 
@@ -1834,8 +1876,19 @@ void __init paging_init(void)
 		if (impl = PANTHER_IMPL)
 			cpu_pgsz_mask |= (HV_PGSZ_MASK_32MB |
 					  HV_PGSZ_MASK_256MB);
+
+		sun4u_linear_pte_xor_finalize();
 	}
 
+	/* Flush the TLBs and the 4M TSB so that the updated linear
+	 * pte XOR settings are realized for all mappings.
+	 */
+	__flush_tlb_all();
+#ifndef CONFIG_DEBUG_PAGEALLOC
+	memset(swapper_4m_tsb, 0x40, sizeof(swapper_4m_tsb));
+#endif
+	__flush_tlb_all();
+
 	/* Setup bootmem... */
 	last_valid_pfn = end_pfn = bootmem_init(phys_base);
 
@@ -2230,7 +2283,6 @@ static void __init sun4u_pgprot_init(void)
 	kern_linear_pte_xor[0] |= (_PAGE_CP_4U | _PAGE_CV_4U |
 				   _PAGE_P_4U | _PAGE_W_4U);
 
-	/* XXX Should use 256MB on Panther. XXX */
 	for (i = 1; i < 4; i++)
 		kern_linear_pte_xor[i] = kern_linear_pte_xor[0];
 
@@ -2280,34 +2332,8 @@ static void __init sun4v_pgprot_init(void)
 	kern_linear_pte_xor[0] |= (_PAGE_CP_4V | _PAGE_CV_4V |
 				   _PAGE_P_4V | _PAGE_W_4V);
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
-	kern_linear_pte_xor[1] = (_PAGE_VALID | _PAGE_SZBITS_4V) ^
-		0xfffff80000000000UL;
-#else
-	kern_linear_pte_xor[1] = (_PAGE_VALID | _PAGE_SZ256MB_4V) ^
-		0xfffff80000000000UL;
-#endif
-	kern_linear_pte_xor[1] |= (_PAGE_CP_4V | _PAGE_CV_4V |
-				   _PAGE_P_4V | _PAGE_W_4V);
-
-	i = 2;
-
-	if (sun4v_chip_type = SUN4V_CHIP_NIAGARA4) {
-#ifdef CONFIG_DEBUG_PAGEALLOC
-		kern_linear_pte_xor[2] = (_PAGE_VALID | _PAGE_SZBITS_4V) ^
-			0xfffff80000000000UL;
-#else
-		kern_linear_pte_xor[2] = (_PAGE_VALID | _PAGE_SZ2GB_4V) ^
-			0xfffff80000000000UL;
-#endif
-		kern_linear_pte_xor[2] |= (_PAGE_CP_4V | _PAGE_CV_4V |
-					   _PAGE_P_4V | _PAGE_W_4V);
-
-		i = 3;
-	}
-
-	for (; i < 4; i++)
-		kern_linear_pte_xor[i] = kern_linear_pte_xor[i - 1];
+	for (i = 1; i < 4; i++)
+		kern_linear_pte_xor[i] = kern_linear_pte_xor[0];
 
 	pg_iobits = (_PAGE_VALID | _PAGE_PRESENT_4V | __DIRTY_BITS_4V |
 		     __ACCESS_BITS_4V | _PAGE_E_4V);
-- 
1.7.10.4

