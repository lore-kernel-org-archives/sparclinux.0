From: David Miller <davem@davemloft.net>
Date: Thu, 31 Dec 2015 20:30:31 +0000
Subject: [PATCH] sparc: Wire up mlock2 system call.
Message-Id: <20151231.153031.1204716147186023428.davem@davemloft.net>
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
index 5655912..1c26d44 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -421,8 +421,9 @@
 #define __NR_bind		353
 #define __NR_listen		354
 #define __NR_setsockopt		355
+#define __NR_mlock2		356
 
-#define NR_syscalls		356
+#define NR_syscalls		357
 
 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
index d557a25..e663b6c 100644
--- a/arch/sparc/kernel/systbls_32.S
+++ b/arch/sparc/kernel/systbls_32.S
@@ -88,4 +88,4 @@ sys_call_table:
 /*340*/	.long sys_ni_syscall, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
 /*345*/	.long sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
 /*350*/	.long sys_execveat, sys_membarrier, sys_userfaultfd, sys_bind, sys_listen
-/*355*/	.long sys_setsockopt
+/*355*/	.long sys_setsockopt, sys_mlock2
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index 898684c..1557121 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -89,7 +89,7 @@ sys_call_table32:
 /*340*/	.word sys_kern_features, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
 	.word sys32_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
 /*350*/	.word sys32_execveat, sys_membarrier, sys_userfaultfd, sys_bind, sys_listen
-	.word compat_sys_setsockopt
+	.word compat_sys_setsockopt, sys_mlock2
 
 #endif /* CONFIG_COMPAT */
 
@@ -170,4 +170,4 @@ sys_call_table:
 /*340*/	.word sys_kern_features, sys_kcmp, sys_finit_module, sys_sched_setattr, sys_sched_getattr
 	.word sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
 /*350*/	.word sys64_execveat, sys_membarrier, sys_userfaultfd, sys_bind, sys_listen
-	.word sys_setsockopt
+	.word sys_setsockopt, sys_mlock2
-- 
2.4.1

