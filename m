From: Amanieu d'Antras <amanieu@gmail.com>
Date: Thu, 05 Nov 2015 00:50:36 +0000
Subject: [PATCH v2 17/20] sparc: Use generic compat_siginfo_t
Message-Id: <1446684640-4112-18-git-send-email-amanieu@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
In-Reply-To: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amanieu d'Antras <amanieu@gmail.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
---
 arch/sparc/include/asm/compat.h | 54 -----------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 9357014..8f85fcd 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -153,62 +153,8 @@ typedef union compat_sigval {
 	compat_uptr_t	sival_ptr;
 } compat_sigval_t;
 
-#define HAVE_ARCH_COMPAT_SIGINFO_T
 #define HAVE_ARCH_COPY_SIGINFO_TO_USER32
 #define HAVE_ARCH_COPY_SIGINFO_FROM_USER32
-#define SI_PAD_SIZE32	(128/sizeof(int) - 3)
-
-typedef struct compat_siginfo {
-	int si_signo;
-	int si_errno;
-	int si_code;
-
-	union {
-		int _pad[SI_PAD_SIZE32];
-
-		/* kill() */
-		struct {
-			compat_pid_t _pid;		/* sender's pid */
-			unsigned int _uid;		/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			compat_timer_t _tid;		/* timer id */
-			int _overrun;			/* overrun count */
-			compat_sigval_t _sigval;	/* same as below */
-			int _sys_private;	/* not to be passed to user */
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			compat_pid_t _pid;		/* sender's pid */
-			unsigned int _uid;		/* sender's uid */
-			compat_sigval_t _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			compat_pid_t _pid;		/* which child */
-			unsigned int _uid;		/* sender's uid */
-			int _status;			/* exit code */
-			compat_clock_t _utime;
-			compat_clock_t _stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGEMT */
-		struct {
-			u32 _addr; /* faulting insn/memory ref. */
-			int _trapno;
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			int _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
-	} _sifields;
-} compat_siginfo_t;
 
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
-- 
2.6.2

