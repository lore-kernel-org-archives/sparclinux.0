Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072BF22F164;
	Fri, 30 May 2025 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748613933; cv=none; b=Km52urKL47JrlKd2yzYCo7L3JOm3tUh13O9JpzA1kfekS8Tn7eAENRgCCNX+CmipErtYyeN0NBjwNoKFNZr9XpxGL5V9Hac57ERiT2BckrD2bjFjX6ZHzjNhACGWwGrc7z6gM+/i69ZuR3Q6C+1mrLaZsNa1pF26i8M9o4rMu70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748613933; c=relaxed/simple;
	bh=yLm0jyQJu0WZrXh+w7GKCHO5nUthXsl1vtsPqXVY914=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUIYqqwkEVuzCX8ErGh/wMh99VqlKpBCDElo9R8Y+jH3IxYc6otJELNDCpAFsfrsH8XDWc21I5ZF0SFh/kr8u24YHpsfiFe1CKX7aUFSuDVI0rvI6Wu+8GzJej1En4UdZu4dyDj1kVux8MzFmyE3caPRWyaGpmkKqVsVqXSVHMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A52826A4;
	Fri, 30 May 2025 07:05:15 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9729C3F673;
	Fri, 30 May 2025 07:05:26 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 5/6] mm: Avoid calling page allocator while in lazy mmu mode
Date: Fri, 30 May 2025 15:04:43 +0100
Message-ID: <20250530140446.2387131-6-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530140446.2387131-1-ryan.roberts@arm.com>
References: <20250530140446.2387131-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lazy mmu mode applies to the current task and permits pte modifications
to be deferred and updated at a later time in a batch to improve
performance. tlb_next_batch() is called in lazy mmu mode as follows:

zap_pte_range
  arch_enter_lazy_mmu_mode
  do_zap_pte_range
    zap_present_ptes
      zap_present_folio_ptes
        __tlb_remove_folio_pages
          __tlb_remove_folio_pages_size
            tlb_next_batch
  arch_leave_lazy_mmu_mode

tlb_next_batch() may call into the page allocator which is problematic
with CONFIG_DEBUG_PAGEALLOC because debug_pagealloc_[un]map_pages()
calls the arch implementation of __kernel_map_pages() which must modify
the ptes for the linear map.

There are two possibilities at this point:

- If the arch implementation modifies the ptes directly without first
  entering lazy mmu mode, the pte modifications may get deferred until
  the existing lazy mmu mode is exited. This could result in taking
  spurious faults for example.

- If the arch implementation enters a nested lazy mmu mode before
  modification of the ptes (many arches use apply_to_page_range()),
  then the linear map updates will definitely be applied upon leaving
  the inner lazy mmu mode. But because lazy mmu mode does not support
  nesting, the remainder of the outer user is no longer in lazy mmu
  mode and the optimization opportunity is lost.

So let's just ensure that the page allocator is never called from within
lazy mmu mode. Use the new arch_in_lazy_mmu_mode() API to check if we
are in lazy mmu mode, and if so, when calling into the page allocator,
temporarily leave lazy mmu mode.

Given this new API we can also add VM_WARNings to check that we exit
lazy mmu mode when required to ensure the PTEs are actually updated
prior to tlb flushing.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/asm-generic/tlb.h |  2 ++
 mm/mmu_gather.c           | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 88a42973fa47..84fb269b78a5 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -469,6 +469,8 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
 
 static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 {
+	VM_WARN_ON(arch_in_lazy_mmu_mode());
+
 	/*
 	 * Anything calling __tlb_adjust_range() also sets at least one of
 	 * these bits.
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index db7ba4a725d6..0bd1e69b048b 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -18,6 +18,7 @@
 static bool tlb_next_batch(struct mmu_gather *tlb)
 {
 	struct mmu_gather_batch *batch;
+	bool lazy_mmu;
 
 	/* Limit batching if we have delayed rmaps pending */
 	if (tlb->delayed_rmap && tlb->active != &tlb->local)
@@ -32,7 +33,15 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
 	if (tlb->batch_count == MAX_GATHER_BATCH_COUNT)
 		return false;
 
+	lazy_mmu = arch_in_lazy_mmu_mode();
+	if (lazy_mmu)
+		arch_leave_lazy_mmu_mode();
+
 	batch = (void *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+
+	if (lazy_mmu)
+		arch_enter_lazy_mmu_mode();
+
 	if (!batch)
 		return false;
 
@@ -145,6 +154,8 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
 {
 	struct mmu_gather_batch *batch;
 
+	VM_WARN_ON(arch_in_lazy_mmu_mode());
+
 	for (batch = &tlb->local; batch && batch->nr; batch = batch->next)
 		__tlb_batch_free_encoded_pages(batch);
 	tlb->active = &tlb->local;
@@ -154,6 +165,8 @@ static void tlb_batch_list_free(struct mmu_gather *tlb)
 {
 	struct mmu_gather_batch *batch, *next;
 
+	VM_WARN_ON(arch_in_lazy_mmu_mode());
+
 	for (batch = tlb->local.next; batch; batch = next) {
 		next = batch->next;
 		free_pages((unsigned long)batch, 0);
@@ -363,6 +376,8 @@ void tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
 	struct mmu_table_batch **batch = &tlb->batch;
 
+	VM_WARN_ON(arch_in_lazy_mmu_mode());
+
 	if (*batch == NULL) {
 		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 		if (*batch == NULL) {
-- 
2.43.0

