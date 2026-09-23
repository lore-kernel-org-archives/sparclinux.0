Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627857ED95
	for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194767; cv=none; b=VgT4MUDpaP0jPhDpe37GA7+h1asS2MrTXtfTPFE3l+jaaaqJXsCVvvE5lWLxKg8HgkyKerp2fpvGrKo0OoA2GE+beRcts2/Rlzofo8xUvpc3Xkpc37aRjTMcTfoSiVla8v9E2/DubIZMABhKn9KXl+CKj7/W/XMkY177JS2Hg8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194767; c=relaxed/simple;
	bh=ZcPIw4eZTdDBlXCbqQEro1ebWfUuQCWYfKDFEL48bSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bz87vBchVot8PTwc1SqJsmQJF12Nw46pSSL2sDwUyEHGjTLnTMkjov0vfL9EgMdZcykA4BOuZqXEng2WFXT4xQO+M9xHmTJaDDQI2t4Y1Oo53clZidU3u4RQJn/VSVU3Rqn55Xs1zQpAhT3G2Sin+FdPDU8FhiuffcibBmCxdrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWz2s6kn; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWz2s6kn"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efe5so220657166b.2
        for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 13:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790194759; x=1790799559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=frtoc8QloQCQUfk7NjWI4KUj8MMQjADBvRstAE5cfJw=;
        b=UWz2s6knK/FiqzFI0Q+UtTuvme6C9omqr1NYZk2QOuVvx4+Q4TIJ5Pm9JBDtFiSbdr
         nWSe5M9C0mM0x1Md+zf9Cz2VQ3xnknhUOBZX/RSe1lCtXXXsd/SM/rccMbauQF4TsgDj
         biFMlmCv5RsMtXXcTq49wUzB3GWkH9qZx/prPJR0ayrjavjom5NR4FusfQPSw4siqDWp
         5Yr0bXQ9uGEbFlNiuYGr1WP0CjcwGL09CPV151WI6pOvfrJTquNVm/ZeXctBAUDZJz3i
         Imq6k/ygfRHXrqz44G2XYFbLj5veG1m3kL+GzB2T90QlEFL57H4Bg+o58DhUiSDzRdEq
         5I4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194759; x=1790799559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=frtoc8QloQCQUfk7NjWI4KUj8MMQjADBvRstAE5cfJw=;
        b=W7zaxCUqjzpvXbcStssxlulVKjZ71bke8eiIj1GTQlzxCrEV0dH/ohJ/QhnXQl++AP
         5J8Fv73wU5ch16HEhiHSK44iEhFf+GMWNaMBHmqVgLSe9oWnqDHYLL0QUVqBtJOBcwdh
         K2JDTwA/crPcNf0BHCrlhXzQSD17poMk4CSRCAwZXEnjYvqUYTF3d1jSsLiMrpOmlGxm
         fWRQwNBmgfydZ1UtAuyQDNI44FX8LPZAcUZoO9GSpeFFX9iHgLZbrWXKS5aP3lTB994g
         JPfez568DwjEKHWjwTWbXVC3xY3EvlObr1wdZkYZHdGY9DN2OE1KmJWSliVNCw8TdsFm
         7z3A==
X-Forwarded-Encrypted: i=1; AKwUvBz0waoeSaiKi5rB3a+LPi8/RM1ergvNVGCU5N4opN9taFCTMyzIyWpSfXJgUMc8vRxTOIGysPckAdUr@vger.kernel.org
X-Gm-Message-State: AFuF++lIzHsE1PMEsjLoQ6lf863AVFsCD1UFPN6Z86Gn4OQDUEQq/NT6
	8kRnyUyD9r7mNea5UfRoG5drDHv2VfChWWElVyJno2/3nlWp8iaIxEau
X-Gm-Gg: AYBFou3V7u/f6sdimjjX+xN92t0LawCV2PsmYElUSy7hsaL4uwJeiQFzOcvh8dLFZ0h
	b7hJycsVKoihrVwbgq+NCfPu9I4gFNzWPk4DMOwtRyRBiCT0sHxMzJktjGboccMF9WOQFkyvJ+l
	s8SMneYmg7JBAMrEARtesV7KQH9U9BgT7GmYu8fIyeMvi9cZ4YrG6FgwhjkfA8AwJZHVW+0OhjO
	HggA4I6nWdNRJIL5s+VEx3QoK1iEdAOoDgx5/gCtx8DBYooscT9xrTGz9Ni6yATibdVMwnh4lSJ
	RjYUp9opUGnNtSAGkQU9EmMrP0p/Z7eMx9uXXF1cR6seobU0TT9lcGgIflxelYoFk2DGfURfegn
	1QZ2C/PrM1XfkB32qQ+/dH70EImMkIrhltuqG1yYMDvwkaU4WwCDGkb01t1HZZtwuFuFkbi7tOC
	jJQU4DzbnJ/yRgdtOtXFHkK0YAnyXoqZ83KwQXCW1N/FeLVPMgBfdRsRJpGU0I3fLqpJWP3yvKH
	kyr6cZGwiHufGqpBvCUeu1klm93cD44ENRWuyYh6GfGaRtBUQE=
