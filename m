Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D712F27A929
	for <sparclinux@vger.kernel.org>; Mon,  1 Sep 2025 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759846; cv=none; b=LGR2ClxN0OXZdZDnte0Q6/r6CjFXnFlPaT3GeDCLCZegvwQ0JB4I3mCI6GUMwO6rmjjDclbiGv6oUI8Ax21YEN5QJFlA73cfv28mJLOU5uS9KqnV0HEe8G7ChxZD/ROyE7bxa8O/HALgxusiS4ELLqul3LI4lclzGO9PqizsTLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759846; c=relaxed/simple;
	bh=Uiwj5FytXh8JuGFYDmzftQKcOe0iTru3tGLWkIpecec=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2QxD/mG1EjV9S8KrmPzXRwSNQWnUQ0S9NVHFPqUaFfiaqsTIhtiWrxCOtuXIB9Hj3fpX97tKi0tHwc6uNzi6KK4qKr9+FXDKNUQ+iwf7ILaIdSgxb5HqdygBuX+qaRASSseU0hoHoG75JNv/ayA8M4Bkqd2f28t0Bm3biyS31I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hVucwSm7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hVucwSm7"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b042ec947e4so210470566b.0
        for <sparclinux@vger.kernel.org>; Mon, 01 Sep 2025 13:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759843; x=1757364643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xc7ijYojCT4luS7LR3VDEJwaByj8Czavl1FcpBrU7UU=;
        b=hVucwSm7pi8jhoXlcCNB4cUSsA2xoXsm4NPxGeBRQqDYhHmSUxmdy/KXjrJHHG8iUl
         AC+GzfT1dEL8hUKifuoOgP/1KE28PYlFhpgR/huCFs3NA/h57/soKgpmiWb2LpSbq8Kw
         k3itCb1lmCLeZmG9ktU953RHHM884rXBOIKB17RfEr6sqTmm9kpcXGJgVKS+PCQtig3W
         FT7/lcoOsa0tX7DQ2hWMpRX8X6ZInEiEyrp4wk9LvyUs2vvixlzJqBCfir6Bw2iYbTyz
         MBur2ZRhKqR1oLTbbJbU+IeORkF+v4+FYWxrTSFJTteRbdEhaXVmDQmxhmfN1eDKVGcz
         tMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759843; x=1757364643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xc7ijYojCT4luS7LR3VDEJwaByj8Czavl1FcpBrU7UU=;
        b=pIZ/j4jUq+Kmu9cAzSXSeaxRo0OBG+cqb5uvPSPbua8AWZOjwp8RUr9LM7OablUJz3
         LqUrsSeC2LYh1M+osqKoAEkAt+U53JXHqM7bX5tUF23TaqZMjqnUeCPMdm/CuArDV3Fj
         VoZq8IWX9X2V8a/oEHS0mojw+nQtQAIDG07+TIM4z/w+D3MQuOjbNL/QK/oly/QB682C
         y0pUM8zjpM0MCyOcd7W1ZN4EvupoYE44i38pjjbZA0cJJWzYhtMMp8wx+LQ+vTPNUC/D
         9eZNy3+mW+Ax5PmM4Ui7nEKmuZBaGhMERy28g41P344GJYYcMuD8ut0i5fvvjBWr7lGM
         /TIA==
X-Forwarded-Encrypted: i=1; AJvYcCUotFHYexwM6F/qatTrbzQRHK75eRbJFqr9ZK6nybFTBr9KOo7OzBZpqDLJhZrBss/i6qAo1yY4NKzW@vger.kernel.org
X-Gm-Message-State: AOJu0YxsD0aYzAO/zhr5kVPf4CFsFnitktEm+8boRGOYEnrM+O3w55e4
	Jbly6f6WsyvvqGE0LyltY5TXdPR/MtoB4jc6ba6bEAC1CrnVhBCiAZtE/yKR4Qtt8fs=
X-Gm-Gg: ASbGnctky47MDw1/M8je97QkNv7k+/eTVclY1zbLtqPWeQpWWXyAtfaSn3KqYywMKJW
	9j3BiyOsJZ4CTEh8gZ7Nq1PfN/KzxyBhptTkAZnpXeTQGV/TwbWH1JTS9abVCGAeFnN9dp04+2B
	W476yHQJBnCI5KXS/sJ3GRq6/4hcsHwiRTS+ejWSIOoKjoMlqaPjwrMD/+NzN5H73PhKAUFUxtf
	sdIZ2IWDVMdKImiYcz0yzv3tmL4mI2zI55tDTOZP46Coz3E9M5mbcb7d4i21gAK7JQVa+ra6pms
	D+HbQBL+Ytmtyl/v4l7g276GcY1afikP0pkRqu3lhyT6YhPQSlBzTCexujdTi/37suHuuMQHe9A
	dhlc8ToQ9e8VJFiaB/f8K7lpge/tm7RsGBZA9T9PMRoFepti109D41ETG7bgVAUeHqhFzLNRtNl
	K0O4ZVfKVGvW+zFJsfb2ZXXq6BWI55RmBh
