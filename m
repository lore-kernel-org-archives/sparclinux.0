From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 08 Oct 2011 12:55:35 +0000
Subject: Re: longjmp question
Message-Id: <20111008125534.GA5065@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Oct 08, 2011 at 02:43:55AM -0400, David Miller wrote:
> From: Jurij Smakov <jurij@wooyd.org>
> Date: Sat, 8 Oct 2011 00:22:10 +0100
> 
> > #define RW_FP [%fp + 0x48]
> 
> Let's just do away with this value entirely and do this the
> safest way possible, since this is the slow path:
> 
> diff --git a/sysdeps/sparc/sparc32/__longjmp.S b/sysdeps/sparc/sparc32/__longjmp.S
> index a5453b4..70e8e29 100644
> --- a/sysdeps/sparc/sparc32/__longjmp.S
> +++ b/sysdeps/sparc/sparc32/__longjmp.S
> @@ -22,7 +22,6 @@
>  #include <jmpbuf-offsets.h>
>  #define ENV(base,reg) [%base + (reg * 4)]
>  #define ST_FLUSH_WINDOWS 3
> -#define RW_FP [%fp + 0x48]
>  
>  ENTRY(__longjmp)
>  	/* Store our arguments in global registers so we can still
> @@ -55,6 +54,7 @@ LOC(loop):
>  	 ld ENV(g1,JB_SP), %o0	/* Delay slot: extract target SP.  */
>  
>  LOC(thread):
> +	save	%sp, -96, %sp
>  	/*
>  	 * Do a "flush register windows trap".  The trap handler in the
>  	 * kernel writes all the register windows to their stack slots, and
> @@ -67,15 +67,13 @@ LOC(thread):
>  #ifdef PTR_DEMANGLE
>  	ld	ENV(g1,JB_PC), %g5 /* Set return PC. */
>  	ld	ENV(g1,JB_SP), %g1 /* Set saved SP on restore below. */
> -	PTR_DEMANGLE2 (%o7, %g5, %g4)
> +	PTR_DEMANGLE2 (%i7, %g5, %g4)
>  	PTR_DEMANGLE2 (%fp, %g1, %g4)
>  #else
> -	ld	ENV(g1,JB_PC), %o7 /* Set return PC. */
> +	ld	ENV(g1,JB_PC), %i7 /* Set return PC. */
>  	ld	ENV(g1,JB_SP), %fp /* Set saved SP on restore below. */
>  #endif
> -	sub	%fp, 64, %sp	/* Allocate a register frame. */
> -	st	%g3, RW_FP	/* Set saved FP on restore below. */
> -	retl
> +	jmp	%i7 + 8
>  	 restore %g2, 0, %o0	/* Restore values from above register frame. */

I don't really see anything in the code which would ensure that after 
we execute this restore, fp is going to be set to target fp value 
(available as ENV(g1,JB_FP) or g3. It might be the responsibility of 
the unwinding part, but then it would not explain why such code was 
explicitly present in the old version.

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
