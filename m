From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Apr 2014 19:55:21 +0000
Subject: [PATCH 2/5] sparc32: fix sparse warning in fault_32.c
Message-Id: <20140420195520.GB17743@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From ade61f6c32462ce4f8c27a6e9edf40d53d39f7f1 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Apr 2014 19:56:50 +0200
Subject: [PATCH 2/5] sparc32: fix sparse warning in fault_32.c

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
index 5703274..e6af5ae 100644
--- a/arch/sparc/mm/mm_32.h
+++ b/arch/sparc/mm/mm_32.h
@@ -1,3 +1,13 @@
+/* fault_32.c - visible as they are called from assembler */
+extern asmlinkage int lookup_fault(unsigned long pc, unsigned long ret_pc,
+                                   unsigned long address);
+extern asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
+                                      unsigned long address);
+
+extern void window_overflow_fault(void);
+extern void window_underflow_fault(unsigned long sp);
+extern void window_ret_fault(struct pt_regs *regs);
+
 /* srmmu.c */
 extern char *srmmu_name;
 
-- 
1.8.3.1

