From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 21 Jul 2017 01:50:59 +0000
Subject: [PATCH v1 2/4] sparc64: tlb mondo replacement with smp_call_function_many
Message-Id: <1500601861-203232-3-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Context domains will require an mm to have more than one context id. Each
context domain contains a context id for the mm which visited. A first
step is to eliminate xcall with context id used for tlb operations. We
replace context id with the mm. The mm is used to find the context id.

Two xcalls, xcall_flush_tlb_mm and xcall_flush_tlb_page, are replaced
with smp_call_function_many equivalent.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/kernel/smp_64.c |   46 +++++++++++----
 arch/sparc/mm/ultra.S      |  131 --------------------------------------------
 2 files changed, 34 insertions(+), 143 deletions(-)

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 3218bc4..889b8f8 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -903,8 +903,6 @@ void smp_tsb_sync(struct mm_struct *mm)
 	smp_call_function_many(mm_cpumask(mm), tsb_sync, mm, 1);
 }
 
-extern unsigned long xcall_flush_tlb_mm;
-extern unsigned long xcall_flush_tlb_page;
 extern unsigned long xcall_flush_tlb_kernel_range;
 extern unsigned long xcall_fetch_glob_regs;
 extern unsigned long xcall_fetch_glob_pmu;
@@ -1068,6 +1066,13 @@ void smp_fetch_global_pmu(void)
  *    questionable (in theory the big win for threads is the massive sharing of
  *    address space state across processors).
  */
