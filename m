From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 20 Oct 2011 15:39:48 +0000
Subject: Re: [PATCH 1/3] sparc32: Remove non-kernel code from memcpy
Message-Id: <20111020153948.GA28887@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20111019.184415.1875111683071341626.davem@davemloft.net>
In-Reply-To: <20111019.184415.1875111683071341626.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Oct 19, 2011 at 06:44:15PM -0400, David Miller wrote:
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/lib/memcpy.S |  607 +----------------------------------------------
>  1 files changed, 2 insertions(+), 605 deletions(-)
> 
> diff --git a/arch/sparc/lib/memcpy.S b/arch/sparc/lib/memcpy.S
> index 34fe657..6a8ef5d 100644
> --- a/arch/sparc/lib/memcpy.S
> +++ b/arch/sparc/lib/memcpy.S
> @@ -7,17 +7,12 @@
>   * Copyright (C) 1996 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
>   */
>  
> -#ifdef __KERNEL__
> -
> -#define FUNC(x) 											\
> +#define FUNC(x) 		\
>  	.globl	x;		\
>  	.type	x,@function;	\
> -	.align	4;											\
> +	.align	4;		\
>  x:

The kernel way is to use:

#include <linux/linkage.h>

...

ENTRY(memcpy)

I do not see this widely used in sparc32 code - added to my todo list.

	Sam
