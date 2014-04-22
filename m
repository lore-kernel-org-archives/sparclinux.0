From: Eric Paris <eparis@redhat.com>
Date: Tue, 22 Apr 2014 21:40:04 +0000
Subject: [PATCH] sparc: implement is_32bit_task
Message-Id: <1398202804-30164-1-git-send-email-eparis@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We are currently embedding the same check from thread_info.h into
syscall.h thanks to the way syscall_get_arch() was implemented in the
audit tree.  Instead create a new function, is_32bit_task() which is
similar to that found on the powerpc arch.  This simplifies the
syscall.h code and makes the build/Kconfig requirements much easier
to understand.

Signed-off-by: Eric Paris <eparis@redhat.com
Cc: David S. Miller <davem@davemloft.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/syscall.h        | 7 +------
 arch/sparc/include/asm/thread_info_32.h | 2 ++
 arch/sparc/include/asm/thread_info_64.h | 2 ++
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/syscall.h b/arch/sparc/include/asm/syscall.h
index a5a8153..49f71fd 100644
--- a/arch/sparc/include/asm/syscall.h
+++ b/arch/sparc/include/asm/syscall.h
@@ -128,12 +128,7 @@ static inline void syscall_set_arguments(struct task_struct *task,
 
 static inline int syscall_get_arch(void)
 {
-#if defined(__sparc__) && defined(__arch64__)
-	return test_thread_flag(TIF_32BIT) ? AUDIT_ARCH_SPARC
-					   : AUDIT_ARCH_SPARC64;
-#else
-	return AUDIT_ARCH_SPARC;
-#endif
+	return is_32bit_task() ? AUDIT_ARCH_SPARC : AUDIT_ARCH_SPARC64;
 }
 
 #endif /* __ASM_SPARC_SYSCALL_H */
diff --git a/arch/sparc/include/asm/thread_info_32.h b/arch/sparc/include/asm/thread_info_32.h
index 96efa7a..025c984 100644
--- a/arch/sparc/include/asm/thread_info_32.h
+++ b/arch/sparc/include/asm/thread_info_32.h
@@ -130,6 +130,8 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define _TIF_DO_NOTIFY_RESUME_MASK	(_TIF_NOTIFY_RESUME | \
 					 _TIF_SIGPENDING)
 
+#define is_32bit_task()	(1)
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_THREAD_INFO_H */
diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index a5f01ac..5a4f660 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -219,6 +219,8 @@ register struct thread_info *current_thread_info_reg asm("g6");
 				 _TIF_NEED_RESCHED)
 #define _TIF_DO_NOTIFY_RESUME_MASK	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING)
 
+#define is_32bit_task()	(test_thread_flag(TIF_32BIT))
+
 /*
  * Thread-synchronous status.
  *
-- 
1.9.0

