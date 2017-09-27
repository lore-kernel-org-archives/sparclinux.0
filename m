From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 27 Sep 2017 19:56:37 +0000
Subject: Re: [PATCH v2 2/2] sparc64: Use lzcnt instruction for fls and __fls
Message-Id: <20170927195637.GB15193@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1506540326-9604-1-git-send-email-vijay.ac.kumar@oracle.com>
 <1506540326-9604-3-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1506540326-9604-3-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vijay Kumar <vijay.ac.kumar@oracle.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, babu.moger@oracle.com, rob.gardner@oracle.com

Hi Vijay.

On Wed, Sep 27, 2017 at 01:25:26PM -0600, Vijay Kumar wrote:
> For T4 and above, patch fls and __fls functions
> at the boot time to use lzcnt instruction.
> 
> Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
> Reviewed-by: Babu Moger <babu.moger@oracle.com>
> ---
>  arch/sparc/Makefile         |    1 +
>  arch/sparc/kernel/head_64.S |    2 ++
>  arch/sparc/lib/Makefile     |    3 +++
>  arch/sparc/lib/NG4fls.S     |   30 ++++++++++++++++++++++++++++++
>  arch/sparc/lib/NG4patch.S   |    9 +++++++++
>  5 files changed, 45 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
> index 8496a07..0763cd8 100644
> --- a/arch/sparc/Makefile
> +++ b/arch/sparc/Makefile
> @@ -48,6 +48,7 @@ KBUILD_CFLAGS += -ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare
>  KBUILD_CFLAGS += -Wa,--undeclared-regs
>  KBUILD_CFLAGS += $(call cc-option,-mtune=ultrasparc3)
>  KBUILD_AFLAGS += -m64 -mcpu=ultrasparc -Wa,--undeclared-regs
> +KBUILD_AFLAGS += -Wa,-Asparc4
This change is not justified anywhere??

>  
>  ifeq ($(CONFIG_MCOUNT),y)
>    KBUILD_CFLAGS += -pg
> diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
> index 78e0211..1165254 100644
> --- a/arch/sparc/kernel/head_64.S
> +++ b/arch/sparc/kernel/head_64.S
> @@ -628,6 +628,8 @@ niagara4_patch:
>  	 nop
>  	call	niagara4_patch_pageops
>  	 nop
> +	call	niagara4_patch_fls
> +	 nop
>  
>  	ba,a,pt	%xcc, 80f
>  	 nop
> diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
> index eefbb9c..72d2d8c 100644
> --- a/arch/sparc/lib/Makefile
> +++ b/arch/sparc/lib/Makefile
> @@ -46,3 +46,6 @@ lib-$(CONFIG_SPARC64) += mcount.o ipcsum.o xor.o hweight.o ffs.o
>  obj-$(CONFIG_SPARC64) += iomap.o
>  obj-$(CONFIG_SPARC32) += atomic32.o ucmpdi2.o
>  obj-$(CONFIG_SPARC64) += PeeCeeI.o
> +
> +obj-$(CONFIG_SPARC64) += fls.o
> +obj-$(CONFIG_SPARC64) += NG4fls.o
> diff --git a/arch/sparc/lib/NG4fls.S b/arch/sparc/lib/NG4fls.S
> new file mode 100644
> index 0000000..eb239aa
> --- /dev/null
> +++ b/arch/sparc/lib/NG4fls.S
> @@ -0,0 +1,30 @@
> +/* NG4fls.S: SPARC optimized fls and __fls for T4 and above.
> + *
> + * Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
> + */
> +
> +	.text
> +	.align 32
> +
> +	.globl NG4fls
> +	.globl __NG4fls
> +	.type  NG4fls, #function
> +	.type  __NG4fls, #function

Use ENTRY(), ENDPROC() as already mentioned.
> +NG4fls:
> +	lzcnt   %o0, %o1
> +	mov     64, %o2
> +	retl
> +	 sub     %o2, %o1, %o0
> +	.size   NG4fls, .-NG4fls
> +
> +__NG4fls:
> +	brz,pn  %o0, 1f
> +        mov	%o0, %o1
Use tabs for indent, not spaces. In this case one tab + one space.

> +	lzcnt	%o1, %o0
> +	mov     63, %o2
> +	sub     %o2, %o0, %o0
> +1:
> +	retl
> +	 nop
> +	.size   __NG4fls, .-__NG4fls
> diff --git a/arch/sparc/lib/NG4patch.S b/arch/sparc/lib/NG4patch.S
> index 3cc0f8c..1010d53 100644
> --- a/arch/sparc/lib/NG4patch.S
> +++ b/arch/sparc/lib/NG4patch.S
> @@ -52,3 +52,12 @@ niagara4_patch_pageops:
>  	retl
>  	 nop
>  	.size	niagara4_patch_pageops,.-niagara4_patch_pageops
> +
> +	.globl	niagara4_patch_fls
> +	.type	niagara4_patch_fls,#function
> +niagara4_patch_fls:
> +	NG_DO_PATCH(fls, NG4fls)
> +	NG_DO_PATCH(__fls, __NG4fls)
> +	retl
> +	 nop
> +	.size	niagara4_patch_fls,.-niagara4_patch_fls

Please path the remaining functions in this file with ENTRY(), ENDPROC() - in a separate patch.

	Sam
