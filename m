From: Frank Rowand <frowand.list@gmail.com>
Date: Wed, 05 Sep 2018 01:55:26 +0000
Subject: Re: [PATCH 3/3] of: make default address and size cells sizes private
Message-Id: <35247ddc-303b-89d0-53b5-231c1a293721@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180830190523.31474-1-robh@kernel.org>
 <20180830190523.31474-4-robh@kernel.org>
In-Reply-To: <20180830190523.31474-4-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On 08/30/18 12:05, Rob Herring wrote:
> Only some old OpenFirmware implementations rely on default sizes. Any
> FDT and modern implementation should have explicit properties. Make the
> OF_ROOT_NODE_*_CELLS_DEFAULT defines private so we don't get any outside
> users.
> 
> This also gets us one step closer to removing the asm/prom.h dependency on
> Sparc.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/sparc/include/asm/prom.h | 3 ---
>  drivers/of/of_private.h       | 8 ++++++++
>  include/linux/of.h            | 6 ------
>  3 files changed, 8 insertions(+), 9 deletions(-)

Reviewed-by: Frank Rowand <frank.rowand@sony.com>


> diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
> index d955c8df62d6..1902db27ff4b 100644
> --- a/arch/sparc/include/asm/prom.h
> +++ b/arch/sparc/include/asm/prom.h
> @@ -24,9 +24,6 @@
>  #include <linux/atomic.h>
>  #include <linux/irqdomain.h>
>  
> -#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	2
> -#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
> -
>  #define of_compat_cmp(s1, s2, l)	strncmp((s1), (s2), (l))
>  #define of_prop_cmp(s1, s2)		strcasecmp((s1), (s2))
>  #define of_node_cmp(s1, s2)		strcmp((s1), (s2))
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 216175d11d3d..5d1567025358 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -27,6 +27,14 @@ struct alias_prop {
>  	char stem[0];
>  };
>  
> +#if defined(CONFIG_SPARC)
> +#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT 2
> +#else
> +#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT 1
> +#endif
> +
> +#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
> +
>  extern struct mutex of_mutex;
>  extern struct list_head aliases_lookup;
>  extern struct kset *of_kset;
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 506beca9588d..49d85f670c75 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -247,12 +247,6 @@ static inline unsigned long of_read_ulong(const __be32 *cell, int size)
>  #include <asm/prom.h>
>  #endif
>  
> -/* Default #address and #size cells.  Allow arch asm/prom.h to override */
> -#if !defined(OF_ROOT_NODE_ADDR_CELLS_DEFAULT)
> -#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT 1
> -#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
> -#endif
> -
>  #define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
>  #define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
>  
> 
