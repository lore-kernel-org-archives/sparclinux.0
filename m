From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 May 2014 22:52:36 +0000
Subject: [PATCH 31/34] sparc64: fix sparse warning in kgdb_64.c
Message-Id: <1399157559-19901-31-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
kgdb_64.c:114:18: warning: symbol 'smp_kgdb_capture_client' was not declared. Should it be static?
kgdb_64.c:161:17: warning: symbol 'kgdb_trap' was not declared. Should it be static?

Add proper prototypes

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/kgdb.h | 3 +++
 arch/sparc/kernel/kernel.h    | 3 +++
 arch/sparc/kernel/kgdb_64.c   | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/sparc/include/asm/kgdb.h b/arch/sparc/include/asm/kgdb.h
index 5a8ee15..47366af 100644
--- a/arch/sparc/include/asm/kgdb.h
+++ b/arch/sparc/include/asm/kgdb.h
@@ -28,6 +28,9 @@ enum regnames {
 #define NUMREGBYTES		((GDB_CSR + 1) * 4)
 #else
 #define NUMREGBYTES		((GDB_Y + 1) * 8)
+
+struct pt_regs;
+asmlinkage void kgdb_trap(unsigned long trap_level, struct pt_regs *regs);
 #endif
 
 void arch_kgdb_breakpoint(void);
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 8021372..e7f652b 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -41,6 +41,9 @@ void __irq_entry smp_new_mmu_context_version_client(int irq, struct pt_regs *reg
 void __irq_entry smp_penguin_jailcell(int irq, struct pt_regs *regs);
 void __irq_entry smp_receive_signal_client(int irq, struct pt_regs *regs);
 
+/* kgdb_64.c */
+void __irq_entry smp_kgdb_capture_client(int irq, struct pt_regs *regs);
+
 /* pci.c */
 int pci64_dma_supported(struct pci_dev *pdev, u64 device_mask);
 
diff --git a/arch/sparc/kernel/kgdb_64.c b/arch/sparc/kernel/kgdb_64.c
index b45fe3f..cbf21d0 100644
--- a/arch/sparc/kernel/kgdb_64.c
+++ b/arch/sparc/kernel/kgdb_64.c
@@ -13,6 +13,8 @@
 #include <asm/ptrace.h>
 #include <asm/irq.h>
 
+#include "kernel.h"
+
 void pt_regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 {
 	struct reg_window *win;
-- 
1.9.0

