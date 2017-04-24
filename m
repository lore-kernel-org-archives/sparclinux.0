From: David Miller <davem@davemloft.net>
Date: Mon, 24 Apr 2017 00:24:26 +0000
Subject: [PATCH] sparc64: Fill in rest of HAVE_REGS_AND_STACK_ACCESS_API
Message-Id: <20170423.172426.1562412223042437061.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This lets us enable KPROBE_EVENTS.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Kconfig              |  1 +
 arch/sparc/include/asm/ptrace.h |  3 ++-
 arch/sparc/kernel/ptrace_64.c   | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a59deae..3db2543 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -82,6 +82,7 @@ config SPARC64
 	select HAVE_ARCH_AUDITSYSCALL
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select HAVE_NMI
+	select HAVE_REGS_AND_STACK_ACCESS_API
 
 config ARCH_DEFCONFIG
 	string
diff --git a/arch/sparc/include/asm/ptrace.h b/arch/sparc/include/asm/ptrace.h
index ca57f08..d73428e 100644
--- a/arch/sparc/include/asm/ptrace.h
+++ b/arch/sparc/include/asm/ptrace.h
@@ -83,7 +83,8 @@ unsigned long profile_pc(struct pt_regs *);
 
 #define MAX_REG_OFFSET (offsetof(struct pt_regs, magic))
 
-extern int regs_query_register_offset(const char *name);
+int regs_query_register_offset(const char *name);
+unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n);
 
 /**
  * regs_get_register() - get register value from its offset
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index fc5124c..e1d965e 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -1162,3 +1162,39 @@ int regs_query_register_offset(const char *name)
 			return roff->offset;
 	return -EINVAL;
 }
+
+/**
+ * regs_within_kernel_stack() - check the address in the stack
+ * @regs:	pt_regs which contains kernel stack pointer.
+ * @addr:	address which is checked.
+ *
+ * regs_within_kernel_stack() checks @addr is within the kernel stack page(s).
+ * If @addr is within the kernel stack, it returns true. If not, returns false.
+ */
+static inline int regs_within_kernel_stack(struct pt_regs *regs,
+					   unsigned long addr)
+{
+	unsigned long ksp = kernel_stack_pointer(regs) + STACK_BIAS;
+	return ((addr & ~(THREAD_SIZE - 1))  =
+		(ksp & ~(THREAD_SIZE - 1)));
+}
+
+/**
+ * regs_get_kernel_stack_nth() - get Nth entry of the stack
+ * @regs:	pt_regs which contains kernel stack pointer.
+ * @n:		stack entry number.
+ *
+ * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
+ * is specified by @regs. If the @n th entry is NOT in the kernel stack,
+ * this returns 0.
+ */
+unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
+{
+	unsigned long ksp = kernel_stack_pointer(regs) + STACK_BIAS;
+	unsigned long *addr = (unsigned long *)ksp;
+	addr += n;
+	if (regs_within_kernel_stack(regs, (unsigned long)addr))
+		return *addr;
+	else
+		return 0;
+}
-- 
2.1.2.532.g19b5d50

