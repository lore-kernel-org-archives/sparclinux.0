From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 07 Dec 2008 20:37:35 +0000
Subject: [PATCH 4/5] sparc: add include guards to kernel.h
Message-Id: <1228682256-27812-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/kernel.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 3fa8338..48e7037 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -1,3 +1,5 @@
+#ifndef __SPARC_KERNEL_H
+#define __SPARC_KERNEL_H
 /* cpu.c */
 extern const char *sparc_cpu_type;
 extern const char *sparc_fpu_type;
@@ -14,4 +16,5 @@ extern void handle_hw_divzero(struct pt_regs *regs, unsigned long pc,
 /* muldiv.c */
 extern int do_user_muldiv (struct pt_regs *, unsigned long);
 #else /* CONFIG_SPARC32 */
-#endif
+#endif /* CONFIG_SPARC32 */
+#endif /* !(__SPARC_KERNEL_H) */
-- 
1.5.6.GIT

