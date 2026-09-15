Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143312F8E8A;
	Tue, 15 Sep 2026 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472005; cv=none; b=JBs3h54KlI8re5JpqtYAS9r3Ljb9QEZEFhHR65Df6TWw72KdFTlVYNbDwBm61/hF9/3Jkh1EJPJhKhBSZ/PXuLse4TSa63n7K5xCeji4dKsxfCH/CjVkP0IXQlEVxSVubplsdWjn+8RGnIJ2qm7C/Zyo6Y5UZI8jBA2SEgO8M0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472005; c=relaxed/simple;
	bh=pmbItuaGjYhqGPqyFZ/vQ3bw6O4Agi1po5EvnXuKgAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S5RhTibGwKwxdHC4u/pS4sRzgWtM0NjjgppwoQ14gY/Cd9F+RJ3yYLqLuRiEYgXbemyCxSHQ07ABEHogsqcQolTJ5Ti/rCNsukQ/qNQdFbWae7b4C5j8vs7QFgFv4uMKHYNkYQKp5AJs7ypXPtwrg5Njo/e5xydl2kz8/qzqQAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3o4Ofqw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3o4Ofqw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E0B1F00893;
	Tue, 15 Sep 2026 11:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472003;
	bh=5pDTYibtotoJl0CfBpt6utVDR2mfl4I4vpQdvs8YOz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b3o4OfqwaaazxAeRj/9Gk+rfkrUg7U0vI6JKs41UHHO10m4El4MPR0Sa+EE2Gn36Z
	 JbZmIMb8qLAtadMRwVadqK0bIP8UDUY4u9lCU6f1ugKbhwheYaNkZU/jT+i4Dv1Jl9
	 iSky0rNqGXpj8pMhwujZIwbQHG7ClelfVDOe+So8VfCSthJENcXqjh0059JfLailqW
	 emN+KAXu8UUFnpvYfDn0atcumjm+ShG8MC7FrqvcAxOpAeul4vea+zYnk6otK0pmNa
	 VCFcB52eVERu7FbBBcw9uj72b8Lk1KHXA5mpSreLxYJMokQq6XzH3u5VGfdEMuIA0u
	 VKtgipEWo0wug==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:02 +0200
Subject: [PATCH RFC POC 16/50] sparc: commit fds on syscall exit
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-16-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
 io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>, 
 virtualization@lists.linux.dev, kvm@vger.kernel.org, 
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=6251; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pmbItuaGjYhqGPqyFZ/vQ3bw6O4Agi1po5EvnXuKgAA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KmNrfkT+/ZOoMD81otBR7+qPEnjKjXl+DDvernoB
 8aVLipdHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPRrmH4Z/WrKjlPiWfpjeMh
 +/UOr9OUYuVN+MrcGf8r+7t7cIlFMyPD/eNVJ7U/2tpNS1Kb+nTNq0L7h/NS/upwScjx8VlbzD3
 GAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add TIF_FD_SLOTS and test it together with the other syscall exit
work on the way out of a system call. A task that reserved
descriptors calls syscall_trace() on sparc32 and syscall_trace_leave()
on sparc64.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/sparc/include/asm/thread_info_32.h | 2 ++
 arch/sparc/include/asm/thread_info_64.h | 9 ++++++++-
 arch/sparc/kernel/entry.S               | 2 +-
 arch/sparc/kernel/ptrace_32.c           | 4 ++++
 arch/sparc/kernel/ptrace_64.c           | 4 ++++
 arch/sparc/kernel/syscalls.S            | 4 +++-
 6 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/thread_info_32.h b/arch/sparc/include/asm/thread_info_32.h
index fdaf7b171e0a..fbd7af6bb427 100644
--- a/arch/sparc/include/asm/thread_info_32.h
+++ b/arch/sparc/include/asm/thread_info_32.h
@@ -105,6 +105,7 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_RESTORE_SIGMASK	4	/* restore signal mask in do_signal() */
 #define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
