From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 May 2012 17:04:34 +0000
Subject: [PATCH] sparc32: cleanup mm/fault_32.c
Message-Id: <20120515170434.GA13518@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 08f1ed3b3fdf4d25068c457fcf249413f2235f97 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 May 2012 19:02:08 +0200
Subject: [PATCH] sparc32: cleanup mm/fault_32.c

- remove unused variables
- fix coding style issues that hurts my eyes

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

Noticed a few unused variables and then an "if(" and then...
I actually ran checkpatch on the file too - but
ignored most of the complaints.

	Sam

 arch/sparc/include/asm/pgtable_32.h |    2 -
 arch/sparc/mm/fault_32.c            |   94 ++++++++++++++++------------------
 2 files changed, 44 insertions(+), 52 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 28a67bf..cbbbed5 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -361,8 +361,6 @@ void srmmu_mapiorange(unsigned int bus, unsigned long xpa,
                       unsigned long xva, unsigned int len);
 void srmmu_unmapiorange(unsigned long virt_addr, unsigned int len);
 
-extern int invalid_segment;
-
 /* Encode and de-code a swap entry */
 static inline unsigned long __swp_type(swp_entry_t entry)
 {
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 5d37f1f..f46cf6b 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -30,22 +30,13 @@
 #include <asm/traps.h>
 #include <asm/uaccess.h>
 
-extern int prom_node_root;
-
 int show_unhandled_signals = 1;
 
 /* At boot time we determine these two values necessary for setting
  * up the segment maps and page table entries (pte's).
  */
 
-int num_segmaps, num_contexts;
-int invalid_segment;
-
-/* various Virtual Address Cache parameters we find at boot time... */
-
-int vac_size, vac_linesize, vac_do_hw_vac_flushes;
-int vac_entries_per_context, vac_entries_per_segment;
-int vac_entries_per_page;
+int num_contexts;
 
 /* Return how much physical memory we have.  */
 unsigned long probe_memory(void)
@@ -62,32 +53,33 @@ unsigned long probe_memory(void)
 static void unhandled_fault(unsigned long, struct task_struct *,
 		struct pt_regs *) __attribute__ ((noreturn));
 
-static void unhandled_fault(unsigned long address, struct task_struct *tsk,
-                     struct pt_regs *regs)
+static void __noreturn unhandled_fault(unsigned long address,
+				       struct task_struct *tsk,
+				       struct pt_regs *regs)
 {
-	if((unsigned long) address < PAGE_SIZE) {
+	if ((unsigned long) address < PAGE_SIZE) {
 		printk(KERN_ALERT
 		    "Unable to handle kernel NULL pointer dereference\n");
 	} else {
-		printk(KERN_ALERT "Unable to handle kernel paging request "
-		       "at virtual address %08lx\n", address);
+		printk(KERN_ALERT "Unable to handle kernel paging request at virtual address %08lx\n",
+		       address);
 	}
 	printk(KERN_ALERT "tsk->{mm,active_mm}->context = %08lx\n",
 		(tsk->mm ? tsk->mm->context : tsk->active_mm->context));
 	printk(KERN_ALERT "tsk->{mm,active_mm}->pgd = %08lx\n",
 		(tsk->mm ? (unsigned long) tsk->mm->pgd :
-		 	(unsigned long) tsk->active_mm->pgd));
+			(unsigned long) tsk->active_mm->pgd));
 	die_if_kernel("Oops", regs);
 }
 
