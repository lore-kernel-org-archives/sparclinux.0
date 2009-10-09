From: David Miller <davem@davemloft.net>
Date: Fri, 09 Oct 2009 21:21:32 +0000
Subject: Re: page_to_phys
Message-Id: <20091009.142132.12317577.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4ACF4266.6000702@gaisler.com>
In-Reply-To: <4ACF4266.6000702@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Fri, 09 Oct 2009 16:02:14 +0200

> Currently in io_32.h page_to_phys is defined as:
> 
> #define page_to_phys(page)	(((page) - mem_map) << PAGE_SHIFT)
> 
> Should it not be:
> 
> #define page_to_phys(page) ((((page) - mem_map) << PAGE_SHIFT) +
> #phys_base)
> 
> or perhaps:
> 
> #define page_to_phys(page) ((dma_addr_t)page_to_pfn(page) <<
> #PAGE_SHIFT)

Sparc 32-bit doesn't offset the mem_map at phys_base.

What is offset by phys_base is what gets mapped at PAGE_OFFSET
virtually.

That's why the things that translate between virtual and physical
addresses do take phys_base into account.

