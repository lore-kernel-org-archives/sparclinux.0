From: David Miller <davem@davemloft.net>
Date: Mon, 28 Jul 2014 23:29:43 +0000
Subject: Re: [PATCH] Installing invalid entries in TSB causes hard lockup on UltraSPARC III
Message-Id: <20140728.162943.682999283220326014.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201407271626.41251.cat.schulze@alice-dsl.net>
In-Reply-To: <201407271626.41251.cat.schulze@alice-dsl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 27 Jul 2014 16:26:40 +0200

> With recent kernels, hard lockups are observed by many users of (at least)
> UltraSPARC III based systems. In most cases, users report that these lockups
> occur when heavy disk I/O load is placed on the system. Uniprocessor systems
> become totally unresponsive and will not output any diagnostic information,
> on SMP systems a second CPU might detect that its sibling encountered a lockup
> and complain about this in the syslog. The diagnostics provided on SMP systems
> seem to indicate that the affected CPU has vector interrupts disabled, i.e.
> %PSTATE.IE seems to be set to 0, so that this CPU also does not respond to CPU
> cross calls anymore (in other words, this lockup is not caused by %PIL set
> to a sufficiently high value).
> 
> My analysis showed that this is caused by a tight cycle in TLB miss trap handling.

Good find.

Definitely, loading a non-valid PTE into the TSB will cause lots of problems.
First, it will create this tight loop.  Second, it will cause that invalid
PTE to stay in the TSB even when the valid bit gets set later, because the
code in set_pte_at() doesn't flush anything if the PTE did not previously
have the valid bit set.

> Please note that this patch only cures the symptoms of the problem, and does
> so in a very conservative way. It might also be possible to just set VALID
> to 1 in the PTE value provided to tsb_insert(). As I unfortunately do not have
> access to the affected machine any more since July 1st, I was unable to test more
> advanced strategies.

We definitely do not want to force the bit to be set, we want a full fault to
be taken if the user accesses this page.

Let's move the check higher into the call chain, so that we don't take the
locks or anything in this case, something like:

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 16b58ff..8e894e0 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -351,6 +351,10 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *
 
 	mm = vma->vm_mm;
 
+	/* Don't insert a non-valid PTE into the TSB, we'll deadlock.  */
+	if (!pte_accessible(mm, pte))
+		return;
+
 	spin_lock_irqsave(&mm->context.lock, flags);
 
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
@@ -2617,6 +2621,10 @@ void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (!pmd_large(entry) || !pmd_young(entry))
 		return;
 
+	/* Don't insert a non-valid PMD into the TSB, we'll deadlock.  */
+	if (!(pte & _PAGE_VALID))
+		return;
+
 	pte = pmd_val(entry);
 
 	/* We are fabricating 8MB pages using 4MB real hw pages.  */
