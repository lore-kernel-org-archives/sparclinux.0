From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Thu, 30 Nov 2017 03:35:32 +0000
Subject: Re: sparc64: git kernel 4.14.0-12995-g0c86a6bd85ff does not boot
Message-Id: <4c813f9c-4c85-2f06-1527-2d5f9691ada0@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
In-Reply-To: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 11/29/2017 1:37 PM, David Miller wrote:
> Vijay, why did you put the NG4fls.o into obj-y?
>
> Anatoly, please try this patch:
>
> diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
> index 0f0f76b..063556f 100644
> --- a/arch/sparc/lib/Makefile
> +++ b/arch/sparc/lib/Makefile
> @@ -19,7 +19,7 @@ lib-$(CONFIG_SPARC32) += muldi3.o bitext.o cmpdi2.o
>   lib-$(CONFIG_SPARC64) += multi3.o
>   lib-$(CONFIG_SPARC64) += fls.o
>   lib-$(CONFIG_SPARC64) += fls64.o
> -obj-$(CONFIG_SPARC64) += NG4fls.o
> +lib-$(CONFIG_SPARC64) += NG4fls.o
>   
>   lib-$(CONFIG_SPARC64) += copy_page.o clear_page.o bzero.o
>   lib-$(CONFIG_SPARC64) += csum_copy.o csum_copy_from_user.o csum_copy_to_user.o
Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>

You are right, obj-y is not required.

Thanks,
Vijay
