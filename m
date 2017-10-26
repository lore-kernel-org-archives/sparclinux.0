From: Joe Perches <joe@perches.com>
Date: Thu, 26 Oct 2017 04:53:52 +0000
Subject: Re: [PATCH v2] sparc: Provide cmpxchg64 for 32-bit builds
Message-Id: <1508993632.10651.19.camel@perches.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1508986312-32081-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1508986312-32081-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, "David S . Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2017-10-25 at 19:51 -0700, Guenter Roeck wrote:
> Fix the following build error, seen when building sparc32:allmodconfig.
> 
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:
> 	In function 'i40e_set_priv_flags':
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4150:2: error:
> 	implicit declaration of function 'cmpxchg64'
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Actually implement cmpxchg64 with code snippet provided by Dave Miller
>     Note: I am aware that this doesn't pass checkpatch; I found it more
>     important to be in line with __cmpxchg_u32().
> 
>  arch/sparc/include/asm/cmpxchg_32.h |  2 ++
>  arch/sparc/lib/atomic32.c           | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
> index 83ffb83c5397..7f95d3ca20e2 100644
> --- a/arch/sparc/include/asm/cmpxchg_32.h
> +++ b/arch/sparc/include/asm/cmpxchg_32.h
> @@ -62,6 +62,8 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
>  			(unsigned long)_n_, sizeof(*(ptr)));		\
>  })
>  
> +extern u64 cmpxchg64(u64 *ptr, u64 old, u64 new);

This extern is unusual style for sparc function declarations.

> +
>  #include <asm-generic/cmpxchg-local.h>
>  
>  /*
> diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
> index 2c373329d5cb..41601eb540e7 100644
> --- a/arch/sparc/lib/atomic32.c
> +++ b/arch/sparc/lib/atomic32.c
> @@ -172,6 +172,20 @@ unsigned long __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
>  }
>  EXPORT_SYMBOL(__cmpxchg_u32);
>  
> +u64 cmpxchg64(u64 *ptr, u64 old, u64 new)
> +{
> +	unsigned long flags;
> +	u64 prev;
> +
> +	spin_lock_irqsave(ATOMIC_HASH(ptr), flags);
> +	if ((prev = *ptr) = old)
> +		*ptr = new;
> +	spin_unlock_irqrestore(ATOMIC_HASH(ptr), flags);
> +
> +	return prev;
> +}
> +EXPORT_SYMBOL(cmpxchg64);
> +
>  unsigned long __xchg_u32(volatile u32 *ptr, u32 new)
>  {
>  	unsigned long flags;
