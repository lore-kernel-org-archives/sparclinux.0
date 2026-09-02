Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A6149C4D1
	for <sparclinux@vger.kernel.org>; Wed,  2 Sep 2026 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360277; cv=none; b=GfFqDm61j3y+pPuUxSIIE1ZvBECI+NcvGojfKP2AQqoxKPJq1QgqDCp0lKuNcxFHRvdlJ+uodJtDHVeCLlfhRym8MNrZFewAmXTeiSl4DW8Q9d5wdoGhvYe4eQpsMs/BYP5H0l6Ezn8LGfg6DxXGIanxPeLeUhiA1dtyjnFQnLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360277; c=relaxed/simple;
	bh=YYJcWSK0o8g3JZG0m9jWuvgOSpeoKqWZxSBIxDt0t+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzjc/mSty8EFbjsINARks7jv65JwUmh5M+hLTCSB36ndbGYgUpAZApYm7+bh0LLwbbuXN/NBjmtePDCsC8mr3Hjz6v5EuEcW1rdw/p5o6+IgMjhRM8Qr/mWK6bnXEWzkprW34Nb4zj6kATWh6rj5EXpN3M6wYVYE/Uuqv/esuUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACWU0Iwy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACWU0Iwy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788360273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2JnrEcZXT7a4Ko8RzDbmeGNWkBaG45AGwndXeHnOoAk=;
	b=ACWU0IwyhJjAcDBGVJXfeuaDFptsi0u12vv1ShnAG/jLMEt9YHrBRCbQDWUKVpp8m7ZL7Q
	3L2/n3v6jaTNf5n+i0fgnx6rrHOnv7gmXCNTwpZXXlOU3fwrKNEZxA9LMQ2wt2KBqjmESk
	RfJTYhp8YZqNvVYaoBFAKDH8lmAGI6c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-a2JSz_KeOTmg8-pUeyfoLw-1; Wed,
 02 Sep 2026 10:44:31 -0400
X-MC-Unique: a2JSz_KeOTmg8-pUeyfoLw-1
X-Mimecast-MFC-AGG-ID: a2JSz_KeOTmg8-pUeyfoLw_1788360267
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BE781944EBC;
	Wed,  2 Sep 2026 14:44:24 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1DCEC1800765;
	Wed,  2 Sep 2026 14:44:09 +0000 (UTC)
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
Subject: [PATCH v2 01/13] audit: log all six syscall arguments in the SYSCALL record
Date: Wed,  2 Sep 2026 11:43:34 -0300
Message-ID: <b30076994d49fa393251c836b5a57a725f218572.1788351089.git.rrobaina@redhat.com>
In-Reply-To: <cover.1788351089.git.rrobaina@redhat.com>
References: <cover.1788351089.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
architecture's syscall entry path, change __audit_syscall_entry()
to take a pointer to pt_regs and use syscall_get_arguments() to
retrieve all six arguments.

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
 include/linux/audit.h         | 13 ++++---------
 include/uapi/linux/audit.h    |  2 ++
 kernel/audit.h                |  2 +-
 kernel/auditfilter.c          |  2 ++
 kernel/auditsc.c              | 19 ++++++++-----------
 kernel/entry/syscall-common.c |  4 +---
 6 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 45abb3722d30..9ce5962bc537 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -323,8 +323,7 @@ extern int  audit_alloc(struct task_struct *task);
 extern void __audit_free(struct task_struct *task);
 extern void __audit_uring_entry(u8 op);
 extern void __audit_uring_exit(int success, long code);
-extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
-				  unsigned long a2, unsigned long a3);
+extern void __audit_syscall_entry(int major, struct pt_regs *regs);
 extern void __audit_syscall_exit(int ret_success, long ret_value);
 extern void __audit_getname(struct filename *name);
 extern void __audit_inode(struct filename *name, const struct dentry *dentry,
@@ -373,12 +372,10 @@ static inline void audit_uring_exit(int success, long code)
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
+		__audit_syscall_entry(major, regs);
 }
 static inline void audit_syscall_exit(void *pt_regs)
 {
@@ -611,9 +608,7 @@ static inline void audit_uring_entry(u8 op)
 { }
 static inline void audit_uring_exit(int success, long code)
 { }
-static inline void audit_syscall_entry(int major, unsigned long a0,
-				       unsigned long a1, unsigned long a2,
-				       unsigned long a3)
+static inline void audit_syscall_entry(int major, struct pt_regs *regs)
 { }
 static inline void audit_syscall_exit(void *pt_regs)
 { }
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
index 2b9ce0b52511..cf45c782b03d 100644
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
@@ -1970,10 +1974,7 @@ void __audit_uring_exit(int success, long code)
 /**
  * __audit_syscall_entry - fill in an audit record at syscall entry
  * @major: major syscall type (function)
- * @a1: additional syscall register 1
- * @a2: additional syscall register 2
- * @a3: additional syscall register 3
- * @a4: additional syscall register 4
+ * @regs: the task's register state at syscall entry
  *
  * Fill in audit context at syscall entry.  This only happens if the
  * audit context was created when the task was created and the state or
@@ -1983,8 +1984,7 @@ void __audit_uring_exit(int success, long code)
  * will only be written if another part of the kernel requests that it
  * be written).
  */
-void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
-			   unsigned long a3, unsigned long a4)
+void __audit_syscall_entry(int major, struct pt_regs *regs)
 {
 	struct audit_context *context = audit_context();
 	enum audit_state     state;
@@ -2012,10 +2012,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 
 	context->arch	    = syscall_get_arch(current);
 	context->major      = major;
-	context->argv[0]    = a1;
-	context->argv[1]    = a2;
-	context->argv[2]    = a3;
-	context->argv[3]    = a4;
+	syscall_get_arguments(current, regs, context->argv);
 	context->context = AUDIT_CTX_SYSCALL;
 	context->current_state  = state;
 	ktime_get_coarse_real_ts64(&context->stamp.ctime);
diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
index b8eac9efb6fd..471db2a8e09d 100644
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -22,9 +22,7 @@ void trace_syscall_exit(struct pt_regs *regs, long ret)
 void syscall_enter_audit(struct pt_regs *regs)
 {
 	long syscall = syscall_get_nr(current, regs);
-	unsigned long args[6];
 
-	syscall_get_arguments(current, regs, args);
-	__audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
+	__audit_syscall_entry(syscall, regs);
 }
 #endif
-- 
2.55.0

