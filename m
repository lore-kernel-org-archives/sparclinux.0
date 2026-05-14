Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383B229D265
	for <sparclinux@vger.kernel.org>; Thu, 14 May 2026 04:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778732372; cv=none; b=M9oZhxYNwEE6H5VhVh8Zv/qqg+RBcrHoVsLma+VZ8UesWqtcoOPVSDZjZ631WMJ3X+AQX5O+Hq3kCwJKcQs/T4XRRLtwI+hi/tbBKtZidcrJXa8dfPdAh+W5xgVYf3DqTrgkLhOkSyo2m4zXpq1H0jSoTEj4ymmf6tgkmiEUxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778732372; c=relaxed/simple;
	bh=Il7z7k7VQb1Z9DWRPao3XDu1v9GZ4yn3chJmUj5ztw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gh2c8EAnfXsWYbohyPuflWs9K3I4xmi+ydPqSKCmNGM/aEwlR1fA31DQzty4UMnTbZCZQgooW4XVedRiYkTzgSpmId3HIg1tn0Rft9Rs7aubuRTN+zQpqDcGXlc9fYG61Oo2082P/sHpq3aDcL7oFMM3zFPcI1fwjfymcn3naAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=szsy54Nk; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szsy54Nk"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c80167f56cdso3139734a12.3
        for <sparclinux@vger.kernel.org>; Wed, 13 May 2026 21:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778732367; x=1779337167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OBQYCOUv5VS9R+Ac3hvFkNUoTr1w2023iigKlao48bA=;
        b=szsy54Nks0WJg7L2kGUjlAlI6pIOq44lhRujCOnZcG0I9HQ9dzoMUfvFtYmN1ZBjEt
         lGQyvH6N1ASZerdv7MpGgSOOHJIm/Qo2r9nPKGdbnwaD7PdlqKO9Oe9cdbWVrGSKLleq
         8UGhrHK0pWj1ysMoW/4dTPS8Yv69neia189BAuOI5MhGtjrZ5vY/ZiSbLd5qLG+2amP2
         hfu/gjqCGH5sBQEoJ/JOt9sJvrQSaJcnNx7WWZophgK63+UlLqtzALDYLne6qhWP93lj
         pGulZ5NWasAFq9bdv6Wy1LafwoUjeUBahe4nsQpEfD/41XR7Jf7GNXLHk7Ui8H7oTWRG
         oS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778732367; x=1779337167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBQYCOUv5VS9R+Ac3hvFkNUoTr1w2023iigKlao48bA=;
        b=kfSf5W3pAA5VbVlhWThJn1e2KOPti2ApYqkQIrbCwUjZ6UXcxasp/HJ+5Idqj++UtZ
         7Pw+x1ShsKfvbeq/LF8snGJoL+NfzVBn7EyTVyN9jswLEE3Y4YWJIhNsedocWPz7ekLa
         ycE7Tz4aHpnkBEgdwEdrk9RvQoHWLFuGk0vtIsX3d7rK+7ZT7R4SLVxKQS/FiHoF8qtU
         Hgy79sNSneV0Xw0aefMOnQT+VmfJSGvJ3/fFeWwBTKTTosLo5j0drGUj68ji7f+mszKr
         +ADrtZcDwko6RxKZeA5iHDr9GVf35vU5Tr3D2EWCIsYgbW50F29LZbwJEWm3HQfOkngP
         ddZg==
X-Gm-Message-State: AOJu0YwuP3zUmkDYBErJvxv9TNkuO6xdfqVgB0M/R57/1uzBITCU33s5
	kUa4ZeHtcUEjU90HB6lC0ez7gZwIOodxCouw3Z3A5EalHfy124IlF0wdpRMYzg==
X-Gm-Gg: Acq92OFZnmojXNCtPO1IigfVNqCMM8AjlmsXwAuhoMVuiByqc7n2vUPafYefShTRuJh
	gC3XmuignGnV81OTUjKxmNWxvf5ZW5jiUEt5TMfOU9nHC0TKUZJWI5dHJfXj5pwHWNZax60vZ2+
	BLn4YOqWnC8rhKLVagOMcnv64f+POKEhHMrr30oNapkWRSFX666WQz43Tn1pJF/irurz9jWjFDS
	4nzPt3Xeb55+seq9yE+szdStGGi4zuukTEVA09ABfknpRxcXb0V63aNEll6OzvuicJXXgwB1PnF
	s/1U9lzYb1BOP4WGcaqMMA/rli3pGdiFt4+Wy0JuUZIVcD9MQifOa3Eo9veM28E5dzpjiWD5XQ8
	Al1cHfID3IW/jmq9FTM0JYsURhjLCyW+/aDRfBRN2tgLmsIXWYdb+v/a93BB7ydidH2lgxgbthz
	KtSeNh7LzlhrWZvOVcggBYD5EZBFLW4/geE9+jcFO7NkSEEl8Lb5L7wgoXDVEmQa6XAQVr1DiCG
	aLbEO1vyn12HHpBtGqH8ExnaK5K1fm5u8E=
X-Received: by 2002:a05:6a21:e097:b0:39c:5624:ee53 with SMTP id adf61e73a8af0-3afaff1f3f3mr6580874637.24.1778732366518;
        Wed, 13 May 2026 21:19:26 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb121ccasm739878a12.29.2026.05.13.21.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 21:19:25 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Christian Brauner <brauner@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH] sparc: Avoid unsupported LLD branch relocations
Date: Wed, 13 May 2026 21:19:08 -0700
Message-ID: <20260514041908.874355-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LLD does not support several SPARC branch relocation types, including
R_SPARC_WDISP16, R_SPARC_WDISP19, and R_SPARC_WDISP22. A sparc64
allmodconfig LLVM build can therefore fail when trap table code and
low-level assembly leave branches to global symbols for the linker.

Use local labels for branches that stay within the same assembled
object so the assembler can resolve them directly. Convert the
remaining cross-object branches and tail calls to absolute set/jmpl
sequences, which LLD handles through the usual HI22/LO10 relocations.

Disable the unused sparc32 syscall trace entry points when compat
support is not built, and request sys_llseek for the native syscall
table so the LLD allmodconfig build remains self-contained.

Assisted-by: Codex:GPT-5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/sparc/include/asm/switch_to_64.h |   3 +-
 arch/sparc/include/asm/ttable.h       |  76 +++++++-------
 arch/sparc/include/asm/unistd.h       |   1 +
 arch/sparc/kernel/cherrs.S            |  28 ++---
 arch/sparc/kernel/dtlb_prot.S         |   2 +-
 arch/sparc/kernel/etrap_64.S          |  13 ++-
 arch/sparc/kernel/fpu_traps.S         |  11 +-
 arch/sparc/kernel/itlb_miss.S         |   2 +-
 arch/sparc/kernel/ktlb.S              |   4 +-
 arch/sparc/kernel/misctrap.S          |  18 ++--
 arch/sparc/kernel/rtrap_64.S          |  16 ++-
 arch/sparc/kernel/spiterrs.S          |  24 ++---
 arch/sparc/kernel/sun4v_ivec.S        |  16 +--
 arch/sparc/kernel/sun4v_mcd.S         |   3 +-
 arch/sparc/kernel/sun4v_tlb_miss.S    |  44 ++++----
 arch/sparc/kernel/syscalls.S          |  25 +++--
 arch/sparc/kernel/tsb.S               |  18 ++--
 arch/sparc/kernel/ttable_64.S         |   6 +-
 arch/sparc/kernel/urtt_fill.S         |  18 +++-
 arch/sparc/kernel/utrap.S             |   5 +-
 arch/sparc/kernel/winfixup.S          |  21 ++--
 arch/sparc/lib/GENbzero.S             |   3 +-
 arch/sparc/lib/GENcopy_from_user.S    |   8 +-
 arch/sparc/lib/GENcopy_to_user.S      |   8 +-
 arch/sparc/lib/M7copy_from_user.S     |   8 +-
 arch/sparc/lib/M7copy_to_user.S       |   8 +-
 arch/sparc/lib/Memcpy_utils.S         | 144 +++++++++++++-------------
 arch/sparc/lib/NG2copy_from_user.S    |   8 +-
 arch/sparc/lib/NG2copy_to_user.S      |   8 +-
 arch/sparc/lib/NG2memcpy.S            |  21 ++--
 arch/sparc/lib/NG4copy_from_user.S    |   8 +-
 arch/sparc/lib/NG4copy_to_user.S      |   8 +-
 arch/sparc/lib/NGbzero.S              |   3 +-
 arch/sparc/lib/NGcopy_from_user.S     |   8 +-
 arch/sparc/lib/NGcopy_to_user.S       |   8 +-
 arch/sparc/lib/NGmemcpy.S             |  37 +++----
 arch/sparc/lib/U1copy_from_user.S     |   8 +-
 arch/sparc/lib/U1copy_to_user.S       |   8 +-
 arch/sparc/lib/U3copy_to_user.S       |   8 +-
 arch/sparc/lib/memmove.S              |   6 +-
 arch/sparc/mm/ultra.S                 |  16 ++-
 41 files changed, 401 insertions(+), 287 deletions(-)