X-Received: by 2002:a17:907:9811:b0:c2a:46a2:5b57 with SMTP id a640c23a62f3a-c2ac2375464mr19975466b.10.1790194759459;
        Wed, 23 Sep 2026 13:19:19 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae63dc17sm183626966b.33.2026.09.23.13.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:19:19 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [RFC PATCH 2/5] sparc32: add a kernel assisted compare-and-swap
Date: Wed, 23 Sep 2026 22:17:18 +0200
Message-ID: <20260923201830.865553-3-linmag7@gmail.com>
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

Pre-v9 sparc has no compare-and-swap instruction, so userspace can only
emulate one with a lock, and neither place to put that lock works. A lock
private to a process cannot serialise against another process operating on
the same page. A lock kept inside the object, what glibc did before
2019, ldstub on the top byte of the word, is correct across processes but
costs value bits, so it cannot implement the full-width operations a
current compiler emits calls to. A lock owned by the kernel has neither
problem. parisc solves the same problem the same way with its LWS
compare-and-swap.

Add trap type 0x91 for this. Dispatch follows the existing do_hw_divzero
pattern of reaching C rather than doing the work in trap assembly. The
ABI is

	%o0	word aligned user address
	%o1	expected value
	%o2	new value

returning the value found at the address in %o0, the previously observed
value, as __sync_val_compare_and_swap does, with the carry bit set and an
errno in %o0 on failure.

The number is SP_TRAP_CAS in asm/traps.h, where the other software trap
numbers already live, since this one is userspace ABI from now on. The
instruction userspace executes is ta 0x11, not ta 0x91: sparc forms the
trap type by adding 0x80 to the software trap number, which is also why
the Linux system call is SP_TRAP_LINUX 0x90 and glibc issues ta 0x10.

David Miller prototyped the same idea in 2016 on software trap 0x23,
discovered through the get-kernel-features call and implemented first on
sparc64 [2]. This is a different ABI rather than that one finished:
0x11 follows the Linux syscall trap immediately, discovery is AT_HWCAP,
and sparc64 compat mode is not supported.

Where the cpu implements the instruction the lock is not used at all and
the swap is performed directly, with the user data ASI so that the kernel
reaches the word the same way a binary built for that cpu does. Choosing
on the hardware rather than on a build option is what keeps the two in
step: such a binary uses casa inline and never takes this trap, so a
kernel serialising on a lock would exclude nothing against it.

Otherwise the lock array is used. It is hashed on address bits that lie
inside the page offset, so the same physical word reached through
different virtual addresses selects the same lock. asm/futex_32.h uses
the same array, so a compare-and-swap from userspace and one performed by
the futex code exclude each other.

Page faults are disabled while the lock is held, since faulting there
would take the mmap lock with interrupts off; on failure the lock is
dropped, the page is faulted in with fault_in_safe_writeable(), not
fault_in_writeable(), which may modify the target memory while probing it
and the operation is retried.

One consequence constrains the caller rather than the kernel: where the
lock is used an ordinary store does not take it, so userspace must build
every atomic write from this service, or those writes are not atomic
against it. Andreas Larsson made the same point about
kernel-emulated casa in 2016 [1]. Documentation/arch/sparc/cas-trap.rst
states that, and the width and compiler-integration limits, as part of
the ABI.

Link: https://inbox.sourceware.org/libc-alpha/5810C1A3.9030504@gaisler.com/ [1]
Link: https://inbox.sourceware.org/libc-alpha/20161107.113825.631166023186879199.davem@davemloft.net/ [2]
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/cas_32.h     | 23 +++++++
 arch/sparc/include/uapi/asm/traps.h |  3 +-
 arch/sparc/kernel/Makefile          |  1 +
 arch/sparc/kernel/cas_32.c          | 96 +++++++++++++++++++++++++++++
 arch/sparc/kernel/entry.S           | 17 +++++
 arch/sparc/kernel/ttable_32.S       |  9 +--
 arch/sparc/lib/casa_32.S            | 12 ++++
 7 files changed, 156 insertions(+), 5 deletions(-)
 create mode 100644 arch/sparc/kernel/cas_32.c

