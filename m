Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E7B4A3879
	for <sparclinux@vger.kernel.org>; Tue, 22 Sep 2026 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105135; cv=none; b=MCNtpdOJrdofxSaDimGuiLR+lCSNI4ZVM0gWwNnBwLRypq/rJ2bv2EalXX0lDIss4/tlsDXxRLKYYO2kY+dx92kA9Pvy0HBslqGaszK4zzz5aaIehb6xNREZ460uv5MAP0Nx6mXIqXOqxEkEE9/BzisWwPd4Bgq/hlk+WOhSvh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105135; c=relaxed/simple;
	bh=8spCMQsob0cbxv0j4UMVHPSzWk2o5wd/oncgmW1WbhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KR1X3K8Ytf/S32vcque5NerVzB8Zxdr2Wfrq7SxVVEka3L9BEVIlmPOjdkMZM7bmt0+BBY8NNWxQ0eLHTK6dsgi7b0Z10GmGjjwi7khdrlGajbYc04mTF9HGg5BF60zjSbnrUVbrpqAkjpamhF52EBl68jTKU09QEIgasP0BqS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9A9CtaV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9A9CtaV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790105132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6TM6uu+FM58oALQCRrt4iHL681e2T+gM7AtXU+yYTA=;
	b=Y9A9CtaVA9Y1cHWcvB8RHDLGZvpV2yu3un/CKV9TKhLsjoifigpoOjHQA64DtjVaypyZCu
	WjGbiM60SrqIK9PLGsjF6Cav+SVCPfcw0f9eEQc8AOGNn/VTJt9Ng1YR9QnC9g6LWPOMDC
	UVf8lLsSS4r7tp9wE7xi19/tWlBKOZA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-IRN1w4lsMay6e_AHh4r-gw-1; Tue,
 22 Sep 2026 15:25:28 -0400
X-MC-Unique: IRN1w4lsMay6e_AHh4r-gw-1
X-Mimecast-MFC-AGG-ID: IRN1w4lsMay6e_AHh4r-gw_1790105124
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 209BD1809C98;
	Tue, 22 Sep 2026 19:25:24 +0000 (UTC)
Received: from wsxc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 281A830001B9;
	Tue, 22 Sep 2026 19:25:08 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	bpf@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	sgrubb@redhat.com,
	oleg@redhat.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	guoren@kernel.org,
	monstr@monstr.eu,
	tsbogend@alpha.franken.de,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	tglx@kernel.org,
	peterz@infradead.org,
	luto@kernel.org,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH v3 14/14] audit: rename audit_syscall_entry_regs() to audit_syscall_entry()
Date: Tue, 22 Sep 2026 16:20:06 -0300
Message-ID: <0bb32d256099870f3f9ca2632cccf58538f882ed.1790088067.git.rrobaina@redhat.com>
In-Reply-To: <cover.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Now that every architecture has been converted to the pt_regs-based
audit_syscall_entry_regs(), the legacy audit_syscall_entry() and
__audit_syscall_entry() helpers that took the individual syscall
argument registers (a0-a3) no longer have any callers.

Remove those legacy helpers and rename audit_syscall_entry_regs() and
__audit_syscall_entry_regs() back to audit_syscall_entry() and
__audit_syscall_entry(), restoring the original naming.

The _regs variants were introduced separately, and the architectures
converted one per patch, specifically so this final rename is the only
step that removes the old prototype. That keeps the series bisectable:
every commit builds, and no caller is ever left referencing a helper
that has been removed.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/arm/kernel/ptrace.c        |  2 +-
 arch/arm64/kernel/ptrace.c      |  2 +-
 arch/csky/kernel/ptrace.c       |  2 +-
 arch/microblaze/kernel/ptrace.c |  2 +-
 arch/mips/kernel/ptrace.c       |  2 +-
 arch/openrisc/kernel/ptrace.c   |  2 +-
 arch/parisc/kernel/ptrace.c     |  4 +--
 arch/sh/kernel/ptrace_32.c      |  2 +-
 arch/sparc/kernel/ptrace_64.c   |  2 +-
 arch/um/kernel/ptrace.c         |  2 +-
 arch/xtensa/kernel/ptrace.c     |  2 +-
 include/linux/audit.h           | 21 +++---------
 kernel/auditsc.c                | 58 ++-------------------------------
 kernel/entry/syscall-common.c   |  2 +-
 14 files changed, 19 insertions(+), 86 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 3c5d7fd733ec..e103ec2661cd 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -868,7 +868,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, scno);
 
-	audit_syscall_entry_regs(scno, regs);
+	audit_syscall_entry(scno, regs);
 
 	return scno;
 }
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 2bcbeafe26a3..65532b2a8cd4 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2476,7 +2476,7 @@ int syscall_trace_enter(struct pt_regs *regs)
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, regs->syscallno);
 
