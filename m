From: David Miller <davem@davemloft.net>
Date: Wed, 10 May 2017 00:49:37 +0000
Subject: Re: [PATCH net-next] bnxt: add dma mapping attributes
Message-Id: <20170509.204937.115947896476049334.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1494362253-270990-1-git-send-email-shannon.nelson@oracle.com>
In-Reply-To: <1494362253-270990-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: shannon.nelson@oracle.com
Cc: netdev@vger.kernel.org, sparclinux@vger.kernel.org

From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue,  9 May 2017 13:37:33 -0700

> @@ -66,6 +66,12 @@
>  MODULE_DESCRIPTION("Broadcom BCM573xx network driver");
>  MODULE_VERSION(DRV_MODULE_VERSION);
>  
> +#ifdef CONFIG_SPARC
> +#define BNXT_DMA_ATTRS  DMA_ATTR_WEAK_ORDERING
> +#else
> +#define BNXT_DMA_ATTRS	0
> +#endif
> +

I do not what this ifdef crap showing up in every driver just
to improve performance on one platform.

This needs to be generically done somehow in a way that
drivers get the correct setting automatically and without
ifdef checks.
