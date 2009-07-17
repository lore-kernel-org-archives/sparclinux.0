From: David Miller <davem@davemloft.net>
Date: Fri, 17 Jul 2009 02:39:06 +0000
Subject: Re: [PATCH 8/8] sparc: add CONFIG_DMA_API_DEBUG support
Message-Id: <20090716.193906.33652838.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1247466360-13330-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1247466360-13330-9-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1247466360-13330-9-git-send-email-fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fujita.tomonori@lab.ntt.co.jp
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, reif@earthlink.net, x86@kernel.org, tony.luck@intel.com, akpm@linux-foundation.org

From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Mon, 13 Jul 2009 15:26:00 +0900

> All we need to do for CONFIG_DMA_API_DEBUG support is call
> dma_debug_init() in DMA code common for SPARC32 and SPARC64.
> 
> Now SPARC32 uses two dma_map_ops structures for pci and sbus so there
> is not much dma stuff for SPARC32 in kernel/dma.c. kernel/ioport.c
> also includes dma stuff for SPARC32. So let's put all the dma stuff
> for SPARC32 in kernel/ioport.c and make kernel/dma.c common for
> SPARC32 and SPARC64.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

ACK, we just need to tweak that illegal DMA address check so
that it doesn't erroneously trigger on sparc32.
