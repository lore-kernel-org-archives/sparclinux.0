From: David Miller <davem@davemloft.net>
Date: Fri, 18 Dec 2015 03:47:53 +0000
Subject: [PATCH] sparc: Add all necessary direct socket system calls.
Message-Id: <20151217.224753.1441573007785005706.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The GLIBC folks would like to eliminate socketcall support
eventually, and this makes sense regardless so wire them
all up.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/uapi/asm/unistd.h |  5 ++++-
 arch/sparc/kernel/systbls_32.S       | 18 +++++++++---------
 arch/sparc/kernel/systbls_64.S       | 16 ++++++++--------
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index efe9479..a4f46f8 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -417,8 +417,11 @@
 #define __NR_bpf		349
 #define __NR_execveat		350
 #define __NR_membarrier		351
+#deifne __NR_bind		352
+#deifne __NR_listen		353
+#deifne __NR_setsockopt		354
 
-#define NR_syscalls		352
+#define NR_syscalls		355
 
 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
index cc23b62..5157f8a 100644
--- a/arch/sparc/kernel/systbls_32.S
+++ b/arch/sparc/kernel/systbls_32.S
@@ -35,18 +35,18 @@ sys_call_table:
 /*80*/	.long sys_setgroups16, sys_getpgrp, sys_setgroups, sys_setitimer, sys_ftruncate64
 /*85*/	.long sys_swapon, sys_getitimer, sys_setuid, sys_sethostname, sys_setgid
 /*90*/	.long sys_dup2, sys_setfsuid, sys_fcntl, sys_select, sys_setfsgid
-/*95*/	.long sys_fsync, sys_setpriority, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall
+/*95*/	.long sys_fsync, sys_setpriority, sys_socket, sys_connect, sys_accept
 /*100*/	.long sys_getpriority, sys_rt_sigreturn, sys_rt_sigaction, sys_rt_sigprocmask, sys_rt_sigpending
 /*105*/	.long sys_rt_sigtimedwait, sys_rt_sigqueueinfo, sys_rt_sigsuspend, sys_setresuid, sys_getresuid
-/*110*/	.long sys_setresgid, sys_getresgid, sys_setregid, sys_nis_syscall, sys_nis_syscall
-/*115*/	.long sys_getgroups, sys_gettimeofday, sys_getrusage, sys_nis_syscall, sys_getcwd
+/*110*/	.long sys_setresgid, sys_getresgid, sys_setregid, sys_recvmsg, sys_sendmsg
+/*115*/	.long sys_getgroups, sys_gettimeofday, sys_getrusage, sys_getsockopt, sys_getcwd
 /*120*/	.long sys_readv, sys_writev, sys_settimeofday, sys_fchown16, sys_fchmod
-/*125*/	.long sys_nis_syscall, sys_setreuid16, sys_setregid16, sys_rename, sys_truncate
-/*130*/	.long sys_ftruncate, sys_flock, sys_lstat64, sys_nis_syscall, sys_nis_syscall
-/*135*/	.long sys_nis_syscall, sys_mkdir, sys_rmdir, sys_utimes, sys_stat64
-/*140*/	.long sys_sendfile64, sys_nis_syscall, sys_futex, sys_gettid, sys_getrlimit
+/*125*/	.long sys_recvfrom, sys_setreuid16, sys_setregid16, sys_rename, sys_truncate
+/*130*/	.long sys_ftruncate, sys_flock, sys_lstat64, sys_sendto, sys_shutdown
+/*135*/	.long sys_socketpair, sys_mkdir, sys_rmdir, sys_utimes, sys_stat64
+/*140*/	.long sys_sendfile64, sys_getpeername, sys_futex, sys_gettid, sys_getrlimit
 /*145*/	.long sys_setrlimit, sys_pivot_root, sys_prctl, sys_pciconfig_read, sys_pciconfig_write
-/*150*/	.long sys_nis_syscall, sys_inotify_init, sys_inotify_add_watch, sys_poll, sys_getdents64
+/*150*/	.long sys_getsockname, sys_inotify_init, sys_inotify_add_watch, sys_poll, sys_getdents64
 /*155*/	.long sys_fcntl64, sys_inotify_rm_watch, sys_statfs, sys_fstatfs, sys_oldumount
 /*160*/	.long sys_sched_setaffinity, sys_sched_getaffinity, sys_getdomainname, sys_setdomainname, sys_nis_syscall
 /*165*/	.long sys_quotactl, sys_set_tid_address, sys_mount, sys_ustat, sys_setxattr
