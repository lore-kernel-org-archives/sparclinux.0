Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C24847ACF8;
	Wed, 23 Sep 2026 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154292; cv=none; b=ruA6yMCwotVHGWltQRnaUS2yhmz+iqpKt1Rj3xI6YFVYzgdGbBeUEerX6XfX1uY5Gj25uShbpnqXinMf0asSUm5gdoEMipN5TrPENaezUN41xCRpbsqXWmspMILQ1ESkim8U3l6hVy+/10rXzKlLlUNrcudNHpLtFVC/J3tOlR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154292; c=relaxed/simple;
	bh=cxgetAdP1Sx1ujJnO5LBiKiGZ+DDeQyEAcve0PRNeYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMhiOidYNWdr6RiPGDiWXC1FcqGR87aFXxUWxeRkz2v/MXAyvXxJ7SxByl3HfQExya+mHMXkwXGP/oD2iMyCZ6eKJDVmCaJKjfQRrjkJR/JZDMmyCUw0eMJYlJzNGGYuGxqa00p66IJNb50f/KCREcyy01E1+i7N/agCF2CFlcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=j5KeeO56; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="j5KeeO56"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790154287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcARCW0fuNDHJ8brXMYCmROpjUHy2tGOJ3XYiDITMp0=;
	b=j5KeeO56WMTt7d3r1OjG7MCuUIr5V52qtGFMJab9DMzYmLcu3Vdnp3DTJgh7T0chRD+gt9
	NQEKiWa0BOB55CqjjhqqcrRXqCWyX8S8nOvl1eQ9HsSFY1CMYOt1Y49Tx47fOH7lnPczG1
	cpvqcv0JrdbUKx9sHcCUTX/TbMy9l6Y=
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
Subject: [RFC PATCH v3 3/3] perf tools: Support sparc user register samples and dwarf unwinding
Date: Wed, 23 Sep 2026 11:04:28 +0200
Message-ID: <20260923090429.2026529-4-stian@itx.no>
In-Reply-To: <20260923090429.2026529-1-stian@itx.no>
References: <20260923090429.2026529-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the sparc perf_regs tables and the EM_SPARC/EM_SPARCV9 dispatch for
register names, masks, ip/sp and the perf-to-DWARF register mapping,
plus the uapi header copy.

For libdw unwinding, seed DWARF registers 16-31 (%l0-%l7, %i0-%i7) from
the register save area at the start of the stack dump: the kernel
flushes the sampled window there, and the CFI after `save` needs %i6
and %i7 to find the first caller. The dump of a 64-bit sparc stack
starts at %sp + 2047, so memory_read() takes its base from there.

Signed-off-by: Stian Halseth <stian@itx.no>
---
 tools/arch/sparc/include/uapi/asm/perf_regs.h | 34 ++++++++++
 tools/perf/arch/sparc/include/perf_regs.h     | 18 +++++
 tools/perf/check-headers.sh                   |  1 +
 tools/perf/util/dwarf-regs-arch/Build         |  1 +
 .../util/dwarf-regs-arch/dwarf-regs-sparc.c   | 12 ++++
 tools/perf/util/dwarf-regs.c                  |  4 ++
 tools/perf/util/include/dwarf-regs.h          |  1 +
 tools/perf/util/perf-regs-arch/Build          |  1 +
 .../util/perf-regs-arch/perf_regs_sparc.c     | 67 +++++++++++++++++++
 tools/perf/util/perf_regs.c                   | 18 +++++
 tools/perf/util/perf_regs.h                   |  5 ++
 tools/perf/util/unwind-libdw.c                | 37 ++++++++++
 12 files changed, 199 insertions(+)
 create mode 100644 tools/arch/sparc/include/uapi/asm/perf_regs.h
 create mode 100644 tools/perf/arch/sparc/include/perf_regs.h
 create mode 100644 tools/perf/util/dwarf-regs-arch/dwarf-regs-sparc.c
 create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_sparc.c

