Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDAD1E8335;
	Sun,  2 Mar 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740927376; cv=none; b=eBWZQprmkW0ZKepjtAKX4bwqystKZbEU978D7QsQ3Ty+EuHYHMjMBqJoI7ZP2i7nWp4L8WUT8UTr8p4pc5KbMRssSRD4E3u6m0x8Frv8p+8ldVmzIAMI2xnuM5I7vwK9HkJXpjjM+ZQUxMBLfm3aiLfp6qWIYTdMfw1/mFwox/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740927376; c=relaxed/simple;
	bh=c6ehuWdLcz3BYdrGIyVmrDosVO/BPD7S+ggVt1CrEQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pm0zWub+RlclfXaGFBbueAAB9NOxYSCOEwFZXOYMZU9qpFzSUAfias5Kgkwk1JxkUnl7QPoVPdtIo/f6oCuk1St0E26oT7+j6O/m7FlRM2eJLedTMKOW9U13qCk7ZA0qe7W4bxxwNhpgtERi8tWpRiNXYbiV4IUAZuEoKrejKl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A5BE13D5;
	Sun,  2 Mar 2025 06:56:28 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B5213F5A1;
	Sun,  2 Mar 2025 06:56:11 -0800 (PST)
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
Subject: [PATCH v1 2/4] sparc/mm: Disable preemption in lazy mmu mode
Date: Sun,  2 Mar 2025 14:55:52 +0000
Message-ID: <20250302145555.3236789-3-ryan.roberts@arm.com>
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

Fixes: 38e0edb15bd0 ("mm/apply_to_range: call pte function with lazy updates")
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