+#define TIF_FD_SLOTS		6	/* syscall prepared descriptors */
 #define TIF_USEDFPU		8	/* FPU was used by this task
 					 * this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	9	/* true if poll_idle() is polling
@@ -117,6 +118,7 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
+#define _TIF_FD_SLOTS		(1<<TIF_FD_SLOTS)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index c8a73dff27f8..890ee65d9029 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -180,7 +180,7 @@ extern struct thread_info *current_thread_info(void);
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_NOTIFY_SIGNAL	4	/* signal notifications exist */
-#define TIF_UNALIGNED		5	/* allowed to do unaligned accesses */
+#define TIF_FD_SLOTS		5	/* syscall prepared descriptors */
 #define TIF_UPROBE		6	/* breakpointed or singlestepped */
 #define TIF_32BIT		7	/* 32-bit binary */
 #define TIF_NOHZ		8	/* in adaptive nohz mode */
@@ -194,12 +194,14 @@ extern struct thread_info *current_thread_info(void);
 #define TIF_MCDPER		12	/* Precise MCD exception */
 #define TIF_MEMDIE		13	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	14
+#define TIF_UNALIGNED		15	/* allowed to do unaligned accesses */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
+#define _TIF_FD_SLOTS		(1<<TIF_FD_SLOTS)
 #define _TIF_UNALIGNED		(1<<TIF_UNALIGNED)
 #define _TIF_UPROBE		(1<<TIF_UPROBE)
 #define _TIF_32BIT		(1<<TIF_32BIT)
@@ -209,6 +211,11 @@ extern struct thread_info *current_thread_info(void);
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
+/* work to do in syscall_trace_leave() */
+#define _TIF_SYSCALL_EXIT_WORK	(_TIF_SYSCALL_TRACE | _TIF_SECCOMP | \
+				 _TIF_SYSCALL_AUDIT | _TIF_SYSCALL_TRACEPOINT | \
+				 _TIF_NOHZ | _TIF_FD_SLOTS)
+
 #define _TIF_USER_WORK_MASK	((0xff << TI_FLAG_WSAVED_SHIFT) | \
 				 _TIF_DO_NOTIFY_RESUME_MASK | \
 				 _TIF_NEED_RESCHED)
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index ea51ef52c952..d2023b84db9e 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -1023,7 +1023,7 @@ ret_sys_call:
 	ld	[%sp + STACKFRAME_SZ + PT_PSR], %g3
 	set	PSR_C, %g2
 	bgeu	1f
-	 andcc	%l5, _TIF_SYSCALL_TRACE, %g0
+	 andcc	%l5, (_TIF_SYSCALL_TRACE | _TIF_FD_SLOTS), %g0
 
 	/* System call success, clear Carry condition code. */
 	andn	%g3, %g2, %g3
diff --git a/arch/sparc/kernel/ptrace_32.c b/arch/sparc/kernel/ptrace_32.c
index 5991b1731fee..042e60685418 100644
--- a/arch/sparc/kernel/ptrace_32.c
+++ b/arch/sparc/kernel/ptrace_32.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/file.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/errno.h>
@@ -437,6 +438,9 @@ asmlinkage int syscall_trace(struct pt_regs *regs, int syscall_exit_p)
 {
 	int ret = 0;
 
+	if (syscall_exit_p && test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(regs);
+
 	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
 		if (syscall_exit_p)
 			ptrace_report_syscall_exit(regs, 0);
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 825ddf55fece..499b30c505fd 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/file.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/mm.h>
@@ -1110,6 +1111,9 @@ asmlinkage void syscall_trace_leave(struct pt_regs *regs)
 	if (test_thread_flag(TIF_NOHZ))
 		user_exit();
 
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(regs);
+
 	audit_syscall_exit(regs);
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index 96fe8763d70c..086fb8eaf133 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -269,10 +269,12 @@ ret_sys_call:
 	ldx	[%sp + PTREGS_OFF + PT_V9_TSTATE], %g3
 	mov	%ulo(TSTATE_XCARRY | TSTATE_ICARRY), %g2
 	sllx	%g2, 32, %g2
+	/* Reload the flags, the syscall may have set TIF_FD_SLOTS. */
+	ldx	[%g6 + TI_FLAGS], %l0
 
 	cmp	%o0, -ERESTART_RESTARTBLOCK
 	bgeu,pn	%xcc, 1f
-	 andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT|_TIF_NOHZ), %g0
+	 andcc	%l0, _TIF_SYSCALL_EXIT_WORK, %g0
 	ldx	[%sp + PTREGS_OFF + PT_V9_TNPC], %l1 ! pc = npc
 
 2:

-- 
2.53.0

