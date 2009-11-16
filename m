From: David Miller <davem@davemloft.net>
Date: Mon, 16 Nov 2009 11:21:12 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific
Message-Id: <20091116.032112.164780783.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Mon, 16 Nov 2009 12:06:55 +0100

> After pulling the latest sparc-next dma_map_single began returning
> bogus addresses. I just saw that page_address was being used
> everywhere
> else in ioport.c (including sbus_map_page) and switched to that since
> page_to_phys was returning incorrect addresses when passed SKB pages.
> 
> So if page_address is wrong I will have to investigate what it is that
> really is broken.

You really need to investigate why dma_map_single() is not
returning sane addresses.
