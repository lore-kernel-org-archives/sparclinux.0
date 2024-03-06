Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F5F605C9
	for <sparclinux@vger.kernel.org>; Wed,  6 Mar 2024 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721799; cv=none; b=ruiwAhfMv36ByT/RabINNqvdBJ8tBlXSFqiGHg68ou08Rpc4ObIhku6Z+6UZb55eOJ+0CKhNriMGUd7zWBtlnjJnMqRfAjuf2YFaP0J7BadVTX/AJW2rzVaJmNamaFW9veZf9IhhmqaWlJjfp0ybIVa2yNHLOEMV8pyPi9DQeSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721799; c=relaxed/simple;
	bh=X5eBBmskEGNOVvFH7lA9BrgRznTJLWM2S1lsxZlH7is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D051NzWVhPo74piYtXah9sdGWRA67lMBA0jZ4gefI5mZPFiAJ/H1XHoEdHRgiJ+iMyPVR400ccxZCFLBJeccVDL6JoFil+QvoG6KdPI3NsiK3N8s5zmYL6emSyw/n2wqfvH/Zg7cvQCG5WNwzk3hx6jnB5/qgJTTJr/tbrEJNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FL+8QoTH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FL+8QoTH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709721797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kmh1r8OzIBeRtjZdwvZUDbG8Rg7aEeeC8h0p+1IZUgI=;
	b=FL+8QoTH85bZ9022gfc1DC3sM6hGKfrUL3ZYz1jlHwkvS16Lf3F/r5Zym0F5tlXIKSbm72
	IuYuOAuyKhWl69W10l5O560M741tkMm44b0tZSz/3ahSBZy5KHmebRlPlRUMYf70k0O/QX
	vntsjXPm2MU0ulP2BgvRZloE+xyx8YQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-28RiKZlpPQu-76jARwQEkw-1; Wed, 06 Mar 2024 05:43:10 -0500
X-MC-Unique: 28RiKZlpPQu-76jARwQEkw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13B1C8007A7;
	Wed,  6 Mar 2024 10:43:10 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 294B5111DD03;
	Wed,  6 Mar 2024 10:43:01 +0000 (UTC)
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
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: [PATCH RFC 09/13] mm/powerpc: Redefine pXd_huge() with pXd_leaf()
Date: Wed,  6 Mar 2024 18:41:43 +0800
Message-ID: <20240306104147.193052-10-peterx@redhat.com>
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

PowerPC book3s 4K mostly has the same definition on both, except pXd_huge()
constantly returns 0 for hash MMUs.  AFAICT that is fine to be removed,
because pXd_huge() reflects a hugetlb entry, while it's own hugetlb pgtable
lookup function (__find_linux_pte() shared by all powerpc code) already use
pXd_leaf() irrelevant of the MMU type.  It means pXd_leaf() should work all
fine with hash MMU pgtables or something could already went wrong.

The goal should be that we will have one API pXd_leaf() to detect all kinds
of huge mappings.  AFAICT we need to use the pXd_leaf() impl (rather than
pXd_huge() ones) to make sure ie. THPs on hash MMU will also return true.

This helps to simplify a follow up patch to drop pXd_huge() treewide.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable-4k.h | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
index 48f21820afe2..92545981bb49 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
@@ -8,22 +8,12 @@
 #ifdef CONFIG_HUGETLB_PAGE
 static inline int pmd_huge(pmd_t pmd)
 {
-	/*
-	 * leaf pte for huge page
-	 */
-	if (radix_enabled())
-		return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
-	return 0;
+	return pmd_leaf(pmd);
 }
 
 static inline int pud_huge(pud_t pud)
 {
-	/*
-	 * leaf pte for huge page
-	 */
-	if (radix_enabled())
-		return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
-	return 0;
+	return pud_leaf(pud);
 }
 
 /*
-- 
2.44.0

