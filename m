Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7673002A5;
	Fri, 15 Aug 2025 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254517; cv=none; b=mj/E8XLEIuZ+fM7pzIk3DU2DWiYr2J6Nx/tXNROd4xOVzvnfcA4EQr5DEda00vkeuEo3r4Q7bNV8vscfdXacpKdbJn9TVjW/H7r5QHffq42lTFMF8GieZ+q8TqX2pThNHR/Xk9cJIL9iTjAE69XM/Ikp5PCZLv4xFJX0JK+jkiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254517; c=relaxed/simple;
	bh=SJRaOguhTl/Tk5XbsGGzu50TtmtYidsEXowjFzTGB/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=syZSxxS1BdwwVlrYGQ5klldDmQD0dAFtTlkQXi0fgZVqhca6CN7c147+U+JIjKvYz6QZ8oS2j0+CFlr3yaPpLOY66Xt/wO7Yx3KyTXFlhmdWCWXcA2JNbWL69jms4PDtMM2Y7X1uSLmoakhlhkqyk7ro0p2SJ42owDckVsiqk9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WGuydQO8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ijcCssBe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WGuydQO8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ijcCssBe"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755254513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XEoztOX42ZPvrRbI5LNX79Yd84LWhBUqfG54KTkC4Qo=;
	b=WGuydQO8WVMd28MwRGcOrycehqTfwI2l21GBtoJhvzZJRktKbPEpqNU3IklsPDbYdGOUt/
	5Iwm+1IDJUA5QOBVRbCokyV1OqZwZI/Ok6EpU3gpaIRuOo2iURZRY0yqr/YGMAaOK/9ROu
	yo8m+vmULoapZM5/2aqICo01Su8vBnFlt0Wz9rWhmifweKH8LgyJ6P6q684mAyOl3u+A5E
	iI5lq5TL0tPXNgxWC4v2tzbF5DmB4FyI2Em9+vwpJpu71oAOykpNkBVtTVfdK2ncRLFNnk
	wHM9el7pidDf7PgpRQL2Q5nNrtJbd5nXGa2sjYbVG84YkmtERRuyHBDZGgfWMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755254513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XEoztOX42ZPvrRbI5LNX79Yd84LWhBUqfG54KTkC4Qo=;
	b=ijcCssBeGbrCfA2++LsHFH9crCdGORv6SQqZsL/qV6OfnkMtd86GDcbpBWXdPsq0F1UQkk
	15SipwgYQ7aY52Cg==
Date: Fri, 15 Aug 2025 12:41:16 +0200
Subject: [PATCH v2 07/13] sparc64: vdso: Introduce vdso/processor.h
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250815-vdso-sparc64-generic-2-v2-7-b5ff80672347@linutronix.de>
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
In-Reply-To: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755254507; l=4619;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=SJRaOguhTl/Tk5XbsGGzu50TtmtYidsEXowjFzTGB/o=;
 b=pPDKyV+wOXXRexlKU9+bFxSZgq+GcJUqIVX9hqOIUKnYT/vG228rwVvPwW8yJ96o0WfB38vRy
 eV59Q+PyniYDO44OL3UTz0RoycRZi3tuy6Fph99Ru/DXniIZLIhVDwg
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic vDSO library expects a vdso/processor.h with an definition of
cpu_relax().

Split out cpu_relax() into this dedicated header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/include/asm/processor.h      |  3 +++
 arch/sparc/include/asm/processor_32.h   |  2 --
 arch/sparc/include/asm/processor_64.h   | 25 --------------------
 arch/sparc/include/asm/vdso/processor.h | 41 +++++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/arch/sparc/include/asm/processor.h b/arch/sparc/include/asm/processor.h
index 18295ea625dd7271617c15caa003a173099dd4d0..e34de956519aaca0e9bf82a22000d9096f868968 100644
--- a/arch/sparc/include/asm/processor.h
+++ b/arch/sparc/include/asm/processor.h
@@ -1,6 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef ___ASM_SPARC_PROCESSOR_H
 #define ___ASM_SPARC_PROCESSOR_H
+
+#include <asm/vdso/processor.h>
+
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm/processor_64.h>
 #else
