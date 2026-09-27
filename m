Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131212DA75A;
	Sun, 27 Sep 2026 00:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790470769; cv=none; b=rdXagtEolL0Ddjj+fviuGoQZkV49uHObdEf4HCLxV5P9Ha9KZtrLivWzWGOKCBeCc1aOnwKfP/klj524G8e9BRdCDc5PcLxQmK3jFnmCtL/LOiK3uRfCrs8qyEWPvV9c7aYMb7RirUdEZzEh2mSoXejD+L6925ci4Hp+1cZZ5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790470769; c=relaxed/simple;
	bh=Du3cU79bAXsjUcgzf+HDKi4jYGMQ+3Phn6ovrv6oaMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQVRlTIKiexOBnhoLg6etLsz9ZrPUViYTYcR366IaU0qOMYMYNzBLUedkXS9ksQWnbvrOxzpf8awPN+lct/kq2TN+4l+XiSss1SpoM9Yr17jUCfM4Hp6XCMSWGqOpakeJRjOCo6FCOkhdd2aoPckHCyJWWVjeyojuMsvegXmS7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlL0fP47; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlL0fP47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EF41F000FF;
	Sun, 27 Sep 2026 00:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790470767;
	bh=Wrfsge/UiEXglEWNcZHupbJnJi+4FhsbpIAOoy2SFUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dlL0fP47az+11n9dKFCLi3fB0y4s7dBGpbJ7BI6xlhsKX3Pd65MIXzNVouJdfjKJ1
	 Rj9EsQpA2qXsGSnu8rLSHqv9DIGLM1FL2CC7okUTnBGQ1uZ2/uNh4go8ud0Uuohuva
	 ZwegjlBEx8NZPcY4vROjSJXQ1E5QGHKVqHCdcEJ8vxteLIpV08WrA8UHjQPGytF0yM
	 0N7CX1dbgb7exYN8l404PfTyyGlJnHI+jrg8nm/bh7jqpPdNm5jgUCc+GP2xMhhSzV
	 0EBvXzh/14Yyq8nc1d+lgigHAZ9Oj0NZHc9BbGaReEkvZ7f6hX+lFJJVCXvGjn4obg
	 7o6RW1daE6BBA==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 2/3] sparc32: emulate casa on V8 CPUs
Date: Sun, 27 Sep 2026 02:58:20 +0200
Message-ID: <20260927005821.8369-3-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927005821.8369-1-kaloz@kernel.org>
References: <20260927005821.8369-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sun4m implements no compare-and-swap instruction, only ldstub and swap,
so the V9 casa opcode is undefined there and raises illegal_instruction.
Complete the immediate-ASI form from do_illegal_instruction() for both
ASIs a compiler emits -- 0x80, the V9 primary address space, and 0x0A
from gcc -mcpu=leon3 -- so a C library can use one casa for its 32-bit
atomics on any V8 part. The opcode is unimplemented, so the ASI carries
no distinction the emulated CAS has to honour. LEON parts built without
casa take the same trap and are the LEON parts this serves.

The CAS is futex_atomic_cmpxchg_inatomic(), so it is atomic against the
futex operations and against itself on SMP. Everything else, including
the register-ASI form and casxa, raises SIGILL.

Confirmed on a dual-SuperSPARC SPARCstation 20.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/sparc/kernel/Makefile     |   1 +
 arch/sparc/kernel/cas_emu_32.c | 117 +++++++++++++++++++++++++++++++++
 arch/sparc/kernel/entry.h      |   1 +
 arch/sparc/kernel/traps_32.c   |   7 ++
 arch/sparc/kernel/unimp_32.h   |  71 ++++++++++++++++++++
 5 files changed, 197 insertions(+)
 create mode 100644 arch/sparc/kernel/cas_emu_32.c
 create mode 100644 arch/sparc/kernel/unimp_32.h

diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 497b5714fa8f..fbea79a4ab58 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -40,6 +40,7 @@ obj-y                   += sys_sparc_$(BITS).o
 obj-$(CONFIG_SPARC32)   += systbls_32.o
 obj-y                   += time_$(BITS).o
 obj-$(CONFIG_SPARC32)   += windows.o
+obj-$(CONFIG_SPARC32)   += cas_emu_32.o
 obj-y                   += cpu.o
 obj-$(CONFIG_SPARC32)   += devices.o
 obj-y                   += ptrace_$(BITS).o
