From: David Miller <davem@davemloft.net>
Date: Tue, 09 Sep 2014 23:41:43 +0000
Subject: Re: [PATCH v2] sparc32: dma_alloc_coherent must honour GFP_ZERO
Message-Id: <20140909.164143.1020450668380281143.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1409909268-7622-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1409909268-7622-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Fri,  5 Sep 2014 11:27:48 +0200

> dma_zalloc_coherent() calls dma_alloc_coherent(__GFP_ZERO)
> but the sparc32 implementations sbus_alloc_coherent() and
> pci32_alloc_coherent() doesn't take the gfp flags into
> account.
> 
> Tested on the SPARC32/LEON GRETH Ethernet driver which fails
> due to dma_alloc_coherent(__GFP_ZERO) returns non zeroed
> pages.
> 
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>

The real bug is that we ignore the gfp flags completely, there
is no reason to override whatever 'gfp' is into a hard coded
"GFP_KERNEL" or "GFP_KERNEL | __GFP_COMP".

Please just make these routines use 'gfp' as-is.

Thanks.
