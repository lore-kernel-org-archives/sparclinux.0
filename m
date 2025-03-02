Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2597B1E5B6D;
	Sun,  2 Mar 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740927374; cv=none; b=OinVgLYQPu+TRKClP54QdRop+he0N/6kRfjPvwYBZWrCUTRFv1aLllxtYd98V//lSN3rOL/cchYa5zu9Fy8htbuYnIrC4+bKXbNjqgVwqWC+VZzUmSW8N+LyjnTFrKFyMZV6jqfgzQG96YibzagDEndX0CdDr+FgMcJGJHOSBRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740927374; c=relaxed/simple;
	bh=CYZmyb+Ao7XAV+bXmksYjtkFzppIf54HpgGpKLcdu3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6gNtp1WadI+IMpSPdOu987ZljJ1ySDuw94OsSdv2xexL6mjCSkcXK1naf9Y/zMGZIaXg+CFZLf0jtdjbvI29Akx6WgX+QqSS4UcKdS8gEeIU0kftvc4LUqlKw9B0ZTN+cCg/LrVwInxPlIm6RjBdShwAodlMCGZk9ho2+mZ4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A14C212FC;
	Sun,  2 Mar 2025 06:56:25 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCBDB3F5A1;
	Sun,  2 Mar 2025 06:56:08 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	sparclinux@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] mm: Fix lazy mmu docs and usage
Date: Sun,  2 Mar 2025 14:55:51 +0000
Message-ID: <20250302145555.3236789-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250302145555.3236789-1-ryan.roberts@arm.com>
References: <20250302145555.3236789-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The docs, implementations and use of arch_[enter|leave]_lazy_mmu_mode()
is a bit of a mess (to put it politely). There are a number of issues
related to nesting of lazy mmu regions and confusion over whether the
task, when in a lazy mmu region, is preemptible or not. Fix all the
issues relating to the core-mm. Follow up commits will fix the
arch-specific implementations. 3 arches implement lazy mmu; powerpc,
sparc and x86.

When arch_[enter|leave]_lazy_mmu_mode() was first introduced by commit
6606c3e0da53 ("[PATCH] paravirt: lazy mmu mode hooks.patch"), it was
expected that lazy mmu regions would never nest and that the appropriate
page table lock(s) would be held while in the region, thus ensuring the
region is non-preemptible. Additionally lazy mmu regions were only used
during manipulation of user mappings.

