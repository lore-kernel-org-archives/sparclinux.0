Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F4199EA2
	for <sparclinux@vger.kernel.org>; Mon, 23 Dec 2024 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947203; cv=none; b=DUWqp9ouTYuPVFgMsF3EiXBnDRCS7EpLo84p1Sw4zbQLWDIThygn7zZYq8rv4uFN0pdeT7BQhDTLh9d58XWT1Xq4i2cW41fJl4CPJGCRRO0pZFuocXjhqnxZoEDG3RhGj6juqS1iozs8YHBMf3zgmNyiNC2EWKhe5S/EU9As8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947203; c=relaxed/simple;
	bh=z7CWl7O3eullh1F2ul6vkw9nxR1R7juWYomvqNSqC4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IEBewRxMutOB4mOCnjTGmLsHIdwNcSTZr2yGhYX5w7Ze4y/SJJW5LlshzZxveWVrnSVu7BtAxNJm8ecBKuo+Xjx+WMtbNPFA4xBQl9kJXdovv1hkCyFazQxLZ9jkNUay+Py9ZWtKx4fBHjVW25F5ktaTTEYY/+YZuOnMHNUeahY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gBJl0ZEh; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gBJl0ZEh"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725ea1e19f0so3222708b3a.3
        for <sparclinux@vger.kernel.org>; Mon, 23 Dec 2024 01:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947200; x=1735552000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vy7m3PQdTp9s3cHn2TFUEZi29ZbV6wwwxQw/bfJltk=;
        b=gBJl0ZEhPzt/YSVHFKr2G4DdLNfHEeophzf6xmt5hCsiabjCqcPJbB3Q9Y/7nmsme7
         poM4DwoLIFZWGSCWZJTwjTM8ndd0C8Yw18HkASeG7zFK+VVeS2Nf69oEJRfu5s/AJkYj
         aQkDbDagyRe8U46EnyVq2TwDG+CPWkCmxCZFQrkRpzBtV7aKmFBumvlZif5WOL3WRKZT
         jABbdnWKZoXLBvRJeaeVUqY1vOLNfyTmAau39IhKdbinpDl7svx0FvYBFps/t4XqkLvo
         nA4zbKRN6ZAB3c7BaDnFnRiqDpJjSV3Pzx1TGH2u/AiK68Hf+z0CDLrcsFWE0lJn3G+t
         MEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947200; x=1735552000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Vy7m3PQdTp9s3cHn2TFUEZi29ZbV6wwwxQw/bfJltk=;
        b=u21RJqCMLLScdrGmDS7p7pofmUQt1Wyive6Wr0pbm3Qh2jlKqzeG5tNsxmM3KtRt99
         XX+fjqmQXgRK1S76OPHD6K5Bn0KJD5qfQPg9eTcNbSBmKyBTdxhmu49xd1xFWV0QGh/8
         kNurA+eW01klXN3K7z37HmksBgyxYOP8Crj/Gm++eC/tQO+HMDAQiiGbnuQpPa/t7NF0
         U7Q9+gvGESoeUkmik8cwyQB9qkl0x+0V+Cs5qNNUnDAtK9BaEx/9bADVFQA1xSsYiB1E
         9+qRJcfHM+8fjIum4vt0iythEm0X0d9vnaVX5ag1N6pXRENjQ5DPolpbvsTaUsTSEtdY
         nDQg==
X-Forwarded-Encrypted: i=1; AJvYcCX0iO6vNKAn7HPUdlX23D560VVp14NSzmp1ICWVyvwuFxiKbjCgQc1S4HxR0CLQTzkIWQTNeXp+m1Sl@vger.kernel.org
X-Gm-Message-State: AOJu0YwaOVm9ohSWY3gkKCYHY5puXY9gyaC+aQzsVC/xsS0RC+HlHq9J
	CqHxoxGnQZeHgOv+Zt+O91L9tJCQH86lztlyP4/WO44D4Sdz7D3jtz5CUhgBFfU=
X-Gm-Gg: ASbGncvTe6v7542FX7he+JmvGAkjm9+wL59eg+VbGx58TRreTDuhlYTrFQkwaxF6pIv
	VHAi9CrwtERq8ZK2ha7mdX9u3Y8ZvPripwslkUNfK6VQwhssrn+H/KvdmdYnOm4KKtZXmJQQI4u
	GmiEAlMIlAGZO2/22ULmhbM3YDurzwO6fO07HVbMSfpIcY1zOeFmiCP02I0ErnI2KDw9pNcxP64
	XiW1WzVjAleMfCGzh8Do++Ut24l2MR72OL8Ev7QppxBZ1zAzFzY02LtALCuxFhAbO1Lt3a3Oqjb
	Zt02BMHrBkAa+rQcVtViuw==
