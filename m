From: David Miller <davem@davemloft.net>
Date: Wed, 21 Apr 2010 10:23:52 +0000
Subject: [PATCH 1/2] sparc64: Show stack backtrace from show_regs() just
Message-Id: <20100421.032352.82045316.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/process_64.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index a5cf386..dbe81a3 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -202,6 +202,7 @@ void show_regs(struct pt_regs *regs)
 	       regs->u_regs[15]);
 	printk("RPC: <%pS>\n", (void *) regs->u_regs[15]);
 	show_regwindow(regs);
+	show_stack(current, (unsigned long *) regs->u_regs[UREG_FP]);
 }
 
 struct global_reg_snapshot global_reg_snapshot[NR_CPUS];
-- 
1.7.0.4