diff --git a/tools/arch/sparc/include/uapi/asm/perf_regs.h b/tools/arch/sparc/include/uapi/asm/perf_regs.h
new file mode 100644
index 000000000000..0621ffbdafce
--- /dev/null
+++ b/tools/arch/sparc/include/uapi/asm/perf_regs.h
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
diff --git a/tools/perf/arch/sparc/include/perf_regs.h b/tools/perf/arch/sparc/include/perf_regs.h
new file mode 100644
index 000000000000..493fbff9ea16
--- /dev/null
+++ b/tools/perf/arch/sparc/include/perf_regs.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ARCH_PERF_REGS_H
+#define ARCH_PERF_REGS_H
+
+#include <stdlib.h>
+#include <linux/types.h>
+#include "../../../../arch/sparc/include/uapi/asm/perf_regs.h"
+
+#define PERF_REGS_MASK	((1ULL << PERF_REG_SPARC_MAX) - 1)
+#define PERF_REGS_MAX	PERF_REG_SPARC_MAX
+
+#ifdef __arch64__
+#define PERF_SAMPLE_REGS_ABI	PERF_SAMPLE_REGS_ABI_64
+#else
+#define PERF_SAMPLE_REGS_ABI	PERF_SAMPLE_REGS_ABI_32
+#endif
+
+#endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 531c0e0e84df..f144590f5082 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -42,6 +42,7 @@ declare -a FILES=(
   "arch/mips/include/uapi/asm/perf_regs.h"
   "arch/powerpc/include/uapi/asm/perf_regs.h"
   "arch/s390/include/uapi/asm/perf_regs.h"
+  "arch/sparc/include/uapi/asm/perf_regs.h"
   "arch/x86/include/uapi/asm/perf_regs.h"
   "arch/x86/include/uapi/asm/kvm.h"
   "arch/x86/include/uapi/asm/svm.h"
diff --git a/tools/perf/util/dwarf-regs-arch/Build b/tools/perf/util/dwarf-regs-arch/Build
index ceb68ae86fd8..bda944029046 100644
--- a/tools/perf/util/dwarf-regs-arch/Build
+++ b/tools/perf/util/dwarf-regs-arch/Build
@@ -6,4 +6,5 @@ perf-util-$(CONFIG_LIBDW) += dwarf-regs-mips.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-powerpc.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-riscv.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-s390.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-sparc.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-sparc.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-sparc.c
new file mode 100644
index 000000000000..a5af1e1d8b8b
--- /dev/null
+++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-sparc.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <dwarf-regs.h>
+#include "../../../arch/sparc/include/uapi/asm/perf_regs.h"
+
+int __get_dwarf_regnum_for_perf_regnum_sparc(int perf_regnum)
+{
+	if (perf_regnum < PERF_REG_SPARC_G1 || perf_regnum > PERF_REG_SPARC_O7)
+		return -ENOENT;
+
+	return perf_regnum;
+}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 797f455eba0d..df9200c31aaa 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -217,6 +217,10 @@ int get_dwarf_regnum_for_perf_regnum(int perf_regnum, unsigned int machine,
 	case EM_S390:
 		reg = __get_dwarf_regnum_for_perf_regnum_s390(perf_regnum);
 		break;
+	case EM_SPARC:
+	case EM_SPARCV9:
+		reg = __get_dwarf_regnum_for_perf_regnum_sparc(perf_regnum);
+		break;
 	case EM_LOONGARCH:
 		reg = __get_dwarf_regnum_for_perf_regnum_loongarch(perf_regnum);
 		break;
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 46a764cf322f..4a02f30c5604 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -113,6 +113,7 @@ int __get_dwarf_regnum_for_perf_regnum_loongarch(int perf_regnum);
 int __get_dwarf_regnum_for_perf_regnum_powerpc(int perf_regnum);
 int __get_dwarf_regnum_for_perf_regnum_riscv(int perf_regnum);
 int __get_dwarf_regnum_for_perf_regnum_s390(int perf_regnum);
+int __get_dwarf_regnum_for_perf_regnum_sparc(int perf_regnum);
 int __get_dwarf_regnum_for_perf_regnum_mips(int perf_regnum);
 
 /*
diff --git a/tools/perf/util/perf-regs-arch/Build b/tools/perf/util/perf-regs-arch/Build
index be95402aa540..47220a2f2dae 100644
--- a/tools/perf/util/perf-regs-arch/Build
+++ b/tools/perf/util/perf-regs-arch/Build
@@ -6,4 +6,5 @@ perf-util-y += perf_regs_mips.o
 perf-util-y += perf_regs_powerpc.o
 perf-util-y += perf_regs_riscv.o
 perf-util-y += perf_regs_s390.o
+perf-util-y += perf_regs_sparc.o
 perf-util-y += perf_regs_x86.o
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_sparc.c b/tools/perf/util/perf-regs-arch/perf_regs_sparc.c
new file mode 100644
index 000000000000..9ee8e496ab8c
--- /dev/null
+++ b/tools/perf/util/perf-regs-arch/perf_regs_sparc.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "../perf_regs.h"
+#include "../../arch/sparc/include/perf_regs.h"
+
+uint64_t __perf_reg_mask_sparc(bool intr __maybe_unused)
+{
+	return PERF_REGS_MASK;
+}
+
+const char *__perf_reg_name_sparc(int id)
+{
+	switch (id) {
+	case PERF_REG_SPARC_PC:
+		return "pc";
+	case PERF_REG_SPARC_G1:
+		return "g1";
+	case PERF_REG_SPARC_G2:
+		return "g2";
+	case PERF_REG_SPARC_G3:
+		return "g3";
+	case PERF_REG_SPARC_G4:
+		return "g4";
+	case PERF_REG_SPARC_G5:
+		return "g5";
+	case PERF_REG_SPARC_G6:
+		return "g6";
+	case PERF_REG_SPARC_G7:
+		return "g7";
+	case PERF_REG_SPARC_O0:
+		return "o0";
+	case PERF_REG_SPARC_O1:
+		return "o1";
+	case PERF_REG_SPARC_O2:
+		return "o2";
+	case PERF_REG_SPARC_O3:
+		return "o3";
+	case PERF_REG_SPARC_O4:
+		return "o4";
+	case PERF_REG_SPARC_O5:
+		return "o5";
+	case PERF_REG_SPARC_O6:
+		return "sp";
+	case PERF_REG_SPARC_O7:
+		return "o7";
+	case PERF_REG_SPARC_TSTATE:
+		return "tstate";
+	case PERF_REG_SPARC_NPC:
+		return "npc";
+	case PERF_REG_SPARC_Y:
+		return "y";
+	default:
+		return NULL;
+	}
+
+	return NULL;
+}
+
+uint64_t __perf_reg_ip_sparc(void)
+{
+	return PERF_REG_SPARC_PC;
+}
+
+uint64_t __perf_reg_sp_sparc(void)
+{
+	return PERF_REG_SPARC_O6;
+}
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 558c143abbab..5880b54fd7dc 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -68,6 +68,10 @@ uint64_t perf_intr_reg_mask(uint16_t e_machine)
 	case EM_S390:
 		mask = __perf_reg_mask_s390(/*intr=*/true);
 		break;
