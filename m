Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E934A3851;
	Tue, 15 Sep 2026 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472014; cv=none; b=ej8NPyImHKyRBLMCkQhhirVVNE9H4+64KuGN3/oCHYvA9ojR2FAkIl8AYb1JTdjeuurKkkQWwaAunzZTIWpJNKM2hl3x+MP80BUTOctrjCmfp0f82vaavmsks2rWAA3upYkPn/IrA3h5aDmN0N0kJ3sB+ieVnhG2PL62n0f9aUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472014; c=relaxed/simple;
	bh=S9sXo+/yQO9aORTIGU5zP9aw99mbVPSatnA1JIW5H/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9/8MhcZOBXgS//8q3N0Lh0uHQSKN0dfp+oGR6Fg5ssdqx0FTkDS3KlGnSec7n1ATKfgbKYhwdGwnw2Vomg1lnJL8dDXR8ehbNbc4A8k9kcqAXG3MNslgc9JmxCGSMCNRm+hrVhIwCH18lwgaG4K050w1wLkhqwIi9fa2H3LAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUmSavNi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUmSavNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8D71F00898;
	Tue, 15 Sep 2026 11:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472011;
	bh=LsNpEFA01NMLmoDGH+WQ2k5w2caYKI3aFXCKnW6fq4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jUmSavNiamqp7sEiSGUpt1XZfKBJkPkcG/PFCGuuE8ULC/JC+9Uv/jivWwgpx6a/O
	 ndFuFYQRnEyeD6+NTxQCHA1WQfYk7Jmw39axkxPneZ0ZlWHflWnPtQntegHAjSQOHr
	 qvPuy2KIMTAU8QpGMIZajMcBNJZLx1KDydcGwu/7Fq4Sm2suht1GMp/5OShBghjByJ
	 Wo0vc/D/MORpmKTNOKDNlY4+TTriFUPTu4Y02yC+j0UyASaEIruvlKlSwBV+MXdIZL
	 vi9GUupn2o56nWtYus7diY/kBIvVMBlvyHSKLH2hV7NTFX1VBgWRv0lAAGJXCHoiGT
	 eaCHwlU6HAvXg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:03 +0200
Subject: [PATCH RFC POC 17/50] um: commit fds on syscall exit
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-17-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865; i=brauner@kernel.org;
 h=from:subject:message-id; bh=S9sXo+/yQO9aORTIGU5zP9aw99mbVPSatnA1JIW5H/M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KldP/NzGWPyQ7vZ1w8Z91Y4Xry4dOW/w5ekHD1Nn
 i1f3lHo1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRnzMY/tdevWsc17Pol1js
 drW1Ndl3Uj4rJ6jNqM1Qvbkzdcr/kFkM//PT/U4ukVght9Iz6NLyeqmVG29b1dz/x+3x4GR56M6
 Uan4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add TIF_FD_SLOTS. handle_syscall() calls syscall_trace_leave() after
every system call, so test the flag there and commit the reservations
before audit and the ptrace exit stop.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/um/include/asm/thread_info.h | 2 ++
 arch/um/kernel/ptrace.c           | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index 7a6f4dc99fa1..7140516ee0b6 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -44,6 +44,7 @@ struct thread_info {
 #define TIF_SECCOMP		9	/* secure computing */
 #define TIF_SINGLESTEP		10	/* single stepping userspace */
 #define TIF_SYSCALL_TRACEPOINT	11	/* syscall tracepoint instrumentation */
+#define TIF_FD_SLOTS		12	/* syscall prepared descriptors */
 
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
@@ -55,6 +56,7 @@ struct thread_info {
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
+#define _TIF_FD_SLOTS		(1 << TIF_FD_SLOTS)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL | \
 				 _TIF_NOTIFY_RESUME)
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 7da0a5223aa6..f1f89181fb7e 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/audit.h>
+#include <linux/file.h>
 #include <linux/ptrace.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
@@ -142,6 +143,9 @@ void syscall_trace_leave(struct pt_regs *regs)
 {
 	int ptraced = current->ptrace;
 
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(regs);
+
 	audit_syscall_exit(regs);
 
 	/* Fake a debug trap */

-- 
2.53.0

