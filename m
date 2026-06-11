Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9500D3BF69C;
	Thu, 11 Jun 2026 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178665; cv=none; b=krK/Hy6qdXIfYfHvNTmfGU7aiP1RvfTyeBxpKNx+nYbKdizr+xdBogGQ/hGmW+UFYKvp2jElDkStUB38yUdGv9OCcMwtK6mn0IAZztpFfk467288YGqoLWYi6SgsBcGU6eeX+ensMCvs1aWk0OSQyggXx9z5awiMcECeBUzi9Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178665; c=relaxed/simple;
	bh=QUx8q27kjKZJDO7m6XKER/7Pxq7rgDpVcxhQfdiql+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RUI3K1lrk6F0xPsm2ow4DxnRriCgEE8wMsxQloiudkOVVfvrpthFVAqv7qgTadiDh0zC6fRARc7vSAPnL8kN6I/c+2ntp6SXkPMx2MNhxEoN8sikWjJgYhGWWfJ20D8SPl7ohlCE9FKza8c3YmCgI0mjLViK52wIXakmaNfb0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkSTzLLK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkSTzLLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C351F00893;
	Thu, 11 Jun 2026 11:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781178664;
	bh=MtJFXmmapZ+SVQ7jqSbbDH4KUUFmDq6LRQqzvI2w5vA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HkSTzLLK2j0OdL+U0vq+q46ivBKJymR1NSUBYntk2QPWjBZaz2WMihOeeYuHWgbd7
	 iPrR2cVJEMpcL0QfVE/2t+nIZB9zpocQvFF1u1ihuiCncwyeLs2jyWcEYExUHtarDZ
	 jZow1Y75zPoS/kAZjZ9xrwzgfAl5XXqxpxp3PI8It7Fl5bCTOIEMVPIZP8cMBdkzgB
	 ac0iTJ7t1c6CITZn97AhViBGLbv1OswAKx8BSu/m46QkFlA+xR3NCsbXxyB2hvd53e
	 XP+4e2VQ+wZ4Q7K/C6YibH2hPskIlKp5/w79fNxZWZJASUOo5fKZURM6jJBSBFNfmX
	 6vJBtYsSKX8dQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 11 Jun 2026 13:50:47 +0200
Subject: [PATCH 1/3] sparc/mm: drop custom pte_clear_not_present_full()
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-clear_not_present_full_ptes-v1-1-49865fc82629@kernel.org>
References: <20260611-clear_not_present_full_ptes-v1-0-49865fc82629@kernel.org>
In-Reply-To: <20260611-clear_not_present_full_ptes-v1-0-49865fc82629@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Peter Zijlstra <peterz@infradead.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

On sparc64, pte_clear_not_present_full() nowadays does a simple
__set_pte_at(). In __set_pte_at() -> maybe_tlb_batch_add(), we check
pte_accessible() to see whether to call tlb_batch_add().

However, non-present PTEs are surely not accessible, so tlb_batch_add()
is never called and the "full" parameter is irrelevant.

Let's drop the helper and just let common code do a pte_clear().

pte_clear() on sparc64 maps to set_pte_at()->set_ptes()->__set_pte_at()
... so it ends up calling the same function, just with "full=0".

Given that "full" is irrelevant, there is no change.

We added pte_clear_not_present_full() for sparc64 in commit 90f08e399d05
("sparc: mmu_gather rework"), and I suspect that it was already not
required back then.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/sparc/include/asm/pgtable_64.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 74ede706fb32..0837ebbc5dce 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -945,10 +945,6 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 #define pte_clear(mm,addr,ptep)		\
 	set_pte_at((mm), (addr), (ptep), __pte(0UL))
 
-#define __HAVE_ARCH_PTE_CLEAR_NOT_PRESENT_FULL
-#define pte_clear_not_present_full(mm,addr,ptep,fullmm)	\
-	__set_pte_at((mm), (addr), (ptep), __pte(0UL), (fullmm))
-
 #ifdef DCACHE_ALIASING_POSSIBLE
 #define __HAVE_ARCH_MOVE_PTE
 #define move_pte(pte, old_addr, new_addr)				\

-- 
2.43.0

