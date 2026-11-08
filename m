Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177369;
	b=SEAgacHuRS3imhd51I+s7kgktocM5oKdED21/odVVz0F8TtvdyrlzV/XiqrtbdwTEVr4
	 a8up0uabCDxYCOHFUX6miO4rYnQO4zo+ZhnDeBkiKBh9ecFTCN7X61i2wUbLs7B1q2cpe
	 WvoNWTm74H+gYV2xSP2XLhOrFH8oZeObr8YaIW7et0M104cN6tfnTvE3+IcWv4b/3FR4m
	 /qT1khEgc00x6JvnEZGeQ2M08yTVvBpork71KOy8GOFN3aWZ52EOCt24wIvrtx/d3myB8
	 h4uRskIHfnnn00sGP+2A7r2A7NfMJtUq4mimkAa2l9Fp8iduADeqNgS4er7dKQKXUYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=62VFOg8MBQwHAYCXFCSU2NA7xtVlUF2RJoBXeGfN2Ak=;
	b=tU2fC79ZLClQmsIqLQ/TGBnewquFR7dZ2w8t4B1fum/Crq1HbRtEVP59Y0LztVHJ4pCx
	 CY33bPbs80tAI3Hra/2AObklt4SFnKPb6WvMekcUH6VpN1tALydnhip84ZuTGplEgP7+7
	 VgWx87FHRkmmVN/AqsrgBcHkl4wGExMo1qk5CBYvDT+3uvXk+W1f/Jou7ASvcvETzpc3T
	 6tRj3dCQZvSrvEsgCGF854uwgzTc88jX+6/E7f7Fx4+DSdWzjupwpoxxs0mmW9UeOdIu3
	 P1V82GkZE1puHM2DBjDqB0YFtezZhRnu82GYFQTIXSzxtMdNWkUwKNvVE65WvW5xRsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QnUYllcq;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B57606EEA9
	for <sparclinux@vger.kernel.org>; Sun,  8 Nov 2026 22:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35B57606EEA9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QnUYllcq
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b70880c0a4so346120a12.2
        for <sparclinux@vger.kernel.org>; Sun, 08 Nov 2026 14:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177368; x=1794782168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=62VFOg8MBQwHAYCXFCSU2NA7xtVlUF2RJoBXeGfN2Ak=;
        b=QnUYllcqes2uRUEHKIf8dGsbZO+dZMH3dFyctkPLkJcF5UcUN1RMmWfZut99JVGJQ+
         PS+fsuOvEAK0SLcPD/toeULEOekIFAXvoBXHUVGXkKrAtxyAVt7Vv/v59B68uWYDZ0P9
         ZZP/+6/Prr2xCYasYCWamghb+iZ9TDhWh6pFeCnfpPs6Shwwk3F0b4t1ivgite0dOJFu
         kXwzIKFWl08hqJnR5IB/yiVxYKNI2L7zjKKKbeikUbgmYSidPfYkxDTZHIEWx25zKw+/
         qSOpnCUVY2nlp6MCxzS0lJc5icxNouiW7DDZnI/Y/OEh753VbsKBX45PC4WtvdHl2CGq
         bMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177368; x=1794782168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=62VFOg8MBQwHAYCXFCSU2NA7xtVlUF2RJoBXeGfN2Ak=;
        b=DocA3LdwFYLP23gSDygT8AIXU/ZQD4w9dELAn0PXIQ237P2qWlGwUe4t+GuVVQDuJP
         bG/QG0Ot6ejfdltxwqukt7buwl1vgXzmni3dk5fQ/GG25UUBmHmKTl8FDAp6Ki701ez6
         qZ4q7oPe6HpKj9OJX2FgjkkfPINU06kXx7qMWvCZZ0UxBnzT1q9nV05ITjJfUfIwj5Lb
         h5BRJ1w2h5FGS+saM9ui/06+UZ8/Mwc2vPxh6ET4yVMIJYcZ91faYZyjSEahMUuM9WMv
         VSvUxNwrmqQeRD4EVPm9z5L3MvSvqfq+V50z2pH2fIzPQZ5pQdTLg2phiKNdeHrpSIcI
         34eg==
X-Gm-Message-State: APuU4Z9Vm/o28vXgHzCNcm0fyyqfENU0G0e7xJXyS5M0KkrjQ5CFLSz5
	LWsKvTMsjPztTuJUZe3JBqwTCotabZLs9O5JQFeWG5JVU8uyLfEVqiaX
