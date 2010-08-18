From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 18 Aug 2010 05:39:55 +0000
Subject: Re: 64-bit ppc rwsem
Message-Id: <20100818053955.GA11962@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20100817.191424.183031381.davem@davemloft.net>
	<1282106338.22370.151.camel@pasglop>
	<1282107803.22370.173.camel@pasglop>
	<20100817.222818.193699062.davem@davemloft.net>
In-Reply-To: <20100817.222818.193699062.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@au.ibm.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org

> diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
> index c4b5e03..fa4c3ea 100644
> --- a/arch/sparc/lib/Makefile
> +++ b/arch/sparc/lib/Makefile
> @@ -15,7 +15,7 @@ lib-$(CONFIG_SPARC32) += divdi3.o udivdi3.o
>  lib-$(CONFIG_SPARC32) += copy_user.o locks.o
>  lib-y                 += atomic_$(BITS).o
>  lib-$(CONFIG_SPARC32) += lshrdi3.o ashldi3.o
> -lib-y                 += rwsem_$(BITS).o
> +lib-$(CONFIG_SPARC32) += rwsem_$(BITS).o

You could write this explicit as:

> +lib-$(CONFIG_SPARC32) += rwsem_32.o

As rwsem_64 is gone now.

	Sam
