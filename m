From: David Miller <davem@davemloft.net>
Date: Thu, 01 Apr 2010 01:06:13 +0000
Subject: [PATCH] sparc: Fix regset register window handling.
Message-Id: <20100331.180613.21424983.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


We have to adjust 'reg_window' down by 16 becuase the 'pos' iterator
we'll use to index into the stack slots will be between 16 and 32.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

This should fix registers in core dumps and other debugging
problems on Sparc.  I'll push this to Linus and stable too.

 arch/sparc/kernel/ptrace_32.c |    4 ++++
 arch/sparc/kernel/ptrace_64.c |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/ptrace_32.c b/arch/sparc/kernel/ptrace_32.c
index 7e3dfd9..e608f39 100644
--- a/arch/sparc/kernel/ptrace_32.c
+++ b/arch/sparc/kernel/ptrace_32.c
@@ -65,6 +65,7 @@ static int genregs32_get(struct task_struct *target,
 			*k++ = regs->u_regs[pos++];
 
 		reg_window = (unsigned long __user *) regs->u_regs[UREG_I6];
+		reg_window -= 16;
 		for (; count > 0 && pos < 32; count--) {
 			if (get_user(*k++, &reg_window[pos++]))
 				return -EFAULT;
@@ -76,6 +77,7 @@ static int genregs32_get(struct task_struct *target,
 		}
 
 		reg_window = (unsigned long __user *) regs->u_regs[UREG_I6];
+		reg_window -= 16;
 		for (; count > 0 && pos < 32; count--) {
 			if (get_user(reg, &reg_window[pos++]) ||
 			    put_user(reg, u++))
@@ -141,6 +143,7 @@ static int genregs32_set(struct task_struct *target,
 			regs->u_regs[pos++] = *k++;
 
 		reg_window = (unsigned long __user *) regs->u_regs[UREG_I6];
+		reg_window -= 16;
 		for (; count > 0 && pos < 32; count--) {
 			if (put_user(*k++, &reg_window[pos++]))
 				return -EFAULT;
@@ -153,6 +156,7 @@ static int genregs32_set(struct task_struct *target,
 		}
 
 		reg_window = (unsigned long __user *) regs->u_regs[UREG_I6];
+		reg_window -= 16;
 		for (; count > 0 && pos < 32; count--) {
 			if (get_user(reg, u++) ||
 			    put_user(reg, &reg_window[pos++]))
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 2f6524d..aa90da0 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -492,6 +492,7 @@ static int genregs32_get(struct task_struct *target,
 			*k++ = regs->u_regs[pos++];
 
 		reg_window = (compat_ulong_t __user *) regs->u_regs[UREG_I6];
+		reg_window -= 16;
 		if (target = current) {
 			for (; count > 0 && pos < 32; count--) {
 				if (get_user(*k++, &reg_window[pos++]))
@@ -516,6 +517,7 @@ static int genregs32_get(struct task_struct *target,
 		}
 
 		reg_window = (compat_ulong_t __user *) regs->u_regs[UREG_I6];
+		reg_window -= 16;
 		if (target = current) {
 			for (; count > 0 && pos < 32; count--) {
 				if (get_user(reg, &reg_window[pos++]) ||
@@ -599,6 +601,7 @@ static int genregs32_set(struct task_struct *target,
 			regs->u_regs[pos++] = *k++;
 
 		reg_window = (compat_ulong_t __user *) regs->u_regs[UREG_I6];
+		reg_window -= 16;
 		if (target = current) {
 			for (; count > 0 && pos < 32; count--) {
 				if (put_user(*k++, &reg_window[pos++]))
@@ -625,6 +628,7 @@ static int genregs32_set(struct task_struct *target,
 		}
 
 		reg_window = (compat_ulong_t __user *) regs->u_regs[UREG_I6];
+		reg_window -= 16;
 		if (target = current) {
 			for (; count > 0 && pos < 32; count--) {
 				if (get_user(reg, u++) ||
-- 
1.7.0.3