X-Gm-Gg: AYBFou2U6M1D49TtnXS6NPIpB2L+ZDI0aC73pkibUfJ5REwTqWO+cWrmiSer7xDIGip
	aHAOgTLj2aVyAmg+X23o6HThbSLOODwsZPm2AP+rvbbgQFPxQuLT5qOx0sEm65C6/XSJzqMXZ26
	LB2iW2IfMuCY3oYdXZuvt3rcPiOgMJmvPO1+h/G1SSr+WHk8krcUIvS5/cDLwyO2gZSsht/JE8q
	xOdIG2AQxXhVoP5tq3Z7Slx1uo4I3bIsFnmNDTqFy7NPkUJXWPtvbgprcbg9S6sn0OXggKop6On
	rjr7ya5CUOefN/kppIo3oF18XKOO4nOc/KTVy4VENRAvI2vvwr3W6aG0U0J5g5aWMmWppKqBqo4
	ojx8NvzU1ju+LViC3SXNAI1PmCROlcUfOIQe9xpyYMIZ0BXxqqXUM1BBzHzPaGkoHkHeBZ8sC2H
	Wh64tyCMRMmqsK1a4mq7X+iYLxXDg+eS7Kc4sE2ZBhlaFC4x+iwann2fBi4VKEsVjPrYQPUfjR6
	AYcMWNxPT0Kdm7j3zIQpdpOlUaXC01wLbsx3nxY6SUBUqb0qK8EyquikkDaQqzpFIWck4KgK7yb
	R3RtTVwdSu8mAX7FVcP/3CHwk5AgpRe2WVxTWNaCh9tx6h7ZqCQLNGx5xgz1XsBMHsmvWlY=
X-Received: by 2002:a05:6402:3787:b0:6b7:1b3b:d309 with SMTP id 4fb4d7f45d1cf-6b7224c54abmr1481109a12.33.1794177367600;
        Sun, 08 Nov 2026 14:36:07 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ebc7b0sm859272a12.14.2026.11.08.14.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:36:06 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 9/9] sparc32: enroll and order CPUs before switching address spaces
Date: Sun,  8 Nov 2026 23:34:19 +0100
Message-ID: <20261108223516.1125534-10-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108223516.1125534-1-linmag7@gmail.com>
References: <20261108223516.1125534-1-linmag7@gmail.com>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The task-switch macro records a CPU in the incoming active_mm mask, but
kthread_use_mm() changes address spaces without switching tasks. A
shootdown can therefore miss a CPU using that mm.

Move enrollment to switch_mm(), before installing the context. User task
switches and activate_mm() pass here, as does kthread_use_mm(). Lazy
kernel threads inherit the already active mm on that CPU; they do not
introduce a different hardware context. Keep CPU bits until mm teardown,
as in the preceding fix, and remove the duplicate switch_to() update.

SPARC32 smp_mb() currently expands to a compiler barrier. The hash lock in
set_bit() is acquired before the mask store, so it does not provide a
hardware StoreLoad fence after enrollment. Use STBAR followed by a native
LDSTUB of a private stack byte before changing the context. STBAR orders
prior stores before the atomic operation, including under PSO; LDSTUB
blocks subsequent memory operations. The memory clobber orders the
compiler. SPARC Architecture Manual V8 sections 6.2 and 6.3 describe these
rules.

The shootdown side updates PTEs using native SWAP before inspecting the mm
mask. A newly enrolling CPU must publish its bit before accessing the new
address space: either a concurrent shootdown includes it, or it observes
the updated tables. A returning CPU remains enrolled and cannot be
omitted. Do not rely on processor-specific cache maintenance or a later
refcount operation for this ordering. The local helper does not change the
general SPARC32 barrier implementation and acquires no shared lock.

Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/switch_to_32.h |  1 -
 arch/sparc/mm/srmmu.c                 | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/switch_to_32.h b/arch/sparc/include/asm/switch_to_32.h
index 42eeafcb8a41..1d9855abbc00 100644
--- a/arch/sparc/include/asm/switch_to_32.h
+++ b/arch/sparc/include/asm/switch_to_32.h
@@ -58,7 +58,6 @@ extern struct thread_info *current_set[NR_CPUS];
 #define switch_to(prev, next, last) do {						\
 	SWITCH_ENTER(prev);								\
 	SWITCH_DO_LAZY_FPU(next);							\
-	cpumask_set_cpu(smp_processor_id(), mm_cpumask(next->active_mm));		\
 	__asm__ __volatile__(								\
 	"sethi	%%hi(here - 0x8), %%o7\n\t"						\
 	"mov	%%g6, %%g3\n\t"								\
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index d3634bcb048d..e5c136c8ecd7 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -467,6 +467,18 @@ static void __init sparc_context_init(int numctx)
 		add_to_free_ctxlist(ctx_list_pool + ctx);
 }
 
+/* Order CPU enrollment before accesses through the new context. */
+static inline void sparc32_mm_context_barrier(void)
+{
+#ifdef CONFIG_SMP
+	unsigned char scratch = 0;
+
+	/* STBAR orders prior stores; LDSTUB blocks subsequent loads. */
+	asm volatile("stbar\n\tldstub %0, %%g0"
+		     : "+m" (scratch) : : "memory");
+#endif
+}
+
 void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
 	       struct task_struct *tsk)
 {
@@ -479,6 +491,10 @@ void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
 		srmmu_ctxd_set(&srmmu_context_table[mm->context], mm->pgd);
 	}
 
+	/* kthread_use_mm() can enter an mm without a task switch. */
+	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
+	sparc32_mm_context_barrier();
+
 	if (sparc_cpu_model == sparc_leon)
 		leon_switch_mm();
 
-- 
2.43.0

