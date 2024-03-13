Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224BA5E066
	for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366459; cv=none; b=c1dhz8bfd9MsqCSzu+6wH4NC7Kmlp4kczvKLpkfcIqdIodEKvBSnju+3P+WpHykqsUi/NfxYFHdTcNVj9VWpZT9oPWdUiAkK1YyBFTrNY/+AD0HIkLeltjkY8fvneHWpSIA/sBhXb2g9rR61ijoPFCM3I57kRGAdtZ8oiD1oC2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366459; c=relaxed/simple;
	bh=t18R28ny76a7TFkmozYcxNFR6pN9FqPc0sZ3mbG+iGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKwH/wMohEczlrYwCuYHQObpr5kA18j6/FlwYyaDgKf8mstXf9QXGXsIEpDcJ6D3TiAS/AV8nT9jycR1tGN88/SlR5GZW8Jmz5Zqsm4/mQGlpZGShdlX0PgurMEF9/NHWbsTHo8+sAQCxDoZEX8//2etXSL1HHrQDOXgLvCB3+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBeQCrtn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBeQCrtn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xZurg04juSYF/uW9HtnhgkfMM1C/gArxmrpoVNEgvCQ=;
	b=SBeQCrtnqHalaF4ij/nFhZNiI+eARsbmV8yx4QsCtNna3JCa4lJ+8rGd3lRzXcXeM8wohm
	qJN9LS5pXgMNewiDDcDNW9aMhXgU8/VQEAs6HswGtID701FRuXbzkf5+PDDA/Ofw0x5+Qs
	AduHSVOOgpAUgK3iubymWDp1e+/DXG4=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-vpVrU8myMv2cIP8S-Ob_eQ-1; Wed, 13 Mar 2024 17:47:34 -0400
X-MC-Unique: vpVrU8myMv2cIP8S-Ob_eQ-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4730797bef9so2624137.1
        for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 14:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366453; x=1710971253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZurg04juSYF/uW9HtnhgkfMM1C/gArxmrpoVNEgvCQ=;
        b=Pq4Lur2C765Nj+sRcJPIbnDBZ7xmGnKlSegZ9FXY5ajAyfu7G1LGZVyHSHTZ/rd1U9
         KLsxnYeM/XukQ/NR5W0CBTe1V1JwYxxeZ1FW8kELuMc+DbRonYMPJuxCcxRSolzXPj7i
         9z30TabXE3sST2PwoxGspy8bejaN/gvcWKtdcqtTVy6kSBQ8AqAPUPy8IVQcRSSBfKnQ
         VzSJfRfVtyvHSYm7y6WbxX9VS6J+XnQhrHhZeGJqckXXOyWTZ8EHWVfYfPLLTfk7MnBQ
         56emCkQyiI8d4HHSGkVwWTZBBmleDWa7Hg1ygda2Xq+paJ4unHCxZYV79yD7TWSBoWkh
         MlkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1AjgYmcBDefrGz9vr7yuhv5JyLsslmfr/GlD69Ik7ss8k1M7rnoDw85FxQOHVsQHNqEEjflvEryzFRIiupS9097X2R0QWAfXhwg==
X-Gm-Message-State: AOJu0Yz4e5cb5ZAk3zbOZWegjXx7BMsbvCk+CDSnNdxIK9PuKRZaR6kN
	jwDWsqONphy5QLELI1DMzyEBTsEulbRhDIbVBxWU28fjwTgsvYsZlzkSWsG9n+5aFm0R/aBnZD2
	ola6JPrLMxECN5NvOFhTohZFwoGsdDTfKBhpIhl+5uza4iFxdkOhXti6UHt4=
X-Received: by 2002:a05:6102:5492:b0:474:d28c:2ac5 with SMTP id bk18-20020a056102549200b00474d28c2ac5mr243712vsb.0.1710366453595;
        Wed, 13 Mar 2024 14:47:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkTENrzWBEROMNgSFXQjsM78hPZrMM1UORfrrvjF9qoLUGsHb0Hjw+2mHy3NCjFs/y6Z4aCg==
X-Received: by 2002:a05:6102:5492:b0:474:d28c:2ac5 with SMTP id bk18-20020a056102549200b00474d28c2ac5mr243694vsb.0.1710366453272;
        Wed, 13 Mar 2024 14:47:33 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:32 -0700 (PDT)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org,
	Matthew Wilcox <willy@infradead.org>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	peterx@redhat.com,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	sparclinux@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mark Salter <msalter@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 08/13] mm/arm64: Merge pXd_huge() and pXd_leaf() definitions
Date: Wed, 13 Mar 2024 17:47:14 -0400
Message-ID: <20240313214719.253873-9-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313214719.253873-1-peterx@redhat.com>
References: <20240313214719.253873-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

Unlike most archs, aarch64 defines pXd_huge() and pXd_leaf() slightly
differently.  Redefine the pXd_huge() with pXd_leaf().

There used to be two traps for old aarch64 definitions over these APIs that
I found when reading the code around, they're:

 (1) 4797ec2dc83a ("arm64: fix pud_huge() for 2-level pagetables")
 (2) 23bc8f69f0ec ("arm64: mm: fix p?d_leaf()")

Define pXd_huge() with the current pXd_leaf() will make sure (2) isn't a
problem (on PROT_NONE checks). To make sure it also works for (1), we move
over the __PAGETABLE_PMD_FOLDED check to pud_leaf(), allowing it to
constantly returning "false" for 2-level pgtables, which looks even safer
to cover both now.

Cc: Muchun Song <muchun.song@linux.dev>
Cc: Mark Salter <msalter@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/include/asm/pgtable.h | 4 ++++
 arch/arm64/mm/hugetlbpage.c      | 8 ++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 401087e8a43d..14d24c357c7a 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -704,7 +704,11 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #define pud_none(pud)		(!pud_val(pud))
 #define pud_bad(pud)		(!pud_table(pud))
 #define pud_present(pud)	pte_present(pud_pte(pud))
+#ifndef __PAGETABLE_PMD_FOLDED
 #define pud_leaf(pud)		(pud_present(pud) && !pud_table(pud))
+#else
+#define pud_leaf(pud)		false
+#endif
 #define pud_valid(pud)		pte_valid(pud_pte(pud))
 #define pud_user(pud)		pte_user(pud_pte(pud))
 #define pud_user_exec(pud)	pte_user_exec(pud_pte(pud))
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 0f0e10bb0a95..1234bbaef5bf 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -81,16 +81,12 @@ bool arch_hugetlb_migration_supported(struct hstate *h)
 
 int pmd_huge(pmd_t pmd)
 {
-	return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
+	return pmd_leaf(pmd);
 }
 
 int pud_huge(pud_t pud)
 {
-#ifndef __PAGETABLE_PMD_FOLDED
-	return pud_val(pud) && !(pud_val(pud) & PUD_TABLE_BIT);
-#else
-	return 0;
-#endif
+	return pud_leaf(pud);
 }
 
 static int find_num_contig(struct mm_struct *mm, unsigned long addr,
-- 
2.44.0

