From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 28 Apr 2011 19:08:06 +0000
Subject: Re: [PATCH] SPARC32/LEON: Remove unnecessary page_address calls in
Message-Id: <20110428190805.GA11189@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1303981009-22274-1-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1303981009-22274-1-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Kristoffer.
On Thu, Apr 28, 2011 at 10:56:49AM +0200, Kristoffer Glembo wrote:
> The function mmu_inval_dma_area takes a virtual address as a parameter which is problematic in case the
> buffer is located in highmem and the mapping currently is unavailable.
> 
> Since the function was only implemented for LEON this patch removes calls to it in non LEON code paths and
> renames it to dma_make_coherent which instead takes a physical address (which for now is unused since we
> flush the whole cache). This way it is possible to remove several unnecessary calls to page_address which
> will fail if the virtual mapping is unavailable.
> 
> Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>

To make changelog look consistent please use:
sparc: headline        <= for general sparc stuff
sparc32: headline      <= for sparc32 specific stuff
sparc32,leon: headline <= for leon specific stuff

This is so shortlogs looks the same.

And please keep the line-length in the changelogs below 80 chars.

> ---
>  arch/sparc/kernel/ioport.c |   40 ++++++++++++++--------------------------
>  1 files changed, 14 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
> index c6ce9a6..7dc268d 100644
> --- a/arch/sparc/kernel/ioport.c
> +++ b/arch/sparc/kernel/ioport.c
> @@ -50,10 +50,13 @@
>  #include <asm/io-unit.h>
>  #include <asm/leon.h>
>  
> +/* This function must make sure that caches and memory are coherent after DMA
> + * On LEON systems without cache snooping it flushes the entire D-CACHE.
> + */
>  #ifndef CONFIG_SPARC_LEON
> -#define mmu_inval_dma_area(p, l)	/* Anton pulled it out for 2.4.0-xx */
> +#define dma_make_coherent(p, l)

Please make this a "static inline dma_make_coherent(unsigned long pa, unsigned long len)"
so we get proper type-check for non-leon code.


For the actual implementation I have no comments - I do not
know the code well enough.
But I like the simplification - thats always good.

	Sam
