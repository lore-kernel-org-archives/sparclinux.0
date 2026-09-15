Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B006B471D1C;
	Tue, 15 Sep 2026 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471898; cv=none; b=JECDMsU5+k9n4qftGYfEGnrQEr1mr3btHQ3kiyagp8FojObabBr5Xg25+9MJYEVsk3MQHXCVf0Dwk7qC8E2OxbmQMY8lKVcxwV96W/yNaYkf1vDlCsYUi8N6plDSGKGKgSXObhZjxpYIPWMyMvt3JDxSjKy302szTgRekqnFGLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471898; c=relaxed/simple;
	bh=NtpqRPTNAZlEeaPhe0rYOorWsOpjpNCIyBf0GHcmRWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A29x8Y1iEzcaywHb+8AIkoGtH0K9o/LbPtu/9PBf415rSb7eeiL7eVOWpuP46G6UrTGEzRjtI5ifCeanZTLb6GdkUkKKxebjrn8dv+rfEpkRdJ6hTqbEgpDSoq0LQGJUt1B/o2GJnM87x00/UmeWGH+gPqM63Ti5vlQkA0T9Isc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA99JUjo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA99JUjo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D9E1F00898;
	Tue, 15 Sep 2026 11:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471896;
	bh=H/Q2uFiWqDBb8xqHpNo0BQBrMpfRMKZw5TP1oZm+kmg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FA99JUjog1yV1DbWoG2ziqsNO+0sw6EHhtLDfJByBVRaUjyRjJwu1VFldCsris1pZ
	 e2wCrK7C66Yw9jz989T8vHtdcQycYZY1aOUXtThwXFvZsxHJJ78r7g7qoZrOOkMU/s
	 lj0gTkb4Mh3TKCRQmb0rlBwKhGV75TJbATZem6Sjbrdch9yj+/sxhbvRUPzaeynzTg
	 lmZfZ3Gj1rUe2RlV3+OteWTMGEeRJFR//N1tZnHmdQHnT01ZVBDm1L4xmKQwmCU+jR
	 umSCRuNroMIzP8zt6GPqOvmEIb6PE+fF3iEwa5/6zDnWWP2+oNJbKhA8JiapM5A8Pv
	 P/GWj9Gp89ypA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:30:48 +0200
Subject: [PATCH RFC POC 02/50] entry: commit fds on syscall exit
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-2-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5066; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NtpqRPTNAZlEeaPhe0rYOorWsOpjpNCIyBf0GHcmRWk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KnJVo3fvV5S5/Sii+rtiZfVW3bllXHI7rc8Ks4gk
 ree7ZZuRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQusDD8Lz+/bproy5BneSeO
 7On6+Fbpk7eF5doft2tsDJMENZ0vdjP89zl45Kb3WpH+yPBZEx9N/6r6VywwdGaxQ76IV1yGifk
 iNgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Reserving a descriptor with fd_prepare() marks the task with
SYSCALL_WORK_FD_SLOTS. The syscall exit path already tests the
syscall work bits so a syscall that deferred nothing pays nothing new
and one that did takes the slow path. syscall_exit_work() commits the
reservations before audit and ptrace.

Architectures without the generic entry code grow TIF_FD_SLOTS bit in
their syscall exit work in the following patches.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c                    | 24 ++++++++++++++++++++++++
 include/linux/entry-common.h |  8 +++++++-
 include/linux/file.h         |  2 ++
 include/linux/thread_info.h  |  2 ++
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index 90351241bb07..6fa481d63dcf 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -23,6 +23,7 @@
 #include <linux/file_ref.h>
 #include <net/sock.h>
 #include <linux/init_task.h>
+#include <asm/syscall.h>
 
 #include "internal.h"
 
@@ -643,6 +644,19 @@ static void fd_release(unsigned int fd)
 /* Enough for SCM_MAX_FD, and a page of slots on 4K pages. */
 #define FD_SLOTS_SPILL_MIN	256
 
