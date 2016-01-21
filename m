From: David Miller <davem@davemloft.net>
Date: Thu, 21 Jan 2016 23:58:05 +0000
Subject: [PATCH] sparc: Hook up copy_file_range syscall.
Message-Id: <20160121.155805.1330211258083641331.davem@davemloft.net>
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
index 1c26d44..b6de8b1 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -422,8 +422,9 @@
 #define __NR_listen		354
 #define __NR_setsockopt		355
 #define __NR_mlock2		356
+#define __NR_copy_file_range	357
 
-#define NR_syscalls		357
+#define NR_syscalls		358
 
 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
index e663b6c..6c3dd6c 100644
--- a/arch/sparc/kernel/systbls_32.S
+++ b/arch/sparc/kernel/systbls_32.S
@@ -88,4 +88,4 @@ sys_call_table:
 /*340*/	.long sys_ni_syscall, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
 /*345*/	.long sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
 /*350*/	.long sys_execveat, sys_membarrier, sys_userfaultfd, sys_bind, sys_listen
-/*355*/	.long sys_setsockopt, sys_mlock2
+/*355*/	.long sys_setsockopt, sys_mlock2, sys_copy_file_range
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index 1557121..12b524c 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -89,7 +89,7 @@ sys_call_table32:
 /*340*/	.word sys_kern_features, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
 	.word sys32_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
 /*350*/	.word sys32_execveat, sys_membarrier, sys_userfaultfd, sys_bind, sys_listen
-	.word compat_sys_setsockopt, sys_mlock2
+	.word compat_sys_setsockopt, sys_mlock2, sys_copy_file_range
 
 #endif /* CONFIG_COMPAT */
 
@@ -170,4 +170,4 @@ sys_call_table:
 /*340*/	.word sys_kern_features, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
 	.word sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
 /*350*/	.word sys64_execveat, sys_membarrier, sys_userfaultfd, sys_bind, sys_listen
-	.word sys_setsockopt, sys_mlock2
+	.word sys_setsockopt, sys_mlock2, sys_copy_file_range
-- 
2.1.2.532.g19b5d50

