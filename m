Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493041A8417
	for <sparclinux@vger.kernel.org>; Wed,  8 Jan 2025 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319652; cv=none; b=KUBacz+eOevqAZk5zULIyAFgXk6mvjOo2J7H/wQh2Ipbf/b3tbmsCfMICPKe2xj+ZeCrOMM6nnGntXg6fIQpYBZYQGtl9w85WLEoi/nRX8RpLbJBHJdnO5YNNXIh3u2TmgSP+I0uVjz+YVQghyz+G+dYavTH1qw4m/WNDFvtkSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319652; c=relaxed/simple;
	bh=aGqvHL2vBr0F32b5nn3s88qKn1CLr8WeccygZVRBAEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AFTJKOZHWJIb+mdzdheSZ4WgJtDlEY1AmdnKpj/L3aatjJanr4ETijmfXMDJBMA1CACfV+bgv5ZbxOi1l2HhWDjTA7N9+ha+4tPSDS8mmYDOb0rkRIlxgNVXBn4jTqbT92nSFPek00WEBaSPO0sfAR7tP6LifvrYihybwQR2Dto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=R1wYrQBv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R1wYrQBv"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21619108a6bso226852145ad.3
        for <sparclinux@vger.kernel.org>; Tue, 07 Jan 2025 23:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319650; x=1736924450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evJHXxUH8wpRsLAfhvt7S2AIimf3Ggw2vmlVHfN1TNM=;
        b=R1wYrQBvekglq61bdhkezbMUyzBomFK02UdYR3kFqRnxl/ukKmfQF9ATptRIOvqpeF
         9Vz9wk1St+iBjzEkYfMiMTuBqylqgHpzKXP2eLtyC9QzQQDr99+l3Hxx0wNtpd1HkncN
         PbJ3uFm44HoZZl9h/IBko4TGSwZicRkhowjkSA4Qlc0RX/gX+7YeXTzCM7V7pfFBMlv4
         J+wkM/ri2+s7Wklf1T32NKvdukAsl1n02xAkd/D+ST/Xh0uOjERNXbW5WVR5eu+8sRU9
         8jYYfXAGwkfqIpAs/o8/O0p0ybRVYFIYjrVx4jhSJzzIpwbx9Vjn8A3IRUBBQTY3OPkB
         bVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319650; x=1736924450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evJHXxUH8wpRsLAfhvt7S2AIimf3Ggw2vmlVHfN1TNM=;
        b=IOpCFIGs1yEboPD9nAx1GQermDc7f77rfwzykT/EyCWrHoC1XRxMmB+3KJclhtpPYf
         QNtCDUS9ZveZmOZuNjsUi++C0tLL3epSAO78S/kTSrCe92UsH5KxeZtM8RaAA2Jsx32L
         hgq7GHzDJapW/gymUD7njAGVFEuFqRr21YR3cvyD08M2CtxmNeogpKO1omV0zntsHrqv
         hc6P58dUzgkNjkUUAa+DZl+1p5+Vnqg0W2+UBRxD2K2F7xoodPiy0PMyAyf6ufZkZnCY
         LS5AcIBVMdPWK5GyMWrkVxDEgQXoaTfmw/qDNbMsQEpCt6/WgG2Lf5rjpM1cgGnpjDhU
         9mlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/JZPhD4Sx017vcUsu8QtRCLXdXwWLKhMX3q7NHIJpbfiw7Z14W+CFxBTGqbD9SkA37DJWYCGyBqTW@vger.kernel.org
X-Gm-Message-State: AOJu0YyE2jeYrTbxC5rQ7grgVpRPX1/fckB/PODFFADY29/SUfSQ6eje
	0hwBVlGtCC+A9HuBHsKnRAmkEKl9r5CdXwDWmgXmYXQnJ8rkm75TIcOni+7Dns4=
X-Gm-Gg: ASbGnctvKHHBB05MFinhAxXBfnhQWOiZ/ILU+mqIHbej2kdXxIJ+RtGG+3YBlRYI9AM
	N7thLN0WFIIJIrJpu6BAYgBh/tq9E1gD7MprCSfBRkmUuI9TcLFgdslWgjn8PwL6vnh8IK4fumP
	kqDML66y2KI/mCOLFjSoOmVeLMufQVIPTfPxFmTx0X0s/oI5kLG/W/8m4kcKd02eamYM9nXXJHX
	BcRMYGW7azjhsYyP5gSmepczFKwnG2SJJPxL6/eGiMYWUbPz+qGhaTUitHobTA/urzT9A/WbEX6
	1Rual7ebhVHqqCpnwf6A6XQ3yUI=
X-Google-Smtp-Source: AGHT+IF9X6lXCsguwyHO5KdCHubvdTIDd4Y888fAuDMWr6lGszjnzuDzetJYvdD8sXl2Z0Y5NvXbNg==
X-Received: by 2002:a17:902:cec3:b0:216:7ee9:220b with SMTP id d9443c01a7336-21a83f4f43amr30110425ad.22.1736319649715;
        Tue, 07 Jan 2025 23:00:49 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:00:49 -0800 (PST)
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
Subject: [PATCH v5 06/17] s390: pgtable: add statistics for PUD and P4D level page table
Date: Wed,  8 Jan 2025 14:57:22 +0800
Message-Id: <4707dffce228ccec5c6662810566dd12b5741c4b.1736317725.git.zhengqi.arch@bytedance.com>
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

Like PMD and PTE level page table, also add statistics for PUD and P4D
page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/pgalloc.h | 29 +++++++++++++++++++++--------
 arch/s390/include/asm/tlb.h     |  2 ++
 2 files changed, 23 insertions(+), 8 deletions(-)

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
index e95b2c8081eb8..907d57a68145c 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -122,6 +122,7 @@ static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 {
 	if (mm_p4d_folded(tlb->mm))
 		return;
+	pagetable_p4d_dtor(virt_to_ptdesc(p4d));
 	__tlb_adjust_range(tlb, address, PAGE_SIZE);
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
@@ -140,6 +141,7 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 {
 	if (mm_pud_folded(tlb->mm))
 		return;
+	pagetable_pud_dtor(virt_to_ptdesc(pud));
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
 	tlb->cleared_p4ds = 1;
-- 
2.20.1

