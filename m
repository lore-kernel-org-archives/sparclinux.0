From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Fri, 19 Apr 2013 17:40:51 +0000
Subject: Re: [PATCH] sparc64: Don't pass a pointer to xcall_flush_tlb_pending
Message-Id: <517181A3.5090905@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <516F0B8A.5070407@oracle.com>
In-Reply-To: <516F0B8A.5070407@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Here's a lightly-tested incremental patch to yours that limits
smp_flush_tlb_page's  cross calls to the mm's active set.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>

diff --git a/arch/sparc/include/asm/tlbflush_64.h b/arch/sparc/include/asm/tlbflush_64.h
index d4b56bb..f3c8a0f 100644
--- a/arch/sparc/include/asm/tlbflush_64.h
+++ b/arch/sparc/include/asm/tlbflush_64.h
@@ -54,21 +54,21 @@ do {	flush_tsb_kernel_range(start,end); \
 	__flush_tlb_kernel_range(start,end); \
 } while (0)
 
-#define global_flush_tlb_page(context, vaddr) \
-	__flush_tlb_page(context, vaddr)
+#define global_flush_tlb_page(mm, vaddr) \
+	__flush_tlb_page(CTX_HWBITS((mm)->context), vaddr)
 
 #else /* CONFIG_SMP */
 
 extern void smp_flush_tlb_kernel_range(unsigned long start, unsigned long end);
-extern void smp_flush_tlb_page(unsigned long context, unsigned long vaddr);
+extern void smp_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr);
 
 #define flush_tlb_kernel_range(start, end) \
 do {	flush_tsb_kernel_range(start,end); \
 	smp_flush_tlb_kernel_range(start, end); \
 } while (0)
 
-#define global_flush_tlb_page(context, vaddr) \
-	smp_flush_tlb_page(context, vaddr)
+#define global_flush_tlb_page(mm, vaddr) \
+	smp_flush_tlb_page(mm, vaddr)
 
 #endif /* ! CONFIG_SMP */
 
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 33bd996..1dee6e9 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1108,10 +1108,16 @@ void smp_flush_tlb_pending(struct mm_struct *mm, unsigned long nr, unsigned long
 	put_cpu();
 }
 
-void smp_flush_tlb_page(unsigned long context, unsigned long vaddr)
+void smp_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr)
 {
-	smp_cross_call(&xcall_flush_tlb_page,
-		       context, vaddr, 0);
+	unsigned long context = CTX_HWBITS(mm->context);
+	int cpu = get_cpu();
+
+	if (mm = current->mm && atomic_read(&mm->mm_users) = 1)
+		cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
+	else
+		smp_cross_call(&xcall_flush_tlb_page, context, vaddr, 0);
+
 	__flush_tlb_page(context, vaddr);
 }
 
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 26ddb58..1e31b30 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -77,7 +77,7 @@ static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
 	}
 
 	if (!tb->active) {
-		global_flush_tlb_page(CTX_HWBITS(mm->context), vaddr);
+		global_flush_tlb_page(mm, vaddr);
 		flush_tsb_user_page(mm, vaddr);
 		return;
 	}
