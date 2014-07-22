From: David Miller <davem@davemloft.net>
Date: Tue, 22 Jul 2014 05:32:22 +0000
Subject: [PATCH] sparc: Hook up renameat2 syscall.
Message-Id: <20140721.223222.2075781288787561030.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/uapi/asm/unistd.h | 3 ++-
 arch/sparc/kernel/sys32.S            | 1 +
 arch/sparc/kernel/systbls_32.S       | 1 +
 arch/sparc/kernel/systbls_64.S       | 2 ++
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index b73274f..42f2bca 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -410,8 +410,9 @@
 #define __NR_finit_module	342
 #define __NR_sched_setattr	343
 #define __NR_sched_getattr	344
+#define __NR_renameat2		345
 
-#define NR_syscalls		345
+#define NR_syscalls		346
 
 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
diff --git a/arch/sparc/kernel/sys32.S b/arch/sparc/kernel/sys32.S
index d066eb1..f834224 100644
--- a/arch/sparc/kernel/sys32.S
+++ b/arch/sparc/kernel/sys32.S
@@ -48,6 +48,7 @@ SIGN1(sys32_futex, compat_sys_futex, %o1)
 SIGN1(sys32_recvfrom, compat_sys_recvfrom, %o0)
 SIGN1(sys32_recvmsg, compat_sys_recvmsg, %o0)
 SIGN1(sys32_sendmsg, compat_sys_sendmsg, %o0)
+SIGN2(sys32_renameat2, sys_renameat2, %o0, %o2)
 
 	.globl		sys32_mmap2
 sys32_mmap2:
diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
index 151ace8..85fe9b1 100644
--- a/arch/sparc/kernel/systbls_32.S
+++ b/arch/sparc/kernel/systbls_32.S
@@ -86,3 +86,4 @@ sys_call_table:
 /*330*/	.long sys_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, sys_open_by_handle_at, sys_clock_adjtime
 /*335*/	.long sys_syncfs, sys_sendmmsg, sys_setns, sys_process_vm_readv, sys_process_vm_writev
 /*340*/	.long sys_ni_syscall, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
+/*345*/	.long sys_renameat2
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index 4bd4e2b..33ecba2 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -87,6 +87,7 @@ sys_call_table32:
 /*330*/	.word compat_sys_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, compat_sys_open_by_handle_at, compat_sys_clock_adjtime
 	.word sys_syncfs, compat_sys_sendmmsg, sys_setns, compat_sys_process_vm_readv, compat_sys_process_vm_writev
 /*340*/	.word sys_kern_features, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
+	.word sys32_renameat2
 
 #endif /* CONFIG_COMPAT */
 
@@ -165,3 +166,4 @@ sys_call_table:
 /*330*/	.word sys_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, sys_open_by_handle_at, sys_clock_adjtime
 	.word sys_syncfs, sys_sendmmsg, sys_setns, sys_process_vm_readv, sys_process_vm_writev
 /*340*/	.word sys_kern_features, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
+	.word sys_renameat2
-- 
1.8.1.2

