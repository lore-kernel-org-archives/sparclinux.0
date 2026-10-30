Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349509;
	b=v4R6fj/dac4rjYJ0m0qDZKgUTL3Ld4SBLgojnJN0w4drcKNJTrPhiX4usuBlYyj4nwJE
	 /qr5S+6AKly5U0YccI/rL+S/PPWGV0Evej032NQYiv2fNjnC/wkh3kbbP8z9GbtfGn4xR
	 qo3wjEX1yOLlSha0by/06QSwW3dK5f9yhcMe7s5cSMWjS7JzDi7OmGkfF3ZSWe/UH5PUt
	 IYHJ2OgAXmgoHxOVOrRbOz3BH+kNyd64sJChNUIWrXiFy6vuhYeHQ2QUTAkb9cvyLMDao
	 7DjNYYvJFqL7qtSuifVuN3o6Tz+II9JpVXnE7vpjc4wPGN/rEUcz33yLU+qPH4DoPIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kNSWkSKbXy4yqbi1F/NqpsveYsUGyKJhJ7RGmrJoCBE=;
	b=mcv/OfPP3biJnU2NjT+OyiD6quWovm9X1oXDP/sYZ6zch9PsNFWM88NN544+7fWcDntf
	 RvuPCdQ4gmesU1AXyahpOzgQHvi05Ya3RveuSCNGqC3dtYe0X/XFxJMiE2LfTUar3pJWd
	 SVsgpJpYZSyzmiHOWwVnmMYJlq3Nm9C5cFZ7EKseivWO8AC4C5Dd1qM1+BmQ5Kgc+MD/T
	 pzR0jGh3O9T50M4sDEINwTf7FO0cqgWR8x4nDlWQZMTI9hdGri1RQNdHqjpYp8ggmR6HA
	 iaBjutg4HyK0GsYoP6vX3HRvUm918YkB74lOi94mDRSlBfasHCHWw46ZjSFZjsrCDUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lHH6tm9e;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA9560A262B
	for <sparclinux@vger.kernel.org>; Fri, 30 Oct 2026 08:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FA9560A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lHH6tm9e
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ccca948203aso147380a12.3
        for <sparclinux@vger.kernel.org>; Fri, 30 Oct 2026 01:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793349507; x=1793954307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kNSWkSKbXy4yqbi1F/NqpsveYsUGyKJhJ7RGmrJoCBE=;
        b=lHH6tm9eFLhBmHpmdTsOkTK3m0JIEPEobyAy6uFj3sElhv15/krfzc86zEF2LGl09l
         gANlXa9+ttvNpFVE8BCo/X34y5GeAZHgYcshWRwb+tLEjO9u7xUJponHyaycOlvphmA/
         CNY/pQCj9auwT+9XNiX7L5KsJkoqEKjUVQuBq8L8t6MReuJnqehrSrKxGqsUz45vytRW
         6s2huHzN3py+tWUMsxojPDdwmCxyIiDi6O2DbC6mzwPhvXhQMQmOnjRBbL3ZSxb+67Mf
         IL1BSOy6qndNztXXGEyBjCrGUximKMiGuRC5myYgtlauUDaCp5YKeJOseTmSgMVE7HNz
         Kk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793349507; x=1793954307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kNSWkSKbXy4yqbi1F/NqpsveYsUGyKJhJ7RGmrJoCBE=;
        b=S4RoTXGdcGW4emPDHP4uy6KYAUdKP+MusX9Ck5yXOdmkakJeXVzw7cicVbASmZiGO3
         v3viXA5pr/p9OfeaMUtsw74QlYnS3/Sffh4b0uZqJrilc57rfvzSANUNlFlEXxsKp1yG
         F5esXTyeHEZ+K4tqj/bsmbyq+OR6s3iNXRoav+f5ZPlZOLqe0pbmuZX702UXEHxCcnQu
         sqmbF3UhajSPucr5K/2ZFq0juJT/z521lNRZBY7zVfw5q39aIJigRyut9HvD5Fs3D9Jj
         Ka03+s2AD4uANfsh4IlzJYlwbiLQq80Khrrp5INYxOkfChmvS9tcUVIJ/p+qnfZAxGQN
         AP7Q==
X-Forwarded-Encrypted: i=1; AKwUvByKeFsZUAN66U+AMWCGOV7tgX8f1EnaCsJdVJdfMKcNBfP/r3Gm1WXB1cCQXpzmd5Q82PacdbyA0tPv@vger.kernel.org
X-Gm-Message-State: AFq9FYLAvoujD2PjDIoqdYHy1jQ/6wdeP1AclhnrDOWvPYma6BmrQ6Nb
	OrSGwculLBq1oG2LGOCK/vTxWhTX6NPxY74ougNsdmVsMbxeWjaCObWTAKRHm2oBnvo=
X-Gm-Gg: AYBFou3m/Ocr1OrIVhSryWZ4trz3T1vu7sJjvh0y+RFFn2CdqBCqOgajyVSQu1aTndP
	tTAkZzIRHha4h71RLutNJZ7dmrfhCW79o3/1oBIgyBA2qQ8hjPpY4d1EIXpQaDaZ2cjiRq1I0bx
	9+MyXYwK+wY3TZMtiPsJxJCQZLWawwSn5r6VjIEe2MZp+upHKJRLP0vA/tWs5uMiScnx7mrYnIN
	OkkfsRVLveVaE89+TdJYW9/Zqj65zE/2ezBhmt0CAEkE70jwJBgjTxQ41WERDjLhZrw02ymoouX
	KuwrNDbmgE/YFrDJ7CJx1534JO9akhkjd+qr864odi3QGrvi8d7Ywsih7snebZPzF3S2YuqYFXm
	qNP5IpniYLsXymwVa1qGmZoHbIlnFZwBvFX3kLAixH8FO5JolzOXtVTilQ3DDp2ZPLKfqzocjmJ
	pR4TJr6q0iyaJivGoPV+2xCvgPTSiFYq+eB4DfLecdQqiC0eIezmrYyTKAPu9FaBQL+52DuFJ5k
	CqiiKJ+x9tobFP52h4XvtyKlzkUq7W/73ttMTHSqUT1U24AQZK1oBpi/7Ke7XMyMXhHjWJl266i
	n5xDf5KMkWYRiTUsLQK13spBjr3JeTMaH0+lczyzcTi9+PURIOY=
