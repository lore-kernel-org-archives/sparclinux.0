From: David Miller <davem@davemloft.net>
Date: Tue, 12 Jan 2010 10:45:55 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific
Message-Id: <20100112.024555.260023279.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Tue, 12 Jan 2010 11:35:59 +0100

> I was using CONFIG_SLAB without noticing any problems.
> 
> But I'm a bit confused. Doesn't this patch generate the exact same code?
> Now __pa will add in phys_base but pfn_to_page(__pa()>>PAGE_SHIFT)
> will remove it by subtracting ARCH_PFN_OFFSET.
 ...
> For me it still fails if I'm not adding phys_base in page_to_phys.

Indeed.

Ok, let me think about this some more.

Thanks for testing and looking at this.
