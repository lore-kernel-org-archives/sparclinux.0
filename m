From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 May 2014 22:52:28 +0000
Subject: [PATCH 23/34] sparc64: clean up compat_sigset_t.seta handling
Message-Id: <1399157559-19901-23-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Use compat_sigset_t rather than opencode the array
Drop "switch (_NSIG_WORDS)" as we know this is always 1
Introduce BUILD_BUG_ON() to catch if this changes

As a side-effect of this fix following sparse warnings:
signal32.c:220:60: warning: invalid access past the end of 'seta' (12 8)
signal32.c:220:42: warning: invalid access past the end of 'seta' (8 8)
signal32.c:219:60: warning: invalid access past the end of 'seta' (20 8)
signal32.c:219:42: warning: invalid access past the end of 'seta' (16 8)
signal32.c:218:60: warning: invalid access past the end of 'seta' (28 8)
signal32.c:218:42: warning: invalid access past the end of 'seta' (24 8)
signal32.c:309:68: warning: invalid access past the end of 'seta' (12 8)
signal32.c:309:46: warning: invalid access past the end of 'seta' (8 8)
signal32.c:308:68: warning: invalid access past the end of 'seta' (20 8)
signal32.c:308:46: warning: invalid access past the end of 'seta' (16 8)
signal32.c:307:68: warning: invalid access past the end of 'seta' (28 8)
signal32.c:307:46: warning: invalid access past the end of 'seta' (24 8)

They all pointed to code that was never executed - so no bugs fixed.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/signal32.c | 55 ++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index ab33c99..62deba7 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -146,7 +146,7 @@ void do_sigreturn32(struct pt_regs *regs)
 	unsigned int psr;
 	unsigned pc, npc;
 	sigset_t set;
-	unsigned seta[_COMPAT_NSIG_WORDS];
+	compat_sigset_t seta;
 	int err, i;
 	
 	/* Always make any pending restarted system calls return -EINTR */
@@ -210,17 +210,13 @@ void do_sigreturn32(struct pt_regs *regs)
 		if (restore_rwin_state(compat_ptr(rwin_save)))
 			goto segv;
 	}
-	err |= __get_user(seta[0], &sf->info.si_mask);
-	err |= copy_from_user(seta+1, &sf->extramask,
+	err |= __get_user(seta.sig[0], &sf->info.si_mask);
+	err |= copy_from_user(&seta.sig[1], &sf->extramask,
 			      (_COMPAT_NSIG_WORDS - 1) * sizeof(unsigned int));
 	if (err)
 	    	goto segv;
-	switch (_NSIG_WORDS) {
-		case 4: set.sig[3] = seta[6] + (((long)seta[7]) << 32);
-		case 3: set.sig[2] = seta[4] + (((long)seta[5]) << 32);
-		case 2: set.sig[1] = seta[2] + (((long)seta[3]) << 32);
-		case 1: set.sig[0] = seta[0] + (((long)seta[1]) << 32);
-	}
+
+	set.sig[0] = seta.sig[0] + (((long)seta.sig[1]) << 32);
 	set_current_blocked(&set);
 	return;
 
@@ -304,12 +300,7 @@ asmlinkage void do_rt_sigreturn32(struct pt_regs *regs)
 			goto segv;
 	}
 
-	switch (_NSIG_WORDS) {
-		case 4: set.sig[3] = seta.sig[6] + (((long)seta.sig[7]) << 32);
-		case 3: set.sig[2] = seta.sig[4] + (((long)seta.sig[5]) << 32);
-		case 2: set.sig[1] = seta.sig[2] + (((long)seta.sig[3]) << 32);
-		case 1: set.sig[0] = seta.sig[0] + (((long)seta.sig[1]) << 32);
-	}
+	set.sig[0] = seta.sig[0] + (((long)seta.sig[1]) << 32);
 	set_current_blocked(&set);
 	return;
 segv:
@@ -418,7 +409,7 @@ static int setup_frame32(struct ksignal *ksig, struct pt_regs *regs,
 	void __user *tail;
 	int sigframe_size;
 	u32 psr;
-	unsigned int seta[_COMPAT_NSIG_WORDS];
+	compat_sigset_t seta;
 
 	/* 1. Make sure everything is clean */
 	synchronize_user_stack();
@@ -482,18 +473,14 @@ static int setup_frame32(struct ksignal *ksig, struct pt_regs *regs,
 		err |= __put_user(0, &sf->rwin_save);
 	}
 
-	switch (_NSIG_WORDS) {
-	case 4: seta[7] = (oldset->sig[3] >> 32);
-	        seta[6] = oldset->sig[3];
-	case 3: seta[5] = (oldset->sig[2] >> 32);
-	        seta[4] = oldset->sig[2];
-	case 2: seta[3] = (oldset->sig[1] >> 32);
-	        seta[2] = oldset->sig[1];
-	case 1: seta[1] = (oldset->sig[0] >> 32);
-	        seta[0] = oldset->sig[0];
-	}
-	err |= __put_user(seta[0], &sf->info.si_mask);
-	err |= __copy_to_user(sf->extramask, seta + 1,
+	/* If these change we need to know - assignments to seta relies on these sizes */
+	BUILD_BUG_ON(_NSIG_WORDS != 1);
+	BUILD_BUG_ON(_COMPAT_NSIG_WORDS != 2);
+	seta.sig[1] = (oldset->sig[0] >> 32);
+	seta.sig[0] = oldset->sig[0];
+
+	err |= __put_user(seta.sig[0], &sf->info.si_mask);
+	err |= __copy_to_user(sf->extramask, &seta.sig[1],
 			      (_COMPAT_NSIG_WORDS - 1) * sizeof(unsigned int));
 
 	if (!wsaved) {
@@ -623,16 +610,8 @@ static int setup_rt_frame32(struct ksignal *ksig, struct pt_regs *regs,
 	/* Setup sigaltstack */
 	err |= __compat_save_altstack(&sf->stack, regs->u_regs[UREG_FP]);
 
-	switch (_NSIG_WORDS) {
-	case 4: seta.sig[7] = (oldset->sig[3] >> 32);
-		seta.sig[6] = oldset->sig[3];
-	case 3: seta.sig[5] = (oldset->sig[2] >> 32);
-		seta.sig[4] = oldset->sig[2];
-	case 2: seta.sig[3] = (oldset->sig[1] >> 32);
-		seta.sig[2] = oldset->sig[1];
-	case 1: seta.sig[1] = (oldset->sig[0] >> 32);
-		seta.sig[0] = oldset->sig[0];
-	}
+	seta.sig[1] = (oldset->sig[0] >> 32);
+	seta.sig[0] = oldset->sig[0];
 	err |= __copy_to_user(&sf->mask, &seta, sizeof(compat_sigset_t));
 
 	if (!wsaved) {
-- 
1.9.0

