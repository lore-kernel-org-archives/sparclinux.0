From: Bob Picco <bpicco@meloft.net>
Date: Thu, 27 Sep 2012 15:36:45 +0000
Subject: [PATCH 2/2] do_rt_sigreturn provide the target sp
Message-Id: <1348760205-26101-3-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

do_sigaltstack expects the stack we are returning to. An issue will manifest
with an alternate stack. That is, a sigaltstack followed by a sigaction
(aka. rt_sigaction) with SA_ONSTACK for flags will sigsegv. do_sigaltstack
returns -EPERM having found on_sig_stack to be true and a sigsegv results.

Let's teach do_rt_sigreturn to provide do_sigaltstack with our target stack.

Signed-off-by: Bob Picco <bpicco@meloft.net>
cc: stable@vger.kernel.org
---
 arch/sparc/kernel/signal_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 1f905f6..f572586 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -295,7 +295,7 @@ void do_rt_sigreturn(struct pt_regs *regs)
 		err |= restore_fpu_state(regs, fpu_save);
 
 	err |= __copy_from_user(&set, &sf->mask, sizeof(sigset_t));
-	err |= do_sigaltstack(&sf->stack, NULL, (unsigned long)sf);
+	err |= do_sigaltstack(&sf->stack, NULL, regs->u_regs[UREG_FP]);
 
 	if (err)
 		goto segv;
-- 
1.7.10

