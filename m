From: Adrian Bunk <bunk@kernel.org>
Date: Wed, 23 Apr 2008 09:51:48 +0000
Subject: [2.6 patch] sparc: cleanup after SunOS binary emulation removal
Message-Id: <20080423095148.GC28933@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wli@holomorphy.com, "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

The following cleanups are now possible:
- arch/sparc/kernel/entry.S:ret_sys_call no longer has to be global
- arch/sparc/kernel/signal.c:sys_sigpause() can be removed

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 arch/sparc/kernel/entry.S  |    1 -
 arch/sparc/kernel/signal.c |    5 -----
 2 files changed, 6 deletions(-)

7548ea102f0db3c04f47a3c60242327b02916a5a diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 135644f..484c83d 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -1409,7 +1409,6 @@ syscall_is_too_hard:
 
 	st	%o0, [%sp + STACKFRAME_SZ + PT_I0]
 
-	.globl	ret_sys_call
 ret_sys_call:
 	ld	[%curptr + TI_FLAGS], %l6
 	cmp	%o0, -ERESTART_RESTARTBLOCK
diff --git a/arch/sparc/kernel/signal.c b/arch/sparc/kernel/signal.c
index 1f73061..3e849e8 100644
--- a/arch/sparc/kernel/signal.c
+++ b/arch/sparc/kernel/signal.c
@@ -105,11 +105,6 @@ static int _sigpause_common(old_sigset_t set)
 	return -ERESTARTNOHAND;
 }
 
-asmlinkage int sys_sigpause(unsigned int set)
-{
-	return _sigpause_common(set);
-}
-
 asmlinkage int sys_sigsuspend(old_sigset_t set)
 {
 	return _sigpause_common(set);