diff --git a/arch/sparc/kernel/cas_emu_32.c b/arch/sparc/kernel/cas_emu_32.c
new file mode 100644
index 000000000000..257f528d9a2c
--- /dev/null
+++ b/arch/sparc/kernel/cas_emu_32.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Emulation of the V9 casa compare-and-swap for V8 CPUs.
+ *
+ * Copyright (C) 2026 Imre Kaloz <kaloz@kernel.org>
+ *
+ * sun4m implements no compare-and-swap at all, only ldstub and swap, and
+ * casa is optional on LEON. Where it is missing, casa is an undefined opcode
+ * and raises illegal_instruction (tt 0x02).
+ *
+ * Both immediate ASIs a compiler emits are accepted: 0x80, the V9 primary
+ * address space, and 0x0A, which gcc -mcpu=leon3 uses. The opcode is
+ * unimplemented wherever this runs, so the ASI carries no distinction the
+ * emulated CAS has to honour.
+ *
+ * The register-ASI form is not emulated: it reads %asi, which V8 does not
+ * have. casxa is a 64-bit CAS and is meaningless on a 32-bit CPU.
+ *
+ * The CAS takes the futex ops' lock, so it is atomic against them and
+ * against itself, but not against a plain store to the same word.
+ */
+
+#include <linux/kernel.h>
+#include <linux/sched/signal.h>
+#include <linux/mm.h>
+#include <linux/uaccess.h>
+#include <linux/ptrace.h>
+#include <asm/futex.h>
+#include <asm/ptrace.h>
+
+#include "entry.h"
+#include "unimp_32.h"
+
+#define CASA_OP		3	/* insn[31:30] */
+#define CASA_OP3	0x3c	/* insn[24:19] */
+
+#define ASI_P		0x80
+#define ASI_LEON	0x0a
+
+/* A fault returns -EFAULT, and the caller pages the word in. */
+static int cas_try(u32 __user *uaddr, u32 cmp, u32 newval, u32 *oldval)
+{
+	int ret;
+
+	pagefault_disable();
+	ret = futex_atomic_cmpxchg_inatomic(oldval, uaddr, cmp, newval);
+	pagefault_enable();
+	return ret;
+}
+
+/*
+ * Returns 1 if the trap was consumed, either by emulating the CAS and
+ * advancing the PC or by delivering a fault signal for a bad address, and 0
+ * if this is not a casa we emulate, in which case the caller raises SIGILL.
+ */
+int try_emulate_casa(struct pt_regs *regs, unsigned int insn)
+{
+	unsigned int rd, rs1, rs2, asi;
+	unsigned long addr;
+	u32 cmp, newval, old;
+	int fault = 0, ret;
+
+	if ((insn >> 30) != CASA_OP)
+		return 0;
+	if (((insn >> 19) & 0x3f) != CASA_OP3)
+		return 0;
+	if (insn & (1 << 13))			/* i == 1: register ASI */
+		return 0;
+	asi = (insn >> 5) & 0xff;
+	if (asi != ASI_P && asi != ASI_LEON)
+		return 0;
+
+	rd = (insn >> 25) & 0x1f;
+	rs1 = (insn >> 14) & 0x1f;
+	rs2 = insn & 0x1f;
+
+	unimp_flush_windows(rs1, rs2, rd);
+
+	addr = unimp_get_reg(rs1, regs, &fault);
+	cmp = unimp_get_reg(rs2, regs, &fault);
+	newval = unimp_get_reg(rd, regs, &fault);
+	if (fault)
+		goto sigsegv;
+
+	if (addr & 3) {				/* CAS is naturally aligned */
+		send_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)addr, current);
+		return 1;
+	}
+	if (!access_ok((void __user *)addr, sizeof(u32)))
+		goto sigsegv;
+
+	while ((ret = cas_try((u32 __user *)addr, cmp, newval, &old)) == -EFAULT) {
+		/*
+		 * Page the word in writably and retry, as
+		 * fault_in_user_writeable() does.
+		 */
+		struct mm_struct *mm = current->mm;
+		int fx;
+
+		mmap_read_lock(mm);
+		fx = fixup_user_fault(mm, addr, FAULT_FLAG_WRITE, NULL);
+		mmap_read_unlock(mm);
+		if (fx)
+			goto sigsegv;
+	}
+
+	if (unimp_put_reg(rd, old, regs))
+		goto sigsegv;
+
+	regs->pc = regs->npc;
+	regs->npc += 4;
+	return 1;
+
+sigsegv:
+	send_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)addr, current);
+	return 1;
+}
diff --git a/arch/sparc/kernel/entry.h b/arch/sparc/kernel/entry.h
index c746c0fd5d6b..2eb2b0be90df 100644
--- a/arch/sparc/kernel/entry.h
+++ b/arch/sparc/kernel/entry.h
@@ -14,6 +14,7 @@ void handler_irq(int irq, struct pt_regs *regs);
 void do_hw_interrupt(struct pt_regs *regs, unsigned long type);
 void do_illegal_instruction(struct pt_regs *regs, unsigned long pc,
                             unsigned long npc, unsigned long psr);