+	case EM_SPARC:
+	case EM_SPARCV9:
+		mask = __perf_reg_mask_sparc(/*intr=*/true);
+		break;
 	case EM_386:
 	case EM_X86_64:
 		mask = __perf_reg_mask_x86(/*intr=*/true);
@@ -111,6 +115,10 @@ uint64_t perf_user_reg_mask(uint16_t e_machine)
 	case EM_S390:
 		mask = __perf_reg_mask_s390(/*intr=*/false);
 		break;
+	case EM_SPARC:
+	case EM_SPARCV9:
+		mask = __perf_reg_mask_sparc(/*intr=*/false);
+		break;
 	case EM_386:
 	case EM_X86_64:
 		mask = __perf_reg_mask_x86(/*intr=*/false);
@@ -154,6 +162,10 @@ const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags)
 	case EM_S390:
 		reg_name = __perf_reg_name_s390(id);
 		break;
+	case EM_SPARC:
+	case EM_SPARCV9:
+		reg_name = __perf_reg_name_sparc(id);
+		break;
 	case EM_386:
 	case EM_X86_64:
 		reg_name = __perf_reg_name_x86(id);
@@ -215,6 +227,9 @@ uint64_t perf_arch_reg_ip(uint16_t e_machine)
 		return __perf_reg_ip_riscv();
 	case EM_S390:
 		return __perf_reg_ip_s390();
+	case EM_SPARC:
+	case EM_SPARCV9:
+		return __perf_reg_ip_sparc();
 	case EM_386:
 	case EM_X86_64:
 		return __perf_reg_ip_x86();
@@ -244,6 +259,9 @@ uint64_t perf_arch_reg_sp(uint16_t e_machine)
 		return __perf_reg_sp_riscv();
 	case EM_S390:
 		return __perf_reg_sp_s390();