+static void tlb_mm_flush_func(void *info)
+{
+	struct mm_struct *mm = (struct mm_struct *)info;
+	u32 ctx = CTX_HWBITS(mm->context);
+
+	__flush_tlb_mm(ctx, SECONDARY_CONTEXT);
+}
 
 /* This currently is only used by the hugetlb arch pre-fault
  * hook on UltraSPARC-III+ and later when changing the pagesize
@@ -1083,9 +1088,7 @@ void smp_flush_tlb_mm(struct mm_struct *mm)
 		goto local_flush_and_out;
 	}
 
-	smp_cross_call_masked(&xcall_flush_tlb_mm,
-			      ctx, 0, 0,
-			      mm_cpumask(mm));
+	smp_call_function_many(mm_cpumask(mm), tlb_mm_flush_func, mm, 1);
 
 local_flush_and_out:
 	__flush_tlb_mm(ctx, SECONDARY_CONTEXT);
@@ -1094,16 +1097,18 @@ void smp_flush_tlb_mm(struct mm_struct *mm)
 }
 
 struct tlb_pending_info {
-	unsigned long ctx;
 	unsigned long nr;
+	struct mm_struct *mm;
 	unsigned long *vaddrs;
 };
 
 static void tlb_pending_func(void *info)
 {
 	struct tlb_pending_info *t = info;
+	struct mm_struct *mm = t->mm;
+	u32 ctx = CTX_HWBITS(mm->context);
 
-	__flush_tlb_pending(t->ctx, t->nr, t->vaddrs);
+	__flush_tlb_pending(ctx, t->nr, t->vaddrs);
 }
 
 void smp_flush_tlb_pending(struct mm_struct *mm, unsigned long nr, unsigned long *vaddrs)
@@ -1112,7 +1117,7 @@ void smp_flush_tlb_pending(struct mm_struct *mm, unsigned long nr, unsigned long
 	struct tlb_pending_info info;
 	int cpu = get_cpu();
 
-	info.ctx = ctx;
+	info.mm = mm;
 	info.nr = nr;
 	info.vaddrs = vaddrs;
 
@@ -1127,17 +1132,34 @@ void smp_flush_tlb_pending(struct mm_struct *mm, unsigned long nr, unsigned long
 	put_cpu();
 }
 
+struct flush_tlb_page_info {
+	struct mm_struct *mm;
+	unsigned long vaddr;
+};
+
+static void flush_tlb_page_func(void *info)
+{
+	struct flush_tlb_page_info *t = info;
+	struct mm_struct *mm = t->mm;
+	u32 ctx = CTX_HWBITS(mm->context);
+
+	__flush_tlb_page(ctx, t->vaddr);
+}
+
 void smp_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr)
 {
-	unsigned long context = CTX_HWBITS(mm->context);
+	u32 context = CTX_HWBITS(mm->context);
+	struct flush_tlb_page_info info;
 	int cpu = get_cpu();
 
+	info.mm = mm;
+	info.vaddr = vaddr;
+
 	if (mm = current->mm && atomic_read(&mm->mm_users) = 1)
 		cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
 	else
-		smp_cross_call_masked(&xcall_flush_tlb_page,
-				      context, vaddr, 0,
-				      mm_cpumask(mm));
+		smp_call_function_many(mm_cpumask(mm), flush_tlb_page_func,
+				       &info, 1);
 	__flush_tlb_page(context, vaddr);
 
 	put_cpu();
diff --git a/arch/sparc/mm/ultra.S b/arch/sparc/mm/ultra.S
index fcf4d27..8f17994 100644
--- a/arch/sparc/mm/ultra.S
+++ b/arch/sparc/mm/ultra.S
@@ -512,71 +512,6 @@ tlb_patch_one:
 	 nop
 
 #ifdef CONFIG_SMP
-	/* These are all called by the slaves of a cross call, at
-	 * trap level 1, with interrupts fully disabled.
-	 *
-	 * Register usage:
-	 *   %g5	mm->context	(all tlb flushes)
-	 *   %g1	address arg 1	(tlb page and range flushes)
-	 *   %g7	address arg 2	(tlb range flush only)
-	 *
-	 *   %g6	scratch 1
-	 *   %g2	scratch 2
-	 *   %g3	scratch 3
-	 *   %g4	scratch 4
-	 */
-	.align		32
-	.globl		xcall_flush_tlb_mm
-xcall_flush_tlb_mm:	/* 24 insns */
-	mov		PRIMARY_CONTEXT, %g2
-	ldxa		[%g2] ASI_DMMU, %g3
-	srlx		%g3, CTX_PGSZ1_NUC_SHIFT, %g4
-	sllx		%g4, CTX_PGSZ1_NUC_SHIFT, %g4
-	or		%g5, %g4, %g5	/* Preserve nucleus page size fields */
-	stxa		%g5, [%g2] ASI_DMMU
-	mov		0x40, %g4
-	stxa		%g0, [%g4] ASI_DMMU_DEMAP
-	stxa		%g0, [%g4] ASI_IMMU_DEMAP
-	stxa		%g3, [%g2] ASI_DMMU
-	retry
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-
-	.globl		xcall_flush_tlb_page
-xcall_flush_tlb_page:	/* 20 insns */
-	/* %g5=context, %g1=vaddr */
-	mov		PRIMARY_CONTEXT, %g4
-	ldxa		[%g4] ASI_DMMU, %g2
-	srlx		%g2, CTX_PGSZ1_NUC_SHIFT, %g4
-	sllx		%g4, CTX_PGSZ1_NUC_SHIFT, %g4
-	or		%g5, %g4, %g5
-	mov		PRIMARY_CONTEXT, %g4
-	stxa		%g5, [%g4] ASI_DMMU
-	andcc		%g1, 0x1, %g0
-	be,pn		%icc, 2f
-	 andn		%g1, 0x1, %g5
-	stxa		%g0, [%g5] ASI_IMMU_DEMAP
-2:	stxa		%g0, [%g5] ASI_DMMU_DEMAP
-	membar		#Sync
-	stxa		%g2, [%g4] ASI_DMMU
-	retry
-	nop
-	nop
-	nop
-	nop
-	nop
-
 	.globl		xcall_flush_tlb_kernel_range
 xcall_flush_tlb_kernel_range:	/* 44 insns */
 	sethi		%hi(PAGE_SIZE - 1), %g2
@@ -850,58 +785,6 @@ __hypervisor_tlb_xcall_error:
 	 mov	%l5, %o1
 	ba,a,pt	%xcc, rtrap
 
