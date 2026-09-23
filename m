Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A3F57D228
	for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194765; cv=none; b=XU1+ZtPZYuj4xShQcowTmtvGDN4YiHRt2CU+/pXHzt+nFHrWEnWPF6IGVoAvkL2k2CQcbre7sdl6k64O1kDIBHrnxTLaJ4JfihcUr4Wna3m0gw3F0xHbEi1dPwCZOYqi5D6dHmGUS6OSWsEB4MpPdtR4JyPVLY5hPyPsZLsI0vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194765; c=relaxed/simple;
	bh=0wHYlVgoasAY1JmiSfypx9MtD3RKd0J6iTU414lX8cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASnlu3YI2NABJywpl3w9FrAhtXxXq6sK/9stm95mDOb2cMYWRN+TNecyB4YteyyfETIHSGDXkUjpTN0GxEnUooMEJF8VVH5j9XOMObgF/mVpwd7RwqBaMpDSGVfrx5SUdH8zEKEkTg/V8tYn7sje7szELm+EvJ43kOVHbB6GjWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZV5K7zD; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZV5K7zD"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9a2b95b72so2406279a12.2
        for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 13:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790194758; x=1790799558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lWUnL6Dr5OR7XEBSMs9m8RHYhNUCxYmL/3WkiHTjwQE=;
        b=sZV5K7zD6WLwhp2aC7GFAOGLB2ULZgX+485VMLGElvKM70b1loMuAkWpXdLsRULQ2W
         mtCy9BRt26fN3kJbWn1qNOzJ9SoydYrl/YmYpYd6VIv+F6nhL9v2QkgVaswwH+MxA9AH
         13zkUDRVvFXaOquEZue9DJwdlwmVTmrFEmu7sNplaD6vkqaN8uRJ90xQqo5em9976SuR
         0Om/eKiz0qSTwEY1dfFZKiARhm5trw1/laMaGeTSTJJB+NDQqZb+Nsz2gVb/Gs6Zo1s+
         VGEixYIfsgQ/hUx9jzT7tqaajxKhr9EwaU/drXj0UUWZQWouICqwrG8x98YtraHvmko+
         zOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194758; x=1790799558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lWUnL6Dr5OR7XEBSMs9m8RHYhNUCxYmL/3WkiHTjwQE=;
        b=lePuxseA3vtlNNRw3kfUiNelnos1QjTFkniZn1YFMBsHoyzbXEFFsYGB9ICKM/WYmD
         HCOfo5JzJN18enP4q5Mcabf5QJ+/5bMYfQVv+zGlLm2UMs0MvlfC3LBkpiRGgfLAf6ud
         6ctOCoEsTAaJ8iQcOso0AguSPbMm59mMf2aF5IEtbot42rDLtxpkc3yH54w4r7G+Z6N3
         1SMYWUTPd03qdxo344ku0nUUzoF1OtiTiS4pngzvSTInUmDZmQjwRhqs4bW0UGda+pMV
         9pey+vtFYDmqtedLlGCP6SNwsiYavMdGsbARNOSw23e73+wLgeIuWE+Hjln7GGefiXba
         AGPA==
X-Forwarded-Encrypted: i=1; AKwUvBz5eSOK1gFV2kzi0w7X/vWA8GO8+GiYtUMQ1v8bsC2BM96vNerAC0+nK3tjIM6Nv0vyUYGYIpkw0Pxp@vger.kernel.org
X-Gm-Message-State: AFuF++kCufsKA0E+4ix6Y5uVkvIFxFZps64tcwmi7e14Y0AaIX4VP/X5
	RKQNCKiq+0iL1movhrUy95ftxeAH4JvvHzWbhzbde3bCTlB6FT3NfZhh
X-Gm-Gg: AYBFou22WfYwqc2MzIcd+GzpfbmW7Mw8o2/hEuLeU9nzJkaXRXtC9UV/hhX6qFMeDCs
	dzNjkl8ndt1p7JOHmHXaC+oEicbag5CgskT0XL+ya4mf5kwzCV1JCS+xFjBacrHqo3BpkCMH3oi
	6TG6rQV5zmWOjomg2G4tcdSoKetYZUnoJz6sOdGksCtDer3m8EicVvCl2L1cf40RtqE1uUH0XME
	wMlLI/LG09l4eu4+dx3PI0GCNJJf0SFYEeWkHn7WPcZJ2oc0Inl7t/XkQdtLnyBY0H5saui0Dsm
	xrXdn1R9ReeIg31vtQmJSCOAtZXhJK1JHsepYmCM+K1VqdiLF3cJulXz05bVnQYKKefkoS31vJE
	rwVLgBRMflYHZ7VUDJuXVAjj7+Sezh73rU6hmf+FM0XaNZsfBIMElV0dJ+y1sUThPBEDtIobnFx
	QbNvFSWxCj1Eq1h8zAzUWaGi4zRUHcaZcKOI0NX5Zc/I2sDMyFAQ68MqtiR4zmfJNM3FtWsWOM7
	XT1KyhSIxSu66PWRPH0uThnCdy0uQ2Nd+QXrHBG
