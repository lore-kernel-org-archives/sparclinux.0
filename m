From: Kirill Tkhai <tkhai@yandex.ru>
Date: Thu, 31 Mar 2011 07:49:51 +0000
Subject: [PATCH] SPARC32: wrong scheduling of freshly created processes
Message-Id: <1301557791.5962.19.camel@hp>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

SPARC32: Pass task_struct to schedule_tail() in ret_from_fork

Hello, Dave.

We have to pass task_struct of previous process to function
schedule_tail(). Currently in ret_from_fork previous thread_info
is passed:

switch_to: mov %g6, %g3 /* previous thread_info in g6 */

ret_from_fork: call    schedule_tail
                mov    %g3, %o0 /* previous thread_info is passed */

void schedule_tail(struct task_struct *prev);

Signed-off-by: Tkhai Kirill <tkhai@yandex.ru>

--- arch/sparc/kernel/entry.S.orig	2011-03-27 22:37:20.000000000 +0400
+++ arch/sparc/kernel/entry.S	2011-03-29 20:52:00.165292813 +0400
@@ -1283,7 +1283,7 @@ linux_syscall_trace:
 	.globl	ret_from_fork
 ret_from_fork:
 	call	schedule_tail
-	 mov	%g3, %o0
+	 ld	[%g3 + TI_TASK], %o0
 	b	ret_sys_call
 	 ld	[%sp + STACKFRAME_SZ + PT_I0], %o0