diff --git a/arch/sparc/include/asm/switch_to_64.h b/arch/sparc/include/asm/switch_to_64.h
index d93963ff7caa..b2b3f7e61a6a 100644
--- a/arch/sparc/include/asm/switch_to_64.h
+++ b/arch/sparc/include/asm/switch_to_64.h
@@ -45,13 +45,14 @@ do {	save_and_clear_fpu();						\
 	"ldx	[%%sp + 2047 + 0x78], %%i7\n\t"				\
 	"ldx	[%%g6 + %9], %%g4\n\t"					\
 	"wrpr	%%g0, 14, %%pil\n\t"					\
-	"brz,pt %%o7, switch_to_pc\n\t"					\
+	"brz,pt %%o7, 1f\n\t"						\
 	" mov	%%g7, %0\n\t"						\
 	"sethi	%%hi(ret_from_fork), %%g1\n\t"				\
 	"jmpl	%%g1 + %%lo(ret_from_fork), %%g0\n\t"			\
 	" nop\n\t"							\
 	".globl switch_to_pc\n\t"					\
 	"switch_to_pc:\n\t"						\
+	"1:\n\t"							\
 	: "=&r" (last), "=r" (current), "=r" (current_thread_info_reg),	\
 	  "=r" (__local_per_cpu_offset)					\
 	: "0" (task_thread_info(next)),					\
diff --git a/arch/sparc/include/asm/ttable.h b/arch/sparc/include/asm/ttable.h
index b32d3068cce1..abc4223386f5 100644
--- a/arch/sparc/include/asm/ttable.h
+++ b/arch/sparc/include/asm/ttable.h
@@ -24,30 +24,30 @@
 
 #define TRAP(routine)					\
 	sethi	%hi(109f), %g7;				\
-	ba,pt	%xcc, etrap;				\
+	ba,pt	%xcc, .Letrap;				\
 109:	 or	%g7, %lo(109b), %g7;			\
 	call	routine;				\
 	 add	%sp, PTREGS_OFF, %o0;			\
-	ba,pt	%xcc, rtrap;				\
+	ba,pt	%xcc, .Lrtrap;				\
 	 nop;						\
 	nop;
 
 #define TRAP_7INSNS(routine)				\
 	sethi	%hi(109f), %g7;				\
-	ba,pt	%xcc, etrap;				\
+	ba,pt	%xcc, .Letrap;				\
 109:	 or	%g7, %lo(109b), %g7;			\
 	call	routine;				\
 	 add	%sp, PTREGS_OFF, %o0;			\
-	ba,pt	%xcc, rtrap;				\
+	ba,pt	%xcc, .Lrtrap;				\
 	 nop;
 
 #define TRAP_SAVEFPU(routine)				\
 	sethi	%hi(109f), %g7;				\
-	ba,pt	%xcc, do_fptrap;			\
+	ba,pt	%xcc, .Ldo_fptrap;			\
 109:	 or	%g7, %lo(109b), %g7;			\
 	call	routine;				\
 	 add	%sp, PTREGS_OFF, %o0;			\
-	ba,pt	%xcc, rtrap;				\
+	ba,pt	%xcc, .Lrtrap;				\
 	 nop;						\
 	nop;
 
@@ -63,39 +63,39 @@
 
 #define TRAPTL1(routine)				\
 	sethi	%hi(109f), %g7;				\
-	ba,pt	%xcc, etraptl1;				\
+	ba,pt	%xcc, .Letraptl1;				\
 109:	 or	%g7, %lo(109b), %g7;			\
 	call	routine;				\
 	 add	%sp, PTREGS_OFF, %o0;			\
-	ba,pt	%xcc, rtrap;				\
+	ba,pt	%xcc, .Lrtrap;				\
 	 nop;						\
 	nop;
 
 #define TRAP_ARG(routine, arg)				\
 	sethi	%hi(109f), %g7;				\
-	ba,pt	%xcc, etrap;				\
+	ba,pt	%xcc, .Letrap;				\
 109:	 or	%g7, %lo(109b), %g7;			\
 	add	%sp, PTREGS_OFF, %o0;			\
 	call	routine;				\
 	 mov	arg, %o1;				\
-	ba,pt	%xcc, rtrap;				\
+	ba,pt	%xcc, .Lrtrap;				\
 	 nop;
 
 #define TRAPTL1_ARG(routine, arg)			\
 	sethi	%hi(109f), %g7;				\
-	ba,pt	%xcc, etraptl1;				\
+	ba,pt	%xcc, .Letraptl1;				\
 109:	 or	%g7, %lo(109b), %g7;			\
 	add	%sp, PTREGS_OFF, %o0;			\
 	call	routine;				\
 	 mov	arg, %o1;				\
-	ba,pt	%xcc, rtrap;				\
+	ba,pt	%xcc, .Lrtrap;				\
 	 nop;
 
 #define SYSCALL_TRAP(routine, systbl)			\
 	rdpr	%pil, %g2;				\
 	mov	TSTATE_SYSCALL, %g3;			\
 	sethi	%hi(109f), %g7;				\
-	ba,pt	%xcc, etrap_syscall;			\
+	ba,pt	%xcc, .Letrap_syscall;			\
 109:	 or	%g7, %lo(109b), %g7;			\
 	sethi	%hi(systbl), %l7;			\
 	ba,pt	%xcc, routine;				\
@@ -103,7 +103,7 @@
 
 #define TRAP_UTRAP(handler,lvl)				\
 	mov	handler, %g3;				\
-	ba,pt	%xcc, utrap_trap;			\
+	ba,pt	%xcc, .Lutrap_trap;			\
 	 mov	lvl, %g4;				\
 	nop;						\
 	nop;						\
@@ -116,7 +116,7 @@
 #else
 #define	LINUX_32BIT_SYSCALL_TRAP BTRAP(0x110)
 #endif
-#define LINUX_64BIT_SYSCALL_TRAP SYSCALL_TRAP(linux_sparc_syscall, sys_call_table64)
+#define LINUX_64BIT_SYSCALL_TRAP SYSCALL_TRAP(.Llinux_sparc_syscall, sys_call_table64)
 #define GETCC_TRAP TRAP(getcc)
 #define SETCC_TRAP TRAP(setcc)
 #define BREAKPOINT_TRAP TRAP(breakpoint_trap)
@@ -127,7 +127,7 @@
 	rdpr	%pil, %g2;				\
 	wrpr	%g0, PIL_NORMAL_MAX, %pil;		\
 	sethi	%hi(1f-4), %g7;				\
-	ba,pt	%xcc, etrap_irq;			\
+	ba,pt	%xcc, .Letrap_irq;			\
 	 or	%g7, %lo(1f-4), %g7;			\
 	nop;						\
 	nop;						\
@@ -138,7 +138,7 @@
 	mov	level, %o0;				\
 	call	routine;				\
 	 add	%sp, PTREGS_OFF, %o1;			\
-	ba,a,pt	%xcc, rtrap_irq;			\
+	ba,a,pt	%xcc, .Lrtrap_irq;			\
 	.previous;
 
 #else
@@ -146,39 +146,43 @@
 #define TRAP_IRQ(routine, level)			\
 	rdpr	%pil, %g2;				\
 	wrpr	%g0, PIL_NORMAL_MAX, %pil;		\
-	ba,pt	%xcc, etrap_irq;			\
+	ba,pt	%xcc, .Letrap_irq;			\
 	 rd	%pc, %g7;				\
 	mov	level, %o0;				\
 	call	routine;				\
 	 add	%sp, PTREGS_OFF, %o1;			\
-	ba,a,pt	%xcc, rtrap_irq;
+	ba,a,pt	%xcc, .Lrtrap_irq;
 
 #endif
 
 #define TRAP_NMI_IRQ(routine, level)			\
 	rdpr	%pil, %g2;				\
 	wrpr	%g0, PIL_NMI, %pil;			\
-	ba,pt	%xcc, etrap_irq;			\
+	ba,pt	%xcc, .Letrap_irq;			\
 	 rd	%pc, %g7;				\
 	mov	level, %o0;				\
 	call	routine;				\
 	 add	%sp, PTREGS_OFF, %o1;			\
-	ba,a,pt	%xcc, rtrap_nmi;
+	ba,a,pt	%xcc, .Lrtrap_nmi;
 
-#define TRAP_IVEC TRAP_NOSAVE(do_ivec)
+#define TRAP_IVEC					\
+	sethi	%hi(do_ivec), %g1;			\
+	jmpl	%g1 + %lo(do_ivec), %g0;		\
+	 nop;						\
+	nop; nop; nop; nop; nop;
 
 #define BTRAP(lvl) TRAP_ARG(bad_trap, lvl)
 
 #define BTRAPTL1(lvl) TRAPTL1_ARG(bad_trap_tl1, lvl)
 
 #define FLUSH_WINDOW_TRAP						\
-	ba,pt	%xcc, etrap;						\
+	ba,pt	%xcc, .Letrap;						\
 	 rd	%pc, %g7;						\
 	flushw;								\
 	ldx	[%sp + PTREGS_OFF + PT_V9_TNPC], %l1;			\
 	add	%l1, 4, %l2;						\
 	stx	%l1, [%sp + PTREGS_OFF + PT_V9_TPC];			\
-	ba,pt	%xcc, rtrap;						\
+	ba,pt	%xcc, .Lrtrap;						\
 	 stx	%l2, [%sp + PTREGS_OFF + PT_V9_TNPC];
 
 #ifdef CONFIG_KPROBES
@@ -204,7 +208,7 @@
 	ldx	[%g2 + HV_FAULT_I_ADDR_OFFSET], %g4;	\
 	ldx	[%g2 + HV_FAULT_I_CTX_OFFSET], %g5;	\
 	srlx	%g4, 22, %g6;				\
-	ba,pt	%xcc, sun4v_itsb_miss;			\
+	ba,pt	%xcc, .Lsun4v_itsb_miss;			\
 	 nop;						\
 	nop;						\
 	nop;
@@ -214,7 +218,7 @@
 	ldx	[%g2 + HV_FAULT_D_ADDR_OFFSET], %g4;	\
 	ldx	[%g2 + HV_FAULT_D_CTX_OFFSET], %g5;	\
 	srlx	%g4, 22, %g6;				\
-	ba,pt	%xcc, sun4v_dtsb_miss;			\
+	ba,pt	%xcc, .Lsun4v_dtsb_miss;			\
 	 nop;						\
 	nop;						\
 	nop;
@@ -223,9 +227,9 @@
 	ldxa	[%g0] ASI_SCRATCHPAD, %g2;		\
 	ldx	[%g2 + HV_FAULT_D_ADDR_OFFSET], %g4;	\
 	ldx	[%g2 + HV_FAULT_D_CTX_OFFSET], %g5;	\
-	ba,pt	%xcc, etrap;				\
+	ba,pt	%xcc, .Letrap;				\
 	 rd	%pc, %g7;				\
-	ba,pt	%xcc, sun4v_mcd_detect_precise;		\
+	ba,pt	%xcc, .Lsun4v_mcd_detect_precise;		\
 	 nop;						\
 	nop;
 
@@ -288,7 +292,7 @@ etrap_kernel_spill:					\
 	stx	%i7, [%sp + STACK_BIAS + 0x78];		\
 	saved;						\
 	sub	%g1, 2, %g1;				\
-	ba,pt	%xcc, etrap_save;			\
+	ba,pt	%xcc, .Letrap_save;			\
 	wrpr	%g1, %cwp;				\
 	nop; nop; nop; nop; nop; nop; nop; nop;		\
 	nop; nop; nop; nop;
@@ -346,7 +350,7 @@ etrap_user_spill_64bit:					\
 	stxa	%i7, [%sp + STACK_BIAS + 0x78] %asi;	\
 	saved;						\
 	sub	%g1, 2, %g1;				\
-	ba,pt	%xcc, etrap_save;			\
+	ba,pt	%xcc, .Letrap_save;			\
 	 wrpr	%g1, %cwp;				\
 	nop; nop; nop; nop; nop;			\
 	nop; nop; nop; nop;				\
@@ -383,7 +387,7 @@ etrap_spill_fixup_64bit:				\
 	saved;						\
 	rdpr	%cwp, %g1;				\
 	sub	%g1, 2, %g1;				\
-	ba,pt	%xcc, etrap_save;			\
+	ba,pt	%xcc, .Letrap_save;			\
 	 wrpr	%g1, %cwp;				\
 	nop; nop; nop
 
@@ -445,7 +449,7 @@ etrap_user_spill_32bit:			\
 	stwa	%i7, [%sp + 0x3c] %asi;	\
 	saved;				\
 	sub	%g1, 2, %g1;		\
-	ba,pt	%xcc, etrap_save;	\
+	ba,pt	%xcc, .Letrap_save;	\
 	 wrpr	%g1, %cwp;		\
 	nop; nop; nop; nop;		\
 	nop; nop;			\
@@ -482,7 +486,7 @@ etrap_spill_fixup_32bit:				\
 	saved;						\
 	rdpr	%cwp, %g1;				\
 	sub	%g1, 2, %g1;				\
-	ba,pt	%xcc, etrap_save;			\
+	ba,pt	%xcc, .Letrap_save;			\
 	 wrpr	%g1, %cwp;				\
 	nop; nop; nop
 
@@ -547,7 +551,7 @@ kern_rtt_fill:						\
 	ldx	[%sp + STACK_BIAS + 0x78], %i7;		\
 	restored;					\
 	add	%g1, 1, %g1;				\
-	ba,pt	%xcc, kern_rtt_restore;			\
+	ba,pt	%xcc, .Lkern_rtt_restore;			\
 	 wrpr	%g1, %cwp;				\
 	nop; nop; nop; nop; nop;			\
 	nop; nop; nop; nop;
@@ -602,7 +606,7 @@ user_rtt_fill_64bit:					\
 	ldxa	[%sp + STACK_BIAS + 0x68] %asi, %i5;	\
 	ldxa	[%sp + STACK_BIAS + 0x70] %asi, %i6;	\
 	ldxa	[%sp + STACK_BIAS + 0x78] %asi, %i7;	\
-	ba,pt	%xcc, user_rtt_pre_restore;		\
+	ba,pt	%xcc, .Luser_rtt_pre_restore;		\
 	 restored;					\
 	nop; nop; nop; nop; nop; nop;			\
 	nop; nop; nop; nop; nop;			\
@@ -665,7 +669,7 @@ user_rtt_fill_32bit:					\
 	lduwa	[%sp + 0x34] %asi, %i5;			\
 	lduwa	[%sp + 0x38] %asi, %i6;			\
 	lduwa	[%sp + 0x3c] %asi, %i7;			\
-	ba,pt	%xcc, user_rtt_pre_restore;		\
+	ba,pt	%xcc, .Luser_rtt_pre_restore;		\
 	 restored;					\
 	nop; nop; nop; nop; nop;			\
 	nop; nop; nop;					\
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index d6bc76706a7a..227a25eac918 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -40,6 +40,7 @@
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_LLSEEK
 #ifdef __32bit_syscall_numbers__
 #define __ARCH_WANT_SYS_IPC
 #else
diff --git a/arch/sparc/kernel/cherrs.S b/arch/sparc/kernel/cherrs.S
index 7f3d3d264390..16bf22630415 100644
--- a/arch/sparc/kernel/cherrs.S
+++ b/arch/sparc/kernel/cherrs.S
@@ -104,7 +104,7 @@ cheetah_plus_dcpe_trap_vector:
 do_cheetah_plus_data_parity:
 	rdpr		%pil, %g2
 	wrpr		%g0, PIL_NORMAL_MAX, %pil
-	ba,pt		%xcc, etrap_irq
+	ba,pt		%xcc, .Letrap_irq
 	 rd		%pc, %g7
 #ifdef CONFIG_TRACE_IRQFLAGS
 	call		trace_hardirqs_off
@@ -113,7 +113,7 @@ do_cheetah_plus_data_parity:
 	mov		0x0, %o0
 	call		cheetah_plus_parity_error
 	 add		%sp, PTREGS_OFF, %o1
-	ba,a,pt		%xcc, rtrap_irq
+	ba,a,pt		%xcc, .Lrtrap_irq
 	.size		do_cheetah_plus_data_parity,.-do_cheetah_plus_data_parity
 
 	.globl		cheetah_plus_dcpe_trap_vector_tl1
@@ -146,7 +146,7 @@ cheetah_plus_icpe_trap_vector:
 do_cheetah_plus_insn_parity:
 	rdpr		%pil, %g2
 	wrpr		%g0, PIL_NORMAL_MAX, %pil
-	ba,pt		%xcc, etrap_irq
+	ba,pt		%xcc, .Letrap_irq
 	 rd		%pc, %g7
 #ifdef CONFIG_TRACE_IRQFLAGS
 	call		trace_hardirqs_off
@@ -155,7 +155,7 @@ do_cheetah_plus_insn_parity:
 	mov		0x1, %o0
 	call		cheetah_plus_parity_error
 	 add		%sp, PTREGS_OFF, %o1
-	ba,a,pt		%xcc, rtrap_irq
+	ba,a,pt		%xcc, .Lrtrap_irq
 	.size		do_cheetah_plus_insn_parity,.-do_cheetah_plus_insn_parity
 
 	.globl		cheetah_plus_icpe_trap_vector_tl1
@@ -219,12 +219,12 @@ do_dcpe_tl1_nonfatal:	/* Ok we may use interrupt globals safely. */
 
 do_dcpe_tl1_fatal:
 	sethi		%hi(1f), %g7
-	ba,pt		%xcc, etraptl1
+	ba,pt		%xcc, .Letraptl1
 1:	or		%g7, %lo(1b), %g7
 	mov		0x2, %o0
 	call		cheetah_plus_parity_error
 	 add		%sp, PTREGS_OFF, %o1
-	ba,a,pt		%xcc, rtrap
+	ba,a,pt		%xcc, .Lrtrap
 	.size		do_dcpe_tl1,.-do_dcpe_tl1
 
 	.globl		do_icpe_tl1
@@ -262,12 +262,12 @@ do_icpe_tl1_nonfatal:	/* Ok we may use interrupt globals safely. */
 
 do_icpe_tl1_fatal:
 	sethi		%hi(1f), %g7
-	ba,pt		%xcc, etraptl1
+	ba,pt		%xcc, .Letraptl1
 1:	or		%g7, %lo(1b), %g7
 	mov		0x3, %o0
 	call		cheetah_plus_parity_error
 	 add		%sp, PTREGS_OFF, %o1
-	ba,a,pt		%xcc, rtrap
+	ba,a,pt		%xcc, .Lrtrap
 	.size		do_icpe_tl1,.-do_icpe_tl1
 	
 	.type		dcpe_icpe_tl1_common,#function
@@ -490,7 +490,7 @@ cheetah_fast_ecc:
 c_fast_ecc:
 	rdpr		%pil, %g2
 	wrpr		%g0, PIL_NORMAL_MAX, %pil
-	ba,pt		%xcc, etrap_irq
+	ba,pt		%xcc, .Letrap_irq
 	 rd		%pc, %g7
 #ifdef CONFIG_TRACE_IRQFLAGS
 	call		trace_hardirqs_off
@@ -500,7 +500,7 @@ c_fast_ecc:
 	mov		%l5, %o2
 	call		cheetah_fecc_handler
 	 add		%sp, PTREGS_OFF, %o0
-	ba,a,pt		%xcc, rtrap_irq
+	ba,a,pt		%xcc, .Lrtrap_irq
 	.size		c_fast_ecc,.-c_fast_ecc
 
 	/* Our caller has disabled I-cache and performed membar Sync. */
@@ -526,7 +526,7 @@ cheetah_cee:
 c_cee:
 	rdpr		%pil, %g2
 	wrpr		%g0, PIL_NORMAL_MAX, %pil
-	ba,pt		%xcc, etrap_irq
+	ba,pt		%xcc, .Letrap_irq
 	 rd		%pc, %g7
 #ifdef CONFIG_TRACE_IRQFLAGS
 	call		trace_hardirqs_off
@@ -536,7 +536,7 @@ c_cee:
 	mov		%l5, %o2
 	call		cheetah_cee_handler
 	 add		%sp, PTREGS_OFF, %o0
-	ba,a,pt		%xcc, rtrap_irq
+	ba,a,pt		%xcc, .Lrtrap_irq
 	.size		c_cee,.-c_cee
 
 	/* Our caller has disabled I-cache+D-cache and performed membar Sync. */
@@ -562,7 +562,7 @@ cheetah_deferred_trap:
 c_deferred:
 	rdpr		%pil, %g2
 	wrpr		%g0, PIL_NORMAL_MAX, %pil
-	ba,pt		%xcc, etrap_irq
+	ba,pt		%xcc, .Letrap_irq
 	 rd		%pc, %g7
 #ifdef CONFIG_TRACE_IRQFLAGS
 	call		trace_hardirqs_off
@@ -572,5 +572,5 @@ c_deferred:
 	mov		%l5, %o2
 	call		cheetah_deferred_handler
 	 add		%sp, PTREGS_OFF, %o0
-	ba,a,pt		%xcc, rtrap_irq
+	ba,a,pt		%xcc, .Lrtrap_irq
 	.size		c_deferred,.-c_deferred
diff --git a/arch/sparc/kernel/dtlb_prot.S b/arch/sparc/kernel/dtlb_prot.S
index 9f945771bbd1..ea8959ff1273 100644
--- a/arch/sparc/kernel/dtlb_prot.S
+++ b/arch/sparc/kernel/dtlb_prot.S
@@ -30,7 +30,7 @@
 	sllx		%g5, PAGE_SHIFT, %g5		! Clear context ID bits
 	bgu,pn		%xcc, winfix_trampoline		! Yes, perform winfixup
 	 mov		FAULT_CODE_DTLB | FAULT_CODE_WRITE, %g4
-	ba,pt		%xcc, sparc64_realfault_common	! Nope, normal fault
+	ba,pt		%xcc, .Lsparc64_realfault_common	! Nope, normal fault
 	 nop
 	nop
 
diff --git a/arch/sparc/kernel/etrap_64.S b/arch/sparc/kernel/etrap_64.S
index 08cc41f64725..82f10acdc869 100644
--- a/arch/sparc/kernel/etrap_64.S
+++ b/arch/sparc/kernel/etrap_64.S
@@ -26,11 +26,14 @@
  * %g4 and %g5 will be preserved %l4 and %l5 respectively.
  */
 
-		.text		
-		.align	64
-		.globl	etrap_syscall, etrap, etrap_irq, etraptl1
+		.text
+	.align	64
+	.globl	etrap_syscall, etrap, etrap_irq, etraptl1
+.Letrap:
 etrap:		rdpr	%pil, %g2
+.Letrap_irq:
 etrap_irq:	clr	%g3
+.Letrap_syscall:
 etrap_syscall:	TRAP_LOAD_THREAD_REG(%g6, %g1)
 		rdpr	%tstate, %g1
 		or	%g1, %g3, %g1
@@ -66,7 +69,7 @@ etrap_syscall:	TRAP_LOAD_THREAD_REG(%g6, %g1)
 		st	%g1, [%g2 + STACKFRAME_SZ + PT_V9_MAGIC]
 
 		rdpr	%cansave, %g1
-		brnz,pt %g1, etrap_save
+		brnz,pt %g1, .Letrap_save
 		 nop
 
 		rdpr	%cwp, %g1
@@ -88,6 +91,7 @@ etrap_user_spill:
 		 nop
 		ba,a,pt	%xcc, etrap_user_spill_64bit
 
+.Letrap_save:
 etrap_save:	save	%g2, -STACK_BIAS, %sp
 		mov	%g6, %l6
 
@@ -205,6 +209,7 @@ etrap_save:	save	%g2, -STACK_BIAS, %sp
 		 stb	%g0, [%l4 + %l3]
 		nop
 
+.Letraptl1:
 etraptl1:	/* Save tstate/tpc/tnpc of TL 1-->4 and the tl register itself.
 		 * We place this right after pt_regs on the trap stack.
 		 * The layout is:
diff --git a/arch/sparc/kernel/fpu_traps.S b/arch/sparc/kernel/fpu_traps.S
index 051659e29c7a..b05fd6181ba5 100644
--- a/arch/sparc/kernel/fpu_traps.S
+++ b/arch/sparc/kernel/fpu_traps.S
@@ -2,6 +2,7 @@
 	/* This is trivial with the new code... */
 	.globl		do_fpdis
 	.type		do_fpdis,#function
+.Ldo_fpdis:
 do_fpdis:
 	sethi		%hi(TSTATE_PEF), %g4
 	rdpr		%tstate, %g5
@@ -15,10 +16,10 @@ do_fpdis:
 
 	/* Legal state when DCR_IFPOE is set in Cheetah %dcr. */
 	sethi		%hi(109f), %g7
-	ba,pt		%xcc, etrap
+	ba,pt		%xcc, .Letrap
 109:	 or		%g7, %lo(109b), %g7
 	add		%g0, %g0, %g0
-	ba,a,pt		%xcc, rtrap
+	ba,a,pt		%xcc, .Lrtrap
 
 1:	TRAP_LOAD_THREAD_REG(%g6, %g1)
 	ldub		[%g6 + TI_FPSAVED], %g5
@@ -198,12 +199,13 @@ fpdis_exit2:
 fp_other_bounce:
 	call		do_fpother
 	 add		%sp, PTREGS_OFF, %o0
-	ba,a,pt		%xcc, rtrap
+	ba,a,pt		%xcc, .Lrtrap
 	.size		fp_other_bounce,.-fp_other_bounce
 
 	.align		32
 	.globl		do_fpother_check_fitos
 	.type		do_fpother_check_fitos,#function
+.Ldo_fpother_check_fitos:
 do_fpother_check_fitos:
 	TRAP_LOAD_THREAD_REG(%g6, %g1)
 	sethi		%hi(fp_other_bounce - 4), %g7
@@ -330,6 +332,7 @@ fitos_emul_fini:
 	.align		32
 	.globl		do_fptrap
 	.type		do_fptrap,#function
+.Ldo_fptrap:
 do_fptrap:
 	TRAP_LOAD_THREAD_REG(%g6, %g1)
 	stx		%fsr, [%g6 + TI_XFSR]
@@ -379,6 +382,6 @@ do_fptrap_after_fsr:
 	.previous
 
 	membar		#Sync
-	ba,pt		%xcc, etrap
+	ba,pt		%xcc, .Letrap
 	 wr		%g0, 0, %fprs
 	.size		do_fptrap,.-do_fptrap
diff --git a/arch/sparc/kernel/itlb_miss.S b/arch/sparc/kernel/itlb_miss.S
index 5a5d92482e8d..670a7417711f 100644
--- a/arch/sparc/kernel/itlb_miss.S
+++ b/arch/sparc/kernel/itlb_miss.S
@@ -14,7 +14,7 @@
 	 mov	FAULT_CODE_ITLB, %g3
 	sethi	%hi(_PAGE_EXEC_4U), %g4
 	andcc	%g5, %g4, %g0			! Executable?
-	be,pn	%xcc, tsb_do_fault
+	be,pn	%xcc, .Ltsb_do_fault
 	 nop					! Delay slot, fill me
 	stxa	%g5, [%g0] ASI_ITLB_DATA_IN	! Load TLB
 	retry					! Trap done
diff --git a/arch/sparc/kernel/ktlb.S b/arch/sparc/kernel/ktlb.S
index 6bfaf73ce8a0..c42f41c9b04f 100644
--- a/arch/sparc/kernel/ktlb.S
+++ b/arch/sparc/kernel/ktlb.S
@@ -92,7 +92,7 @@ kvmap_itlb_longpath:
 	.previous
 
 	rdpr	%tpc, %g5
-	ba,pt	%xcc, sparc64_realfault_common
+	ba,pt	%xcc, .Lsparc64_realfault_common
 	 mov	FAULT_CODE_ITLB, %g4
 
 kvmap_itlb_obp:
@@ -264,7 +264,7 @@ kvmap_dtlb_longpath:
 	 * need to clear the context ID bits out of %g5 here.
 	 */
 
-	be,pt	%xcc, sparc64_realfault_common
+	be,pt	%xcc, .Lsparc64_realfault_common
 	 mov	FAULT_CODE_DTLB, %g4
 	ba,pt	%xcc, winfix_trampoline
 	 nop
diff --git a/arch/sparc/kernel/misctrap.S b/arch/sparc/kernel/misctrap.S
index b5c84177521e..fd96699b1204 100644
--- a/arch/sparc/kernel/misctrap.S
+++ b/arch/sparc/kernel/misctrap.S
@@ -15,11 +15,11 @@ __do_privact:
 	stxa		%g0, [%g3] ASI_DMMU	! Clear FaultValid bit
 	membar		#Sync
 	sethi		%hi(109f), %g7
-	ba,pt		%xcc, etrap
+	ba,pt		%xcc, .Letrap
 109:	or		%g7, %lo(109b), %g7
 	call		do_privact
 	 add		%sp, PTREGS_OFF, %o0
-	ba,a,pt		%xcc, rtrap
+	ba,a,pt		%xcc, .Lrtrap
 	.size		__do_privact,.-__do_privact
 
 	.type		do_mna,#function
@@ -40,13 +40,13 @@ do_mna:
 	 rdpr		%tpc, %g3
 
 1:	sethi		%hi(109f), %g7
-	ba,pt		%xcc, etrap
+	ba,pt		%xcc, .Letrap
 109:	 or		%g7, %lo(109b), %g7
 	mov		%l4, %o1
 	mov		%l5, %o2
 	call		mem_address_unaligned
 	 add		%sp, PTREGS_OFF, %o0
-	ba,a,pt		%xcc, rtrap
+	ba,a,pt		%xcc, .Lrtrap
 	.size		do_mna,.-do_mna
 
 	.type		do_lddfmna,#function
@@ -58,13 +58,13 @@ do_lddfmna:
 	membar		#Sync
 	mov		DMMU_SFAR, %g4
 	ldxa		[%g4] ASI_DMMU, %g4
-	ba,pt		%xcc, etrap
+	ba,pt		%xcc, .Letrap
 109:	 or		%g7, %lo(109b), %g7
 	mov		%l4, %o1
 	mov		%l5, %o2
 	call		handle_lddfmna
 	 add		%sp, PTREGS_OFF, %o0
-	ba,a,pt		%xcc, rtrap
+	ba,a,pt		%xcc, .Lrtrap
 	.size		do_lddfmna,.-do_lddfmna
 
 	.type		do_stdfmna,#function
@@ -76,13 +76,13 @@ do_stdfmna:
 	membar		#Sync
 	mov		DMMU_SFAR, %g4
 	ldxa		[%g4] ASI_DMMU, %g4
-	ba,pt		%xcc, etrap
+	ba,pt		%xcc, .Letrap
 109:	 or		%g7, %lo(109b), %g7
 	mov		%l4, %o1
 	mov		%l5, %o2
 	call		handle_stdfmna
 	 add		%sp, PTREGS_OFF, %o0
-	ba,a,pt		%xcc, rtrap
+	ba,a,pt		%xcc, .Lrtrap
 	 nop
 	.size		do_stdfmna,.-do_stdfmna
 
@@ -90,6 +90,6 @@ do_stdfmna:
 breakpoint_trap:
 	call		sparc_breakpoint
 	 add		%sp, PTREGS_OFF, %o0
-	ba,pt		%xcc, rtrap
+	ba,pt		%xcc, .Lrtrap
 	 nop
 	.size		breakpoint_trap,.-breakpoint_trap
diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
index eef102765a7e..6df8d09e9cce 100644
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -93,6 +93,7 @@ __handle_signal:
 		 * avoid running softirqs, doing IRQ tracing, preempting, etc.
 		 */
 		.globl			rtrap_nmi
+.Lrtrap_nmi:
 rtrap_nmi:	ldx			[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
 		sethi			%hi(0xf << 20), %l4
 		and			%l1, %l4, %l4
@@ -109,7 +110,9 @@ rtrap_nmi:	ldx			[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
 
 		.align			64
 		.globl			rtrap_irq, rtrap, irqsz_patchme, rtrap_xcall
+.Lrtrap_irq:
 rtrap_irq:
+.Lrtrap:
 rtrap:
 		/* mm/ultra.S:xcall_report_regs KNOWS about this load. */
 		ldx			[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
@@ -279,17 +282,21 @@ rt_continue:	ldx			[%sp + PTREGS_OFF + PT_V9_G1], %g1
 		 nop
 
 user_rtt_fill_fixup_dax:
-		ba,pt	%xcc, user_rtt_fill_fixup_common
+		set	user_rtt_fill_fixup_common, %g1
+		jmpl	%g1, %g0
 		 mov	1, %g3
 
 user_rtt_fill_fixup_mna:
-		ba,pt	%xcc, user_rtt_fill_fixup_common
+		set	user_rtt_fill_fixup_common, %g1
+		jmpl	%g1, %g0
 		 mov	2, %g3
 
 user_rtt_fill_fixup:
-		ba,pt	%xcc, user_rtt_fill_fixup_common
+		set	user_rtt_fill_fixup_common, %g1
+		jmpl	%g1, %g0
 		 clr	%g3
 
+.Luser_rtt_pre_restore:
 user_rtt_pre_restore:
 		add			%g1, 1, %g1
 		wrpr			%g1, 0x0, %cwp
@@ -304,6 +311,7 @@ user_rtt_restore:
 kern_rtt:	rdpr			%canrestore, %g1
 		brz,pn			%g1, kern_rtt_fill
 		 nop
+.Lkern_rtt_restore:
 kern_rtt_restore:
 		stw			%g0, [%sp + PTREGS_OFF + PT_V9_MAGIC]
 		restore
@@ -322,7 +330,7 @@ to_kernel:
 		 nop
 		call			preempt_schedule_irq
 		 nop
-		ba,pt			%xcc, rtrap
+		ba,pt			%xcc, .Lrtrap
 #endif
 kern_fpucheck:	ldub			[%g6 + TI_FPDEPTH], %l5
 		brz,pt			%l5, rt_continue
diff --git a/arch/sparc/kernel/spiterrs.S b/arch/sparc/kernel/spiterrs.S
index 5427af44099a..78fed4a32e1f 100644
--- a/arch/sparc/kernel/spiterrs.S
+++ b/arch/sparc/kernel/spiterrs.S
@@ -83,13 +83,13 @@ __spitfire_cee_trap_continue:
 	bleu,pt		%xcc, 1f
 	 wrpr		%g0, PIL_NORMAL_MAX, %pil
 
-	ba,pt		%xcc, etraptl1
+	ba,pt		%xcc, .Letraptl1
 	 rd		%pc, %g7
 
 	ba,a,pt		%xcc, 2f
 	 nop
 
-1:	ba,pt		%xcc, etrap_irq
+1:	ba,pt		%xcc, .Letrap_irq
 	 rd		%pc, %g7
 
 2:
@@ -101,7 +101,7 @@ __spitfire_cee_trap_continue:
 	mov		%l5, %o2
 	call		spitfire_access_error
 	 add		%sp, PTREGS_OFF, %o0
-	ba,a,pt		%xcc, rtrap
+	ba,a,pt		%xcc, .Lrtrap
 	.size		__spitfire_access_error,.-__spitfire_access_error
 
 	/* This is the trap handler entry point for ECC correctable
@@ -170,16 +170,16 @@ __spitfire_data_access_exception_tl1:
 	 cmp		%g3, 0xff		! last win spill/fill trap
 	bgu,pn		%xcc, 1f
 	 nop
-	ba,pt		%xcc, winfix_dax
+	ba,pt		%xcc, .Lwinfix_dax
 	 rdpr		%tpc, %g3
 1:	sethi		%hi(109f), %g7
-	ba,pt		%xcc, etraptl1
+	ba,pt		%xcc, .Letraptl1
 109:	 or		%g7, %lo(109b), %g7
 	mov		%l4, %o1
 	mov		%l5, %o2
 	call		spitfire_data_access_exception_tl1
 	 add		%sp, PTREGS_OFF, %o0
-	ba,a,pt		%xcc, rtrap
+	ba,a,pt		%xcc, .Lrtrap
 	.size		__spitfire_data_access_exception_tl1,.-__spitfire_data_access_exception_tl1
 
 	.type		__spitfire_data_access_exception,#function
@@ -193,13 +193,13 @@ __spitfire_data_access_exception:
 	stxa		%g0, [%g3] ASI_DMMU	! Clear SFSR.FaultValid bit
 	membar		#Sync
 	sethi		%hi(109f), %g7
-	ba,pt		%xcc, etrap
+	ba,pt		%xcc, .Letrap
 109:	 or		%g7, %lo(109b), %g7
 	mov		%l4, %o1
 	mov		%l5, %o2
 	call		spitfire_data_access_exception
 	 add		%sp, PTREGS_OFF, %o0
-	ba,a,pt		%xcc, rtrap
+	ba,a,pt		%xcc, .Lrtrap
 	.size		__spitfire_data_access_exception,.-__spitfire_data_access_exception
 
 	.type		__spitfire_insn_access_exception_tl1,#function
@@ -212,13 +212,13 @@ __spitfire_insn_access_exception_tl1:
 	stxa		%g0, [%g3] ASI_IMMU	! Clear FaultValid bit
 	membar		#Sync
 	sethi		%hi(109f), %g7
-	ba,pt		%xcc, etraptl1
+	ba,pt		%xcc, .Letraptl1
 109:	 or		%g7, %lo(109b), %g7
 	mov		%l4, %o1
 	mov		%l5, %o2
 	call		spitfire_insn_access_exception_tl1
 	 add		%sp, PTREGS_OFF, %o0
-	ba,a,pt		%xcc, rtrap
+	ba,a,pt		%xcc, .Lrtrap
 	.size		__spitfire_insn_access_exception_tl1,.-__spitfire_insn_access_exception_tl1
 
 	.type		__spitfire_insn_access_exception,#function
@@ -231,11 +231,11 @@ __spitfire_insn_access_exception:
 	stxa		%g0, [%g3] ASI_IMMU	! Clear FaultValid bit
 	membar		#Sync
 	sethi		%hi(109f), %g7
-	ba,pt		%xcc, etrap
+	ba,pt		%xcc, .Letrap
 109:	 or		%g7, %lo(109b), %g7
 	mov		%l4, %o1
 	mov		%l5, %o2
 	call		spitfire_insn_access_exception
 	 add		%sp, PTREGS_OFF, %o0
-	ba,a,pt		%xcc, rtrap
+	ba,a,pt		%xcc, .Lrtrap
 	.size		__spitfire_insn_access_exception,.-__spitfire_insn_access_exception
diff --git a/arch/sparc/kernel/sun4v_ivec.S b/arch/sparc/kernel/sun4v_ivec.S
index 6478ef4f6a15..b72bc36ea12a 100644
--- a/arch/sparc/kernel/sun4v_ivec.S
+++ b/arch/sparc/kernel/sun4v_ivec.S
@@ -204,7 +204,7 @@ sun4v_res_mondo:
 	rdpr	%pil, %g2
 	wrpr	%g0, PIL_NORMAL_MAX, %pil
 	mov	%g1, %g4
-	ba,pt	%xcc, etrap_irq
+	ba,pt	%xcc, .Letrap_irq
 	 rd	%pc, %g7
 #ifdef CONFIG_TRACE_IRQFLAGS
 	call		trace_hardirqs_off
@@ -216,7 +216,7 @@ sun4v_res_mondo:
 	 mov	%l4, %o1
 
 	/* Return from trap.  */
-	ba,pt	%xcc, rtrap_irq
+	ba,pt	%xcc, .Lrtrap_irq
 	 nop
 
 sun4v_res_mondo_queue_empty:
@@ -233,7 +233,7 @@ sun4v_res_mondo_queue_full:
 
 	rdpr	%pil, %g2
 	wrpr	%g0, PIL_NORMAL_MAX, %pil
-	ba,pt	%xcc, etrap_irq
+	ba,pt	%xcc, .Letrap_irq
 	 rd	%pc, %g7
 #ifdef CONFIG_TRACE_IRQFLAGS
 	call		trace_hardirqs_off
@@ -242,7 +242,7 @@ sun4v_res_mondo_queue_full:
 	call	sun4v_resum_overflow
 	 add	%sp, PTREGS_OFF, %o0
 
-	ba,pt	%xcc, rtrap_irq
+	ba,pt	%xcc, .Lrtrap_irq
 	 nop
 
 sun4v_nonres_mondo:
@@ -315,7 +315,7 @@ sun4v_nonres_mondo:
 	rdpr	%pil, %g2
 	wrpr	%g0, PIL_NORMAL_MAX, %pil
 	mov	%g1, %g4
-	ba,pt	%xcc, etrap_irq
+	ba,pt	%xcc, .Letrap_irq
 	 rd	%pc, %g7
 #ifdef CONFIG_TRACE_IRQFLAGS
 	call		trace_hardirqs_off
@@ -327,7 +327,7 @@ sun4v_nonres_mondo:
 	 mov	%l4, %o1
 
 	/* Return from trap.  */
-	ba,pt	%xcc, rtrap_irq
+	ba,pt	%xcc, .Lrtrap_irq
 	 nop
 
 sun4v_nonres_mondo_queue_empty:
@@ -344,7 +344,7 @@ sun4v_nonres_mondo_queue_full:
 
 	rdpr	%pil, %g2
 	wrpr	%g0, PIL_NORMAL_MAX, %pil
-	ba,pt	%xcc, etrap_irq
+	ba,pt	%xcc, .Letrap_irq
 	 rd	%pc, %g7
 #ifdef CONFIG_TRACE_IRQFLAGS
 	call		trace_hardirqs_off
@@ -353,5 +353,5 @@ sun4v_nonres_mondo_queue_full:
 	call	sun4v_nonresum_overflow
 	 add	%sp, PTREGS_OFF, %o0
 
-	ba,pt	%xcc, rtrap_irq
+	ba,pt	%xcc, .Lrtrap_irq
 	 nop
diff --git a/arch/sparc/kernel/sun4v_mcd.S b/arch/sparc/kernel/sun4v_mcd.S
index a419b7318406..942af27505f5 100644
--- a/arch/sparc/kernel/sun4v_mcd.S
+++ b/arch/sparc/kernel/sun4v_mcd.S
@@ -8,10 +8,11 @@
 	.text
 	.align 32
 
+.Lsun4v_mcd_detect_precise:
 sun4v_mcd_detect_precise:
 	mov	%l4, %o1
 	mov 	%l5, %o2
 	call	sun4v_mem_corrupt_detect_precise
 	 add	%sp, PTREGS_OFF, %o0
-	ba,a,pt	%xcc, rtrap
+	ba,a,pt	%xcc, .Lrtrap
 	 nop
diff --git a/arch/sparc/kernel/sun4v_tlb_miss.S b/arch/sparc/kernel/sun4v_tlb_miss.S
index 7ac9f3367674..21e0c90dc721 100644
--- a/arch/sparc/kernel/sun4v_tlb_miss.S
+++ b/arch/sparc/kernel/sun4v_tlb_miss.S
@@ -62,7 +62,7 @@ sun4v_itlb_miss:
 	bne,a,pn %xcc, tsb_miss_page_table_walk
 	 mov	FAULT_CODE_ITLB, %g3
 	andcc	%g3, _PAGE_EXEC_4V, %g0
-	be,a,pn	%xcc, tsb_do_fault
+	be,a,pn	%xcc, .Ltsb_do_fault
 	 mov	FAULT_CODE_ITLB, %g3
 
 	/* We have a valid entry, make hypervisor call to load
@@ -144,7 +144,7 @@ sun4v_dtlb_prot:
 	cmp	%g1, 1
 	bgu,pn	%xcc, winfix_trampoline
 	 mov	FAULT_CODE_DTLB | FAULT_CODE_WRITE, %g4
-	ba,pt	%xcc, sparc64_realfault_common
+	ba,pt	%xcc, .Lsparc64_realfault_common
 	 nop
 
 	/* Called from trap table:
@@ -152,6 +152,7 @@ sun4v_dtlb_prot:
 	 * %g5:	context
 	 * %g6: TAG TARGET
 	 */
+.Lsun4v_itsb_miss:
 sun4v_itsb_miss:
 	mov	SCRATCHPAD_UTSBREG1, %g1
 	ldxa	[%g1] ASI_SCRATCHPAD, %g1
@@ -164,6 +165,7 @@ sun4v_itsb_miss:
 	 * %g5:	context
 	 * %g6: TAG TARGET
 	 */
+.Lsun4v_dtsb_miss:
 sun4v_dtsb_miss:
 	mov	SCRATCHPAD_UTSBREG1, %g1
 	ldxa	[%g1] ASI_SCRATCHPAD, %g1
@@ -214,7 +216,7 @@ sun4v_itlb_error:
 
 	sethi	%hi(1f), %g7
 	rdpr	%tl, %g4
-	ba,pt	%xcc, etraptl1
+	ba,pt	%xcc, .Letraptl1
 1:	 or	%g7, %lo(1f), %g7
 	mov	%l4, %o1
 	call	sun4v_itlb_error_report
@@ -241,7 +243,7 @@ sun4v_dtlb_error:
 
 	sethi	%hi(1f), %g7
 	rdpr	%tl, %g4
-	ba,pt	%xcc, etraptl1
+	ba,pt	%xcc, .Letraptl1
 1:	 or	%g7, %lo(1f), %g7
 	mov	%l4, %o1
 	call	sun4v_dtlb_error_report
@@ -251,7 +253,7 @@ sun4v_dtlb_error:
 
 sun4v_bad_ra:
 	or	%g0, %g4, %g5
-	ba,pt	%xcc, sparc64_realfault_common
+	ba,pt	%xcc, .Lsparc64_realfault_common
 	 or	%g1, %g0, %g4
 
 	/* NOTREACHED */
@@ -264,13 +266,13 @@ sun4v_iacc:
 	ldx	[%g2 + HV_FAULT_I_CTX_OFFSET], %g5
 	sllx	%g3, 16, %g3
 	or	%g5, %g3, %g5
-	ba,pt	%xcc, etrap
+	ba,pt	%xcc, .Letrap
 	 rd	%pc, %g7
 	mov	%l4, %o1
 	mov	%l5, %o2
 	call	sun4v_insn_access_exception
 	 add	%sp, PTREGS_OFF, %o0
-	ba,a,pt	%xcc, rtrap
+	ba,a,pt	%xcc, .Lrtrap
 
 	/* Instruction Access Exception, tl1. */
 sun4v_iacc_tl1:
@@ -280,13 +282,13 @@ sun4v_iacc_tl1:
 	ldx	[%g2 + HV_FAULT_I_CTX_OFFSET], %g5
 	sllx	%g3, 16, %g3
 	or	%g5, %g3, %g5
-	ba,pt	%xcc, etraptl1
+	ba,pt	%xcc, .Letraptl1
 	 rd	%pc, %g7
 	mov	%l4, %o1
 	mov	%l5, %o2
 	call	sun4v_insn_access_exception_tl1
 	 add	%sp, PTREGS_OFF, %o0
-	ba,a,pt	%xcc, rtrap
+	ba,a,pt	%xcc, .Lrtrap
 
 	/* Data Access Exception, tl0. */
 sun4v_dacc:
@@ -296,13 +298,13 @@ sun4v_dacc:
 	ldx	[%g2 + HV_FAULT_D_CTX_OFFSET], %g5
 	sllx	%g3, 16, %g3
 	or	%g5, %g3, %g5
-	ba,pt	%xcc, etrap
+	ba,pt	%xcc, .Letrap
 	 rd	%pc, %g7
 	mov	%l4, %o1
 	mov	%l5, %o2
 	call	sun4v_data_access_exception
 	 add	%sp, PTREGS_OFF, %o0
-	ba,a,pt	%xcc, rtrap
+	ba,a,pt	%xcc, .Lrtrap
 
 	/* Data Access Exception, tl1. */
 sun4v_dacc_tl1:
@@ -312,13 +314,13 @@ sun4v_dacc_tl1:
 	ldx	[%g2 + HV_FAULT_D_CTX_OFFSET], %g5
 	sllx	%g3, 16, %g3
 	or	%g5, %g3, %g5
-	ba,pt	%xcc, etraptl1
+	ba,pt	%xcc, .Letraptl1
 	 rd	%pc, %g7
 	mov	%l4, %o1
 	mov	%l5, %o2
 	call	sun4v_data_access_exception_tl1
 	 add	%sp, PTREGS_OFF, %o0
-	ba,a,pt	%xcc, rtrap
+	ba,a,pt	%xcc, .Lrtrap
 
 	/* Memory Address Unaligned.  */
 sun4v_mna:
@@ -346,22 +348,22 @@ sun4v_mna:
 	sllx	%g3, 16, %g3
 	or	%g5, %g3, %g5
 
-	ba,pt	%xcc, etrap
+	ba,pt	%xcc, .Letrap
 	 rd	%pc, %g7
 	mov	%l4, %o1
 	mov	%l5, %o2
 	call	sun4v_do_mna
 	 add	%sp, PTREGS_OFF, %o0
-	ba,a,pt	%xcc, rtrap
+	ba,a,pt	%xcc, .Lrtrap
 	 nop
 
 	/* Privileged Action.  */
 sun4v_privact:
-	ba,pt	%xcc, etrap
+	ba,pt	%xcc, .Letrap
 	 rd	%pc, %g7
 	call	do_privact
 	 add	%sp, PTREGS_OFF, %o0
-	ba,a,pt	%xcc, rtrap
+	ba,a,pt	%xcc, .Lrtrap
 
 	/* Unaligned ldd float, tl0. */
 sun4v_lddfmna:
@@ -371,13 +373,13 @@ sun4v_lddfmna:
 	ldx	[%g2 + HV_FAULT_D_CTX_OFFSET], %g5
 	sllx	%g3, 16, %g3
 	or	%g5, %g3, %g5
-	ba,pt	%xcc, etrap
+	ba,pt	%xcc, .Letrap
 	 rd	%pc, %g7
 	mov	%l4, %o1
 	mov	%l5, %o2
 	call	handle_lddfmna
 	 add	%sp, PTREGS_OFF, %o0
-	ba,a,pt	%xcc, rtrap
+	ba,a,pt	%xcc, .Lrtrap
 
 	/* Unaligned std float, tl0. */
 sun4v_stdfmna:
@@ -387,13 +389,13 @@ sun4v_stdfmna:
 	ldx	[%g2 + HV_FAULT_D_CTX_OFFSET], %g5
 	sllx	%g3, 16, %g3
 	or	%g5, %g3, %g5
-	ba,pt	%xcc, etrap
+	ba,pt	%xcc, .Letrap
 	 rd	%pc, %g7
 	mov	%l4, %o1
 	mov	%l5, %o2
 	call	handle_stdfmna
 	 add	%sp, PTREGS_OFF, %o0
-	ba,a,pt	%xcc, rtrap
+	ba,a,pt	%xcc, .Lrtrap
 
 #define BRANCH_ALWAYS	0x10680000
 #define NOP		0x01000000
diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index 96fe8763d70c..790c2ed4b718 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -55,11 +55,11 @@ sys32_rt_sigreturn:
 	.align	32
 1:	ldx	[%g6 + TI_FLAGS], %l5
 	andcc	%l5, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT|_TIF_NOHZ), %g0
-	be,pt	%icc, rtrap
+	be,pt	%icc, .Lrtrap
 	 nop
 	call	syscall_trace_leave
 	 add	%sp, PTREGS_OFF, %o0
-	ba,pt	%xcc, rtrap
+	ba,pt	%xcc, .Lrtrap
 	 nop
 
 	/* This is how fork() was meant to be done, 8 instruction entry.
@@ -87,26 +87,30 @@ sys32_rt_sigreturn:
 	 */
 	.align	32
 sys_vfork:
+	set	sparc_vfork, %g1
 	flushw
-	ba,pt	%xcc, sparc_vfork
+	jmpl	%g1, %g0
 	 add	%sp, PTREGS_OFF, %o0
 
 	.align	32
 sys_fork:
+	set	sparc_fork, %g1
 	flushw
-	ba,pt	%xcc, sparc_fork
+	jmpl	%g1, %g0
 	 add	%sp, PTREGS_OFF, %o0
 
 	.align	32
 sys_clone:
+	set	sparc_clone, %g1
 	flushw
-	ba,pt	%xcc, sparc_clone
+	jmpl	%g1, %g0
 	 add	%sp, PTREGS_OFF, %o0
 
 	.align	32
 __sys_clone3:
+	set	sparc_clone3, %g1
 	flushw
-	ba,pt	%xcc, sparc_clone3
+	jmpl	%g1, %g0
 	 add	%sp, PTREGS_OFF, %o0
 
 	.globl	ret_from_fork
@@ -156,6 +160,7 @@ linux_sparc_ni_syscall:
 	ba,pt	%xcc, 4f
 	 or	%l7, %lo(sys_ni_syscall), %l7
 
+#ifdef CONFIG_COMPAT
 linux_syscall_trace32:
 	call	syscall_trace_enter
 	 add	%sp, PTREGS_OFF, %o0
@@ -185,6 +190,7 @@ linux_syscall_trace32:
 	srl	%i2, 0, %o2
 	ba,pt	%xcc, 5f
 	 srl	%i3, 0, %o3
+#endif
 
 linux_syscall_trace:
 	call	syscall_trace_enter
@@ -217,6 +223,7 @@ linux_syscall_trace:
 	 mov	%i4, %o4
 
 
+#ifdef CONFIG_COMPAT
 	/* Linux 32-bit system calls enter here... */
 	.align	32
 	.globl	linux_sparc_syscall32
@@ -240,10 +247,12 @@ linux_sparc_syscall32:
 	 srl	%i5, 0, %o5				! IEU1
 	ba,pt	%xcc, 3f
 	 sra	%o0, 0, %o0
+#endif
 
 	/* Linux native system calls enter here... */
 	.align	32
 	.globl	linux_sparc_syscall
+.Llinux_sparc_syscall:
 linux_sparc_syscall:
 	/* Direct access to user regs, much faster. */
 	cmp	%g1, NR_syscalls			! IEU1	Group
@@ -283,7 +292,7 @@ ret_sys_call:
 	bne,pn	%icc, linux_syscall_trace2
 	 add	%l1, 0x4, %l2			! npc = npc+4
 	stx	%l1, [%sp + PTREGS_OFF + PT_V9_TPC]
-	ba,pt	%xcc, rtrap
+	ba,pt	%xcc, .Lrtrap
 	 stx	%l2, [%sp + PTREGS_OFF + PT_V9_TNPC]
 
 1:
@@ -305,5 +314,5 @@ linux_syscall_trace2:
 	call	syscall_trace_leave
 	 add	%sp, PTREGS_OFF, %o0
 	stx	%l1, [%sp + PTREGS_OFF + PT_V9_TPC]
-	ba,pt	%xcc, rtrap
+	ba,pt	%xcc, .Lrtrap
 	 stx	%l2, [%sp + PTREGS_OFF + PT_V9_TNPC]
diff --git a/arch/sparc/kernel/tsb.S b/arch/sparc/kernel/tsb.S
index eaed39ce8938..4edc5d04b319 100644
--- a/arch/sparc/kernel/tsb.S
+++ b/arch/sparc/kernel/tsb.S
@@ -113,7 +113,7 @@ tsb_miss_page_table_walk:
 	 * TSB both lack a matching entry.
 	 */
 tsb_miss_page_table_walk_sun4v_fastpath:
-	USER_PGTABLE_WALK_TL1(%g4, %g7, %g5, %g2, tsb_do_fault)
+	USER_PGTABLE_WALK_TL1(%g4, %g7, %g5, %g2, .Ltsb_do_fault)
 
 	/* Valid PTE is now in %g5.  */
 
@@ -156,11 +156,11 @@ tsb_miss_page_table_walk_sun4v_fastpath:
 	cmp	%g7, 1
 	bne,pn	%xcc, winfix_trampoline
 	 mov	%g3, %g4
-	ba,pt	%xcc, etrap
+	ba,pt	%xcc, .Letrap
 	 rd	%pc, %g7
 	call	hugetlb_setup
 	 add	%sp, PTREGS_OFF, %o0
-	ba,pt	%xcc, rtrap
+	ba,pt	%xcc, .Lrtrap
 	 nop
 
 60:
@@ -217,7 +217,7 @@ tsb_itlb_load:
 	nop
 	.previous
 
-	be,pn		%xcc, tsb_do_fault
+	be,pn		%xcc, .Ltsb_do_fault
 	 nop
 
 661:	stxa		%g5, [%g0] ASI_ITLB_DATA_IN
@@ -248,6 +248,7 @@ tsb_itlb_load:
 	 */
 
 	.globl		tsb_do_fault
+.Ltsb_do_fault:
 tsb_do_fault:
 	cmp		%g3, FAULT_CODE_DTLB
 
@@ -278,28 +279,29 @@ tsb_do_dtlb_fault:
 	srlx		%g5, PAGE_SHIFT, %g5
 	sllx		%g5, PAGE_SHIFT, %g5
 
-	be,pt	%xcc, sparc64_realfault_common
+	be,pt	%xcc, .Lsparc64_realfault_common
 	 mov	FAULT_CODE_DTLB, %g4
 	ba,pt	%xcc, winfix_trampoline
 	 nop
 
 tsb_do_itlb_fault:
 	rdpr	%tpc, %g5
-	ba,pt	%xcc, sparc64_realfault_common
+	ba,pt	%xcc, .Lsparc64_realfault_common
 	 mov	FAULT_CODE_ITLB, %g4
 
 	.globl	sparc64_realfault_common
+.Lsparc64_realfault_common:
 sparc64_realfault_common:
 	/* fault code in %g4, fault address in %g5, etrap will
 	 * preserve these two values in %l4 and %l5 respectively
 	 */
-	ba,pt	%xcc, etrap			! Save trap state
+	ba,pt	%xcc, .Letrap			! Save trap state
 1:	 rd	%pc, %g7			! ...
 	stb	%l4, [%g6 + TI_FAULT_CODE]	! Save fault code
 	stx	%l5, [%g6 + TI_FAULT_ADDR]	! Save fault address
 	call	do_sparc64_fault		! Call fault handler
 	 add	%sp, PTREGS_OFF, %o0		! Compute pt_regs arg
-	ba,pt	%xcc, rtrap			! Restore cpu state
+	ba,pt	%xcc, .Lrtrap			! Restore cpu state
 	 nop					! Delay slot (fill me)
 
 winfix_trampoline:
diff --git a/arch/sparc/kernel/ttable_64.S b/arch/sparc/kernel/ttable_64.S
index 86e737e59c7e..51ae9fc2d395 100644
--- a/arch/sparc/kernel/ttable_64.S
+++ b/arch/sparc/kernel/ttable_64.S
@@ -30,9 +30,9 @@ tl0_resv018:	BTRAP(0x18) BTRAP(0x19)
 tl0_mcd:	SUN4V_MCD_PRECISE
 tl0_resv01b:	BTRAP(0x1b)
 tl0_resv01c:	BTRAP(0x1c) BTRAP(0x1d)	BTRAP(0x1e) BTRAP(0x1f)
-tl0_fpdis:	TRAP_NOSAVE(do_fpdis)
+tl0_fpdis:	TRAP_NOSAVE(.Ldo_fpdis)
 tl0_fpieee:	TRAP_SAVEFPU(do_fpieee)
-tl0_fpother:	TRAP_NOSAVE(do_fpother_check_fitos)
+tl0_fpother:	TRAP_NOSAVE(.Ldo_fpother_check_fitos)
 tl0_tof:	TRAP(do_tof)
 tl0_cwin:	CLEAN_WINDOW
 tl0_div0:	TRAP(do_div0)
@@ -195,7 +195,7 @@ tl1_resv012:	BTRAPTL1(0x12) BTRAPTL1(0x13) BTRAPTL1(0x14) BTRAPTL1(0x15)
 tl1_resv016:	BTRAPTL1(0x16) BTRAPTL1(0x17) BTRAPTL1(0x18) BTRAPTL1(0x19)
 tl1_resv01a:	BTRAPTL1(0x1a) BTRAPTL1(0x1b) BTRAPTL1(0x1c) BTRAPTL1(0x1d)
 tl1_resv01e:	BTRAPTL1(0x1e) BTRAPTL1(0x1f)
-tl1_fpdis:	TRAP_NOSAVE(do_fpdis)
+tl1_fpdis:	TRAP_NOSAVE(.Ldo_fpdis)
 tl1_fpieee:	TRAPTL1(do_fpieee_tl1)
 tl1_fpother:	TRAPTL1(do_fpother_tl1)
 tl1_tof:	TRAPTL1(do_tof_tl1)
diff --git a/arch/sparc/kernel/urtt_fill.S b/arch/sparc/kernel/urtt_fill.S
index e4cee7be5cd0..dd809c190e26 100644
--- a/arch/sparc/kernel/urtt_fill.S
+++ b/arch/sparc/kernel/urtt_fill.S
@@ -66,7 +66,8 @@ user_rtt_fill_fixup_common:
 
 		call	do_sparc64_fault
 		 add	%sp, PTREGS_OFF, %o0
-		ba,pt	%xcc, rtrap
+		set	rtrap, %g1
+		jmpl	%g1, %g0
 		 nop
 
 1:		cmp	%g3, 2
@@ -81,12 +82,16 @@ user_rtt_fill_fixup_common:
 		mov	%l4, %o2
 		call	sun4v_do_mna
 		 mov	%l5, %o1
-		ba,a,pt	%xcc, rtrap
+		set	rtrap, %g1
+		jmpl	%g1, %g0
+		 nop
 1:		mov	%l4, %o1
 		mov	%l5, %o2
 		call	mem_address_unaligned
 		 nop
-		ba,a,pt	%xcc, rtrap
+		set	rtrap, %g1
+		jmpl	%g1, %g0
+		 nop
 
 2:		sethi	%hi(tlb_type), %g1
 		mov	%l4, %o1
@@ -97,9 +102,12 @@ user_rtt_fill_fixup_common:
 		 add	%sp, PTREGS_OFF, %o0
 		call	sun4v_data_access_exception
 		 nop
-		ba,a,pt	%xcc, rtrap
+		set	rtrap, %g1
+		jmpl	%g1, %g0
 		 nop
 
 1:		call	spitfire_data_access_exception
 		 nop
-		ba,a,pt	%xcc, rtrap
+		set	rtrap, %g1
+		jmpl	%g1, %g0
+		 nop
diff --git a/arch/sparc/kernel/utrap.S b/arch/sparc/kernel/utrap.S
index 7a2d9a9bea59..bae98ca92b80 100644
--- a/arch/sparc/kernel/utrap.S
+++ b/arch/sparc/kernel/utrap.S
@@ -1,18 +1,19 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 	.globl		utrap_trap
 	.type		utrap_trap,#function
+.Lutrap_trap:
 utrap_trap:		/* %g3=handler,%g4=level */
 	TRAP_LOAD_THREAD_REG(%g6, %g1)
 	ldx		[%g6 + TI_UTRAPS], %g1
 	brnz,pt		%g1, invoke_utrap
 	 nop
 
-	ba,pt		%xcc, etrap
+	ba,pt		%xcc, .Letrap
 	 rd		%pc, %g7
 	mov		%l4, %o1
         call		bad_trap
 	 add		%sp, PTREGS_OFF, %o0
-	ba,a,pt		%xcc, rtrap
+	ba,a,pt		%xcc, .Lrtrap
 
 invoke_utrap:
 	sllx		%g3, 3, %g3
diff --git a/arch/sparc/kernel/winfixup.S b/arch/sparc/kernel/winfixup.S
index 448accee090f..136b66c112d7 100644
--- a/arch/sparc/kernel/winfixup.S
+++ b/arch/sparc/kernel/winfixup.S
@@ -29,11 +29,11 @@ fill_fixup:
 	stb	%g4, [%g6 + TI_FAULT_CODE]
 	stx	%g5, [%g6 + TI_FAULT_ADDR]
 	wrpr	%g1, %cwp
-	ba,pt	%xcc, etrap
+	ba,pt	%xcc, .Letrap
 	 rd	%pc, %g7
 	call	do_sparc64_fault
 	 add	%sp, PTREGS_OFF, %o0
-	ba,a,pt	%xcc, rtrap
+	ba,a,pt	%xcc, .Lrtrap
 
 	/* Be very careful about usage of the trap globals here.
 	 * You cannot touch %g5 as that has the fault information.
@@ -98,11 +98,11 @@ spill_fixup_dax:
 	stb	%g4, [%g6 + TI_FAULT_CODE]
 	stx	%g5, [%g6 + TI_FAULT_ADDR]
 	wrpr	%g1, %cwp
-	ba,pt	%xcc, etrap
+	ba,pt	%xcc, .Letrap
 	 rd	%pc, %g7
 	call	do_sparc64_fault
 	 add	%sp, PTREGS_OFF, %o0
-	ba,a,pt	%xcc, rtrap
+	ba,a,pt	%xcc, .Lrtrap
 
 winfix_mna:
 	andn	%g3, 0x7f, %g3
@@ -114,7 +114,7 @@ fill_fixup_mna:
 	rdpr	%tstate, %g1
 	and	%g1, TSTATE_CWP, %g1
 	wrpr	%g1, %cwp
-	ba,pt	%xcc, etrap
+	ba,pt	%xcc, .Letrap
 	 rd	%pc, %g7
 	sethi	%hi(tlb_type), %g1
 	lduw	[%g1 + %lo(tlb_type)], %g1
@@ -124,13 +124,14 @@ fill_fixup_mna:
 	mov	%l4, %o2
 	call	sun4v_do_mna
 	 mov	%l5, %o1
-	ba,a,pt	%xcc, rtrap
+	ba,a,pt	%xcc, .Lrtrap
 1:	mov	%l4, %o1
 	mov	%l5, %o2
 	call	mem_address_unaligned
 	 nop
-	ba,a,pt	%xcc, rtrap
+	ba,a,pt	%xcc, .Lrtrap
 
+.Lwinfix_dax:
 winfix_dax:
 	andn	%g3, 0x7f, %g3
 	add	%g3, 0x74, %g3
@@ -141,7 +142,7 @@ fill_fixup_dax:
 	rdpr	%tstate, %g1
 	and	%g1, TSTATE_CWP, %g1
 	wrpr	%g1, %cwp
-	ba,pt	%xcc, etrap
+	ba,pt	%xcc, .Letrap
 	 rd	%pc, %g7
 	sethi	%hi(tlb_type), %g1
 	mov	%l4, %o1
@@ -152,9 +153,9 @@ fill_fixup_dax:
 	 add	%sp, PTREGS_OFF, %o0
 	call	sun4v_data_access_exception
 	 nop
-	ba,a,pt	%xcc, rtrap
+	ba,a,pt	%xcc, .Lrtrap
 	 nop
 1:	call	spitfire_data_access_exception
 	 nop
-	ba,a,pt	%xcc, rtrap
+	ba,a,pt	%xcc, .Lrtrap
 	 nop
diff --git a/arch/sparc/lib/GENbzero.S b/arch/sparc/lib/GENbzero.S
index 63d618857d49..cc1d14724623 100644
--- a/arch/sparc/lib/GENbzero.S
+++ b/arch/sparc/lib/GENbzero.S
@@ -31,6 +31,7 @@ GENmemset:		/* %o0=buf, %o1=pat, %o2=len */
 
 	.globl		GENbzero
 	.type		GENbzero, #function
+.LGENbzero:
 GENbzero:
 	clr		%o2
 1:	brz,pn		%o1, GENbzero_return
@@ -121,7 +122,7 @@ GENclear_user:		/* %o0=buf, %o1=len */
 	brz,pn		%o1, GENbzero_done
 	 clr		%o3
 	cmp		%o5, ASI_AIUS
-	bne,pn		%icc, GENbzero
+	bne,pn		%icc, .LGENbzero
 	 clr		%o2
 	ba,pt		%xcc, GENbzero_from_clear_user
 	 mov		ASI_AIUS, %o4
diff --git a/arch/sparc/lib/GENcopy_from_user.S b/arch/sparc/lib/GENcopy_from_user.S
index 6891a5678ea3..799cf0013d0f 100644
--- a/arch/sparc/lib/GENcopy_from_user.S
+++ b/arch/sparc/lib/GENcopy_from_user.S
@@ -24,8 +24,12 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, raw_copy_in_user;		\
-	 nop
+	be,pt		%icc, 1f;			\
+	 nop;					\
+	set		raw_copy_in_user, %g1;		\
+	jmpl		%g1, %g0;			\
+	 nop;					\
+1:
 #endif
 
 #include "GENmemcpy.S"
diff --git a/arch/sparc/lib/GENcopy_to_user.S b/arch/sparc/lib/GENcopy_to_user.S
index df75b532a934..fe77197a3e90 100644
--- a/arch/sparc/lib/GENcopy_to_user.S
+++ b/arch/sparc/lib/GENcopy_to_user.S
@@ -28,8 +28,12 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, raw_copy_in_user;		\
-	 nop
+	be,pt		%icc, 1f;			\
+	 nop;					\
+	set		raw_copy_in_user, %g1;		\
+	jmpl		%g1, %g0;			\
+	 nop;					\
+1:
 #endif
 
 #include "GENmemcpy.S"
diff --git a/arch/sparc/lib/M7copy_from_user.S b/arch/sparc/lib/M7copy_from_user.S
index 66464b3e3649..4ade396f9449 100644
--- a/arch/sparc/lib/M7copy_from_user.S
+++ b/arch/sparc/lib/M7copy_from_user.S
@@ -33,8 +33,12 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, raw_copy_in_user;		\
-	 nop
+	be,pt		%icc, 1f;			\
+	 nop;					\
+	set		raw_copy_in_user, %g1;		\
+	jmpl		%g1, %g0;			\
+	 nop;					\
+1:
 #endif
 
 #include "M7memcpy.S"
diff --git a/arch/sparc/lib/M7copy_to_user.S b/arch/sparc/lib/M7copy_to_user.S
index a60ac467f808..0ac7e64d83e3 100644
--- a/arch/sparc/lib/M7copy_to_user.S
+++ b/arch/sparc/lib/M7copy_to_user.S
@@ -44,8 +44,12 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, raw_copy_in_user;		\
-	 nop
+	be,pt		%icc, 1f;			\
+	 nop;					\
+	set		raw_copy_in_user, %g1;		\
+	jmpl		%g1, %g0;			\
+	 nop;					\
+1:
 #endif
 
 #include "M7memcpy.S"
diff --git a/arch/sparc/lib/Memcpy_utils.S b/arch/sparc/lib/Memcpy_utils.S
index 207343367bb2..75760baadd3a 100644
--- a/arch/sparc/lib/Memcpy_utils.S
+++ b/arch/sparc/lib/Memcpy_utils.S
@@ -5,349 +5,351 @@
 #include <asm/asi.h>
 #include <asm/visasm.h>
 
+.L__restore_asi_fp:
 ENTRY(__restore_asi_fp)
 	VISExitHalf
 	retl
 	 wr	%g0, ASI_AIUS, %asi
 ENDPROC(__restore_asi_fp)
 
+.L__restore_asi:
 ENTRY(__restore_asi)
 	retl
 	 wr	%g0, ASI_AIUS, %asi
 ENDPROC(__restore_asi)
 
 ENTRY(memcpy_retl_o2)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 mov	%o2, %o0
 ENDPROC(memcpy_retl_o2)
 ENTRY(memcpy_retl_o2_plus_1)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 1, %o0
 ENDPROC(memcpy_retl_o2_plus_1)
 ENTRY(memcpy_retl_o2_plus_3)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 3, %o0
 ENDPROC(memcpy_retl_o2_plus_3)
 ENTRY(memcpy_retl_o2_plus_4)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 4, %o0
 ENDPROC(memcpy_retl_o2_plus_4)
 ENTRY(memcpy_retl_o2_plus_5)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 5, %o0
 ENDPROC(memcpy_retl_o2_plus_5)
 ENTRY(memcpy_retl_o2_plus_6)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 6, %o0
 ENDPROC(memcpy_retl_o2_plus_6)
 ENTRY(memcpy_retl_o2_plus_7)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 7, %o0
 ENDPROC(memcpy_retl_o2_plus_7)
 ENTRY(memcpy_retl_o2_plus_8)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 8, %o0
 ENDPROC(memcpy_retl_o2_plus_8)
 ENTRY(memcpy_retl_o2_plus_15)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 15, %o0
 ENDPROC(memcpy_retl_o2_plus_15)
 ENTRY(memcpy_retl_o2_plus_15_8)
 	 add	%o2, 15, %o2
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 8, %o0
 ENDPROC(memcpy_retl_o2_plus_15_8)
 ENTRY(memcpy_retl_o2_plus_16)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 16, %o0
 ENDPROC(memcpy_retl_o2_plus_16)
 ENTRY(memcpy_retl_o2_plus_24)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 24, %o0
 ENDPROC(memcpy_retl_o2_plus_24)
 ENTRY(memcpy_retl_o2_plus_31)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 31, %o0
 ENDPROC(memcpy_retl_o2_plus_31)
 ENTRY(memcpy_retl_o2_plus_32)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 32, %o0
 ENDPROC(memcpy_retl_o2_plus_32)
 ENTRY(memcpy_retl_o2_plus_31_32)
 	add	%o2, 31, %o2
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 32, %o0
 ENDPROC(memcpy_retl_o2_plus_31_32)
 ENTRY(memcpy_retl_o2_plus_31_24)
 	add	%o2, 31, %o2
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 24, %o0
 ENDPROC(memcpy_retl_o2_plus_31_24)
 ENTRY(memcpy_retl_o2_plus_31_16)
 	add	%o2, 31, %o2
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 16, %o0
 ENDPROC(memcpy_retl_o2_plus_31_16)
 ENTRY(memcpy_retl_o2_plus_31_8)
 	add	%o2, 31, %o2
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 8, %o0
 ENDPROC(memcpy_retl_o2_plus_31_8)
 ENTRY(memcpy_retl_o2_plus_63)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 63, %o0
 ENDPROC(memcpy_retl_o2_plus_63)
 ENTRY(memcpy_retl_o2_plus_63_64)
 	 add	%o2, 63, %o2
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 64, %o0
 ENDPROC(memcpy_retl_o2_plus_63_64)
 ENTRY(memcpy_retl_o2_plus_63_56)
 	 add	%o2, 63, %o2
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 56, %o0
 ENDPROC(memcpy_retl_o2_plus_63_56)
 ENTRY(memcpy_retl_o2_plus_63_48)
 	 add	%o2, 63, %o2
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 48, %o0
 ENDPROC(memcpy_retl_o2_plus_63_48)
 ENTRY(memcpy_retl_o2_plus_63_40)
 	 add	%o2, 63, %o2
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 40, %o0
 ENDPROC(memcpy_retl_o2_plus_63_40)
 ENTRY(memcpy_retl_o2_plus_63_32)
 	 add	%o2, 63, %o2
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 32, %o0
 ENDPROC(memcpy_retl_o2_plus_63_32)
 ENTRY(memcpy_retl_o2_plus_63_24)
 	 add	%o2, 63, %o2
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 24, %o0
 ENDPROC(memcpy_retl_o2_plus_63_24)
 ENTRY(memcpy_retl_o2_plus_63_16)
 	 add	%o2, 63, %o2
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 16, %o0
 ENDPROC(memcpy_retl_o2_plus_63_16)
 ENTRY(memcpy_retl_o2_plus_63_8)
 	 add	%o2, 63, %o2
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 8, %o0
 ENDPROC(memcpy_retl_o2_plus_63_8)
 ENTRY(memcpy_retl_o2_plus_o3)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o3, %o0
 ENDPROC(memcpy_retl_o2_plus_o3)
 ENTRY(memcpy_retl_o2_plus_o3_plus_1)
 	add	%o3, 1, %o3
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o3, %o0
 ENDPROC(memcpy_retl_o2_plus_o3_plus_1)
 ENTRY(memcpy_retl_o2_plus_o5)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5)
 ENTRY(memcpy_retl_o2_plus_o5_plus_1)
 	add	%o5, 1, %o5
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5_plus_1)
 ENTRY(memcpy_retl_o2_plus_o5_plus_4)
 	add	%o5, 4, %o5
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5_plus_4)
 ENTRY(memcpy_retl_o2_plus_o5_plus_8)
 	add	%o5, 8, %o5
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5_plus_8)
 ENTRY(memcpy_retl_o2_plus_o5_plus_16)
 	add	%o5, 16, %o5
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5_plus_16)
 ENTRY(memcpy_retl_o2_plus_o5_plus_24)
 	add	%o5, 24, %o5
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5_plus_24)
 ENTRY(memcpy_retl_o2_plus_o5_plus_32)
 	add	%o5, 32, %o5
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5_plus_32)
 ENTRY(memcpy_retl_o2_plus_o5_64)
 	add	%o5, 32, %o5
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5_64)
 ENTRY(memcpy_retl_o2_plus_g1)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %g1, %o0
 ENDPROC(memcpy_retl_o2_plus_g1)
 ENTRY(memcpy_retl_o2_plus_g1_plus_1)
 	add	%g1, 1, %g1
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %g1, %o0
 ENDPROC(memcpy_retl_o2_plus_g1_plus_1)
 ENTRY(memcpy_retl_o2_plus_g1_plus_8)
 	add	%g1, 8, %g1
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %g1, %o0
 ENDPROC(memcpy_retl_o2_plus_g1_plus_8)
 ENTRY(memcpy_retl_o2_plus_o4)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4)
 ENTRY(memcpy_retl_o2_plus_o4_plus_8)
 	add	%o4, 8, %o4
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_plus_8)
 ENTRY(memcpy_retl_o2_plus_o4_plus_16)
 	add	%o4, 16, %o4
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_plus_16)
 ENTRY(memcpy_retl_o2_plus_o4_plus_24)
 	add	%o4, 24, %o4
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_plus_24)
 ENTRY(memcpy_retl_o2_plus_o4_plus_32)
 	add	%o4, 32, %o4
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_plus_32)
 ENTRY(memcpy_retl_o2_plus_o4_plus_40)
 	add	%o4, 40, %o4
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_plus_40)
 ENTRY(memcpy_retl_o2_plus_o4_plus_48)
 	add	%o4, 48, %o4
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_plus_48)
 ENTRY(memcpy_retl_o2_plus_o4_plus_56)
 	add	%o4, 56, %o4
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_plus_56)
 ENTRY(memcpy_retl_o2_plus_o4_plus_64)
 	add	%o4, 64, %o4
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_plus_64)
 ENTRY(memcpy_retl_o2_plus_o5_plus_64)
 	add	%o5, 64, %o5
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5_plus_64)
 ENTRY(memcpy_retl_o2_plus_o3_fp)
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o3, %o0
 ENDPROC(memcpy_retl_o2_plus_o3_fp)
 ENTRY(memcpy_retl_o2_plus_o3_plus_1_fp)
 	add	%o3, 1, %o3
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o3, %o0
 ENDPROC(memcpy_retl_o2_plus_o3_plus_1_fp)
 ENTRY(memcpy_retl_o2_plus_o3_plus_4_fp)
 	add	%o3, 4, %o3
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o3, %o0
 ENDPROC(memcpy_retl_o2_plus_o3_plus_4_fp)
 ENTRY(memcpy_retl_o2_plus_o4_fp)
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_fp)
 ENTRY(memcpy_retl_o2_plus_o4_plus_8_fp)
 	add	%o4, 8, %o4
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_plus_8_fp)
 ENTRY(memcpy_retl_o2_plus_o4_plus_16_fp)
 	add	%o4, 16, %o4
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_plus_16_fp)
 ENTRY(memcpy_retl_o2_plus_o4_plus_24_fp)
 	add	%o4, 24, %o4
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_plus_24_fp)
 ENTRY(memcpy_retl_o2_plus_o4_plus_32_fp)
 	add	%o4, 32, %o4
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_plus_32_fp)
 ENTRY(memcpy_retl_o2_plus_o4_plus_40_fp)
 	add	%o4, 40, %o4
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_plus_40_fp)
 ENTRY(memcpy_retl_o2_plus_o4_plus_48_fp)
 	add	%o4, 48, %o4
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_plus_48_fp)
 ENTRY(memcpy_retl_o2_plus_o4_plus_56_fp)
 	add	%o4, 56, %o4
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_plus_56_fp)
 ENTRY(memcpy_retl_o2_plus_o4_plus_64_fp)
 	add	%o4, 64, %o4
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_plus_64_fp)
 ENTRY(memcpy_retl_o2_plus_o5_fp)
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5_fp)
 ENTRY(memcpy_retl_o2_plus_o5_plus_64_fp)
 	add	%o5, 64, %o5
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5_plus_64_fp)
 ENTRY(memcpy_retl_o2_plus_o5_plus_56_fp)
 	add	%o5, 56, %o5
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5_plus_56_fp)
 ENTRY(memcpy_retl_o2_plus_o5_plus_48_fp)
 	add	%o5, 48, %o5
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5_plus_48_fp)
 ENTRY(memcpy_retl_o2_plus_o5_plus_40_fp)
 	add	%o5, 40, %o5
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5_plus_40_fp)
 ENTRY(memcpy_retl_o2_plus_o5_plus_32_fp)
 	add	%o5, 32, %o5
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5_plus_32_fp)
 ENTRY(memcpy_retl_o2_plus_o5_plus_24_fp)
 	add	%o5, 24, %o5
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5_plus_24_fp)
 ENTRY(memcpy_retl_o2_plus_o5_plus_16_fp)
 	add	%o5, 16, %o5
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5_plus_16_fp)
 ENTRY(memcpy_retl_o2_plus_o5_plus_8_fp)
 	add	%o5, 8, %o5
