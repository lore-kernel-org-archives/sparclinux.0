From: "Dmitry V. Levin" <ldv@altlinux.org>
Date: Fri, 13 Apr 2018 14:19:02 +0000
Subject: [PATCH] sparc: fix compat siginfo ABI regression
Message-Id: <20180413141901.GA15253@altlinux.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Anatoly Pugachev <matorola@gmail.com>, sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Starting with commit v4.14-rc1~60^2^2~1, a SIGFPE signal sent via kill
results to wrong values in si_pid and si_uid fields of compat siginfo_t.

This happens due to FPE_FIXME being defined to 0 for sparc, and at the
same time siginfo_layout() introduced by the same commit returns
SIL_FAULT for SIGFPE if si_code = SI_USER and FPE_FIXME is defined to 0.

Fix this regression by removing FPE_FIXME macro and changing all its users
to assign FPE_FLTUNK to si_code instead of FPE_FIXME.

Note that FPE_FLTUNK is a new macro introduced by commit
266da65e9156d93e1126e185259a4aae68188d0e.

Tested with commit v4.16-11958-g16e205cf42da.

This bug was found by strace test suite.

Link: https://github.com/strace/strace/issues/21
Fixes: cc731525f26a ("signal: Remove kernel interal si_code magic")
Thanks-to: Anatoly Pugachev <matorola@gmail.com>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/sparc/include/uapi/asm/siginfo.h | 7 -------
 arch/sparc/kernel/traps_32.c          | 2 +-
 arch/sparc/kernel/traps_64.c          | 2 +-
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/siginfo.h b/arch/sparc/include/uapi/asm/siginfo.h
index 896ce44..e704955 100644
--- a/arch/sparc/include/uapi/asm/siginfo.h
+++ b/arch/sparc/include/uapi/asm/siginfo.h
@@ -18,13 +18,6 @@
 #define SI_NOINFO	32767		/* no information in siginfo_t */
 
 /*
- * SIGFPE si_codes
- */
-#ifdef __KERNEL__
-#define FPE_FIXME	0	/* Broken dup of SI_USER */
-#endif /* __KERNEL__ */
-
-/*
  * SIGEMT si_codes
  */
 #define EMT_TAGOVF	1	/* tag overflow */
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index b1ed763..33cd35b 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -307,7 +307,7 @@ void do_fpe_trap(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 	info.si_errno = 0;
 	info.si_addr = (void __user *)pc;
 	info.si_trapno = 0;
-	info.si_code = FPE_FIXME;
+	info.si_code = FPE_FLTUNK;
 	if ((fsr & 0x1c000) = (1 << 14)) {
 		if (fsr & 0x10)
 			info.si_code = FPE_FLTINV;
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 462a21a..e81072a 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2372,7 +2372,7 @@ static void do_fpe_common(struct pt_regs *regs)
 		info.si_errno = 0;
 		info.si_addr = (void __user *)regs->tpc;
 		info.si_trapno = 0;
-		info.si_code = FPE_FIXME;
+		info.si_code = FPE_FLTUNK;
 		if ((fsr & 0x1c000) = (1 << 14)) {
 			if (fsr & 0x10)
 				info.si_code = FPE_FLTINV;
-- 
ldv
