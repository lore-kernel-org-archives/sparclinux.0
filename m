Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0252219DF98
	for <sparclinux@vger.kernel.org>; Mon, 23 Dec 2024 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947152; cv=none; b=AN++xfdqDTmbnJmC4x7U5S1MgFv5Oee+Sztu4aOyqV5R8dCsZjzrGL0jN4xD8KLRw7LI+91L/O5UNkSU5q4AhZRd/sKw/7RQoStvwoy5DT+u7mK23oC8rFQZ9/G6DEKmcmCds5L1JbMZcNvtBb8i05USgESTc1goXY1AcdEMT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947152; c=relaxed/simple;
	bh=EElIB1gpaaG9REY1IEzvLAKdR3Au6Zf5cYxlQP4u0WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dwX0SkI4cBIYfpngcWvOykeQtUAz/Jgqb82R1M6puxRKJlpYIYJxJgAszrCqRyhqt7PAUQZPb6CwVph2/e40sDYp3or9dgrBJznxlfuq3dCTi+7XWE4/l699cmMUunr6TxiPXkrBYZrp7+5z9/HIU1yeBv2XDNq99V5mJCxdAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RvnFhilM; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RvnFhilM"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725abf74334so3355150b3a.3
        for <sparclinux@vger.kernel.org>; Mon, 23 Dec 2024 01:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947149; x=1735551949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/+0uIvp7xUeTeFwO63TH1y++vtASeDM7X35qnuktEM=;
        b=RvnFhilMwMdm89KRWIGPdeFKH134ayho2vhrK4zga2b2j4N4QodaBfBh2+ytH9OdqS
         jsBrfOMGRRCbnE1C8SwbOfVntYK+8QrlDqpjkuo4iJCmGY9qrIZ/XYvtM38g4PFDSZg4
         UQpx8GmGCZ6WXg4Nyk8cnR4fQtiKS8D1Zacq/RedZMm92E15M0U18Zj4LWSkMY0jsxj1
         RZbSBvInUsoGVvHivopMJK1HW0z4Rtyz1CdG7IVQvlXBSABkLCtEEm5IW2Vdfq+yAnpl
         76lIqGhDUL0QgBY4YOECrQU3aXB3bF4jEBG4Yj1b/b+/JYhWN/7NVW8UeU5NTXrmwo+Y
         5FoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947149; x=1735551949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/+0uIvp7xUeTeFwO63TH1y++vtASeDM7X35qnuktEM=;
        b=tNtq5S9cJefrRW8whWuRHYh4E5XfMu8J1U18MErKGAPjXtbIZrP92jdKJqJRkSZH7U
         9892BsknUCIGUl4vTy8XN0C3d3HlhV5evYXCAxPGr0kHnd8zptgnby0sRyjEbR7Nd+Bj
         mYj+1+7fHL9a9sgj0NhlKoZjXzIo77Fh9k+Z5CsxQaCyAJnxBEPxtbCS8QipReg5CXBl
         u05tQyYqVJGt66SsUh6UuiWuMzDU1Ys2BvNAYcxqWKbRNXW1IQFQNimb7FcQ40RlO44J
         RT01yLSFhHwozJ99RekDObqfJgQvK68wkYcqgfH4e27Vrv2//nlOYZXhul5ilSLDoarp
         g7Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUZp32XneLHfkqZT2Y6V4Sbf0+wuXn1MM4gEMhSs9xcCN3skoT+dLWQkVtDk5POb1juHAYN4x0Pk4zm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx//pP/7zwsG8q3fizUtjgpOFTPrJer4jbvJ8beqDfkcd/Aa7Wd
	qeqFwkfbTAsPa4vWWBr68WDlTM1QNhcPOyyWFIhS8CIPckQWIGgFluVdiAyxsB0=
X-Gm-Gg: ASbGncuxU8TfEs2ZPFoA7KqeC235n5n6p+re5GbekMQFONNukaUl6JqOHubjlNYDFST
	0F8VaYISZxreP3oVD7eWEHjLLdy/qhRtUG7sEcMuuKRPSOmI3AFey5wja211N55S2ekux/HH/IC
	6trl+o1ddGPVrlltL8Ubg9UsCCe8COZP7/HsGcaf1VQLygfFxtB2XyZS7X1/PRO6rSEn8dF4ugD
	dExdOoHqyjyDIODUNGIYdv3pS+3CWpvXdgryAb1Vl65v/NeAMFhCOE6EsY8fp6s90WY+c08PhnE
	m4OkqD2fsCKlReE2IP8UwA==
