Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FFA495029;
	Tue, 22 Sep 2026 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108140; cv=none; b=ffW0Wq2t5tdjKOLxRyKqsjDPH/v+m5Xd6JLDQCTefYq3WVrk88E1rY9AgzXxfo8mgxXgOrZlUy3qHK+AqUyg5sEeakvMN84JCmfPoKK8SNppHk2slj6FdkYHmf0yM7IMIAauK7jhwSi6jGKQolC7DyVLhC8jb4ap4y93l6fl73A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108140; c=relaxed/simple;
	bh=lhUx29EswnsXc0CtXm4KjouhRkqiGp3lYPwDGO9aLxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnlAOYDiHSGE4QaKkVsQArXPbvS+R6qPI+RxhNkj08qDmOEZ7O0MTwaz7tMGb04My2aLiDZYAPQih8Iku+GEJEMzKJ4z/zGXfPfBVBtfnVZu6/yiXc0n5fZYS6t3pkQtuL36qH+5kcrlCni+yVYNqpvoPl2Gsxgo5Tv168muwE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=L1jZey/1; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="L1jZey/1"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790108130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCjbmsJfQGQn+3BbHYLh/zVJrApu2LzN6m90GD2+p24=;
	b=L1jZey/1NvEWGM+zkTV8WXZIfYhdLFC/JwArpbHNOTGooQSvKP7MnEBN3a6cmXEWtwdeZx
	FmL4rOwPao73tSX+sZCjk9ArVN8QYHKsFiIMPTDcybrOC5D+Rmq0Edd+V8U0Plcz3/qAZd
	C18k850AqkFf7bH5rinru8wt/53JIYM=
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
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	linux-perf-users@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [RFC PATCH v2 2/3] sparc64: Support PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER
Date: Tue, 22 Sep 2026 22:15:06 +0200
Message-ID: <20260922201507.1719668-3-stian@itx.no>
In-Reply-To: <20260922201507.1719668-1-stian@itx.no>
References: <20260922201507.1719668-1-stian@itx.no>
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
them UREG_I*), %tstate, PC, NPC and %y.

%o6 is reported as held in the register, i.e. with the 2047 stack bias
for a 64-bit task, the same as ptrace and user_stack_pointer(). The
stack dump therefore also starts at the biased address, as consumers
of PERF_SAMPLE_STACK_USER expect the dump to begin at the sampled
stack pointer value; the first 2047 bytes lie below the frame, and a
sample whose %sp page is not mapped yet gets an empty dump, as on any
arch with a not-present stack page.

User-mode values of a 32-bit task are truncated to 32 bits as
genregs32_get() does, since the hardware does not zero-extend them.
Kernel-mode registers, as seen by PERF_SAMPLE_REGS_INTR, are left
alone.

perf_arch_prepare_ustack() flushes the user register windows so the
sampled window's %l and %i registers are in the dumped stack, where a
DWARF unwinder needs them: the CFI of a function after `save` defines
the CFA in terms of %i6.

This makes perf record --call-graph dwarf and eu-stackprof usable on
sparc64.

Signed-off-by: Stian Halseth <stian@itx.no>
---
 .../features/perf/perf-regs/arch-support.txt  |  2 +-
 .../perf/perf-stackdump/arch-support.txt      |  2 +-
 arch/sparc/Kconfig                            |  2 +
 arch/sparc/include/asm/perf_event.h           |  3 +
 arch/sparc/include/uapi/asm/perf_regs.h       | 33 ++++++++++
 arch/sparc/kernel/Makefile                    |  2 +-
 arch/sparc/kernel/perf_regs.c                 | 65 +++++++++++++++++++
 7 files changed, 106 insertions(+), 3 deletions(-)
 create mode 100644 arch/sparc/include/uapi/asm/perf_regs.h
 create mode 100644 arch/sparc/kernel/perf_regs.c

diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
index 4c9a5a012075..41ab622efa15 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -23,7 +23,7 @@
     |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: | TODO |
-    |       sparc: | TODO |
+    |       sparc: |  ok  |
     |          um: | TODO |
     |         x86: |  ok  |
     |      xtensa: | TODO |
diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
index dd362b5cb638..cafa6fae7704 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -23,7 +23,7 @@
     |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: | TODO |
-    |       sparc: | TODO |
+    |       sparc: |  ok  |
     |          um: | TODO |
     |         x86: |  ok  |
     |      xtensa: | TODO |
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
index 000000000000..726516abf5a7
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
+	if (user_mode(regs) && test_thread_flag(TIF_32BIT))
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

