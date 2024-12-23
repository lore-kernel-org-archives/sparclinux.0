Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EAE18DF6E
	for <sparclinux@vger.kernel.org>; Mon, 23 Dec 2024 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947062; cv=none; b=FnIs3JP+2+NUSGageahYhCCzpGmCVoefxNKc1uTwFi1KQKpwaEVJr06oz1VDm9IlzSmT2tOrbW0AwhZbUp243VCFr/uY74Zwoqn3rJNx6l7BAfAnweupwNSwQx0sgSjhS4Xwu6Tfs8YkhjUOZ4Z144htGlQAlZeAHwF34sFlwZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947062; c=relaxed/simple;
	bh=gsn2MxaDHMIkVDeNJoAZ1GXzg4UbDMQdMp9AlgDJXWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=avVYu+BvJbFxeaeW1iGZNdq/jiNwdTOPeqLU9B3Yy3ZA7xiWzKSMM4PrkqpNGNyFa1cZlfL/U0x+JGR2srwpKQWYv0OUMlrPgbak2BXWmSqeB+3LUjwsIWuD82NX4Pm//V9QpeWbAJRYNMVBCHS4QPJB3+x6xMsgdtCa+KzdkRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VqAbwFY+; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VqAbwFY+"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so2340538a12.3
        for <sparclinux@vger.kernel.org>; Mon, 23 Dec 2024 01:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947060; x=1735551860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY41yoAggnrpKZDOvMIy0+FhpPRF9QFn+bDK7HKPzWw=;
        b=VqAbwFY+mxfHi24wSoLfeFH9u+D1/KxNf/fdg4uD/4bg61xhkNTGf4yKJXZo5XDk8v
         US3r5OvglLHzKlic2ukiek2bj0BKfKhwiq5abR1rjMk4h2sT7hxuH7kYIcGfvJN7hmIl
         NpU8ovDEiYsPvujSMsQdC+VSEnHHo6NzQ9P6VSmcpk1o7MKw4una5zLtHg4LcTLKAoVT
         sSLPHusPUK63ztodU6/MPaFHL/QX+dspXnSlTUtauT85SM/jfSP4YsWiMkOnJZZTmaU/
         W+f+S+roHE34myJIjQ+Nxd4+zc119g7+jpLtI5Yi6upYQnyGbh7XdXKG5mmSWX+n4F0a
         oA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947060; x=1735551860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY41yoAggnrpKZDOvMIy0+FhpPRF9QFn+bDK7HKPzWw=;
        b=kDrJ568EgqkdX2ZnsNOKKTb1PFFtcuGa4rPRwjbRIGYkZlcidRqktVJmg3BQ+/lBX1
         Busozsw/I/1LcrGIBdcab+0UQeD9P/DhhEo24wSIC/gcMwOVC9ngS2v3MhNtG5UUBwqR
         bbRFN/aM+toPEtae1TtZHEdzScIjHA6d9PTPjvjkmx0zJ/W8bLHocWa6dXt0K8u3RCpX
         NK5/O2hHimhPBc5JlDTL1Ec25NMW1CBICon5oRCBW1iGkAHAqCJnWmMZxqpj+BkuCNcc
         P4Vbo5sK3Fh8AMcGX7FJ3g7XtJFpfYOOeBRN16+fYxLQtuj9gq7NXGd5nDkG8+JHtgSj
         1b4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCcPklZ/UtwjFxOzQaXV8Mj81sckbZCwb+amAXZO4oShn8faZ7zCi3WCARFziApYz1fbacTvk3CW+K@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4KEjQbCokl3KYGQzO7k4WWzOzEpPb3orVligkV0HubRxHiTNL
	Qgq0ccL+U7+/THby8gcMA8DNNhpxJo7L/SQ9ebtXIB5ZZtMm16UDw4/QoQU5H30=
X-Gm-Gg: ASbGncs6Q1yioJuuq/CEIctWj04Nv8vNE0Lh12pKVUwTYzBrG1RkWwyaXmOwESsRZ8N
	KASYGuAabniowjtGA+H/DIFNBJLy2sea6MG3q19JvX9LA2/OvxVK+SbSFsEbOgDMK114fAvfvcQ
	hNDTx+UBCAoq/lwNEVCrLOYNdBY/4ZSUZV1lZKQSfEFkrEk73eZhGz4LxEHvQCP/1JsR7ZqH0qW
	rDGVOEI7sNoYo6eENH17jatyXjJOAGsjAOu5jeFBLmuEkakeGmTHO7MrAceDaVmYI+wPe6sPNFc
	KH+3iubnJIsWZE/ytEvH8g==
