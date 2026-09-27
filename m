Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA932E612E;
	Sun, 27 Sep 2026 00:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790470771; cv=none; b=l7CYWT50qLZdjjHbgK/CAgW5i7CUdAirFrvwY/WB6XKlYL6fsAa0nQC0Mc55Phyl/zBk4SX2jA+wnfUwVfjZqxS0bAZTjICYPfbulw78UBo6TeLTrUuvciRO3yHbOPlQhGQOi5pnAyD8f7K3SsZNSDOPAaa4rHiaMSzvaL62nAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790470771; c=relaxed/simple;
	bh=AUM56UEpJlCdgHNmTfKk18s8xN43s9/I/WxFlNUSGf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dzv+1ChfT+whnEPZH7k8Yubt5uQKGbxG8C64V0OKlWNjelj4zwOoJ6N05L7OEUMzkJKjPhvKghiS1dZGzv7RnGSP8TF03TZmX+6DPzBmIzpwY0RF7i+iyo3L9UDfUd5+a3hGcWc8adokDRmBXWtp9Oe3AjVde1cg/JnNqaRMGas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G41wsI/d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G41wsI/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8671F00893;
	Sun, 27 Sep 2026 00:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790470769;
	bh=vFITZ6Bb1Yy1QG4PdHoSLnFmxfPvxS9PNjf9FffGMbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G41wsI/dgFhqnb8OcS2LLnzVI5+IgD27jtw9k54XoqQcVztWWC3XCNGz5L2XY+f7K
	 6iwuGNPL8JxKb1reV85EhUZ3ORtUlpE+nZT9zabZkj8RP7U2NItYpNSzJ2F55CBjSW
	 ux2hTIy2Q6BcCOCcmm3s/b/q59ZRryEsN3i95TXwuOcRxLPqmEDX6eIuX7qYT6QDq1
	 Qaa28ThdBH6U5CpqP5/tMuYRYh/8ARBzm+gZUd4I1EXcDQ9KIumzHTUpkjflRpvNvy
	 oMNdMfmT8NCnDFe5KTn13hqbq+kDdz/i9WmH1GyGd8uYOloPHhl7r5jivvLSmQVTNT
	 2mx6HmQ3cf0Ag==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 3/3] sparc32: emulate integer divide taken as illegal_instruction
Date: Sun, 27 Sep 2026 02:58:21 +0200
Message-ID: <20260927005821.8369-4-kaloz@kernel.org>
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

SuperSPARC and SuperSPARC-II implement a 52-bit by 32-bit integer divide
and raise illegal_instruction for udiv and sdiv when the 64-bit dividend
{Y, rs1} has significant bits above bit 51, as the SuperSPARC II
Addendum documents, so whether a divide traps depends on its operands.
gcc emits udiv under -mcpu=v8, including in libgcc's __udivdi3, so
64-bit division in user code on these CPUs dies with SIGILL.

Complete udiv and sdiv, and their -cc forms, from
do_illegal_instruction(), sharing the windowed-operand helpers with the
casa emulation. A CPU that executes the instruction never reaches the
handler, nor does a kernel-mode illegal instruction. A fault reading a
windowed operand raises SIGSEGV, as the casa emulation does. On overflow
the quotient saturates to 0xffffffff for udiv and to 0x7fffffff or
0x80000000 for sdiv, and the -cc forms set V, as the architecture
specifies.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/sparc/kernel/Makefile     |   1 +
 arch/sparc/kernel/div_emu_32.c | 127 +++++++++++++++++++++++++++++++++
 arch/sparc/kernel/entry.h      |   1 +
 arch/sparc/kernel/traps_32.c   |   3 +
 4 files changed, 132 insertions(+)
 create mode 100644 arch/sparc/kernel/div_emu_32.c

diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index fbea79a4ab58..43e15b46b8dd 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_SPARC32)   += systbls_32.o
 obj-y                   += time_$(BITS).o
 obj-$(CONFIG_SPARC32)   += windows.o
 obj-$(CONFIG_SPARC32)   += cas_emu_32.o
+obj-$(CONFIG_SPARC32)   += div_emu_32.o
 obj-y                   += cpu.o
 obj-$(CONFIG_SPARC32)   += devices.o
 obj-y                   += ptrace_$(BITS).o
