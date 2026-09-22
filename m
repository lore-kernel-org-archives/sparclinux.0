Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C522F4A2630
	for <sparclinux@vger.kernel.org>; Tue, 22 Sep 2026 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790104898; cv=none; b=RUb0sQ3tNPihiS8DQ5jkC86QKisFQfs8NJiIF7w5PxWuUvd0z9SoP+3zl3DZuhBz76xwxJfdeGsefT+ClJGAF1nKnGEz2C117zfn6znqgIf4blNC0Oue6OoKcBUR5gdjTtHEOGZdzUEgsek5eWtT7gcFxFoxOCB8RIYoXPcQK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790104898; c=relaxed/simple;
	bh=iLauW72EWyHueuXG3EXD+TLJ1Aa3TyP73GOPu2LgyR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlB3SQQzGYHgF2trvXjOyxKRl8O/5jUW78tLADiwZz+rMO75nGIF4GVgXhcD7k6DWXtDDYW50MUscr2Hkkc+fJ9qsQyvvkM2IFl6rBGtULzKudC1BNLvbONILqcFvhDR7b+xTavfglPLgdNnbZTzv5JHDd1jdLHE2Uo57cBE2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9hjFRGf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9hjFRGf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790104891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cvbbR+jvfRtJnkcvWRUCSpiRDTc8Jp7qlX4ZPaYYSmM=;
	b=E9hjFRGf5LiAE7VHvlZNKPsA972PJ3CqPRMYJzPJhl2TLdZ8aEdynnxPopaHKUz9tUuFZ/
	o2hnDmmy3fpRZ0J1blwBTgejW65ExNGum0KKSc0PKhRPeS1A1ecBeKqX6MP/Zv8D2XMaDL
	QP3FAzo8ylfSGV1mXQeXDszwbF3OGHY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-Slu2K4xJNmy9lFCzEvpBYA-1; Tue,
 22 Sep 2026 15:21:29 -0400
X-MC-Unique: Slu2K4xJNmy9lFCzEvpBYA-1
X-Mimecast-MFC-AGG-ID: Slu2K4xJNmy9lFCzEvpBYA_1790104885
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84CD61955DC8;
	Tue, 22 Sep 2026 19:21:23 +0000 (UTC)
Received: from wsxc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 59E523000223;
	Tue, 22 Sep 2026 19:20:48 +0000 (UTC)
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
Subject: [PATCH v3 01/14] audit: log all six syscall arguments in the SYSCALL record
Date: Tue, 22 Sep 2026 16:19:53 -0300
Message-ID: <855572d1b7461e7f258547be0f11c74029755110.1790088067.git.rrobaina@redhat.com>
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

The SYSCALL record currently logs only four of the six syscall
arguments (a0-a3). The remaining two are captured but silently
discarded before reaching the audit context. This leads to the
need for auxiliary records when audit-relevant data lands in the
5th or 6th argument of a syscall.

Extend the SYSCALL record to log all six arguments, by adding
arguments a4 and a5 (5th and 6th syscall arguments respectively)
inline within the existing record. Also add the two new args to
the audit rules switch case, so audit rules can filter on them.

Rather than plumbing two more register arguments through every
architecture's syscall entry path, retrieve the arguments from
pt_regs via syscall_get_arguments(). To keep the series bisectable,
add new helpers audit_syscall_entry_regs() and
__audit_syscall_entry_regs() that take a pointer to pt_regs, rather
than modifying the existing ones in place. Later patches convert
each architecture over to the new helpers, and a final patch removes
the legacy helpers and renames the new ones back to the original
naming.

 audit-testsuite# make test
 audit-testsuite# ausearch -i -m SYSCALL
 ...
 type=SYSCALL ... syscall=sendto success=yes exit=1088 a0=0x4
  a1=0x7ffe43518b60 a2=0x440 a3=0x0 a4=7ffe43518b4c a5=c
 type=SYSCALL ... syscall=openat2 success=yes exit=4 a0=0x3
  a1=0x7fffc74692c8 a2=0x7fffc7467390 a3=0x18 a4=0 a5=7fffc74674f8
 type=SYSCALL ... syscall=openat success=yes exit=3 a0=AT_FDCWD
  a1=0x557ced4141a2 a2=O_RDWR|O_NONBLOCK a3=0x0 a4=0 a5=0
 ...

Suggested-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/audit/CAHC9VhSjEt_-Bsra4AEqWv+Daw5Ff=gqy7dX4Ah11RVhdyCBUQ@mail.gmail.com/T/#t
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 include/linux/audit.h         |  8 ++++++
 include/uapi/linux/audit.h    |  2 ++
 kernel/audit.h                |  2 +-
 kernel/auditfilter.c          |  2 ++
 kernel/auditsc.c              | 53 ++++++++++++++++++++++++++++++++++-
 kernel/entry/syscall-common.c |  4 +--
 6 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 45abb3722d30..22ffad5b2060 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -325,6 +325,7 @@ extern void __audit_uring_entry(u8 op);
 extern void __audit_uring_exit(int success, long code);
 extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
 				  unsigned long a2, unsigned long a3);
