From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 17 Feb 2017 08:39:41 +0000
Subject: Re: [PATCH 08/35] sparc: Convert remaining use of pr_warning to pr_warn
Message-Id: <20170217083941.GA8078@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1487314666.git.joe@perches.com>
 <d84b420939da59b66f099dc806469abff7dd0414.1487314667.git.joe@perches.com>
In-Reply-To: <d84b420939da59b66f099dc806469abff7dd0414.1487314667.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On Thu, Feb 16, 2017 at 11:11:21PM -0800, Joe Perches wrote:
> To enable eventual removal of pr_warning
> 
> This makes pr_warn use consistent for arch/sparc
> 
> Prior to this patch, there was 1 use of pr_warning and
> 8 uses of pr_warn in arch/sparc
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/sparc/kernel/smp_64.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> index dcb12d9002e9..ca0f8faa79a9 100644
> --- a/arch/sparc/kernel/smp_64.c
> +++ b/arch/sparc/kernel/smp_64.c
> @@ -1564,9 +1564,8 @@ void __init setup_per_cpu_areas(void)
>  					    pcpu_alloc_bootmem,
>  					    pcpu_free_bootmem);
>  		if (rc)
> -			pr_warning("PERCPU: %s allocator failed (%d), "
> -				   "falling back to page size\n",
> -				   pcpu_fc_names[pcpu_chosen_fc], rc);
> +			pr_warn("PERCPU: %s allocator failed (%d), falling back to page size\n",
> +				pcpu_fc_names[pcpu_chosen_fc], rc);

Good to see that the string is now on one line.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
