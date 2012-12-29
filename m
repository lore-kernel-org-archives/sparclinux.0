From: David Miller <davem@davemloft.net>
Date: Sat, 29 Dec 2012 06:39:26 +0000
Subject: [PATCH] sparc: Hook up finit_module syscall.
Message-Id: <20121228.223926.27304080587848765.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/uapi/asm/unistd.h |    3 ++-
 arch/sparc/kernel/systbls_32.S       |    2 +-
 arch/sparc/kernel/systbls_64.S       |    4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index cac719d..62ced58 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -407,8 +407,9 @@
 #define __NR_process_vm_writev	339
 #define __NR_kern_features	340
 #define __NR_kcmp		341
+#define __NR_finit_module	342
 
-#define NR_syscalls		342
+#define NR_syscalls		343
 
 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
index 5147f57..6ac43c3 100644
--- a/arch/sparc/kernel/systbls_32.S
+++ b/arch/sparc/kernel/systbls_32.S
@@ -85,4 +85,4 @@ sys_call_table:
 /*325*/	.long sys_pwritev, sys_rt_tgsigqueueinfo, sys_perf_event_open, sys_recvmmsg, sys_fanotify_init
 /*330*/	.long sys_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, sys_open_by_handle_at, sys_clock_adjtime
 /*335*/	.long sys_syncfs, sys_sendmmsg, sys_setns, sys_process_vm_readv, sys_process_vm_writev
-/*340*/	.long sys_ni_syscall, sys_kcmp
+/*340*/	.long sys_ni_syscall, sys_kcmp, sys_finit_module
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index cdbd9b8..1009ecb 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -86,7 +86,7 @@ sys_call_table32:
 	.word compat_sys_pwritev, compat_sys_rt_tgsigqueueinfo, sys_perf_event_open, compat_sys_recvmmsg, sys_fanotify_init
 /*330*/	.word sys32_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, compat_sys_open_by_handle_at, compat_sys_clock_adjtime
 	.word sys_syncfs, compat_sys_sendmmsg, sys_setns, compat_sys_process_vm_readv, compat_sys_process_vm_writev
-/*340*/	.word sys_kern_features, sys_kcmp
+/*340*/	.word sys_kern_features, sys_kcmp, sys_finit_module
 
 #endif /* CONFIG_COMPAT */
 
@@ -164,4 +164,4 @@ sys_call_table:
 	.word sys_pwritev, sys_rt_tgsigqueueinfo, sys_perf_event_open, sys_recvmmsg, sys_fanotify_init
 /*330*/	.word sys_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, sys_open_by_handle_at, sys_clock_adjtime
 	.word sys_syncfs, sys_sendmmsg, sys_setns, sys_process_vm_readv, sys_process_vm_writev
-/*340*/	.word sys_kern_features, sys_kcmp
+/*340*/	.word sys_kern_features, sys_kcmp, sys_finit_module
-- 
1.7.10.4

