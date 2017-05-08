From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Mon, 08 May 2017 11:36:24 +0000
Subject: Re: [v3 9/9] s390: teach platforms not to zero struct pages memory
Message-Id: <20170508113624.GA4876@osiris>
List-Id: <sparclinux.vger.kernel.org>
References: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
 <1494003796-748672-10-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1494003796-748672-10-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, davem@davemloft.net

On Fri, May 05, 2017 at 01:03:16PM -0400, Pavel Tatashin wrote:
> If we are using deferred struct page initialization feature, most of
> "struct page"es are getting initialized after other CPUs are started, and
> hence we are benefiting from doing this job in parallel. However, we are
> still zeroing all the memory that is allocated for "struct pages" using the
> boot CPU.  This patch solves this problem, by deferring zeroing "struct
> pages" to only when they are initialized on s390 platforms.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  arch/s390/mm/vmem.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index 9c75214..ffe9ba1 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -252,7 +252,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
>  				void *new_page;
>  
>  				new_page = vmemmap_alloc_block(PMD_SIZE, node,
> -							       true);
> +							       VMEMMAP_ZERO);
>  				if (!new_page)
>  					goto out;
>  				pmd_val(*pm_dir) = __pa(new_page) | sgt_prot;

If you add the hunk below then this is

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index ffe9ba1aec8b..bf88a8b9c24d 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -272,7 +272,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 		if (pte_none(*pt_dir)) {
 			void *new_page;
 
-			new_page = vmemmap_alloc_block(PAGE_SIZE, node, true);
+			new_page = vmemmap_alloc_block(PAGE_SIZE, node, VMEMMAP_ZERO);
 			if (!new_page)
 				goto out;
 			pte_val(*pt_dir) = __pa(new_page) | pgt_prot;

