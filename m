From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:25:59 +0000
Subject: [PATCH 21/34] sparc64: fix sparse warnings in sys_sparc32.c
Message-Id: <1400275572-17424-21-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1399157559-19901-21-git-send-email-sam@ravnborg.org>
In-Reply-To: <1399157559-19901-21-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
sys_sparc32.c:52:17: warning: symbol 'sys32_truncate64' was not declared. Should it be static?
sys_sparc32.c:60:17: warning: symbol 'sys32_ftruncate64' was not declared. Should it be static?
sys_sparc32.c:98:17: warning: symbol 'compat_sys_stat64' was not declared. Should it be static?
sys_sparc32.c:109:17: warning: symbol 'compat_sys_lstat64' was not declared. Should it be static?
sys_sparc32.c:120:17: warning: symbol 'compat_sys_fstat64' was not declared. Should it be static?
sys_sparc32.c:131:17: warning: symbol 'compat_sys_fstatat64' was not declared. Should it be static?
sys_sparc32.c:196:27: warning: symbol 'sys32_pread64' was not declared. Should it be static?
sys_sparc32.c:205:27: warning: symbol 'sys32_pwrite64' was not declared. Should it be static?
sys_sparc32.c:214:17: warning: symbol 'compat_sys_readahead' was not declared. Should it be static?
sys_sparc32.c:222:6: warning: symbol 'compat_sys_fadvise64' was not declared. Should it be static?
sys_sparc32.c:230:6: warning: symbol 'compat_sys_fadvise64_64' was not declared. Should it be static?
sys_sparc32.c:241:6: warning: symbol 'sys32_sync_file_range' was not declared. Should it be static?
sys_sparc32.c:249:17: warning: symbol 'compat_sys_fallocate' was not declared. Should it be static?

Add proper prototypes in systbls.h
Include linux/compat.h to get access to necessary types
Use inverse christmas tree order in includes

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/sys_sparc32.c |  2 ++
 arch/sparc/kernel/systbls.h     | 55 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc32.c b/arch/sparc/kernel/sys_sparc32.c
index 7136885..022c30c 100644
--- a/arch/sparc/kernel/sys_sparc32.c
+++ b/arch/sparc/kernel/sys_sparc32.c
@@ -49,6 +49,8 @@
 #include <asm/mmu_context.h>
 #include <asm/compat_signal.h>
 
+#include "systbls.h"
+
 asmlinkage long sys32_truncate64(const char __user * path, unsigned long high, unsigned long low)
 {
 	if ((int)high < 0)
diff --git a/arch/sparc/kernel/systbls.h b/arch/sparc/kernel/systbls.h
index a3ed7ae..2dab823 100644
--- a/arch/sparc/kernel/systbls.h
+++ b/arch/sparc/kernel/systbls.h
@@ -1,9 +1,11 @@
 #ifndef _SYSTBLS_H
 #define _SYSTBLS_H
 
+#include <linux/signal.h>
 #include <linux/kernel.h>
+#include <linux/compat.h>
 #include <linux/types.h>
-#include <linux/signal.h>
+
 #include <asm/utrap.h>
 
 asmlinkage unsigned long sys_getpagesize(void);
@@ -47,6 +49,55 @@ asmlinkage long sparc_memory_ordering(unsigned long model,
 				      struct pt_regs *regs);
 asmlinkage void sparc64_set_context(struct pt_regs *regs);
 asmlinkage void sparc64_get_context(struct pt_regs *regs);
-
+asmlinkage long sys32_truncate64(const char __user * path,
+				 unsigned long high,
+				 unsigned long low);
+asmlinkage long sys32_ftruncate64(unsigned int fd,
+				  unsigned long high,
+				  unsigned long low);
+struct compat_stat64;
+asmlinkage long compat_sys_stat64(const char __user * filename,
+				  struct compat_stat64 __user *statbuf);
+asmlinkage long compat_sys_lstat64(const char __user * filename,
+				   struct compat_stat64 __user *statbuf);
+asmlinkage long compat_sys_fstat64(unsigned int fd,
+				   struct compat_stat64 __user * statbuf);
+asmlinkage long compat_sys_fstatat64(unsigned int dfd,
+				     const char __user *filename,
+				     struct compat_stat64 __user * statbuf, int flag);
+asmlinkage compat_ssize_t sys32_pread64(unsigned int fd,
+					char __user *ubuf,
+					compat_size_t count,
+					unsigned long poshi,
+					unsigned long poslo);
+asmlinkage compat_ssize_t sys32_pwrite64(unsigned int fd,
+					 char __user *ubuf,
+					 compat_size_t count,
+					 unsigned long poshi,
+					 unsigned long poslo);
+asmlinkage long compat_sys_readahead(int fd,
+				     unsigned long offhi,
+				     unsigned long offlo,
+				     compat_size_t count);
+long compat_sys_fadvise64(int fd,
+			  unsigned long offhi,
+			  unsigned long offlo,
+			  compat_size_t len, int advice);
+long compat_sys_fadvise64_64(int fd,
+			     unsigned long offhi, unsigned long offlo,
+			     unsigned long lenhi, unsigned long lenlo,
+			     int advice);
+long sys32_sync_file_range(unsigned int fd,
+			   unsigned long off_high, unsigned long off_low,
+			   unsigned long nb_high, unsigned long nb_low,
+			   unsigned int flags);
+asmlinkage long compat_sys_fallocate(int fd, int mode, u32 offhi, u32 offlo,
+				     u32 lenhi, u32 lenlo);
+asmlinkage long compat_sys_fstat64(unsigned int fd,
+				   struct compat_stat64 __user * statbuf);
+asmlinkage long compat_sys_fstatat64(unsigned int dfd,
+				     const char __user *filename,
+				     struct compat_stat64 __user * statbuf,
+				     int flag);
 #endif /* CONFIG_SPARC64 */
 #endif /* _SYSTBLS_H */
-- 
1.9.0

