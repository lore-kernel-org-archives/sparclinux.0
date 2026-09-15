Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4514A64DC;
	Tue, 15 Sep 2026 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471943; cv=none; b=g1GKvAaJDyqStm9nFil98KTUSvTZs2Sz3pdbv8AiuHjsPEOYtyF8TxRpbUkfBgg85yGmXFniwDcBYknMVbg8BxDbuaSMri1rviKnjPwBS14z2NcOE+RubXpr3lrLm8UPa/BSwBDopg++eSsnMRqdgiFd0RQbZT20pOG6+Wg2rPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471943; c=relaxed/simple;
	bh=Bf/Nt9MIp5BYByx3VQiEgkxrXuUu+w3TElLZR1b5xXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=loE1XY1yFpffX9vAYuCPUjWz4zgnrhDqKa3Rc+GDivA31S8kU650M0CLVCJnNJmV4rDOnEUOqdp3mZcOZjzG5cwkCNLz6uNOCikC3E/3d07pVf/dkp1XKXep/zhenJr3Y3bamXSGikKCKbYv5oXOAxdVKjVkIfK+CwwB0AlQjt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsZ0YSeM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsZ0YSeM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D2C1F00898;
	Tue, 15 Sep 2026 11:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471942;
	bh=sj/TXeU8lbnq/VrgmP1w7bpiu8kxbau6iQA5smJm308=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KsZ0YSeM3U31KwXzuSOBPVbLhE9vK4Yxa17kxnYE4VLLcBpXFBViJ7MpY18d0q6fg
	 Dlkn+mjs3MbZWkyHFiqCn2El/got/SWIrC3Q6gwcviuJR1/ai315fCDOEzDtjnFUA+
	 ERro30MRjCev/KMJgcrZtL2o1gUZZKhbA8HyLbu41oPLd1EatgWYME4stynmbpZ0mz
	 K2X3JgB7AebymzKvLiHCEwmgdxwueAGGvA/T8oKFv3D8nL35LXrTyGPgC1/a4X9Lk0
	 vYiOSTed74edj4byJ8eheDQrzWMKeMINNC4B6wsUI+361fX0pdzSzZSfMUdSTok96o
	 JldIOwL5KHMLA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:30:54 +0200
Subject: [PATCH RFC POC 08/50] hexagon: commit fds on syscall exit
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-8-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2326; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Bf/Nt9MIp5BYByx3VQiEgkxrXuUu+w3TElLZR1b5xXU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KlxSfoWG7jlfrZ0K0tn4qOUcP+ecLZEh3DTGxwiP
 //KiUzqKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMieN4wMd9vcWj+ZhdjGz730
 0Td4Qozfzkm7T2q1yV5i3fu0zPsfNyPDAc8V881XLgs7f0Ke7TKroLtaVRyno/+PV+zTfzPk3mr
 iBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add TIF_FD_SLOTS and test it in do_trap0() once the system call has
returned, before the ptrace exit stop gets to see the result.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/hexagon/include/asm/thread_info.h | 2 ++
 arch/hexagon/kernel/traps.c            | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/hexagon/include/asm/thread_info.h b/arch/hexagon/include/asm/thread_info.h
index e90f280b9ce3..8558d2d147f8 100644
--- a/arch/hexagon/include/asm/thread_info.h
+++ b/arch/hexagon/include/asm/thread_info.h
@@ -88,6 +88,7 @@ register struct thread_info *__current_thread_info asm(QUOTED_THREADINFO_REG);
 #define TIF_SIGPENDING          2       /* signal pending */
 #define TIF_NEED_RESCHED        3       /* rescheduling necessary */
 #define TIF_SINGLESTEP          4       /* restore ss @ return to usr mode */
+#define TIF_FD_SLOTS          5       /* syscall prepared descriptors */
 #define TIF_RESTORE_SIGMASK     6       /* restore sig mask in do_signal() */
 #define TIF_NOTIFY_SIGNAL	7       /* signal notifications exist */
 /* true if poll_idle() is polling TIF_NEED_RESCHED */
@@ -98,6 +99,7 @@ register struct thread_info *__current_thread_info asm(QUOTED_THREADINFO_REG);
 #define _TIF_SIGPENDING         (1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED       (1 << TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP         (1 << TIF_SINGLESTEP)
+#define _TIF_FD_SLOTS         (1 << TIF_FD_SLOTS)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 
 /* work to do on interrupt/exception return - All but TIF_SYSCALL_TRACE */
diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 6fe0c1b62c1b..4d15c5212fd7 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/file.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
@@ -381,6 +382,9 @@ void do_trap0(struct pt_regs *regs)
 				   regs->r04, regs->r05);
 		}
 
+		if (unlikely(test_thread_flag(TIF_FD_SLOTS)))
+			fd_slots_commit(regs);
+
 		/* allow strace to get the syscall return state  */
 		if (unlikely(test_thread_flag(TIF_SYSCALL_TRACE)))
 			ptrace_report_syscall_exit(regs, 0);

-- 
2.53.0

