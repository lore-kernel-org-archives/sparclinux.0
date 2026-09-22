Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9A554936E;
	Tue, 22 Sep 2026 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085446; cv=none; b=Lp/6IKzzAGEpy8tWYRdwSvcJjn/oVqYsRSy4BFObECwd5skxCfQI/XXD6iCwfBdMT00RAdP3rNJotq/q+WGBDXlwrdoaMRnmavLZdnuWJQ/zo+IyNSK2v1iThJDyBg8tmRcAJQiMN7HeWS4O3wVhKXs0gUiKIt6R1a08JphThCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085446; c=relaxed/simple;
	bh=pN/M8AdJGfApBsIjohsqKZc+u7W0H3nuc7qL18S2QCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riPJyKIZ3GYq2iRwYp4x5s88/15ogywCdrtvke2BpEUbgUVGZXDQMhWefljFSvd78F7zJvTu+ioN0hw4UcmKQV7C8IM7t95RJdLyr79V/vxzBYJjVEPlUECxMGxVIBnp2ktRhmYEubwIi2D5V/61wcnZbv82ouAsxWGPYT7HV+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=DE+bxE3Y; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="DE+bxE3Y"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790085436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PsXtLsCdtkC02MuBzxmxbitWNwPTeetSeVoh7aihcE=;
	b=DE+bxE3Y8ObbpBY+xv0grmMMkKqIR6J2HRqDDie1LUj09UydY6Lpy0BbBjLjuxvB4FkzGC
	PSb7mznBGG+EmmdgetOTpCkXXrt4r6BKp106wl6EGmWF7IRn2O+BPEEKutkilpRJ07pTtD
	VO9EdZ59gZTo9yT7Kg09cUCzuEYzmlo=
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [RFC PATCH 2/2] sparc64: Support PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER
Date: Tue, 22 Sep 2026 15:56:53 +0200
Message-ID: <20260922135653.1622301-3-stian@itx.no>
In-Reply-To: <20260922135653.1622301-1-stian@itx.no>
References: <20260922135653.1622301-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Select HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP and add the
perf_regs implementation. The exposed registers mirror struct pt_regs:
%g0-%g7, %o0-%o7 (named from the user's point of view; pt_regs calls
them UREG_I*), %tstate, PC, NPC and %y. %o6 is reported as held in the
register, i.e. with the 2047 stack bias for a 64-bit task, the same as
ptrace and user_stack_pointer(). Values of a 32-bit task are truncated
to 32 bits as genregs32_get() does, since the hardware does not
zero-extend them.

perf_arch_prepare_ustack() flushes the user register windows so the
sampled window's %l and %i registers are in the dumped stack, where a
DWARF unwinder needs them: the CFI of a function after `save` defines
the CFA in terms of %i6.

This makes perf record --call-graph dwarf and eu-stackprof usable on
sparc64.

Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/Kconfig                      |  2 +
 arch/sparc/include/asm/perf_event.h     |  3 ++
 arch/sparc/include/uapi/asm/perf_regs.h | 33 +++++++++++++
 arch/sparc/kernel/Makefile              |  2 +-
 arch/sparc/kernel/perf_regs.c           | 65 +++++++++++++++++++++++++
 5 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 arch/sparc/include/uapi/asm/perf_regs.h
 create mode 100644 arch/sparc/kernel/perf_regs.c

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index ab77d3f2536e..9d7f575f359d 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -93,6 +93,8 @@ config SPARC64
 	select RTC_DRV_SUN4V
 	select RTC_DRV_STARFIRE
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_REGS
+	select HAVE_PERF_USER_STACK_DUMP
 	select PERF_USE_VMALLOC
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select HAVE_C_RECORDMCOUNT
diff --git a/arch/sparc/include/asm/perf_event.h b/arch/sparc/include/asm/perf_event.h
index c2aec0c7f4f5..03f1ab1618b9 100644
--- a/arch/sparc/include/asm/perf_event.h
+++ b/arch/sparc/include/asm/perf_event.h
@@ -25,6 +25,9 @@ do {							\
 	(regs)->u_regs[UREG_I6] = _fp;			\
 	(regs)->u_regs[UREG_I7] = _i7;			\
 } while (0)
+
+void perf_arch_prepare_ustack(void);
+#define perf_arch_prepare_ustack	perf_arch_prepare_ustack
 #endif
 
 #endif
