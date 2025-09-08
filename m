Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C69B2ECD3A;
	Mon,  8 Sep 2025 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317251; cv=none; b=b/OoF3L1jfIhBgq91jUzM03ccseWLM3FK3ThlR7xIHwHC+BP6N/SFUUb4hWturR6yuEvRY9oeSdaIqzfK2p8dH2InQvjh2VX0bUNtiiOdN+mtEELaXhJa1KDYx8wyqU6tKHHSdCEk4CmpZPnL8LOrutAlooMrnUdch8X1B/TIek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317251; c=relaxed/simple;
	bh=hkDsOOLYTwNQnHVD2JN+ks+GUnYIcxo3wNnKCrpM0zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTFOqM9avr/ZNqUx8DDvjiJ+eZvATLkKAtVnl+YYKx++EA2iI6hNnnWs5seNwVwjyl5vF9TvCjQBjlWGnofD8KiplzBv4O+0ElzWSuncFo8a3NOCrhfRG/wC5NyjRSUTaMSHkf35EXNNGxWYr7RAdGuF+wWjFV97q7Y8FuTy9Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEDB91764;
	Mon,  8 Sep 2025 00:40:40 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A6C13F63F;
	Mon,  8 Sep 2025 00:40:44 -0700 (PDT)
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
	xen-devel@lists.xenproject.org
Subject: [PATCH v2 3/7] arm64: mm: fully support nested lazy_mmu sections
Date: Mon,  8 Sep 2025 08:39:27 +0100
Message-ID: <20250908073931.4159362-4-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250908073931.4159362-1-kevin.brodsky@arm.com>
References: <20250908073931.4159362-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Despite recent efforts to prevent lazy_mmu sections from nesting, it
remains difficult to ensure that it never occurs - and in fact it
does occur on arm64 in certain situations (CONFIG_DEBUG_PAGEALLOC).
Commit 1ef3095b1405 ("arm64/mm: Permit lazy_mmu_mode to be nested")
made nesting tolerable on arm64, but without truly supporting it:
the inner leave() call clears TIF_LAZY_MMU, disabling the batching
optimisation before the outer section ends.

Now that the lazy_mmu API allows enter() to pass through a state to
the matching leave() call, we can actually support nesting. If
enter() is called inside an active lazy_mmu section, TIF_LAZY_MMU
will already be set, and we can then return LAZY_MMU_NESTED to
instruct the matching leave() call not to clear TIF_LAZY_MMU.

The only effect of this patch is to ensure that TIF_LAZY_MMU (and
therefore the batching optimisation) remains set until the outermost
lazy_mmu section ends. leave() still emits barriers if needed,
regardless of the nesting level, as the caller may expect any
page table changes to become visible when leave() returns.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 816197d08165..602feda97dc4 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -85,24 +85,14 @@ typedef int lazy_mmu_state_t;
 
 static inline lazy_mmu_state_t arch_enter_lazy_mmu_mode(void)
 {
-	/*
-	 * lazy_mmu_mode is not supposed to permit nesting. But in practice this
-	 * does happen with CONFIG_DEBUG_PAGEALLOC, where a page allocation
-	 * inside a lazy_mmu_mode section (such as zap_pte_range()) will change
-	 * permissions on the linear map with apply_to_page_range(), which
-	 * re-enters lazy_mmu_mode. So we tolerate nesting in our
-	 * implementation. The first call to arch_leave_lazy_mmu_mode() will
-	 * flush and clear the flag such that the remainder of the work in the
-	 * outer nest behaves as if outside of lazy mmu mode. This is safe and
-	 * keeps tracking simple.
-	 */
+	int lazy_mmu_nested;
 
 	if (in_interrupt())
 		return LAZY_MMU_DEFAULT;
 
-	set_thread_flag(TIF_LAZY_MMU);
+	lazy_mmu_nested = test_and_set_thread_flag(TIF_LAZY_MMU);
 
-	return LAZY_MMU_DEFAULT;
+	return lazy_mmu_nested ? LAZY_MMU_NESTED : LAZY_MMU_DEFAULT;
 }
 
 static inline void arch_leave_lazy_mmu_mode(lazy_mmu_state_t state)
@@ -113,7 +103,8 @@ static inline void arch_leave_lazy_mmu_mode(lazy_mmu_state_t state)
 	if (test_and_clear_thread_flag(TIF_LAZY_MMU_PENDING))
 		emit_pte_barriers();
 
-	clear_thread_flag(TIF_LAZY_MMU);
+	if (state != LAZY_MMU_NESTED)
+		clear_thread_flag(TIF_LAZY_MMU);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-- 
2.47.0

