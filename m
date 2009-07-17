From: David Miller <davem@davemloft.net>
Date: Fri, 17 Jul 2009 02:38:45 +0000
Subject: Re: [PATCH 7/8] sparc: use asm-generic/pci-dma-compat
Message-Id: <20090716.193845.76232427.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1247466360-13330-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1247466360-13330-8-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1247466360-13330-8-git-send-email-fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fujita.tomonori@lab.ntt.co.jp
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, reif@earthlink.net, x86@kernel.org, tony.luck@intel.com, akpm@linux-foundation.org

From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Mon, 13 Jul 2009 15:25:59 +0900

> This converts SPARC to use asm-generic/pci-dma-compat instead of the
> homegrown mechnism.
> 
> SPARC32 has two dma_map_ops structures for pci and sbus (removing
> arch/sparc/kernel/dma.c, PCI and SBUS DMA accessor). The global
> 'dma_ops' is set to sbus_dma_ops and get_dma_ops() returns
> pci32_dma_ops for pci devices so we can use the appropriate dma
> mapping operations.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Tested-by: Robert Reif <reif@earthlink.net>

ACK