+/* Make the syscall exit path call fd_slots_commit(). */
+#if defined(CONFIG_GENERIC_ENTRY)
+#define fd_slots_set_work()	set_syscall_work(FD_SLOTS)
+#define fd_slots_clear_work()	clear_syscall_work(FD_SLOTS)
+#elif defined(TIF_FD_SLOTS)
+#define fd_slots_set_work()	set_thread_flag(TIF_FD_SLOTS)
+#define fd_slots_clear_work()	clear_thread_flag(TIF_FD_SLOTS)
+#else
+/* Nothing commits until the architecture provides the flag. */
+#define fd_slots_set_work()	do { } while (0)
+#define fd_slots_clear_work()	do { } while (0)
+#endif
+
 static struct fd_slot *fd_slot(struct fd_slots *slots, unsigned int idx)
 {
 	if (idx < FD_SLOTS_INLINE)
@@ -690,6 +704,8 @@ static struct fd_slot *fd_slot_record(int fd)
 	}
 	ACCESS_PRIVATE(slot, fd) = fd;
 	ACCESS_PRIVATE(slot, file) = NULL;
+	if (!idx)
+		fd_slots_set_work();
 	slots->nr = idx + 1;
 	return slot;
 }
@@ -809,6 +825,14 @@ static __always_inline void fd_slots_finish(struct fd_slots *slots, bool failed)
 	else
 		fd_slots_drop(slots);
 	slots->nr = 0;
+	fd_slots_clear_work();
+}
+
+/* Syscall exit hook, keyed on the return value the caller will see. */
+void fd_slots_commit(struct pt_regs *regs)
+{
+	fd_slots_finish(&current->fd_slots,
+			syscall_get_error(current, regs) != 0);
 }
 
 /* Install or drop the prepared descriptors based on @ret. */
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 6574b7183c01..2da30e50cf59 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -3,6 +3,7 @@
 #define __LINUX_ENTRYCOMMON_H
 
 #include <linux/audit.h>
+#include <linux/file.h>
 #include <linux/irq-entry-common.h>
 #include <linux/livepatch.h>
 #include <linux/ptrace.h>
@@ -36,7 +37,8 @@
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
 				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
-				 SYSCALL_WORK_SYSCALL_EXIT_TRAP)
+				 SYSCALL_WORK_SYSCALL_EXIT_TRAP |	\
+				 SYSCALL_WORK_FD_SLOTS)
 
 /**
  * arch_ptrace_report_syscall_permit_entry - Architecture specific wrapper for
@@ -245,6 +247,10 @@ static __always_inline void syscall_exit_work(struct pt_regs *regs, unsigned lon
 {
 	bool step;
 
+	/* Install or drop the descriptors the syscall prepared. */
+	if (work & SYSCALL_WORK_FD_SLOTS)
+		fd_slots_commit(regs);
+
 	/*
 	 * If the syscall was rolled back due to syscall user dispatching,
 	 * then the tracers below are not invoked for the same reason as
diff --git a/include/linux/file.h b/include/linux/file.h
index fe2893eea945..04dd85cdd9bf 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -92,6 +92,8 @@ extern int __get_unused_fd_flags(unsigned flags, unsigned long nofile);
 extern int get_unused_fd_flags(unsigned flags);
 extern void put_unused_fd(unsigned int fd);
 void __fd_slots_commit(long ret);
+struct pt_regs;
+void fd_slots_commit(struct pt_regs *regs);
 void exit_fd_slots(void);
 
 DEFINE_CLASS(get_unused_fd, int, if (_T >= 0) put_unused_fd(_T),
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 307b8390fc67..c80a87444286 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -47,6 +47,7 @@ enum syscall_work_bit {
 	SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH,
 	SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP,
 	SYSCALL_WORK_BIT_SYSCALL_RSEQ_SLICE,
+	SYSCALL_WORK_BIT_FD_SLOTS,
 };
 
 #define SYSCALL_WORK_SECCOMP			BIT(SYSCALL_WORK_BIT_SECCOMP)
@@ -57,6 +58,7 @@ enum syscall_work_bit {
 #define SYSCALL_WORK_SYSCALL_USER_DISPATCH	BIT(SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH)
 #define SYSCALL_WORK_SYSCALL_EXIT_TRAP		BIT(SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP)
 #define SYSCALL_WORK_SYSCALL_RSEQ_SLICE		BIT(SYSCALL_WORK_BIT_SYSCALL_RSEQ_SLICE)
+#define SYSCALL_WORK_FD_SLOTS			BIT(SYSCALL_WORK_BIT_FD_SLOTS)
 #endif
 
 #include <asm/thread_info.h>

-- 
2.53.0