X-Google-Smtp-Source: AGHT+IGzJPehXmI9EiALURY/rXkYz5IeFVzDP1ESKudUiTiCx5T7yEPplQz84NPBzI/8iDTakDOKMg==
X-Received: by 2002:a17:907:60d3:b0:ae0:b3be:f214 with SMTP id a640c23a62f3a-b01d8a267damr879923866b.9.1756759843094;
        Mon, 01 Sep 2025 13:50:43 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:42 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 08/12] mm: constify arch_pick_mmap_layout() for improved const-correctness
Date: Mon,  1 Sep 2025 22:50:17 +0200
Message-ID: <20250901205021.3573313-9-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901205021.3573313-1-max.kellermann@ionos.com>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function only reads from the rlimit pointer (but writes to the
mm_struct pointer which is kept without `const`).

All callees are already const-ified or (internal functions) are being
constified by this patch.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/s390/mm/mmap.c              | 4 ++--
 arch/sparc/kernel/sys_sparc_64.c | 2 +-
 arch/x86/mm/mmap.c               | 6 +++---
 include/linux/sched/mm.h         | 4 ++--
 mm/util.c                        | 6 +++---
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index e188cb6d4946..197c1d9497a7 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -47,7 +47,7 @@ static unsigned long mmap_base_legacy(unsigned long rnd)
 }
 
 static inline unsigned long mmap_base(unsigned long rnd,
-				      struct rlimit *rlim_stack)
+				      const struct rlimit *rlim_stack)
 {
 	unsigned long gap = rlim_stack->rlim_cur;
 	unsigned long pad = stack_maxrandom_size() + stack_guard_gap;
@@ -169,7 +169,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long ad
  * This function, called very early during the creation of a new
  * process VM image, sets up which VM layout function to use:
  */
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *mm, const struct rlimit *rlim_stack)
 {
 	unsigned long random_factor = 0UL;
 
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 785e9909340f..55faf2effa46 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -294,7 +294,7 @@ static unsigned long mmap_rnd(void)
 	return rnd << PAGE_SHIFT;
 }
 
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *mm, const struct rlimit *rlim_stack)
 {
 	unsigned long random_factor = mmap_rnd();
 	unsigned long gap;
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index 708f85dc9380..82f3a987f7cf 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -80,7 +80,7 @@ unsigned long arch_mmap_rnd(void)
 }
 
 static unsigned long mmap_base(unsigned long rnd, unsigned long task_size,
-			       struct rlimit *rlim_stack)
+			       const struct rlimit *rlim_stack)
 {
 	unsigned long gap = rlim_stack->rlim_cur;
 	unsigned long pad = stack_maxrandom_size(task_size) + stack_guard_gap;
@@ -110,7 +110,7 @@ static unsigned long mmap_legacy_base(unsigned long rnd,
  */
 static void arch_pick_mmap_base(unsigned long *base, unsigned long *legacy_base,
 		unsigned long random_factor, unsigned long task_size,
-		struct rlimit *rlim_stack)
+		const struct rlimit *rlim_stack)
 {
 	*legacy_base = mmap_legacy_base(random_factor, task_size);
 	if (mmap_is_legacy())
@@ -119,7 +119,7 @@ static void arch_pick_mmap_base(unsigned long *base, unsigned long *legacy_base,
 		*base = mmap_base(random_factor, task_size, rlim_stack);
 }
 
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *mm, const struct rlimit *rlim_stack)
 {
 	if (mmap_is_legacy())
 		mm_flags_clear(MMF_TOPDOWN, mm);
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2201da0afecc..0232d983b715 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -178,7 +178,7 @@ static inline void mm_update_next_owner(struct mm_struct *mm)
 #endif
 
 extern void arch_pick_mmap_layout(struct mm_struct *mm,
-				  struct rlimit *rlim_stack);
+				  const struct rlimit *rlim_stack);
 
 unsigned long
 arch_get_unmapped_area(struct file *filp, unsigned long addr,
@@ -211,7 +211,7 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 				  unsigned long flags, vm_flags_t vm_flags);
 #else
 static inline void arch_pick_mmap_layout(struct mm_struct *mm,
-					 struct rlimit *rlim_stack) {}
+					 const struct rlimit *rlim_stack) {}
 #endif
 
 static inline bool in_vfork(struct task_struct *tsk)
diff --git a/mm/util.c b/mm/util.c
index 241d2eaf26ca..77462027ad24 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -431,7 +431,7 @@ static int mmap_is_legacy(const struct rlimit *rlim_stack)
 #define MIN_GAP		(SZ_128M)
 #define MAX_GAP		(STACK_TOP / 6 * 5)
 
-static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
+static unsigned long mmap_base(const unsigned long rnd, const struct rlimit *rlim_stack)
 {
 #ifdef CONFIG_STACK_GROWSUP
 	/*
@@ -462,7 +462,7 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
 #endif
 }
 
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *mm, const struct rlimit *rlim_stack)
 {
 	unsigned long random_factor = 0UL;
 
@@ -478,7 +478,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 	}
 }
 #elif defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *mm, const struct rlimit *rlim_stack)
 {
 	mm->mmap_base = TASK_UNMAPPED_BASE;
 	mm_flags_clear(MMF_TOPDOWN, mm);
-- 
2.47.2

