From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Wed, 17 Apr 2013 20:52:26 +0000
Subject: [PATCH] sparc64: Don't pass a pointer to xcall_flush_tlb_pending
Message-Id: <516F0B8A.5070407@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The use of the vaddrs array to pass the page addresses to the remote
functions is lacking serialization. xmp_cross_call_masked() returns when
the mondo signals are delivered to the target cpus, not when the remote
functions have completed. This can result in the vaddr array being
overwritten by the initiating cpu before the remote functions execute.

Failing to flush the tlb entries correctly can cause user-space
processes to access stale memory resulting in various traps. An easy
way to trigger this behavior is to repeatedly write a large number to
/proc/sys/vm/nr_hugepages:

while true ; do
	echo 1000000 > /proc/sys/vm/nr_hugepages
done

The very limited environment in which the remote functions execute makes
it difficult to pass any more arguments. This patch passes one or two
page addresses as arguments eliminating the pointer argument. In order
to limit the number of cross calls, if the number of tlb entries to flush
exceeds a threshold, xcall_tlb_flush_mm is called instead. I've initially
set the threshold at 16, but there is probably a better number.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 537eb66..31d94f1 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1081,11 +1081,24 @@ void smp_flush_tlb_pending(struct mm_struct *mm, unsigned long nr, unsigned long
 
 	if (mm = current->mm && atomic_read(&mm->mm_users) = 1)
 		cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
-	else
-		smp_cross_call_masked(&xcall_flush_tlb_pending,
-				      ctx, nr, (unsigned long) vaddrs,
+	else if (nr < 17) {
+		int i;
+		unsigned long vaddr2;
+		for(i = 0; i < nr; i+=2) {
+			vaddr2 = i + 1 < nr ? vaddrs[i + 1] : 0;
+			smp_cross_call_masked(&xcall_flush_tlb_pending,
+					      ctx, vaddrs[i], vaddr2,
+					      mm_cpumask(mm));
+		}
+	} else
+		/*
+		 * At some point it is probably cheaper to flush the whole
+		 * context rather than make too many cross calls
+		 */
+		smp_cross_call_masked(&xcall_flush_tlb_mm, ctx, 0, 0,
 				      mm_cpumask(mm));
 
+
 	__flush_tlb_pending(ctx, nr, vaddrs);
 
 	put_cpu();
diff --git a/arch/sparc/mm/ultra.S b/arch/sparc/mm/ultra.S
index f8e13d4..a232c83 100644
--- a/arch/sparc/mm/ultra.S
+++ b/arch/sparc/mm/ultra.S
@@ -398,9 +398,8 @@ xcall_flush_tlb_mm:	/* 21 insns */
 	nop
 
 	.globl		xcall_flush_tlb_pending
-xcall_flush_tlb_pending:	/* 21 insns */
-	/* %g5=context, %g1=nr, %g7=vaddrs[] */
-	sllx		%g1, 3, %g1
+xcall_flush_tlb_pending:	/* 20 insns */
+	/* %g5=context, %g1=vaddr1, %g7=vaddr2 */
 	mov		PRIMARY_CONTEXT, %g4
 	ldxa		[%g4] ASI_DMMU, %g2
 	srlx		%g2, CTX_PGSZ1_NUC_SHIFT, %g4
@@ -408,20 +407,21 @@ xcall_flush_tlb_pending:	/* 21 insns */
 	or		%g5, %g4, %g5
 	mov		PRIMARY_CONTEXT, %g4
 	stxa		%g5, [%g4] ASI_DMMU
-1:	sub		%g1, (1 << 3), %g1
-	ldx		[%g7 + %g1], %g5
-	andcc		%g5, 0x1, %g0
+1:	andcc		%g1, 0x1, %g0
 	be,pn		%icc, 2f
 
-	 andn		%g5, 0x1, %g5
-	stxa		%g0, [%g5] ASI_IMMU_DEMAP
-2:	stxa		%g0, [%g5] ASI_DMMU_DEMAP
+	 andn		%g1, 0x1, %g1
+	stxa		%g0, [%g1] ASI_IMMU_DEMAP
+2:	stxa		%g0, [%g1] ASI_DMMU_DEMAP
 	membar		#Sync
-	brnz,pt		%g1, 1b
-	 nop
+	/* Repeat with vaddr2 if not zero */
+	mov		%g7, %g1
+	brnz,pn		%g1, 1b
+	 mov		0, %g7
 	stxa		%g2, [%g4] ASI_DMMU
 	retry
 	nop
+	nop
 
 	.globl		xcall_flush_tlb_kernel_range
 xcall_flush_tlb_kernel_range:	/* 25 insns */
@@ -657,14 +657,12 @@ __hypervisor_xcall_flush_tlb_mm: /* 21 insns */
 	retry
 
 	.globl		__hypervisor_xcall_flush_tlb_pending
-__hypervisor_xcall_flush_tlb_pending: /* 21 insns */
-	/* %g5=ctx, %g1=nr, %g7=vaddrs[], %g2,%g3,%g4,g6=scratch */
-	sllx		%g1, 3, %g1
+__hypervisor_xcall_flush_tlb_pending: /* 20 insns */
+	/* %g5=ctx, %g1=vaddr1, %g7=vaddr2, %g2,%g3,%g4,g6=scratch */
 	mov		%o0, %g2
 	mov		%o1, %g3
 	mov		%o2, %g4
-1:	sub		%g1, (1 << 3), %g1
-	ldx		[%g7 + %g1], %o0	/* ARG0: virtual address */
+1:	mov		%g1, %o0		/* ARG0: virtual address */
 	mov		%g5, %o1		/* ARG1: mmu context */
 	mov		HV_MMU_ALL, %o2		/* ARG2: flags */
 	srlx		%o0, PAGE_SHIFT, %o0
@@ -673,8 +671,10 @@ __hypervisor_xcall_flush_tlb_pending: /* 21 insns */
 	mov		HV_MMU_UNMAP_ADDR_TRAP, %g6
 	brnz,a,pn	%o0, __hypervisor_tlb_xcall_error
 	 mov		%o0, %g5
-	brnz,pt		%g1, 1b
-	 nop
+	/* Repeat with vaddr2 if not zero */
+	mov		%g7, %g1
+	brnz,pn		%g1, 1b
+	 mov		0, %g7
 	mov		%g2, %o0
 	mov		%g3, %o1
 	mov		%g4, %o2
@@ -793,7 +793,7 @@ hypervisor_patch_cachetlbops:
 	sethi		%hi(__hypervisor_xcall_flush_tlb_pending), %o1
 	or		%o1, %lo(__hypervisor_xcall_flush_tlb_pending), %o1
 	call		tlb_patch_one
-	 mov		21, %o2
+	 mov		20, %o2
 
 	sethi		%hi(xcall_flush_tlb_kernel_range), %o0
 	or		%o0, %lo(xcall_flush_tlb_kernel_range), %o0
