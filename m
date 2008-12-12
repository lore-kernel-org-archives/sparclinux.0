From: David Miller <davem@davemloft.net>
Date: Fri, 12 Dec 2008 04:26:22 +0000
Subject: Re: [PATCH] use sparc64 version of scatterlist.h
Message-Id: <20081211.202622.93871140.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4941E249.1060808@earthlink.net>
In-Reply-To: <4941E249.1060808@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Thu, 11 Dec 2008 23:02:17 -0500

> Use sparc64 version of scatterlist.h.
> 
> There are three main differences:
>     dma_addr_t replaces __u32
>     dma_address replaces dvma_address
>     dma_length replaces dvma_length
> 
> dma_addr_t is a u32 on sparc32.
> 
> Boot tested on sparc32.
> 
> Signed-off-by: Robert Reif <reif@earthlink.net>

Applied, thanks a lot Robert.
