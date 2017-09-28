From: David Miller <davem@davemloft.net>
Date: Thu, 28 Sep 2017 04:38:12 +0000
Subject: Re: [PATCH] sparc: Provide cmpxchg64 for 32-bit builds
Message-Id: <20170927.213812.1333158312684109871.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1506274171-28423-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1506274171-28423-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 24 Sep 2017 10:29:31 -0700

> Fix the following build error, seen when building sparc32:allmodconfig.
> 
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:
> 	In function 'i40e_set_priv_flags':
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4150:2: error:
> 	implicit declaration of function 'cmpxchg64'
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

That fixes the build:

> @@ -72,5 +72,6 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
>  	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
>  			(unsigned long)(n), sizeof(*(ptr))))
>  #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
> +#define cmpxchg64(ptr, o, n)	cmpxchg64_local((ptr), (o), (n))
>  
>  #endif /* __ARCH_SPARC_CMPXCHG__ */

but it's wrong.  cmpxchg64_local() is only atomic on the current cpu
so using it for plain cmpxchg64() is not going to work.