-	ba,pt	%xcc, __restore_asi_fp
+	ba,pt	%xcc, .L__restore_asi_fp
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5_plus_8_fp)
 
diff --git a/arch/sparc/lib/NG2copy_from_user.S b/arch/sparc/lib/NG2copy_from_user.S
index e57bc514f538..2c37df6ec19a 100644
--- a/arch/sparc/lib/NG2copy_from_user.S
+++ b/arch/sparc/lib/NG2copy_from_user.S
@@ -37,8 +37,12 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, raw_copy_in_user;		\
-	 nop
+	be,pt		%icc, 1f;			\
+	 nop;					\
+	set		raw_copy_in_user, %g1;		\
+	jmpl		%g1, %g0;			\
+	 nop;					\
+1:
 #endif
 
 #include "NG2memcpy.S"
diff --git a/arch/sparc/lib/NG2copy_to_user.S b/arch/sparc/lib/NG2copy_to_user.S
index 367c0bf01518..28f4f8ae44f7 100644
--- a/arch/sparc/lib/NG2copy_to_user.S
+++ b/arch/sparc/lib/NG2copy_to_user.S
@@ -46,8 +46,12 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, raw_copy_in_user;		\
-	 nop
+	be,pt		%icc, 1f;			\
+	 nop;					\
+	set		raw_copy_in_user, %g1;		\
+	jmpl		%g1, %g0;			\
+	 nop;					\
+1:
 #endif
 
 #include "NG2memcpy.S"