X-Google-Smtp-Source: AGHT+IF7O/ZMCvOOtywTANPL1zwoTq06yXXDMhnBrPgrfov3E/r1DzhOhOYD8wImAojzeP7TdceoFw==
X-Received: by 2002:a05:6a21:3285:b0:1e1:aad7:d50d with SMTP id adf61e73a8af0-1e5e084b681mr22018514637.46.1734947059944;
        Mon, 23 Dec 2024 01:44:19 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:44:19 -0800 (PST)
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
Subject: [PATCH v3 06/17] s390: pgtable: add statistics for PUD and P4D level page table
Date: Mon, 23 Dec 2024 17:40:52 +0800
Message-Id: <35be22a2b1666df729a9fc108c2da5cce266e4be.1734945104.git.zhengqi.arch@bytedance.com>
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

Like PMD and PTE level page table, also add statistics for PUD and P4D
page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/pgalloc.h | 29 +++++++++++++++++++-------
 arch/s390/include/asm/tlb.h     | 37 +++++++++++++++++----------------
 2 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 7b84ef6dc4b6d..a0c1ca5d8423c 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -53,29 +53,42 @@ static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	unsigned long *table = crst_table_alloc(mm);
 
-	if (table)
-		crst_table_init(table, _REGION2_ENTRY_EMPTY);
+	if (!table)
+		return NULL;
+	crst_table_init(table, _REGION2_ENTRY_EMPTY);
+	pagetable_p4d_ctor(virt_to_ptdesc(table));
+
 	return (p4d_t *) table;
 }
 
 static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 {
-	if (!mm_p4d_folded(mm))
-		crst_table_free(mm, (unsigned long *) p4d);
+	if (mm_p4d_folded(mm))
+		return;
+
+	pagetable_p4d_dtor(virt_to_ptdesc(p4d));
+	crst_table_free(mm, (unsigned long *) p4d);
 }
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	unsigned long *table = crst_table_alloc(mm);
-	if (table)
-		crst_table_init(table, _REGION3_ENTRY_EMPTY);
+
+	if (!table)
+		return NULL;
+	crst_table_init(table, _REGION3_ENTRY_EMPTY);
+	pagetable_pud_ctor(virt_to_ptdesc(table));
+
 	return (pud_t *) table;
 }
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 {
-	if (!mm_pud_folded(mm))
-		crst_table_free(mm, (unsigned long *) pud);
+	if (mm_pud_folded(mm))
+		return;
+
+	pagetable_pud_dtor(virt_to_ptdesc(pud));
+	crst_table_free(mm, (unsigned long *) pud);
 }
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index e95b2c8081eb8..b946964afce8e 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -110,24 +110,6 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 	tlb_remove_ptdesc(tlb, pmd);
 }
 
-/*
- * p4d_free_tlb frees a pud table and clears the CRSTE for the
- * region second table entry from the tlb.
- * If the mm uses a four level page table the single p4d is freed
- * as the pgd. p4d_free_tlb checks the asce_limit against 8PB
- * to avoid the double free of the p4d in this case.
- */
-static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
-				unsigned long address)
-{
-	if (mm_p4d_folded(tlb->mm))
-		return;
-	__tlb_adjust_range(tlb, address, PAGE_SIZE);
-	tlb->mm->context.flush_mm = 1;
-	tlb->freed_tables = 1;
-	tlb_remove_ptdesc(tlb, p4d);
-}
-
 /*
  * pud_free_tlb frees a pud table and clears the CRSTE for the
  * region third table entry from the tlb.
@@ -140,11 +122,30 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 {
 	if (mm_pud_folded(tlb->mm))
 		return;
+	pagetable_pud_dtor(virt_to_ptdesc(pud));
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
 	tlb->cleared_p4ds = 1;
 	tlb_remove_ptdesc(tlb, pud);
 }
 
+/*
+ * p4d_free_tlb frees a p4d table and clears the CRSTE for the
+ * region second table entry from the tlb.
+ * If the mm uses a four level page table the single p4d is freed
+ * as the pgd. p4d_free_tlb checks the asce_limit against 8PB
+ * to avoid the double free of the p4d in this case.
+ */
+static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
+				unsigned long address)
+{
+	if (mm_p4d_folded(tlb->mm))
+		return;
+	pagetable_p4d_dtor(virt_to_ptdesc(p4d));
+	__tlb_adjust_range(tlb, address, PAGE_SIZE);
+	tlb->mm->context.flush_mm = 1;
+	tlb->freed_tables = 1;
+	tlb_remove_ptdesc(tlb, p4d);
+}
 
 #endif /* _S390_TLB_H */
-- 
2.20.1

