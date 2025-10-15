Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251022E2DFE;
	Wed, 15 Oct 2025 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516875; cv=none; b=KlpA7I/PBLLCiE0tpElw0h0ZBaAcaIXEU1XOzJiBNKYg80Q86Y1sz32nnk/YqAjwhOgTOmhBPSnzZc0jUI20BhFmGhc1pZ7dpuINdWJZAQbtDWssnM7A/vjsB709pw+yfyAmyaoiACEHbiIqlrOA+z9DsXFFTn+3//FB746Lddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516875; c=relaxed/simple;
	bh=25flPjRMXR8LYUKwJe0iy9R5OTqX6GUkNayOQ1le2Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsVATBndNdWagk96g3fKZl44ieOqk5CkfZQsRJthttfsfR0rOviB7gwXBXAAaL9GGAoXt5fDTsESYrFAzS0fUOZVRN+1RYxQxclFjVq3ZaF9pnBpBeD0sGlBYnvAOo0xKfRbzNDwUq8NsYNBRYdfsAE3Fy2uNDjv/N7OQf8NkLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 968DD22EA;
	Wed, 15 Oct 2025 01:27:45 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 400C13F66E;
	Wed, 15 Oct 2025 01:27:48 -0700 (PDT)
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
Subject: [PATCH v3 02/13] x86/xen: simplify flush_lazy_mmu()
Date: Wed, 15 Oct 2025 09:27:16 +0100
Message-ID: <20251015082727.2395128-3-kevin.brodsky@arm.com>
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

arch_flush_lazy_mmu_mode() is called when outstanding batched
pgtable operations must be completed immediately. There should
however be no need to leave and re-enter lazy MMU completely. The
only part of that sequence that we really need is xen_mc_flush();
call it directly.

While at it, we can also avoid preempt_disable() if we are not
in lazy MMU mode - xen_get_lazy_mode() should tolerate preemption.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/x86/xen/mmu_pv.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 2a4a8deaf612..dcb7b0989c32 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2137,14 +2137,11 @@ static void xen_enter_lazy_mmu(void)
 
 static void xen_flush_lazy_mmu(void)
 {
-	preempt_disable();
-
 	if (xen_get_lazy_mode() == XEN_LAZY_MMU) {
-		arch_leave_lazy_mmu_mode();
-		arch_enter_lazy_mmu_mode();
+		preempt_disable();
+		xen_mc_flush();
+		preempt_enable();
 	}
-
-	preempt_enable();
 }
 
 static void __init xen_post_allocator_init(void)
-- 
2.47.0

