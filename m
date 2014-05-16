From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:26:00 +0000
Subject: [PATCH 22/34] sparc64: fix sparse "Should it be static?" warnings in signal32.c
Message-Id: <1400275572-17424-22-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1399157559-19901-22-git-send-email-sam@ravnborg.org>
In-Reply-To: <1399157559-19901-22-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
signal32.c:140:6: warning: symbol 'do_sigreturn32' was not declared. Should it be static?
signal32.c:230:17: warning: symbol 'do_rt_sigreturn32' was not declared. Should it be static?
signal32.c:729:6: warning: symbol 'do_signal32' was not declared. Should it be static?
signal32.c:773:16: warning: symbol 'do_sys32_sigstack' was not declared. Should it be static?

Add proper prototypes and drop local prototype

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/kernel.h    | 6 ++++++
 arch/sparc/kernel/signal32.c  | 1 +
 arch/sparc/kernel/signal_64.c | 6 +++---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index eeb87f7..980e21d 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -44,6 +44,12 @@ void __irq_entry smp_receive_signal_client(int irq, struct pt_regs *regs);
 /* pci.c */
 int pci64_dma_supported(struct pci_dev *pdev, u64 device_mask);
 
+/* signal32.c */
+void do_sigreturn32(struct pt_regs *regs);
+asmlinkage void do_rt_sigreturn32(struct pt_regs *regs);
+void do_signal32(struct pt_regs * regs);
+asmlinkage int do_sys32_sigstack(u32 u_ssptr, u32 u_ossptr, unsigned long sp);
+
 #endif
 
 #ifdef CONFIG_SPARC32
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index ee789d2..ab33c99 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -31,6 +31,7 @@
 #include <asm/switch_to.h>
 
 #include "sigutil.h"
+#include "kernel.h"
 
 /* This magic should be in g_upper[0] for all upper parts
  * to be valid.
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index cd91d01..1a69998 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -35,9 +35,10 @@
 #include <asm/switch_to.h>
 #include <asm/cacheflush.h>
 
-#include "entry.h"
-#include "systbls.h"
 #include "sigutil.h"
+#include "systbls.h"
+#include "kernel.h"
+#include "entry.h"
 
 /* {set, get}context() needed for 64-bit SparcLinux userland. */
 asmlinkage void sparc64_set_context(struct pt_regs *regs)
@@ -492,7 +493,6 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 
 #ifdef CONFIG_COMPAT
 	if (test_thread_flag(TIF_32BIT)) {
-		extern void do_signal32(struct pt_regs *);
 		do_signal32(regs);
 		return;
 	}
-- 
1.9.0

