Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C01C13B780
	for <sparclinux@vger.kernel.org>; Thu, 25 Jan 2024 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211246; cv=none; b=JQWYPzKH2V1p+Z7jV6IwTfSixtSXSTIf5UIvPNpLjg1rWB3iovATYqYSUWHhj5WZ9YqXsnAkKvPKlEThPj0R1TqrRG62zyd855zyMaVJcfCWPg23OE3VRXDS8v1PHiRVwS/DkHGI5lQDrJsvjQKQV6ckEP5/SPMlulCQXm6jssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211246; c=relaxed/simple;
	bh=DqZd8VNKrBMA2MCTzOsJDO3H2WtPlAO0jJy/IaCevjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmyWReg5/FvbfJnhMkl0MUao1BDT44HHDcSoexYIeE5Pj3ts0OgnnzZ/Wh34+zSjiTyGAhx+2k/K9nZHahgPd/y92rNDcSr8UP0szSB22jxwK+mRn2F29JWUNUASBgPJwEQpavfGR2fVOhaz76UwEcibdvBBvcNAeD4do1853ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+6cDMIk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+6cDMIk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706211243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t50qmPGMpYBEYaKXQ+yO8QVLOuyugBz/n/H7V6E+Pmw=;
	b=M+6cDMIkgqQvRN3vG7JUQUfO3Pc9A7dAxEB3zArUVwXfvgAaSNJ+Lr7Hspmcr9RIsSzVqd
	1oVlgrbNOu0eju+5ecJnl6chg44jV/5a1VPj6M9Ij0X39x6A5HZvPBEB3YujwAEwiWIYPd
	9G6DEtyRkkkpk2jTL3BsOi/fjrZwoog=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-d5Q_-Ra7Nw6rcBDvoDTvqQ-1; Thu, 25 Jan 2024 14:34:01 -0500
X-MC-Unique: d5Q_-Ra7Nw6rcBDvoDTvqQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2A0C1013665;
	Thu, 25 Jan 2024 19:33:59 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.154])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9077F492BC6;
	Thu, 25 Jan 2024 19:33:53 +0000 (UTC)
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
Subject: [PATCH v2 14/15] mm/memory: ignore dirty/accessed/soft-dirty bits in folio_pte_batch()
Date: Thu, 25 Jan 2024 20:32:26 +0100
Message-ID: <20240125193227.444072-15-david@redhat.com>
In-Reply-To: <20240125193227.444072-1-david@redhat.com>
References: <20240125193227.444072-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Let's always ignore the accessed/young bit: we'll always mark the PTE
as old in our child process during fork, and upcoming users will
similarly not care.

Ignore the dirty bit only if we don't want to duplicate the dirty bit
into the child process during fork. Maybe, we could just set all PTEs
in the child dirty if any PTE is dirty. For now, let's keep the behavior
unchanged, this can be optimized later if required.

Ignore the soft-dirty bit only if the bit doesn't have any meaning in
the src vma, and similarly won't have any in the copied dst vma.

For now, we won't bother with the uffd-wp bit.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 4d1be89a01ee0..b3f035fe54c8d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -953,24 +953,44 @@ static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
 	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
 }
 
+/* Flags for folio_pte_batch(). */
+typedef int __bitwise fpb_t;
+
+/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
+#define FPB_IGNORE_DIRTY		((__force fpb_t)BIT(0))
+
+/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
+#define FPB_IGNORE_SOFT_DIRTY		((__force fpb_t)BIT(1))
+
+static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
+{
+	if (flags & FPB_IGNORE_DIRTY)
+		pte = pte_mkclean(pte);
+	if (likely(flags & FPB_IGNORE_SOFT_DIRTY))
+		pte = pte_clear_soft_dirty(pte);
+	return pte_mkold(pte);
+}
+
 /*
  * Detect a PTE batch: consecutive (present) PTEs that map consecutive
  * pages of the same folio.
  *
- * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN.
+ * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN,
+ * the accessed bit, dirty bit (with FPB_IGNORE_DIRTY) and soft-dirty bit
+ * (with FPB_IGNORE_SOFT_DIRTY).
  */
 static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
-		pte_t *start_ptep, pte_t pte, int max_nr)
+		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags)
 {
 	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
 	const pte_t *end_ptep = start_ptep + max_nr;
-	pte_t expected_pte = pte_next_pfn(pte);
+	pte_t expected_pte = __pte_batch_clear_ignored(pte_next_pfn(pte), flags);
 	pte_t *ptep = start_ptep + 1;
 
 	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
 
 	while (ptep != end_ptep) {
-		pte = ptep_get(ptep);
+		pte = __pte_batch_clear_ignored(ptep_get(ptep), flags);
 
 		if (!pte_same(pte, expected_pte))
 			break;
@@ -1004,6 +1024,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 {
 	struct page *page;
 	struct folio *folio;
+	fpb_t flags = 0;
 	int err, nr;
 
 	page = vm_normal_page(src_vma, addr, pte);
@@ -1018,7 +1039,12 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	 * by keeping the batching logic separate.
 	 */
 	if (unlikely(!*prealloc && folio_test_large(folio) && max_nr != 1)) {
-		nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr);
+		if (src_vma->vm_flags & VM_SHARED)
+			flags |= FPB_IGNORE_DIRTY;
+		if (!vma_soft_dirty_enabled(src_vma))
+			flags |= FPB_IGNORE_SOFT_DIRTY;
+
+		nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr, flags);
 		folio_ref_add(folio, nr);
 		if (folio_test_anon(folio)) {
 			if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page,
-- 
2.43.0

