From: "=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?=" <fweisbec@gmail.com>
Date: Tue, 21 Oct 2008 00:26:04 +0000
Subject: Re: [PATCH] sparc: correct section of current_pc()
Message-Id: <c62985530810201726w17ac4249h71c8feeb00fcd0e9@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <48FA0F7C.9040507@gmail.com>
In-Reply-To: <48FA0F7C.9040507@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "William L. Irwin" <wli@holomorphy.com>, Sparc <sparclinux@vger.kernel.org>

2008/10/18 Frederic Weisbecker <fweisbec@gmail.com>:
> Latest mainline gives this section mismatch on sparc:
>
> The function current_pc() references
> the variable __init no_sun4u_here.
> This is often because current_pc lacks a __init
> annotation or the annotation of no_sun4u_here is wrong.
>
> Since current_pc() is used only in early time, it is correct to
> put it in .init section.
>
> Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
> ---
> diff --git a/arch/sparc/kernel/head.S b/arch/sparc/kernel/head.S
> index 2d325fd..2fe2c11 100644
> --- a/arch/sparc/kernel/head.S
> +++ b/arch/sparc/kernel/head.S
> @@ -465,6 +465,7 @@ gokernel:
>                mov     %o7, %g4                ! Save %o7
>
>                /* Jump to it, and pray... */
> +               __INIT
>  current_pc:
>                call    1f
>                 nop
>
>

(Adding William and sparclinux in cc)
