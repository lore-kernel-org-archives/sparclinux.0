From: "=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?=" <fweisbec@gmail.com>
Date: Tue, 21 Oct 2008 00:24:19 +0000
Subject: Re: [PATCH] sparc: correct section of apc_no_idle
Message-Id: <c62985530810201724i6e19441ep59ab42cd488ae1c3@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <48FA0AB6.3060505@gmail.com>
In-Reply-To: <48FA0AB6.3060505@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "William L. Irwin" <wli@holomorphy.com>, Sparc <sparclinux@vger.kernel.org>

2008/10/18 Frederic Weisbecker <fweisbec@gmail.com>:
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
> ---
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
>  #define apc_readb(offs)                (sbus_readb(regs+offs))
>  #define apc_writeb(val, offs)  (sbus_writeb(val, regs+offs))
>

(Adding William and sparclinux in cc)