-	.globl		__hypervisor_xcall_flush_tlb_mm
-__hypervisor_xcall_flush_tlb_mm: /* 24 insns */
-	/* %g5=ctx, g1,g2,g3,g4,g7=scratch, %g6=unusable */
-	mov		%o0, %g2
-	mov		%o1, %g3
-	mov		%o2, %g4
-	mov		%o3, %g1
-	mov		%o5, %g7
-	clr		%o0		/* ARG0: CPU lists unimplemented */
-	clr		%o1		/* ARG1: CPU lists unimplemented */
-	mov		%g5, %o2	/* ARG2: mmu context */
-	mov		HV_MMU_ALL, %o3	/* ARG3: flags */
-	mov		HV_FAST_MMU_DEMAP_CTX, %o5
-	ta		HV_FAST_TRAP
-	mov		HV_FAST_MMU_DEMAP_CTX, %g6
-	brnz,pn		%o0, 1f
-	 mov		%o0, %g5
-	mov		%g2, %o0
-	mov		%g3, %o1
-	mov		%g4, %o2
-	mov		%g1, %o3
-	mov		%g7, %o5
-	membar		#Sync
-	retry
-1:	sethi		%hi(__hypervisor_tlb_xcall_error), %g4
-	jmpl		%g4 + %lo(__hypervisor_tlb_xcall_error), %g0
-	 nop
-
-	.globl		__hypervisor_xcall_flush_tlb_page
-__hypervisor_xcall_flush_tlb_page: /* 20 insns */
-	/* %g5=ctx, %g1=vaddr */
-	mov		%o0, %g2
-	mov		%o1, %g3
-	mov		%o2, %g4
-	mov		%g1, %o0	        /* ARG0: virtual address */
-	mov		%g5, %o1		/* ARG1: mmu context */
-	mov		HV_MMU_ALL, %o2		/* ARG2: flags */
-	srlx		%o0, PAGE_SHIFT, %o0
-	sllx		%o0, PAGE_SHIFT, %o0
-	ta		HV_MMU_UNMAP_ADDR_TRAP
-	mov		HV_MMU_UNMAP_ADDR_TRAP, %g6
-	brnz,a,pn	%o0, 1f
-	 mov		%o0, %g5
-	mov		%g2, %o0
-	mov		%g3, %o1
-	mov		%g4, %o2
-	membar		#Sync
-	retry
-1:	sethi		%hi(__hypervisor_tlb_xcall_error), %g4
-	jmpl		%g4 + %lo(__hypervisor_tlb_xcall_error), %g0
-	 nop
-
 	.globl		__hypervisor_xcall_flush_tlb_kernel_range
 __hypervisor_xcall_flush_tlb_kernel_range: /* 44 insns */
 	/* %g1=start, %g7=end, g2,g3,g4,g5,g6=scratch */
@@ -1075,20 +958,6 @@ hypervisor_patch_cachetlbops:
 #endif /* DCACHE_ALIASING_POSSIBLE */
 
 #ifdef CONFIG_SMP
-	sethi		%hi(xcall_flush_tlb_mm), %o0
-	or		%o0, %lo(xcall_flush_tlb_mm), %o0
-	sethi		%hi(__hypervisor_xcall_flush_tlb_mm), %o1
-	or		%o1, %lo(__hypervisor_xcall_flush_tlb_mm), %o1
-	call		tlb_patch_one
-	 mov		24, %o2
-
-	sethi		%hi(xcall_flush_tlb_page), %o0
-	or		%o0, %lo(xcall_flush_tlb_page), %o0
-	sethi		%hi(__hypervisor_xcall_flush_tlb_page), %o1
-	or		%o1, %lo(__hypervisor_xcall_flush_tlb_page), %o1
-	call		tlb_patch_one
-	 mov		20, %o2
-
 	sethi		%hi(xcall_flush_tlb_kernel_range), %o0
 	or		%o0, %lo(xcall_flush_tlb_kernel_range), %o0
 	sethi		%hi(__hypervisor_xcall_flush_tlb_kernel_range), %o1
-- 
1.7.1

