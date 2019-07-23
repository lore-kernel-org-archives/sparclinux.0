From: David Miller <davem@davemloft.net>
Date: Tue, 23 Jul 2019 18:49:23 +0000
Subject: Re: [PATCH] sparc: remove unneeded uapi/asm/statfs.h
Message-Id: <20190723.114923.2114077126939672208.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190723113149.14776-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190723113149.14776-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yamada.masahiro@socionext.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 23 Jul 2019 20:31:49 +0900

> statfs.h is listed in include/uapi/asm-generic/Kbuild, so Kbuild will
> automatically generate it.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied, thank you.
