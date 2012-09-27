From: Bob Picco <bpicco@meloft.net>
Date: Thu, 27 Sep 2012 15:36:44 +0000
Subject: [PATCH 1/2] sparc do_rt_sigreturn - minor clean up
Message-Id: <1348760205-26101-2-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

This is just an elimination of whitespace.

Signed-off-by: Bob Picco <bpicco@meloft.net>
---
 arch/sparc/kernel/signal_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 867de2f..1f905f6 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -267,7 +267,7 @@ void do_rt_sigreturn(struct pt_regs *regs)
 
 	synchronize_user_stack ();
 	sf = (struct rt_signal_frame __user *)
-		(regs->u_regs [UREG_FP] + STACK_BIAS);
+		(regs->u_regs[UREG_FP] + STACK_BIAS);
 
 	/* 1. Make sure we are not getting garbage from the user */
 	if (((unsigned long) sf) & 3)
-- 
1.7.10

