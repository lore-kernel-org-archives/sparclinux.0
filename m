From: Youling Tang <tangyouling@loongson.cn>
Date: Fri, 27 Nov 2020 03:58:50 +0000
Subject: [PATCH] sparc: Removes code duplication between arch_ptrace and compat_arch_ptrace
Message-Id: <1606449530-14319-1-git-send-email-tangyouling@loongson.cn>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oleg Nesterov <oleg@redhat.com>, "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

The patch removes code duplication between arch_ptrace and
compat_arch_ptrace, in large part by having the former call
into the later for all requests that don't need any special
"compat" treatment.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/sparc/kernel/ptrace_64.c | 71 +++++++++++--------------------------------
 1 file changed, 17 insertions(+), 54 deletions(-)

diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 2b92155d..4fd8c33 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -929,78 +929,51 @@ struct compat_fps {
 long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
-	compat_ulong_t caddr2 = task_pt_regs(current)->u_regs[UREG_I4];
 	struct pt_regs32 __user *pregs;
 	struct compat_fps __user *fps;
-	unsigned long addr2 = caddr2;
 	unsigned long addr = caddr;
 	unsigned long data = cdata;
-	int ret;
 
 	pregs = (struct pt_regs32 __user *) addr;
 	fps = (struct compat_fps __user *) addr;
 
 	switch (request) {
-	case PTRACE_PEEKUSR:
-		ret = (addr != 0) ? -EIO : 0;
-		break;
-
 	case PTRACE_GETREGS:
-		ret = copy_regset_to_user(child, &ptrace32_view,
+		return copy_regset_to_user(child, &ptrace32_view,
 					  REGSET_GENERAL, 0,
 					  19 * sizeof(u32),
 					  pregs);
-		break;
 
 	case PTRACE_SETREGS:
-		ret = copy_regset_from_user(child, &ptrace32_view,
+		return copy_regset_from_user(child, &ptrace32_view,
 					  REGSET_GENERAL, 0,
 					  19 * sizeof(u32),
 					  pregs);
-		break;
 
 	case PTRACE_GETFPREGS:
-		ret = copy_regset_to_user(child, &ptrace32_view,
+		return copy_regset_to_user(child, &ptrace32_view,
 					  REGSET_FP, 0,
 					  68 * sizeof(u32),
 					  fps);
-		break;
 
 	case PTRACE_SETFPREGS:
-		ret = copy_regset_from_user(child, &ptrace32_view,
+		return copy_regset_from_user(child, &ptrace32_view,
 					  REGSET_FP, 0,
 					  33 * sizeof(u32),
 					  fps);
-		break;
 
+	case PTRACE_PEEKUSR:
 	case PTRACE_READTEXT:
 	case PTRACE_READDATA:
-		ret = ptrace_readdata(child, addr,
-				      (char __user *)addr2, data);
-		if (ret = data)
-			ret = 0;
-		else if (ret >= 0)
-			ret = -EIO;
-		break;
-
 	case PTRACE_WRITETEXT:
 	case PTRACE_WRITEDATA:
-		ret = ptrace_writedata(child, (char __user *) addr2,
-				       addr, data);
-		if (ret = data)
-			ret = 0;
-		else if (ret >= 0)
-			ret = -EIO;
-		break;
+		return arch_ptrace(child, request, addr, data);
 
 	default:
 		if (request = PTRACE_SPARC_DETACH)
 			request = PTRACE_DETACH;
-		ret = compat_ptrace_request(child, request, addr, data);
-		break;
+		return compat_ptrace_request(child, request, addr, data);
 	}
-
-	return ret;
 }
 #endif /* CONFIG_COMPAT */
 
@@ -1025,63 +998,53 @@ long arch_ptrace(struct task_struct *child, long request,
 
 	switch (request) {
 	case PTRACE_PEEKUSR:
-		ret = (addr != 0) ? -EIO : 0;
-		break;
+		return ((addr != 0) ? -EIO : 0);
 
 	case PTRACE_GETREGS64:
-		ret = copy_regset_to_user(child, &ptrace64_view,
+		return copy_regset_to_user(child, &ptrace64_view,
 					  REGSET_GENERAL, 0,
 					  19 * sizeof(u64),
 					  pregs);
-		break;
 
 	case PTRACE_SETREGS64:
-		ret = copy_regset_from_user(child, &ptrace64_view,
+		return copy_regset_from_user(child, &ptrace64_view,
 					  REGSET_GENERAL, 0,
 					  19 * sizeof(u64),
 					  pregs);
-		break;
 
 	case PTRACE_GETFPREGS64:
-		ret = copy_regset_to_user(child, view, REGSET_FP,
+		return copy_regset_to_user(child, view, REGSET_FP,
 					  0 * sizeof(u64),
 					  33 * sizeof(u64),
 					  fps);
-		break;
 
 	case PTRACE_SETFPREGS64:
-		ret = copy_regset_from_user(child, view, REGSET_FP,
+		return copy_regset_from_user(child, view, REGSET_FP,
 					  0 * sizeof(u64),
 					  33 * sizeof(u64),
 					  fps);
-		break;
 
 	case PTRACE_READTEXT:
 	case PTRACE_READDATA:
 		ret = ptrace_readdata(child, addr, addr2p, data);
 		if (ret = data)
-			ret = 0;
+			return 0;
 		else if (ret >= 0)
-			ret = -EIO;
-		break;
+			return -EIO;
 
 	case PTRACE_WRITETEXT:
 	case PTRACE_WRITEDATA:
 		ret = ptrace_writedata(child, addr2p, addr, data);
 		if (ret = data)
-			ret = 0;
+			return 0;
 		else if (ret >= 0)
-			ret = -EIO;
-		break;
+			return -EIO;
 
 	default:
 		if (request = PTRACE_SPARC_DETACH)
 			request = PTRACE_DETACH;
-		ret = ptrace_request(child, request, addr, data);
-		break;
+		return ptrace_request(child, request, addr, data);
 	}
-
-	return ret;
 }
 
 asmlinkage int syscall_trace_enter(struct pt_regs *regs)
-- 
2.1.0
