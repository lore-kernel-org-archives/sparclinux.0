Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349500;
	b=vJeI4ubPWOVwyTT8rrX3W3zeye2/+unWCF7m270+bcGFCu/UReh7qTJwmVl9fPsO6GB1
	 VF9LzD7igO0Wb08VtofydEu/at7VmWQC/ESMw+M67KFZHRk8CwQkP0yALxp1CWXcYTXyR
	 XZFQwswSSwLXT28Zh26LGTcikh3PXgx/OWvN8eAXxomhdtR1KKUiO+InTogeT38ZzRtPZ
	 XmlKX3h2c0VzzFRfF1T89cpmQYmnEhWJ1CO4DYQc05J0A2gLSkPR0yQn2zzSsvJNQO10s
	 JWvgSJJ2nBUovTDnq4vB5pL1OImS5UmJwvfI+9k+iCHZv8+yBgbc3bHDekRYEDYF7Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CB+bZxSYAyiQD1sxDhADYYDlxsNLMIf5jThUADM0poI=;
	b=qz9TKxj43f8i2qdkrwZ9qsz8ALOr/fXWK3Vllv47FVMrJS2oYdQM/vvMKGjUkq4iXPY4
	 FgYMRRZYqANUa2LWiIx/DVWhIUuHmNJfe5kR+4TkeNhp7pyWRKuBGH3B42Yu3QG5wFWRR
	 /J5TYTuXJp8ahZpW2zYgmtcBkWo0FVxEGvpS9Ik+oeoA78A4UbwFkIod/jqCM4EffUnyt
	 vnMcbtxQX5jNrQPLDo5/jU395HcxItSrVkB6KjU1KKBTlE4LmcyUc1ewl3wE8WY8B2qGY
	 NhUBQqeSjqjE/fxz/Te7GyCqg/q7hh2BKWGkxl2eDJV1gFLVfTmH0rcf4qbgclRvIcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=RnUcjXvj;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9947606A331
	for <sparclinux@vger.kernel.org>; Fri, 30 Oct 2026 08:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9947606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=RnUcjXvj
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so259665a91.1
        for <sparclinux@vger.kernel.org>; Fri, 30 Oct 2026 01:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793349499; x=1793954299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CB+bZxSYAyiQD1sxDhADYYDlxsNLMIf5jThUADM0poI=;
        b=RnUcjXvjix8p2uWimqZKYUZ59woszJ6Ic6+lL95p0LDI7cyTfjT9WI+ZR8xUoJk0sR
         EBWQHSdd3lqxV5rA9EruGVHANC7GxIOLJBjNS/vsU77Zy5dRkxXMGqjA/a+BDggSHaqZ
         nsBTL6DXsd8QBUG2wSnbhz63OgPvI2Q74vODrbR97EYjuiULx6zI+9ZjDgm7N7Tte3qx
         8eVByoRJdj7jhyabKfjnf9rSj5uE8zfkvCuLTl0RsgDhqvDMXILjltylkUKbPnIU7uL1
         Rm99UyUIIT2Xz6SGiwpXETAtOu6xUF3Ko7iYIWctcORmqv5nFvAu7YDEuPmUG0RH2AHC
         As3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793349499; x=1793954299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CB+bZxSYAyiQD1sxDhADYYDlxsNLMIf5jThUADM0poI=;
        b=2nBE5O6S0xVdjkC+rKPhLgKhw8GyTbB8pFEqtFpEuS6dr5iUq7XPobACXrUZh8KVOg
         yj/zdAuHptQVGd9k/WDOA1IrZXwLVMMsAJ6IZwRPp9a2RaAS4TQFaqPQ7AOCf/xVjuru
         PMaimuTm7EOiDO0leJlEfSvu96QcsryPcgSsKva3Tp3/wfvIwLqKJ/qcRuQh6O8z9VPS
         xJKn8mqk2glYR9EcM8Ov+0wy9atq69pNWY/h3UBVuGLIrhdStPLWgmM7Uf7pt+EC27Px
         oUInB7j9+DM9NzXD3E05/qlfg/cGbUP53Fzle4Qb1AXMMqG4/7Q+13U+2m+nKLY9k/uQ
         RV7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxTCfqCo8BpkodjUOv5Nt1mkcraJ6hhaz7lwlzhOthUj7x7nskYrBQua6tKU0vUzvMu/8Vdu5fgDrnB@vger.kernel.org
