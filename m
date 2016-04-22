From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 22 Apr 2016 17:41:03 +0000
Subject: [PATCH 1/5] sparc32: drop hardcoding trap_level in kgdb_trap
Message-Id: <1461346867-9736-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix this so we pass the trap_level from the actual trap
code like we do in sparc64.
Add use on ENTRY(), ENDPROC() in the assembler function too.

This fixes a bug where the hardcoded value for trap_level
was the sparc64 value.

As the generic code does not use the trap_level argument
(for sparc32) - this patch does not have any functional impact.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/head_32.h |  8 ++++----
 arch/sparc/include/asm/kgdb.h    |  2 +-
 arch/sparc/kernel/entry.S        | 10 ++++------
 arch/sparc/kernel/kgdb_32.c      |  6 +++---
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/include/asm/head_32.h b/arch/sparc/include/asm/head_32.h
index 5f1dbe3..6fc60fd 100644
--- a/arch/sparc/include/asm/head_32.h
+++ b/arch/sparc/include/asm/head_32.h
@@ -43,10 +43,10 @@
 	nop;
 
 #ifdef CONFIG_KGDB
-#define KGDB_TRAP(num) \
-	b kgdb_trap_low; \
-	rd %psr,%l0; \
-	nop; \
+#define KGDB_TRAP(num)                  \
+	mov num, %l7;                   \
+	b kgdb_trap_low;                \
+	rd %psr,%l0;                    \
 	nop;
 #else
 #define KGDB_TRAP(num) \
diff --git a/arch/sparc/include/asm/kgdb.h b/arch/sparc/include/asm/kgdb.h
index 47366af..a6ad7bf 100644
--- a/arch/sparc/include/asm/kgdb.h
+++ b/arch/sparc/include/asm/kgdb.h
@@ -28,10 +28,10 @@ enum regnames {
 #define NUMREGBYTES		((GDB_CSR + 1) * 4)
 #else
 #define NUMREGBYTES		((GDB_Y + 1) * 8)
+#endif
 
 struct pt_regs;
 asmlinkage void kgdb_trap(unsigned long trap_level, struct pt_regs *regs);
-#endif
 
 void arch_kgdb_breakpoint(void);
 
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index a83707c..6ece718 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -1225,20 +1225,18 @@ breakpoint_trap:
 	RESTORE_ALL
 
 #ifdef CONFIG_KGDB
-	.align	4
-	.globl	kgdb_trap_low
-	.type	kgdb_trap_low,#function
-kgdb_trap_low:
+	ENTRY(kgdb_trap_low)
 	rd	%wim,%l3
 	SAVE_ALL
 	wr 	%l0, PSR_ET, %psr
 	WRITE_PAUSE
 
+	mov	%l7, %o0		! trap_level
 	call	kgdb_trap
-	 add	%sp, STACKFRAME_SZ, %o0
+	 add	%sp, STACKFRAME_SZ, %o1	! struct pt_regs *regs
 
 	RESTORE_ALL
-	.size	kgdb_trap_low,.-kgdb_trap_low
+	ENDPROC(kgdb_trap_low)
 #endif
 
 	.align	4
diff --git a/arch/sparc/kernel/kgdb_32.c b/arch/sparc/kernel/kgdb_32.c
index dcf2108..5d0a323 100644
--- a/arch/sparc/kernel/kgdb_32.c
+++ b/arch/sparc/kernel/kgdb_32.c
@@ -135,19 +135,19 @@ int kgdb_arch_handle_exception(int e_vector, int signo, int err_code,
 
 extern void do_hw_interrupt(struct pt_regs *regs, unsigned long type);
 
-asmlinkage void kgdb_trap(struct pt_regs *regs)
+asmlinkage void kgdb_trap(unsigned long trap_level, struct pt_regs *regs)
 {
 	unsigned long flags;
 
 	if (user_mode(regs)) {
-		do_hw_interrupt(regs, 0xfd);
+		do_hw_interrupt(regs, trap_level);
 		return;
 	}
 
 	flushw_all();
 
 	local_irq_save(flags);
-	kgdb_handle_exception(0x172, SIGTRAP, 0, regs);
+	kgdb_handle_exception(trap_level, SIGTRAP, 0, regs);
 	local_irq_restore(flags);
 }
 
-- 
2.5.0

