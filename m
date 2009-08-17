From: David Miller <davem@davemloft.net>
Date: Mon, 17 Aug 2009 03:23:20 +0000
Subject: Re: [PATCH] sparc64: build compressed image (zImage) by default
Message-Id: <20090816.202320.158035570.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200906291245.59887.elendil@planet.nl>
In-Reply-To: <200906291245.59887.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: elendil@planet.nl
Cc: sparclinux@vger.kernel.org, linux-kbuild@vger.kernel.org, jurij@wooyd.org

From: Frans Pop <elendil@planet.nl>
Date: Mon, 29 Jun 2009 12:45:59 +0200

> From: Jurij Smakov <jurij@wooyd.org>
> Subject: sparc64: build compressed image (zImage) by default
> 
> Besides creating the uncompressed vmlinux image for sparc64, also
> create a compressed zImage. This is more consistent with other
> architectures and required to make the 'deb-pkg' target work.
> 
> Signed-off-by: Jurij Smakov <jurij@wooyd.org>
> Signed-off-by: Frans Pop <elendil@planet.nl>

This is fine, however:

> @@ -91,6 +91,9 @@ endif
>  
>  boot := arch/sparc/boot
>  
> +# Default target
> +all: zImage
> +
>  image zImage tftpboot.img vmlinux.aout: vmlinux
>  	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>  

If we are going to add this target to the 32/64 agnostic part of the
Makefile, we should remove the identical chunk earlier in the 32-bit
specific section.

I took the liberty of making that cleanup when applying this,
thanks!

