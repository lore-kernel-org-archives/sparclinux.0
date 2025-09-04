Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F7630496A;
	Thu,  4 Sep 2025 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990722; cv=none; b=ia2P3LQakfZ04CPf2SaDS+ouIXOfKeHYq+s9keRcJpHvJMm8Mxcahtp7SiwfI2CpQhZUgK6ChsRQnDEFWFsOf5t3vI1RkAJJS8gKYrpwhg8gJAnk/lmnVSZDvQWb0/XygRa63E5hMsI0/9sEUgKxZdt7I5WHOknyYuNfT+5aiuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990722; c=relaxed/simple;
	bh=J1/wcjUx9MmIGYpRK2XuavFky8ZRhqkYg87SLB42Ixk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4XWKupdMvj6Lavb7j92LuVPrH4MeERn0Pmq3/sCTqEzcMe8IyUHXbtrHcm8VgCaboythKwz8KlSk3ngABfcNskIgM4kTyq5pOyZJxEDEnYxUYwwfwRjZ1+/TzNwYJUrJjr0tg6kFe6nAGRCMoU0hu2DAWtciex/n8WeUd/O1z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2267F2ECB;
	Thu,  4 Sep 2025 05:58:32 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E64E73F6A8;
	Thu,  4 Sep 2025 05:58:35 -0700 (PDT)
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
Subject: [PATCH 4/7] x86/xen: support nested lazy_mmu sections (again)
Date: Thu,  4 Sep 2025 13:57:33 +0100
Message-ID: <20250904125736.3918646-5-kevin.brodsky@arm.com>
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

Commit 49147beb0ccb ("x86/xen: allow nesting of same lazy mode")
originally introduced support for nested lazy sections (LAZY_MMU and
LAZY_CPU). It later got reverted by commit c36549ff8d84 as its
implementation turned out to be intolerant to preemption.

Now that the lazy_mmu API allows enter() to pass through a state to
the matching leave() call, we can support nesting again for the
LAZY_MMU mode in a preemption-safe manner. If xen_enter_lazy_mmu() is
called inside an active lazy_mmu section, xen_lazy_mode will already
be set to XEN_LAZY_MMU and we can then return LAZY_MMU_NESTED to
instruct the matching xen_leave_lazy_mmu() call to leave
xen_lazy_mode unchanged.

The only effect of this patch is to ensure that xen_lazy_mode
remains set to XEN_LAZY_MMU until the outermost lazy_mmu section
ends. xen_leave_lazy_mmu() still calls xen_mc_flush()
unconditionally.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/x86/include/asm/paravirt.h       |  6 ++----
 arch/x86/include/asm/paravirt_types.h |  4 ++--
 arch/x86/xen/mmu_pv.c                 | 11 ++++++++---
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 65a0d394fba1..4ecd3a6b1dea 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -529,14 +529,12 @@ static inline void arch_end_context_switch(struct task_struct *next)
 #define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
 static inline lazy_mmu_state_t arch_enter_lazy_mmu_mode(void)
 {
-	PVOP_VCALL0(mmu.lazy_mode.enter);
-
-	return LAZY_MMU_DEFAULT;
+	return PVOP_CALL0(lazy_mmu_state_t, mmu.lazy_mode.enter);
 }
 
 static inline void arch_leave_lazy_mmu_mode(lazy_mmu_state_t state)
 {
-	PVOP_VCALL0(mmu.lazy_mode.leave);
+	PVOP_VCALL1(mmu.lazy_mode.leave, state);
 }
 
 static inline void arch_flush_lazy_mmu_mode(void)
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index bc1af86868a3..b7c567ccbf32 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -45,8 +45,8 @@ typedef int lazy_mmu_state_t;
 
 struct pv_lazy_ops {
 	/* Set deferred update mode, used for batching operations. */
-	void (*enter)(void);
-	void (*leave)(void);
+	lazy_mmu_state_t (*enter)(void);
+	void (*leave)(lazy_mmu_state_t);
 	void (*flush)(void);
 } __no_randomize_layout;
 #endif
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 2039d5132ca3..6e5390ff06a5 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2130,9 +2130,13 @@ static void xen_set_fixmap(unsigned idx, phys_addr_t phys, pgprot_t prot)
 #endif
 }
 
-static void xen_enter_lazy_mmu(void)
+static lazy_mmu_state_t xen_enter_lazy_mmu(void)
 {
+	if (this_cpu_read(xen_lazy_mode) == XEN_LAZY_MMU)
+		return LAZY_MMU_NESTED;
+
 	enter_lazy(XEN_LAZY_MMU);
+	return LAZY_MMU_DEFAULT;
 }
 
 static void xen_flush_lazy_mmu(void)
@@ -2167,11 +2171,12 @@ static void __init xen_post_allocator_init(void)
 	pv_ops.mmu.write_cr3 = &xen_write_cr3;
 }
 
-static void xen_leave_lazy_mmu(void)
+static void xen_leave_lazy_mmu(lazy_mmu_state_t state)
 {
 	preempt_disable();
 	xen_mc_flush();
-	leave_lazy(XEN_LAZY_MMU);
+	if (state != LAZY_MMU_NESTED)
+		leave_lazy(XEN_LAZY_MMU);
 	preempt_enable();
 }
 
-- 
2.47.0

