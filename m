From: David Miller <davem@davemloft.net>
Date: Thu, 01 Nov 2018 20:33:15 +0000
Subject: Re: [PATCH v2 3/4] sparc: add system call table generation support
Message-Id: <20181101.133315.47887636039827313.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1541080391-3890-1-git-send-email-firoz.khan@linaro.org>
        <1541080391-3890-4-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1541080391-3890-4-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: firoz.khan@linaro.org
Cc: sparclinux@vger.kernel.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, kstewart@linuxfoundation.org, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org

From: Firoz Khan <firoz.khan@linaro.org>
Date: Thu,  1 Nov 2018 19:23:10 +0530

> +141	common	getpeername		sys_getpeername			sys_nis_syscall
 ...
> +150	common	getsockname		sys_getsockname			sys_nis_syscall

The sys_nis_syscall in these two entries is incorrect, see the patch
below.

One of my worst fears about this change has been realized, that
instead of helping us find problems, it is so automated to the point
that it fails to question issues like this.

If sys_nis_syscall for the compat syscall shows up in a situation where the
native 32-bit syscall does have an entry, that's a BUG and the script should
point this out so that the bug can be fixed.

Thank you.

==========
From 1f2b5b8e2df4591fbca430aff9c5a072dcc0f408 Mon Sep 17 00:00:00 2001
From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 31 Oct 2018 18:30:21 -0700
Subject: [PATCH] sparc64: Wire up compat getpeername and getsockname.

Fixes: 8b30ca73b7cc ("sparc: Add all necessary direct socket system calls.")
Reported-by: Joseph Myers  <joseph@codesourcery.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/systbls_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index bb68c80..ff9389a 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -47,9 +47,9 @@ sys_call_table32:
 	.word sys_recvfrom, sys_setreuid16, sys_setregid16, sys_rename, compat_sys_truncate
 /*130*/	.word compat_sys_ftruncate, sys_flock, compat_sys_lstat64, sys_sendto, sys_shutdown
 	.word sys_socketpair, sys_mkdir, sys_rmdir, compat_sys_utimes, compat_sys_stat64
-/*140*/	.word sys_sendfile64, sys_nis_syscall, compat_sys_futex, sys_gettid, compat_sys_getrlimit
+/*140*/	.word sys_sendfile64, sys_getpeername, compat_sys_futex, sys_gettid, compat_sys_getrlimit
 	.word compat_sys_setrlimit, sys_pivot_root, sys_prctl, sys_pciconfig_read, sys_pciconfig_write
-/*150*/	.word sys_nis_syscall, sys_inotify_init, sys_inotify_add_watch, sys_poll, sys_getdents64
+/*150*/	.word sys_getsockname, sys_inotify_init, sys_inotify_add_watch, sys_poll, sys_getdents64
 	.word compat_sys_fcntl64, sys_inotify_rm_watch, compat_sys_statfs, compat_sys_fstatfs, sys_oldumount
 /*160*/	.word compat_sys_sched_setaffinity, compat_sys_sched_getaffinity, sys_getdomainname, sys_setdomainname, sys_nis_syscall
 	.word sys_quotactl, sys_set_tid_address, compat_sys_mount, compat_sys_ustat, sys_setxattr
-- 
2.1.2.532.g19b5d50