diff --git a/arch/sparc/include/uapi/asm/perf_regs.h b/arch/sparc/include/uapi/asm/perf_regs.h
new file mode 100644
index 000000000000..17f14335d6c0
--- /dev/null
+++ b/arch/sparc/include/uapi/asm/perf_regs.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_ASM_SPARC_PERF_REGS_H
+#define _UAPI_ASM_SPARC_PERF_REGS_H
+
+/*
+ * Mirrors struct pt_regs.  O6 is %sp as held in the register, i.e. biased
+ * by 2047 for a 64-bit task.
+ */
+enum perf_event_sparc_regs {
+	PERF_REG_SPARC_G0,
+	PERF_REG_SPARC_G1,
+	PERF_REG_SPARC_G2,
+	PERF_REG_SPARC_G3,
+	PERF_REG_SPARC_G4,
+	PERF_REG_SPARC_G5,
+	PERF_REG_SPARC_G6,
+	PERF_REG_SPARC_G7,
+	PERF_REG_SPARC_O0,
+	PERF_REG_SPARC_O1,
+	PERF_REG_SPARC_O2,
+	PERF_REG_SPARC_O3,
+	PERF_REG_SPARC_O4,
+	PERF_REG_SPARC_O5,
+	PERF_REG_SPARC_O6,
+	PERF_REG_SPARC_O7,
+	PERF_REG_SPARC_TSTATE,
+	PERF_REG_SPARC_PC,
+	PERF_REG_SPARC_NPC,
+	PERF_REG_SPARC_Y,
+	PERF_REG_SPARC_MAX
+};
+
+#endif /* _UAPI_ASM_SPARC_PERF_REGS_H */
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 497b5714fa8f..a3dd92247c3b 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -113,7 +113,7 @@ obj-$(CONFIG_AUDIT)     += audit.o
 audit--$(CONFIG_AUDIT)  := compat_audit.o
 obj-$(CONFIG_COMPAT)    += $(audit--y)
 
-pc--$(CONFIG_PERF_EVENTS) := perf_event.o
+pc--$(CONFIG_PERF_EVENTS) := perf_event.o perf_regs.o
 obj-$(CONFIG_SPARC64)	+= $(pc--y)
 
 obj-$(CONFIG_UPROBES)	+= uprobes.o
diff --git a/arch/sparc/kernel/perf_regs.c b/arch/sparc/kernel/perf_regs.c
new file mode 100644
index 000000000000..644a0a11cb90
--- /dev/null
+++ b/arch/sparc/kernel/perf_regs.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/perf_event.h>
+#include <linux/perf_regs.h>
+#include <linux/sched/task_stack.h>
+#include <asm/cacheflush.h>
+#include <asm/ptrace.h>
+
+u64 perf_reg_value(struct pt_regs *regs, int idx)
+{
+	u64 val;
+
+	switch (idx) {
+	case PERF_REG_SPARC_G0 ... PERF_REG_SPARC_O7:
+		val = regs->u_regs[idx];
+		break;
+	case PERF_REG_SPARC_TSTATE:
+		return regs->tstate;
+	case PERF_REG_SPARC_PC:
+		val = regs->tpc;
+		break;
+	case PERF_REG_SPARC_NPC:
+		val = regs->tnpc;
+		break;
+	case PERF_REG_SPARC_Y:
+		return regs->y;
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
+	if (test_thread_flag(TIF_32BIT))
+		val = (u32)val;
+
+	return val;
+}
+
+#define REG_RESERVED (~((1ULL << PERF_REG_SPARC_MAX) - 1))
+
+int perf_reg_validate(u64 mask)
+{
+	if (!mask || mask & REG_RESERVED)
+		return -EINVAL;
+
+	return 0;
+}
+
+u64 perf_reg_abi(struct task_struct *task)
+{
+	if (test_tsk_thread_flag(task, TIF_32BIT))
+		return PERF_SAMPLE_REGS_ABI_32;
+
+	return PERF_SAMPLE_REGS_ABI_64;
+}
+
+void perf_get_regs_user(struct perf_regs *regs_user,
+			struct pt_regs *regs)
+{
+	regs_user->regs = task_pt_regs(current);
+	regs_user->abi = perf_reg_abi(current);
+}
+
+void perf_arch_prepare_ustack(void)
+{
+	flushw_user();
+}
-- 
2.55.0

