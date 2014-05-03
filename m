From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 May 2014 22:52:11 +0000
Subject: [PATCH 06/34] sparc32: fix sparse warnings in sys_sparc_32.c
Message-Id: <1399157559-19901-6-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
sys_sparc_32.c:32:26: warning: symbol 'sys_getpagesize' was not declared. Should it be static?
sys_sparc_32.c:71:16: warning: symbol 'sparc_pipe' was not declared. Should it be static?
sys_sparc_32.c:96:26: warning: symbol 'sys_mmap2' was not declared. Should it be static?
sys_sparc_32.c:106:26: warning: symbol 'sys_mmap' was not declared. Should it be static?
sys_sparc_32.c:114:6: warning: symbol 'sparc_remap_file_pages' was not declared. Should it be static?
sys_sparc_32.c:127:1: warning: symbol 'c_sys_nis_syscall' was not declared. Should it be static?
sys_sparc_32.c:144:1: warning: symbol 'sparc_breakpoint' was not declared. Should it be static?
sys_sparc_32.c:200:16: warning: symbol 'sys_getdomainname' was not declared. Should it be static?

Adapt systbls.h for use by both sparc32 + sparc64.
In the process modify the return type of a few functions:

Change return type from unsigned long to long:
sys_mmap2()
sys_mmap()

Change return type from int to long:
sparc_pipe()
sys_getdomainname()

The changed return type was done to align with sparc64.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/sys_sparc_32.c | 10 +++---
 arch/sparc/kernel/systbls.h      | 71 +++++++++++++++++++++++-----------------
 2 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
index 3a8d184..646988d 100644
--- a/arch/sparc/kernel/sys_sparc_32.c
+++ b/arch/sparc/kernel/sys_sparc_32.c
@@ -24,6 +24,8 @@
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 
+#include "systbls.h"
+
 /* #define DEBUG_UNIMP_SYSCALL */
 
 /* XXX Make this per-binary type, this way we can detect the type of
@@ -68,7 +70,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
  * sys_pipe() is the normal C calling standard for creating
  * a pipe. It's not the way unix traditionally does this, though.
  */
-asmlinkage int sparc_pipe(struct pt_regs *regs)
+asmlinkage long sparc_pipe(struct pt_regs *regs)
 {
 	int fd[2];
 	int error;
@@ -93,7 +95,7 @@ int sparc_mmap_check(unsigned long addr, unsigned long len)
 
 /* Linux version of mmap */
 
-asmlinkage unsigned long sys_mmap2(unsigned long addr, unsigned long len,
+asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags, unsigned long fd,
 	unsigned long pgoff)
 {
@@ -103,7 +105,7 @@ asmlinkage unsigned long sys_mmap2(unsigned long addr, unsigned long len,
 			      pgoff >> (PAGE_SHIFT - 12));
 }
 
-asmlinkage unsigned long sys_mmap(unsigned long addr, unsigned long len,
+asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags, unsigned long fd,
 	unsigned long off)
 {
@@ -197,7 +199,7 @@ SYSCALL_DEFINE5(rt_sigaction, int, sig,
 	return ret;
 }
 
-asmlinkage int sys_getdomainname(char __user *name, int len)
+asmlinkage long sys_getdomainname(char __user *name, int len)
 {
  	int nlen, err;
  	
diff --git a/arch/sparc/kernel/systbls.h b/arch/sparc/kernel/systbls.h
index 26e6dd7..a3ed7ae 100644
--- a/arch/sparc/kernel/systbls.h
+++ b/arch/sparc/kernel/systbls.h
@@ -6,36 +6,47 @@
 #include <linux/signal.h>
 #include <asm/utrap.h>
 
-extern asmlinkage unsigned long sys_getpagesize(void);
-extern asmlinkage long sparc_pipe(struct pt_regs *regs);
-extern asmlinkage long sys_sparc_ipc(unsigned int call, int first,
-			       unsigned long second,
-			       unsigned long third,
-			       void __user *ptr, long fifth);
-extern asmlinkage long sparc64_personality(unsigned long personality);
-extern asmlinkage long sys64_munmap(unsigned long addr, size_t len);
-extern asmlinkage unsigned long sys64_mremap(unsigned long addr,
-					     unsigned long old_len,
-					     unsigned long new_len,
-					     unsigned long flags,
-					     unsigned long new_addr);
-extern asmlinkage unsigned long c_sys_nis_syscall(struct pt_regs *regs);
-extern asmlinkage long sys_getdomainname(char __user *name, int len);
-extern asmlinkage long sys_utrap_install(utrap_entry_t type,
-					 utrap_handler_t new_p,
-					 utrap_handler_t new_d,
-					 utrap_handler_t __user *old_p,
-					 utrap_handler_t __user *old_d);
-extern asmlinkage long sparc_memory_ordering(unsigned long model,
-					     struct pt_regs *regs);
-extern asmlinkage long sys_rt_sigaction(int sig,
-					const struct sigaction __user *act,
-					struct sigaction __user *oact,
-					void __user *restorer,
-					size_t sigsetsize);
+asmlinkage unsigned long sys_getpagesize(void);
+asmlinkage long sparc_pipe(struct pt_regs *regs);
+asmlinkage unsigned long c_sys_nis_syscall(struct pt_regs *regs);
+asmlinkage long sys_getdomainname(char __user *name, int len);
+void do_rt_sigreturn(struct pt_regs *regs);
+asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
+			 unsigned long prot, unsigned long flags,
+			 unsigned long fd, unsigned long off);
+asmlinkage void sparc_breakpoint(struct pt_regs *regs);
 
-extern asmlinkage void sparc64_set_context(struct pt_regs *regs);
-extern asmlinkage void sparc64_get_context(struct pt_regs *regs);
-extern void do_rt_sigreturn(struct pt_regs *regs);
+#ifdef CONFIG_SPARC32
+asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
+			  unsigned long prot, unsigned long flags,
+			  unsigned long fd, unsigned long pgoff);
+long sparc_remap_file_pages(unsigned long start, unsigned long size,
+			    unsigned long prot, unsigned long pgoff,
+			    unsigned long flags);
 
+#endif /* CONFIG_SPARC32 */
+
+#ifdef CONFIG_SPARC64
+asmlinkage long sys_sparc_ipc(unsigned int call, int first,
+			      unsigned long second,
+			      unsigned long third,
+			      void __user *ptr, long fifth);
+asmlinkage long sparc64_personality(unsigned long personality);
+asmlinkage long sys64_munmap(unsigned long addr, size_t len);
+asmlinkage unsigned long sys64_mremap(unsigned long addr,
+				      unsigned long old_len,
+				      unsigned long new_len,
+				      unsigned long flags,
+				      unsigned long new_addr);
+asmlinkage long sys_utrap_install(utrap_entry_t type,
+				  utrap_handler_t new_p,
+				  utrap_handler_t new_d,
+				  utrap_handler_t __user *old_p,
+				  utrap_handler_t __user *old_d);
+asmlinkage long sparc_memory_ordering(unsigned long model,
+				      struct pt_regs *regs);
+asmlinkage void sparc64_set_context(struct pt_regs *regs);
+asmlinkage void sparc64_get_context(struct pt_regs *regs);
+
+#endif /* CONFIG_SPARC64 */
 #endif /* _SYSTBLS_H */
-- 
1.9.0

