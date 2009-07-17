From: David Miller <davem@davemloft.net>
Date: Fri, 17 Jul 2009 02:37:46 +0000
Subject: Re: [PATCH 6/8] sparc: replace sbus_map_single and
Message-Id: <20090716.193746.160720785.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1247466360-13330-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1247466360-13330-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1247466360-13330-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fujita.tomonori@lab.ntt.co.jp
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, reif@earthlink.net, x86@kernel.org, tony.luck@intel.com, akpm@linux-foundation.org

From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Mon, 13 Jul 2009 15:25:58 +0900

> This is a preparation for using asm-generic/pci-dma-compat.h; SPARC32
> has two dma_map_ops structures for pci and sbus (removing
> arch/sparc/kernel/dma.c, PCI and SBUS DMA accessor).
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Tested-by: Robert Reif <reif@earthlink.net>

ACK
