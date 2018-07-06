From: David Miller <davem@davemloft.net>
Date: Fri, 06 Jul 2018 00:31:03 +0000
Subject: Re: [PATCH] kbuild: update ARCH alias info for sparc
Message-Id: <20180706.093103.1547249026984330034.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <03cfef31-5308-7b17-9e0d-3a0dc680e750@infradead.org>
In-Reply-To: <03cfef31-5308-7b17-9e0d-3a0dc680e750@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rdunlap@infradead.org
Cc: linux-kbuild@vger.kernel.org, yamada.masahiro@socionext.com, sparclinux@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 5 Jul 2018 12:12:03 -0700

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> The supported alias for building sparc 32-bit is "sparc32",
> not "sparc", so update the alias documentation for that.
> Just using "sparc" produces a 64-bit config file.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: David S. Miller <davem@davemloft.net>
