From: Roland McGrath <roland@redhat.com>
Date: Sun, 23 Mar 2008 21:19:51 +0000
Subject: [PATCH] sparc64 exec PT_DTRACE
Message-Id: <20080323211951.522C026FA0A@magilla.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

The PT_DTRACE flag is meaningless and obsolete.
Don't touch it.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/sparc64/kernel/process.c     |    3 ---
 arch/sparc64/kernel/sys_sparc32.c |    3 ---
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/sparc64/kernel/process.c b/arch/sparc64/kernel/process.c
index e116e38..c80d850 100644
--- a/arch/sparc64/kernel/process.c
+++ b/arch/sparc64/kernel/process.c
@@ -731,9 +731,6 @@ asmlinkage int sparc_execve(struct pt_regs *regs)
 		current_thread_info()->xfsr[0] = 0;
 		current_thread_info()->fpsaved[0] = 0;
 		regs->tstate &= ~TSTATE_PEF;
-		task_lock(current);
-		current->ptrace &= ~PT_DTRACE;
-		task_unlock(current);
 	}
 out:
 	return error;
diff --git a/arch/sparc64/kernel/sys_sparc32.c b/arch/sparc64/kernel/sys_sparc32.c
index deaba2b..41cbc6b 100644
--- a/arch/sparc64/kernel/sys_sparc32.c
+++ b/arch/sparc64/kernel/sys_sparc32.c
@@ -678,9 +678,6 @@ asmlinkage long sparc32_execve(struct pt_regs *regs)
 		current_thread_info()->xfsr[0] = 0;
 		current_thread_info()->fpsaved[0] = 0;
 		regs->tstate &= ~TSTATE_PEF;
-		task_lock(current);
-		current->ptrace &= ~PT_DTRACE;
-		task_unlock(current);
 	}
 out:
 	return error;
