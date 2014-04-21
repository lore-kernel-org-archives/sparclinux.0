From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 19:39:38 +0000
Subject: [PATCH 23/29] sparc32: fix sparse warnings in unaligned_32.c
Message-Id: <1398109184-3283-23-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
unaligned_32.c:146:15: warning: symbol 'safe_compute_effective_address' was not declared. Should it be static?
unaligned_32.c:235:17: warning: symbol 'kernel_unaligned_trap' was not declared. Should it be static?
unaligned_32.c:319:17: warning: symbol 'user_unaligned_trap' was not declared. Should it be static?

Add proper declarations in kernel.h + setup.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/setup.h   | 3 +++
 arch/sparc/kernel/kernel.h       | 4 ++++
 arch/sparc/kernel/unaligned_32.c | 4 ++++
 arch/sparc/mm/fault_32.c         | 4 +---
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 622145b..fb54505 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -42,6 +42,9 @@ extern unsigned long cmdline_memory_size;
 /* devices.c */
 void __init device_scan(void);
 
+/* unaligned_32.c */
+unsigned long safe_compute_effective_address(struct pt_regs *, unsigned int);
+
 #endif
 
 extern void sun_do_break(void);
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 2c312a2..4f22038 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -113,6 +113,10 @@ asmlinkage int do_sys_sigstack(struct sigstack __user *ssptr,
 /* ptrace_32.c */
 asmlinkage int syscall_trace(struct pt_regs *regs, int syscall_exit_p);
 
+/* unaligned_32.c */
+asmlinkage void kernel_unaligned_trap(struct pt_regs *regs, unsigned int insn);
+asmlinkage void user_unaligned_trap(struct pt_regs *regs, unsigned int insn);
+
 /* windows.c */
 void try_to_clear_window_buffer(struct pt_regs *regs, int who);
 
diff --git a/arch/sparc/kernel/unaligned_32.c b/arch/sparc/kernel/unaligned_32.c
index c0ec897..c5c61b3 100644
--- a/arch/sparc/kernel/unaligned_32.c
+++ b/arch/sparc/kernel/unaligned_32.c
@@ -16,6 +16,10 @@
 #include <linux/smp.h>
 #include <linux/perf_event.h>
 
+#include <asm/setup.h>
+
+#include "kernel.h"
+
 enum direction {
 	load,    /* ld, ldd, ldh, ldsh */
 	store,   /* st, std, sth, stsh */
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 7751810..908e8c1 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -26,6 +26,7 @@
 #include <asm/pgtable.h>
 #include <asm/openprom.h>
 #include <asm/oplib.h>
+#include <asm/setup.h>
 #include <asm/smp.h>
 #include <asm/traps.h>
 #include <asm/uaccess.h>
@@ -140,9 +141,6 @@ static void __do_fault_siginfo(int code, int sig, struct pt_regs *regs,
 	force_sig_info (sig, &info, current);
 }
 
-extern unsigned long safe_compute_effective_address(struct pt_regs *,
-						    unsigned int);
-
 static unsigned long compute_si_addr(struct pt_regs *regs, int text_fault)
 {
 	unsigned int insn;
-- 
1.8.3.1

