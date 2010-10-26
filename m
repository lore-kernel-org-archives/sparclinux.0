From: David Miller <davem@davemloft.net>
Date: Tue, 26 Oct 2010 16:26:43 +0000
Subject: Re: [PATCH] sparc32: make CONFIG_SPARC_LEON depends on !SMP to fix
Message-Id: <20101026.092643.39179121.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1288108303-2712-1-git-send-email-namhyung@gmail.com>
In-Reply-To: <1288108303-2712-1-git-send-email-namhyung@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: namhyung@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@gmail.com>
Date: Wed, 27 Oct 2010 00:51:43 +0900

> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 4db8bc0..a6685ba 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -463,7 +463,7 @@ config SERIAL_CONSOLE
>  
>  config SPARC_LEON
>  	bool "Sparc Leon processor family"
> -	depends on SPARC32
> +	depends on SPARC32 && !SMP
>  	---help---
>  	  If you say Y here if you are running on a SPARC-LEON processor.
>  	  The LEON processor is a synthesizable VHDL model of the
> -- 

Upon further consideration, since not only do SMP leon chips exist,
but people are posting real bug fixes for that configuration, I'll
apply your original patch.

Thanks!
