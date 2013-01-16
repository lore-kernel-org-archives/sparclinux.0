From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 16 Jan 2013 21:13:09 +0000
Subject: Re: [PATCH] sparc: kernel/sbus.c: fix memory leakage
Message-Id: <20130116211309.GA13993@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1358199372-11976-1-git-send-email-dinggnu@gmail.com>
In-Reply-To: <1358199372-11976-1-git-send-email-dinggnu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cong Ding <dinggnu@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 14, 2013 at 10:36:08PM +0100, Cong Ding wrote:
> the variable iommu and strbuf are not freed if it goes to error.
> 
> Signed-off-by: Cong Ding <dinggnu@gmail.com>
> ---
>  arch/sparc/kernel/sbus.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sparc/kernel/sbus.c b/arch/sparc/kernel/sbus.c
> index 1271b3a..0b66e53 100644
> --- a/arch/sparc/kernel/sbus.c
> +++ b/arch/sparc/kernel/sbus.c
> @@ -555,10 +555,10 @@ static void __init sbus_iommu_init(struct platform_device *op)
>  
>  	iommu = kzalloc(sizeof(*iommu), GFP_ATOMIC);
>  	if (!iommu)
> -		goto fatal_memory_error;
> +		goto fatal_iommu_memory_error;
>  	strbuf = kzalloc(sizeof(*strbuf), GFP_ATOMIC);
>  	if (!strbuf)
> -		goto fatal_memory_error;
> +		goto fatal_strbuf_memory_error;
>  
>  	op->dev.archdata.iommu = iommu;
>  	op->dev.archdata.stc = strbuf;
> @@ -656,6 +656,10 @@ static void __init sbus_iommu_init(struct platform_device *op)
>  	return;
>  
>  fatal_memory_error:
> +	kfree(strbuf);
> +fatal_strbuf_memory_error:
> +	kfree(iommu);
> +fatal_iommu_memory_error:
>  	prom_printf("sbus_iommu_init: Fatal memory allocation error.\n");
>  }
kfree is a noop if passed a null pointer.
So you can just add the missing kfree's to fix this.

	Sam
