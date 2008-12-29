From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 29 Dec 2008 23:58:09 +0000
Subject: [PATCH 10/11] sparc: unify sigcontext.h
Message-Id: <1230595090-23982-10-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

With the renamed types in place the unification was straightforward.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/Kbuild          |    2 -
 arch/sparc/include/asm/sigcontext.h    |  102 +++++++++++++++++++++++++++++--
 arch/sparc/include/asm/sigcontext_32.h |   59 ------------------
 arch/sparc/include/asm/sigcontext_64.h |   87 ---------------------------
 4 files changed, 95 insertions(+), 155 deletions(-)
 delete mode 100644 arch/sparc/include/asm/sigcontext_32.h
 delete mode 100644 arch/sparc/include/asm/sigcontext_64.h

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 1612229..fd925bd 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -3,8 +3,6 @@ include include/asm-generic/Kbuild.asm
 
 header-y += ptrace_32.h
 header-y += ptrace_64.h
-header-y += sigcontext_32.h
-header-y += sigcontext_64.h
 header-y += siginfo_32.h
 header-y += siginfo_64.h
 
diff --git a/arch/sparc/include/asm/sigcontext.h b/arch/sparc/include/asm/sigcontext.h
index e92de7e..a1607d1 100644
--- a/arch/sparc/include/asm/sigcontext.h
+++ b/arch/sparc/include/asm/sigcontext.h
@@ -1,8 +1,96 @@
-#ifndef ___ASM_SPARC_SIGCONTEXT_H
-#define ___ASM_SPARC_SIGCONTEXT_H
-#if defined(__sparc__) && defined(__arch64__)
-#include <asm/sigcontext_64.h>
+#ifndef __SPARC_SIGCONTEXT_H
+#define __SPARC_SIGCONTEXT_H
+
+#ifdef __KERNEL__
+#include <asm/ptrace.h>
+
+#ifndef __ASSEMBLY__
+
+#define __SUNOS_MAXWIN   31
+
+/* This is what SunOS does, so shall I unless we use new 32bit signals or rt signals. */
+struct sigcontext32 {
+	int sigc_onstack;      /* state to restore */
+	int sigc_mask;         /* sigmask to restore */
+	int sigc_sp;           /* stack pointer */
+	int sigc_pc;           /* program counter */
+	int sigc_npc;          /* next program counter */
+	int sigc_psr;          /* for condition codes etc */
+	int sigc_g1;           /* User uses these two registers */
+	int sigc_o0;           /* within the trampoline code. */
+
+	/* Now comes information regarding the users window set
+	 * at the time of the signal.
+	 */
+	int sigc_oswins;       /* outstanding windows */
+
+	/* stack ptrs for each regwin buf */
+	unsigned sigc_spbuf[__SUNOS_MAXWIN];
+
+	/* Windows to restore after signal */
+	struct reg_window32 sigc_wbuf[__SUNOS_MAXWIN];
+};
+
+
+/* This is what we use for 32bit new non-rt signals. */
+
+typedef struct {
+	struct {
+		unsigned int psr;
+		unsigned int pc;
+		unsigned int npc;
+		unsigned int y;
+		unsigned int u_regs[16]; /* globals and ins */
+	}			si_regs;
+	int			si_mask;
+} __siginfo32_t;
+
+#ifdef CONFIG_SPARC64
+typedef struct {
+	unsigned   int si_float_regs [64];
+	unsigned   long si_fsr;
+	unsigned   long si_gsr;
+	unsigned   long si_fprs;
+} __siginfo_fpu_t;
+
+/* This is what SunOS doesn't, so we have to write this alone
+   and do it properly. */
+struct sigcontext {
+	/* The size of this array has to match SI_MAX_SIZE from siginfo.h */
+	char			sigc_info[128];
+	struct {
+		unsigned long	u_regs[16]; /* globals and ins */
+		unsigned long	tstate;
+		unsigned long	tpc;
+		unsigned long	tnpc;
+		unsigned int	y;
+		unsigned int	fprs;
+	}			sigc_regs;
+	__siginfo_fpu_t *	sigc_fpu_save;
+	struct {
+		void	*	ss_sp;
+		int		ss_flags;
+		unsigned long	ss_size;
+	}			sigc_stack;
+	unsigned long		sigc_mask;
+};
+
 #else
