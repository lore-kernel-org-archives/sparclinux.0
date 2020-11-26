From: Will Deacon <will@kernel.org>
Date: Thu, 26 Nov 2020 14:32:50 +0000
Subject: Re: [PATCH v2 4/6] arm64/mm: Implement pXX_leaf_size() support
Message-Id: <20201126143249.GA18344@willie-the-truck>
List-Id: <sparclinux.vger.kernel.org>
References: <20201126120114.071913521@infradead.org>
 <20201126121121.226210959@infradead.org>
 <20201126125747.GG2414@hirez.programming.kicks-ass.net>
In-Reply-To: <20201126125747.GG2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, eranian@google.com, christophe.leroy@csgroup.eu, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, willy@infradead.org, aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org, davem@davemloft.net, catalin.marinas@arm.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, dave.hansen@intel.com, kirill.shutemov@linux.intel.com

On Thu, Nov 26, 2020 at 01:57:47PM +0100, Peter Zijlstra wrote:
> 
> Now with pmd_cont() defined...
> 
> ---
> Subject: arm64/mm: Implement pXX_leaf_size() support
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri Nov 13 11:46:06 CET 2020
> 
> ARM64 has non-pagetable aligned large page support with PTE_CONT, when
> this bit is set the page is part of a super-page. Match the hugetlb
> code and support these super pages for PTE and PMD levels.
> 
> This enables PERF_SAMPLE_{DATA,CODE}_PAGE_SIZE to report accurate
> pagetable leaf sizes.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm64/include/asm/pgtable.h |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -407,6 +407,7 @@ static inline int pmd_trans_huge(pmd_t p
>  #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
>  #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
>  #define pmd_valid(pmd)		pte_valid(pmd_pte(pmd))
> +#define pmd_cont(pmd)		pte_cont(pmd_pte(pmd))
>  #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
>  #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
>  #define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
> @@ -503,6 +504,9 @@ extern pgprot_t phys_mem_access_prot(str
>  				 PMD_TYPE_SECT)
>  #define pmd_leaf(pmd)		pmd_sect(pmd)
>  
> +#define pmd_leaf_size(pmd)	(pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
> +#define pte_leaf_size(pte)	(pte_cont(pte) ? CONT_PTE_SIZE : PAGE_SIZE)
> +
>  #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
>  static inline bool pud_sect(pud_t pud) { return false; }
>  static inline bool pud_table(pud_t pud) { return true; }

Acked-by: Will Deacon <will@kernel.org>

I'm still highly dubious about the utility of this feature in perf, since
the TLB entry size is pretty much independent of the page-table
configuration, but that's a problem for all architectures I suspect.

Will
