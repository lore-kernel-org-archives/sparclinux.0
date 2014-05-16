From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:25:54 +0000
Subject: [PATCH 16/34] sparc64: fix sparse warnings in sys_sparc_64.c + unaligned_64.c
Message-Id: <1400275572-17424-16-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1399157559-19901-16-git-send-email-sam@ravnborg.org>
In-Reply-To: <1399157559-19901-16-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
kernel/sys_sparc_64.c:643:17: warning: symbol 'sys_kern_features' was not declared. Should it be static?
kernel/unaligned_64.c:297:17: warning: symbol 'kernel_unaligned_trap' was not declared. Should it be static?
kernel/unaligned_64.c:387:5: warning: symbol 'handle_popc' was not declared. Should it be static?
kernel/unaligned_64.c:428:5: warning: symbol 'handle_ldf_stq' was not declared. Should it be static?
kernel/unaligned_64.c:553:6: warning: symbol 'handle_ld_nf' was not declared. Should it be static?
kernel/unaligned_64.c:579:6: warning: symbol 'handle_lddfmna' was not declared. Should it be static?
kernel/unaligned_64.c:643:6: warning: symbol 'handle_stdfmna' was not declared. Should it be static?

Functions that are only used in kernel/ - add prototypes in kernel.h
Functions used outside kernel/ - add prototype in asm/setup.h
Removed local prototypes

One of the local prototypes had wrong signature (return void - not int).

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/setup.h   |  7 +++++++
 arch/sparc/kernel/kernel.h       | 10 ++++++++++
 arch/sparc/kernel/sys_sparc_64.c |  1 +
 arch/sparc/kernel/traps_64.c     |  7 ++-----
 arch/sparc/kernel/unaligned_64.c |  2 ++
 arch/sparc/mm/fault_64.c         |  4 +---
 6 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 9520e2e..b5f5686 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -47,6 +47,13 @@ unsigned long safe_compute_effective_address(struct pt_regs *, unsigned int);
 
 #endif
 
+#ifdef CONFIG_SPARC64
+/* unaligned_64.c */
+int handle_ldf_stq(u32 insn, struct pt_regs *regs);
+void handle_ld_nf(u32 insn, struct pt_regs *regs);
+
+#endif
+
 void sun_do_break(void);
 extern int stop_a_enabled;
 extern int scons_pwroff;
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 0ce0f96..e122b4b 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -23,6 +23,16 @@ static inline unsigned long kimage_addr_to_ra(const char *p)
 
 	return kern_base + (val - KERNBASE);
 }
+
+/* sys_sparc_64.c */
+asmlinkage long sys_kern_features(void);
+
+/* unaligned_64.c */
+asmlinkage void kernel_unaligned_trap(struct pt_regs *regs, unsigned int insn);
+int handle_popc(u32 insn, struct pt_regs *regs);
+void handle_lddfmna(struct pt_regs *regs, unsigned long sfar, unsigned long sfsr);
+void handle_stdfmna(struct pt_regs *regs, unsigned long sfar, unsigned long sfsr);
+
 #endif
 
 #ifdef CONFIG_SPARC32
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index beb0b5a..c85403d 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -31,6 +31,7 @@
 #include <asm/unistd.h>
 
 #include "entry.h"
+#include "kernel.h"
 #include "systbls.h"
 
 /* #define DEBUG_UNIMP_SYSCALL */
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 86484704..fb6640e 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -43,8 +43,10 @@
 #include <asm/prom.h>
 #include <asm/memctrl.h>
 #include <asm/cacheflush.h>
+#include <asm/setup.h>
 
 #include "entry.h"
+#include "kernel.h"
 #include "kstack.h"
 
 /* When an irrecoverable trap occurs at tl > 0, the trap entry
@@ -2431,9 +2433,6 @@ EXPORT_SYMBOL(die_if_kernel);
 #define VIS_OPCODE_MASK	((0x3 << 30) | (0x3f << 19))
 #define VIS_OPCODE_VAL	((0x2 << 30) | (0x36 << 19))
 
-extern int handle_popc(u32 insn, struct pt_regs *regs);
-extern int handle_ldf_stq(u32 insn, struct pt_regs *regs);
-
 void do_illegal_instruction(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
@@ -2484,8 +2483,6 @@ out:
 	exception_exit(prev_state);
 }
 
-extern void kernel_unaligned_trap(struct pt_regs *regs, unsigned int insn);
-
 void mem_address_unaligned(struct pt_regs *regs, unsigned long sfar, unsigned long sfsr)
 {
 	enum ctx_state prev_state = exception_enter();
diff --git a/arch/sparc/kernel/unaligned_64.c b/arch/sparc/kernel/unaligned_64.c
index 3c1a7cb..bbead0d 100644
--- a/arch/sparc/kernel/unaligned_64.c
+++ b/arch/sparc/kernel/unaligned_64.c
@@ -24,8 +24,10 @@
 #include <linux/context_tracking.h>
 #include <asm/fpumacro.h>
 #include <asm/cacheflush.h>
+#include <asm/setup.h>
 
 #include "entry.h"
+#include "kernel.h"
 
 enum direction {
 	load,    /* ld, ldd, ldh, ldsh */
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 69bb818..7813a81 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -32,6 +32,7 @@
 #include <asm/lsu.h>
 #include <asm/sections.h>
 #include <asm/mmu_context.h>
+#include <asm/setup.h>
 
 int show_unhandled_signals = 1;
 
@@ -174,9 +175,6 @@ static void do_fault_siginfo(int code, int sig, struct pt_regs *regs,
 	force_sig_info(sig, &info, current);
 }
 
-extern int handle_ldf_stq(u32, struct pt_regs *);
-extern int handle_ld_nf(u32, struct pt_regs *);
-
 static unsigned int get_fault_insn(struct pt_regs *regs, unsigned int insn)
 {
 	if (!insn) {
-- 
1.9.0

