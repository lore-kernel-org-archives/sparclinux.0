Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978B522ACD1;
	Fri, 30 May 2025 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748613919; cv=none; b=UepbqLNgtLQbphWYs6wiZvChnOE8Bze5ubF0v5p0jCUJZHb8kKybSVObQQGsEOCevaLqGXfSlP9TvOvMxPvZGFWrgziEVfH4ryfGxGoAPslmou5A9bwFXUBY2pclZExlA7Cm0I3GDjRql/gUA7PhlIAbaz/c4AvB2Rl5jc4DxpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748613919; c=relaxed/simple;
	bh=I5HloKLMfWzlXiU6e/59qP+RTyrUsp4/b4lMuSl4vQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HI5kECNojqx3rogmDA73DFLDk6MyyLg+kMtcYFaH170G54GPzuvSwM7ogrya3nr5yaX1j89XUPwkyfL6EAHz4/+sN2UIkU1Z1fHIEm71MO1+a6BK5/Q2+Xz6W4SgLG1haosiIaqnt9lnmOuJ2sP+VEV8TbB93VyiavOv1nsa3Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23F3F2247;
	Fri, 30 May 2025 07:04:59 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DD213F673;
	Fri, 30 May 2025 07:05:10 -0700 (PDT)
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
Subject: [RFC PATCH v1 2/6] mm: Fix pte update and tlb maintenance ordering in migrate_vma_collect_pmd()
Date: Fri, 30 May 2025 15:04:40 +0100
Message-ID: <20250530140446.2387131-3-ryan.roberts@arm.com>
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

migrate_vma_collect_pmd() was previously modifying ptes while in lazy
mmu mode, then performing tlb maintenance for the modified ptes, then
leaving lazy mmu mode. But any pte modifications during lazy mmu mode
may be deferred until arch_leave_lazy_mmu_mode(), inverting the required
ordering between pte modificaiton and tlb maintenance.

Let's fix that by leaving mmu mode (forcing all the pte updates to be
actioned) before doing the tlb maintenance.

This is a theorectical bug discovered during code review.

Fixes: 60bae7370896 ("mm/migrate_device.c: flush TLB while holding PTL")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/migrate_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 3158afe7eb23..fc73a940c112 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -283,11 +283,12 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		migrate->src[migrate->npages++] = mpfn;
 	}
 
+	arch_leave_lazy_mmu_mode();
+
 	/* Only flush the TLB if we actually modified any entries */
 	if (unmapped)
 		flush_tlb_range(walk->vma, start, end);
 
-	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(ptep - 1, ptl);
 
 	return 0;
-- 
2.43.0

