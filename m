Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A63DB63A;
	Wed,  2 Sep 2026 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334110; cv=none; b=G7wti9JAl8jCE4C1MOjIQfg3elkWfHJcgDLI0R1EmhLVXSgMkHqxNf3LB0i3AXGhUSFV23qHv3UB/8D6R97k1WJlwKHC45P17ou53rNbvWwfcZvs+IF6O2mZrYFDGxJqJIOuxPOVBjarGt2N1OV+S3rvridkqUFR9ylFPiJ8cxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334110; c=relaxed/simple;
	bh=lHMkNGeNhAY/tgzdqodyUbj+lanoGiJ8QhnvNO34iK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbvZEllV2l3uMoX5HWvA4UgIEbIJijidQ7iYw4zobn7w9HZNxYy7sI0Gbw8mu0vM7O2HeN9nXldnNt6n9CxM2ivg1ziZhEasF/4E1rlb73KvK9KNWu5bDXfo+U01siAq8b0eM4Netw0PEcWyBpdCqG6BYuJEpmKfNgjC/IRpJjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=jVv5J6ob; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="jVv5J6ob"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1788334106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MA1FNXy8T7cO6SzfP+eojF2O5rk5e4TAUWvX6RjwjOY=;
	b=jVv5J6obD1nR2u6+z+H8UJ3BKIp55OlLWNC1yi3PvqOpG1YkunbWttXoDBSya7EPJ0EA5d
	6ZOfnaDdgsuRonkS5qgZia8gDnFhAkCj6PI490Go3/WFUq/MoANMsSxejY5cSsGM07njJm
	O2uVQvvjAswMTBgaKIQztunA1TcHAFY=
To: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kees Cook <kees@kernel.org>,
	sparclinux@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2 1/2] sparc64: add seccomp filter support
Date: Wed,  2 Sep 2026 09:27:44 +0200
Message-ID: <20260902072745.3412940-2-stian@itx.no>
In-Reply-To: <20260902072745.3412940-1-stian@itx.no>
References: <20260902072745.3412940-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sparc is the last architecture besides alpha without SECCOMP_FILTER,
which systemd, docker, flatpak and the like all want, and userspace
support already exists as a pending libseccomp pull request.
Everything the filter mode needs is in fact already in place:
syscall_get_arch(), syscall_get_arguments() and
syscall_set_return_value() have long been provided for audit and
ptrace, TIF_SECCOMP is already in the syscall-entry work mask, and
strict-mode seccomp has been wired up for years.  What is missing is
letting seccomp veto a syscall and honouring the return value it
sets.

