Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774C62E1F00;
	Wed, 29 Oct 2025 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732640; cv=none; b=rcnrr15TkSgGbu2oDwuFACe4lswuGtfpTMa7aCxHPgt2KiWTWsS6VliP5zQT5Rsr3DuFMxrbDAbjyT4geVKnuhEeFdVtIyqJTg5aZhZjZ6jWSpC3J+pvJq0WS4U9MTfiFdhnmxW3l9t1jT+ctzUOI/1+IC1oRFey16CcAtk2Qvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732640; c=relaxed/simple;
	bh=UuQ3ktXA8MimPt4JwTCKHkQFzTgSkjNDhXLKB99RxAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/BVDTte53I+PxRyhbkCFa3AtPm7a8zp3pPHVQNq9nOPXHizzjeToUoWWKQGP6GL7OkYKODZu1Md9jGe8ARLeMagyUIheX5wpM3YumOcm5FqskzuJuGpvMxoHurgbzuBYF/hll+TJjJoKfkVSgkAM9+jHgz+D+g2sHFw75eC3GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECC152BCC;
	Wed, 29 Oct 2025 03:10:30 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DACF93F66E;
	Wed, 29 Oct 2025 03:10:33 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>,
	Juergen Gross <jgross@suse.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	x86@kernel.org
Subject: [PATCH v4 09/12] powerpc/mm: replace batch->active with in_lazy_mmu_mode()
Date: Wed, 29 Oct 2025 10:09:06 +0000
Message-ID: <20251029100909.3381140-10-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251029100909.3381140-1-kevin.brodsky@arm.com>
References: <20251029100909.3381140-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A per-CPU batch struct is activated when entering lazy MMU mode; its
lifetime is the same as the lazy MMU section (it is deactivated when
leaving the mode). Preemption is disabled in that interval to ensure
that the per-CPU reference remains valid.

The generic lazy_mmu layer now tracks whether a task is in lazy MMU
mode. We can therefore use the generic helper in_lazy_mmu_mode()
to tell whether a batch struct is active instead of tracking it
explicitly.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h | 9 ---------
 arch/powerpc/mm/book3s64/hash_tlb.c                | 2 +-
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
index 623a8a8b2d0e..bbc54690d374 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
@@ -12,7 +12,6 @@
 #define PPC64_TLB_BATCH_NR 192
 
 struct ppc64_tlb_batch {
-	int			active;
 	unsigned long		index;
 	struct mm_struct	*mm;
 	real_pte_t		pte[PPC64_TLB_BATCH_NR];
@@ -26,8 +25,6 @@ extern void __flush_tlb_pending(struct ppc64_tlb_batch *batch);
 
 static inline void arch_enter_lazy_mmu_mode(void)
 {
-	struct ppc64_tlb_batch *batch;
-
 	if (radix_enabled())
 		return;
 	/*
@@ -35,8 +32,6 @@ static inline void arch_enter_lazy_mmu_mode(void)
 	 * operating on kernel page tables.
 	 */
 	preempt_disable();
-	batch = this_cpu_ptr(&ppc64_tlb_batch);
-	batch->active = 1;
 }
 
 static inline void arch_flush_lazy_mmu_mode(void)
@@ -51,14 +46,10 @@ static inline void arch_flush_lazy_mmu_mode(void)
 
 static inline void arch_leave_lazy_mmu_mode(void)
 {
-	struct ppc64_tlb_batch *batch;
-
 	if (radix_enabled())
 		return;
-	batch = this_cpu_ptr(&ppc64_tlb_batch);
 
 	arch_flush_lazy_mmu_mode();
-	batch->active = 0;
 	preempt_enable();
 }
 
diff --git a/arch/powerpc/mm/book3s64/hash_tlb.c b/arch/powerpc/mm/book3s64/hash_tlb.c
index 787f7a0e27f0..72b83f582b6d 100644
--- a/arch/powerpc/mm/book3s64/hash_tlb.c
+++ b/arch/powerpc/mm/book3s64/hash_tlb.c
@@ -100,7 +100,7 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 	 * Check if we have an active batch on this CPU. If not, just
 	 * flush now and return.
 	 */
-	if (!batch->active) {
+	if (!in_lazy_mmu_mode()) {
 		flush_hash_page(vpn, rpte, psize, ssize, mm_is_thread_local(mm));
 		put_cpu_var(ppc64_tlb_batch);
 		return;
-- 
2.47.0

