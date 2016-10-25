From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 25 Oct 2016 18:39:40 +0000
Subject: Re: [PATCH 09/11] sparc64: Convert U3copy_{from,to}_user to accurate exception reporting.
Message-Id: <20161025183940.GA14043@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20161025.110228.1744774836277392991.davem@davemloft.net>
In-Reply-To: <20161025.110228.1744774836277392991.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave.

One small comment below.
I did not try to build with these patches, but stumbled over this detail.

On Tue, Oct 25, 2016 at 11:02:28AM -0400, David Miller wrote:
> 
> Report the exact number of bytes which have not been successfully
> copied when an exception occurs, using the running remaining length.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/lib/U3copy_from_user.S |   8 +-
>  arch/sparc/lib/U3copy_to_user.S   |   8 +-
>  arch/sparc/lib/U3memcpy.S         | 227 ++++++++++++++++++++++++++------------
>  3 files changed, 162 insertions(+), 81 deletions(-)
> 
> diff --git a/arch/sparc/lib/U3copy_from_user.S b/arch/sparc/lib/U3copy_from_user.S
> index 1046e2b..db73010 100644
> --- a/arch/sparc/lib/U3copy_from_user.S
> +++ b/arch/sparc/lib/U3copy_from_user.S
> @@ -3,19 +3,19 @@
>   * Copyright (C) 1999, 2000, 2004 David S. Miller (davem@redhat.com)
>   */
>  
> -#define EX_LD(x)		\
> +#define EX_LD(x,y)		\
>  98:	x;			\
>  	.section __ex_table,"a";\
>  	.align 4;		\
> -	.word 98b, __retl_mone;	\
> +	.word 98b, y;		\
>  	.text;			\
>  	.align 4;
>  
> -#define EX_LD_FP(x)		\
> +#define EX_LD_FP(x,y)		\
>  98:	x;			\
>  	.section __ex_table,"a";\
>  	.align 4;		\
> -	.word 98b, __retl_mone_fp;\
> +	.word 98b, y##_fp;	\
>  	.text;			\
>  	.align 4;
>  
> diff --git a/arch/sparc/lib/U3copy_to_user.S b/arch/sparc/lib/U3copy_to_user.S
> index 032b0c5..c4ee858 100644
> --- a/arch/sparc/lib/U3copy_to_user.S
> +++ b/arch/sparc/lib/U3copy_to_user.S
> @@ -3,19 +3,19 @@
>   * Copyright (C) 1999, 2000, 2004 David S. Miller (davem@redhat.com)
>   */
>  
> -#define EX_ST(x)		\
> +#define EX_ST(x,y)		\
>  98:	x;			\
>  	.section __ex_table,"a";\
>  	.align 4;		\
> -	.word 98b, __retl_mone;	\
> +	.word 98b, y;		\
>  	.text;			\
>  	.align 4;
>  
> -#define EX_ST_FP(x)		\
> +#define EX_ST_FP(x,y)		\
>  98:	x;			\
>  	.section __ex_table,"a";\
>  	.align 4;		\
> -	.word 98b, __retl_mone_fp;\
> +	.word 98b, y##_fp;	\
>  	.text;			\
>  	.align 4;
>  
> diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
> index 491ee69..54f9870 100644
> --- a/arch/sparc/lib/U3memcpy.S
> +++ b/arch/sparc/lib/U3memcpy.S
> @@ -4,6 +4,7 @@
>   */
>  
>  #ifdef __KERNEL__
> +#include <linux/linkage.h>
>  #include <asm/visasm.h>
>  #include <asm/asi.h>
>  #define GLOBAL_SPARE	%g7
> @@ -22,21 +23,17 @@
>  #endif
>  
>  #ifndef EX_LD
> -#define EX_LD(x)	x
> +#define EX_LD(x,y)	x

The above line will result in following assembelr code fragment:
.word 98b, ;           \
          ^
          empty
Maybe this is just fine - but it looks wrong.
Same goes for other uses of related macros.

	Sam
