From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 27 Sep 2017 19:50:43 +0000
Subject: Re: [PATCH v2 1/2] sparc64: Define SPARC default fls and __fls
Message-Id: <20170927195043.GA15193@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1506540326-9604-1-git-send-email-vijay.ac.kumar@oracle.com>
 <1506540326-9604-2-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1506540326-9604-2-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vijay Kumar <vijay.ac.kumar@oracle.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, babu.moger@oracle.com, rob.gardner@oracle.com

Hi Vijay.

Some feedback - see below.
The comment about ENTRY() ENDPROC() is also valid for patch 2/2

	Sam

> 
> diff --git a/arch/sparc/include/asm/bitops_64.h b/arch/sparc/include/asm/bitops_64.h
> index 2d52240..946c236 100644
> --- a/arch/sparc/include/asm/bitops_64.h
> +++ b/arch/sparc/include/asm/bitops_64.h
> @@ -22,11 +22,12 @@
>  void clear_bit(unsigned long nr, volatile unsigned long *addr);
>  void change_bit(unsigned long nr, volatile unsigned long *addr);
>  
> +#define fls64(word)  (((word)?(__fls(word) + 1):0))
This macro could result in unwanted sideeffects.
If I use:

	fls64(i++)

for some obscure reason, then i will be incremented twice if i != 0.
Using the asm-generic version would be better.

> +int fls(unsigned int word);
> +int __fls(unsigned long word);
> +
>  #include <asm-generic/bitops/non-atomic.h>
>  
> -#include <asm-generic/bitops/fls.h>
> -#include <asm-generic/bitops/__fls.h>
> -#include <asm-generic/bitops/fls64.h>
>  
>  #ifdef __KERNEL__
>  
> diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
> index 07c03e7..eefbb9c 100644
> --- a/arch/sparc/lib/Makefile
> +++ b/arch/sparc/lib/Makefile
> @@ -16,6 +16,7 @@ lib-$(CONFIG_SPARC64) += atomic_64.o
>  lib-$(CONFIG_SPARC32) += lshrdi3.o ashldi3.o
>  lib-$(CONFIG_SPARC32) += muldi3.o bitext.o cmpdi2.o
>  lib-$(CONFIG_SPARC64) += multi3.o
> +lib-$(CONFIG_SPARC64) += fls.o
>  
>  lib-$(CONFIG_SPARC64) += copy_page.o clear_page.o bzero.o
>  lib-$(CONFIG_SPARC64) += csum_copy.o csum_copy_from_user.o csum_copy_to_user.o
> diff --git a/arch/sparc/lib/fls.S b/arch/sparc/lib/fls.S
> new file mode 100644
> index 0000000..a19bff2
> --- /dev/null
> +++ b/arch/sparc/lib/fls.S
> @@ -0,0 +1,126 @@
> +/* fls.S: SPARC default fls and __fls definitions.
> + *
> + * SPARC default fls and __fls definitions, which follows the same
> + * algorithm as in generic fls() and __fls(). These functions will
> + * be boot time patched on T4 and onward.
> + */
> +
> +#include <asm/bitsperlong.h>
> +#include <asm/export.h>
> +
> +	.text
> +	.align	32
> +
> +	.global	fls, __fls
> +	.type	fls,	#function
> +	.type	__fls,	#function
> +
> +	.register	%g2, #scratch
> +	.register	%g3, #scratch
> +
> +EXPORT_SYMBOL(__fls)
> +EXPORT_SYMBOL(fls)
> +
> +fls:
Use ENTRY(), ENDPROC() for assembler functions.
> +	brz,pn	%o0, 6f
> +	 mov	0, %o1
> +	sethi	%hi(0xffff0000), %g3
> +	mov	%o0, %g2
> +	andcc	%o0, %g3, %g0
> +	be,pt	%icc, 8f
> +	 mov	32, %o1
> +	sethi	%hi(0xff000000), %g3
> +	andcc	%g2, %g3, %g0
> +	bne,pt	%icc, 3f
> +	 sethi	%hi(0xf0000000), %g3
> +	sll	%o0, 8, %o0
> +1:
> +	add	%o1, -8, %o1
> +	sra	%o0, 0, %o0
> +	mov	%o0, %g2
> +2:
> +	sethi	%hi(0xf0000000), %g3
> +3:
> +	andcc	%g2, %g3, %g0
> +	bne,pt	%icc, 4f
> +	 sethi	%hi(0xc0000000), %g3
> +	sll	%o0, 4, %o0
> +	add	%o1, -4, %o1
> +	sra	%o0, 0, %o0
> +	mov	%o0, %g2
> +4:
> +	andcc	%g2, %g3, %g0
> +	be,a,pt	%icc, 7f
> +	 sll	%o0, 2, %o0
> +5:
> +	xnor	%g0, %o0, %o0
> +	srl	%o0, 31, %o0
> +	sub	%o1, %o0, %o1
> +6:
> +	jmp	%o7 + 8
> +	 sra	%o1, 0, %o0
> +7:
> +	add	%o1, -2, %o1
> +	ba,pt	%xcc, 5b
> +	 sra	%o0, 0, %o0
> +8:
> +	sll	%o0, 16, %o0
> +	sethi	%hi(0xff000000), %g3
> +	sra	%o0, 0, %o0
> +	mov	%o0, %g2
> +	andcc	%g2, %g3, %g0
> +	bne,pt	%icc, 2b
> +	 mov	16, %o1
> +	ba,pt	%xcc, 1b
> +	 sll	%o0, 8, %o0
> +	.size	fls, .-fls
> +
> +__fls:
Same here, use ENTRY(), ENDPROC()
> +#if BITS_PER_LONG = 64
> +	mov	-1, %g2
> +	sllx	%g2, 32, %g2
> +	and	%o0, %g2, %g2
> +	brnz,pt	%g2, 1f
> +	 mov	63, %g1
> +	sllx	%o0, 32, %o0
> +#endif