X-Google-Smtp-Source: AGHT+IHTlP+hesMysY/dnyw4k1T/aSGpJ0FSxzWG+ektln9VxnC2FaHlf9zeRwOgabkwOIXU2HSkPg==
X-Received: by 2002:a05:6a00:2407:b0:729:597:4faa with SMTP id d2e1a72fcca58-72abde9c004mr15027146b3a.16.1734947200520;
        Mon, 23 Dec 2024 01:46:40 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:46:40 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
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
Subject: [PATCH v3 17/17] mm: pgtable: introduce generic pagetable_dtor_free()
Date: Mon, 23 Dec 2024 17:41:03 +0800
Message-Id: <3ade33c5049f465dc2f0b95edc2d68c80f2048c9.1734945104.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734945104.git.zhengqi.arch@bytedance.com>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pte_free(), pmd_free(), __pud_free() and __p4d_free() in
asm-generic/pgalloc.h and the generic __tlb_remove_table() are basically
the same, so let's introduce pagetable_dtor_free() to deduplicate them.

In addition, the pagetable_dtor_free() in s390 actually does the same
thing, so let's s390 also calls generic pagetable_dtor_free().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/s390/mm/pgalloc.c        | 18 ++++++------------
 include/asm-generic/pgalloc.h | 23 ++++-------------------
 include/asm-generic/tlb.h     |  5 +----
 include/linux/mm.h            |  8 ++++++++
 4 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 3e002dea6278f..1e0727be48eaf 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -180,32 +180,26 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	return table;
 }
 
-static void pagetable_dtor_free(struct ptdesc *ptdesc)
-{
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
-}
-
 void page_table_free(struct mm_struct *mm, unsigned long *table)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(table);
+	struct page *page = virt_to_page(table);
 
-	pagetable_dtor_free(ptdesc);
+	pagetable_dtor_free(page);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void pte_free_now(struct rcu_head *head)
 {
-	struct ptdesc *ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
+	struct page *page = container_of(head, struct page, rcu_head);
 
-	pagetable_dtor_free(ptdesc);
+	pagetable_dtor_free(page);
 }
 
 void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(pgtable);
+	struct page *page = virt_to_page(pgtable);
 
-	call_rcu(&ptdesc->pt_rcu_head, pte_free_now);
+	call_rcu(&page->rcu_head, pte_free_now);
 	/*
 	 * THPs are not allowed for KVM guests. Warn if pgste ever reaches here.
 	 * Turn to the generic pte_free_defer() version once gmap is removed.
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 4afb346eae255..7d327889df306 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -107,10 +107,7 @@ static inline pgtable_t pte_alloc_one_noprof(struct mm_struct *mm)
  */
 static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
 {
-	struct ptdesc *ptdesc = page_ptdesc(pte_page);
-
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(pte_page);
 }
 
 
@@ -150,11 +147,7 @@ static inline pmd_t *pmd_alloc_one_noprof(struct mm_struct *mm, unsigned long ad
 #ifndef __HAVE_ARCH_PMD_FREE
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
-
-	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(virt_to_page(pmd));
 }
 #endif
 
@@ -199,11 +192,7 @@ static inline pud_t *pud_alloc_one_noprof(struct mm_struct *mm, unsigned long ad
 
 static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(pud);
-
-	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(virt_to_page(pud));
 }
 
 #ifndef __HAVE_ARCH_PUD_FREE
@@ -245,11 +234,7 @@ static inline p4d_t *p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long ad
 
 static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
-
-	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(virt_to_page(p4d));
 }
 
 #ifndef __HAVE_ARCH_P4D_FREE
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 583e95568f52b..ef25169523602 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -211,10 +211,7 @@ struct mmu_table_batch {
 #ifndef __HAVE_ARCH_TLB_REMOVE_TABLE
 static inline void __tlb_remove_table(void *table)
 {
-	struct ptdesc *ptdesc = page_ptdesc((struct page *)table);
-
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(table);
 }
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index cad11fa10c192..cd078d51f47c7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3001,6 +3001,14 @@ static inline void pagetable_dtor(struct ptdesc *ptdesc)
 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
+static inline void pagetable_dtor_free(void *table)
+{
+	struct ptdesc *ptdesc = page_ptdesc((struct page *)table);
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
+}
+
 static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
 {
 	struct folio *folio = ptdesc_folio(ptdesc);
-- 
2.20.1

