From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 11 May 2011 07:18:38 +0000
Subject: Re: [PATCH] sparc32/LEON: Added __init declaration to leon_flush_needed()
Message-Id: <4DCA384E.2070503@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4DC9CFF6.4020804@googlemail.com>
In-Reply-To: <4DC9CFF6.4020804@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Matthias Rosenfelder wrote:

> The function leon_flush_needed() is called only during bootup
> from another __init function. Therefore, we can add
> __init to leon_flush_needed().
>
> Signed-off-by: Matthias Rosenfelder <rosenfelder.lkml@googlemail.com>
> ---
>  arch/sparc/mm/leon_mm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/sparc/mm/leon_mm.c b/arch/sparc/mm/leon_mm.c
> index c0e0129..e485a68 100644
> --- a/arch/sparc/mm/leon_mm.c
> +++ b/arch/sparc/mm/leon_mm.c
> @@ -226,7 +226,7 @@ void leon3_getCacheRegs(struct leon3_cacheregs *regs)
>   * Leon2 and Leon3 differ in their way of telling cache information
>   *
>   */
> -int leon_flush_needed(void)
> +int __init leon_flush_needed(void)
>  {
>         int flush_needed = -1;
>         unsigned int ssize, sets;
> -- 
> 1.6.4.2
>
Please change to the standard commit message format: "sparc32,leon: " 
instead of sparc32/LEON. Otherwise it looks good,

Acked-by: Daniel Hellstrom <daniel@gaisler.com>

Thanks,
Daniel

