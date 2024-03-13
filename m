Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9577E5A78A
	for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366453; cv=none; b=JnO53qmVTtmikF8DVflhzsHX095inAbuOaqQUlmWkNhULAkg7AOB08DRdd9s8sDL6cd85kB+H9glu7gegjS6vPZsUvkLG8IxHmWhtfHMS+CSUZ0e06t0gBEbxuqug0Y8vEo52wnQi1lmFMfpjv/vrqhH2Xb4i3Mn5Oj39GTr04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366453; c=relaxed/simple;
	bh=iHHSvsdkBOFub0mcOT/89y75sePdz9RiRVPlZT5QMlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ve/eBDzQ2fw5Sadps3RDxCWdSG925K1BBoCfUW5d3b9fUtX7douC3NGxlHOjNp7PQ+yrGetP5E3fhj3C3QcSQsjCKItxYDc7a6C/zGJW48yoC0DzyiumNMOq2CG8DvjwQ3W8QKJrAtXSrHB+vsvyF/WB3YCHyoBvEWGjHndmDX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LB8wzJ78; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LB8wzJ78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXyJDuJosTa0kFBnhKvW1aqbtapsaxz0OHU+bPr+fnc=;
	b=LB8wzJ78SlFuj+V7wiruUtcK0Vzk5PHrJ5e3qM6DdeFc9ECKcrK9pJsCD7dAIRUQI3HvIa
	eZID2Y5Wbv/DQnjP3Xuuv8BRAtMeGEnNY1R/9pgGHH4RFAqEuAkFcyYNAY1HOrfWFpp81w
	MH5Ptbtnyl/w/iiETFNhLF/KGt0IsbI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-k5CjuGDLMLCpu-n3mx7eqA-1; Wed, 13 Mar 2024 17:47:29 -0400
X-MC-Unique: k5CjuGDLMLCpu-n3mx7eqA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6818b8cb840so989036d6.1
        for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 14:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366449; x=1710971249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXyJDuJosTa0kFBnhKvW1aqbtapsaxz0OHU+bPr+fnc=;
        b=lcwJttYkI5DtnIQBP0Fm7cKaJMWTM81MnTveRUakO3g/QbSlq9EWjbhYDXtCvACBnq
         1HP89OyK4TsFkNpD1j/4+BghwyD4t3oJ71rOoC2mtVMQpsy23O6/fd6CWrM9+cMnDlFI
         homf8Yb3mVx17VaoRFYTvt0UdlksFYxHPx0fVzEcD5T1MoGFpow1by3S/d3J+2N4ZIf1
         GnkD17ABk8Anu1PMPdWKQWUNlS8EJpn+K6FR/kdJy3Lc2tJTBWlNzaU8j8YK50z/cBFq
         9DmtZ/A4f1WoVRjzvd4GryHl563Ux4h1LYHUL8ZqcZ1F1s4PfzilrMy068tr9QkMVcAU
         G2og==
X-Forwarded-Encrypted: i=1; AJvYcCWrgUbKPYY6yRqqDiulrGNxAhwgmKvcihEzjY0/5NXz8g3fRCnsLV/YTn8TOzrLizAqVeSa+zKxGTVgSemSRngL7oJ22YgWWLznsg==
X-Gm-Message-State: AOJu0YwbWm4wOs0R1XSJfAsof8+5TwI3Npa8RULtpkwZDgNPqJ8L06Pa
	tDxoKAFRWqW+1u2G4ggysaF5L9VeJuraYAeV00wRN8FChccuOj3qqQYwyO2yyP7p3TmH8NmCY+4
	N6yeDw+0vpKYacuF4H+dHIFNsfF5ELVLDMnqMjDRVMiiGzoUKXt1OyGsQfSU=
X-Received: by 2002:a05:6214:aa7:b0:690:d74d:7e6d with SMTP id ew7-20020a0562140aa700b00690d74d7e6dmr2881504qvb.3.1710366448978;
        Wed, 13 Mar 2024 14:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELbWWxNSgYU6xiV6giMb0Xazy3M+lqNjbyiI8S6tM3m0hmfGtXABqH+Dtrq87Nz5UyrTDJQA==
X-Received: by 2002:a05:6214:aa7:b0:690:d74d:7e6d with SMTP id ew7-20020a0562140aa700b00690d74d7e6dmr2881487qvb.3.1710366448612;
        Wed, 13 Mar 2024 14:47:28 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:28 -0700 (PDT)
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
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH 05/13] mm/sparc: Change pXd_huge() behavior to exclude swap entries
Date: Wed, 13 Mar 2024 17:47:11 -0400
Message-ID: <20240313214719.253873-6-peterx@redhat.com>
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

Please refer to the previous patch on the reasoning for x86.  Now sparc is
the only architecture that will allow swap entries to be reported as
pXd_huge().  After this patch, all architectures should forbid swap entries
in pXd_huge().

Cc: David S. Miller <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sparc/mm/hugetlbpage.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index b432500c13a5..d31c2cec35c9 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -409,14 +409,12 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 
 int pmd_huge(pmd_t pmd)
 {
-	return !pmd_none(pmd) &&
-		(pmd_val(pmd) & (_PAGE_VALID|_PAGE_PMD_HUGE)) != _PAGE_VALID;
+	return pmd_leaf(pmd);;
 }
 
 int pud_huge(pud_t pud)
 {
-	return !pud_none(pud) &&
-		(pud_val(pud) & (_PAGE_VALID|_PAGE_PUD_HUGE)) != _PAGE_VALID;
+	return pud_leaf(pud);
 }
 
 static void hugetlb_free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
-- 
2.44.0

