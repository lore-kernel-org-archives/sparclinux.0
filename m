From: Andreas Larsson <andreas@gaisler.com>
Date: Wed, 09 Nov 2016 09:43:05 +0000
Subject: [PATCH] sparc32: Fix inverted invalid_frame_pointer checks on sigreturns
Message-Id: <1478684585-9993-1-git-send-email-andreas@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, software@gaisler.com

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/kernel/signal_32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index c3c12ef..9c0c8fd 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -89,7 +89,7 @@ asmlinkage void do_sigreturn(struct pt_regs *regs)
 	sf = (struct signal_frame __user *) regs->u_regs[UREG_FP];
 
 	/* 1. Make sure we are not getting garbage from the user */
-	if (!invalid_frame_pointer(sf, sizeof(*sf)))
+	if (invalid_frame_pointer(sf, sizeof(*sf)))
 		goto segv_and_exit;
 
 	if (get_user(ufp, &sf->info.si_regs.u_regs[UREG_FP]))
@@ -150,7 +150,7 @@ asmlinkage void do_rt_sigreturn(struct pt_regs *regs)
 
 	synchronize_user_stack();
 	sf = (struct rt_signal_frame __user *) regs->u_regs[UREG_FP];
-	if (!invalid_frame_pointer(sf, sizeof(*sf)))
+	if (invalid_frame_pointer(sf, sizeof(*sf)))
 		goto segv;
 
 	if (get_user(ufp, &sf->regs.u_regs[UREG_FP]))
-- 
2.8.0

