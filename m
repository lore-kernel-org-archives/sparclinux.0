Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B864156F0;
	Tue, 15 Sep 2026 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471928; cv=none; b=ZP09+FrXSN+b5dGw47mk8MN3FJM704SyJLHUuuqLbfh7hKIYrNrhzyvsEy1ttgZjAwIpCG8Vc3n86ARuTz3keqwQ80ZnNHwAlYo+zMOBHd8s5g3c7i+QEaMjGi/GqvxxsFRhzsm/lFjsacE6V76rKXExbmuCNuu80PFGyTyOSIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471928; c=relaxed/simple;
	bh=k8f7wEWfxKpIfpqM0ZZciT9rU/+Z+B0mDMLnzjQbKbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a620qd8sBV8X/35YTiMXjCfQUGQXIYgg+JNIdr6ih6sesic2kGMatAVDKZH41orY81SwT9ReC5vEd9igxjWpLzqJUK7UOks82+qAmaEHbITwJd8QnJhz4Tg8jRkM5Rjh2pIdgjHanNNclypMhPD+67NZWKrYX7Ci7jttSugXf2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4zmLfJv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4zmLfJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887861F00893;
	Tue, 15 Sep 2026 11:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471926;
	bh=IxmCoZxNvEY3MY1bZ7ewHUS2NdsWvLK1wdW+Bpu3XII=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=C4zmLfJvLb8/XMAlQ0q3DR72O6RIbbpSlqr7mpxZZCXJCOZxs052NdpfsCeWB6jTO
	 sp7ZSYu4dpiFz7qZobKbv0Abd6MgSlwyvtgrq+Q5gxYnbTDPGivrBv40jjmQzLGjRT
	 vrpW8H100OjuekLO+QbwSm4M7Pzv6OLBPqNmMdQXQ9Pvk4HwKHgkGGqx1zr9MQdDkX
	 DH4Qvm5HZpUEMbwwqO5pgKn+CIl2pzB83ZS8OPqmZIf0xHJv0M68Lea7oxkcu2dWSZ
	 yYvMHPI29Nvht7tAvKnNjpHySotS6aewXYvlGWWYpncPxSi676hzekHoKm/yXfnU59
	 FZU3zcroOoqIA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:30:52 +0200
Subject: [PATCH RFC POC 06/50] arm64: commit fds on syscall exit
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-6-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2286; i=brauner@kernel.org;
 h=from:subject:message-id; bh=k8f7wEWfxKpIfpqM0ZZciT9rU/+Z+B0mDMLnzjQbKbc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KnZs3W+lNrE9bX1j9JX3V1/xZvtQk5p++zvYh+2m
 2y+/NbBoKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi8csYGbbp9Kz+NflwSea1
 kB+Gs1Oy2DcWpDxrSJl+sK8+M9b2eyTDb3Z/1XKDldKc0bdKrTceZZ30eNPnnY6Zhw+Lb5A7wqf
 zgAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add TIF_FD_SLOTS to the syscall work bits. el0_svc_common() rereads
the flags after the system call and takes the trace exit for any of
them. So a task that reserved descriptors ends up in
syscall_trace_exit() which commits them before audit and the ptrace exit
stop.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/arm64/include/asm/thread_info.h | 4 +++-
 arch/arm64/kernel/ptrace.c           | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 5d7fe3e153c8..e48006eb98a8 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -74,6 +74,7 @@ void arch_setup_new_exec(void);
 #define TIF_SECCOMP		11	/* syscall secure computing */
 #define TIF_SYSCALL_EMU		12	/* syscall emulation active */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
+#define TIF_FD_SLOTS		14	/* syscall prepared descriptors */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
@@ -107,10 +108,11 @@ void arch_setup_new_exec(void);
 #define _TIF_MTE_ASYNC_FAULT	(1 << TIF_MTE_ASYNC_FAULT)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_TSC_SIGSEGV	(1 << TIF_TSC_SIGSEGV)
+#define _TIF_FD_SLOTS		(1 << TIF_FD_SLOTS)
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
-				 _TIF_SYSCALL_EMU)
+				 _TIF_SYSCALL_EMU | _TIF_FD_SLOTS)
 
 #ifdef CONFIG_SHADOW_CALL_STACK
 #define INIT_SCS							\
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index f743cbec1c3a..3bedfed977d4 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -28,6 +28,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/regset.h>
 #include <linux/elf.h>
+#include <linux/file.h>
 #include <linux/rseq.h>
 
 #include <asm/compat.h>
@@ -2486,6 +2487,9 @@ void syscall_trace_exit(struct pt_regs *regs)
 {
 	unsigned long flags = read_thread_flags();
 
+	if (flags & _TIF_FD_SLOTS)
+		fd_slots_commit(regs);
+
 	audit_syscall_exit(regs);
 
 	if (flags & _TIF_SYSCALL_TRACEPOINT)

-- 
2.53.0