+int try_emulate_casa(struct pt_regs *regs, unsigned int insn);
 
 void do_priv_instruction(struct pt_regs *regs, unsigned long pc,
                          unsigned long npc, unsigned long psr);
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index e1d50820c376..69851b19766a 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -109,6 +109,8 @@ void do_hw_interrupt(struct pt_regs *regs, unsigned long type)
 void do_illegal_instruction(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 			    unsigned long psr)
 {
+	unsigned int insn;
+
 	if (psr & PSR_PS) {
 		const struct exception_table_entry *entry;
 
@@ -126,6 +128,11 @@ void do_illegal_instruction(struct pt_regs *regs, unsigned long pc, unsigned lon
 	       regs->pc, *(unsigned long *)regs->pc);
 #endif
 
+	if (!get_user(insn, (unsigned int __user *)pc)) {
+		if (try_emulate_casa(regs, insn))
+			return;
+	}
+
 	send_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)pc, current);
 }
 
diff --git a/arch/sparc/kernel/unimp_32.h b/arch/sparc/kernel/unimp_32.h
new file mode 100644
index 000000000000..9ab1705b9d04
--- /dev/null
+++ b/arch/sparc/kernel/unimp_32.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 Imre Kaloz <kaloz@kernel.org>
+ */
+#ifndef _SPARC_UNIMP_32_H
+#define _SPARC_UNIMP_32_H
+
+#include <linux/uaccess.h>
+#include <asm/ptrace.h>
+
+/*
+ * Operand access for instructions completed out of do_illegal_instruction().
+ *
+ * Like maybe_flush_windows() in unaligned_32.c this has to be inlined: the
+ * save/restore chain must run in the trapping window, not one level deeper
+ * behind a call, or the outermost user window is left un-flushed and
+ * try_to_clear_window_buffer() kills the task on its next fork.
+ */
+static __always_inline void unimp_flush_windows(unsigned int rs1,
+						unsigned int rs2,
+						unsigned int rd)
+{
+	if (rs1 >= 16 || rs2 >= 16 || rd >= 16)
+		__asm__ __volatile__("save %sp, -0x40, %sp\n\t"
+				     "save %sp, -0x40, %sp\n\t"
+				     "save %sp, -0x40, %sp\n\t"
+				     "save %sp, -0x40, %sp\n\t"
+				     "save %sp, -0x40, %sp\n\t"
+				     "save %sp, -0x40, %sp\n\t"
+				     "save %sp, -0x40, %sp\n\t"
+				     "restore; restore; restore; restore;\n\t"
+				     "restore; restore; restore;\n\t");
+}
+
+/*
+ * Globals and outs come from pt_regs, locals and ins from the flushed window
+ * on the user stack. %g0 reads as zero.
+ */
+static inline unsigned long unimp_get_reg(unsigned int reg,
+					  struct pt_regs *regs, int *fault)
+{
+	struct reg_window32 __user *win;
+	unsigned long val;
+
+	if (reg < 16)
+		return reg ? regs->u_regs[reg] : 0;
+
+	win = (struct reg_window32 __user *)regs->u_regs[UREG_FP];
+	if (get_user(val, &win->locals[reg - 16])) {
+		*fault = 1;
+		return 0;
+	}
+	return val;
+}
+
+/* %g0 discards the result. */
+static inline int unimp_put_reg(unsigned int reg, unsigned long val,
+				struct pt_regs *regs)
+{
+	struct reg_window32 __user *win;
+
+	if (reg < 16) {
+		if (reg)
+			regs->u_regs[reg] = val;
+		return 0;
+	}
+	win = (struct reg_window32 __user *)regs->u_regs[UREG_FP];
+	return put_user(val, &win->locals[reg - 16]);
+}
+
+#endif /* _SPARC_UNIMP_32_H */
-- 
2.47.3

