Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0659253B52
	for <sparclinux@vger.kernel.org>; Sat,  8 Nov 2025 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622796; cv=none; b=DAhK7neZSPVwv1ICHSPWHXg7E3snpdt7b5aS0HbsEm3rmhaWn8oaSL5zPkSeUcjQSGPaZ/cihq8M/wLwLmH/Z1qIeGA/CJdHEkJkz5UEvslrGfIr62Ety8U6VjUIx31eFgeCGqpZpyJYnEsDhlkNHWgOR8bTSwlCcGr3tmbD/FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622796; c=relaxed/simple;
	bh=hnlpC3YLWJGM+XP4XQR8YQD5f3S6V9XJPPnRLSiogsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyD8Eded1g6wuclyKRhvVAkL8Qyp8gqc3HwsPSb7ZKB/QS0+Z2W98QMmL/Lz3AM5JF7Vx/47BRVY2ffirAJg8i4V65zV8m8MjPac2lQX/tX9f+7GzYuMv7PISiXPlaJZboW6xSc4rFG0NZdy0SMgQUzbDM0LFBwZN8u6AnN0Pl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dD5AG0ac; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD5AG0ac"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-340ba29d518so1115444a91.3
        for <sparclinux@vger.kernel.org>; Sat, 08 Nov 2025 09:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762622792; x=1763227592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKX/131TEur+U1ws0a+nOk/0nOWDLcKaeuLKOvTYpSE=;
        b=dD5AG0acQDWO9l+KHBAzXj7O/mhROeBTi+xr3cOkfI4mXm+SfkN0f2WRmkY5DBH9fC
         /JbM1KIFv/7A/XSymeCs7n1BQGbRsU0H02e/Wh65bFj3ifshU1k16RHJJg7sYCx3y4rO
         VolDqpqCkAOX91mTgS4dFGfytoX4hOodkY94pG/qU6XyOPRjAlpS25MZllOnWkqjxCxG
         URJKWVh1259jMI1NuB66oBZL5hbOMq1cfFS93c6xcpUUvDmAk1UwQ3DQwe2k4CIbC8vE
         NAxytdPSUXu4lCB70k89B1hJbRtwvH1JoPxDY1Av1JGd44OJyjayhbCUwXxZRM1XJlDw
         CAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762622792; x=1763227592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oKX/131TEur+U1ws0a+nOk/0nOWDLcKaeuLKOvTYpSE=;
        b=DEYuqXcrRVc/a/Hvq++bG9/FHa06gwt3aEras4B0q5HEEjnbq0pbO48U3T1kPvPFq4
         sgZPo3Qd2uFqPrweYZF/dsO/kCgov1ZQs+EJ7fAQ5upIX6RmSXksLR3CtFEYi+nEbFow
         HommZw1VxyaorPtLCnSdHi0IfrNC0e3q1r3LFwuQ2xW0ccGjaqoLlD55a3nz+xYhpEdY
         KUEMuxjsTQQa3ZWcfAisrNo8jFbo66svMnK5gpRCAV2WEwtYqes7G2MTaHaV5ahMfkQ3
         CKKzl/HHzBgN31GkJNbd5k/+KkV/MmoYytNLP0d7IcFqKb490zkEdjGiHyVjn1vsDQZY
         /rfg==
X-Forwarded-Encrypted: i=1; AJvYcCU5jP2nKguRPrgKDOqDqFf+bI6hd6E+LpEwOwGFA4uTMiV8HMkOzGy/SI3UVg7KUmiRZ8Pl2SDROUsc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz3Rjm1AHctu6OQfjZLjxUOkhZbCkc9c0xaD7HrERJLxPiaSzz
	NfdZt8Sv06G7MMJG1461IufxztMD/vk4GtWdU4C1v4uxSEkrxn3jPfSb
