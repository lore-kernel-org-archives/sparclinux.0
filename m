Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF1D1A23A6
	for <sparclinux@vger.kernel.org>; Mon, 30 Dec 2024 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549761; cv=none; b=Dn6Js+hFZn06aJiOznVPMusm3j7MqPhMJ0jn5DmXqooRTUaBO/e7iqaR2BhymhtUkZ59ffBMcIxl+MxJlRF257vynTgzKJyKLqC/9ahh1p8KRLuz1LCIwDUuoK+mwBkCGzsBJyUgXxhJ5PgOjVm2ORwJL1J6b0xa4GZhgisLQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549761; c=relaxed/simple;
	bh=VQrwZRR3rAwbwOGD5AjoKk2Z15695i3scVkWYvbG/zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=df5PXOWirdLF5Ky1y5D3XjKIvuQJfaKIUpmgD8//nDsnC8OeWTvnFd06nGLWAADU93DRTKHiN1/xE3qSJtdomi0hJ8IHDVooBeOQFrWHVRlNfCgbX3FjBrZEQkCjamxI8ZpAyC45LRuM+qWipA34bsxprfSGkewHcbwv3ygNCEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=W1EIz8Sw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="W1EIz8Sw"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21670dce0a7so17224385ad.1
        for <sparclinux@vger.kernel.org>; Mon, 30 Dec 2024 01:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549758; x=1736154558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi4+N7L/R07Fq6g8WRpMxop4cD3t01a1BHl7awbkQjI=;
        b=W1EIz8SwrFGzIPvVSTgGDInoWHqdgxJVSp7apqZTLAW2HlHtEDtnjUqJvIlQo4bzVk
         /syWMiQA39pCZO0/DoZFOC7QUkscXEDiaF3ebSv+siTPp6PVBqsSrpR2+wXCyVoMPkdI
         EkbBfs9Thjr9x3yll1cZ/P0uQDt+pE/zbhF90dwCdHI5uhVQ/nLfJIK/7sAyKOSqxiuV
         pAHk/GdRvVhYljIzy0buCAImw0PnA2xuaKNQZQhkkPTODHZcWLIfV4Pm52THd3LRcpoj
         82dMp3Up3sE/+SaD6UMBzza195ZuehCMECQGAZP2IOmSDzlirqTw6dNJtJhuS6VJswbZ
         yv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549758; x=1736154558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hi4+N7L/R07Fq6g8WRpMxop4cD3t01a1BHl7awbkQjI=;
        b=XZzBVkv0+pg4TV+2aN3dyk5lp6ggh9BezRBBwKcx/GDYWxfaAXeaOAWg3cW+lKsxdO
         VH/xIfk51njD/cdbQlH5SVuHV2KXfu4ZiPnzwCFHb7QrucEmQMRgMfQteaqUkPt0pN3s
         +OhLK6jrJJT/KGZ3lHY+/88m1g0ZyHgZfQWv9h/1I2POr59HR6x/41fUKUKmFMD9sMSP
         1Fnp0/6CT4cv+IzWUbrT9/ZdD4UDywZ524KKxvyM5YEXg3WMEY8V5A5S7nChlQztBbqV
         lKAs3qmwkGxjrbyXLyFZLleAWCZKyI0SvIeh7r771LvWzDvH8vU5p3/+MPJuDxepmemk
         XeOw==
X-Forwarded-Encrypted: i=1; AJvYcCU/5vUe+Dlt6AmW0EktTBordD6/O1tyRygIGa+iHcnagO46iVUV18MrnRYZs2jIdUt8BRBm39szPmWy@vger.kernel.org
X-Gm-Message-State: AOJu0Yys2QY9X+KDVx8w7BjFBUS6hbwqwzuyNWQLedzRWeoQeO/6yin8
	SGUBQXDDruUZjBtEPmJV9OnPpg51nGPltdbcbS8fdkJawh1EGbIblIHEw5rgKiI=
X-Gm-Gg: ASbGncsjYgJKYkzIxoO7UusZI5T/sa5GumzlrQrE7u6O2//65xyHZlsYyIGhEMabqJk
	JINiPDYYrGeOPUVQv8UD9oMl1X9UNFq6595OYiZVTA8ItGiRSC8p5KohVxOG9dV7zgZX4PorEWp
	IcT9W/k1rvMlhzkc4jODtAFpL4dpAv6Oswp5iRNpP+PvIQKULXXBTGGPEh5ggiyOdEwRcEgkD7P
	2bs5+qEIPOFJAIrBkVKAkAxh3bCA+avJDyzjmX88T2wf/22NPdOzJjwis5JDJvJv4k3GkRWY4PS
	Mupv8vDpk5YvkJ1cBAFpCA==
