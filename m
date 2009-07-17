From: David Miller <davem@davemloft.net>
Date: Fri, 17 Jul 2009 02:37:33 +0000
Subject: Re: [PATCH 5/8] sparc: remove no-op dma_4v_sync_single_for_cpu and
Message-Id: <20090716.193733.64064398.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1247466360-13330-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1247466360-13330-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1247466360-13330-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fujita.tomonori@lab.ntt.co.jp
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, reif@earthlink.net, x86@kernel.org, tony.luck@intel.com, akpm@linux-foundation.org

From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Mon, 13 Jul 2009 15:25:57 +0900

> Now sparc uses include/asm-generic/dma-mapping-common.h. pci_sun4v.c
> doesn't need to have no-op dma_4v_sync_single_for_cpu and
> dma_4v_sync_sg_for_cpu (dma-mapping-common.h does nothing if
> sync_{single|sg}_for_cpu hook is not defined). So we can remove them
> safely.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Tested-by: Robert Reif <reif@earthlink.net>

ACK