Commit 38e0edb15bd0 ("mm/apply_to_range: call pte function with lazy
updates") started invoking the lazy mmu mode in apply_to_pte_range(),
which is used for both user and kernel mappings. For kernel mappings the
region is no longer protected by any lock so there is no longer any
guarantee about non-preemptibility. Additionally, for RT configs, the
holding the PTL only implies no CPU migration, it doesn't prevent
preemption.

Commit bcc6cc832573 ("mm: add default definition of set_ptes()") added
arch_[enter|leave]_lazy_mmu_mode() to the default implementation of
set_ptes(), used by x86. So after this commit, lazy mmu regions can be
nested. Additionally commit 1a10a44dfc1d ("sparc64: implement the new
page table range API") and commit 9fee28baa601 ("powerpc: implement the
new page table range API") did the same for the sparc and powerpc
set_ptes() overrides.

powerpc couldn't deal with preemption so avoids it in commit
b9ef323ea168 ("powerpc/64s: Disable preemption in hash lazy mmu mode"),
which explicitly disables preemption for the whole region in its
implementation. x86 can support preemption (or at least it could until
it tried to add support nesting; more on this below). Sparc looks to be
totally broken in the face of preemption, as far as I can tell.

powewrpc can't deal with nesting, so avoids it in commit 47b8def9358c
("powerpc/mm: Avoid calling arch_enter/leave_lazy_mmu() in set_ptes"),
which removes the lazy mmu calls from its implementation of set_ptes().
x86 attempted to support nesting in commit 49147beb0ccb ("x86/xen: allow
nesting of same lazy mode") but as far as I can tell, this breaks its
support for preemption.

In short, it's all a mess; the semantics for
arch_[enter|leave]_lazy_mmu_mode() are not clearly defined and as a
result the implementations all have different expectations, sticking
plasters and bugs.

arm64 is aiming to start using these hooks, so let's clean everything up
before adding an arm64 implementation. Update the documentation to state
that lazy mmu regions can never be nested, must not be called in
interrupt context and preemption may or may not be enabled for the
duration of the region.

Additionally, update the way arch_[enter|leave]_lazy_mmu_mode() is
called in pagemap_scan_pmd_entry() to follow the normal pattern of
holding the ptl for user space mappings. As a result the scope is
reduced to only the pte table, but that's where most of the performance
win is. While I believe there wasn't technically a bug here, the
original scope made it easier to accidentally nest or, worse,
accidentally call something like kmap() which would expect an immediate
mode pte modification but it would end up deferred.

arch-specific fixes to conform to the new spec will proceed this one.

These issues were spotted by code review and I have no evidence of
issues being reported in the wild.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 fs/proc/task_mmu.c      | 11 ++++-------
 include/linux/pgtable.h | 14 ++++++++------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c17615e21a5d..b0f189815512 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2459,22 +2459,19 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
 	spinlock_t *ptl;
 	int ret;
 
-	arch_enter_lazy_mmu_mode();
-
 	ret = pagemap_scan_thp_entry(pmd, start, end, walk);
-	if (ret != -ENOENT) {
-		arch_leave_lazy_mmu_mode();
+	if (ret != -ENOENT)
 		return ret;
-	}
 
 	ret = 0;
 	start_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
 	if (!pte) {
-		arch_leave_lazy_mmu_mode();
 		walk->action = ACTION_AGAIN;
 		return 0;
 	}
 
+	arch_enter_lazy_mmu_mode();
+
 	if ((p->arg.flags & PM_SCAN_WP_MATCHING) && !p->vec_out) {
 		/* Fast path for performing exclusive WP */
 		for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
@@ -2543,8 +2540,8 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
 	if (flush_end)
 		flush_tlb_range(vma, start, addr);
 
-	pte_unmap_unlock(start_pte, ptl);
 	arch_leave_lazy_mmu_mode();
+	pte_unmap_unlock(start_pte, ptl);
 
 	cond_resched();
 	return ret;
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 94d267d02372..787c632ee2c9 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -222,10 +222,14 @@ static inline int pmd_dirty(pmd_t pmd)
  * hazard could result in the direct mode hypervisor case, since the actual
  * write to the page tables may not yet have taken place, so reads though
  * a raw PTE pointer after it has been modified are not guaranteed to be
- * up to date.  This mode can only be entered and left under the protection of
- * the page table locks for all page tables which may be modified.  In the UP
- * case, this is required so that preemption is disabled, and in the SMP case,
- * it must synchronize the delayed page table writes properly on other CPUs.
+ * up to date.
+ *
+ * In the general case, no lock is guaranteed to be held between entry and exit
+ * of the lazy mode. So the implementation must assume preemption may be enabled
+ * and cpu migration is possible; it must take steps to be robust against this.
+ * (In practice, for user PTE updates, the appropriate page table lock(s) are
+ * held, but for kernel PTE updates, no lock is held). Nesting is not permitted
+ * and the mode cannot be used in interrupt context.
  */
 #ifndef __HAVE_ARCH_ENTER_LAZY_MMU_MODE
 #define arch_enter_lazy_mmu_mode()	do {} while (0)
@@ -287,7 +291,6 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 {
 	page_table_check_ptes_set(mm, ptep, pte, nr);
 
-	arch_enter_lazy_mmu_mode();
 	for (;;) {
 		set_pte(ptep, pte);
 		if (--nr == 0)
@@ -295,7 +298,6 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		ptep++;
 		pte = pte_next_pfn(pte);
 	}
-	arch_leave_lazy_mmu_mode();
 }
 #endif
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
-- 
2.43.0