diff --git a/arch/sparc/lib/NG2memcpy.S b/arch/sparc/lib/NG2memcpy.S
index bcb21b3a82f1..7f5697b48cc2 100644
--- a/arch/sparc/lib/NG2memcpy.S
+++ b/arch/sparc/lib/NG2memcpy.S
@@ -181,38 +181,39 @@
 #define EX_RETVAL(x)	x
 __restore_fp:
 	VISExitHalf
+.L__restore_asi:
 __restore_asi:
 	retl
 	 wr	%g0, ASI_AIUS, %asi
 ENTRY(NG2_retl_o2)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 mov	%o2, %o0
 ENDPROC(NG2_retl_o2)
 ENTRY(NG2_retl_o2_plus_1)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 1, %o0
 ENDPROC(NG2_retl_o2_plus_1)
 ENTRY(NG2_retl_o2_plus_4)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 4, %o0
 ENDPROC(NG2_retl_o2_plus_4)
 ENTRY(NG2_retl_o2_plus_8)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, 8, %o0
 ENDPROC(NG2_retl_o2_plus_8)
 ENTRY(NG2_retl_o2_plus_o4_plus_1)
 	add	%o4, 1, %o4
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o4, %o0
 ENDPROC(NG2_retl_o2_plus_o4_plus_1)
 ENTRY(NG2_retl_o2_plus_o4_plus_8)
 	add	%o4, 8, %o4
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o4, %o0
 ENDPROC(NG2_retl_o2_plus_o4_plus_8)
 ENTRY(NG2_retl_o2_plus_o4_plus_16)
 	add	%o4, 16, %o4
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o4, %o0
 ENDPROC(NG2_retl_o2_plus_o4_plus_16)
 ENTRY(NG2_retl_o2_plus_g1_fp)
