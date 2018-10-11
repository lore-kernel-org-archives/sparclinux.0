From: David Miller <davem@davemloft.net>
Date: Thu, 11 Oct 2018 04:10:36 +0000
Subject: [PATCH] sparc: Wire up io_pgetevents system call.
Message-Id: <20181010.211036.2130641974267107687.davem@davemloft.net>
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
index 09acf0ddec10..45b4bf1875e6 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -427,8 +427,9 @@
 #define __NR_preadv2		358
 #define __NR_pwritev2		359
 #define __NR_statx		360
+#define __NR_io_pgetevents	361
 
-#define NR_syscalls		361
+#define NR_syscalls		362
 
 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
index 12bee14b552c..621a363098ec 100644
--- a/arch/sparc/kernel/systbls_32.S
+++ b/arch/sparc/kernel/systbls_32.S
@@ -90,4 +90,4 @@ sys_call_table:
 /*345*/	.long sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
 /*350*/	.long sys_execveat, sys_membarrier, sys_userfaultfd, sys_bind, sys_listen
 /*355*/	.long sys_setsockopt, sys_mlock2, sys_copy_file_range, sys_preadv2, sys_pwritev2
-/*360*/	.long sys_statx
+/*360*/	.long sys_statx, sys_io_pgetevents
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index 387ef993880a..bb68c805b891 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -91,7 +91,7 @@ sys_call_table32:
 	.word sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
 /*350*/	.word sys32_execveat, sys_membarrier, sys_userfaultfd, sys_bind, sys_listen
 	.word compat_sys_setsockopt, sys_mlock2, sys_copy_file_range, compat_sys_preadv2, compat_sys_pwritev2
-/*360*/	.word sys_statx
+/*360*/	.word sys_statx, compat_sys_io_pgetevents
 
 #endif /* CONFIG_COMPAT */
 
@@ -173,4 +173,4 @@ sys_call_table:
 	.word sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
 /*350*/	.word sys64_execveat, sys_membarrier, sys_userfaultfd, sys_bind, sys_listen
 	.word sys_setsockopt, sys_mlock2, sys_copy_file_range, sys_preadv2, sys_pwritev2
-/*360*/	.word sys_statx
+/*360*/	.word sys_statx, sys_io_pgetevents
-- 
2.17.1