X-Received: by 2002:a17:907:1c84:b0:c26:2f09:f2d8 with SMTP id a640c23a62f3a-c2ac2601042mr17491066b.36.1790194758486;
        Wed, 23 Sep 2026 13:19:18 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae63dc17sm183626966b.33.2026.09.23.13.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:19:18 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [RFC PATCH 1/5] sparc32: detect the compare-and-swap instruction at boot
Date: Wed, 23 Sep 2026 22:17:17 +0200
Message-ID: <20260923201830.865553-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923201830.865553-1-linmag7@gmail.com>
References: <20260923201830.865553-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some 32-bit sparc implementations provide the v9 compare-and-swap as an
extension, LEON3 does, plain v8 does not. Whether it is present decides
how a user word can be made atomic, and the kernel has to make the same
choice userspace made: a binary built for such a cpu uses casa inline, one
built for v8 cannot and asks the kernel instead. Both follow from the
hardware, so deciding on the hardware keeps them in step.

Probe by executing one compare-and-swap that must succeed and checking
that it did, rather than inferring support from the absence of a trap.  A
cpu without the instruction raises illegal_instruction, so
do_illegal_instruction() now looks for an exception table fixup before
dying, the way the data fault path already does; the same entry also
covers a faulting address later.

casa cannot appear in inline asm: sparc32 is built -Wa,-Av8, the assembler
rejects the instruction outright, and sparc gas has no .arch pseudo-op to
override that locally. It therefore lives in its own object assembled
-Wa,-Aleon, which adds the one instruction without letting the rest of v9
in.  This affects the assembler only, not what the compiler emits.

The helpers are laid out for the LEON atomic errata rather than detecting
them. GRLIB-TN-0011 wants the atomic 16-byte aligned, or an instruction
TLB miss can release the bus lock before the store completes;
GRLIB-TN-0010 forbids reaching one from a load or a control transfer,
which a call with a load in its delay slot does. A nop at the entry plus
nop padding to the boundary covers both, for less than runtime detection
would cost. The padding is spelled .balignl because a plain .align lets
the assembler branch over the gap, and that branch lands on the atomic -
exactly the sequence TN-0010 asks us to avoid.

The probe runs once, on the boot cpu, so an SMP machine whose cpus
disagree about the instruction is not supported. None is known.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/cas_32.h   | 10 +++++++++
 arch/sparc/include/asm/cpu_type.h |  7 +++++++
 arch/sparc/kernel/cpu.c           | 24 ++++++++++++++++++++++
 arch/sparc/kernel/traps_32.c      | 16 ++++++++++++++-
 arch/sparc/lib/Makefile           |  5 +++++
 arch/sparc/lib/casa_32.S          | 34 +++++++++++++++++++++++++++++++
 6 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 arch/sparc/include/asm/cas_32.h
 create mode 100644 arch/sparc/lib/casa_32.S

diff --git a/arch/sparc/include/asm/cas_32.h b/arch/sparc/include/asm/cas_32.h
new file mode 100644
index 000000000000..3658ff71fa70
--- /dev/null
+++ b/arch/sparc/include/asm/cas_32.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SPARC_CAS_32_H
+#define _SPARC_CAS_32_H
+
+#include <linux/types.h>
+
+/* Returns 0 and stores the value found in *prev, or -EFAULT. */
+int __sparc32_casa(u32 *addr, u32 oldval, u32 newval, u32 *prev);
+
+#endif /* _SPARC_CAS_32_H */
diff --git a/arch/sparc/include/asm/cpu_type.h b/arch/sparc/include/asm/cpu_type.h
index 2b59799859d1..c54e0abfdb2b 100644
--- a/arch/sparc/include/asm/cpu_type.h
+++ b/arch/sparc/include/asm/cpu_type.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_CPU_TYPE_H
 #define __ASM_CPU_TYPE_H
 
+#include <linux/types.h>
+
 /*
  * Sparc (general) CPU types
  */
