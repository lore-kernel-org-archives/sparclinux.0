Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C10847ACED;
	Wed, 23 Sep 2026 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154292; cv=none; b=IfJ5MZ+m3VOvf0cV82hzMVnuq43dOaTs1bLZdmnBmnNFXb4BQJUVAaL5c7Hgh0i+2xB637sO/P1kmj+NlV6g+t6cd+RkPCfIcBrcHn628uOcRPorKB1nUtDoiQyxl6RoYXjDDPHdeMK7OMDQbz27qAwm8rEd8hVZH1Oe/9kyKb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154292; c=relaxed/simple;
	bh=MnrQ/UCLPgMJiD7M2IUEdTHDvWWbhXS16zP3MUuTmXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y83T/zVJgJw6xp1eGDvmtEiQGUypBAweP9nmt4QhSRSWoyjC6RhE5CEilmGq1hBSmKU9AsMEHGzYGuHzRJ6x3TNzTQXimBEXUybFz/Yi3O+0++iPZfahd7VeGLDfvJrG5mGpbmttSavikerabwqP6iN7DykNfaPuSoO3LFHf87Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=pdJVR1Ib; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="pdJVR1Ib"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790154287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RH3e8NuNIPbcQndfdh8xaIIhh/m+lM4txfgcsD5MlM=;
	b=pdJVR1IbUFruVgxUzoEamrAyij23T4L8NpCXabGaVJSlHcUH9K10jaiU3JeBFu24SB2Il5
	TmBMqhmG0LGjxFn+MjEYdvkDSpK+chuQtoYboMlD10TuGnLS2UAFtl5/99yd4h999kvX7z
	rIfKxJaAcLDYh/87YXJew9VRrhzQpis=
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
Subject: [RFC PATCH v3 2/3] sparc64: Support PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER
Date: Wed, 23 Sep 2026 11:04:27 +0200
Message-ID: <20260923090429.2026529-3-stian@itx.no>
In-Reply-To: <20260923090429.2026529-1-stian@itx.no>
References: <20260923090429.2026529-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Select HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP and add the
perf_regs implementation. The exposed registers mirror struct pt_regs:
%g1-%g7, %o0-%o7 (named from the user's point of view; pt_regs calls
them UREG_I*), %tstate, NPC and %y, with the PC in the slot of %g0, as
mips and loongarch do for their hardwired-zero register. Trap entry
does not save %g0, so its pt_regs slot holds stale stack contents for
a trap taken in the kernel and must not be exposed.

%o6 is reported as held in the register, i.e. with the 2047 stack bias
for a 64-bit stack, the same as ptrace and user_stack_pointer(). The
stack dump starts at the stack's actual address instead, %o6 + 2047
when test_thread_64bit_stack() says so, so that it begins at the
sampled frame; the uapi header documents this for consumers.

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
 arch/sparc/include/asm/perf_event.h           |  5 ++
 arch/sparc/include/uapi/asm/perf_regs.h       | 34 +++++++++
 arch/sparc/kernel/Makefile                    |  2 +-
 arch/sparc/kernel/perf_regs.c                 | 74 +++++++++++++++++++
 7 files changed, 118 insertions(+), 3 deletions(-)
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
index c2aec0c7f4f5..3e70c23e7714 100644
--- a/arch/sparc/include/asm/perf_event.h
+++ b/arch/sparc/include/asm/perf_event.h
@@ -25,6 +25,11 @@ do {							\
 	(regs)->u_regs[UREG_I6] = _fp;			\
 	(regs)->u_regs[UREG_I7] = _i7;			\
 } while (0)
+
+void perf_arch_prepare_ustack(void);
+#define perf_arch_prepare_ustack	perf_arch_prepare_ustack
+unsigned long perf_arch_user_stack_pointer(struct pt_regs *regs);
+#define perf_arch_user_stack_pointer	perf_arch_user_stack_pointer
 #endif
 
 #endif
diff --git a/arch/sparc/include/uapi/asm/perf_regs.h b/arch/sparc/include/uapi/asm/perf_regs.h
new file mode 100644
index 000000000000..0621ffbdafce
--- /dev/null
+++ b/arch/sparc/include/uapi/asm/perf_regs.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_ASM_SPARC_PERF_REGS_H
+#define _UAPI_ASM_SPARC_PERF_REGS_H
+
+/*
+ * Mirrors struct pt_regs, with the PC in the slot of the hardwired-zero
+ * %g0.  O6 is %sp as held in the register: for a 64-bit stack (odd O6)
+ * it is biased by 2047, and the PERF_SAMPLE_STACK_USER dump starts at
+ * O6 + 2047.
+ */
+enum perf_event_sparc_regs {
+	PERF_REG_SPARC_PC,
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
index 000000000000..8bcc3421ec19
--- /dev/null
+++ b/arch/sparc/kernel/perf_regs.c
@@ -0,0 +1,74 @@
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
+	case PERF_REG_SPARC_PC:
+		val = regs->tpc;
+		break;
+	case PERF_REG_SPARC_G1 ... PERF_REG_SPARC_O7:
+		val = regs->u_regs[idx];
+		break;
+	case PERF_REG_SPARC_TSTATE:
+		return regs->tstate;
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
+
+unsigned long perf_arch_user_stack_pointer(struct pt_regs *regs)
+{
+	unsigned long sp = user_stack_pointer(regs);
+
+	if (test_thread_64bit_stack(sp))
+		sp += STACK_BIAS;
+	return sp;
+}
-- 
2.55.0