+extern void __audit_syscall_entry_regs(int major, struct pt_regs *regs);
 extern void __audit_syscall_exit(int ret_success, long ret_value);
 extern void __audit_getname(struct filename *name);
 extern void __audit_inode(struct filename *name, const struct dentry *dentry,
@@ -380,6 +381,11 @@ static inline void audit_syscall_entry(int major, unsigned long a0,
 	if (unlikely(audit_context()))
 		__audit_syscall_entry(major, a0, a1, a2, a3);
 }
+static inline void audit_syscall_entry_regs(int major, struct pt_regs *regs)
+{
+	if (unlikely(audit_context()))
+		__audit_syscall_entry_regs(major, regs);
+}
 static inline void audit_syscall_exit(void *pt_regs)
 {
 	if (unlikely(audit_context())) {
@@ -615,6 +621,8 @@ static inline void audit_syscall_entry(int major, unsigned long a0,
 				       unsigned long a1, unsigned long a2,
 				       unsigned long a3)
 { }
+static inline void audit_syscall_entry_regs(int major, struct pt_regs *regs)
+{ }
 static inline void audit_syscall_exit(void *pt_regs)
 { }
 static inline bool audit_dummy_context(void)
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index e8f5ce677df7..6726059d6df1 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -303,6 +303,8 @@
 #define AUDIT_ARG1      (AUDIT_ARG0+1)
 #define AUDIT_ARG2      (AUDIT_ARG0+2)
 #define AUDIT_ARG3      (AUDIT_ARG0+3)
+#define AUDIT_ARG4      (AUDIT_ARG0+4)
+#define AUDIT_ARG5      (AUDIT_ARG0+5)
 
 #define AUDIT_FILTERKEY	210
 
diff --git a/kernel/audit.h b/kernel/audit.h
index 92d5e723d570..83011b14af18 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -117,7 +117,7 @@ struct audit_context {
 	struct audit_stamp  stamp;	/* event identifier */
 	int		    major;      /* syscall number */
 	int		    uring_op;   /* uring operation */
-	unsigned long	    argv[4];    /* syscall arguments */
+	unsigned long	    argv[6];    /* syscall arguments */
 	long		    return_code;/* syscall return code */
 	u64		    prio;
 	int		    return_valid; /* return code is valid */
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index f52645625214..cded3696e3c5 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -358,6 +358,8 @@ static int audit_field_valid(struct audit_entry *entry, struct audit_field *f)
 	case AUDIT_ARG1:
 	case AUDIT_ARG2:
 	case AUDIT_ARG3:
+	case AUDIT_ARG4:
+	case AUDIT_ARG5:
 	case AUDIT_PERS: /* <uapi/linux/personality.h> */
 	case AUDIT_DEVMINOR:
 		/* all ops are valid */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 2b9ce0b52511..89f5c518c6f0 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -728,6 +728,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 		case AUDIT_ARG1:
 		case AUDIT_ARG2:
 		case AUDIT_ARG3:
+		case AUDIT_ARG4:
+		case AUDIT_ARG5:
 			if (ctx)
 				result = audit_comparator(ctx->argv[f->type-AUDIT_ARG0], f->op, f->val);
 			break;
@@ -1674,11 +1676,13 @@ static void audit_log_exit(void)
 						    AUDITSC_SUCCESS),
 					 context->return_code);
 		audit_log_format(ab,
-				 " a0=%lx a1=%lx a2=%lx a3=%lx items=%d",
+				 " a0=%lx a1=%lx a2=%lx a3=%lx a4=%lx a5=%lx items=%d",
 				 context->argv[0],
 				 context->argv[1],
 				 context->argv[2],
 				 context->argv[3],
+				 context->argv[4],
+				 context->argv[5],
 				 context->name_count);
 		audit_log_task_info(ab);
 		audit_log_key(ab, context->filterkey);
@@ -2021,6 +2025,53 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	ktime_get_coarse_real_ts64(&context->stamp.ctime);
 }
 
+/**
+ * __audit_syscall_entry_regs - fill in an audit record at syscall entry
+ * @major: major syscall type (function)
+ * @regs: the task's register state at syscall entry
+ *
+ * Fill in audit context at syscall entry.  This only happens if the
+ * audit context was created when the task was created and the state or
+ * filters demand the audit context be built.  If the state from the
+ * per-task filter or from the per-syscall filter is AUDIT_STATE_RECORD,
+ * then the record will be written at syscall exit time (otherwise, it
+ * will only be written if another part of the kernel requests that it
+ * be written).
+ */
+void __audit_syscall_entry_regs(int major, struct pt_regs *regs)
+{
+	struct audit_context *context = audit_context();
+	enum audit_state     state;
+
+	if (!audit_enabled || !context)
+		return;
+
+	WARN_ON(context->context != AUDIT_CTX_UNUSED);
+	WARN_ON(context->name_count);
+	if (context->context != AUDIT_CTX_UNUSED || context->name_count) {
+		audit_panic("unrecoverable error in audit_syscall_entry_regs()");
+		return;
+	}
+
+	state = context->state;
+	if (state == AUDIT_STATE_DISABLED)
+		return;
+
+	context->dummy = !audit_n_rules;
+	if (!context->dummy && state == AUDIT_STATE_BUILD) {
+		context->prio = 0;
+		if (auditd_test_task(current))
+			return;
+	}
+
+	context->arch	    = syscall_get_arch(current);
+	context->major      = major;
+	syscall_get_arguments(current, regs, context->argv);
+	context->context = AUDIT_CTX_SYSCALL;
+	context->current_state  = state;
+	ktime_get_coarse_real_ts64(&context->stamp.ctime);
+}
+
 /**
  * __audit_syscall_exit - deallocate audit context after a system call
  * @success: success value of the syscall
diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
index b8eac9efb6fd..70941008beb6 100644
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -22,9 +22,7 @@ void trace_syscall_exit(struct pt_regs *regs, long ret)
 void syscall_enter_audit(struct pt_regs *regs)
 {
 	long syscall = syscall_get_nr(current, regs);
-	unsigned long args[6];
 
-	syscall_get_arguments(current, regs, args);
-	__audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
+	__audit_syscall_entry_regs(syscall, regs);
 }
 #endif
-- 
2.55.0