-	audit_syscall_entry_regs(regs->syscallno, regs);
+	audit_syscall_entry(regs->syscallno, regs);
 
 	return regs->syscallno;
 }
diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index e61b1408737c..5c3051bcd78c 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -329,7 +329,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, syscall_get_nr(current, regs));
 
-	audit_syscall_entry_regs(regs_syscallid(regs), regs);
+	audit_syscall_entry(regs_syscallid(regs), regs);
 	return 0;
 }
 
diff --git a/arch/microblaze/kernel/ptrace.c b/arch/microblaze/kernel/ptrace.c
index d0a540b7370f..5fe9e3a150f4 100644
--- a/arch/microblaze/kernel/ptrace.c
+++ b/arch/microblaze/kernel/ptrace.c
@@ -147,7 +147,7 @@ asmlinkage unsigned long do_syscall_trace_enter(struct pt_regs *regs)
 		 */
 		ret = -1L;
 
-	audit_syscall_entry_regs(regs->r12, regs);
+	audit_syscall_entry(regs->r12, regs);
 
 	return ret ?: regs->r12;
 }
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index c6f4e801cfae..7a09b4671a54 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -1338,7 +1338,7 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs)
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->regs[2]);
 
-	audit_syscall_entry_regs(current_thread_info()->syscall, regs);
+	audit_syscall_entry(current_thread_info()->syscall, regs);
 
 	/*
 	 * Negative syscall numbers are mistaken for rejected syscalls, but
diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
index 78294c84e4de..eca613b84ff8 100644
--- a/arch/openrisc/kernel/ptrace.c
+++ b/arch/openrisc/kernel/ptrace.c
@@ -301,7 +301,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 		 */
 		ret = -1L;
 
-	audit_syscall_entry_regs(regs->gpr[11], regs);
+	audit_syscall_entry(regs->gpr[11], regs);
 
 	return ret ? : regs->gpr[11];
 }
diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index 4e62d6bd6466..948e0cf29ba4 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -359,10 +359,10 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 
 #ifdef CONFIG_64BIT
 	if (!is_compat_task())
-		audit_syscall_entry_regs(regs->gr[20], regs);
+		audit_syscall_entry(regs->gr[20], regs);
 	else
 #endif
-		audit_syscall_entry_regs(regs->gr[20] & 0xffffffff, regs);
+		audit_syscall_entry(regs->gr[20] & 0xffffffff, regs);
 
 	/*
 	 * Sign extend the syscall number to 64bit since it may have been
diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index c82d336611ef..e138f529ee7e 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -466,7 +466,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->regs[0]);
 
-	audit_syscall_entry_regs(regs->regs[3], regs);
+	audit_syscall_entry(regs->regs[3], regs);
 
 	return 0;
 }
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 6197de10b45c..b162585b4a74 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -1098,7 +1098,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->u_regs[UREG_G1]);
 
-	audit_syscall_entry_regs(regs->u_regs[UREG_G1], regs);
+	audit_syscall_entry(regs->u_regs[UREG_G1], regs);
 
 	return ret;
 }
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 17c285e49ddc..bdc1b18bb342 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -123,7 +123,7 @@ static void send_sigtrap(struct uml_pt_regs *regs, int error_code)
  */
 int syscall_trace_enter(struct pt_regs *regs)
 {
-	audit_syscall_entry_regs(UPT_SYSCALL_NR(&regs->regs), regs);
+	audit_syscall_entry(UPT_SYSCALL_NR(&regs->regs), regs);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, UPT_SYSCALL_NR(&regs->regs));
diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index 86e4679b5869..327e00c2ebde 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -561,7 +561,7 @@ int do_syscall_trace_enter(struct pt_regs *regs)
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, syscall_get_nr(current, regs));
 
-	audit_syscall_entry_regs(regs->syscall, regs);
+	audit_syscall_entry(regs->syscall, regs);
 	return 1;
 }
 
diff --git a/include/linux/audit.h b/include/linux/audit.h
index 22ffad5b2060..9ce5962bc537 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -323,9 +323,7 @@ extern int  audit_alloc(struct task_struct *task);
 extern void __audit_free(struct task_struct *task);
 extern void __audit_uring_entry(u8 op);
 extern void __audit_uring_exit(int success, long code);
-extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
-				  unsigned long a2, unsigned long a3);
-extern void __audit_syscall_entry_regs(int major, struct pt_regs *regs);
+extern void __audit_syscall_entry(int major, struct pt_regs *regs);
 extern void __audit_syscall_exit(int ret_success, long ret_value);
 extern void __audit_getname(struct filename *name);
 extern void __audit_inode(struct filename *name, const struct dentry *dentry,
@@ -374,17 +372,10 @@ static inline void audit_uring_exit(int success, long code)
 	if (unlikely(audit_context()))
 		__audit_uring_exit(success, code);
 }
