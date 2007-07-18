From: David Miller <davem@davemloft.net>
Date: Wed, 18 Jul 2007 07:09:48 +0000
Subject: Re: [PATCH] Mark sparc and sparc64 as not having virt_to_bus
Message-Id: <20070718.000948.112288343.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718144140.3b4fd82e.sfr@canb.auug.org.au>
In-Reply-To: <20070718144140.3b4fd82e.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 18 Jul 2007 14:41:40 +1000

> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/sparc/Kconfig       |    3 +++
>  arch/sparc64/Kconfig     |    3 +++
>  include/asm-sparc64/io.h |    5 -----
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> This is part of a rash attempt to make allmodconfig builds work for sparc
> and sparc64 :-)

Hehe, applied, thanks Stephen.
