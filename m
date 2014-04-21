From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 17:12:21 +0000
Subject: [PATCH 09/24] sparc32: fix sparse warnings in windows.c
Message-Id: <1398100356-19794-9-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
windows.c:16:6: warning: symbol 'flush_user_windows' was not declared. Should it be static?
windows.c:109:6: warning: symbol 'try_to_clear_window_buffer' was not declared. Should it be static?

Add missing include of cacheflush.h + add declaration of try_to_clear_window_buffer in kernel.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/kernel.h  | 4 ++++
 arch/sparc/kernel/windows.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index b293265..7f05d3f 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -109,6 +109,10 @@ void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0,
 asmlinkage int do_sys_sigstack(struct sigstack __user *ssptr,
                                struct sigstack __user *ossptr,
                                unsigned long sp);
+
+/* windows.c */
+void try_to_clear_window_buffer(struct pt_regs *regs, int who);
+
 #else /* CONFIG_SPARC32 */
 #endif /* CONFIG_SPARC32 */
 #endif /* !(__SPARC_KERNEL_H) */
diff --git a/arch/sparc/kernel/windows.c b/arch/sparc/kernel/windows.c
index 3107381..87bab0a 100644
--- a/arch/sparc/kernel/windows.c
+++ b/arch/sparc/kernel/windows.c
@@ -10,8 +10,11 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 
+#include <asm/cacheflush.h>
 #include <asm/uaccess.h>
 
+#include "kernel.h"
+
 /* Do save's until all user register windows are out of the cpu. */
 void flush_user_windows(void)
 {
-- 
1.8.3.1