-static inline void audit_syscall_entry(int major, unsigned long a0,
-				       unsigned long a1, unsigned long a2,
-				       unsigned long a3)
+static inline void audit_syscall_entry(int major, struct pt_regs *regs)
 {
 	if (unlikely(audit_context()))
-		__audit_syscall_entry(major, a0, a1, a2, a3);
-}
-static inline void audit_syscall_entry_regs(int major, struct pt_regs *regs)
-{
-	if (unlikely(audit_context()))
-		__audit_syscall_entry_regs(major, regs);
+		__audit_syscall_entry(major, regs);
 }
 static inline void audit_syscall_exit(void *pt_regs)
 {
@@ -617,11 +608,7 @@ static inline void audit_uring_entry(u8 op)
 { }
 static inline void audit_uring_exit(int success, long code)
 { }
-static inline void audit_syscall_entry(int major, unsigned long a0,
-				       unsigned long a1, unsigned long a2,
-				       unsigned long a3)
-{ }
-static inline void audit_syscall_entry_regs(int major, struct pt_regs *regs)
+static inline void audit_syscall_entry(int major, struct pt_regs *regs)
 { }
 static inline void audit_syscall_exit(void *pt_regs)
 { }
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 89f5c518c6f0..cf45c782b03d 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1974,60 +1974,6 @@ void __audit_uring_exit(int success, long code)
 /**
  * __audit_syscall_entry - fill in an audit record at syscall entry
  * @major: major syscall type (function)
- * @a1: additional syscall register 1
- * @a2: additional syscall register 2
- * @a3: additional syscall register 3
- * @a4: additional syscall register 4
- *
- * Fill in audit context at syscall entry.  This only happens if the
- * audit context was created when the task was created and the state or
- * filters demand the audit context be built.  If the state from the
- * per-task filter or from the per-syscall filter is AUDIT_STATE_RECORD,
- * then the record will be written at syscall exit time (otherwise, it
- * will only be written if another part of the kernel requests that it
- * be written).
- */
-void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
-			   unsigned long a3, unsigned long a4)
-{
-	struct audit_context *context = audit_context();
-	enum audit_state     state;
-
-	if (!audit_enabled || !context)
-		return;
-
-	WARN_ON(context->context != AUDIT_CTX_UNUSED);
-	WARN_ON(context->name_count);
-	if (context->context != AUDIT_CTX_UNUSED || context->name_count) {
-		audit_panic("unrecoverable error in audit_syscall_entry()");
-		return;
-	}
-
-	state = context->state;
-	if (state == AUDIT_STATE_DISABLED)
-		return;
-
-	context->dummy = !audit_n_rules;
-	if (!context->dummy && state == AUDIT_STATE_BUILD) {
-		context->prio = 0;
-		if (auditd_test_task(current))
-			return;
-	}
-
-	context->arch	    = syscall_get_arch(current);
-	context->major      = major;
-	context->argv[0]    = a1;
-	context->argv[1]    = a2;
-	context->argv[2]    = a3;
-	context->argv[3]    = a4;
-	context->context = AUDIT_CTX_SYSCALL;
-	context->current_state  = state;
-	ktime_get_coarse_real_ts64(&context->stamp.ctime);
-}
-
-/**
- * __audit_syscall_entry_regs - fill in an audit record at syscall entry
- * @major: major syscall type (function)
  * @regs: the task's register state at syscall entry
  *
  * Fill in audit context at syscall entry.  This only happens if the
@@ -2038,7 +1984,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
  * will only be written if another part of the kernel requests that it
  * be written).
  */
-void __audit_syscall_entry_regs(int major, struct pt_regs *regs)
+void __audit_syscall_entry(int major, struct pt_regs *regs)
 {
 	struct audit_context *context = audit_context();
 	enum audit_state     state;
@@ -2049,7 +1995,7 @@ void __audit_syscall_entry_regs(int major, struct pt_regs *regs)
 	WARN_ON(context->context != AUDIT_CTX_UNUSED);
 	WARN_ON(context->name_count);
 	if (context->context != AUDIT_CTX_UNUSED || context->name_count) {
-		audit_panic("unrecoverable error in audit_syscall_entry_regs()");
+		audit_panic("unrecoverable error in audit_syscall_entry()");
 		return;
 	}
 
diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
index 70941008beb6..471db2a8e09d 100644
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -23,6 +23,6 @@ void syscall_enter_audit(struct pt_regs *regs)
 {
 	long syscall = syscall_get_nr(current, regs);
 
-	__audit_syscall_entry_regs(syscall, regs);
+	__audit_syscall_entry(syscall, regs);
 }
 #endif
-- 
2.55.0

