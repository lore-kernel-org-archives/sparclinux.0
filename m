From: Kirill Tkhai <tkhai@yandex.ru>
Date: Thu, 25 Jul 2013 21:00:53 +0000
Subject: [PATCH]sparc64: Fix wrong syscall return value passed to trace_sys_exit()
Message-Id: <164021374786053@web9g.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Syscall number is passed instead of return value. Fix that.

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
CC: David Miller <davem@davemloft.net>
---
 arch/sparc/kernel/ptrace_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 7ff45e4..a348330 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -1087,7 +1087,7 @@ asmlinkage void syscall_trace_leave(struct pt_regs *regs)
 	audit_syscall_exit(regs);
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
-		trace_sys_exit(regs, regs->u_regs[UREG_G1]);
+		trace_sys_exit(regs, regs->u_regs[UREG_I0]);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		tracehook_report_syscall_exit(regs, 0);
