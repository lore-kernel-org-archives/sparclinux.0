Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA291AC42B
	for <sparclinux@vger.kernel.org>; Wed,  8 Jan 2025 07:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319807; cv=none; b=tZs95VRg3AaDE/68C7vScN8BuREcfC+a/KLFXm9qs2ku8VsmViFtNDKYnFdieiBGgCgOi8K1JrE+E3h7BrKQS6gL15gvcLCG+hrIqhBCTif5IVti9GHsRm+d76Rikva4uRMGJhfQ9SyZieONtnkYHfjz+2RVJFOAh12c6DLo+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319807; c=relaxed/simple;
	bh=/Z4BDRon0Bevgr5mvsJCh3x7OaoERaQ2cVgkjt99Nxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tctB2zzul3zknegMOMh7bJfCMT29rqfZ5RDky00tzHlfd7aq4SeNIVTyFrfHAtPsDsjDPumHgAjyJmzJH2JojhDEN1S7Cx5hU/ZfJT4/SBr6Oo0dCvLVZkgdZRu1TlVSQofTMQi23bEu3x2VZBRQlBUHbgIkiBDD+4HzNvdOWuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Bujf4aZk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Bujf4aZk"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2156e078563so210961615ad.2
        for <sparclinux@vger.kernel.org>; Tue, 07 Jan 2025 23:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319804; x=1736924604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x40aCfPUIT+7f+SOGlgpQ1mZ5+3GERu3xGzgSvQpPds=;
        b=Bujf4aZkjw72UhClVTmyLsiBn7MRga03gknCk8ch02tYmNn1EcQy2aGfTVul9Yuewg
         TkJR7hhvPKitum95BdkelwMwuLaaKtKkw+qL1gu+zxtOlRuReYrDeRekypnnhGx3bwSX
         VeghCEO1Cibcla+ajxtqSM/3LCNY0osW+PgdjK6yl9oxZdT6a05n4fvUcpwTum4C90Gu
         4Dqa4X5b9EckXWyvd+9srkK09ugKfoIlUcb4B4lB8uzwsSj9/vVDgFhrs/n84BM39IcA
         kPoGAj4W6B6lsBxtUKebiUewcFE7zu2wfF5lNOcy0yFeaRNUdEFSyIyZU042WDt/wRTZ
         lbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319804; x=1736924604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x40aCfPUIT+7f+SOGlgpQ1mZ5+3GERu3xGzgSvQpPds=;
        b=Oa4fTu+RUEeS7ul0ThTxRYIcvn+3Sba3UvTQamscWElnDZSol9HL+0GIXBga35i7Db
         3/AgT07Kt9KmBjOBdWzGyLseSm/0M1Mdwf4kaIaTrC+b1EFo5D70n5+it4wSohc1QeGn
         P5qVRavmR9z3xkyx9rBIT6hexYZUGHr8N4YYpBywV5WaMSnFS4uPEzJgvEY92eA3F3rb
         uJ2WnwuziyNJ/ghnjy+BsSHLddsbnoC+v0VDCYlP1yJoqhNw+pZRvcG5upUoWsr89E3e
         R0tR0DQ/q+MjOl8vuHjKYi8l1QD39B7+EKN7Jeak6fIiJfz3IVKiyETMCwOXGCzfUMGa
         7Inw==
X-Forwarded-Encrypted: i=1; AJvYcCWCx3kxfXlzzJrFS92agpvapsTG53Vf+0r/jhG4U0miAa+U6qrGTYWkxOneE0LWfHnqorgnsLtFgcuT@vger.kernel.org
X-Gm-Message-State: AOJu0YzqiyxrE5n8YBUFju9S+Uo/K2x5gza3zp/Q+L6dUmHngHmSGnyD
	hj466rndlzLJW98v53eA1IbI8OrEmZsoYQuo2nR1CYszH6mG3OxH47BVzWCvyD8=
X-Gm-Gg: ASbGncveXxjX+0cB4a0fUmiwej6i+BXOyUonRHZEZyFajDLXQSIL6D2Tu/gQgSjor1O
	QgSiHhRMX1x4NUvsV276iJ56djkOxNBggfwDbUj681j/Kc9itWYRgXLSOcKghxKRU73WV2M9MqH
	+NrrevI7yWiTk+1F93TqjbrAumERRGd27TKq2KVe8vSQu0HUNEv2aUABxtB73XA0cLpxQSezZay
	TLDFVaeytpqmIr405Nm407hG4k6X6+Jowb5I6qlDKNOWABkOzLfJdIPpNAPUlXM+CRM9KSHL/fY
	dJjFqQO8+ZtdrfP8uk0D4qkdEGo=
X-Google-Smtp-Source: AGHT+IH8IKObAIjKqBGW3XQDBdiOawtDgYf1Tuj1urKOF9Kp4Be/TSELj5l2Ma8a+iBaK6i0ld/PMQ==
X-Received: by 2002:a17:902:da8e:b0:216:410d:4c67 with SMTP id d9443c01a7336-21a83fb1395mr28350885ad.41.1736319804422;
        Tue, 07 Jan 2025 23:03:24 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:03:23 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	alex@ghiti.fr,
	andreas@gaisler.com,
	palmer@dabbelt.com,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com,
	vishal.moola@gmail.com,
	arnd@arndb.de,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 16/17] mm: pgtable: move __tlb_remove_table_one() in x86 to generic file
Date: Wed,  8 Jan 2025 14:57:32 +0800
Message-Id: <aab8a449bc67167943fd2cb5aab0a3a23b7b1cd7.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __tlb_remove_table_one() in x86 does not contain architecture-specific
content, so move it to the generic file.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/x86/include/asm/tlb.h | 19 -------------------
 mm/mmu_gather.c            | 20 ++++++++++++++++++--
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 3858dbf75880e..77f52bc1578a7 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -20,25 +20,6 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
 }
 
-#ifdef CONFIG_PT_RECLAIM
-static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
-{
-	struct ptdesc *ptdesc;
-
-	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
-	__tlb_remove_table(ptdesc);
-}
-
-static inline void __tlb_remove_table_one(void *table)
-{
-	struct ptdesc *ptdesc;
-
-	ptdesc = table;
-	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
-}
-#define __tlb_remove_table_one __tlb_remove_table_one
-#endif /* CONFIG_PT_RECLAIM */
-
 static inline void invlpg(unsigned long addr)
 {
 	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 1e21022bcf339..7aa6f18c500b2 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -311,13 +311,29 @@ static inline void tlb_table_invalidate(struct mmu_gather *tlb)
 	}
 }
 
-#ifndef __tlb_remove_table_one
+#ifdef CONFIG_PT_RECLAIM
+static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
+{
+	struct ptdesc *ptdesc;
+
+	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
+	__tlb_remove_table(ptdesc);
+}
+
+static inline void __tlb_remove_table_one(void *table)
+{
+	struct ptdesc *ptdesc;
+
+	ptdesc = table;
+	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
+}
+#else
 static inline void __tlb_remove_table_one(void *table)
 {
 	tlb_remove_table_sync_one();
 	__tlb_remove_table(table);
 }
-#endif
+#endif /* CONFIG_PT_RECLAIM */
 
 static void tlb_remove_table_one(void *table)
 {
-- 
2.20.1

