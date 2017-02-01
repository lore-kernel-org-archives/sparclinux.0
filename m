From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 01 Feb 2017 16:30:18 +0000
Subject: Re: [PATCH 1/3] sparc64: make tsb pointer computation symbolic
Message-Id: <20170201163018.GA27409@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20170201123823.6273-2-bob.picco@oracle.com>
In-Reply-To: <20170201123823.6273-2-bob.picco@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Bob.

Nit pick below.


On Wed, Feb 01, 2017 at 07:38:21AM -0500, Bob Picco wrote:
> From: bob picco <bob.picco@oracle.com>
> 
> Define some symbolic names for tsb/tlb miss trap tsb pointer computation.
> 
> Signed-off-by: Bob Picco <bob.picco@oracle.com>
> ---
>  arch/sparc/include/asm/spitfire.h  |  5 +++++
>  arch/sparc/kernel/sun4v_tlb_miss.S | 24 ++++++++++++------------
>  2 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/spitfire.h b/arch/sparc/include/asm/spitfire.h
> index 1d8321c827a8..1852a8618001 100644
> --- a/arch/sparc/include/asm/spitfire.h
> +++ b/arch/sparc/include/asm/spitfire.h
> @@ -37,6 +37,11 @@
>  #define SPITFIRE_HIGHEST_LOCKED_TLBENT	(64 - 1)
>  #define CHEETAH_HIGHEST_LOCKED_TLBENT	(16 - 1)
>  
> +#define HV_TSB_SIZE_BASE	0x200	/* 512 TTE-s minimum.		*/
> +#define	HV_TSB_SIZE_BASE_SHIFT	0x09	/* Shift of minimum tsb size.	*/
> +#define	HV_TSB_SIZE_MASK	0x07	/* Size encoding of tsb.	*/
> +#define	HV_TSB_TTE_SIZE_SHIFT	0x04	/* Sixteen byte tte size.	*/
If you end up respinning the pacthes please replace the tab after "define" with a space

	Sam
