Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F45E1386B1
	for <sparclinux@vger.kernel.org>; Wed, 27 Mar 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549997; cv=none; b=R4W3uuznFpOtOGBlwZe1wthqTijA+R8KQHZ1AglTFoQvnd5Iqgj28McmC1MgeTCg4UTnptPkY9AmklkLTrLlMx9syGQNsEsqkdOhu845HpbMjws2aUFSN+lK4/S/U5VQQly4+OEqoEKWliGSAZdgl/MUda/+R1Wsw2GmdkC5R94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549997; c=relaxed/simple;
	bh=8gpmKkY29SJuTg4LmIbkZEOBCZ11ElunVVIi45/9jI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EdfRI8d6VAkf18panOvY51F7NdWoiM2hEUXfeGjTznXnYks25eLVDKFpeV6WCy84d5ymZJwvqtWt2MutWzDOms4usaKTXy9AS2QRBmjc6PaCP0SZNY4yy7PKBD4YqvUDnoY5dpZUeejIBu8BSJz6S+RbI8sb4ER8cxSaIZWRcY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c7B9R/EO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7B9R/EO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711549994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l5JjIi+WQ126Fkbtv46vLIk/jhfAPVnucXDpVIswBCE=;
	b=c7B9R/EOEMP9wMYe30RnFonvP81ryE5KFLfIxiO7NX8dxDPAP7mBrHheFsOL+GRt320Fml
	HmNq7W9MQtJt2ZDW00qyiJXNeYUPdcaFZXWOrJi55qOnFoY9GZxDhsgIANYvKOOgy1YnOa
	8yn2AWmHyPb1N6ajUBtL3BWvtPYGvf0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-ek6u8Lc_ON65MTWXMQdBMg-1; Wed, 27 Mar 2024 10:33:08 -0400
X-MC-Unique: ek6u8Lc_ON65MTWXMQdBMg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FB8A8007A7;
	Wed, 27 Mar 2024 14:33:08 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.208])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3EE5D492BC9;
	Wed, 27 Mar 2024 14:33:06 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Subject: [PATCH v1] mm: remove "prot" parameter from move_pte()
Date: Wed, 27 Mar 2024 15:33:01 +0100
Message-ID: <20240327143301.741807-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

The "prot" parameter is unused, and using it instead of what's stored in
that particular PTE would very likely be wrong. Let's simply remove it.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/sparc/include/asm/pgtable_64.h | 2 +-
 include/linux/pgtable.h             | 2 +-
 mm/mremap.c                         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 4d1bafaba942..38c3446e2c61 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -956,7 +956,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 
 #ifdef DCACHE_ALIASING_POSSIBLE
 #define __HAVE_ARCH_MOVE_PTE
-#define move_pte(pte, prot, old_addr, new_addr)				\
+#define move_pte(pte, old_addr, new_addr)				\
 ({									\
 	pte_t newpte = (pte);						\
 	if (tlb_type != hypervisor && pte_present(pte)) {		\
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 09c85c7bf9c2..e62fe05318db 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1079,7 +1079,7 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 #endif
 
 #ifndef __HAVE_ARCH_MOVE_PTE
-#define move_pte(pte, prot, old_addr, new_addr)	(pte)
+#define move_pte(pte, old_addr, new_addr)	(pte)
 #endif
 
 #ifndef pte_accessible
diff --git a/mm/mremap.c b/mm/mremap.c
index 38d98465f3d8..f5aba752d35f 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -205,7 +205,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		 */
 		if (pte_present(pte))
 			force_flush = true;
-		pte = move_pte(pte, new_vma->vm_page_prot, old_addr, new_addr);
+		pte = move_pte(pte, old_addr, new_addr);
 		pte = move_soft_dirty_pte(pte);
 		set_pte_at(mm, new_addr, new_pte, pte);
 	}
-- 
2.43.2