X-Received: by 2002:a17:90a:e70c:b0:3ad:a232:4044 with SMTP id 98e67ed59e1d1-3ae8979969fmr1091626a91.38.1793349506870;
        Fri, 30 Oct 2026 01:38:26 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9b1506sm7542122a91.15.2026.10.30.01.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 01:38:26 -0700 (PDT)
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
Subject: [PATCH 2/2] mm: remove redundant pagetable_dtor() calls
Date: Fri, 30 Oct 2026 16:38:00 +0800
Message-ID: <20261030083800.599152-3-songmuchun@bytedance.com>
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

pagetable_free() now runs pagetable_dtor() for constructed page
tables. Calling the destructor immediately before freeing the page table
therefore duplicates the lifecycle handling at each caller.

Remove the redundant calls and let pagetable_free() handle the
destructor. No functional change is intended.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/m68k/include/asm/mcf_pgalloc.h    | 1 -
 arch/powerpc/mm/book3s64/mmu_context.c | 1 -
 arch/powerpc/mm/book3s64/pgtable.c     | 1 -
 arch/powerpc/mm/pgtable-frag.c         | 2 --
 arch/s390/include/asm/pgalloc.h        | 4 ----
 arch/sparc/mm/init_64.c                | 1 -
 arch/x86/mm/pgtable.c                  | 1 -
 7 files changed, 11 deletions(-)

diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index 27c3b91ac0b8..f607d239ce16 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -62,7 +62,6 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(pgtable);
 
-	pagetable_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 
diff --git a/arch/powerpc/mm/book3s64/mmu_context.c b/arch/powerpc/mm/book3s64/mmu_context.c
index 2fe787e6c2dc..36ce18e625cc 100644
--- a/arch/powerpc/mm/book3s64/mmu_context.c
+++ b/arch/powerpc/mm/book3s64/mmu_context.c
@@ -249,7 +249,6 @@ static void pmd_frag_destroy(void *pmd_frag)
 	count = ((unsigned long)pmd_frag & ~PAGE_MASK) >> PMD_FRAG_SIZE_SHIFT;
 	/* We allow PTE_FRAG_NR fragments from a PTE page */
 	if (atomic_sub_and_test(PMD_FRAG_NR - count, &ptdesc->pt_frag_refcount)) {
-		pagetable_dtor(ptdesc);
 		pagetable_free(ptdesc);
 	}
 }
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 85ab6723c8f2..4ff471775f2d 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -450,7 +450,6 @@ void pmd_fragment_free(unsigned long *pmd)
 
 	BUG_ON(atomic_read(&ptdesc->pt_frag_refcount) <= 0);
 	if (atomic_dec_and_test(&ptdesc->pt_frag_refcount)) {
-		pagetable_dtor(ptdesc);
 		pagetable_free(ptdesc);
 	}
 }
diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
index ae742564a3d5..2568bb514181 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -26,7 +26,6 @@ void pte_frag_destroy(void *pte_frag)
 	/* We allow PTE_FRAG_NR fragments from a PTE page */
 	if (atomic_sub_and_test(PTE_FRAG_NR - count, &ptdesc->pt_frag_refcount)) {
 		folio_clear_active(ptdesc_folio(ptdesc));
-		pagetable_dtor(ptdesc);
 		pagetable_free(ptdesc);
 	}
 }
@@ -110,7 +109,6 @@ static void pte_free_now(struct rcu_head *head)
 	struct ptdesc *ptdesc;
 
 	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
-	pagetable_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index a5de9e61ea9e..d554c475c61f 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -66,7 +66,6 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 	if (mm_p4d_folded(mm))
 		return;
 
-	pagetable_dtor(virt_to_ptdesc(p4d));
 	crst_table_free(mm, (unsigned long *) p4d);
 }
 
@@ -88,7 +87,6 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 	if (mm_pud_folded(mm))
 		return;
 
-	pagetable_dtor(virt_to_ptdesc(pud));
 	crst_table_free(mm, (unsigned long *) pud);
 }
 
@@ -111,7 +109,6 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
 	if (mm_pmd_folded(mm))
 		return;
-	pagetable_dtor(virt_to_ptdesc(pmd));
 	crst_table_free(mm, (unsigned long *) pmd);
 }
 
@@ -144,7 +141,6 @@ static inline pgd_t *pgd_alloc_noprof(struct mm_struct *mm)
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	pagetable_dtor(virt_to_ptdesc(pgd));
 	crst_table_free(mm, (unsigned long *) pgd);
 }
 
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 9bbccb5d23a8..9f3cb7883f3f 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2840,7 +2840,6 @@ static void __pte_free(pgtable_t pte)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
 
-	pagetable_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 81b3bb9a197a..9929d7d55d72 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -156,7 +156,6 @@ static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 		if (pmds[i]) {
 			ptdesc = virt_to_ptdesc(pmds[i]);
 
-			pagetable_dtor(ptdesc);
 			pagetable_free(ptdesc);
 			mm_dec_nr_pmds(mm);
 		}
-- 
2.54.0