X-Google-Smtp-Source: AGHT+IHlutX536vagq2BMCvNjirBm1uJlF1dzaH3GgOc0ZHj3lAXm7kK/AuGYqDlsmkXqpl9hOqJ3g==
X-Received: by 2002:a05:6a00:92a4:b0:728:e1f9:b680 with SMTP id d2e1a72fcca58-72abdd7ac89mr17103004b3a.6.1734947149240;
        Mon, 23 Dec 2024 01:45:49 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:45:48 -0800 (PST)
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
Subject: [PATCH v3 13/17] mm: pgtable: introduce generic __tlb_remove_table()
Date: Mon, 23 Dec 2024 17:40:59 +0800
Message-Id: <f7febc7719fd84673a8eae8af71b7b4278d3e110.1734945104.git.zhengqi.arch@bytedance.com>
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

Several architectures (arm, arm64, riscv and x86) define exactly the
same __tlb_remove_table(), just introduce generic __tlb_remove_table() to
eliminate these duplications.

The s390 __tlb_remove_table() is nearly the same, so also make s390
__tlb_remove_table() version generic.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/arm/include/asm/tlb.h      |  9 ---------
 arch/arm64/include/asm/tlb.h    |  7 -------
 arch/powerpc/include/asm/tlb.h  |  1 +
 arch/riscv/include/asm/tlb.h    | 12 ------------
 arch/s390/include/asm/tlb.h     |  9 ++++-----
 arch/s390/mm/pgalloc.c          |  7 -------
 arch/sparc/include/asm/tlb_32.h |  1 +
 arch/sparc/include/asm/tlb_64.h |  1 +
 arch/x86/include/asm/tlb.h      | 17 -----------------
 include/asm-generic/tlb.h       | 15 +++++++++++++--
 10 files changed, 20 insertions(+), 59 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index 264ab635e807a..ea4fbe7b17f6f 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -27,15 +27,6 @@
 #else /* !CONFIG_MMU */
 
 #include <asm/tlbflush.h>
-
-static inline void __tlb_remove_table(void *_table)
-{
-	struct ptdesc *ptdesc = (struct ptdesc *)_table;
-
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
-}
-
 #include <asm-generic/tlb.h>
 
 static inline void
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 93591a80b5bfb..8d762607285cc 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -10,13 +10,6 @@
 
 #include <linux/pagemap.h>
 
-static inline void __tlb_remove_table(void *_table)
-{
-	struct ptdesc *ptdesc = (struct ptdesc *)_table;
-
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
-}
 
 #define tlb_flush tlb_flush
 static void tlb_flush(struct mmu_gather *tlb);
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index 1ca7d4c4b90db..2058e8d3e0138 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -37,6 +37,7 @@ extern void tlb_flush(struct mmu_gather *tlb);
  */
 #define tlb_needs_table_invalidate()	radix_enabled()
 
+#define __HAVE_ARCH_TLB_REMOVE_TABLE
 /* Get the generic bits... */
 #include <asm-generic/tlb.h>
 
diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
index ded8724b3c4f7..50b63b5c15bd8 100644
--- a/arch/riscv/include/asm/tlb.h
+++ b/arch/riscv/include/asm/tlb.h
@@ -10,18 +10,6 @@ struct mmu_gather;
 
 static void tlb_flush(struct mmu_gather *tlb);
 
-#ifdef CONFIG_MMU
-
-static inline void __tlb_remove_table(void *table)
-{
-	struct ptdesc *ptdesc = (struct ptdesc *)table;
-
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
-}
-
-#endif /* CONFIG_MMU */
-
 #define tlb_flush tlb_flush
 #include <asm-generic/tlb.h>
 
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 79df7c0932c56..da4a7d175f69c 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -22,7 +22,6 @@
  * Pages used for the page tables is a different story. FIXME: more
  */
 
-void __tlb_remove_table(void *_table);
 static inline void tlb_flush(struct mmu_gather *tlb);
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
 		struct page *page, bool delay_rmap, int page_size);
