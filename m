From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 19:39:17 +0000
Subject: [PATCH 02/29] sparc32: fix sparse warning in fault_32.c
Message-Id: <1398109184-3283-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:
fault_32.c:38:24: error: symbol 'unhandled_fault' redeclared with different type - different modifiers

When this warning was fixed several new warnings popped up - fix them too.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/fault_32.c |  5 ++---
 arch/sparc/mm/mm_32.h    | 10 ++++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 59dbd46..7751810 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -30,10 +30,9 @@
 #include <asm/traps.h>
 #include <asm/uaccess.h>
 
-int show_unhandled_signals = 1;
+#include "mm_32.h"
 
-static void unhandled_fault(unsigned long, struct task_struct *,
-		struct pt_regs *) __attribute__ ((noreturn));
+int show_unhandled_signals = 1;
 
 static void __noreturn unhandled_fault(unsigned long address,
 				       struct task_struct *tsk,
diff --git a/arch/sparc/mm/mm_32.h b/arch/sparc/mm/mm_32.h
index 5703274..ee773e4 100644
--- a/arch/sparc/mm/mm_32.h
+++ b/arch/sparc/mm/mm_32.h
@@ -1,3 +1,13 @@
+/* fault_32.c - visible as they are called from assembler */
+asmlinkage int lookup_fault(unsigned long pc, unsigned long ret_pc,
+                            unsigned long address);
+asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
+                               unsigned long address);
+
+void window_overflow_fault(void);
+void window_underflow_fault(unsigned long sp);
+void window_ret_fault(struct pt_regs *regs);
+
 /* srmmu.c */
 extern char *srmmu_name;
 
-- 
1.8.3.1