Testign for BITS_PER_LONG seems not necessary as long as this is sparc64 only.
And sparc32 has no optimized bit operations not even LEON
so this would not make sense in sparc32 land anyway.

> +	mov	31, %g1
> +1:
> +	mov	-1, %g2
> +	sllx	%g2, (BITS_PER_LONG-16), %g2
spaces around operators please. It is no excuse that the source did not have so.

> +	and	%o0, %g2, %g2
> +	brnz,pt	%g2, 2f
> +	 mov	-1, %g2
> +	sllx	%o0, 16, %o0
> +	add	%g1, -16, %g1
> +2:
> +	mov	-1, %g2
> +	sllx	%g2, (BITS_PER_LONG-8), %g2
> +	and	%o0, %g2, %g2
> +	brnz,pt	%g2, 3f
> +	 mov	-1, %g2
> +	sllx	%o0, 8, %o0
> +	add	%g1, -8, %g1
> +3:
> +	sllx	%g2, (BITS_PER_LONG-4), %g2
> +	and	%o0, %g2, %g2
> +	brnz,pt	%g2, 4f
> +	 mov	-1, %g2
> +	sllx	%o0, 4, %o0
> +	add	%g1, -4, %g1
> +4:
> +	sllx	%g2, (BITS_PER_LONG-2), %g2
> +	and	%o0, %g2, %g2
> +	brnz,pt	%g2, 5f
> +	 mov	-1, %g3
> +	sllx	%o0, 2, %o0
> +	add	%g1, -2, %g1
> +5:
> +	mov	0, %g2
> +	sllx	%g3, (BITS_PER_LONG-1), %g3
> +	and	%o0, %g3, %o0
> +	movre	%o0, 1, %g2
> +	sub	%g1, %g2, %g1
> +	jmp	%o7+8
> +	 sra	%g1, 0, %o0
> +	.size	__fls, .-__fls
