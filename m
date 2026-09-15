Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B694649DBAA;
	Tue, 15 Sep 2026 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471936; cv=none; b=CjW7fyiugtGAGtyRHZLJ4pMytXcL1Iu1HnqsGQ6fTCf7SQ0xtzWq5U/0cgkEF3k4OMFtqULWe0RFpQtOJ4Cc0AB6q8wNSvtIWBpy1sLilYnA1+vLyBRJc577XTBFhcdyBnm7ZLFhTE/fPCZ6U0T7K7kWcSiCsOaEMCUscIPEzac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471936; c=relaxed/simple;
	bh=a9znqAkO+hvOtZefxwIBQ5T2UBtQYyo8n09NKXNA7dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bcnmGEq/gJOESOg0YH7Khy8f2bQJO+8UVDWC9kdZO+kEe1y9GLsuL7Ea5QOfR7rwnfHj25nr0kGnfOsZaRkgiPd6jBlgXzZPlMY1lL6uDzj153rPekV2sgCb6vc6bYRJhkZyERG04/Nyu6SRvaSB3u0FJPgMFT9vlS7UVRItbmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUEfB7kz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUEfB7kz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD8B1F000FF;
	Tue, 15 Sep 2026 11:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471934;
	bh=E/WcE2lGsMFSob/cBMgO+hea6aPl2xaxNOKxSHdhki0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GUEfB7kz965znZtfpHqb8eIiCiLO6486hnBmkQwRyzaxNwEFt42WOgfKGny2AO9jY
	 DpqE0IKoYZQ3CDqUbNbcjMdJnHniI4Fwuvms6GgbMB9wf1VAHv7229/U9I1vFe9NJ2
	 qY36omvqqIoX9NFkJOdvBvJQPo9mZFT+l30lGkj4F5tMWGVWdBHQTO1lqNMxuFrqVO
	 OfO8kqQ7j1k9tC1TlYJ8bqUqsF+G/mO7jEhf7l0Ip9oOnDoxcn+y9v2WqMllKuuodC
	 iV25Lg90bMELqmrBnnnzxEgH4HOX9MN+zPjb9ZEZ2BQQYFgld28sSUlqTUgIhK2Mo5
	 y/yD7KaWeZ/WQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:30:53 +0200
Subject: [PATCH RFC POC 07/50] csky: commit fds on syscall exit
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-7-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2976; i=brauner@kernel.org;
 h=from:subject:message-id; bh=a9znqAkO+hvOtZefxwIBQ5T2UBtQYyo8n09NKXNA7dw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KmReJL5+9/LafuaZn07vvD2NNsTS/r9pju0zTneI
 MsZ4PDocUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE4p0Z/vsI/l1WJ+2YWb1+
 rv5bmZs79nw5b7JPKv5J5eJeHt8sXQeG/zUtrlyha6a8POM74Rhn8++6CEYXZZkjm45o/epqCbm
 3lRkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add TIF_FD_SLOTS and test it after the untraced system call has
stored its return value. A task that reserved descriptors joins the
traced path, where syscall_trace_exit() commits them before audit and
the ptrace exit stop.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/csky/include/asm/thread_info.h | 2 ++
 arch/csky/kernel/entry.S            | 9 +++++++++
 arch/csky/kernel/ptrace.c           | 4 ++++
 3 files changed, 15 insertions(+)

diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index fdd4f8ad45ac..59109ce64695 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -61,6 +61,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SYSCALL_TRACEPOINT	5       /* syscall tracepoint instrumentation */
 #define TIF_SYSCALL_AUDIT	6	/* syscall auditing */
 #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
+#define TIF_FD_SLOTS		8	/* syscall prepared descriptors */
 #define TIF_POLLING_NRFLAG	16	/* poll_idle() is TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18      /* is terminating due to OOM killer */
 #define TIF_RESTORE_SIGMASK	20	/* restore signal mask in do_signal() */
@@ -73,6 +74,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
+#define _TIF_FD_SLOTS		(1 << TIF_FD_SLOTS)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 3261f46f2244..6ff3074b9787 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -80,6 +80,15 @@ ENTRY(csky_systemcall)
 	jsr     syscallid
 #endif
 	stw     a0, (sp, LSAVE_A0)      /* Save return value */
+	/* descriptors reserved by the syscall are committed in syscall_trace_exit() */
+	mov     r9, sp
+	bmaski  r10, THREAD_SHIFT
+	andn    r9, r10
+	ldw     r10, (r9, TINFO_FLAGS)
+	lrw	r9, _TIF_FD_SLOTS
+	and	r10, r9
+	cmpnei	r10, 0
+	bt      1f
 	jmpi    ret_from_exception
 
 csky_syscall_trace:
diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index ee2867a1576e..b19fef9d396d 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -4,6 +4,7 @@
 #include <linux/audit.h>
 #include <linux/elf.h>
 #include <linux/errno.h>
+#include <linux/file.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/ptrace.h>
@@ -335,6 +336,9 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 
 asmlinkage void syscall_trace_exit(struct pt_regs *regs)
 {
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(regs);
+
 	audit_syscall_exit(regs);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))

-- 
2.53.0

