Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89664A3872;
	Tue, 15 Sep 2026 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472024; cv=none; b=iUJj9vYha3hUnwNAtUeMYsv6M5sOo4Dk5j3XvOx6utao/rXg52rDrmfsbRfYxR25/ovaKrlVMdujRSQTIEisEmro8jTZncym9axBiND0OiscBUaxRufLRToKGqGpEMGZ1RFll82ubpNofKyfn7lNt2AZ0Pag6Gn//2G+etHxWTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472024; c=relaxed/simple;
	bh=Ob3PjpQ/cxpLv/3i+RPAC4oxtU+7SyXGKknKtjIi6uA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KcxEGl+Hg7pK3/wHrjD/Q5sJtYT6KOf6Hi+c68CyNt1jKIX1Gr5Nir+miASiV89u4IrEsQy8dYl3Fgl88AJxlNyD4nfZ6Gq2tts9q7ylRVNaVnrvKSXlwliq5kLaMKx04qeuEMCSzUz7lJXoqsjzUqagyIshxd459B6m9R4eItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6JS+1os; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6JS+1os"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A06C1F000FF;
	Tue, 15 Sep 2026 11:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472018;
	bh=Opabrir2qKnajEOx/bmqQ0vFOOuJF5mcXpUx8QfYgRo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m6JS+1osV+HHQ3+stbRMi1nG57ukYiJTEcH35bNEsuFkz3EDpaPqRCxptR5myI3CQ
	 DrVL3ticaSsEmHs4hzrQOkVHuI+pRvmExpm7hSTVT1Fy4ahKbV0yxhDmvASrd6aMLO
	 kfyvZnG8hPY/OSMfxVk2m1KEfL0A4tlDKieBNoYaPaJt6kinrooutLXDgSWdlzJaI4
	 Qyu0CqnjMLHGESZU0vH6Xh9zHueNHEtLJB7dyoK2455umDXJ25s2IeNCaoYNiPSyj5
	 BtthgxR3vTZnXL/kG06SW2wMzb3uuLV+YqWCArv2R8bMdgvjWU+Ck1onWTajB/my7G
	 f4cwtNsAzJb3g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:04 +0200
Subject: [PATCH RFC POC 18/50] xtensa: commit fds on syscall exit
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-18-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2590; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ob3PjpQ/cxpLv/3i+RPAC4oxtU+7SyXGKknKtjIi6uA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Km1PCQWPOf+dN42p7eiixMDrC8oHl3XfDxb8HXeu
 Q8v17M86ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIlRQjwxxl+ehP3JqHnz5Z
 rnHMf3GFlcCby16MDPn/pqho/776ZA8jwwxuu0Z35YDFs7a2ZE2t16lXXVd42bXR6lPXzm5Ltrk
 6jAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add TIF_FD_SLOTS and test it once the system call has stored its
return value. A task that reserved descriptors uses the traced path.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/xtensa/include/asm/thread_info.h | 2 ++
 arch/xtensa/kernel/entry.S            | 5 +++++
 arch/xtensa/kernel/ptrace.c           | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/arch/xtensa/include/asm/thread_info.h b/arch/xtensa/include/asm/thread_info.h
index 5b74dfc35ef9..0c8eb5dc8398 100644
--- a/arch/xtensa/include/asm/thread_info.h
+++ b/arch/xtensa/include/asm/thread_info.h
@@ -124,6 +124,7 @@ static __always_inline struct thread_info *current_thread_info(void)
 #define TIF_SYSCALL_AUDIT	9	/* syscall auditing active */
 #define TIF_SECCOMP		10	/* secure computing */
 #define TIF_MEMDIE		11	/* is terminating due to OOM killer */
+#define TIF_FD_SLOTS		12	/* syscall prepared descriptors */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
@@ -134,6 +135,7 @@ static __always_inline struct thread_info *current_thread_info(void)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
+#define _TIF_FD_SLOTS		(1<<TIF_FD_SLOTS)
 
 #define _TIF_WORK_MASK		(_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP | \
 				 _TIF_SYSCALL_TRACEPOINT | \
diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 272fff587907..4b95f48736e6 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -1976,6 +1976,11 @@ ENTRY(system_call)
 1:	/* regs->areg[2] = return_value */
 
 	s32i	abi_rv, abi_saved0, PT_AREG2
+
+	/* descriptors reserved by the syscall are committed in do_syscall_trace_leave */
+	GET_THREAD_INFO(a4, a1)
+	l32i	a4, a4, TI_FLAGS
+	bbsi.l	a4, TIF_FD_SLOTS, 1f
 	bnez	abi_saved1, 1f
 .Lsyscall_exit:
 #if defined(__XTENSA_WINDOWED_ABI__)
diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index 364e4fdabb00..d44d62a56b85 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/audit.h>
+#include <linux/file.h>
 #include <linux/errno.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/kernel.h>
@@ -571,6 +572,9 @@ void do_syscall_trace_leave(struct pt_regs *regs)
 {
 	int step;
 
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(regs);
+
 	audit_syscall_exit(regs);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))

-- 
2.53.0