Rework the entry hook accordingly: syscall_trace_enter() now runs the
ptrace entry report first and seccomp second (matching the generic
entry code, so a tracer's changes are seen by the filter), and
returns -1 when the syscall has been denied.  On denial the return
value and the carry bit have already been set in pt_regs -
syscall_set_return_value() for a ptrace abort, the seccomp core for
SECCOMP_RET_ERRNO/TRAP/TRACE/KILL - so the assembler stubs must no
longer force -ENOSYS; they instead branch to a new linux_syscall_skip
path that advances TPC/TNPC past the trap instruction and returns
through the syscall exit work without storing a new return value.

The old behaviour of a ptrace entry abort (ENOSYS with the carry bit
set, followed by the exit report) is preserved, it is just set up in
C now.

syscall_rollback()'s XXX comment is replaced with an explanation of
why a no-op is correct: every caller runs before the syscall has been
invoked, and on sparc the first argument register is only overwritten
by the return value once the syscall has actually run.

SECCOMP_ARCH_NATIVE/COMPAT are defined so the constant-action bitmap
cache works for both 64-bit and compat 32-bit tasks.

Filter support is 64-bit only for now, as strict mode already was:
the 32-bit kernel's entry path has no equivalent plumbing.

Tested on an UltraSPARC T4-1: the seccomp_bpf selftest passes 95 of
95 (16 skipped for missing optional features such as uprobes), the
libseccomp test suite with its pending SPARC support passes 5190 of
5190 including the live tests, and docker containers run confined by
both the default and custom seccomp profiles.

Link: https://github.com/sparclinux/issues/issues/11
Signed-off-by: Stian Halseth <stian@itx.no>
---
v2: no changes

 arch/sparc/Kconfig               |  2 +-
 arch/sparc/include/asm/seccomp.h | 15 +++++++++++++++
 arch/sparc/include/asm/syscall.h | 11 +++++------
 arch/sparc/kernel/entry.h        |  2 +-
 arch/sparc/kernel/ptrace_64.c    | 28 +++++++++++++++++++---------
 arch/sparc/kernel/syscalls.S     | 28 ++++++++++++++++++++++------
 6 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index ab77d3f2536e..8dd15256edf6 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -23,7 +23,7 @@ config SPARC
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_ARCH_KGDB if !SMP || SPARC64
 	select HAVE_ARCH_TRACEHOOK
-	select HAVE_ARCH_SECCOMP if SPARC64
+	select HAVE_ARCH_SECCOMP_FILTER if SPARC64
 	select HAVE_EXIT_THREAD
 	select HAVE_PCI
 	select SYSCTL_EXCEPTION_TRACE
diff --git a/arch/sparc/include/asm/seccomp.h b/arch/sparc/include/asm/seccomp.h
index 62d4579efb1a..1ea70080f5cd 100644
--- a/arch/sparc/include/asm/seccomp.h
+++ b/arch/sparc/include/asm/seccomp.h
@@ -6,6 +6,21 @@
 
 #define __NR_seccomp_sigreturn_32 __NR_sigreturn
 
+#ifdef CONFIG_SPARC64
+# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_SPARC64
+# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+# define SECCOMP_ARCH_NATIVE_NAME	"sparc64"
+# ifdef CONFIG_COMPAT
+#  define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_SPARC
+#  define SECCOMP_ARCH_COMPAT_NR	NR_syscalls
+#  define SECCOMP_ARCH_COMPAT_NAME	"sparc"
+# endif
+#else
+# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_SPARC
+# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+# define SECCOMP_ARCH_NATIVE_NAME	"sparc"
+#endif
+
 #include <asm-generic/seccomp.h>
 
 #endif /* _ASM_SECCOMP_H */
diff --git a/arch/sparc/include/asm/syscall.h b/arch/sparc/include/asm/syscall.h
index b0233924d323..fc225f2ee23c 100644
--- a/arch/sparc/include/asm/syscall.h
+++ b/arch/sparc/include/asm/syscall.h
@@ -40,12 +40,11 @@ static inline void syscall_set_nr(struct task_struct *task,
 static inline void syscall_rollback(struct task_struct *task,
 				    struct pt_regs *regs)
 {
-	/* XXX This needs some thought.  On Sparc we don't
-	 * XXX save away the original %o0 value somewhere.
-	 * XXX Instead we hold it in register %l5 at the top
-	 * XXX level trap frame and pass this down to the signal
-	 * XXX dispatch code which is the only place that value
-	 * XXX ever was needed.
+	/* Every caller rolls back before the syscall has been invoked
+	 * (a ptrace entry abort or a seccomp user notification), and at
+	 * that point the arguments in pt_regs are still intact: the
+	 * return value only overwrites u_regs[UREG_I0] once the syscall
+	 * has actually run.  Nothing to undo.
 	 */
 }
 
diff --git a/arch/sparc/kernel/entry.h b/arch/sparc/kernel/entry.h
index c746c0fd5d6b..734a649301ea 100644
--- a/arch/sparc/kernel/entry.h
+++ b/arch/sparc/kernel/entry.h
@@ -82,7 +82,7 @@ void do_notify_resume(struct pt_regs *regs,
 		      unsigned long orig_i0,
 		      unsigned long thread_info_flags);
 
-asmlinkage int syscall_trace_enter(struct pt_regs *regs);
+asmlinkage long syscall_trace_enter(struct pt_regs *regs);
 asmlinkage void syscall_trace_leave(struct pt_regs *regs);
 
 void bad_trap_tl1(struct pt_regs *regs, long lvl);
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 825ddf55fece..6f4a005e674f 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -38,6 +38,7 @@
 #include <asm/page.h>
 #include <asm/cpudata.h>
 #include <asm/cacheflush.h>
+#include <asm/syscall.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
@@ -1082,18 +1083,27 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ret;
 }
 
-asmlinkage int syscall_trace_enter(struct pt_regs *regs)
+/*
+ * Returns 0 to let the syscall through, or -1 to skip it.  On skip the
+ * return value and the carry bit have already been set in pt_regs; the
+ * assembler caller must return through the syscall exit work without
+ * writing to them.
+ */
+asmlinkage long syscall_trace_enter(struct pt_regs *regs)
 {
-	int ret = 0;
-
-	/* do the secure computing check first */
-	secure_computing_strict(regs->u_regs[UREG_G1]);
-
 	if (test_thread_flag(TIF_NOHZ))
 		user_exit();
 
-	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		ret = !ptrace_report_syscall_permit_entry(regs);
+	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
+	    !ptrace_report_syscall_permit_entry(regs)) {
+		/* The tracer aborted the syscall. */
+		syscall_set_return_value(current, regs, -ENOSYS, 0);
+		return -1;
+	}
+
+	/* Do seccomp after ptrace, to catch any tracer changes. */
+	if (!seccomp_permit_syscall())
+		return -1;
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->u_regs[UREG_G1]);
@@ -1102,7 +1112,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 			    regs->u_regs[UREG_I1], regs->u_regs[UREG_I2],
 			    regs->u_regs[UREG_I3]);
 