-asmlinkage int lookup_fault(unsigned long pc, unsigned long ret_pc, 
+asmlinkage int lookup_fault(unsigned long pc, unsigned long ret_pc,
 			    unsigned long address)
 {
 	struct pt_regs regs;
 	unsigned long g2;
 	unsigned int insn;
 	int i;
-	
+
 	i = search_extables_range(ret_pc, &g2);
 	switch (i) {
 	case 3:
@@ -107,14 +99,14 @@ asmlinkage int lookup_fault(unsigned long pc, unsigned long ret_pc,
 		/* for _from_ macros */
 		insn = *((unsigned int *) pc);
 		if (!((insn >> 21) & 1) || ((insn>>19)&0x3f) = 15)
-			return 2; 
-		break; 
+			return 2;
+		break;
 
 	default:
 		break;
 	}
 
-	memset(&regs, 0, sizeof (regs));
+	memset(&regs, 0, sizeof(regs));
 	regs.pc = pc;
 	regs.npc = pc + 4;
 	__asm__ __volatile__(
@@ -177,11 +169,10 @@ static unsigned long compute_si_addr(struct pt_regs *regs, int text_fault)
 	if (text_fault)
 		return regs->pc;
 
-	if (regs->psr & PSR_PS) {
+	if (regs->psr & PSR_PS)
 		insn = *(unsigned int *) regs->pc;
-	} else {
+	else
 		__get_user(insn, (unsigned int *) regs->pc);
-	}
 
 	return safe_compute_effective_address(regs, insn);
 }
@@ -207,7 +198,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	unsigned int flags = (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE |
 			      (write ? FAULT_FLAG_WRITE : 0));
 
-	if(text_fault)
+	if (text_fault)
 		address = regs->pc;
 
 	/*
@@ -227,25 +218,25 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
 	 */
-        if (in_atomic() || !mm)
-                goto no_context;
+	if (in_atomic() || !mm)
+		goto no_context;
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
 retry:
 	down_read(&mm->mmap_sem);
 
-	if(!from_user && address >= PAGE_OFFSET)
+	if (!from_user && address >= PAGE_OFFSET)
 		goto bad_area;
 
 	vma = find_vma(mm, address);
-	if(!vma)
+	if (!vma)
 		goto bad_area;
-	if(vma->vm_start <= address)
+	if (vma->vm_start <= address)
 		goto good_area;
-	if(!(vma->vm_flags & VM_GROWSDOWN))
+	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if(expand_stack(vma, address))
+	if (expand_stack(vma, address))
 		goto bad_area;
 	/*
 	 * Ok, we have a good vm_area for this memory access, so
@@ -253,12 +244,12 @@ retry:
 	 */
 good_area:
 	code = SEGV_ACCERR;
-	if(write) {
-		if(!(vma->vm_flags & VM_WRITE))
+	if (write) {
+		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
 	} else {
 		/* Allow reads even for write-only mappings */
-		if(!(vma->vm_flags & (VM_READ | VM_EXEC)))
+		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
 			goto bad_area;
 	}
 
@@ -324,14 +315,16 @@ no_context:
 	g2 = regs->u_regs[UREG_G2];
 	if (!from_user) {
 		fixup = search_extables_range(regs->pc, &g2);
-		if (fixup > 10) { /* Values below are reserved for other things */
+		/* Values below 10 are reserved for other things */
+		if (fixup > 10) {
 			extern const unsigned __memset_start[];
 			extern const unsigned __memset_end[];
 			extern const unsigned __csum_partial_copy_start[];
 			extern const unsigned __csum_partial_copy_end[];
 
 #ifdef DEBUG_EXCEPTIONS
-			printk("Exception: PC<%08lx> faddr<%08lx>\n", regs->pc, address);
+			printk("Exception: PC<%08lx> faddr<%08lx>\n",
+			       regs->pc, address);
 			printk("EX_TABLE: insn<%08lx> fixup<%08x> g2<%08lx>\n",
 				regs->pc, fixup, g2);
 #endif
@@ -339,7 +332,7 @@ no_context:
 			     regs->pc < (unsigned long)__memset_end) ||
 			    (regs->pc >= (unsigned long)__csum_partial_copy_start &&
 			     regs->pc < (unsigned long)__csum_partial_copy_end)) {
-			        regs->u_regs[UREG_I4] = address;
+				regs->u_regs[UREG_I4] = address;
 				regs->u_regs[UREG_I5] = regs->pc;
 			}
 			regs->u_regs[UREG_G2] = g2;
@@ -348,8 +341,8 @@ no_context:
 			return;
 		}
 	}
-	
-	unhandled_fault (address, tsk, regs);
+
+	unhandled_fault(address, tsk, regs);
 	do_exit(SIGKILL);
 
 /*
@@ -395,6 +388,7 @@ vmalloc_fault:
 
 		if (pmd_present(*pmd) || !pmd_present(*pmd_k))
 			goto bad_area_nosemaphore;
+
 		*pmd = *pmd_k;
 		return;
 	}
@@ -412,21 +406,21 @@ static void force_user_fault(unsigned long address, int write)
 
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
-	if(!vma)
+	if (!vma)
 		goto bad_area;
-	if(vma->vm_start <= address)
+	if (vma->vm_start <= address)
 		goto good_area;
-	if(!(vma->vm_flags & VM_GROWSDOWN))
+	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if(expand_stack(vma, address))
+	if (expand_stack(vma, address))
 		goto bad_area;
 good_area:
 	code = SEGV_ACCERR;
-	if(write) {
-		if(!(vma->vm_flags & VM_WRITE))
+	if (write) {
+		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
 	} else {
-		if(!(vma->vm_flags & (VM_READ | VM_EXEC)))
+		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
 			goto bad_area;
 	}
 	switch (handle_mm_fault(mm, vma, address, write ? FAULT_FLAG_WRITE : 0)) {
@@ -457,7 +451,7 @@ void window_overflow_fault(void)
 	unsigned long sp;
 
 	sp = current_thread_info()->rwbuf_stkptrs[0];
-	if(((sp + 0x38) & PAGE_MASK) != (sp & PAGE_MASK))
+	if (((sp + 0x38) & PAGE_MASK) != (sp & PAGE_MASK))
 		force_user_fault(sp + 0x38, 1);
 	force_user_fault(sp, 1);
 
@@ -466,7 +460,7 @@ void window_overflow_fault(void)
 
 void window_underflow_fault(unsigned long sp)
 {
-	if(((sp + 0x38) & PAGE_MASK) != (sp & PAGE_MASK))
+	if (((sp + 0x38) & PAGE_MASK) != (sp & PAGE_MASK))
 		force_user_fault(sp + 0x38, 0);
 	force_user_fault(sp, 0);
 
@@ -478,7 +472,7 @@ void window_ret_fault(struct pt_regs *regs)
 	unsigned long sp;
 
 	sp = regs->u_regs[UREG_FP];
-	if(((sp + 0x38) & PAGE_MASK) != (sp & PAGE_MASK))
+	if (((sp + 0x38) & PAGE_MASK) != (sp & PAGE_MASK))
 		force_user_fault(sp + 0x38, 0);
 	force_user_fault(sp, 0);
 
-- 
1.6.0.6

