From: Jason Wessel <jason.wessel@windriver.com>
Date: Tue, 19 Jul 2011 20:58:32 +0000
Subject: [PATCH] sparc,kgdbts: fix compile regression with kgdb test suite
Message-Id: <1311109112-12909-1-git-send-email-jason.wessel@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, vapier@gentoo.org

Commit 63ab25ebbc (kgdbts: unify/generalize gdb breakpoint adjustment)
introduced a compile regression on sparc.

kgdbts.c: In function 'check_and_rewind_pc':
kgdbts.c:307: error: implicit declaration of function 'instruction_pointer_set'

Simply add the correct macro definition for instruction pointer on the
Sparc architecture.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 arch/sparc/include/asm/ptrace.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/ptrace.h b/arch/sparc/include/asm/ptrace.h
index c7ad3fe..b928b31 100644
--- a/arch/sparc/include/asm/ptrace.h
+++ b/arch/sparc/include/asm/ptrace.h
@@ -205,6 +205,7 @@ do {	current_thread_info()->syscall_noerror = 1; \
 } while (0)
 #define user_mode(regs) (!((regs)->tstate & TSTATE_PRIV))
 #define instruction_pointer(regs) ((regs)->tpc)
+#define instruction_pointer_set(regs, val) ((regs)->tpc = (val))
 #define user_stack_pointer(regs) ((regs)->u_regs[UREG_FP])
 #define regs_return_value(regs) ((regs)->u_regs[UREG_I0])
 #ifdef CONFIG_SMP
-- 
1.7.1