diff --git a/arch/sparc/include/asm/cas_32.h b/arch/sparc/include/asm/cas_32.h
index 3658ff71fa70..400be2b9f628 100644
--- a/arch/sparc/include/asm/cas_32.h
+++ b/arch/sparc/include/asm/cas_32.h
@@ -2,9 +2,32 @@
 #ifndef _SPARC_CAS_32_H
 #define _SPARC_CAS_32_H
 
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
+struct pt_regs;
+
+asmlinkage void handle_sparc32_cas(struct pt_regs *regs, unsigned long pc,
+				   unsigned long npc, unsigned long psr);
+
 /* Returns 0 and stores the value found in *prev, or -EFAULT. */
 int __sparc32_casa(u32 *addr, u32 oldval, u32 newval, u32 *prev);
 
+/* The same on a user address, using the user data ASI. */
+int __sparc32_casa_user(u32 __user *addr, u32 oldval, u32 newval, u32 *prev);
+
+#define SPARC32_ATOMIC_LOCKS	256
+
+extern raw_spinlock_t sparc32_atomic_locks[SPARC32_ATOMIC_LOCKS];
+
+/* Hash on page-offset bits only, so one physical word maps to one lock
+ * through any virtual address.  asm/futex_32.h must hash identically.
+ */
+static inline raw_spinlock_t *sparc32_atomic_lock(const void __user *uaddr)
+{
+	unsigned long ua = (unsigned long)uaddr;
+
+	return &sparc32_atomic_locks[(ua >> 2) & (SPARC32_ATOMIC_LOCKS - 1)];
+}
+
 #endif /* _SPARC_CAS_32_H */
diff --git a/arch/sparc/include/uapi/asm/traps.h b/arch/sparc/include/uapi/asm/traps.h
index 43fe5b8fe8be..3e4d1c0c5a94 100644
--- a/arch/sparc/include/uapi/asm/traps.h
+++ b/arch/sparc/include/uapi/asm/traps.h
@@ -81,6 +81,7 @@
 #define SP_TRAP_SOLARIS 0x88         /* Solaris System Call */
 #define SP_TRAP_NETBSD  0x89         /* NetBSD System Call */
 #define SP_TRAP_LINUX   0x90         /* Linux System Call */
+#define SP_TRAP_CAS     0x91         /* Compare and swap, issued as "ta 0x11" */
 
 /* Names used for compatibility with SunOS */
 #define ST_SYSCALL              0x00
@@ -104,7 +105,7 @@
 	 (level > SP_TRAP_BADFL && level < SP_TRAP_CPEXP) || \
 	 (level > SP_TRAP_DMM && level < SP_TRAP_IMM) || \
 	 (level > SP_TRAP_IMM && level < SP_TRAP_SUNOS) || \
-	 (level > SP_TRAP_LINUX && level < SP_TRAP_KBPT1))
+	 (level > SP_TRAP_CAS && level < SP_TRAP_KBPT1))
 
 /* Is this a Hardware trap? */
 #define HW_TRAP_P(level) ((level > 0) && (level < SP_TRAP_SUNOS))
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 497b5714fa8f..7ae9ab4082ca 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -18,6 +18,7 @@ CFLAGS_REMOVE_pcr.o := -pg
 endif
 
 obj-y                   := head_$(BITS).o
+obj-$(CONFIG_SPARC32)   += cas_32.o
 obj-$(CONFIG_SPARC64)   += urtt_fill.o
 obj-$(CONFIG_SPARC32)   += entry.o wof.o wuf.o
 obj-$(CONFIG_SPARC32)   += etrap_32.o