@@ -226,18 +227,18 @@ ENTRY(NG2_retl_o2_plus_g1_plus_64_fp)
 ENDPROC(NG2_retl_o2_plus_g1_plus_64_fp)
 ENTRY(NG2_retl_o2_plus_g1_plus_1)
 	add	%g1, 1, %g1
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %g1, %o0
 ENDPROC(NG2_retl_o2_plus_g1_plus_1)
 ENTRY(NG2_retl_o2_and_7_plus_o4)
 	and	%o2, 7, %o2
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o4, %o0
 ENDPROC(NG2_retl_o2_and_7_plus_o4)
 ENTRY(NG2_retl_o2_and_7_plus_o4_plus_8)
 	and	%o2, 7, %o2
 	add	%o4, 8, %o4
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%o2, %o4, %o0
 ENDPROC(NG2_retl_o2_and_7_plus_o4_plus_8)
 #endif
diff --git a/arch/sparc/lib/NG4copy_from_user.S b/arch/sparc/lib/NG4copy_from_user.S
index 0cac15a6db3c..b0c4f6b670d0 100644
--- a/arch/sparc/lib/NG4copy_from_user.S
+++ b/arch/sparc/lib/NG4copy_from_user.S
@@ -32,8 +32,12 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, raw_copy_in_user;		\
-	 nop
+	be,pt		%icc, 1f;			\
+	 nop;					\
+	set		raw_copy_in_user, %g1;		\
+	jmpl		%g1, %g0;			\
+	 nop;					\
+1:
 #endif
 
 #include "NG4memcpy.S"