@@ -87,4 +87,4 @@ sys_call_table:
 /*335*/	.long sys_syncfs, sys_sendmmsg, sys_setns, sys_process_vm_readv, sys_process_vm_writev
 /*340*/	.long sys_ni_syscall, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
 /*345*/	.long sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
-/*350*/	.long sys_execveat, sys_membarrier
+/*350*/	.long sys_execveat, sys_membarrier, sys_bind, sys_listen, sys_setsockopt
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index f229468..6a9a77d 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -37,15 +37,15 @@ sys_call_table32:
 /*80*/	.word sys_setgroups16, sys_getpgrp, sys_setgroups, compat_sys_setitimer, sys32_ftruncate64
 	.word sys_swapon, compat_sys_getitimer, sys_setuid, sys_sethostname, sys_setgid
 /*90*/	.word sys_dup2, sys_setfsuid, compat_sys_fcntl, sys32_select, sys_setfsgid
-	.word sys_fsync, sys_setpriority, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall
+	.word sys_fsync, sys_setpriority, sys_socket, sys_connect, sys_accept
 /*100*/ .word sys_getpriority, sys32_rt_sigreturn, compat_sys_rt_sigaction, compat_sys_rt_sigprocmask, compat_sys_rt_sigpending
 	.word compat_sys_rt_sigtimedwait, compat_sys_rt_sigqueueinfo, compat_sys_rt_sigsuspend, sys_setresuid, sys_getresuid
-/*110*/	.word sys_setresgid, sys_getresgid, sys_setregid, sys_nis_syscall, sys_nis_syscall
-	.word sys_getgroups, compat_sys_gettimeofday, compat_sys_getrusage, sys_nis_syscall, sys_getcwd
+/*110*/	.word sys_setresgid, sys_getresgid, sys_setregid, compat_sys_recvmsg, compat_sys_sendmsg
+	.word sys_getgroups, compat_sys_gettimeofday, compat_sys_getrusage, compat_sys_getsockopt, sys_getcwd
 /*120*/	.word compat_sys_readv, compat_sys_writev, compat_sys_settimeofday, sys_fchown16, sys_fchmod
-	.word sys_nis_syscall, sys_setreuid16, sys_setregid16, sys_rename, compat_sys_truncate
-/*130*/	.word compat_sys_ftruncate, sys_flock, compat_sys_lstat64, sys_nis_syscall, sys_nis_syscall
-	.word sys_nis_syscall, sys_mkdir, sys_rmdir, compat_sys_utimes, compat_sys_stat64
+	.word sys_recvfrom, sys_setreuid16, sys_setregid16, sys_rename, compat_sys_truncate
+/*130*/	.word compat_sys_ftruncate, sys_flock, compat_sys_lstat64, sys_sendto, sys_shutdown
+	.word sys_socketpair, sys_mkdir, sys_rmdir, compat_sys_utimes, compat_sys_stat64
 /*140*/	.word sys_sendfile64, sys_nis_syscall, sys32_futex, sys_gettid, compat_sys_getrlimit
 	.word compat_sys_setrlimit, sys_pivot_root, sys_prctl, sys_pciconfig_read, sys_pciconfig_write
 /*150*/	.word sys_nis_syscall, sys_inotify_init, sys_inotify_add_watch, sys_poll, sys_getdents64
@@ -88,7 +88,7 @@ sys_call_table32:
 	.word sys_syncfs, compat_sys_sendmmsg, sys_setns, compat_sys_process_vm_readv, compat_sys_process_vm_writev
 /*340*/	.word sys_kern_features, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
 	.word sys32_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
-/*350*/	.word sys32_execveat, sys_membarrier
+/*350*/	.word sys32_execveat, sys_membarrier, sys_bind, sys_listen, compat_sys_setsockopt
 
 #endif /* CONFIG_COMPAT */
 
@@ -168,4 +168,4 @@ sys_call_table:
 	.word sys_syncfs, sys_sendmmsg, sys_setns, sys_process_vm_readv, sys_process_vm_writev
 /*340*/	.word sys_kern_features, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
 	.word sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
-/*350*/	.word sys64_execveat, sys_membarrier
+/*350*/	.word sys64_execveat, sys_membarrier, sys_bind, sys_listen, sys_setsockopt
-- 
2.1.0

