From: Adrian Bunk <bunk@kernel.org>
Date: Wed, 23 Apr 2008 09:51:51 +0000
Subject: [2.6 patch] sparc64: cleanup after SunOS/Solaris binary emulation
Message-Id: <20080423095151.GD28933@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

The following cleanups are now possible:
- arch/sparc64/kernel/entry.S:ret_sys_call no longer has to be global
- arch/sparc64/kernel/sparc64_ksyms.c:
  remove no longer used prototypes

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 arch/sparc64/kernel/entry.S         |    2 +-
 arch/sparc64/kernel/sparc64_ksyms.c |    2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

ca8093aa35d5765240c30a334109356831c04b5c diff --git a/arch/sparc64/kernel/entry.S b/arch/sparc64/kernel/entry.S
index fb43c76..f54cd2d 100644
--- a/arch/sparc64/kernel/entry.S
+++ b/arch/sparc64/kernel/entry.S
@@ -1559,7 +1559,7 @@ linux_sparc_syscall32:
 
 	/* Linux native system calls enter here... */
 	.align	32
-	.globl	linux_sparc_syscall, ret_sys_call
+	.globl	linux_sparc_syscall
 linux_sparc_syscall:
 	/* Direct access to user regs, much faster. */
 	cmp		%g1, NR_SYSCALLS			! IEU1	Group
diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
index 3873646..6633659 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -68,8 +68,6 @@ extern void *__memscan_zero(void *, size_t);
 extern void *__memscan_generic(void *, int, size_t);
 extern int __memcmp(const void *, const void *, __kernel_size_t);
 extern __kernel_size_t strlen(const char *);
-extern void linux_sparc_syscall(void);
-extern void rtrap(void);
 extern void show_regs(struct pt_regs *);
 extern void syscall_trace(struct pt_regs *, int);
 extern void sys_sigsuspend(void);

