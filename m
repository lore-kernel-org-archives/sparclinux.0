Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F753EC837;
	Tue, 15 Sep 2026 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471905; cv=none; b=LALcA+snpkQ4J7SYGE2u6We35oYCEJfqx7Eiruseum9qI4JohZ9lPOIT0AnZMcQ/rsAvFuobvBgueKsk+k5tDVxcSRs5VdPzUBQWXD1KqKeXOOMJUfCe8NtHPGTZ7xt2F9oqe6G/mokX8c6KYyOPSuaqCmSc8zyixpnEsv/K7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471905; c=relaxed/simple;
	bh=RHaKINpzdp/l9rjcdl2huzzYgE91Xjm8KSEi0tjemx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LBOj3DzfWWOi0vm9o6/bzx9FmJ2aJfJlea1i6VDWDv+6ne5mU6FGIU/pvos9dvbysHQRJA96g0lb7coldmsq+IvbO244Z7JITASfaXQntWt/HwnbqCNgn7dWjyLygRqruy5hzQHq8KY1cuWTp5+HobZGFXKbI9CiPM9+kaluXjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7x382Hn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7x382Hn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38BA1F000FF;
	Tue, 15 Sep 2026 11:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471903;
	bh=XMEKWie9jF24t7TYFlO7sbFAQBsdl6e/pxJpNAPN2Sg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=i7x382Hnnkl9/28oqzb0mWvS6zSI4aiPrUmgqyFCmzCN9moF5QbSnsvMPDmf6jsFE
	 20sY8viNkieJZbQC/m/uoRnsZDoZFxiObsIH/1onHcojg8Na5KA8WBmzAnwM4xe7nv
	 cWuvmngGAmVYJETI1rRmztQmkMvwsRgO4LmnzxxzIad+JvmPwmUPG7wVIXCYGBiA0I
	 mqlaXmYHiuxvamjCZ59B9hIoZAdp2d3/z0azbHRAvvW4HC6KY9c6HyzfMGBsxUC5KA
	 wQsLl2gTta2JoSnUidFFvBDUQCl+fjxiaYkM5A0OZHt6XgJeW93tAdk20XFiFzz/9p
	 9i6uz6bpnbytg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:30:49 +0200
Subject: [PATCH RFC POC 03/50] alpha: commit fds on syscall exit
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-3-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3840; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RHaKINpzdp/l9rjcdl2huzzYgE91Xjm8KSEi0tjemx0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KnZvvtgiPkBlSLl5w330l/eiLM07dLKTdyvJ/x9U
 swK10XpHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5uouRobnvtNDzWTUxee+k
 GNbq6gjNkn34863ehHMFswpYD6708Gb47zR1+f3CeV+t1HumyzefFry5dVXvk12PN5yNOaLxR90
 pnAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add TIF_FD_SLOTS and test it once the untraced system call has stored
its result. A task that reserved descriptors calls syscall_trace_leave()
and joins ret_from_sys_call with the flag gone.

We mirror the traced error path where the switch stack is set up and the
return address and the syscall restart state are placed in callee-saved
registers.

Btw, let's remove alpha... It's a pain.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/alpha/include/asm/thread_info.h |  2 ++
 arch/alpha/kernel/entry.S            | 24 +++++++++++++++++++++++-
 arch/alpha/kernel/ptrace.c           |  3 +++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/thread_info.h b/arch/alpha/include/asm/thread_info.h
index 1552ecca8520..db8465f5fabb 100644
--- a/arch/alpha/include/asm/thread_info.h
+++ b/arch/alpha/include/asm/thread_info.h
@@ -67,6 +67,7 @@ register unsigned long *current_stack_pointer __asm__ ("$30");
 #define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
 #define TIF_SECCOMP		6	/* seccomp syscall filtering active */
 #define	TIF_SYSCALL_TRACEPOINT	7	/* syscall tracepoint instrumentation */
+#define TIF_FD_SLOTS		8	/* syscall prepared descriptors */
 #define TIF_DIE_IF_KERNEL	9	/* dik recursion lock */
 #define TIF_MEMDIE		13	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	14	/* idle is polling for TIF_NEED_RESCHED */
@@ -80,6 +81,7 @@ register unsigned long *current_stack_pointer __asm__ ("$30");
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
+#define _TIF_FD_SLOTS		(1<<TIF_FD_SLOTS)
 
 /*
  * Work to do on syscall entry (in entry.S).
diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index 9f2608de2544..20372e926359 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -569,6 +569,13 @@ entSys:
 $ret_success:
 	stq	$0, 0($sp)
 	stq	$31, 72($sp)		/* a3=0 => no error */
+$syscall_exit:
+	/* Descriptors reserved by the syscall are committed in
+	   syscall_trace_leave, off the return path interrupts share.  */
+	ldl	$17, TI_FLAGS($8)
+	lda	$2, _TIF_FD_SLOTS
+	and	$17, $2, $2
+	bne	$2, $fd_slots_exit
 
 	.align	4
 	.globl	ret_from_sys_call
@@ -612,7 +619,7 @@ $syscall_error:
 	stq	$0, 0($sp)
 	mov	$31, $26	/* tell "ret_from_sys_call" we can restart */
 	stq	$1, 72($sp)	/* a3 for return */
-	br	ret_from_sys_call
+	br	$syscall_exit
 
 /*
  * Do all cleanup when returning from all interrupts and system calls.
@@ -648,6 +655,21 @@ $work_notifysig:
 	UNDO_SWITCH_STACK
 	br	restore_all
 
+	.align	4
+$fd_slots_exit:
+	/* Keep the return address and the syscall restart state in
+	   $26/$18/$19 across the call.  */
+	DO_SWITCH_STACK
+	mov	$26, $9
+	mov	$18, $10
+	mov	$19, $11
+	jsr	$26, syscall_trace_leave
+	mov	$9, $26
+	mov	$10, $18
+	mov	$11, $19
+	UNDO_SWITCH_STACK
+	br	ret_from_sys_call
+
 /*
  * PTRACE syscall handler
  */
diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
index fc8f6cedbb28..736218b34601 100644
--- a/arch/alpha/kernel/ptrace.c
+++ b/arch/alpha/kernel/ptrace.c
@@ -6,6 +6,7 @@
 /* more mutilation by David Mosberger (davidm@azstarnet.com) */
 
 #include <linux/kernel.h>
+#include <linux/file.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/mm.h>
@@ -507,6 +508,8 @@ asmlinkage unsigned long syscall_trace_enter(void)
 asmlinkage void
 syscall_trace_leave(void)
 {
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(current_pt_regs());
 	audit_syscall_exit(current_pt_regs());
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		ptrace_report_syscall_exit(current_pt_regs(), 0);

-- 
2.53.0

