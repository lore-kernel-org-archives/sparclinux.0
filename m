From: David Miller <davem@davemloft.net>
Date: Wed, 30 Jul 2014 22:07:22 +0000
Subject: Re: sparc64 WARNING: at mm/mmap.c:2757 exit_mmap+0x13c/0x160()
Message-Id: <20140730.150722.861254999466992321.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1404170119550.20193@math.ut.ee>
	<20140729.162635.638786990787878495.davem@davemloft.net>
	<alpine.SOC.1.00.1407310101550.2065@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1407310101550.2065@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: aaro.koskinen@iki.fi, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, hughd@google.com, cat.schulze@alice-dsl.net

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 31 Jul 2014 01:02:53 +0300 (EEST)

>> Here is something I'd like you guys to test.
> 
> Very interesting.
> 
> [...]
>> Could you guys please try this patch below?  Thanks.
> 
>   CC      arch/sparc/mm/init_64.o
> arch/sparc/mm/init_64.c: In function 'update_mmu_cache_pmd':
> arch/sparc/mm/init_64.c:2625:6: error: 'pte' may be used uninitialized in this function [-Werror=uninitialized]
> 
> gcc 4.6.4.

I'm very disappointed that gcc-4.6.3 didn't say anything to me about
this :-)

Here is a fixed patch, thanks.

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 16b58ff..db5ddde 100644
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
@@ -2619,6 +2623,10 @@ void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 	pte = pmd_val(entry);
 
+	/* Don't insert a non-valid PMD into the TSB, we'll deadlock.  */
+	if (!(pte & _PAGE_VALID))
+		return;
+
 	/* We are fabricating 8MB pages using 4MB real hw pages.  */
 	pte |= (addr & (1UL << REAL_HPAGE_SHIFT));
 
