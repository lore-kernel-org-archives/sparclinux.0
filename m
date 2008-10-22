From: David Miller <davem@davemloft.net>
Date: Wed, 22 Oct 2008 04:56:07 +0000
Subject: Re: [PATCH] sparc: correct section of apc_no_idle
Message-Id: <20081021.215607.193696998.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48FA0AB6.3060505@gmail.com>
In-Reply-To: <48FA0AB6.3060505@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Sat, 18 Oct 2008 18:11:34 +0200

[ Please post sparc patches to sparclinux@vger.kernel.org in
  the future, CC:'d ]

> The latest mainline gives this section mismatch on sparc:
> 
> The function __devinit apc_probe() references
> a variable __initdata apc_no_idle.
> If apc_no_idle is only used by apc_probe then
> annotate apc_no_idle with a matching annotation.
> 
> Since the commit 7e7e2f035663c5ceb029bfb9d91e75099b0a5625,
> apc_probe() is on __devinit so we have to correct apc_no_idle
> which is referenced by this function.
> 
> Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>

Applied, thanks.

> diff --git a/arch/sparc/kernel/apc.c b/arch/sparc/kernel/apc.c
> index 4dd1ba7..9c11582 100644
> --- a/arch/sparc/kernel/apc.c
> +++ b/arch/sparc/kernel/apc.c
> @@ -31,7 +31,7 @@
>  #define APC_DEVNAME "apc"
>  
>  static u8 __iomem *regs;
> -static int apc_no_idle __initdata = 0;
> +static int apc_no_idle __devinitdata = 0;
>  
>  #define apc_readb(offs)		(sbus_readb(regs+offs))
>  #define apc_writeb(val, offs) 	(sbus_writeb(val, regs+offs))