@@ -87,7 +86,7 @@ static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 	tlb->cleared_pmds = 1;
 	if (mm_alloc_pgste(tlb->mm))
 		gmap_unlink(tlb->mm, (unsigned long *)pte, address);
-	tlb_remove_ptdesc(tlb, pte);
+	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pte));
 }
 
 /*
@@ -106,7 +105,7 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
 	tlb->cleared_puds = 1;
-	tlb_remove_ptdesc(tlb, pmd);
+	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pmd));
 }
 
 /*
@@ -124,7 +123,7 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
 	tlb->cleared_p4ds = 1;
-	tlb_remove_ptdesc(tlb, pud);
+	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pud));
 }
 
 /*
@@ -142,7 +141,7 @@ static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 	__tlb_adjust_range(tlb, address, PAGE_SIZE);
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
-	tlb_remove_ptdesc(tlb, p4d);
+	tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
 }
 
 #endif /* _S390_TLB_H */
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index c73b89811a264..3e002dea6278f 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -193,13 +193,6 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 	pagetable_dtor_free(ptdesc);
 }
 
-void __tlb_remove_table(void *table)
-{
-	struct ptdesc *ptdesc = virt_to_ptdesc(table);
-
-	pagetable_dtor_free(ptdesc);
-}
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void pte_free_now(struct rcu_head *head)
 {
diff --git a/arch/sparc/include/asm/tlb_32.h b/arch/sparc/include/asm/tlb_32.h
index 5cd28a8793e39..910254867dfbd 100644
--- a/arch/sparc/include/asm/tlb_32.h
+++ b/arch/sparc/include/asm/tlb_32.h
@@ -2,6 +2,7 @@
 #ifndef _SPARC_TLB_H
 #define _SPARC_TLB_H
 
+#define __HAVE_ARCH_TLB_REMOVE_TABLE
 #include <asm-generic/tlb.h>
 
 #endif /* _SPARC_TLB_H */
diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
index 3037187482db7..1a6e694418e39 100644
--- a/arch/sparc/include/asm/tlb_64.h
+++ b/arch/sparc/include/asm/tlb_64.h
@@ -33,6 +33,7 @@ void flush_tlb_pending(void);
 #define tlb_needs_table_invalidate()	(false)
 #endif
 
+#define __HAVE_ARCH_TLB_REMOVE_TABLE
 #include <asm-generic/tlb.h>
 
 #endif /* _SPARC64_TLB_H */
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index f64730be5ad67..3858dbf75880e 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -20,23 +20,6 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
 }
 
-/*
- * While x86 architecture in general requires an IPI to perform TLB
- * shootdown, enablement code for several hypervisors overrides
- * .flush_tlb_others hook in pv_mmu_ops and implements it by issuing
- * a hypercall. To keep software pagetable walkers safe in this case we
- * switch to RCU based table free (MMU_GATHER_RCU_TABLE_FREE). See the comment
- * below 'ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE' in include/asm-generic/tlb.h
- * for more details.
- */
-static inline void __tlb_remove_table(void *table)
-{
-	struct ptdesc *ptdesc = (struct ptdesc *)table;
-
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
-}
-
 #ifdef CONFIG_PT_RECLAIM
 static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
 {
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 709830274b756..69de47c7ef3c5 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -153,8 +153,9 @@
  *
  *  Useful if your architecture has non-page page directories.
  *
- *  When used, an architecture is expected to provide __tlb_remove_table()
- *  which does the actual freeing of these pages.
+ *  When used, an architecture is expected to provide __tlb_remove_table() or
+ *  use the generic __tlb_remove_table(), which does the actual freeing of these
+ *  pages.
  *
  *  MMU_GATHER_RCU_TABLE_FREE
  *
@@ -207,6 +208,16 @@ struct mmu_table_batch {
 #define MAX_TABLE_BATCH		\
 	((PAGE_SIZE - sizeof(struct mmu_table_batch)) / sizeof(void *))
 
+#ifndef __HAVE_ARCH_TLB_REMOVE_TABLE
+static inline void __tlb_remove_table(void *table)
+{
+	struct ptdesc *ptdesc = (struct ptdesc *)table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
+}
+#endif
+
 extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
 
 #else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
-- 
2.20.1

