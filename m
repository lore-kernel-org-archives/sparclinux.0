From: David Miller <davem@davemloft.net>
Date: Wed, 04 Nov 2009 13:39:28 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific
Message-Id: <20091104.053928.92073166.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Mon,  2 Nov 2009 15:28:12 +0100

> Added mmu_inval_dma_area for LEON which flushes dcache if snooping
> is not enabled and created LEON specific dma_ops.

This is a lot of code duplication for what you're trying to
accomplish I think.

And now that your drivers will use OpenFirmware driver interfaces
that's yet another difference you no longer have to account for.

I would suggest that you crib the SBUS routines and parameterize
them cleanly for the small differences your LEON cases needs.

Thanks.
