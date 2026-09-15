Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D439C41378E;
	Tue, 15 Sep 2026 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471913; cv=none; b=jPx2c7aG83EtRZD0JgLG3o0mzyO4QGfrXfkddFIW48BQkKzieui1BlxoyF25QWAhmmfP3x1w8naK6DD418Yc3JMAqLcNjqfIGV1bakd2/JV9dt7zXizJ7UpbtozT2WKugIO5vLIFj54FA0NxII3WS2e/jowUc3mG7iOHkerPE8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471913; c=relaxed/simple;
	bh=evSE6cJdnuFzZXNcFgM0f0Wtj2vW8xSJVidsgxr0vnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oI5648ohhLCkrWFyN8WI/LoIQckza2bDTFPH5vsKCXBoN476tgXrHDJYmD7KXe1hOzGJJMpeZ3YYomH87aA8qNMMwXrM7bYeFMfR+0lIoEy+iwbqXeWF59QuJF6iupknSVyvX5Kp9DzC5Ce3Oy+0mWn3X63R/FvZH7+NFsvLmh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjTiEaV3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjTiEaV3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BA31F00893;
	Tue, 15 Sep 2026 11:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471911;
	bh=FOANy+Z4EJ+6nqoqN6kMNeWMX83pxCR/f2oFPELw6+I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NjTiEaV3ZaSoS1ZK+2F2vFiHjAl7mkp0G3MbSEUlep66TuNm80zD11hu1nBRrXxYn
	 jBTgv2BJxRFDL61U3EX8wu6faVIGU3bVeFZLIy90XxwIrdrOUrOsKYX977rOTgZ/8I
	 4thUe5a8WqKasgzR8NxRqDgxbn2ffdmAsbyPzlk/nLtbznCt3T36AhEWcTJxWAK16P
	 +oX6GAj1A666bKWBCHBVyXFcgtj42qkim8vnDO1heVDCubdQ6sDhUxhnwBvgcIFp3b
	 tNoelVNVV3FSdtQiheYIa3QaDhiMkmI4KN1O3BjQkmw4KGESv+pMI5iwydQ3oXYyV8
	 m6gLuAfE4lcLg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:30:50 +0200
Subject: [PATCH RFC POC 04/50] ARC: commit fds on syscall exit
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-4-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2822; i=brauner@kernel.org;
 h=from:subject:message-id; bh=evSE6cJdnuFzZXNcFgM0f0Wtj2vW8xSJVidsgxr0vnY=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGqpLHyhtTAYRmbLzGwRwqcyv1G19KV/PkIkpZzswA8hR9xFL
 oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmqpLHwACgkQkcYbwGV43KJF2gD/fYHy
 46GYN1jNxZvG5+E3C415n+5O5q2AJF3BkQjO7yQA/1hW7xKAHZiI3T6na5l1kqSbVvDkaRah45d
 KjuZmRA8O
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add TIF_FD_SLOTS and test it on the untraced return from a system
call. A task that reserved descriptors takes the tracesys_exit path,
where syscall_trace_exit() commits them before the ptrace exit stop.
The traced path already ends up there.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/arc/include/asm/thread_info.h | 2 ++
 arch/arc/kernel/entry.S            | 5 +++++
 arch/arc/kernel/ptrace.c           | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/arch/arc/include/asm/thread_info.h b/arch/arc/include/asm/thread_info.h
index 255d2c774219..4c67d4eb434b 100644
--- a/arch/arc/include/asm/thread_info.h
+++ b/arch/arc/include/asm/thread_info.h
@@ -77,6 +77,7 @@ static inline __attribute_const__ struct thread_info *current_thread_info(void)
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SYSCALL_AUDIT	4	/* syscall auditing active */
 #define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
+#define TIF_FD_SLOTS		6	/* syscall prepared descriptors */
 #define TIF_SYSCALL_TRACE	15	/* syscall trace active */
 /* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		16
@@ -88,6 +89,7 @@ static inline __attribute_const__ struct thread_info *current_thread_info(void)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
+#define _TIF_FD_SLOTS		(1<<TIF_FD_SLOTS)
 #define _TIF_MEMDIE		(1<<TIF_MEMDIE)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
 
diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 3c7e74aba679..f436391526e1 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -241,6 +241,11 @@ ENTRY(EV_Trap)
 	jl      [r9]
 
 .Lret_from_system_call:
+	; descriptors reserved by the syscall are committed in syscall_trace_exit()
+	GET_CURR_THR_INFO_FLAGS   r10
+	and.f 0, r10, _TIF_FD_SLOTS
+	bnz   tracesys_exit
+
 	st  r0, [sp, PT_r0]     ; sys call return value in pt_regs
 
 	; fall through to ret_from_exception
diff --git a/arch/arc/kernel/ptrace.c b/arch/arc/kernel/ptrace.c
index fe2b6572e919..0a0d74b9c7c4 100644
--- a/arch/arc/kernel/ptrace.c
+++ b/arch/arc/kernel/ptrace.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
  */
 
+#include <linux/file.h>
 #include <linux/ptrace.h>
 #include <linux/sched/task_stack.h>
 #include <linux/regset.h>
@@ -355,6 +356,9 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 
 asmlinkage void syscall_trace_exit(struct pt_regs *regs)
 {
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(regs);
+
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		ptrace_report_syscall_exit(regs, 0);
 

-- 
2.53.0