-	return ret;
+	return 0;
 }
 
 asmlinkage void syscall_trace_leave(struct pt_regs *regs)
diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index 96fe8763d70c..46779bb27e77 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -159,11 +159,13 @@ linux_sparc_ni_syscall:
 linux_syscall_trace32:
 	call	syscall_trace_enter
 	 add	%sp, PTREGS_OFF, %o0
-	brnz,pn	%o0, 3f
-	 mov	-ENOSYS, %o0
 
+	/* A negative return means the syscall was denied and the
+	 * return value is already set in pt_regs.
+	 */
+	brlz,pn	%o0, linux_syscall_skip
 	/* Syscall tracing can modify the registers.  */
-	ldx	[%sp + PTREGS_OFF + PT_V9_G1], %g1
+	 ldx	[%sp + PTREGS_OFF + PT_V9_G1], %g1
 	sethi	%hi(sys_call_table32), %l7
 	ldx	[%sp + PTREGS_OFF + PT_V9_I0], %i0
 	or	%l7, %lo(sys_call_table32), %l7
@@ -189,11 +191,13 @@ linux_syscall_trace32:
 linux_syscall_trace:
 	call	syscall_trace_enter
 	 add	%sp, PTREGS_OFF, %o0
-	brnz,pn	%o0, 3f
-	 mov	-ENOSYS, %o0
 
+	/* A negative return means the syscall was denied and the
+	 * return value is already set in pt_regs.
+	 */
+	brlz,pn	%o0, linux_syscall_skip
 	/* Syscall tracing can modify the registers.  */
-	ldx	[%sp + PTREGS_OFF + PT_V9_G1], %g1
+	 ldx	[%sp + PTREGS_OFF + PT_V9_G1], %g1
 	sethi	%hi(sys_call_table64), %l7
 	ldx	[%sp + PTREGS_OFF + PT_V9_I0], %i0
 	or	%l7, %lo(sys_call_table64), %l7
@@ -307,3 +311,15 @@ linux_syscall_trace2:
 	stx	%l1, [%sp + PTREGS_OFF + PT_V9_TPC]
 	ba,pt	%xcc, rtrap
 	 stx	%l2, [%sp + PTREGS_OFF + PT_V9_TNPC]
+
+	/* The syscall was denied at entry by ptrace or seccomp.  The
+	 * return value and the carry bit are already set in pt_regs;
+	 * advance past the trap instruction and run the syscall exit
+	 * work without storing a new return value.  We can only get
+	 * here from the entry trace stubs, so the thread flags in %l0
+	 * are known to be non-zero.
+	 */
+linux_syscall_skip:
+	ldx	[%sp + PTREGS_OFF + PT_V9_TNPC], %l1	! pc = npc
+	ba,pt	%xcc, linux_syscall_trace2
+	 add	%l1, 0x4, %l2				! npc = npc+4
-- 
2.43.0

