From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 12 Jan 2021 17:01:38 +0000
Subject: [patch 2/4] mm/highmem: Prepare for overriding set_pte_at()
Message-Id: <20210112170411.056306194@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20210112170136.078559026@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andreas Larsson <andreas@gaisler.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org

The generic kmap_local() map function uses set_pte_at(), but MIPS requires
set_pte() and PowerPC wants __set_pte_at().

Provide arch_kmap_local_set_pte() and default it to set_pte_at().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 mm/highmem.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -473,6 +473,11 @@ static inline void *arch_kmap_local_high
 }
 #endif
 
+#ifndef arch_kmap_local_set_pte
+#define arch_kmap_local_set_pte(mm, vaddr, ptep, ptev)	\
+	set_pte_at(mm, vaddr, ptep, ptev)
+#endif
+
 /* Unmap a local mapping which was obtained by kmap_high_get() */
 static inline bool kmap_high_unmap_local(unsigned long vaddr)
 {
@@ -515,7 +520,7 @@ void *__kmap_local_pfn_prot(unsigned lon
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 	BUG_ON(!pte_none(*(kmap_pte - idx)));
 	pteval = pfn_pte(pfn, prot);
-	set_pte_at(&init_mm, vaddr, kmap_pte - idx, pteval);
+	arch_kmap_local_set_pte(&init_mm, vaddr, kmap_pte - idx, pteval);
 	arch_kmap_local_post_map(vaddr, pteval);
 	current->kmap_ctrl.pteval[kmap_local_idx()] = pteval;
 	preempt_enable();
