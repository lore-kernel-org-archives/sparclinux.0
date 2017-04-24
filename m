From: David Miller <davem@davemloft.net>
Date: Mon, 24 Apr 2017 01:31:33 +0000
Subject: [PATCH] sparc: Update syscall tables.
Message-Id: <20170423.183133.1610924497792806038.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hook up statx.

Ignore pkeys system calls, we don't have protection keeys
on SPARC.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/uapi/asm/unistd.h | 8 +++++++-
 arch/sparc/kernel/systbls_32.S       | 1 +
 arch/sparc/kernel/systbls_64.S       | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index 36eee81..ae77df7 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -425,8 +425,9 @@
 #define __NR_copy_file_range	357
 #define __NR_preadv2		358
 #define __NR_pwritev2		359
+#define __NR_statx		360
 
-#define NR_syscalls		360
+#define NR_syscalls		361
 
 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
@@ -442,4 +443,9 @@
 #define __IGNORE_getresgid
 #endif
 
+/* Sparc doesn't have protection keys. */
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+
 #endif /* _UAPI_SPARC_UNISTD_H */
diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
index eac7f0d..5253e89 100644
--- a/arch/sparc/kernel/systbls_32.S
+++ b/arch/sparc/kernel/systbls_32.S
@@ -89,3 +89,4 @@ sys_call_table:
 /*345*/	.long sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
 /*350*/	.long sys_execveat, sys_membarrier, sys_userfaultfd, sys_bind, sys_listen
 /*355*/	.long sys_setsockopt, sys_mlock2, sys_copy_file_range, sys_preadv2, sys_pwritev2
+/*360*/	.long sys_statx
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index b0f17ff..82339f6 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -90,6 +90,7 @@ sys_call_table32:
 	.word sys32_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
 /*350*/	.word sys32_execveat, sys_membarrier, sys_userfaultfd, sys_bind, sys_listen
 	.word compat_sys_setsockopt, sys_mlock2, sys_copy_file_range, compat_sys_preadv2, compat_sys_pwritev2
+/*360*/	.word sys_statx
 
 #endif /* CONFIG_COMPAT */
 
@@ -171,3 +172,4 @@ sys_call_table:
 	.word sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
 /*350*/	.word sys64_execveat, sys_membarrier, sys_userfaultfd, sys_bind, sys_listen
 	.word sys_setsockopt, sys_mlock2, sys_copy_file_range, sys_preadv2, sys_pwritev2
+/*360*/	.word sys_statx
-- 
2.1.2.532.g19b5d50