diff --git a/arch/sparc/lib/NG4copy_to_user.S b/arch/sparc/lib/NG4copy_to_user.S
index c5c9abb3cb77..95e6f8aa3891 100644
--- a/arch/sparc/lib/NG4copy_to_user.S
+++ b/arch/sparc/lib/NG4copy_to_user.S
@@ -41,8 +41,12 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, raw_copy_in_user;		\
-	 nop
+	be,pt		%icc, 1f;			\
+	 nop;					\
+	set		raw_copy_in_user, %g1;		\
+	jmpl		%g1, %g0;			\
+	 nop;					\
+1:
 #endif
 
 #include "NG4memcpy.S"
diff --git a/arch/sparc/lib/NGbzero.S b/arch/sparc/lib/NGbzero.S
index 19327614d57d..40017d32b4ac 100644
--- a/arch/sparc/lib/NGbzero.S
+++ b/arch/sparc/lib/NGbzero.S
@@ -30,6 +30,7 @@ NGmemset:		/* %o0=buf, %o1=pat, %o2=len */
 
 	.globl		NGbzero
 	.type		NGbzero, #function
+.LNGbzero:
 NGbzero:
 	clr		%o2
 1:	brz,pn		%o1, NGbzero_return
@@ -123,7 +124,7 @@ NGclear_user:		/* %o0=buf, %o1=len */
 	brz,pn		%o1, NGbzero_done
 	 clr		%o3
 	cmp		%o5, ASI_AIUS