+	case EM_SPARC:
+	case EM_SPARCV9:
+		return __perf_reg_sp_sparc();
 	case EM_386:
 	case EM_X86_64:
 		return __perf_reg_sp_x86();
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index 79be2b791509..3f453d910aa4 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -65,6 +65,11 @@ uint64_t __perf_reg_ip_s390(void);
 uint64_t __perf_reg_sp_s390(void);
 int __perf_sdt_arg_parse_op_s390(char *old_op, char **new_op);
 
+uint64_t __perf_reg_mask_sparc(bool intr);
+const char *__perf_reg_name_sparc(int id);
+uint64_t __perf_reg_ip_sparc(void);
+uint64_t __perf_reg_sp_sparc(void);
+
 int __perf_sdt_arg_parse_op_x86(char *old_op, char **new_op);
 uint64_t __perf_reg_mask_x86(bool intr);
 const char *__perf_reg_name_x86(int id);
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 63a5c2253174..d2adf7f2d8bb 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -4,7 +4,9 @@
 #include <elfutils/libdw.h>
 #include <elfutils/libdwfl.h>
 #include <inttypes.h>
+#include <elf.h>
 #include <errno.h>
+#include <string.h>
 #include "debug.h"
 #include "dso.h"
 #include <dwarf-regs.h>
@@ -225,6 +227,14 @@ static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
 	return -1;
 }
 
+/* A 64-bit sparc stack (odd %sp) is biased; its dump starts past the bias. */
+static u64 stack_dump_start(uint16_t e_machine, u64 sp)
+{
+	if ((e_machine == EM_SPARC || e_machine == EM_SPARCV9) && (sp & 1))
+		return sp + 2047;
+	return sp;
+}
+
 static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwarf_Word *result,
 			void *arg)
 {
@@ -243,6 +253,7 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwarf_Word *
 	if (ret)
 		return false;
 
+	start = stack_dump_start(ui->e_machine, start);
 	end = start + stack->size;
 
 	/* Check overflow. */
@@ -267,6 +278,26 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwarf_Word *
 	return true;
 }
 
+/*
+ * The sampled window's %l and %i registers (DWARF 16-31) are not in the
+ * sample; the kernel flushed them to the register save area at the start
+ * of the dumped stack.
+ */
+static void libdw_set_sparc_window_registers(struct unwind_info *ui,
+					     struct regs_dump *user_regs,
+					     Dwarf_Word *dwarf_regs)
+{
+	struct stack_dump *stack = &ui->sample->user_stack;
+	u64 sp;
+
+	if (perf_reg_value(&sp, user_regs, perf_arch_reg_sp(ui->e_machine)))
+		return;
+	if (!(sp & 1) || 16 * sizeof(u64) > stack->size)
+		return;
+
+	memcpy(&dwarf_regs[16], stack->data, 16 * sizeof(u64));
+}
+
 static bool libdw_set_initial_registers(Dwfl_Thread *thread, void *arg)
 {
 	struct dwfl_ui_thread_info *dwfl_ui_ti = arg;
@@ -276,6 +307,7 @@ static bool libdw_set_initial_registers(Dwfl_Thread *thread, void *arg)
 	int max_dwarf_reg = 0;
 	bool ret;
 	uint16_t e_machine = ui->e_machine;
+	bool is_sparc = e_machine == EM_SPARC || e_machine == EM_SPARCV9;
 	int e_flags = ui->e_flags;
 	uint64_t ip_perf_reg = perf_arch_reg_ip(e_machine);
 	Dwarf_Word val = 0;
@@ -295,6 +327,9 @@ static bool libdw_set_initial_registers(Dwfl_Thread *thread, void *arg)
 				max_dwarf_reg = dwarf_reg;
 		}
 	}
+	/* libdw_set_sparc_window_registers() fills DWARF 16-31. */
+	if (is_sparc && max_dwarf_reg < 31)
+		max_dwarf_reg = 31;
 
 	dwarf_regs = calloc(max_dwarf_reg + 1, sizeof(*dwarf_regs));
 	if (!dwarf_regs)
@@ -313,6 +348,8 @@ static bool libdw_set_initial_registers(Dwfl_Thread *thread, void *arg)
 			}
 		}
 	}
+	if (is_sparc)
+		libdw_set_sparc_window_registers(ui, user_regs, dwarf_regs);
 	if (perf_reg_value(&val, user_regs, ip_perf_reg) == 0)
 		dwfl_thread_state_register_pc(thread, val);
 
-- 
2.55.0

