Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA66D60BB0
	for <sparclinux@vger.kernel.org>; Wed,  6 Mar 2024 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721764; cv=none; b=TqSW4gsoGAbKMGjv0f+M1+GILS+dvhQlLsr61OWcVN8jX8oSlNL96BWJwjNag2D/u0cs0pED1MAGl3ESFa5beF8Hg1fKXiqyKspnJSYK7kTwcbtDQtnHWplwaYoYBnBsVJFOD3hIoGHv1JjNVH+ykK5p1ze2RBa5srjtx8sIzNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721764; c=relaxed/simple;
	bh=iHHSvsdkBOFub0mcOT/89y75sePdz9RiRVPlZT5QMlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YB2ytOkA+pxST83f5ZsVh3YKe2Iwv6fJbQ7R91Ltq5jYWXtFwatDyjZLmu/+/ufOQNNm00PRCy1ljGFIijdnP+dLReHaNnyOtR5N+WqlfIeC/i2ZMMxvzuSd4n16YFdYRSfoPnccaydnx27iafCY75nXOV4gGiOFpM530PuOghk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWKs6meb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWKs6meb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709721762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXyJDuJosTa0kFBnhKvW1aqbtapsaxz0OHU+bPr+fnc=;
	b=YWKs6mebCISfQzqmMd/2tIg8ohAyUv3PybAbWqO6vyXXoxSNzqe8jALD29Pmh/zS7JlHC5
	H6fXMP/g4AAgqoKv8JBWeIsucq/Kbv6fUKbyruXXr6K5V8WRopVX4WXyE+XBzftU+/eV93
	8XzbqB0OIFJqnmfcyrUdFMaGFX1Gwas=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-DuM7_ICQNPWc0Qhye-aEuA-1; Wed,
 06 Mar 2024 05:42:34 -0500
X-MC-Unique: DuM7_ICQNPWc0Qhye-aEuA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 068C21C05AED;
	Wed,  6 Mar 2024 10:42:34 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D10DC111DCFF;
	Wed,  6 Mar 2024 10:42:26 +0000 (UTC)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	peterx@redhat.com,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	x86@kernel.org,
	sparclinux@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH RFC 05/13] mm/sparc: Change pXd_huge() behavior to exclude swap entries
Date: Wed,  6 Mar 2024 18:41:39 +0800
Message-ID: <20240306104147.193052-6-peterx@redhat.com>
In-Reply-To: <20240306104147.193052-1-peterx@redhat.com>
References: <20240306104147.193052-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

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

