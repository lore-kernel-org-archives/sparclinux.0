From: "Dmitry V. Levin" <ldv@altlinux.org>
Date: Sat, 05 Aug 2017 20:00:50 +0000
Subject: [PATCH] Fix compat_sys_sigpending breakage introduced by v4.13-rc1~6^2~12
Message-Id: <20170805200050.GA24804@altlinux.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Anatoly Pugachev <matorola@gmail.com>, Eugene Syromyatnikov <evgsyr@gmail.com>

The latest change of compat_sys_sigpending has broken it in two ways.

First, it tries to write 4 bytes more than userspace expects:
sizeof(old_sigset_t) = sizeof(long) = 8 instead of
sizeof(compat_old_sigset_t) = sizeof(u32) = 4.

Second, on big endian architectures these bytes are being written
in the wrong order.

This bug was found by strace test suite.

Reported-by: Anatoly Pugachev <matorola@gmail.com>
Inspired-by: Eugene Syromyatnikov <evgsyr@gmail.com>
Fixes: 8f13621abced ("sigpending(): move compat to native")
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 kernel/signal.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index caed913..7e33f8c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3303,12 +3303,15 @@ SYSCALL_DEFINE1(sigpending, old_sigset_t __user *, set)
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE1(sigpending, compat_old_sigset_t __user *, set32)
 {
+#ifdef __BIG_ENDIAN
 	sigset_t set;
-	int err = do_sigpending(&set, sizeof(old_sigset_t)); 
-	if (err = 0)
-		if (copy_to_user(set32, &set, sizeof(old_sigset_t)))
-			err = -EFAULT;
+	int err = do_sigpending(&set, sizeof(set.sig[0]));
+	if (!err)
+		err = put_user(set.sig[0], set32);
 	return err;
+#else
+	return sys_rt_sigpending((sigset_t __user *)set32, sizeof(*set32));
+#endif
 }
 #endif
 
-- 
ldv