X-Gm-Gg: ASbGnct/XX9e+j4uj9YYBfd0c17GmuK3zxcENqIwI44dtSfcLGMpSaQeeg1QleKgqU3
	9pWzeBWFdRCunk/xAA7uGXqYDURbxDPqydn3Xh8RJcHMezsu9ynJ2l/MPf0lFPiooWwS2PPRbtC
	PdB8Wdsd+QJD2UqURW/6lAu9LKWHCA/5JXIVqeS4fHzHomxeKXXl7q4QqbOtak4M7WECppDQSCq
	brnwYMlJoE5XQ5uhU/BY9E/ZnMh3lAkk9147eRpso5OObITEAJq1N+yTe3TC3BhFgzdpeKj+mBD
	Oo7D0Szh9N3tjqKlkpiycoUC0Qmi/W9Rqo6OUYBU4KHBLAcj6P/zRiyX4jHYAaqIACygRHKkAUP
	128GO59qH4lXfx7ICY8MFis2ZM3FAWbyof6njxFEn7Afo8p/5Q99JX5raEdRmBugm+ed+zqHqme
	K0yc2PntD0RTMKEPoEdIk0vfcWEQ2QRPdjAH8=
X-Google-Smtp-Source: AGHT+IH4teb6TaYW1xg4uJQv+WZcVr1MVnIhG1sOWOWypgVOcL81T9P773N1D5H9ZmD3rsY52c3wxQ==
X-Received: by 2002:a17:90b:37d0:b0:32e:3829:a71c with SMTP id 98e67ed59e1d1-3436cb9ed9emr4303314a91.16.1762622791726;
        Sat, 08 Nov 2025 09:26:31 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3436c3d7dddsm2769122a91.7.2025.11.08.09.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 09:26:31 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: david@redhat.com,
	tglx@linutronix.de,
	segher@kernel.crashing.org,
	riel@surriel.com,
	peterz@infradead.org,
	linux@armlinux.org.uk,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	brauner@kernel.org,
	arnd@arndb.de,
	jlayton@kernel.org,
	aalbersh@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	max.kellermann@ionos.com,
	ryan.roberts@arm.com,
	nysal@linux.ibm.com,
	urezki@gmail.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev,
	will@kernel.org
Subject: [PATCH v2 3/4] Provide the always inline version of some functions
Date: Sun,  9 Nov 2025 01:23:45 +0800
Message-ID: <20251108172346.263590-4-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251108172346.263590-1-qq570070308@gmail.com>
References: <20251108172346.263590-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On critical hot code paths, inline functions can optimize performance.
However, for current compilers, there is no way to request them to inline
at a specific calling point of a function.

Add a always inline version to some functions, so that they can be chosen
when called in hot paths.

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/arm/include/asm/mmu_context.h      | 12 +++++++-
 arch/s390/include/asm/mmu_context.h     | 12 +++++++-
 arch/sparc/include/asm/mmu_context_64.h | 12 +++++++-
 kernel/sched/core.c                     | 38 ++++++++++++++++++++++---
 4 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index db2cb06aa8cf..e77b271570c1 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -80,7 +80,12 @@ static inline void check_and_switch_context(struct mm_struct *mm,
 #ifndef MODULE
 #define finish_arch_post_lock_switch \
 	finish_arch_post_lock_switch
-static inline void finish_arch_post_lock_switch(void)
+/*
+ * finish_arch_post_lock_switch_ainline - the always inline version of
+ * finish_arch_post_lock_switch, used for performance sensitive paths.
+ * If unsure, use finish_arch_post_lock_switch instead.
+ */
+static __always_inline void finish_arch_post_lock_switch_ainline(void)
 {
 	struct mm_struct *mm = current->mm;
 
@@ -99,6 +104,11 @@ static inline void finish_arch_post_lock_switch(void)
 		preempt_enable_no_resched();
 	}
 }
+
+static inline void finish_arch_post_lock_switch(void)
+{
+	finish_arch_post_lock_switch_ainline();
+}
 #endif /* !MODULE */
 
 #endif	/* CONFIG_MMU */
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index d9b8501bc93d..577062834906 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -97,7 +97,12 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 }
 
 #define finish_arch_post_lock_switch finish_arch_post_lock_switch
-static inline void finish_arch_post_lock_switch(void)
+/*
+ * finish_arch_post_lock_switch_ainline - the always inline version of
+ * finish_arch_post_lock_switch, used for performance sensitive paths.
+ * If unsure, use finish_arch_post_lock_switch instead.
+ */
+static __always_inline void finish_arch_post_lock_switch_ainline(void)
 {
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
@@ -120,6 +125,11 @@ static inline void finish_arch_post_lock_switch(void)
 	local_irq_restore(flags);
 }
 
