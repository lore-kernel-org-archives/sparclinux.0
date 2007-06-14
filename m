From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Thu, 14 Jun 2007 19:19:12 +0000
Subject: Re: [PATCH] Fix build errors with strict MM checking
Message-Id: <20070614191912.GA14390@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20070612231600.GA8953@palantir8>
In-Reply-To: <20070612231600.GA8953@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jun 12, 2007 at 04:23:15PM -0700, David Miller wrote:
> From: Martin Habets <errandir_news@mph.eclipse.co.uk>
> Date: Wed, 13 Jun 2007 00:16:00 +0100
> 
> > @@ -2137,11 +2137,11 @@ static unsigned long srmmu_pte_to_pgoff(
> >  
> >  static pgprot_t srmmu_pgprot_noncached(pgprot_t prot)
> >  {
> > -	prot &= ~__pgprot(SRMMU_CACHE);
> > +	pgprot_val(prot) &= ~SRMMU_CACHE;
> >  
> >  	return prot;
> >  }
> 
> This patch doesn't apply cleanly, and it's because of this hunk.
> 
> The patch hunk says that there should be "11" lines in both
> the before and after, but there are only 7.
> 
> Please try to apply the patches your submit unless you
> can ensure that all of your patches are perfect without
> checking :-)

Sorry for that. Not sure what happened, no other code changes in that hunk.
New diff below.

> Also, I wouldn't run a kernel with strict MM checking on, it's
> at best a compile time check and it causes the code output a lot,
> PTE's and PGD's etc. get passed on the stack when given as
> parameters to functions instead of in registers, and many
> optimizations get disabled in the compiler because these
> things are now structures instead of simple integers.
> 
> That's why it's off by default.

I understand it slows down things a lot. Do you mean it has no
run-time value when debugging suspected MM problems? I do get
different output: unhandled paging request with strict MM checking
versus a DMA error without.

Now for the new patch attempt:

Turning on STRICT_MM_TYPECHECKS in include/asm/page.h causes some
build errors for sparc32. This patch against 2.6.21 fixes these.

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

--- linux/arch/sparc/mm/srmmu.c.orig	2007-06-06 23:26:13.000000000 +0100
+++ linux/arch/sparc/mm/srmmu.c	2007-06-14 20:03:47.000000000 +0100
@@ -226,10 +226,10 @@
 
 /* XXX should we hyper_flush_whole_icache here - Anton */
 static inline void srmmu_ctxd_set(ctxd_t *ctxp, pgd_t *pgdp)
-{ srmmu_set_pte((pte_t *)ctxp, (SRMMU_ET_PTD | (__nocache_pa((unsigned long) pgdp) >> 4))); }
+{ srmmu_set_pte((pte_t *)ctxp, __pte(SRMMU_ET_PTD | (__nocache_pa((unsigned long) pgdp) >> 4))); }
 
 static inline void srmmu_pgd_set(pgd_t * pgdp, pmd_t * pmdp)
-{ srmmu_set_pte((pte_t *)pgdp, (SRMMU_ET_PTD | (__nocache_pa((unsigned long) pmdp) >> 4))); }
+{ srmmu_set_pte((pte_t *)pgdp, __pte(SRMMU_ET_PTD | (__nocache_pa((unsigned long) pmdp) >> 4))); }
 
 static void srmmu_pmd_set(pmd_t *pmdp, pte_t *ptep)
 {
@@ -238,7 +238,7 @@
 
 	ptp = __nocache_pa((unsigned long) ptep) >> 4;
 	for (i = 0; i < PTRS_PER_PTE/SRMMU_REAL_PTRS_PER_PTE; i++) {
-		srmmu_set_pte((pte_t *)&pmdp->pmdv[i], SRMMU_ET_PTD | ptp);
+		srmmu_set_pte((pte_t *)&pmdp->pmdv[i], __pte(SRMMU_ET_PTD | ptp));
 		ptp += (SRMMU_REAL_PTRS_PER_PTE*sizeof(pte_t) >> 4);
 	}
 }
@@ -250,7 +250,7 @@
 
 	ptp = page_to_pfn(ptep) << (PAGE_SHIFT-4);	/* watch for overflow */
 	for (i = 0; i < PTRS_PER_PTE/SRMMU_REAL_PTRS_PER_PTE; i++) {
-		srmmu_set_pte((pte_t *)&pmdp->pmdv[i], SRMMU_ET_PTD | ptp);
+		srmmu_set_pte((pte_t *)&pmdp->pmdv[i], __pte(SRMMU_ET_PTD | ptp));
 		ptp += (SRMMU_REAL_PTRS_PER_PTE*sizeof(pte_t) >> 4);
 	}
 }
@@ -2137,7 +2137,7 @@
 
 static pgprot_t srmmu_pgprot_noncached(pgprot_t prot)
 {
-	prot &= ~__pgprot(SRMMU_CACHE);
+	pgprot_val(prot) &= ~SRMMU_CACHE;
 
 	return prot;
 }
