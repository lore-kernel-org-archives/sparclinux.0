From: David Miller <davem@davemloft.net>
Date: Tue, 19 Jan 2016 20:10:59 +0000
Subject: Re: using ptrace to cancel a syscall on sparc
Message-Id: <20160119.151059.2169748653736211782.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20151220054754.GZ11489@vapier.lan>
In-Reply-To: <20151220054754.GZ11489@vapier.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 18 Jan 2016 06:32:30 -0500

> looks like the bug is in arch/sparc/kernel/syscalls.S:linux_syscall_trace32
> (and linux_syscall_trace).  they don't reload the args from the pt_regs
> struct after calling syscall_trace_enter.  i put in a small hack:

Mike, please give this patch a test, thanks!

==========
From 61e354c90b000f8a15e4e26bdfc9d336312a2c86 Mon Sep 17 00:00:00 2001
From: David S. Miller <davem@davemloft.net>
Date: Tue, 19 Jan 2016 15:44:50 -0500
Subject: [PATCH] sparc: Fix system call tracing register handling.

A system call trace trigger on entry allows the tracing
process to inspect and potentially change the traced
process's registers.

Account for that by reloading the %g1 (syscall number)
and %i0-%i5 (syscall argument) values.  We need to be
careful to revalidate the range of %g1, and reload the
system call table entry it corresponds to into %l7.

Reported-by: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/entry.S    |   17 +++++++++++++++++
 arch/sparc/kernel/syscalls.S |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 33c02b1..a83707c 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -948,7 +948,24 @@ linux_syscall_trace:
 	cmp	%o0, 0
 	bne	3f
 	 mov	-ENOSYS, %o0
+
+	/* Syscall tracing can modify the registers.  */
+	ld	[%sp + STACKFRAME_SZ + PT_G1], %g1
+	sethi	%hi(sys_call_table), %l7
+	ld	[%sp + STACKFRAME_SZ + PT_I0], %i0
+	or	%l7, %lo(sys_call_table), %l7
+	ld	[%sp + STACKFRAME_SZ + PT_I1], %i1
+	ld	[%sp + STACKFRAME_SZ + PT_I2], %i2
+	ld	[%sp + STACKFRAME_SZ + PT_I3], %i3
+	ld	[%sp + STACKFRAME_SZ + PT_I4], %i4
+	ld	[%sp + STACKFRAME_SZ + PT_I5], %i5
+	cmp	%g1, NR_syscalls
+	bgeu	3f
+	 mov	-ENOSYS, %o0
+
+	sll	%g1, 2, %l4
 	mov	%i0, %o0
+	ld	[%l7 + %l4], %l7
 	mov	%i1, %o1
 	mov	%i2, %o2
 	mov	%i3, %o3
diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index bb00089..c4a1b5c 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -158,7 +158,25 @@ linux_syscall_trace32:
 	 add	%sp, PTREGS_OFF, %o0
 	brnz,pn	%o0, 3f
 	 mov	-ENOSYS, %o0
+
+	/* Syscall tracing can modify the registers.  */
+	ldx	[%sp + PTREGS_OFF + PT_V9_G1], %g1
+	sethi	%hi(sys_call_table32), %l7
+	ldx	[%sp + PTREGS_OFF + PT_V9_I0], %i0
+	or	%l7, %lo(sys_call_table32), %l7
+	ldx	[%sp + PTREGS_OFF + PT_V9_I1], %i1
+	ldx	[%sp + PTREGS_OFF + PT_V9_I2], %i2
+	ldx	[%sp + PTREGS_OFF + PT_V9_I3], %i3
+	ldx	[%sp + PTREGS_OFF + PT_V9_I4], %i4
+	ldx	[%sp + PTREGS_OFF + PT_V9_I5], %i5
+
+	cmp	%g1, NR_syscalls
+	bgeu,pn	%xcc, 3f
+	 mov	-ENOSYS, %o0
+
+	sll	%g1, 2, %l4
 	srl	%i0, 0, %o0
+	lduw	[%l7 + %l4], %l7
 	srl	%i4, 0, %o4
 	srl	%i1, 0, %o1
 	srl	%i2, 0, %o2
@@ -170,7 +188,25 @@ linux_syscall_trace:
 	 add	%sp, PTREGS_OFF, %o0
 	brnz,pn	%o0, 3f
 	 mov	-ENOSYS, %o0
+
+	/* Syscall tracing can modify the registers.  */
+	ldx	[%sp + PTREGS_OFF + PT_V9_G1], %g1
+	sethi	%hi(sys_call_table64), %l7
+	ldx	[%sp + PTREGS_OFF + PT_V9_I0], %i0
+	or	%l7, %lo(sys_call_table64), %l7
+	ldx	[%sp + PTREGS_OFF + PT_V9_I1], %i1
+	ldx	[%sp + PTREGS_OFF + PT_V9_I2], %i2
+	ldx	[%sp + PTREGS_OFF + PT_V9_I3], %i3
+	ldx	[%sp + PTREGS_OFF + PT_V9_I4], %i4
+	ldx	[%sp + PTREGS_OFF + PT_V9_I5], %i5
+
+	cmp	%g1, NR_syscalls
+	bgeu,pn	%xcc, 3f
+	 mov	-ENOSYS, %o0
+
+	sll	%g1, 2, %l4
 	mov	%i0, %o0
+	lduw	[%l7 + %l4], %l7
 	mov	%i1, %o1
 	mov	%i2, %o2
 	mov	%i3, %o3
-- 
1.7.2.5

