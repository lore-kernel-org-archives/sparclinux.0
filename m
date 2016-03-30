From: David Miller <davem@davemloft.net>
Date: Wed, 30 Mar 2016 01:55:03 +0000
Subject: [PATCH] sparc: Write up preadv2/pwritev2 syscalls.
Message-Id: <20160329.215503.448320989860823119.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/uapi/asm/unistd.h | 4 +++-
 arch/sparc/kernel/systbls_32.S       | 2 +-
 arch/sparc/kernel/systbls_64.S       | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index b6de8b1..36eee81 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -423,8 +423,10 @@
 #define __NR_setsockopt		355
 #define __NR_mlock2		356
 #define __NR_copy_file_range	357
+#define __NR_preadv2		358
+#define __NR_pwritev2		359
 
-#define NR_syscalls		358
+#define NR_syscalls		360
 
 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
index 6c3dd6c..eac7f0d 100644
--- a/arch/sparc/kernel/systbls_32.S
+++ b/arch/sparc/kernel/systbls_32.S
@@ -88,4 +88,4 @@ sys_call_table:
 /*340*/	.long sys_ni_syscall, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
 /*345*/	.long sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
 /*350*/	.long sys_execveat, sys_membarrier, sys_userfaultfd, sys_bind, sys_listen
-/*355*/	.long sys_setsockopt, sys_mlock2, sys_copy_file_range
+/*355*/	.long sys_setsockopt, sys_mlock2, sys_copy_file_range, sys_preadv2, sys_pwritev2
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index 12b524c..b0f17ff 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -89,7 +89,7 @@ sys_call_table32:
 /*340*/	.word sys_kern_features, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
 	.word sys32_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
 /*350*/	.word sys32_execveat, sys_membarrier, sys_userfaultfd, sys_bind, sys_listen
-	.word compat_sys_setsockopt, sys_mlock2, sys_copy_file_range
+	.word compat_sys_setsockopt, sys_mlock2, sys_copy_file_range, compat_sys_preadv2, compat_sys_pwritev2
 
 #endif /* CONFIG_COMPAT */
 
@@ -170,4 +170,4 @@ sys_call_table:
 /*340*/	.word sys_kern_features, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
 	.word sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
 /*350*/	.word sys64_execveat, sys_membarrier, sys_userfaultfd, sys_bind, sys_listen
-	.word sys_setsockopt, sys_mlock2, sys_copy_file_range
+	.word sys_setsockopt, sys_mlock2, sys_copy_file_range, sys_preadv2, sys_pwritev2
-- 
2.1.0

