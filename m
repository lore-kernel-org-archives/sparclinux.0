From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 04:32:11 +0000
Subject: [PATCH] sparc32: Remove sparc_lvl15_nmi().
Message-Id: <20120512.003211.951859984802886720.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


No longer used.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/mm/fault_32.c |   15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index a0f4db9..dd020b2 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -59,21 +59,6 @@ unsigned long probe_memory(void)
 	return total;
 }
 
-/* Whee, a level 15 NMI interrupt memory error.  Let's have fun... */
-asmlinkage void sparc_lvl15_nmi(struct pt_regs *regs, unsigned long serr,
-				unsigned long svaddr, unsigned long aerr,
-				unsigned long avaddr)
-{
-	printk("FAULT: NMI received\n");
-	printk("SREGS: Synchronous Error %08lx\n", serr);
-	printk("       Synchronous Vaddr %08lx\n", svaddr);
-	printk("      Asynchronous Error %08lx\n", aerr);
-	printk("      Asynchronous Vaddr %08lx\n", avaddr);
-	printk("REGISTER DUMP:\n");
-	show_regs(regs);
-	prom_halt();
-}
-
 static void unhandled_fault(unsigned long, struct task_struct *,
 		struct pt_regs *) __attribute__ ((noreturn));
 
-- 
1.7.10

