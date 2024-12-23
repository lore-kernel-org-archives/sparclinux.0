Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC31B195381
	for <sparclinux@vger.kernel.org>; Mon, 23 Dec 2024 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947012; cv=none; b=TuOvLr4B9e7xJSEV0p0n23a6qXJg51NqZclXNJe/iAw7GmkmYMpfWgNGjAkgpltYIKVG99GLt3xHb4gXiVhh7BW+NjKM28GHg47BFs2f6pl2/u2Cq/jXs4V0Jk/NuuJ0i+rE9dWAbc2KyZKAUUaLHC8MQmSFpEzmtcLlIGx9u4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947012; c=relaxed/simple;
	bh=ju5DuzkKGwFmMyIwrlT1Lgl5SSQbM6pKt1IYE0Qmp1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tT+uEHEbt1AYmS8aOKREh77GF2rjxU0UFRcFby8Ycws9srpfaXlE3JhGJ0X6nPo0a+IFAF6eOXH9EQLKM7uK4ijE8BMXIaD6EhcA7q8tee1Tq9wWiGXUH0mf+/N9OytQ4rIoYrRSsIXIgASr00oPDwPUqVSoRotBvPr9Z3sNDHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ikFqkr6B; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ikFqkr6B"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-725f4623df7so3743655b3a.2
        for <sparclinux@vger.kernel.org>; Mon, 23 Dec 2024 01:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947009; x=1735551809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/tJ15+vmer/NbqXoUznjybhQp/MgC6GOdT/GuQUXpM=;
        b=ikFqkr6B0/3PS1wO+3Ey7F7j57aIAc5gjLbqDwTohFJrbACx++AluUPiHxN9uHBSQC
         IVPuuF6KnKEYEiKr/yQHxcdloQB5DmS29AvyvLbqeNU3NHLyX3a9I+gZbR15sRRD11He
         3WwSXngasVjY/nlqAjPJjwQfmR0c2XGTXEKlcXALQ5kf8ED99PA2Ayoi/O3MhrlmfPNn
         3D8gWkdGG66Ol9dqQ0sbt4gH8vLMHxGLBKAh+ZQlp5ldZC91qPk058gI+7dKBfDn/WE0
         E73kQOlr4lyiks0g4/4kKzB3pYIYnBkZGpw6tt/3pr2uNYDQk51eeBQEn8dRlp1a5OqM
         YufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947009; x=1735551809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/tJ15+vmer/NbqXoUznjybhQp/MgC6GOdT/GuQUXpM=;
        b=KfjIzilLG14tQrINd/ZxGlSPoYIeGE+gRP2eAWbopP0VBN//SlkuYsJi5qcOCuT5RI
         djlahsIvma/wWoAUDlawuZka+Tm/ViB41NoIPtbnMRqvRJ5T6+VeM+sIuys2LHzXvij1
         PcTv9leqqTFojki3Q34ajyrw9dUXip3l8Vpnfi29TgJazO8UFBDclW7VVbXSvhK7J2at
         WppR0h4ddFeZZ6DTd/tXYyli2oVt5aj0JTlnD1SnD6St/4xZqL8uosAITBdGka/QF9vi
         61xFIdeBQLXTny+Jm6HppfczMp3tjMbRbvO0EWtAbt6yJpfPldHWCxEMXnYtyNR1tqy6
         a9Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUkEIyQDt5iBCTqy4b9wEHA3jQXagjznkgAPY+wyOFvHrYjvtvlzYdk3mpj6q/pXKardAYj33I4PdYi@vger.kernel.org
X-Gm-Message-State: AOJu0YyVhKb9CMkERJbBhzXH0ONLw/rnFTxhoZREZj2XZ3I95Bf/Y5Lr
	/2qBxIXQgXNCHQWbQ5/p/3DvaaEo/HevCtu1H1w11VG4k1DfxQBnwqHpoSkoWSo=
X-Gm-Gg: ASbGncsbROBdydxDR+0XF+eX66dLca3WKjDCpFuW7yaLDfgZ2M0Q9mp8ZftzHbUx1ZT
	2wxxg9woOP0A6kB8jcYQco/PPuJD/Nsc2ziHrthjmyY/19dGzqqzbCSyVvkPAS5DYx8+tkxxkR5
	EVclMiE1QTMx+eup2+2QJGCkzdwuBzqGgD0MfOtB98WwEu+dzwqpxP8JGfk3WowHpvXbjOXj3kA
	x259rZZL7/ph1TX842iekSEg7aBWWm7FldmWJnKBsCRKbrANnjgrn8e0v8jsZzgR2lnWyWdXYkv
	Vkzntxi+PoKlaCga76CQSQ==
X-Google-Smtp-Source: AGHT+IGn0WgNlH4n6jFU+xV15Lu8l6dnMV2FFWuW4zvXTMVJTCCaTT+ZxewqFKpQcJgKvmYU0RJrVw==
X-Received: by 2002:a05:6a00:35ca:b0:724:f86e:e3d9 with SMTP id d2e1a72fcca58-72abdecbdb4mr16058641b3a.14.1734947008718;
        Mon, 23 Dec 2024 01:43:28 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:43:28 -0800 (PST)
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
Subject: [PATCH v3 02/17] riscv: mm: Skip pgtable level check in {pud,p4d}_alloc_one
Date: Mon, 23 Dec 2024 17:40:48 +0800
Message-Id: <84ddf857508b98a195a790bc6ff6ab8849b44633.1734945104.git.zhengqi.arch@bytedance.com>
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

From: Kevin Brodsky <kevin.brodsky@arm.com>

{pmd,pud,p4d}_alloc_one() is never called if the corresponding page
table level is folded, as {pmd,pud,p4d}_alloc() already does the
required check. We can therefore remove the runtime page table level
checks in {pud,p4d}_alloc_one. The PUD helper becomes equivalent to
the generic version, so we remove it altogether.

This is consistent with the way arm64 and x86 handle this situation
(runtime check in p4d_free() only).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/riscv/include/asm/pgalloc.h | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index f52264304f772..8ad0bbe838a24 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -12,7 +12,6 @@
 #include <asm/tlb.h>
 
 #ifdef CONFIG_MMU
-#define __HAVE_ARCH_PUD_ALLOC_ONE
 #define __HAVE_ARCH_PUD_FREE
 #include <asm-generic/pgalloc.h>
 
@@ -88,15 +87,6 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd,
 	}
 }
 
-#define pud_alloc_one pud_alloc_one
-static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	if (pgtable_l4_enabled)
-		return __pud_alloc_one(mm, addr);
-
-	return NULL;
-}
-
 #define pud_free pud_free
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 {
@@ -118,15 +108,11 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 #define p4d_alloc_one p4d_alloc_one
 static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	if (pgtable_l5_enabled) {
-		gfp_t gfp = GFP_PGTABLE_USER;
-
-		if (mm == &init_mm)
-			gfp = GFP_PGTABLE_KERNEL;
-		return (p4d_t *)get_zeroed_page(gfp);
-	}
+	gfp_t gfp = GFP_PGTABLE_USER;
 
-	return NULL;
+	if (mm == &init_mm)
+		gfp = GFP_PGTABLE_KERNEL;
+	return (p4d_t *)get_zeroed_page(gfp);
 }
 
 static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
-- 
2.20.1

