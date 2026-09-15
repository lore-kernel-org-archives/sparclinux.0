Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C339E4A9D42;
	Tue, 15 Sep 2026 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471967; cv=none; b=dP7yQEviVrVdTdousCrS89kiKkAN/Q2T3qE2T4fmwRRyS3LsAgUHNgGWVHqX/CTjmZM9SaNmQGI8KGtQLPs7QUTG/M+CebENWVf9T87l0NCEQOYG55/ZbQ3e2/YuU9QoNMXVpeXxmu/G+Rj0zGWUkIlhCp/U2Z14JoVwtRdtcAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471967; c=relaxed/simple;
	bh=O2Sy8b10JPTSM3T8FMxCg3yxJ2yYFrKaQgz1RZTqrDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hb1tRBfF1SDSOJ9RPs4d5KIVhV00IPdrzzuG4KqhB4tCpkMqVvTLe0yISZ+ZFLB0wDnFL7e1nv7gIaoMqMhj9Mj32a5fN8VORi04ugLqvINws0/ew/zLktuBNxAufeZPe/COMAwJyEtav0qrnwAI+oqehzDcE36wAHLh+KH/knU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCq0TREx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCq0TREx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A7F1F000FF;
	Tue, 15 Sep 2026 11:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471965;
	bh=lhrRWmW1jhLpY0b4T+pXdyq2K6/6Lw3I7Dd8oxsFe60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dCq0TRExcU+BlQDM8hy6Cs9E6uwVSlfYujcFmaPmD6BlHGcwf1zlVdOj4iekia6nX
	 al4ANJBJ1tX6VX0/MptbgzlPojdMZvifh4Xr1Iux25MunfDMJ0ZdADzgOLF+MDBHzN
	 VJjSchXj7ycWNCGrw0+tgXtNpK5YAPLTUsheMDknEO+8eH1b0rnpbuY1zSztCCnVfA
	 GRrWZUAcC9RH0jbS0xHcc8vRlak+IYa8EXS78G0mBcqGwylEICLDemOC/lzCP+aOI8
	 4k5cX3F/404vMcxuo7rNpXN7ULTgziEBKlCxV3cgzN4zcwdBCL7BCfVwLs7N1a0luj
	 JpfRAWBOJ7VYQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:30:57 +0200
Subject: [PATCH RFC POC 11/50] MIPS: commit fds on syscall exit
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-11-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2696; i=brauner@kernel.org;
 h=from:subject:message-id; bh=O2Sy8b10JPTSM3T8FMxCg3yxJ2yYFrKaQgz1RZTqrDM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KmVfhLzX2amjpDLni+t5iy5HyJ8fnfYuQs5t239d
 4fnocLijlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImcVGP4H7v0ThyX7L2OzssZ
 Dg/usvC4O0iFJConhHNZcXS9mtKnwfBPb1pj+VPfVuVgW/nrzUqNt57OOi2ptdSndP/0CbwHHU/
 xAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add TIF_FD_SLOTS to the syscall exit work. The return path rereads
the flags after the system call and calls syscall_trace_leave() for
any of the exit work bits which commits the reservations before audit
and the ptrace exit stop.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/mips/include/asm/thread_info.h | 5 ++++-
 arch/mips/kernel/ptrace.c           | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 2707dad260dd..79c81696e9c1 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -114,6 +114,7 @@ register unsigned long current_stack_pointer __asm__("sp");
 #define TIF_NOTIFY_RESUME	5	/* callback before returning to user */
 #define TIF_UPROBE		6	/* breakpointed or singlestepping */
 #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
+#define TIF_FD_SLOTS		8	/* syscall prepared descriptors */
 #define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
@@ -152,6 +153,7 @@ register unsigned long current_stack_pointer __asm__("sp");
 #define _TIF_USEDMSA		(1<<TIF_USEDMSA)
 #define _TIF_MSA_CTX_LIVE	(1<<TIF_MSA_CTX_LIVE)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
+#define _TIF_FD_SLOTS		(1<<TIF_FD_SLOTS)
 
 #define _TIF_WORK_SYSCALL_ENTRY	(_TIF_NOHZ | _TIF_SYSCALL_TRACE |	\
 				 _TIF_SYSCALL_AUDIT | \
@@ -159,7 +161,8 @@ register unsigned long current_stack_pointer __asm__("sp");
 
 /* work to do in syscall_trace_leave() */
 #define _TIF_WORK_SYSCALL_EXIT	(_TIF_NOHZ | _TIF_SYSCALL_TRACE |	\
-				 _TIF_SYSCALL_AUDIT | _TIF_SYSCALL_TRACEPOINT)
+				 _TIF_SYSCALL_AUDIT | _TIF_SYSCALL_TRACEPOINT | \
+				 _TIF_FD_SLOTS)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK		\
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 17dc7249b8ca..d68eab59bcc2 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -17,6 +17,7 @@
 #include <linux/compiler.h>
 #include <linux/context_tracking.h>
 #include <linux/elf.h>
+#include <linux/file.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
@@ -1364,6 +1365,9 @@ asmlinkage void syscall_trace_leave(struct pt_regs *regs)
 	 */
 	user_exit();
 
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(regs);
+
 	audit_syscall_exit(regs);
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))

-- 
2.53.0

