From: David Miller <davem@davemloft.net>
Date: Fri, 21 Dec 2018 19:25:07 +0000
Subject: Re: [PATCH] sparc: vdso: Drop implicit common-page-size linker flag
Message-Id: <20181221.112507.103897466549504781.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20181210223515.26332-1-ndesaulniers@google.com>
In-Reply-To: <20181210223515.26332-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ndesaulniers@google.com
Cc: yamada.masahiro@socionext.com, frowand.list@gmail.com, mingo@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: ndesaulniers@google.com
Date: Mon, 10 Dec 2018 14:35:13 -0800

> GNU linker's -z common-page-size's default value is based on the target
> architecture. arch/sparc/vdso/Makefile sets it to the architecture
> default, which is implicit and redundant. Drop it.
> 
> Link: https://lkml.kernel.org/r/20181206191231.192355-1-ndesaulniers@google.com
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Applied.
