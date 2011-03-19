From: David Miller <davem@davemloft.net>
Date: Sat, 19 Mar 2011 04:50:50 +0000
Subject: [PATCH] sparc: Add {open_by,name_to}_handle_at and clock_adjtime
Message-Id: <20110318.215050.173839906.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/unistd.h |    5 ++++-
 arch/sparc/kernel/systbls_32.S  |    2 +-
 arch/sparc/kernel/systbls_64.S  |    4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index 03eb5a8..2f475d7 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -400,8 +400,11 @@
 #define __NR_fanotify_init	329
 #define __NR_fanotify_mark	330
 #define __NR_prlimit64		331
+#define __NR_name_to_handle_at	332
+#define __NR_open_by_handle_at	333
+#define __NR_clock_adjtime	334
 
-#define NR_syscalls		332
+#define NR_syscalls		335
 
 #ifdef __32bit_syscall_numbers__
 /* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
index ec396e1..4b86eaf 100644
--- a/arch/sparc/kernel/systbls_32.S
+++ b/arch/sparc/kernel/systbls_32.S
@@ -83,5 +83,5 @@ sys_call_table:
 /*315*/	.long sys_timerfd_settime, sys_timerfd_gettime, sys_signalfd4, sys_eventfd2, sys_epoll_create1
 /*320*/	.long sys_dup3, sys_pipe2, sys_inotify_init1, sys_accept4, sys_preadv
 /*325*/	.long sys_pwritev, sys_rt_tgsigqueueinfo, sys_perf_event_open, sys_recvmmsg, sys_fanotify_init
-/*330*/	.long sys_fanotify_mark, sys_prlimit64
+/*330*/	.long sys_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, sys_open_by_handle_at, sys_clock_adjtime
 
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index 8cfcaa5..0331baf 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -84,7 +84,7 @@ sys_call_table32:
 	.word compat_sys_timerfd_settime, compat_sys_timerfd_gettime, compat_sys_signalfd4, sys_eventfd2, sys_epoll_create1
 /*320*/	.word sys_dup3, sys_pipe2, sys_inotify_init1, sys_accept4, compat_sys_preadv
 	.word compat_sys_pwritev, compat_sys_rt_tgsigqueueinfo, sys_perf_event_open, compat_sys_recvmmsg, sys_fanotify_init
-/*330*/	.word sys32_fanotify_mark, sys_prlimit64
+/*330*/	.word sys32_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, compat_sys_open_by_handle_at, compat_sys_clock_adjtime
 
 #endif /* CONFIG_COMPAT */
 
@@ -160,4 +160,4 @@ sys_call_table:
 	.word sys_timerfd_settime, sys_timerfd_gettime, sys_signalfd4, sys_eventfd2, sys_epoll_create1
 /*320*/	.word sys_dup3, sys_pipe2, sys_inotify_init1, sys_accept4, sys_preadv
 	.word sys_pwritev, sys_rt_tgsigqueueinfo, sys_perf_event_open, sys_recvmmsg, sys_fanotify_init
-/*330*/	.word sys_fanotify_mark, sys_prlimit64
+/*330*/	.word sys_fanotify_mark, sys_prlimit64, sys_name_to_handle_at, sys_open_by_handle_at, sys_clock_adjtime
-- 
1.7.4.1

