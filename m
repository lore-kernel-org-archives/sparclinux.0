From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 21:49:49 +0000
Subject: [PATCH 14/16]: sparc64: Fix sparse warnings in fault.c
Message-Id: <20080912.144949.92371839.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Fix sparse warnings in fault.c

1) set_brkpt() is referenced by nothing and hasn't been used by anyone
   to my knowledge for many many years.  So just delete it.

2) add extern decl for do_sparc64_fault() in asm/pgtable_64.h

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_64.h |    2 +
 arch/sparc64/mm/fault.c             |   37 -----------------------------------
 2 files changed, 2 insertions(+), 37 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index bb9ec2c..b049abf 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -770,6 +770,8 @@ extern void sun4v_patch_tlb_handlers(void);
 
 extern unsigned long cmdline_memory_size;
 
+extern asmlinkage void do_sparc64_fault(struct pt_regs *regs);
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(_SPARC64_PGTABLE_H) */
diff --git a/arch/sparc64/mm/fault.c b/arch/sparc64/mm/fault.c
index ea7d7ae..a9e474b 100644
--- a/arch/sparc64/mm/fault.c
+++ b/arch/sparc64/mm/fault.c
@@ -51,43 +51,6 @@ static inline int notify_page_fault(struct pt_regs *regs)
 }
 #endif
 
-/*
- * To debug kernel to catch accesses to certain virtual/physical addresses.
- * Mode = 0 selects physical watchpoints, mode = 1 selects virtual watchpoints.
- * flags = VM_READ watches memread accesses, flags = VM_WRITE watches memwrite accesses.
- * Caller passes in a 64bit aligned addr, with mask set to the bytes that need to be
- * watched. This is only useful on a single cpu machine for now. After the watchpoint
- * is detected, the process causing it will be killed, thus preventing an infinite loop.
- */
-void set_brkpt(unsigned long addr, unsigned char mask, int flags, int mode)
-{
-	unsigned long lsubits;
-
-	__asm__ __volatile__("ldxa [%%g0] %1, %0"
-			     : "=r" (lsubits)
-			     : "i" (ASI_LSU_CONTROL));
-	lsubits &= ~(LSU_CONTROL_PM | LSU_CONTROL_VM |
-		     LSU_CONTROL_PR | LSU_CONTROL_VR |
-		     LSU_CONTROL_PW | LSU_CONTROL_VW);
-
-	__asm__ __volatile__("stxa	%0, [%1] %2\n\t"
-			     "membar	#Sync"
-			     : /* no outputs */
-			     : "r" (addr), "r" (mode ? VIRT_WATCHPOINT : PHYS_WATCHPOINT),
-			       "i" (ASI_DMMU));
-
-	lsubits |= ((unsigned long)mask << (mode ? 25 : 33));
-	if (flags & VM_READ)
-		lsubits |= (mode ? LSU_CONTROL_VR : LSU_CONTROL_PR);
-	if (flags & VM_WRITE)
-		lsubits |= (mode ? LSU_CONTROL_VW : LSU_CONTROL_PW);
-	__asm__ __volatile__("stxa %0, [%%g0] %1\n\t"
-			     "membar #Sync"
-			     : /* no outputs */
-			     : "r" (lsubits), "i" (ASI_LSU_CONTROL)
-			     : "memory");
-}
-
 static void __kprobes unhandled_fault(unsigned long address,
 				      struct task_struct *tsk,
 				      struct pt_regs *regs)
-- 
1.5.6.5.GIT

