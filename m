From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 Jul 2014 14:06:17 +0000
Subject: Re: [RESEND][PATCH] sparc: use %s for unaligned panic
Message-Id: <20140714140617.GA18763@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20140630203759.GA4764@www.outflux.net>
In-Reply-To: <20140630203759.GA4764@www.outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On Mon, Jun 30, 2014 at 01:37:59PM -0700, Kees Cook wrote:
> Since unaligned_panic() takes a literal string, make sure it can never
> accidentally be used as a format string.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/sparc/kernel/unaligned_32.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/kernel/unaligned_32.c b/arch/sparc/kernel/unaligned_32.c
> index c5c61b3c6b56..32b61d1b6379 100644
> --- a/arch/sparc/kernel/unaligned_32.c
> +++ b/arch/sparc/kernel/unaligned_32.c
> @@ -166,7 +166,7 @@ unsigned long safe_compute_effective_address(struct pt_regs *regs,
>  /* This is just to make gcc think panic does return... */
>  static void unaligned_panic(char *str)
>  {
> -	panic(str);
> +	panic("%s", str);
>  }
>  
>  /* una_asm.S */

The feedback last time was that this patch is silly.
panic() has only two callsites within the same file.

	Sam
