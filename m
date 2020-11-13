From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 13 Nov 2020 11:45:10 +0000
Subject: Re: [PATCH 2/5] mm: Introduce pXX_leaf_size()
Message-Id: <20201113114510.GX2611@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20201113111901.743573013@infradead.org>
 <20201113113426.465239104@infradead.org>
In-Reply-To: <20201113113426.465239104@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, eranian@google.com
Cc: christophe.leroy@csgroup.eu, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org, willy@infradead.org, aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org, davem@davemloft.net, catalin.marinas@arm.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, dave.hansen@intel.com, kirill.shutemov@linux.intel.com

On Fri, Nov 13, 2020 at 12:19:03PM +0100, Peter Zijlstra wrote:
> A number of architectures have non-pagetable aligned huge/large pages.
> For such architectures a leaf can actually be part of a larger TLB
> entry.
> 
> Provide generic helpers to determine the TLB size of a page-table
> leaf.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/pgtable.h |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1536,4 +1536,20 @@ typedef unsigned int pgtbl_mod_mask;
>  #define pmd_leaf(x)	0
>  #endif
>  
> +#ifndef pgd_leaf_size
> +#define pgd_leaf_size(x) PGD_SIZE

Argh, I lost a refresh, that should've been:

+#define pgd_leaf_size(x) (1ULL << PGDIR_SHIFT)


> +#endif
> +#ifndef p4d_leaf_size
> +#define p4d_leaf_size(x) P4D_SIZE
> +#endif
> +#ifndef pud_leaf_size
> +#define pud_leaf_size(x) PUD_SIZE
> +#endif
> +#ifndef pmd_leaf_size
> +#define pmd_leaf_size(x) PMD_SIZE
> +#endif
> +#ifndef pte_leaf_size
> +#define pte_leaf_size(x) PAGE_SIZE
> +#endif
> +
>  #endif /* _LINUX_PGTABLE_H */
> 
> 
