From: David Miller <davem@davemloft.net>
Date: Wed, 20 Jan 2010 11:32:42 +0000
Subject: [PATCH]: sparc: Add missing SW perf fault events.
Message-Id: <20100120.033242.177709509.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/mm/fault_32.c |   12 ++++++++++--
 arch/sparc/mm/fault_64.c |   13 ++++++++++---
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index b99f81c..a3413ac 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -18,6 +18,7 @@
 #include <linux/signal.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
+#include <linux/perf_event.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/kdebug.h>
@@ -203,6 +204,8 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
         if (in_atomic() || !mm)
                 goto no_context;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, 0, regs, address);
+
 	down_read(&mm->mmap_sem);
 
 	/*
@@ -249,10 +252,15 @@ good_area:
 			goto do_sigbus;
 		BUG();
 	}
-	if (fault & VM_FAULT_MAJOR)
+	if (fault & VM_FAULT_MAJOR) {
 		current->maj_flt++;
-	else
+		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, 0,
+			      regs, address);
+	} else {
 		current->min_flt++;
+		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, 0,
+			      regs, address);
+	}
 	up_read(&mm->mmap_sem);
 	return;
 
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 6081936..b9d4ff0 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -16,6 +16,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/perf_event.h>
 #include <linux/interrupt.h>
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
@@ -296,6 +297,8 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 	if (in_atomic() || !mm)
 		goto intr_or_no_mm;
 
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, 0, regs, address);
+
 	if (!down_read_trylock(&mm->mmap_sem)) {
 		if ((regs->tstate & TSTATE_PRIV) &&
 		    !search_exception_tables(regs->tpc)) {
@@ -400,11 +403,15 @@ good_area:
 			goto do_sigbus;
 		BUG();
 	}
-	if (fault & VM_FAULT_MAJOR)
+	if (fault & VM_FAULT_MAJOR) {
 		current->maj_flt++;
-	else
+		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, 0,
+			      regs, address);
+	} else {
 		current->min_flt++;
-
+		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, 0,
+			      regs, address);
+	}
 	up_read(&mm->mmap_sem);
 
 	mm_rss = get_mm_rss(mm);
-- 
1.6.5

