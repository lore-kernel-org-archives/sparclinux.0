From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 12 May 2020 17:15:27 +0000
Subject: [PATCH 3/3] sparc: unconditionally enable HAVE_COPY_THREAD_TLS
Message-Id: <20200512171527.570109-4-christian.brauner@ubuntu.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200512171527.570109-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200512171527.570109-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Christian Brauner <christian.brauner@ubuntu.com>

Now that both sparc and sparc64 support copy_thread_tls() and don't rely
on do_fork() anymore, turn on HAVE_COPY_THREAD_TLS unconditionally. Once
all architectures are switched over this macro will be removed and
the old do_fork() calling convention fully abandoned in favor of the
cleaner struct kernel_clone_args one.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/sparc/Kconfig             | 2 +-
 arch/sparc/kernel/process_32.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 423f6bc41de2..9f44afe1f73d 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -48,6 +48,7 @@ config SPARC
 	select LOCKDEP_SMALL if LOCKDEP
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
+	select HAVE_COPY_THREAD_TLS
 
 config SPARC32
 	def_bool !64BIT
@@ -95,7 +96,6 @@ config SPARC64
 	select ARCH_HAS_PTE_SPECIAL
 	select PCI_DOMAINS if PCI
 	select ARCH_HAS_GIGANTIC_PAGE
-	select HAVE_COPY_THREAD_TLS
 
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 9c510e6625aa..575bfbda7373 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -274,8 +274,9 @@ clone_stackframe(struct sparc_stackf __user *dst,
 extern void ret_from_fork(void);
 extern void ret_from_kernel_thread(void);
 
-int copy_thread(unsigned long clone_flags, unsigned long sp,
-		unsigned long arg, struct task_struct *p)
+int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
+		    unsigned long arg, struct task_struct *p,
+		    unsigned long tls)
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
@@ -377,7 +378,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 	regs->u_regs[UREG_I1] = 0;
 
 	if (clone_flags & CLONE_SETTLS)
-		childregs->u_regs[UREG_G7] = regs->u_regs[UREG_I3];
+		childregs->u_regs[UREG_G7] = tls;
 
 	return 0;
 }
-- 
2.26.2