-#include <asm/sigcontext_32.h>
-#endif
-#endif
+
+typedef struct {
+	unsigned long si_float_regs [32];
+	unsigned long si_fsr;
+	unsigned long si_fpqdepth;
+	struct {
+		unsigned long *insn_addr;
+		unsigned long insn;
+	} si_fpqueue [16];
+} __siginfo_fpu_t;
+#endif /* (CONFIG_SPARC64) */
+
+
+#endif /* !(__ASSEMBLY__) */
+
+#endif /* (__KERNEL__) */
+
+#endif /* !(__SPARC_SIGCONTEXT_H) */
diff --git a/arch/sparc/include/asm/sigcontext_32.h b/arch/sparc/include/asm/sigcontext_32.h
deleted file mode 100644
index 756e996..0000000
--- a/arch/sparc/include/asm/sigcontext_32.h
+++ /dev/null
@@ -1,59 +0,0 @@
-#ifndef __SPARC_SIGCONTEXT_H
-#define __SPARC_SIGCONTEXT_H
-
-#ifdef __KERNEL__
-#include <asm/ptrace.h>
-
-#ifndef __ASSEMBLY__
-
-#define __SUNOS_MAXWIN   31
-
-/* This is what SunOS does, so shall I. */
-struct sigcontext32 {
-	int sigc_onstack;      /* state to restore */
-	int sigc_mask;         /* sigmask to restore */
-	int sigc_sp;           /* stack pointer */
-	int sigc_pc;           /* program counter */
-	int sigc_npc;          /* next program counter */
-	int sigc_psr;          /* for condition codes etc */
-	int sigc_g1;           /* User uses these two registers */
-	int sigc_o0;           /* within the trampoline code. */
-
-	/* Now comes information regarding the users window set
-	 * at the time of the signal.
-	 */
-	int sigc_oswins;       /* outstanding windows */
-
-	/* stack ptrs for each regwin buf */
-	char *sigc_spbuf[__SUNOS_MAXWIN];
-
-	/* Windows to restore after signal */
-	struct reg_window32 sigc_wbuf[__SUNOS_MAXWIN];
-};
-
-typedef struct {
-	struct {
-		unsigned long psr;
-		unsigned long pc;
-		unsigned long npc;
-		unsigned long y;
-		unsigned long u_regs[16]; /* globals and ins */
-	}		si_regs;
-	int		si_mask;
-} __siginfo32_t;
-
-typedef struct {
-	unsigned   long si_float_regs [32];
-	unsigned   long si_fsr;
-	unsigned   long si_fpqdepth;
-	struct {
-		unsigned long *insn_addr;
-		unsigned long insn;
-	} si_fpqueue [16];
-} __siginfo_fpu_t;
-
-#endif /* !(__ASSEMBLY__) */
-
-#endif /* (__KERNEL__) */
-
-#endif /* !(__SPARC_SIGCONTEXT_H) */
diff --git a/arch/sparc/include/asm/sigcontext_64.h b/arch/sparc/include/asm/sigcontext_64.h
deleted file mode 100644
index 1c868d6..0000000
--- a/arch/sparc/include/asm/sigcontext_64.h
+++ /dev/null
@@ -1,87 +0,0 @@
-#ifndef __SPARC64_SIGCONTEXT_H
-#define __SPARC64_SIGCONTEXT_H
-
-#ifdef __KERNEL__
-#include <asm/ptrace.h>
-#endif
-
-#ifndef __ASSEMBLY__
-
-#ifdef __KERNEL__
-
-#define __SUNOS_MAXWIN   31
-
-/* This is what SunOS does, so shall I unless we use new 32bit signals or rt signals. */
-struct sigcontext32 {
-	int sigc_onstack;      /* state to restore */
-	int sigc_mask;         /* sigmask to restore */
-	int sigc_sp;           /* stack pointer */
-	int sigc_pc;           /* program counter */
-	int sigc_npc;          /* next program counter */
-	int sigc_psr;          /* for condition codes etc */
-	int sigc_g1;           /* User uses these two registers */
-	int sigc_o0;           /* within the trampoline code. */
-
-	/* Now comes information regarding the users window set
-	 * at the time of the signal.
-	 */
-	int sigc_oswins;       /* outstanding windows */
-
-	/* stack ptrs for each regwin buf */
-	unsigned sigc_spbuf[__SUNOS_MAXWIN];
-
-	/* Windows to restore after signal */
-	struct reg_window32 sigc_wbuf[__SUNOS_MAXWIN];
-};
-
-#endif
-
-#ifdef __KERNEL__
-
-/* This is what we use for 32bit new non-rt signals. */
-
-typedef struct {
-	struct {
-		unsigned int psr;
-		unsigned int pc;
-		unsigned int npc;
-		unsigned int y;
-		unsigned int u_regs[16]; /* globals and ins */
-	}			si_regs;
-	int			si_mask;
-} __siginfo32_t;
-
-#endif
-
-typedef struct {
-	unsigned   int si_float_regs [64];
-	unsigned   long si_fsr;
-	unsigned   long si_gsr;
-	unsigned   long si_fprs;
-} __siginfo_fpu_t;
-
-/* This is what SunOS doesn't, so we have to write this alone
-   and do it properly. */
-struct sigcontext {
-	/* The size of this array has to match SI_MAX_SIZE from siginfo.h */
-	char			sigc_info[128];
-	struct {
-		unsigned long	u_regs[16]; /* globals and ins */
-		unsigned long	tstate;
-		unsigned long	tpc;
-		unsigned long	tnpc;
-		unsigned int	y;
-		unsigned int	fprs;
-	}			sigc_regs;
-	__siginfo_fpu_t *	sigc_fpu_save;
-	struct {
-		void	*	ss_sp;
-		int		ss_flags;
-		unsigned long	ss_size;
-	}			sigc_stack;
-	unsigned long		sigc_mask;
-};
-
-#endif /* !(__ASSEMBLY__) */
-
-#endif /* !(__SPARC64_SIGCONTEXT_H) */
-- 
1.6.0.2.GIT

