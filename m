From: David Miller <davem@davemloft.net>
Date: Tue, 01 Nov 2011 08:01:20 +0000
Subject: [PATCH] sparc: Hook up process_vm_{readv,writev} syscalls.
Message-Id: <20111101.040120.533550240129920490.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/unistd.h |    4 +++-
 arch/sparc/kernel/systbls_32.S  |    2 +-
 arch/sparc/kernel/systbls_64.S  |    4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index 6260d5d..c7cb0af 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -406,8 +406,10 @@
 #define __NR_syncfs		335
 #define __NR_sendmmsg		336
 #define __NR_setns		337
+#define __NR_process_vm_readv	338
+#define __NR_process_vm_writev	339
 
-#define NR_syscalls		338
+#define NR_syscalls		340
 
 #ifdef __32bit_syscall_numbers__
 /* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
index 09d8ec4..63402f9 100644
--- a/arch/sparc/kernel/systbls_32.S
+++ b/arch/sparc/kernel/systbls_32.S
@@ -84,4 +84,4 @@ sys_call_table:
 /*320*/	.long sys_dup3, sys_pipe2, sys_inotify_init1, sys_accept4, sys_preadv
 /*325*/	.long sys_pwritev, sys_rt_tgsigqueueinfo, sys_perf_event_open, sys_recvmmsg, sys_fanotify_init
 /*330*/	.long sys_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, sys_open_by_handle_at, sys_clock_adjtime
-/*335*/	.long sys_syncfs, sys_sendmmsg, sys_setns
+/*335*/	.long sys_syncfs, sys_sendmmsg, sys_setns, sys_process_vm_readv, sys_process_vm_writev
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index edbec45..db86b1a 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -85,7 +85,7 @@ sys_call_table32:
 /*320*/	.word sys_dup3, sys_pipe2, sys_inotify_init1, sys_accept4, compat_sys_preadv
 	.word compat_sys_pwritev, compat_sys_rt_tgsigqueueinfo, sys_perf_event_open, compat_sys_recvmmsg, sys_fanotify_init
 /*330*/	.word sys32_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, compat_sys_open_by_handle_at, compat_sys_clock_adjtime
-	.word sys_syncfs, compat_sys_sendmmsg, sys_setns
+	.word sys_syncfs, compat_sys_sendmmsg, sys_setns, compat_sys_process_vm_readv, compat_sys_process_vm_writev
 
 #endif /* CONFIG_COMPAT */
 
@@ -162,4 +162,4 @@ sys_call_table:
 /*320*/	.word sys_dup3, sys_pipe2, sys_inotify_init1, sys_accept4, sys_preadv
 	.word sys_pwritev, sys_rt_tgsigqueueinfo, sys_perf_event_open, sys_recvmmsg, sys_fanotify_init
 /*330*/	.word sys_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, sys_open_by_handle_at, sys_clock_adjtime
-	.word sys_syncfs, sys_sendmmsg, sys_setns
+	.word sys_syncfs, sys_sendmmsg, sys_setns, sys_process_vm_readv, sys_process_vm_writev
-- 
1.7.6.401.g6a319

