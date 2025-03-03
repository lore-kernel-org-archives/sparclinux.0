Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D61A213E6D;
	Mon,  3 Mar 2025 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011363; cv=none; b=gHBAKENZOB5yg0+f1e1LXfwM8TVPmcBhHFgmsLW//JL/69Pk3fvmZvE/tu/dLLtzli5LRYS4hQvsd/CdnKpF79x7YivCT7YG9uE3aORmWiZs3Pu4gzwV3BYZyZWTYECOuBbKoceRKoPs84vHKPWSVe4SrgGm/4AykUy4DvYxkzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011363; c=relaxed/simple;
	bh=O1B5GF7HpAL9qkxPKYum4yHYGnfftCWSle9YRrd7K/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kz1/HghxvDbj5NnOj1r0a9L8vNpdcslaIOt9ec6xLgSzJ4n6+r8nabXHsYm+Sj8F1bTY3zwZc5iJwUotrUKBgpsIivuxCIUHbA5KBCIGJ07tPtm68ncqRoSNmMCP+t/J9LNhNyM2mEXG5/4W8vdDAXEpzt229EyNoKku1dlDMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 865D01BCA;
	Mon,  3 Mar 2025 06:16:15 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48FF23F66E;
	Mon,  3 Mar 2025 06:15:59 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 3/5] sparc/mm: Disable preemption in lazy mmu mode
Date: Mon,  3 Mar 2025 14:15:37 +0000
Message-ID: <20250303141542.3371656-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303141542.3371656-1-ryan.roberts@arm.com>
References: <20250303141542.3371656-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 38e0edb15bd0 ("mm/apply_to_range: call pte function with
lazy updates") it's been possible for arch_[enter|leave]_lazy_mmu_mode()
to be called without holding a page table lock (for the kernel mappings
case), and therefore it is possible that preemption may occur while in
the lazy mmu mode. The Sparc lazy mmu implementation is not robust to
preemption since it stores the lazy mode state in a per-cpu structure
and does not attempt to manage that state on task switch.

Powerpc had the same issue and fixed it by explicitly disabling
preemption in arch_enter_lazy_mmu_mode() and re-enabling in
arch_leave_lazy_mmu_mode(). See commit b9ef323ea168 ("powerpc/64s:
Disable preemption in hash lazy mmu mode").

Given Sparc's lazy mmu mode is based on powerpc's, let's fix it in the
same way here.

Cc: <stable@vger.kernel.org>
Fixes: 38e0edb15bd0 ("mm/apply_to_range: call pte function with lazy updates")
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/sparc/mm/tlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 8648a50afe88..a35ddcca5e76 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -52,8 +52,10 @@ void flush_tlb_pending(void)
 
 void arch_enter_lazy_mmu_mode(void)
 {
-	struct tlb_batch *tb = this_cpu_ptr(&tlb_batch);
+	struct tlb_batch *tb;
 
+	preempt_disable();
+	tb = this_cpu_ptr(&tlb_batch);
 	tb->active = 1;
 }
 
@@ -64,6 +66,7 @@ void arch_leave_lazy_mmu_mode(void)
 	if (tb->tlb_nr)
 		flush_tlb_pending();
 	tb->active = 0;
+	preempt_enable();
 }
 
 static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
-- 
2.43.0