@@ -18,6 +20,11 @@ enum sparc_cpu {
 #ifdef CONFIG_SPARC32
 extern enum sparc_cpu sparc_cpu_model;
 
+/* True where the cpu implements the v9 casa extension (LEON3 does, plain v8
+ * does not).  Probed once on the boot cpu.
+ */
+extern bool sparc32_has_casa;
+
 #define SUN4M_NCPUS            4              /* Architectural limit of sun4m. */
 
 #else
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 79cd6ccfeac0..e09c688a5fd3 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -21,6 +21,9 @@
 #include <asm/psr.h>
 #include <asm/mbus.h>
 #include <asm/cpudata.h>
+#ifdef CONFIG_SPARC32
+#include <asm/cas_32.h>
+#endif
 
 #include "kernel.h"
 #include "entry.h"
@@ -437,11 +440,32 @@ const struct seq_operations cpuinfo_op = {
 };
 
 #ifdef CONFIG_SPARC32
+bool sparc32_has_casa __ro_after_init;
+
+/* One compare-and-swap that must succeed: a cpu without casa traps and the
+ * exception table reports -EFAULT.
+ */
+static void __init casa_probe(void)
+{
+	static const u32 oldval = 0x600df00d;
+	static const u32 newval = 0x0badcafe;
+	u32 word = oldval;
+	u32 prev = 0;
+
+	if (!__sparc32_casa(&word, oldval, newval, &prev))
+		sparc32_has_casa = prev == oldval && word == newval;
+
+	pr_info("sparc32: compare-and-swap instruction %s\n",
+		sparc32_has_casa ? "present" : "not implemented");
+}
+
 static int __init cpu_type_probe(void)
 {
 	int psr_impl, psr_vers, fpu_vers;
 	int psr;
 
+	casa_probe();
+
 	psr_impl = ((get_psr() >> PSR_IMPL_SHIFT) & PSR_IMPL_SHIFTED_MASK);
 	psr_vers = ((get_psr() >> PSR_VERS_SHIFT) & PSR_VERS_SHIFTED_MASK);
 
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index bb149f6cc34b..85ae2fc143ec 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -20,6 +20,7 @@
 #include <linux/kdebug.h>
 #include <linux/export.h>
 #include <linux/pgtable.h>
+#include <linux/extable.h>
 
 #include <asm/delay.h>
 #include <asm/ptrace.h>
@@ -108,8 +109,21 @@ void do_hw_interrupt(struct pt_regs *regs, unsigned long type)
 void do_illegal_instruction(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 			    unsigned long psr)
 {
-	if(psr & PSR_PS)
+	if (psr & PSR_PS) {
+		const struct exception_table_entry *entry;
+
+		/*
+		 * An instruction this cpu does not implement can be probed
+		 * for deliberately, so honour a fixup before dying.
+		 */
+		entry = search_exception_tables(pc);
+		if (entry) {
+			regs->pc = entry->fixup;
+			regs->npc = regs->pc + 4;
+			return;
+		}
 		die_if_kernel("Kernel illegal instruction", regs);
+	}
 #ifdef TRAP_DEBUG
 	printk("Ill instr. at pc=%08lx instruction is %08lx\n",
 	       regs->pc, *(unsigned long *)regs->pc);
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index dd10cdd6f062..007d8e510ee8 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -12,6 +12,11 @@ lib-$(CONFIG_SPARC32) += blockops.o
 lib-y                 += memscan_$(BITS).o memcmp.o strncmp_$(BITS).o
 lib-$(CONFIG_SPARC32) += divdi3.o udivdi3.o
 lib-$(CONFIG_SPARC32) += copy_user.o locks.o
+lib-$(CONFIG_SPARC32) += casa_32.o
+
+# casa is not in v8, which the rest of sparc32 is assembled as.  -Aleon rather
+# than -Av9: it adds the one instruction without letting anything else v9 in.
+AFLAGS_casa_32.o += -Wa,-Aleon
 lib-$(CONFIG_SPARC64) += atomic_64.o
 lib-$(CONFIG_SPARC32) += lshrdi3.o ashldi3.o
 lib-$(CONFIG_SPARC32) += muldi3.o bitext.o
diff --git a/arch/sparc/lib/casa_32.S b/arch/sparc/lib/casa_32.S
new file mode 100644
index 000000000000..67df9ea439ce
--- /dev/null
+++ b/arch/sparc/lib/casa_32.S
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Compare-and-swap for the 32-bit sparc implementations that have it.
+ */
+
+#include <linux/linkage.h>
+#include <asm/errno.h>
+
+	.text
+	.align	4
+
+/* int __sparc32_casa(u32 *addr, u32 oldval, u32 newval, u32 *prev)
+ * Returns 0 and *prev, or -EFAULT.  ASI 0x0b is supervisor data.
+ */
+ENTRY(__sparc32_casa)
+	/* nop + .balignl: LEON errata GRLIB-TN-0010 and TN-0011. */
+	nop
+	.balignl 16, 0x01000000
+1:	casa	[%o0] 0x0b, %o1, %o2
+	st	%o2, [%o3]
+	retl
+	 clr	%o0
+ENDPROC(__sparc32_casa)
+
+	.section .fixup,#alloc,#execinstr
+	.align	4
+2:	retl
+	 mov	-EFAULT, %o0
+	.previous
+
+	.section __ex_table,#alloc
+	.align	4
+	.word	1b, 2b
+	.previous
-- 
2.43.0

