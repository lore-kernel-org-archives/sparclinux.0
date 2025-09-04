Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937F72FFDDD;
	Thu,  4 Sep 2025 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990731; cv=none; b=livHMqbdIacYubIstGoeRcziV7fenpYxKtCC7L+EOTXBukJCNHM2UC+Fx7QJ08sCjHaR1B/54T+4+E4lNpkUwvW16d4KXIidxH9XQG+hG6IPf7799wttuURqEuRpyVaj0I0DTlvXWakSz+7hjVLqs+G12ZHMo0L/ZShjaYstV94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990731; c=relaxed/simple;
	bh=FfFahPfq5+SssMH1K9ICxs3Ni8XAHBJVYKTrFIbUjoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahDr8P/zqzTDw8w8Dny5lD30H4ymtpH2FzXmKa3286eQlfxcER+3GZXJSnIOC/YpXl5erGohUo6dROgAFrxeSZSxm+2XZmEaUADKvnndgSifGW+Z4wpzusw5WLgiyuNAxpIVZaOj0jk4EqyAjqtUOyn6o8+DKKMR3K4/MeKWUMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD01C2F27;
	Thu,  4 Sep 2025 05:58:41 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C1D63F6A8;
	Thu,  4 Sep 2025 05:58:45 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH 6/7] sparc/mm: support nested lazy_mmu sections
Date: Thu,  4 Sep 2025 13:57:35 +0100
Message-ID: <20250904125736.3918646-7-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250904125736.3918646-1-kevin.brodsky@arm.com>
References: <20250904125736.3918646-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lazy_mmu API now allows nested sections to be handled by arch
code: enter() can return a flag if called inside another lazy_mmu
section, so that the matching call to leave() leaves any
optimisation enabled.

This patch implements that new logic for sparc: if there is an
active batch, then enter() returns LAZY_MMU_NESTED and the matching
leave() leaves batch->active set. The preempt_{enable,disable} calls
are left untouched as they already handle nesting themselves.

TLB flushing is still done in leave() regardless of the nesting
level, as the caller may rely on it whether nesting is occurring or
not.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/sparc/mm/tlb.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index bf5094b770af..42de93d74d0e 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -53,12 +53,18 @@ void flush_tlb_pending(void)
 lazy_mmu_state_t arch_enter_lazy_mmu_mode(void)
 {
 	struct tlb_batch *tb;
+	int lazy_mmu_nested;
 
 	preempt_disable();
 	tb = this_cpu_ptr(&tlb_batch);
-	tb->active = 1;
+	lazy_mmu_nested = tb->active;
 
-	return LAZY_MMU_DEFAULT;
+	if (!lazy_mmu_nested) {
+		tb->active = 1;
+		return LAZY_MMU_DEFAULT;
+	} else {
+		return LAZY_MMU_NESTED;
+	}
 }
 
 void arch_leave_lazy_mmu_mode(lazy_mmu_state_t state)
@@ -67,7 +73,10 @@ void arch_leave_lazy_mmu_mode(lazy_mmu_state_t state)
 
 	if (tb->tlb_nr)
 		flush_tlb_pending();
-	tb->active = 0;
+
+	if (state != LAZY_MMU_NESTED)
+		tb->active = 0;
+
 	preempt_enable();
 }
 
-- 
2.47.0

