From: David Miller <davem@davemloft.net>
Date: Mon, 08 Oct 2018 05:57:55 +0000
Subject: Re: [PATCH] sparc: vdso: clean-up vdso Makefile
Message-Id: <20181007.225755.347915466258746806.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1536723553-21287-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1536723553-21287-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yamada.masahiro@socionext.com
Cc: sparclinux@vger.kernel.org, shannon.nelson@oracle.com, linux-kernel@vger.kernel.org, nick.alcock@oracle.com, nagarathnam.muthusamy@oracle.com, gregkh@linuxfoundation.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 12 Sep 2018 12:39:13 +0900

> arch/sparc/vdso/Makefile is a replica of arch/x86/entry/vdso/Makefile.
> 
> Clean-up the Makefile in the same way as I did for x86:
> 
>  - Remove unnecessary export
>  - Put the generated linker script to $(obj)/ instead of $(src)/
>  - Simplify cmd_vdso2c
> 
> The corresponding x86 commits are:
> 
>  - 61615faf0a89 ("x86/build/vdso: Remove unnecessary export in Makefile")
>  - 1742ed2088cc ("x86/build/vdso: Put generated linker scripts to $(obj)/")
>  - c5fcdbf15523 ("x86/build/vdso: Simplify 'cmd_vdso2c'")
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied.
