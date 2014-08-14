From: David Miller <davem@davemloft.net>
Date: Thu, 14 Aug 2014 05:00:48 +0000
Subject: [PATCH] sparc: Hook up memfd_create system call.
Message-Id: <20140813.220048.1831413518107480086.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/uapi/asm/unistd.h | 3 ++-
 arch/sparc/kernel/systbls_32.S       | 2 +-
 arch/sparc/kernel/systbls_64.S       | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index 886cab4..c842a89 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -413,8 +413,9 @@
 #define __NR_renameat2		345
 #define __NR_seccomp		346
 #define __NR_getrandom		347
+#define __NR_memfd_create	348
 
-#define NR_syscalls		348
+#define NR_syscalls		349
 
 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
index 217893e..6a873c3 100644
--- a/arch/sparc/kernel/systbls_32.S
+++ b/arch/sparc/kernel/systbls_32.S
@@ -86,4 +86,4 @@ sys_call_table:
 /*330*/	.long sys_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, sys_open_by_handle_at, sys_clock_adjtime
 /*335*/	.long sys_syncfs, sys_sendmmsg, sys_setns, sys_process_vm_readv, sys_process_vm_writev
 /*340*/	.long sys_ni_syscall, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
-/*345*/	.long sys_renameat2, sys_seccomp, sys_getrandom
+/*345*/	.long sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index d93b49d..d9151b6 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -87,7 +87,7 @@ sys_call_table32:
 /*330*/	.word compat_sys_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, compat_sys_open_by_handle_at, compat_sys_clock_adjtime
 	.word sys_syncfs, compat_sys_sendmmsg, sys_setns, compat_sys_process_vm_readv, compat_sys_process_vm_writev
 /*340*/	.word sys_kern_features, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
-	.word sys32_renameat2, sys_seccomp, sys_getrandom
+	.word sys32_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create
 
 #endif /* CONFIG_COMPAT */
 
@@ -166,4 +166,4 @@ sys_call_table:
 /*330*/	.word sys_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, sys_open_by_handle_at, sys_clock_adjtime
 	.word sys_syncfs, sys_sendmmsg, sys_setns, sys_process_vm_readv, sys_process_vm_writev
 /*340*/	.word sys_kern_features, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
-	.word sys_renameat2, sys_seccomp, sys_getrandom
+	.word sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create
-- 
1.8.1.2

