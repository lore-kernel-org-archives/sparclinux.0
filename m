From: David Miller <davem@davemloft.net>
Date: Tue, 15 Sep 2020 00:05:00 +0000
Subject: Re: [PATCH] sparc: remove SA_STATIC_ALLOC macro definition
Message-Id: <20200914.170500.369431843066947461.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Peter Collingbourne <pcc@google.com>
Date: Mon, 17 Aug 2020 20:17:45 -0700

> This macro is not exposed to uapi and is unreferenced in the
> kernel. The last reference to it was removed in commit 4c6773c3954c
> ("sparc32,leon: add support for extended interrupt controller"),
> so remove the definition.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>

Applied.
