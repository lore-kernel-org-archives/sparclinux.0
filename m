From: David Miller <davem@davemloft.net>
Date: Thu, 14 Jan 2010 11:12:07 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific
Message-Id: <20100114.031207.73913126.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Thu, 14 Jan 2010 12:05:34 +0100

> It works fine for me!
 ...
> Yes this change works as well.

Thanks for testing.

> Hmm, srmmu_mk_pte() uses page_to_pfn() which accounts for pfn_base?

My eyes aren't working, I confused page_to_pfn() with page_to_phys().

Great, now it is all clear.

I'll add the fix to sparc-2.6, thanks again.
