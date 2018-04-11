From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 11 Apr 2018 15:07:58 +0000
Subject: [PATCH] sparc: compat: allow including asm/compat.h for 32-bit
Message-Id: <20180411150829.3881900-1-arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Deepa Dinamani <deepa.kernel@gmail.com>
Cc: y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

We have several files on sparc that include linux/compat.h and expect
asm/compat.h not to be included, otherwise we get a build failure.

Since we need to include asm/compat.h for compat time_t handling
on all 32-bit architectures now, this hides some portions of
asm/compat.h in order to let the rest of the file get included.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/include/asm/compat.h | 4 ++++
 1 file changed, 4 insertions(+)

This is the fix for the y2038 syscall series that missed the 4.17 merge
window. I've now spent two more days doing extra build testing on all
64-bit archtectures building with and without CONFIG_COMPAT, as well
as without CONFIG_64BIT. I did not run into any additional build failures
after this patch, so my plan is to pick that up into my y2038 tree after
-rc1 and send Thomas a pull request a few days later for inclusion
in linux-4.18.

diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 161aeacbc9ad..4eb51d2dae98 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -157,6 +157,7 @@ static inline compat_uptr_t ptr_to_compat(void __user *uptr)
 	return (u32)(unsigned long)uptr;
 }
 
+#ifdef CONFIG_COMPAT
 static inline void __user *arch_compat_alloc_user_space(long len)
 {
 	struct pt_regs *regs = current_thread_info()->kregs;
@@ -173,6 +174,7 @@ static inline void __user *arch_compat_alloc_user_space(long len)
 
 	return (void __user *) usp;
 }
+#endif
 
 struct compat_ipc64_perm {
 	compat_key_t key;
@@ -232,6 +234,7 @@ struct compat_shmid64_ds {
 	unsigned int	__unused2;
 };
 
+#ifdef CONFIG_COMPAT
 static inline int is_compat_task(void)
 {
 	return test_thread_flag(TIF_32BIT);
@@ -243,5 +246,6 @@ static inline bool in_compat_syscall(void)
 	return pt_regs_trap_type(current_pt_regs()) = 0x110;
 }
 #define in_compat_syscall in_compat_syscall
+#endif
 
 #endif /* _ASM_SPARC64_COMPAT_H */
-- 
2.9.0

