From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 14 Mar 2015 07:47:09 +0000
Subject: Re: [PATCH v2 12/22] sparc: %pf is only for function pointers
Message-Id: <20150314074709.GA5376@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1426196761-4891-1-git-send-email-scottwood@freescale.com>
In-Reply-To: <1426196761-4891-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scott Wood <scottwood@freescale.com>
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Thu, Mar 12, 2015 at 04:45:59PM -0500, Scott Wood wrote:
> Use %ps for actual addresses, otherwise you'll get bad output
> on arches like ppc64 where %pf expects a function descriptor.  Even on
> other architectures, refrain from setting a bad example that people
> copy.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Cc: sparclinux@vger.kernel.org
> Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> v2: Fix commit message to reflect that this patch is about %pf, not %pF.
> 
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
