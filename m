From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Sun, 21 Mar 2004 23:12:58 +0000
Subject: Re: small make clean fix
Message-Id: <20040321231258.GA3403@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040321214223.GA17279@spike>
In-Reply-To: <20040321214223.GA17279@spike>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Mar 21, 2004 at 10:42:23PM +0100, Stefan Holst wrote:

> diff -urN a/arch/sparc/Makefile b/arch/sparc/Makefile
> --- a/arch/sparc/Makefile	2004-03-11 11:32:58.000000000 +0100
> +++ b/arch/sparc/Makefile	2004-03-21 22:13:17.005461672 +0100
> @@ -67,7 +67,8 @@
>  	$(call filechk,gen-asm-offsets)
>  
>  CLEAN_FILES +=	include/asm-$(ARCH)/asm_offsets.h	\
> -		arch/$(ARCH)/kernel/asm-offsets.s
> +		arch/$(ARCH)/kernel/asm-offsets.s	\
> +		arch/$(ARCH)/boot/System.map
>  
>  # Don't use tabs in echo arguments.
>  define archhelp

Pete rejected this when I wrote it last year, and applied the clean
target instead.  This is probably my fault, since I failed to tell him
that it doesn't work (or perhaps it did then but doesn't now).

Pete, knowing that the clean target doesn't get called, do you still
object to this?

-- 
Keith M Wesolowski