diff --git a/arch/sparc/kernel/cas_32.c b/arch/sparc/kernel/cas_32.c
new file mode 100644
index 000000000000..de9822dc80b9
--- /dev/null
+++ b/arch/sparc/kernel/cas_32.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kernel assisted compare-and-swap for pre-v9 sparc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/uaccess.h>
+#include <linux/pagemap.h>
+
+#include <asm/ptrace.h>
+#include <asm/cas_32.h>
+#include <asm/cpu_type.h>
+
+raw_spinlock_t sparc32_atomic_locks[SPARC32_ATOMIC_LOCKS] = {
+	[0 ... (SPARC32_ATOMIC_LOCKS - 1)] =
+		__RAW_SPIN_LOCK_UNLOCKED(sparc32_atomic_locks)
+};
+
+/* Report errors in the carry bit as the syscall path does, then step over
+ * the trapping instruction.
+ */
+static void cas_return(struct pt_regs *regs, unsigned long value, bool error)
+{
+	regs->u_regs[UREG_I0] = value;
+	if (error)
+		regs->psr |= PSR_C;
+	else
+		regs->psr &= ~PSR_C;
+
+	regs->pc = regs->npc;
+	regs->npc = regs->npc + 4;
+}
+
+/* Trap type SP_TRAP_CAS; the ABI is in
+ * Documentation/arch/sparc/cas-trap.rst.
+ */
+asmlinkage void handle_sparc32_cas(struct pt_regs *regs, unsigned long pc,
+				   unsigned long npc, unsigned long psr)
+{
+	u32 __user *uaddr = (u32 __user *)regs->u_regs[UREG_I0];
+	u32 oldval = regs->u_regs[UREG_I1];
+	u32 newval = regs->u_regs[UREG_I2];
+	raw_spinlock_t *lock;
+	unsigned long flags;
+	u32 val;
+	int err;
+
+	if (unlikely((unsigned long)uaddr & 3)) {
+		cas_return(regs, EINVAL, true);
+		return;
+	}
+
+	if (unlikely(!access_ok(uaddr, sizeof(u32)))) {
+		cas_return(regs, EFAULT, true);
+		return;
+	}
+
+	if (sparc32_has_casa) {
+		/* No lock needed: casa is atomic against userspace's own. */
+		if (likely(!__sparc32_casa_user(uaddr, oldval, newval, &val)))
+			cas_return(regs, val, false);
+		else
+			cas_return(regs, EFAULT, true);
+		return;
+	}
+
+	lock = sparc32_atomic_lock(uaddr);
+
+retry:
+	/* A fault must not take the mmap lock under a raw spinlock, so make
+	 * it -EFAULT here and fault the page in after dropping the lock.
+	 */
+	raw_spin_lock_irqsave(lock, flags);
+	pagefault_disable();
+
+	err = __get_user(val, uaddr);
+	if (!err && val == oldval)
+		err = __put_user(newval, uaddr);
+
+	pagefault_enable();
+	raw_spin_unlock_irqrestore(lock, flags);
+
+	if (likely(!err)) {
+		cas_return(regs, val, false);
+		return;
+	}
+
+	/* fault_in_writeable() may modify the target memory. */
+	if (fault_in_safe_writeable((char __user *)uaddr, sizeof(u32))) {
+		cas_return(regs, EFAULT, true);
+		return;
+	}
+
+	goto retry;
+}
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index ea51ef52c952..cad48f0a0835 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -644,6 +644,23 @@ do_cp_exception:
 
 	RESTORE_ALL
 
+	/* This routine handles the compare-and-swap trap, type 0x91. */
+	.align	4
+	.globl	do_sparc32_cas
+do_sparc32_cas:
+	SAVE_ALL
+
+	wr	%l0, PSR_ET, %psr		! re-enable traps
+	WRITE_PAUSE
+
+	add	%sp, STACKFRAME_SZ, %o0
+	mov	%l1, %o1
+	mov	%l2, %o2
+	call	handle_sparc32_cas
+	 mov	%l0, %o3
+
+	RESTORE_ALL
+
 	/* This routine handles Hardware Divide By Zero Exceptions. */
 	.align	4
 	.globl	do_hw_divzero
diff --git a/arch/sparc/kernel/ttable_32.S b/arch/sparc/kernel/ttable_32.S
index e79fd786fbbb..0408f0dbae68 100644
--- a/arch/sparc/kernel/ttable_32.S
+++ b/arch/sparc/kernel/ttable_32.S
@@ -89,7 +89,8 @@ t_bad89:BAD_TRAP(0x89)                      /* Net-B.S. System Call          */
 t_bad8a:BAD_TRAP(0x8a) BAD_TRAP(0x8b) BAD_TRAP(0x8c) BAD_TRAP(0x8d) BAD_TRAP(0x8e)
 t_bad8f:BAD_TRAP(0x8f)
 t_linux:LINUX_SYSCALL_TRAP                  /* Linux System Call             */
-t_bad91:BAD_TRAP(0x91) BAD_TRAP(0x92) BAD_TRAP(0x93) BAD_TRAP(0x94) BAD_TRAP(0x95)
+t_cas:	TRAP_ENTRY(0x91, do_sparc32_cas)  /* Compare and swap             */
+t_bad92:BAD_TRAP(0x92) BAD_TRAP(0x93) BAD_TRAP(0x94) BAD_TRAP(0x95)
 t_bad96:BAD_TRAP(0x96) BAD_TRAP(0x97) BAD_TRAP(0x98) BAD_TRAP(0x99) BAD_TRAP(0x9a)
 t_bad9b:BAD_TRAP(0x9b) BAD_TRAP(0x9c) BAD_TRAP(0x9d) BAD_TRAP(0x9e) BAD_TRAP(0x9f)
 t_getcc:GETCC_TRAP                          /* Get Condition Codes           */