X-Gm-Message-State: AFq9FYLXXYM7sB/7Y+kEfaHO4eGbdk6RKYUEk07PxH6wfOs6Posigyb1
	gixiUHHnehQo52RgYt7mikbTEX9aya8qm+1wqLauwOZVA3bXXmWchSudEIBZm68w18g=
X-Gm-Gg: AYBFou2DrSbU3dzPvXDC7O9Ah0Iq3aqEZKMw8eFq2xKFNs1UWetpF8a0zN2FqF0SvFQ
	k2wh42ytdOGNvBQqKiwEyyHuE89g4f/z8OsBjM0WEi8HKrGDpnRttEWhXziiIyUaaWsIwuQbbX4
	w43By01sZHUvA6fab3MBWndTOKQxBMGB+VZf0e3pxXna+SVj0EjVfW6upEo2KyRNhXdHiqkzjGK
	g56polfzRRzhUDkLWS1QTVZA5vQfqg67pMRFQPsl5+CfTQSvJxaiZexQuRSLfDtgCqtIvso+sN3
	oSHnnbeINabFr1h0ZvJcXGsR80fJWtqjGj9mIPR2OBEHXlq4ts1kFItlQIsPPOkSZG4GB1GQYH3
	6gWpr0Uz/yOf1pDhLdXRaL2tLeKzrisbYw5pCl37Vke5AOtd5PSi5C2N4zDRSt+3UVWbpK/G33N
	GqUQkm5X1ZKFo65urBeMH+IgLRyDF8HLni+JTIOATEGPZ4HRHgVoQjPkeffpUvLv/NO3nl+zUqA
	UtYjxkMHZJLzAj3K7fxp72iSfl3YYTT66/XlFdCyGhMAO46ktMkPM/bjmwRZtVV9Rcmy2JDCPCm
	yAVZAIeuK9bzVd5ohuNJUSjPEMyBHplIg1QXBGK2wRyuHyOdZE/d
X-Received: by 2002:a17:90b:1d05:b0:3ac:b08a:ed2c with SMTP id 98e67ed59e1d1-3ae898166a4mr1176591a91.40.1793349498929;
        Fri, 30 Oct 2026 01:38:18 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9b1506sm7542122a91.15.2026.10.30.01.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 01:38:18 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Alistair Popple <apopple@nvidia.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH 1/2] mm: remove pagetable_dtor_free()
Date: Fri, 30 Oct 2026 16:37:59 +0800
Message-ID: <20261030083800.599152-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030083800.599152-1-songmuchun@bytedance.com>
References: <20261030083800.599152-1-songmuchun@bytedance.com>
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

pagetable_free() now runs pagetable_dtor() for pages that have gone
through a page-table constructor, so pagetable_dtor_free() no longer
provides distinct behavior.

Use pagetable_free() directly at the remaining call sites and remove
the redundant helper. This keeps the decision to run the destructor in
the common free path.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/m68k/include/asm/mcf_pgalloc.h |  4 ++--
 arch/m68k/mm/motorola.c             |  2 +-
 arch/s390/mm/pgalloc.c              |  4 ++--
 arch/sh/mm/pgtable.c                |  2 +-
 arch/x86/mm/pat/set_memory.c        | 10 +---------
 arch/x86/mm/pgtable.c               |  4 ++--
 include/asm-generic/pgalloc.h       | 12 ++++++------
 include/asm-generic/tlb.h           |  2 +-
 include/linux/mm.h                  |  6 ------
 9 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index b53ff0950db2..27c3b91ac0b8 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -7,7 +7,7 @@
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	pagetable_dtor_free(virt_to_ptdesc(pte));
+	pagetable_free(virt_to_ptdesc(pte));
 }
 
 extern const char bad_pmd_string[];
@@ -74,7 +74,7 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	pagetable_dtor_free(virt_to_ptdesc(pgd));
+	pagetable_free(virt_to_ptdesc(pgd));
 }
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index f3efa0d13963..d4ad3ccb13b6 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -237,7 +237,7 @@ int free_pointer_table(void *table, int type)
 		spin_unlock_bh(&ptable_lock);
 
 		mmu_page_dtor((void *)pt_addr);
