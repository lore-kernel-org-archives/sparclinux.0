From: David Miller <davem@davemloft.net>
Date: Mon, 05 May 2008 19:16:07 +0000
Subject: Re: sys32_utimes
Message-Id: <20080505.121607.134874052.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080505113452.GA2138@lst.de>
In-Reply-To: <20080505113452.GA2138@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 5 May 2008 13:34:52 +0200

> shouldn't arch/sparc64/kernel/sys_sparc32.c:sys32_utimes() be removed in
> favour of fs/compat.c:compat_sys_utimes()?  Looks like all other
> architectures are using the latter one.

Yep, fixed as follows:

diff --git a/arch/sparc64/kernel/sys_sparc32.c b/arch/sparc64/kernel/sys_sparc32.c
index 161ce47..1aa4288 100644
--- a/arch/sparc64/kernel/sys_sparc32.c
+++ b/arch/sparc64/kernel/sys_sparc32.c
@@ -236,13 +236,6 @@ asmlinkage long sys32_getegid16(void)
 
 /* 32-bit timeval and related flotsam.  */
 
-static long get_tv32(struct timeval *o, struct compat_timeval __user *i)
-{
-	return (!access_ok(VERIFY_READ, i, sizeof(*i)) ||
-		(__get_user(o->tv_sec, &i->tv_sec) |
-		 __get_user(o->tv_usec, &i->tv_usec)));
-}
-
 static inline long put_tv32(struct compat_timeval __user *o, struct timeval *i)
 {
 	return (!access_ok(VERIFY_WRITE, o, sizeof(*o)) ||
@@ -757,30 +750,6 @@ asmlinkage long sys32_settimeofday(struct compat_timeval __user *tv,
 	return do_sys_settimeofday(tv ? &kts : NULL, tz ? &ktz : NULL);
 }
 
-asmlinkage long sys32_utimes(char __user *filename,
-			     struct compat_timeval __user *tvs)
-{
-	struct timespec tv[2];
-
-	if (tvs) {
-		struct timeval ktvs[2];
-		if (get_tv32(&ktvs[0], tvs) ||
-		    get_tv32(&ktvs[1], 1+tvs))
-			return -EFAULT;
-
-		if (ktvs[0].tv_usec < 0 || ktvs[0].tv_usec >= 1000000 ||
-		    ktvs[1].tv_usec < 0 || ktvs[1].tv_usec >= 1000000)
-			return -EINVAL;
-
-		tv[0].tv_sec = ktvs[0].tv_sec;
-		tv[0].tv_nsec = 1000 * ktvs[0].tv_usec;
-		tv[1].tv_sec = ktvs[1].tv_sec;
-		tv[1].tv_nsec = 1000 * ktvs[1].tv_usec;
-	}
-
-	return do_utimes(AT_FDCWD, filename, tvs ? tv : NULL, 0);
-}
-
 /* These are here just in case some old sparc32 binary calls it. */
 asmlinkage long sys32_pause(void)
 {
diff --git a/arch/sparc64/kernel/systbls.S b/arch/sparc64/kernel/systbls.S
index a4fef2b..8b5282d 100644
--- a/arch/sparc64/kernel/systbls.S
+++ b/arch/sparc64/kernel/systbls.S
@@ -45,7 +45,7 @@ sys_call_table32:
 /*120*/	.word compat_sys_readv, compat_sys_writev, sys32_settimeofday, sys32_fchown16, sys_fchmod
 	.word sys_nis_syscall, sys32_setreuid16, sys32_setregid16, sys_rename, sys_truncate
 /*130*/	.word sys_ftruncate, sys_flock, compat_sys_lstat64, sys_nis_syscall, sys_nis_syscall
-	.word sys_nis_syscall, sys32_mkdir, sys_rmdir, sys32_utimes, compat_sys_stat64
+	.word sys_nis_syscall, sys32_mkdir, sys_rmdir, compat_sys_utimes, compat_sys_stat64
 /*140*/	.word sys32_sendfile64, sys_nis_syscall, sys32_futex, sys_gettid, compat_sys_getrlimit
 	.word compat_sys_setrlimit, sys_pivot_root, sys32_prctl, sys_pciconfig_read, sys_pciconfig_write
 /*150*/	.word sys_nis_syscall, sys_inotify_init, sys_inotify_add_watch, sys_poll, sys_getdents64