-	bne,pn		%icc, NGbzero
+	bne,pn		%icc, .LNGbzero
 	 clr		%o2
 	mov		ASI_BLK_INIT_QUAD_LDD_AIUS, %g7
 	ba,pt		%xcc, NGbzero_from_clear_user
diff --git a/arch/sparc/lib/NGcopy_from_user.S b/arch/sparc/lib/NGcopy_from_user.S
index 9abc49fcdbbe..cab0351c4489 100644
--- a/arch/sparc/lib/NGcopy_from_user.S
+++ b/arch/sparc/lib/NGcopy_from_user.S
@@ -26,8 +26,12 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, raw_copy_in_user;		\
-	 nop
+	be,pt		%icc, 1f;			\
+	 nop;					\
+	set		raw_copy_in_user, %g1;		\
+	jmpl		%g1, %g0;			\
+	 nop;					\
+1:
 #endif
 
 #include "NGmemcpy.S"
diff --git a/arch/sparc/lib/NGcopy_to_user.S b/arch/sparc/lib/NGcopy_to_user.S
index 9cbe2f18e5cc..00ea4e0f7dc1 100644
--- a/arch/sparc/lib/NGcopy_to_user.S
+++ b/arch/sparc/lib/NGcopy_to_user.S
@@ -29,8 +29,12 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, raw_copy_in_user;		\
-	 nop
+	be,pt		%icc, 1f;			\
+	 nop;					\
+	set		raw_copy_in_user, %g1;		\
+	jmpl		%g1, %g0;			\
+	 nop;					\
+1:
 #endif
 
 #include "NGmemcpy.S"
