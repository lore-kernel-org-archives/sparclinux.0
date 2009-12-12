From: David Miller <davem@davemloft.net>
Date: Sat, 12 Dec 2009 06:55:30 +0000
Subject: [PATCH 2/10]: sparc64: Use kprobes_built_in() to avoid ifdefs in
Message-Id: <20091211.225530.71091382.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/mm/fault_64.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 43b0da9..0aa50b2 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -31,13 +31,12 @@
 #include <asm/sections.h>
 #include <asm/mmu_context.h>
 
-#ifdef CONFIG_KPROBES
 static inline int notify_page_fault(struct pt_regs *regs)
 {
 	int ret = 0;
 
 	/* kprobe_running() needs smp_processor_id() */
-	if (!user_mode(regs)) {
+	if (kprobes_built_in() && !user_mode(regs)) {
 		preempt_disable();
 		if (kprobe_running() && kprobe_fault_handler(regs, 0))
 			ret = 1;
@@ -45,12 +44,6 @@ static inline int notify_page_fault(struct pt_regs *regs)
 	}
 	return ret;
 }
-#else
-static inline int notify_page_fault(struct pt_regs *regs)
-{
-	return 0;
-}
-#endif
 
 static void __kprobes unhandled_fault(unsigned long address,
 				      struct task_struct *tsk,
-- 
1.6.5

