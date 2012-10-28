From: David Miller <davem@davemloft.net>
Date: Sun, 28 Oct 2012 20:26:15 +0000
Subject: [PATCH] sparc: Wire up sys_kcmp.
Message-Id: <20121028.162615.1566126848889686635.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/uapi/asm/unistd.h | 3 ++-
 arch/sparc/kernel/systbls_32.S       | 1 +
 arch/sparc/kernel/systbls_64.S       | 4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index bed86a8..cac719d 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -406,8 +406,9 @@
 #define __NR_process_vm_readv	338
 #define __NR_process_vm_writev	339
 #define __NR_kern_features	340
+#define __NR_kcmp		341
 
-#define NR_syscalls		341
+#define NR_syscalls		342
 
 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
index 63402f9..5147f57 100644
--- a/arch/sparc/kernel/systbls_32.S
+++ b/arch/sparc/kernel/systbls_32.S
@@ -85,3 +85,4 @@ sys_call_table:
 /*325*/	.long sys_pwritev, sys_rt_tgsigqueueinfo, sys_perf_event_open, sys_recvmmsg, sys_fanotify_init
 /*330*/	.long sys_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, sys_open_by_handle_at, sys_clock_adjtime
 /*335*/	.long sys_syncfs, sys_sendmmsg, sys_setns, sys_process_vm_readv, sys_process_vm_writev
+/*340*/	.long sys_ni_syscall, sys_kcmp
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index 45ce6be..1c9af9f 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -86,7 +86,7 @@ sys_call_table32:
 	.word compat_sys_pwritev, compat_sys_rt_tgsigqueueinfo, sys_perf_event_open, compat_sys_recvmmsg, sys_fanotify_init
 /*330*/	.word sys32_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, compat_sys_open_by_handle_at, compat_sys_clock_adjtime
 	.word sys_syncfs, compat_sys_sendmmsg, sys_setns, compat_sys_process_vm_readv, compat_sys_process_vm_writev
-/*340*/	.word sys_kern_features
+/*340*/	.word sys_kern_features, sys_kcmp
 
 #endif /* CONFIG_COMPAT */
 
@@ -164,4 +164,4 @@ sys_call_table:
 	.word sys_pwritev, sys_rt_tgsigqueueinfo, sys_perf_event_open, sys_recvmmsg, sys_fanotify_init
 /*330*/	.word sys_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, sys_open_by_handle_at, sys_clock_adjtime
 	.word sys_syncfs, sys_sendmmsg, sys_setns, sys_process_vm_readv, sys_process_vm_writev
-/*340*/	.word sys_kern_features
+/*340*/	.word sys_kern_features, sys_kcmp
-- 
1.7.12.2.dirty

