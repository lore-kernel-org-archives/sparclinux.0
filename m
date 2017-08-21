From: "Dmitry V. Levin" <ldv@altlinux.org>
Date: Mon, 21 Aug 2017 23:16:11 +0000
Subject: [PATCH 1/3] signal: replace sigset_to_compat() with put_compat_sigset()
Message-Id: <20170821231611.GA24838@altlinux.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20170805200050.GA24804@altlinux.org>
 <20170806182203.GA12956@ZenIV.linux.org.uk>
 <20170821230933.GA24816@altlinux.org>
In-Reply-To: <20170821230933.GA24816@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

There are 4 callers of sigset_to_compat() in the entire kernel.  One is
in sparc compat rt_sigaction(2), the rest are in kernel/signal.c itself.
All are followed by copy_to_user(), and all but the sparc one are under
"if it's big-endian..." ifdefs.

Let's transform sigset_to_compat() into put_compat_sigset() that also
calls copy_to_user().

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/sparc/kernel/sys_sparc32.c |  6 +++---
 include/linux/compat.h          |  3 ++-
 kernel/compat.c                 | 20 ++++++++++++++------
 kernel/signal.c                 | 27 ++++++---------------------
 4 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc32.c b/arch/sparc/kernel/sys_sparc32.c
index bca44f3..5e2bec9 100644
--- a/arch/sparc/kernel/sys_sparc32.c
+++ b/arch/sparc/kernel/sys_sparc32.c
@@ -159,7 +159,6 @@ COMPAT_SYSCALL_DEFINE5(rt_sigaction, int, sig,
 {
         struct k_sigaction new_ka, old_ka;
         int ret;
-	compat_sigset_t set32;
 
         /* XXX: Don't preclude handling different sized sigset_t's.  */
         if (sigsetsize != sizeof(compat_sigset_t))
@@ -167,6 +166,7 @@ COMPAT_SYSCALL_DEFINE5(rt_sigaction, int, sig,
 
         if (act) {
 		u32 u_handler, u_restorer;
+		compat_sigset_t set32;
 
 		new_ka.ka_restorer = restorer;
 		ret = get_user(u_handler, &act->sa_handler);
@@ -183,9 +183,9 @@ COMPAT_SYSCALL_DEFINE5(rt_sigaction, int, sig,
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
-		sigset_to_compat(&set32, &old_ka.sa.sa_mask);
 		ret = put_user(ptr_to_compat(old_ka.sa.sa_handler), &oact->sa_handler);
-		ret |= copy_to_user(&oact->sa_mask, &set32, sizeof(compat_sigset_t));
+		ret |= put_compat_sigset(&oact->sa_mask, &old_ka.sa.sa_mask,
+					 sizeof(oact->sa_mask));
 		ret |= put_user(old_ka.sa.sa_flags, &oact->sa_flags);
 		ret |= put_user(ptr_to_compat(old_ka.sa.sa_restorer), &oact->sa_restorer);
 		if (ret)
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 5a6a109..17017bb 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -453,7 +453,8 @@ asmlinkage long compat_sys_settimeofday(struct compat_timeval __user *tv,
 asmlinkage long compat_sys_adjtimex(struct compat_timex __user *utp);
 
 extern void sigset_from_compat(sigset_t *set, const compat_sigset_t *compat);
-extern void sigset_to_compat(compat_sigset_t *compat, const sigset_t *set);
+extern int put_compat_sigset(compat_sigset_t __user *compat,
+			     const sigset_t *set, unsigned int size);
 
 asmlinkage long compat_sys_migrate_pages(compat_pid_t pid,
 		compat_ulong_t maxnode, const compat_ulong_t __user *old_nodes,
diff --git a/kernel/compat.c b/kernel/compat.c
index 6f0a0e7..d2bd03b 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -520,15 +520,23 @@ sigset_from_compat(sigset_t *set, const compat_sigset_t *compat)
 }
 EXPORT_SYMBOL_GPL(sigset_from_compat);
 
-void
-sigset_to_compat(compat_sigset_t *compat, const sigset_t *set)
+int
+put_compat_sigset(compat_sigset_t __user *compat, const sigset_t *set,
+		  unsigned int size)
 {
+	/* size <= sizeof(compat_sigset_t) <= sizeof(sigset_t) */
+#ifdef __BIG_ENDIAN
+	compat_sigset_t v;
 	switch (_NSIG_WORDS) {
-	case 4: compat->sig[7] = (set->sig[3] >> 32); compat->sig[6] = set->sig[3];
-	case 3: compat->sig[5] = (set->sig[2] >> 32); compat->sig[4] = set->sig[2];
-	case 2: compat->sig[3] = (set->sig[1] >> 32); compat->sig[2] = set->sig[1];
-	case 1: compat->sig[1] = (set->sig[0] >> 32); compat->sig[0] = set->sig[0];
+	case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
+	case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
+	case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
+	case 1: v.sig[1] = (set->sig[0] >> 32); v.sig[0] = set->sig[0];
 	}
+	return copy_to_user(compat, &v, size) ? -EFAULT : 0;
+#else
+	return copy_to_user(compat, set, size) ? -EFAULT : 0;
+#endif
 }
 
 #ifdef CONFIG_NUMA
diff --git a/kernel/signal.c b/kernel/signal.c
index ed804a4..a1d0426 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2621,13 +2621,7 @@ COMPAT_SYSCALL_DEFINE4(rt_sigprocmask, int, how, compat_sigset_t __user *, nset,
 		if (error)
 			return error;
 	}
-	if (oset) {
-		compat_sigset_t old32;
-		sigset_to_compat(&old32, &old_set);
-		if (copy_to_user(oset, &old32, sizeof(compat_sigset_t)))
-			return -EFAULT;
-	}
-	return 0;
+	return oset ? put_compat_sigset(oset, &old_set, sizeof(*oset)) : 0;
 #else
 	return sys_rt_sigprocmask(how, (sigset_t __user *)nset,
 				  (sigset_t __user *)oset, sigsetsize);
@@ -2669,20 +2663,11 @@ SYSCALL_DEFINE2(rt_sigpending, sigset_t __user *, uset, size_t, sigsetsize)
 COMPAT_SYSCALL_DEFINE2(rt_sigpending, compat_sigset_t __user *, uset,
 		compat_size_t, sigsetsize)
 {
-#ifdef __BIG_ENDIAN
 	sigset_t set;
 	int err = do_sigpending(&set, sigsetsize);
-	if (!err) {
-		compat_sigset_t set32;
-		sigset_to_compat(&set32, &set);
-		/* we can get here only if sigsetsize <= sizeof(set) */
-		if (copy_to_user(uset, &set32, sigsetsize))
-			err = -EFAULT;
-	}
+	if (!err)
+		err = put_compat_sigset(uset, &set, sigsetsize);
 	return err;
-#else
-	return sys_rt_sigpending((sigset_t __user *)uset, sigsetsize);
-#endif
 }
 #endif
 
@@ -3413,7 +3398,6 @@ COMPAT_SYSCALL_DEFINE4(rt_sigaction, int, sig,
 		compat_size_t, sigsetsize)
 {
 	struct k_sigaction new_ka, old_ka;
-	compat_sigset_t mask;
 #ifdef __ARCH_HAS_SA_RESTORER
 	compat_uptr_t restorer;
 #endif
@@ -3425,6 +3409,7 @@ COMPAT_SYSCALL_DEFINE4(rt_sigaction, int, sig,
 
 	if (act) {
 		compat_uptr_t handler;
+		compat_sigset_t mask;
 		ret = get_user(handler, &act->sa_handler);
 		new_ka.sa.sa_handler = compat_ptr(handler);
 #ifdef __ARCH_HAS_SA_RESTORER
@@ -3440,10 +3425,10 @@ COMPAT_SYSCALL_DEFINE4(rt_sigaction, int, sig,
 
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 	if (!ret && oact) {
-		sigset_to_compat(&mask, &old_ka.sa.sa_mask);
 		ret = put_user(ptr_to_compat(old_ka.sa.sa_handler), 
 			       &oact->sa_handler);
-		ret |= copy_to_user(&oact->sa_mask, &mask, sizeof(mask));
+		ret |= put_compat_sigset(&oact->sa_mask, &old_ka.sa.sa_mask,
+					 sizeof(oact->sa_mask));
 		ret |= put_user(old_ka.sa.sa_flags, &oact->sa_flags);
 #ifdef __ARCH_HAS_SA_RESTORER
 		ret |= put_user(ptr_to_compat(old_ka.sa.sa_restorer),

-- 
ldv
