From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Mon, 21 Jan 2013 22:20:36 +0000
Subject: Re: [PATCH v3] sparc: kernel/sbus.c: fix memory leakage
Message-Id: <50FDBF34.4020409@oldelvet.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1358199372-11976-1-git-send-email-dinggnu@gmail.com> <20130116211309.GA13993@merkur.ravnborg.org> <20130116211725.GC18593@gmail.com> <20130116220018.GA14063@merkur.ravnborg.org> <20130116220153.GD18593@gmail.com> <50F7D577.8010506@oldelvet.org.uk> <20130117115637.GB25615@gmail.com> <50F7EED3.1050309@oldelvet.org.uk> <20130117132843.GD25615@gmail.com>
In-Reply-To: <20130117132843.GD25615@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cong Ding <dinggnu@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Reviewed-by: Richard Mortimer <richm@oldelvet.org.uk>

On 17/01/2013 13:28, Cong Ding wrote:
> The variable iommu and strbuf are not freed properly if it goes to error.
>
> Signed-off-by: Cong Ding <dinggnu@gmail.com>
> ---
>   arch/sparc/kernel/sbus.c |    6 +++---
>   1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/sparc/kernel/sbus.c b/arch/sparc/kernel/sbus.c
> index 1271b3a..be5bdf9 100644
> --- a/arch/sparc/kernel/sbus.c
> +++ b/arch/sparc/kernel/sbus.c
> @@ -554,10 +554,8 @@ static void __init sbus_iommu_init(struct platform_device *op)
>   	regs = pr->phys_addr;
>
>   	iommu = kzalloc(sizeof(*iommu), GFP_ATOMIC);
> -	if (!iommu)
> -		goto fatal_memory_error;
>   	strbuf = kzalloc(sizeof(*strbuf), GFP_ATOMIC);
> -	if (!strbuf)
> +	if (!iommu || !strbuf)
>   		goto fatal_memory_error;
>
>   	op->dev.archdata.iommu = iommu;
> @@ -656,6 +654,8 @@ static void __init sbus_iommu_init(struct platform_device *op)
>   	return;
>
>   fatal_memory_error:
> +	kfree(iommu);
> +	kfree(strbuf);
>   	prom_printf("sbus_iommu_init: Fatal memory allocation error.\n");
>   }
>
>
