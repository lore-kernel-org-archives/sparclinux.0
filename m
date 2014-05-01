From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 01 May 2014 16:17:02 +0000
Subject: Re: [PATCH 09/10] sparc64: Add basic validations to {pud,pmd}_bad().
Message-Id: <20140501161702.GA17134@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20140430.175556.65359624693463383.davem@davemloft.net>
In-Reply-To: <20140430.175556.65359624693463383.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 30, 2014 at 05:55:56PM -0400, David Miller wrote:
> 
> Instead of returning false we should at least check the most basic
> things, otherwise page table corruptions will be very difficult to
> debug.
> 
> PMD and PTE tables are of size PAGE_SIZE, so none of the sub-PAGE_SIZE
> bits should be set.
> 
> We also complement this with a check that the physical address the
> pud/pmd points to is valid memory.
> 
> PowerPC was used as a guide while implementating this.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/include/asm/pgtable_64.h | 46 +++++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index ff97960..fd4dbdd 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -71,6 +71,23 @@
>  
>  #include <linux/sched.h>
>  
> +extern unsigned long sparc64_valid_addr_bitmap[];
> +
> +/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
> +static inline bool __kern_addr_valid(unsigned long paddr)
It would had been self-documenting if the type is changed to phys_addr_t here.
But I see that we do not use phys_addr_t much (only one place) in sparc code today.

> +{
> +	if ((paddr >> MAX_PHYS_ADDRESS_BITS) != 0UL)
> +		return false;
> +	return test_bit(paddr >> 22, sparc64_valid_addr_bitmap);
> +}
I assume it is a coincidence that we have the same block size
in sparc64_valid_addr_bitmapi (22) as we have for REAL_HPAGE_SHIFT.

	Sam
