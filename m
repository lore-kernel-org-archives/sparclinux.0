From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 12 Mar 2015 18:47:57 +0000
Subject: Re: [PATCH 12/22] sparc: %pF is only for function pointers
Message-Id: <20150312184757.GA22552@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1426130037-17956-1-git-send-email-scottwood@freescale.com>
 <1426130037-17956-12-git-send-email-scottwood@freescale.com>
In-Reply-To: <1426130037-17956-12-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scott Wood <scottwood@freescale.com>
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Wed, Mar 11, 2015 at 10:13:47PM -0500, Scott Wood wrote:
> Use %pS for actual addresses, otherwise you'll get bad output
> on arches like ppc64 where %pF expects a function descriptor.  Even on
> other architectures, refrain from setting a bad example that people
> copy.

The commit message used uppercase 'S' and 'F'.
But the patch uses lowercase variants.

Is this to highlight the letter in the commit message or some unwanted inconsistency?

	Sam

> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Cc: sparclinux@vger.kernel.org
> ---
>  arch/sparc/kernel/ds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
> index f87a55d..4ff835f 100644
> --- a/arch/sparc/kernel/ds.c
> +++ b/arch/sparc/kernel/ds.c
> @@ -875,7 +875,7 @@ void ldom_power_off(void)
>  
>  static void ds_conn_reset(struct ds_info *dp)
>  {
> -	printk(KERN_ERR "ds-%llu: ds_conn_reset() from %pf\n",
> +	printk(KERN_ERR "ds-%llu: ds_conn_reset() from %ps\n",
>  	       dp->id, __builtin_return_address(0));
>  }
>  
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
