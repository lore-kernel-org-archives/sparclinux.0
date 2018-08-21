From: David Miller <davem@davemloft.net>
Date: Tue, 21 Aug 2018 19:41:30 +0000
Subject: Re: [PATCH] sparc: fix KBUILD_DEFCONFIG for ARCH=sparc32
Message-Id: <20180821.124130.2115246742606446637.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1534784908-11692-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1534784908-11692-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yamada.masahiro@socionext.com
Cc: sparclinux@vger.kernel.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 21 Aug 2018 02:08:28 +0900

> As commit 5ba800962a80 ("kbuild: update ARCH alias info for sparc")
> addressed, SPARC accepts ARCH=sparc32 as an alias.
> 
> However, arch/sparc/Makefile wrongly sets KBUILD_DEFCONFIG, then
> sparc64_defconfig is chosen as the base configuration for ARCH=sparc32.
> 
>   $ make ARCH=sparc32 defconfig
>   *** Default configuration is based on 'sparc64_defconfig'
>   #
>   # configuration written to .config
>   #
> 
> Fix the logic to choose sparc64_defconfig only when ARCH=sparc64.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied, thank you.
