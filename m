Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E1E47F55
	for <sparclinux@vger.kernel.org>; Mon, 22 Jan 2024 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952581; cv=none; b=WuFE5B9a20i+yRFpwvod95rSBYNWG14mp/p4MPJA8KKTtZfF/rvKnaEff0i6K7H7Ui9YoSEHfWVmhYgZFKUxfpndZi6yNspmL3lbvM9y8QmjoXUehivnGtbfpiVZ7vR4HKdDKxesacnQ83vVINLaIoYC0MqiEcPNs12dHnFlYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952581; c=relaxed/simple;
	bh=LQmfaE+WNxEEYA7FcHTQ60ETgLPMV6IALlAB3ldJuis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLOMxvrhooqnk0EJwxRX7HRBmkKzpcbYKyi3L+N/ZlujWfSE82NSlutYfukrIuATsr3+/dVeQaygOWgCdxQJErnq6MTYQ4k9qfidDAd1SPpSGS1gb8VVA3d+DUJLm2K0f9y5R8lQceBOayIpuMBisAjo5Rcj76zrd543NfLbqI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WChc0O/o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WChc0O/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705952579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uF2bxfDUAnNambtI6tdyCXd/UbNqDVLKUcWAFsWTSNU=;
	b=WChc0O/om4CGsUpqarq61nBpeXwPbIcbB1YjFJsp/EVdNK2Nl60L0P5KlsAWDvzQ6mhCJ6
	Hz991FQg5Z/ZoQHqg8yleLEWBOlYliK/4jUJD9u6Zkfz+yYtUkRJoqABRxJMmrs+2TPsnl
	TFoMsSnRdK5gNhqeVbqPZIIOJlRVVSY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-81vkS9EYMCG6II-n3hayug-1; Mon, 22 Jan 2024 14:42:53 -0500
X-MC-Unique: 81vkS9EYMCG6II-n3hayug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 055AF106D1A6;
	Mon, 22 Jan 2024 19:42:52 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.195.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7D396488;
	Mon, 22 Jan 2024 19:42:47 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v1 08/11] mm/memory: pass PTE to copy_present_pte()
Date: Mon, 22 Jan 2024 20:41:57 +0100
Message-ID: <20240122194200.381241-9-david@redhat.com>
In-Reply-To: <20240122194200.381241-1-david@redhat.com>
References: <20240122194200.381241-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

We already read it, let's just forward it.

This patch is based on work by Ryan Roberts.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2aa2051ee51d3..185b4aff13d62 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -959,10 +959,9 @@ static inline void __copy_present_pte(struct vm_area_struct *dst_vma,
  */
 static inline int
 copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
-		 pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
-		 struct folio **prealloc)
+		 pte_t *dst_pte, pte_t *src_pte, pte_t pte, unsigned long addr,
+		 int *rss, struct folio **prealloc)
 {
-	pte_t pte = ptep_get(src_pte);
 	struct page *page;
 	struct folio *folio;
 
@@ -1104,7 +1103,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		}
 		/* copy_present_pte() will clear `*prealloc' if consumed */
 		ret = copy_present_pte(dst_vma, src_vma, dst_pte, src_pte,
-				       addr, rss, &prealloc);
+				       ptent, addr, rss, &prealloc);
 		/*
 		 * If we need a pre-allocated page for this pte, drop the
 		 * locks, allocate, and try again.
-- 
2.43.0