@@ -186,7 +187,7 @@ trapbase_cpu1:
 	BAD_TRAP(0x87) BAD_TRAP(0x88) BAD_TRAP(0x89)
 	BAD_TRAP(0x8a) BAD_TRAP(0x8b) BAD_TRAP(0x8c)
 	BAD_TRAP(0x8d) BAD_TRAP(0x8e) BAD_TRAP(0x8f)
-	LINUX_SYSCALL_TRAP BAD_TRAP(0x91)
+	LINUX_SYSCALL_TRAP TRAP_ENTRY(0x91, do_sparc32_cas)
 	BAD_TRAP(0x92) BAD_TRAP(0x93) BAD_TRAP(0x94)
 	BAD_TRAP(0x95) BAD_TRAP(0x96) BAD_TRAP(0x97) BAD_TRAP(0x98) BAD_TRAP(0x99)
 	BAD_TRAP(0x9a) BAD_TRAP(0x9b) BAD_TRAP(0x9c) BAD_TRAP(0x9d) BAD_TRAP(0x9e)
@@ -286,7 +287,7 @@ trapbase_cpu2:
 	BAD_TRAP(0x86) BAD_TRAP(0x87) BAD_TRAP(0x88)
 	BAD_TRAP(0x89) BAD_TRAP(0x8a) BAD_TRAP(0x8b) BAD_TRAP(0x8c)
 	BAD_TRAP(0x8d) BAD_TRAP(0x8e) BAD_TRAP(0x8f)
-	LINUX_SYSCALL_TRAP BAD_TRAP(0x91)
+	LINUX_SYSCALL_TRAP TRAP_ENTRY(0x91, do_sparc32_cas)
 	BAD_TRAP(0x92) BAD_TRAP(0x93) BAD_TRAP(0x94)
 	BAD_TRAP(0x95) BAD_TRAP(0x96) BAD_TRAP(0x97) BAD_TRAP(0x98) BAD_TRAP(0x99)
 	BAD_TRAP(0x9a) BAD_TRAP(0x9b) BAD_TRAP(0x9c) BAD_TRAP(0x9d) BAD_TRAP(0x9e)
@@ -385,7 +386,7 @@ trapbase_cpu3:
 	BAD_TRAP(0x89) BAD_TRAP(0x8a) BAD_TRAP(0x8b) BAD_TRAP(0x8c)
 	BAD_TRAP(0x8d) BAD_TRAP(0x8e) BAD_TRAP(0x8f)
 	LINUX_SYSCALL_TRAP
-	BAD_TRAP(0x91) BAD_TRAP(0x92) BAD_TRAP(0x93) BAD_TRAP(0x94)
+	TRAP_ENTRY(0x91, do_sparc32_cas) BAD_TRAP(0x92) BAD_TRAP(0x93) BAD_TRAP(0x94)
 	BAD_TRAP(0x95) BAD_TRAP(0x96) BAD_TRAP(0x97) BAD_TRAP(0x98) BAD_TRAP(0x99)
 	BAD_TRAP(0x9a) BAD_TRAP(0x9b) BAD_TRAP(0x9c) BAD_TRAP(0x9d) BAD_TRAP(0x9e)
 	BAD_TRAP(0x9f)
diff --git a/arch/sparc/lib/casa_32.S b/arch/sparc/lib/casa_32.S
index 67df9ea439ce..c277f1f1f795 100644
--- a/arch/sparc/lib/casa_32.S
+++ b/arch/sparc/lib/casa_32.S
@@ -22,6 +22,17 @@ ENTRY(__sparc32_casa)
 	 clr	%o0
 ENDPROC(__sparc32_casa)
 
+/* The same on a user address; ASI 0x0a is user data, as userspace uses. */
+ENTRY(__sparc32_casa_user)
+	/* nop + .balignl: LEON errata GRLIB-TN-0010 and TN-0011. */
+	nop
+	.balignl 16, 0x01000000
+4:	casa	[%o0] 0x0a, %o1, %o2
+	st	%o2, [%o3]
+	retl
+	 clr	%o0
+ENDPROC(__sparc32_casa_user)
+
 	.section .fixup,#alloc,#execinstr
 	.align	4
 2:	retl
@@ -31,4 +42,5 @@ ENDPROC(__sparc32_casa)
 	.section __ex_table,#alloc
 	.align	4
 	.word	1b, 2b
+	.word	4b, 2b
 	.previous
-- 
2.43.0