diff --git a/arch/sparc/kernel/div_emu_32.c b/arch/sparc/kernel/div_emu_32.c
new file mode 100644
index 000000000000..208b4071a525
--- /dev/null
+++ b/arch/sparc/kernel/div_emu_32.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Imre Kaloz <kaloz@kernel.org>
+ *
+ * SuperSPARC and SuperSPARC-II implement a 52-bit by 32-bit integer divide
+ * and raise illegal_instruction for udiv and sdiv when the dividend {Y, rs1}
+ * has significant bits above bit 51. Complete those divides here.
+ *
+ * Format 3 (op = 2), op3 0x0e udiv, 0x0f sdiv, plus 0x10 for the forms that
+ * set %icc. {Y, rs1} / rs2 saturates on overflow and leaves Y alone.
+ */
+
+#include <linux/kernel.h>
+#include <linux/sched/signal.h>
+#include <linux/uaccess.h>
+#include <asm/ptrace.h>
+#include <asm/psr.h>
+
+#include "entry.h"
+#include "unimp_32.h"
+
+int try_emulate_div(struct pt_regs *regs, unsigned int insn)
+{
+	unsigned int op3, rd, rs1, rs2;
+	unsigned long r1, r2, result = 0;
+	int fault = 0, is_signed, cc, ovf = 0;
+
+	if ((insn >> 30) != 2)
+		return 0;
+	op3 = (insn >> 19) & 0x3f;
+	switch (op3) {
+	case 0x0e: case 0x0f: case 0x1e: case 0x1f:
+		break;
+	default:
+		return 0;
+	}
+	is_signed = op3 & 0x01;
+	cc = op3 & 0x10;
+
+	rd = (insn >> 25) & 0x1f;
+	rs1 = (insn >> 14) & 0x1f;
+	rs2 = (insn & (1 << 13)) ? 0 : (insn & 0x1f);
+
+	unimp_flush_windows(rs1, rs2, rd);
+
+	r1 = unimp_get_reg(rs1, regs, &fault);
+	if (insn & (1 << 13)) {			/* i == 1: sign-extended simm13 */
+		long simm = insn & 0x1fff;
+
+		if (simm & 0x1000)
+			simm |= ~0x1fffL;
+		r2 = (unsigned long)simm;
+	} else {
+		r2 = unimp_get_reg(rs2, regs, &fault);
+	}
+	if (fault) {
+		/* A windowed operand could not be read from the user stack. */
+		send_sig_fault(SIGSEGV, SEGV_MAPERR,
+			       (void __user *)regs->u_regs[UREG_FP], current);
+		return 1;
+	}
+
+	if ((unsigned int)r2 == 0) {
+		send_sig_fault(SIGFPE, FPE_INTDIV,
+			       (void __user *)regs->pc, current);
+		return 1;
+	}
+	if (is_signed) {
+		long long num = ((long long)(int)regs->y << 32) |
+				(unsigned int)r1;
+
+		/*
+		 * INT64_MIN / -1 is undefined in C; the quotient is +2^63,
+		 * a positive overflow.
+		 */
+		if (num == LLONG_MIN && (int)r2 == -1) {
+			result = 0x7fffffff;
+			ovf = 1;
+		} else {
+			long long q = num / (int)r2;
+
+			if (q > 2147483647LL) {
+				result = 0x7fffffff;
+				ovf = 1;
+			} else if (q < -2147483647LL - 1) {
+				result = 0x80000000;
+				ovf = 1;
+			} else {
+				result = (unsigned long)(unsigned int)q;
+			}
+		}
+	} else {
+		unsigned long long num =
+			((unsigned long long)(unsigned int)regs->y << 32) |
+			(unsigned int)r1;
+		unsigned long long q = num / (unsigned int)r2;
+
+		if (q > 0xffffffffULL) {
+			result = 0xffffffff;
+			ovf = 1;
+		} else {
+			result = (unsigned long)(unsigned int)q;
+		}
+	}
+
+	if (unimp_put_reg(rd, result, regs)) {
+		send_sig_fault(SIGSEGV, SEGV_MAPERR,
+			       (void __user *)regs->u_regs[UREG_FP], current);
+		return 1;
+	}
+
+	if (cc) {
+		unsigned long psr = regs->psr & ~PSR_ICC;
+
+		if (result & 0x80000000)
+			psr |= PSR_N;
+		if (result == 0)
+			psr |= PSR_Z;
+		if (ovf)
+			psr |= PSR_V;
+		regs->psr = psr;
+	}
+
+	regs->pc = regs->npc;
+	regs->npc += 4;
+	return 1;
+}
diff --git a/arch/sparc/kernel/entry.h b/arch/sparc/kernel/entry.h
index 2eb2b0be90df..4911cfd07d60 100644
--- a/arch/sparc/kernel/entry.h
+++ b/arch/sparc/kernel/entry.h
@@ -15,6 +15,7 @@ void do_hw_interrupt(struct pt_regs *regs, unsigned long type);
 void do_illegal_instruction(struct pt_regs *regs, unsigned long pc,
                             unsigned long npc, unsigned long psr);
 int try_emulate_casa(struct pt_regs *regs, unsigned int insn);
+int try_emulate_div(struct pt_regs *regs, unsigned int insn);
 
 void do_priv_instruction(struct pt_regs *regs, unsigned long pc,
                          unsigned long npc, unsigned long psr);
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index 69851b19766a..f9050dee0f1c 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -131,6 +131,9 @@ void do_illegal_instruction(struct pt_regs *regs, unsigned long pc, unsigned lon
 	if (!get_user(insn, (unsigned int __user *)pc)) {
 		if (try_emulate_casa(regs, insn))
 			return;
+		/* SuperSPARC traps divides wider than 52 bits. */
+		if (try_emulate_div(regs, insn))
+			return;
 	}
 
 	send_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)pc, current);
-- 
2.47.3

