From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 19:39:37 +0000
Subject: [PATCH 22/29] sparc32: fix sparse warning in ptrace_32.c
Message-Id: <1398109184-3283-22-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:
ptrace_32.c:444:16: warning: symbol 'syscall_trace' was not declared. Should it be static?

Add declaration in kernel.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/kernel.h    | 3 +++
 arch/sparc/kernel/ptrace_32.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 716158a..2c312a2 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -110,6 +110,9 @@ asmlinkage int do_sys_sigstack(struct sigstack __user *ssptr,
                                struct sigstack __user *ossptr,
                                unsigned long sp);
 
+/* ptrace_32.c */
+asmlinkage int syscall_trace(struct pt_regs *regs, int syscall_exit_p);
+
 /* windows.c */
 void try_to_clear_window_buffer(struct pt_regs *regs, int who);
 
diff --git a/arch/sparc/kernel/ptrace_32.c b/arch/sparc/kernel/ptrace_32.c
index 896ba7c..a331fdc 100644
--- a/arch/sparc/kernel/ptrace_32.c
+++ b/arch/sparc/kernel/ptrace_32.c
@@ -26,6 +26,8 @@
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
 
+#include "kernel.h"
+
 /* #define ALLOW_INIT_TRACING */
 
 /*
-- 
1.8.3.1