-		pagetable_dtor_free(virt_to_ptdesc((void *)pt_addr));
+		pagetable_free(virt_to_ptdesc((void *)pt_addr));
 		return 1;
 	} else if (ptable_list[type].next != dp) {
 		/*
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 4b160eedc5a0..1b7061498adc 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -125,7 +125,7 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 
 	if (pagetable_is_reserved(ptdesc))
 		return free_reserved_ptdesc(ptdesc);
-	pagetable_dtor_free(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -133,7 +133,7 @@ static void pte_free_now(struct rcu_head *head)
 {
 	struct ptdesc *ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
 
-	pagetable_dtor_free(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
diff --git a/arch/sh/mm/pgtable.c b/arch/sh/mm/pgtable.c
index f6184b86b89c..810730795358 100644
--- a/arch/sh/mm/pgtable.c
+++ b/arch/sh/mm/pgtable.c
@@ -64,7 +64,7 @@ static void __tlb_remove_table_slab(void *table)
 
 static void __tlb_remove_table_pgtable(void *table)
 {
-	pagetable_dtor_free(table);
+	pagetable_free(table);
 }
 
 void __tlb_remove_table(void *table)
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index b1d5c5a0ffb4..98c0a0d29769 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -441,15 +441,7 @@ static void __cpa_collapse_large_pages(struct cpa_data *cpa)
 
 	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
 		list_del(&ptdesc->pt_list);
-		/*
-		 * Only early alloc'd direct map should not be flagged PG_table
-		 * here and those shouldn't be collapsed. However be abundantly
-		 * cautious and handle the !PG_table case too.
-		 */
-		if (PageTable((ptdesc_page(ptdesc))))
-			pagetable_dtor_free(ptdesc);
-		else
-			pagetable_free(ptdesc);
+		pagetable_free(ptdesc);
 	}
 }
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 4a105f283cfb..81b3bb9a197a 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -732,7 +732,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 	for (i = 0; i < PTRS_PER_PMD; i++) {
 		if (!pmd_none(pmd[i])) {
 			pt = page_ptdesc(pmd_page(pmd[i]));
-			pagetable_dtor_free(pt);
+			pagetable_free(pt);
 		}
 	}
 
@@ -759,7 +759,7 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 	/* INVLPG to clear all paging-structure caches */
 	flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
 
-	pagetable_dtor_free(pt);
+	pagetable_free(pt);
 
 	return 1;
 }
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 051aa1331051..0ba651c1336d 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -54,7 +54,7 @@ static inline pte_t *pte_alloc_one_kernel_noprof(struct mm_struct *mm)
  */
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	pagetable_dtor_free(virt_to_ptdesc(pte));
+	pagetable_free(virt_to_ptdesc(pte));
 }
 
 /**
@@ -115,7 +115,7 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte_page);
 
-	pagetable_dtor_free(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 
@@ -162,7 +162,7 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
 
 	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
-	pagetable_dtor_free(ptdesc);
+	pagetable_free(ptdesc);
 }
 #endif
 
@@ -213,7 +213,7 @@ static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
 	struct ptdesc *ptdesc = virt_to_ptdesc(pud);
 
 	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
-	pagetable_dtor_free(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_PUD_FREE
@@ -261,7 +261,7 @@ static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
 	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
 
 	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
-	pagetable_dtor_free(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_P4D_FREE
@@ -300,7 +300,7 @@ static inline void __pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	struct ptdesc *ptdesc = virt_to_ptdesc(pgd);
 
 	BUG_ON((unsigned long)pgd & (PAGE_SIZE-1));
-	pagetable_dtor_free(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_PGD_FREE
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index fbe1114e9a44..b38b262bff5f 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -202,7 +202,7 @@ static inline void __tlb_remove_table(void *table)
 {
 	struct ptdesc *ptdesc = (struct ptdesc *)table;
 
-	pagetable_dtor_free(ptdesc);
+	pagetable_free(ptdesc);
 }
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index cb993a1d0728..26b1ad5998d9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4083,12 +4083,6 @@ static inline void pagetable_free(struct ptdesc *pt)
 	}
 }
 
-static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
-{
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
-}
-
 static inline bool pagetable_pte_ctor(struct mm_struct *mm,
 				      struct ptdesc *ptdesc)
 {
-- 
2.54.0