X-Google-Smtp-Source: AGHT+IHmMXvIfmrfsWwSSN68U3q7TJmVN0XL9C78+ztBjPSSvkZSld2lKuaEpxPQ8tk0dZT2wkXZcA==
X-Received: by 2002:a17:902:d488:b0:212:4ac2:4919 with SMTP id d9443c01a7336-219e6e9f9aemr366243385ad.17.1735549758001;
        Mon, 30 Dec 2024 01:09:18 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:09:17 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
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
Subject: [PATCH v4 03/15] asm-generic: pgalloc: Provide generic p4d_{alloc_one,free}
Date: Mon, 30 Dec 2024 17:07:38 +0800
Message-Id: <4c4bcc1aa565c6252183553aecd5e5cbd1a0f6ea.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Brodsky <kevin.brodsky@arm.com>

Four architectures currently implement 5-level pgtables: arm64,
riscv, x86 and s390. The first three have essentially the same
implementation for p4d_alloc_one() and p4d_free(), so we've got an
opportunity to reduce duplication like at the lower levels.

Provide a generic version of p4d_alloc_one() and p4d_free(), and
make use of it on those architectures.

Their implementation is the same as at PUD level, except that
p4d_free() performs a runtime check by calling mm_p4d_folded().
5-level pgtables depend on a runtime-detected hardware feature on
all supported architectures, so we might as well include this check
in the generic implementation. No runtime check is required in
p4d_alloc_one() as the top-level p4d_alloc() already does the
required check.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/arm64/include/asm/pgalloc.h | 17 ------------
 arch/riscv/include/asm/pgalloc.h | 23 ----------------
 arch/x86/include/asm/pgalloc.h   | 18 -------------
 include/asm-generic/pgalloc.h    | 45 ++++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 58 deletions(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index e75422864d1bd..2965f5a7e39e3 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -85,23 +85,6 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, p4d_t *p4dp)
 	__pgd_populate(pgdp, __pa(p4dp), pgdval);
 }
 
-static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	gfp_t gfp = GFP_PGTABLE_USER;
-
-	if (mm == &init_mm)
-		gfp = GFP_PGTABLE_KERNEL;
-	return (p4d_t *)get_zeroed_page(gfp);
-}
-
-static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
-{
-	if (!pgtable_l5_enabled())
-		return;
-	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
-	free_page((unsigned long)p4d);
-}
-
 #define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
 #else
 static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t p4dp, pgdval_t prot)
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 8ad0bbe838a24..551d614d3369c 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -105,29 +105,6 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 	}
 }
 
-#define p4d_alloc_one p4d_alloc_one
-static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	gfp_t gfp = GFP_PGTABLE_USER;
-
-	if (mm == &init_mm)
-		gfp = GFP_PGTABLE_KERNEL;
-	return (p4d_t *)get_zeroed_page(gfp);
-}
-
-static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
-{
-	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
-	free_page((unsigned long)p4d);
-}
-
-#define p4d_free p4d_free
-static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
-{
-	if (pgtable_l5_enabled)
-		__p4d_free(mm, p4d);
-}
-
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				  unsigned long addr)
 {
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index dcd836b59bebd..dd4841231bb9f 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -147,24 +147,6 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4
 	set_pgd_safe(pgd, __pgd(_PAGE_TABLE | __pa(p4d)));
 }
 
-static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	gfp_t gfp = GFP_KERNEL_ACCOUNT;
-
-	if (mm == &init_mm)
-		gfp &= ~__GFP_ACCOUNT;
-	return (p4d_t *)get_zeroed_page(gfp);
-}
-
-static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
-{
-	if (!pgtable_l5_enabled())
-		return;
-
-	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
-	free_page((unsigned long)p4d);
-}
-
 extern void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d);
 
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 7c48f5fbf8aa7..59131629ac9cc 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -215,6 +215,51 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 
 #endif /* CONFIG_PGTABLE_LEVELS > 3 */
 
+#if CONFIG_PGTABLE_LEVELS > 4
+
+static inline p4d_t *__p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long addr)
+{
+	gfp_t gfp = GFP_PGTABLE_USER;
+	struct ptdesc *ptdesc;
+
+	if (mm == &init_mm)
+		gfp = GFP_PGTABLE_KERNEL;
+	gfp &= ~__GFP_HIGHMEM;
+
+	ptdesc = pagetable_alloc_noprof(gfp, 0);
+	if (!ptdesc)
+		return NULL;
+
+	return ptdesc_address(ptdesc);
+}
+#define __p4d_alloc_one(...)	alloc_hooks(__p4d_alloc_one_noprof(__VA_ARGS__))
+
+#ifndef __HAVE_ARCH_P4D_ALLOC_ONE
+static inline p4d_t *p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long addr)
+{
+	return __p4d_alloc_one_noprof(mm, addr);
+}
+#define p4d_alloc_one(...)	alloc_hooks(p4d_alloc_one_noprof(__VA_ARGS__))
+#endif
+
+static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
+{
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
+
+	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
+	pagetable_free(ptdesc);
+}
+
+#ifndef __HAVE_ARCH_P4D_FREE
+static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
+{
+	if (!mm_p4d_folded(mm))
+		__p4d_free(mm, p4d);
+}
+#endif
+
+#endif /* CONFIG_PGTABLE_LEVELS > 4 */
+
 #ifndef __HAVE_ARCH_PGD_FREE
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-- 
2.20.1

