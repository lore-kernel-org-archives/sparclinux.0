From: jose.marchesi@oracle.com (Jose E. Marchesi)
Date: Wed, 30 Nov 2016 15:55:29 +0000
Subject: Re: [PATCH] silo: Add 64-bit support
Message-Id: <87inr5kln2.fsf@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Two more caveats in common/jmp.S..

    diff --git a/common/jmp.S b/common/jmp.S
    index 3bc8c94..a446d78 100644
    --- a/common/jmp.S
    +++ b/common/jmp.S
    @@ -18,7 +18,13 @@
        Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,
        USA.  */
     
    -#define _SV save %sp, -0x40, %sp
    +#if __WORDSIZE = 32
    +# define STACK_BIAS 0
    +#else
    +# define STACK_BIAS 2047
    +#endif
    +
    +#define _SV save %sp, -STACK_BIAS-0x40, %sp
     #define _RV restore
     #define FLUSH_ALL_WINDOWS \
     	_SV; _SV; _SV; _SV; _SV; _SV; _SV; \
    @@ -46,7 +52,7 @@ __longjmp:
     	FLUSH_ALL_WINDOWS
        ld [%o0], %o7		/* Return PC.  */
     	ld [%o0 + 4], %fp	/* Saved SP.  */

#if __WORDSIZE = 32
        ld [%o0], %o7		/* Return PC.  */
     	ld [%o0 + 4], %fp	/* Saved SP.  */
#else
        ldx [%o0], %o7		/* Return PC.  */
     	ldx [%o0 + 8], %fp	/* Saved SP.  */
#endif

and also in the corresponding stores in setjmp:

#if __WORDSIZE = 32        
	st %o7, [%o0]
	st %sp, [%o0 + 4]
#else
        stx %o7, [%o0]
        stx %sp, [%o0 + 8]
#endif