+static inline void finish_arch_post_lock_switch(void)
+{
+	finish_arch_post_lock_switch_ainline();
+}
+
 #define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev,
                                struct mm_struct *next)
diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
index 78bbacc14d2d..ca7019080574 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -160,7 +160,12 @@ static inline void arch_start_context_switch(struct task_struct *prev)
 }
 
 #define finish_arch_post_lock_switch	finish_arch_post_lock_switch
-static inline void finish_arch_post_lock_switch(void)
+/*
+ * finish_arch_post_lock_switch_ainline - the always inline version of
+ * finish_arch_post_lock_switch, used for performance sensitive paths.
+ * If unsure, use finish_arch_post_lock_switch instead.
+ */
+static __always_inline void finish_arch_post_lock_switch_ainline(void)
 {
 	/* Restore the state of MCDPER register for the new process
 	 * just switched to.
@@ -185,6 +190,11 @@ static inline void finish_arch_post_lock_switch(void)
 	}
 }
 
+static inline void finish_arch_post_lock_switch(void)
+{
+	finish_arch_post_lock_switch_ainline();
+}
+
 #define mm_untag_mask mm_untag_mask
 static inline unsigned long mm_untag_mask(struct mm_struct *mm)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0e50ef3d819a..c50e672e22c4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4884,7 +4884,13 @@ static inline void finish_task(struct task_struct *prev)
 	smp_store_release(&prev->on_cpu, 0);
 }
 
-static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
+/*
+ * do_balance_callbacks_ainline - the always inline version of
+ * do_balance_callbacks, used for performance sensitive paths.
+ * If unsure, use do_balance_callbacks instead.
+ */
+static __always_inline void do_balance_callbacks_ainline(struct rq *rq,
+		struct balance_callback *head)
 {
 	void (*func)(struct rq *rq);
 	struct balance_callback *next;
@@ -4901,6 +4907,11 @@ static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
 	}
 }
 
+static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
+{
+	do_balance_callbacks_ainline(rq, head);
+}
+
 static void balance_push(struct rq *rq);
 
 /*
@@ -4949,11 +4960,21 @@ struct balance_callback *splice_balance_callbacks(struct rq *rq)
 	return __splice_balance_callbacks(rq, true);
 }
 
-static void __balance_callbacks(struct rq *rq)
+/*
+ * __balance_callbacks_ainline - the always inline version of
+ * __balance_callbacks, used for performance sensitive paths.
+ * If unsure, use __balance_callbacks instead.
+ */
+static __always_inline void __balance_callbacks_ainline(struct rq *rq)
 {
 	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
 }
 
+static void __balance_callbacks(struct rq *rq)
+{
+	__balance_callbacks_ainline(rq);
+}
+
 void balance_callbacks(struct rq *rq, struct balance_callback *head)
 {
 	unsigned long flags;
@@ -5003,7 +5024,8 @@ static inline void finish_lock_switch(struct rq *rq)
 #endif
 
 #ifndef finish_arch_post_lock_switch
-# define finish_arch_post_lock_switch()	do { } while (0)
+# define finish_arch_post_lock_switch()		do { } while (0)
+# define finish_arch_post_lock_switch_ainline()	do { } while (0)
 #endif
 
 static inline void kmap_local_sched_out(void)
@@ -5050,6 +5072,9 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 
 /**
  * finish_task_switch - clean up after a task-switch
+ * finish_task_switch_ainline - the always inline version of this func
+ * used for performance sensitive paths
+ *
  * @prev: the thread we just switched away from.
  *
  * finish_task_switch must be called after the context switch, paired
@@ -5067,7 +5092,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
  * past. 'prev == current' is still correct but we need to recalculate this_rq
  * because prev may have moved to another CPU.
  */
-static struct rq *finish_task_switch(struct task_struct *prev)
+static __always_inline struct rq *finish_task_switch_ainline(struct task_struct *prev)
 	__releases(rq->lock)
 {
 	struct rq *rq = this_rq();
@@ -5159,6 +5184,11 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	return rq;
 }
 
+static struct rq *finish_task_switch(struct task_struct *prev)
+{
+	return finish_task_switch_ainline(prev);
+}
+
 /**
  * schedule_tail - first thing a freshly forked thread must call.
  * @prev: the thread we just switched away from.
-- 
2.51.0