diff --git a/arch/sparc/include/asm/processor_32.h b/arch/sparc/include/asm/processor_32.h
index ba8b70ffec085feb17de9050f37de98e0039f7c3..a074d313f4f80621c1bc42733529c6d9450b1275 100644
--- a/arch/sparc/include/asm/processor_32.h
+++ b/arch/sparc/include/asm/processor_32.h
@@ -91,8 +91,6 @@ unsigned long __get_wchan(struct task_struct *);
 extern struct task_struct *last_task_used_math;
 int do_mathemu(struct pt_regs *regs, struct task_struct *fpt);
 
-#define cpu_relax()	barrier()
-
 extern void (*sparc_idle)(void);
 
 #endif
diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
index 0a0d5c3d184c751d232a00e73357c0e345695a94..3de65ad6d78592013b1d1158a58497f3821d003c 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -182,31 +182,6 @@ unsigned long __get_wchan(struct task_struct *task);
 #define KSTK_EIP(tsk)  (task_pt_regs(tsk)->tpc)
 #define KSTK_ESP(tsk)  (task_pt_regs(tsk)->u_regs[UREG_FP])
 
-/* Please see the commentary in asm/backoff.h for a description of
- * what these instructions are doing and how they have been chosen.
- * To make a long story short, we are trying to yield the current cpu
- * strand during busy loops.
- */
-#ifdef	BUILD_VDSO
-#define	cpu_relax()	asm volatile("\n99:\n\t"			\
-				     "rd	%%ccr, %%g0\n\t"	\
-				     "rd	%%ccr, %%g0\n\t"	\
-				     "rd	%%ccr, %%g0\n\t"	\
-				     ::: "memory")
-#else /* ! BUILD_VDSO */
-#define cpu_relax()	asm volatile("\n99:\n\t"			\
-				     "rd	%%ccr, %%g0\n\t"	\
-				     "rd	%%ccr, %%g0\n\t"	\
-				     "rd	%%ccr, %%g0\n\t"	\
-				     ".section	.pause_3insn_patch,\"ax\"\n\t"\
-				     ".word	99b\n\t"		\
-				     "wr	%%g0, 128, %%asr27\n\t"	\
-				     "nop\n\t"				\
-				     "nop\n\t"				\
-				     ".previous"			\
-				     ::: "memory")
-#endif
-
 /* Prefetch support.  This is tuned for UltraSPARC-III and later.
  * UltraSPARC-I will treat these as nops, and UltraSPARC-II has
  * a shallower prefetch queue than later chips.
diff --git a/arch/sparc/include/asm/vdso/processor.h b/arch/sparc/include/asm/vdso/processor.h
new file mode 100644
index 0000000000000000000000000000000000000000..f7a9adc807f7c9a0444afa51aeb47649a9bdb079
--- /dev/null
+++ b/arch/sparc/include/asm/vdso/processor.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_SPARC_VDSO_PROCESSOR_H
+#define _ASM_SPARC_VDSO_PROCESSOR_H
+
+#include <linux/compiler.h>
+
+#if defined(__arch64__)
+
+/* Please see the commentary in asm/backoff.h for a description of
+ * what these instructions are doing and how they have been chosen.
+ * To make a long story short, we are trying to yield the current cpu
+ * strand during busy loops.
+ */
+#ifdef	BUILD_VDSO
+#define	cpu_relax()	asm volatile("\n99:\n\t"			\
+				     "rd	%%ccr, %%g0\n\t"	\
+				     "rd	%%ccr, %%g0\n\t"	\
+				     "rd	%%ccr, %%g0\n\t"	\
+				     ::: "memory")
+#else /* ! BUILD_VDSO */
+#define cpu_relax()	asm volatile("\n99:\n\t"			\
+				     "rd	%%ccr, %%g0\n\t"	\
+				     "rd	%%ccr, %%g0\n\t"	\
+				     "rd	%%ccr, %%g0\n\t"	\
+				     ".section	.pause_3insn_patch,\"ax\"\n\t"\
+				     ".word	99b\n\t"		\
+				     "wr	%%g0, 128, %%asr27\n\t"	\
+				     "nop\n\t"				\
+				     "nop\n\t"				\
+				     ".previous"			\
+				     ::: "memory")
+#endif /* BUILD_VDSO */
+
+#else /* ! __arch64__ */
+
+#define cpu_relax()	barrier()
+
+#endif /* __arch64__ */
+
+#endif /* _ASM_SPARC_VDSO_PROCESSOR_H */

-- 
2.50.1

