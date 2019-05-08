From: David Miller <davem@davemloft.net>
Date: Wed, 08 May 2019 23:58:47 +0000
Subject: Re: [PATCH] sparc: vdso: add FORCE to the build rule of %.so
Message-Id: <20190508.165847.250571841268086695.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1554280344-10741-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1554280344-10741-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yamada.masahiro@socionext.com
Cc: sparclinux@vger.kernel.org, ndesaulniers@google.com, linux-kernel@vger.kernel.org, frowand.list@gmail.com, mingo@kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed,  3 Apr 2019 17:32:24 +0900

> $(call if_changed,...) must have FORCE as a prerequisite.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied.
