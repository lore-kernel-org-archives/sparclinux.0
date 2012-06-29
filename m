From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 29 Jun 2012 12:55:25 +0000
Subject: [PATCH] sparc32, copy_thread: Clear TIF_USEDFPU flag of created task instead of current
Message-Id: <1959391340974525@web19e.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

FPU state is saved into task_struct of created task. Current task continues
use of the state, so it needs TIF_USEDFPU flag is not cleared.

Created task receives fresh FPU and cleared TIF_USEFPU flag is required for it.

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
---
arch/sparc/kernel/process_32.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index fe6787c..3c6dec4 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -358,9 +358,6 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 		put_psr(get_psr() | PSR_EF);
 		fpsave(&p->thread.float_regs[0], &p->thread.fsr,
 		       &p->thread.fpqueue[0], &p->thread.fpqdepth);
-#ifdef CONFIG_SMP
-		clear_thread_flag(TIF_USEDFPU);
-#endif
 	}
 
 	/*
@@ -438,6 +435,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 #ifdef CONFIG_SMP
 	/* FPU must be disabled on SMP. */
 	childregs->psr &= ~PSR_EF;
+	clear_tsk_thread_flag(p, TIF_USEDFPU);
 #endif
 
 	/* Set the return value for the child. */