diff --git a/arch/sparc/lib/NGmemcpy.S b/arch/sparc/lib/NGmemcpy.S
index bbd3ea0a6482..b8c1da692737 100644
--- a/arch/sparc/lib/NGmemcpy.S
+++ b/arch/sparc/lib/NGmemcpy.S
@@ -78,93 +78,94 @@
 	.text
 #ifndef EX_RETVAL
 #define EX_RETVAL(x)	x
+.L__restore_asi:
 __restore_asi:
 	wr	%g0, ASI_AIUS, %asi
 	ret
 	 restore
 ENTRY(NG_ret_i2_plus_i4_plus_1)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%i2, %i5, %i0
 ENDPROC(NG_ret_i2_plus_i4_plus_1)
 ENTRY(NG_ret_i2_plus_g1)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%i2, %g1, %i0
 ENDPROC(NG_ret_i2_plus_g1)
 ENTRY(NG_ret_i2_plus_g1_minus_8)
 	sub	%g1, 8, %g1
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%i2, %g1, %i0
 ENDPROC(NG_ret_i2_plus_g1_minus_8)
 ENTRY(NG_ret_i2_plus_g1_minus_16)
 	sub	%g1, 16, %g1
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%i2, %g1, %i0
 ENDPROC(NG_ret_i2_plus_g1_minus_16)
 ENTRY(NG_ret_i2_plus_g1_minus_24)
 	sub	%g1, 24, %g1
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%i2, %g1, %i0
 ENDPROC(NG_ret_i2_plus_g1_minus_24)
 ENTRY(NG_ret_i2_plus_g1_minus_32)
 	sub	%g1, 32, %g1
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%i2, %g1, %i0
 ENDPROC(NG_ret_i2_plus_g1_minus_32)
 ENTRY(NG_ret_i2_plus_g1_minus_40)
 	sub	%g1, 40, %g1
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%i2, %g1, %i0
 ENDPROC(NG_ret_i2_plus_g1_minus_40)
 ENTRY(NG_ret_i2_plus_g1_minus_48)
 	sub	%g1, 48, %g1
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%i2, %g1, %i0
 ENDPROC(NG_ret_i2_plus_g1_minus_48)
 ENTRY(NG_ret_i2_plus_g1_minus_56)
 	sub	%g1, 56, %g1
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%i2, %g1, %i0
 ENDPROC(NG_ret_i2_plus_g1_minus_56)
 ENTRY(NG_ret_i2_plus_i4_plus_16)
         add     %i4, 16, %i4
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%i2, %i4, %i0
 ENDPROC(NG_ret_i2_plus_i4_plus_16)
 ENTRY(NG_ret_i2_plus_i4_plus_8)
 	add	%i4, 8, %i4
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%i2, %i4, %i0
 ENDPROC(NG_ret_i2_plus_i4_plus_8)
 ENTRY(NG_ret_i2_plus_8)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%i2, 8, %i0
 ENDPROC(NG_ret_i2_plus_8)
 ENTRY(NG_ret_i2_plus_4)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%i2, 4, %i0
 ENDPROC(NG_ret_i2_plus_4)
 ENTRY(NG_ret_i2_plus_1)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%i2, 1, %i0
 ENDPROC(NG_ret_i2_plus_1)
 ENTRY(NG_ret_i2_plus_g1_plus_1)
 	add	%g1, 1, %g1
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%i2, %g1, %i0
 ENDPROC(NG_ret_i2_plus_g1_plus_1)
 ENTRY(NG_ret_i2)
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 mov	%i2, %i0
 ENDPROC(NG_ret_i2)
 ENTRY(NG_ret_i2_and_7_plus_i4)
 	and	%i2, 7, %i2
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%i2, %i4, %i0
 ENDPROC(NG_ret_i2_and_7_plus_i4)
 ENTRY(NG_ret_i2_and_7_plus_i4_plus_8)
 	and	%i2, 7, %i2
 	add	%i4, 8, %i4
-	ba,pt	%xcc, __restore_asi
+	ba,pt	%xcc, .L__restore_asi
 	 add	%i2, %i4, %i0
 ENDPROC(NG_ret_i2_and_7_plus_i4)
 #endif
diff --git a/arch/sparc/lib/U1copy_from_user.S b/arch/sparc/lib/U1copy_from_user.S
index bf08d1c78836..f398f4021eca 100644
--- a/arch/sparc/lib/U1copy_from_user.S
+++ b/arch/sparc/lib/U1copy_from_user.S
@@ -32,7 +32,11 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, raw_copy_in_user;		\
-	 nop;						\
+	be,pt		%icc, 1f;			\
+	 nop;					\
+	set		raw_copy_in_user, %g1;		\
+	jmpl		%g1, %g0;			\
+	 nop;					\
+1:;						\
 
 #include "U1memcpy.S"
diff --git a/arch/sparc/lib/U1copy_to_user.S b/arch/sparc/lib/U1copy_to_user.S
index 15169851e7ab..9c984f3ff6fd 100644
--- a/arch/sparc/lib/U1copy_to_user.S
+++ b/arch/sparc/lib/U1copy_to_user.S
@@ -32,7 +32,11 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, raw_copy_in_user;		\
-	 nop;						\
+	be,pt		%icc, 1f;			\
+	 nop;					\
+	set		raw_copy_in_user, %g1;		\
+	jmpl		%g1, %g0;			\
+	 nop;					\
+1:;						\
 
 #include "U1memcpy.S"
diff --git a/arch/sparc/lib/U3copy_to_user.S b/arch/sparc/lib/U3copy_to_user.S
index da424608272c..9ce943418cfa 100644
--- a/arch/sparc/lib/U3copy_to_user.S
+++ b/arch/sparc/lib/U3copy_to_user.S
@@ -32,7 +32,11 @@
 #define PREAMBLE					\
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
-	bne,pn		%icc, raw_copy_in_user;		\
-	 nop;						\
+	be,pt		%icc, 1f;			\
+	 nop;					\
+	set		raw_copy_in_user, %g1;		\
+	jmpl		%g1, %g0;			\
+	 nop;					\
+1:;						\
 
 #include "U3memcpy.S"
diff --git a/arch/sparc/lib/memmove.S b/arch/sparc/lib/memmove.S
index 543dda7b9dac..4da540270582 100644
--- a/arch/sparc/lib/memmove.S
+++ b/arch/sparc/lib/memmove.S
@@ -17,8 +17,12 @@ ENTRY(memmove) /* o0=dst o1=src o2=len */
 	bleu,pt		%xcc, 2f
 	 add		%o1, %o2, %g7
 	cmp		%g7, %o0
-	bleu,pt		%xcc, memcpy
+	bgu,pn		%xcc, 1f
 	 add		%o0, %o2, %o5
+	set		memcpy, %g7
+	jmpl		%g7, %g0
+	 nop
+1:
 	sub		%g7, 1, %o1
 
 	sub		%o5, 1, %o0
diff --git a/arch/sparc/mm/ultra.S b/arch/sparc/mm/ultra.S
index 70e658d107e0..793b847f43a9 100644
--- a/arch/sparc/mm/ultra.S
+++ b/arch/sparc/mm/ultra.S
@@ -189,6 +189,7 @@ __spitfire_flush_tlb_mm_slow:
 	.section .kprobes.text, "ax"
 	.align		32
 	.globl		__flush_icache_page
+.L__flush_icache_page:
 __flush_icache_page:	/* %o0 = phys_page */
 	srlx		%o0, PAGE_SHIFT, %o0
 	sethi		%hi(PAGE_OFFSET), %g1
@@ -237,7 +238,7 @@ __flush_dcache_page:	/* %o0=kaddr, %o1=flush_icache */
 	/* The I-cache does not snoop local stores so we
 	 * better flush that too when necessary.
 	 */
-	brnz,pt		%o1, __flush_icache_page
+	brnz,pt		%o1, .L__flush_icache_page
 	 sllx		%o0, 11, %o0
 	retl
 	 nop
@@ -642,7 +643,8 @@ xcall_sync_tick:
 	rdpr		%pil, %g2
 	wrpr		%g0, PIL_NORMAL_MAX, %pil
 	sethi		%hi(109f), %g7
-	b,pt		%xcc, etrap_irq
+	set		etrap_irq, %g1
+	jmpl		%g1, %g0
 109:	 or		%g7, %lo(109b), %g7
 #ifdef CONFIG_TRACE_IRQFLAGS
 	call		trace_hardirqs_off
@@ -650,7 +652,8 @@ xcall_sync_tick:
 #endif
 	call		smp_synchronize_tick_client
 	 nop
-	b		rtrap_xcall
+	set		rtrap_xcall, %g1
+	jmpl		%g1, %g0
 	 ldx		[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
 
 	.globl		xcall_fetch_glob_regs
@@ -844,12 +847,15 @@ xcall_flush_dcache_page_spitfire: /* %g1 == physical page address
 __hypervisor_tlb_xcall_error:
 	mov	%g5, %g4
 	mov	%g6, %g5
-	ba,pt	%xcc, etrap
+	set	etrap, %g1
+	jmpl	%g1, %g0
 	 rd	%pc, %g7
 	mov	%l4, %o0
 	call	hypervisor_tlbop_error_xcall
 	 mov	%l5, %o1
-	ba,a,pt	%xcc, rtrap
+	set	rtrap, %g1
+	jmpl	%g1, %g0
+	 nop
 
 	.globl		__hypervisor_xcall_flush_tlb_mm
 __hypervisor_xcall_flush_tlb_mm: /* 24 insns */
-- 
2.54.0

