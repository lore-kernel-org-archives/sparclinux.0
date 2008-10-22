From: David Miller <davem@davemloft.net>
Date: Wed, 22 Oct 2008 04:57:05 +0000
Subject: Re: [PATCH] sparc: correct section of current_pc()
Message-Id: <20081021.215705.201578406.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48FA0FAD.4010308@gmail.com>
In-Reply-To: <48FA0FAD.4010308@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Sat, 18 Oct 2008 18:32:45 +0200

[ sparclinux@vger.kernel.org CC:'d ]

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

Also applied, thanks.

> diff --git a/arch/sparc/kernel/head.S b/arch/sparc/kernel/head.S
> index 2d325fd..2fe2c11 100644
> --- a/arch/sparc/kernel/head.S
> +++ b/arch/sparc/kernel/head.S
> @@ -465,6 +465,7 @@ gokernel:
>  		mov	%o7, %g4		! Save %o7
>  
>  		/* Jump to it, and pray... */
> +		__INIT
>  current_pc:
>  		call	1f
>  		 nop
