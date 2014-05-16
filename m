From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:26:08 +0000
Subject: [PATCH 30/34] sparc64: fix sparse warnings in compat_audit.c
Message-Id: <1400275572-17424-30-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1399157559-19901-30-git-send-email-sam@ravnborg.org>
In-Reply-To: <1399157559-19901-30-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
compat_audit.c:4:10: warning: symbol 'sparc32_dir_class' was not declared. Should it be static?
compat_audit.c:9:10: warning: symbol 'sparc32_chattr_class' was not declared. Should it be static?
compat_audit.c:14:10: warning: symbol 'sparc32_write_class' was not declared. Should it be static?
compat_audit.c:19:10: warning: symbol 'sparc32_read_class' was not declared. Should it be static?
compat_audit.c:24:10: warning: symbol 'sparc32_signal_class' was not declared. Should it be static?
compat_audit.c:29:5: warning: symbol 'sparc32_classify_syscall' was not declared. Should it be static?

Add declarations to kernel.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/audit.c        | 8 ++------
 arch/sparc/kernel/compat_audit.c | 1 +
 arch/sparc/kernel/kernel.h       | 7 +++++++
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/audit.c b/arch/sparc/kernel/audit.c
index 8fff0ac..24361b4 100644
--- a/arch/sparc/kernel/audit.c
+++ b/arch/sparc/kernel/audit.c
@@ -3,6 +3,8 @@
 #include <linux/audit.h>
 #include <asm/unistd.h>
 
+#include "kernel.h"
+
 static unsigned dir_class[] = {
 #include <asm-generic/audit_dir_write.h>
 ~0U
@@ -40,7 +42,6 @@ int audit_classify_arch(int arch)
 int audit_classify_syscall(int abi, unsigned syscall)
 {
 #ifdef CONFIG_COMPAT
-	extern int sparc32_classify_syscall(unsigned);
 	if (abi = AUDIT_ARCH_SPARC)
 		return sparc32_classify_syscall(syscall);
 #endif
@@ -61,11 +62,6 @@ int audit_classify_syscall(int abi, unsigned syscall)
 static int __init audit_classes_init(void)
 {
 #ifdef CONFIG_COMPAT
-	extern __u32 sparc32_dir_class[];
-	extern __u32 sparc32_write_class[];
-	extern __u32 sparc32_read_class[];
-	extern __u32 sparc32_chattr_class[];
-	extern __u32 sparc32_signal_class[];
 	audit_register_class(AUDIT_CLASS_WRITE_32, sparc32_write_class);
 	audit_register_class(AUDIT_CLASS_READ_32, sparc32_read_class);
 	audit_register_class(AUDIT_CLASS_DIR_WRITE_32, sparc32_dir_class);
diff --git a/arch/sparc/kernel/compat_audit.c b/arch/sparc/kernel/compat_audit.c
index d865575..7062263 100644
--- a/arch/sparc/kernel/compat_audit.c
+++ b/arch/sparc/kernel/compat_audit.c
@@ -1,5 +1,6 @@
 #define __32bit_syscall_numbers__
 #include <asm/unistd.h>
+#include "kernel.h"
 
 unsigned sparc32_dir_class[] = {
 #include <asm-generic/audit_dir_write.h>
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 980e21d..8021372 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -50,6 +50,13 @@ asmlinkage void do_rt_sigreturn32(struct pt_regs *regs);
 void do_signal32(struct pt_regs * regs);
 asmlinkage int do_sys32_sigstack(u32 u_ssptr, u32 u_ossptr, unsigned long sp);
 
+/* compat_audit.c */
+extern unsigned sparc32_dir_class[];
+extern unsigned sparc32_chattr_class[];
+extern unsigned sparc32_write_class[];
+extern unsigned sparc32_read_class[];
+extern unsigned sparc32_signal_class[];
+int sparc32_classify_syscall(unsigned syscall);
 #endif
 
 #ifdef CONFIG_SPARC32
-- 
1.9.0

