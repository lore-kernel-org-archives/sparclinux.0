From: David Miller <davem@davemloft.net>
Date: Mon, 17 Aug 2009 01:24:11 +0000
Subject: Re: [RFC][PATCH] SPARC: fix duplicate declaration
Message-Id: <20090816.182411.91021843.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1250153387.6116.20.camel@ht.satnam>
In-Reply-To: <1250153387.6116.20.camel@ht.satnam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Date: Thu, 13 Aug 2009 14:19:47 +0530

> Only difference for 32 and 64 bit version is dma64_addr_t and rest is same.
> 
> Also fixed the following 'make includecheck' warning:
> 
>   arch/sparc/include/asm/types.h: asm-generic/int-ll64.h is included more than once.
> 
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>

I'll apply this, thanks.
