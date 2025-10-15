Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44903164BC;
	Wed, 15 Oct 2025 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516939; cv=none; b=FgLZtAirfgjJJWXpcsfmFxBLZM1NQRW3Uz9jZIXvwfdwpVNLvmzsZim3+yZrtXEd4QG9+r42t4oUmd5kbEmv4kv5FNxY9SvgvPhIkCVH5XCrfDcLzUWgwAIwSffyWSZM0MnJOiwx9Tlh8CNjTN22tQ8EiZYs8U3igmjIvYA1vBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516939; c=relaxed/simple;
	bh=M77QWUN/jEy7GV0PX15SUQmE6yW+sHmw/oAAt9yFBko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mk9shqH/VZ2qt0oICfx2JVjaDuZztNFIOMoXZ4998W/AGe3YIUTYDhO+IGT0EgNz1Axqp1D4ANl2OS+saUa4GYy3Nr3aVMJx0AQQcAJ6ZBNvqENRZqsZZQ3GNUGq8oLmJgrUz56/1Eaz2k39lBiUstUzEATQPnonp8ZbgLOx9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3A1E2379;
	Wed, 15 Oct 2025 01:28:44 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF2653F66E;
	Wed, 15 Oct 2025 01:28:47 -0700 (PDT)
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
Subject: [PATCH v3 13/13] mm: introduce arch_wants_lazy_mmu_mode()
Date: Wed, 15 Oct 2025 09:27:27 +0100
Message-ID: <20251015082727.2395128-14-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251015082727.2395128-1-kevin.brodsky@arm.com>
References: <20251015082727.2395128-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

powerpc decides at runtime whether the lazy MMU mode should be used.

To avoid the overhead associated with managing
task_struct::lazy_mmu_state if the mode isn't used, introduce
arch_wants_lazy_mmu_mode() and bail out of lazy_mmu_mode_* if it
returns false. Add a default definition returning true, and an
appropriate implementation for powerpc.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
This patch seemed like a good idea to start with, but now I'm not so
sure that the churn added to the generic layer is worth it.

It provides a minor optimisation for just powerpc. x86 with XEN_PV also
chooses at runtime whether to implement lazy_mmu helpers or not, but
it doesn't fit this API so neatly and isn't handled here.
---
 .../include/asm/book3s/64/tlbflush-hash.h        | 11 ++++++-----
 include/linux/pgtable.h                          | 16 ++++++++++++----
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
index bbc54690d374..a91b354cf87c 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
@@ -23,10 +23,14 @@ DECLARE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
 
 extern void __flush_tlb_pending(struct ppc64_tlb_batch *batch);
 
+#define arch_wants_lazy_mmu_mode arch_wants_lazy_mmu_mode
+static inline bool arch_wants_lazy_mmu_mode(void)
+{
+	return !radix_enabled();
+}
+
 static inline void arch_enter_lazy_mmu_mode(void)
 {
-	if (radix_enabled())
-		return;
 	/*
 	 * apply_to_page_range can call us this preempt enabled when
 	 * operating on kernel page tables.
@@ -46,9 +50,6 @@ static inline void arch_flush_lazy_mmu_mode(void)
 
 static inline void arch_leave_lazy_mmu_mode(void)
 {
-	if (radix_enabled())
-		return;
-
 	arch_flush_lazy_mmu_mode();
 	preempt_enable();
 }
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 718c9c788114..db4f388d2a16 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -261,11 +261,19 @@ static inline int pmd_dirty(pmd_t pmd)
  * currently enabled.
  */
 #ifdef CONFIG_ARCH_LAZY_MMU
+
+#ifndef arch_wants_lazy_mmu_mode
+static inline bool arch_wants_lazy_mmu_mode(void)
+{
+	return true;
+}
+#endif
+
 static inline void lazy_mmu_mode_enable(void)
 {
 	struct lazy_mmu_state *state = &current->lazy_mmu_state;
 
-	if (in_interrupt())
+	if (!arch_wants_lazy_mmu_mode() || in_interrupt())
 		return;
 
 	VM_BUG_ON(state->count == U8_MAX);
@@ -283,7 +291,7 @@ static inline void lazy_mmu_mode_disable(void)
 {
 	struct lazy_mmu_state *state = &current->lazy_mmu_state;
 
-	if (in_interrupt())
+	if (!arch_wants_lazy_mmu_mode() || in_interrupt())
 		return;
 
 	VM_BUG_ON(state->count == 0);
@@ -303,7 +311,7 @@ static inline void lazy_mmu_mode_pause(void)
 {
 	struct lazy_mmu_state *state = &current->lazy_mmu_state;
 
-	if (in_interrupt())
+	if (!arch_wants_lazy_mmu_mode() || in_interrupt())
 		return;
 
 	VM_WARN_ON(state->count == 0 || !state->enabled);
@@ -316,7 +324,7 @@ static inline void lazy_mmu_mode_resume(void)
 {
 	struct lazy_mmu_state *state = &current->lazy_mmu_state;
 
-	if (in_interrupt())
+	if (!arch_wants_lazy_mmu_mode() || in_interrupt())
 		return;
 
 	VM_WARN_ON(state->count == 0 || state->enabled);
-- 
2.47.0

