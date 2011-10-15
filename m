From: crn@netunix.com
Date: Sat, 15 Oct 2011 00:14:02 +0000
Subject: Re: [PATCH 03/21] sparc: drop unused Kconfig symbol
Message-Id: <alpine.LNX.2.00.1110150111520.26030@post.netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1318595257.6132.59.camel@x61.thuisdomein>
In-Reply-To: <1318595257.6132.59.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Bolle <pebolle@tiscali.nl>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


How does this affect Javastations, ISTR that they need PCI and one
(rare) variant has a PCI slot. ??

On Fri, 14 Oct 2011, Paul Bolle wrote:

> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> arch/sparc/Kconfig |    7 +------
> 1 files changed, 1 insertions(+), 6 deletions(-)
>
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 1a6f20d..f92602e 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -560,12 +560,7 @@ config SUN_OPENPROMFS
> 	  Only choose N if you know in advance that you will not need to modify
> 	  OpenPROM settings on the running system.
>
> -# Makefile helpers
> -config SPARC32_PCI
> -	bool
> -	default y
> -	depends on SPARC32 && PCI
> -
> +# Makefile helper
> config SPARC64_PCI
> 	bool
> 	default y
> -- 
> 1.7.4.4
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
