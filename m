From: David Miller <davem@davemloft.net>
Date: Thu, 20 Nov 2008 10:00:11 +0000
Subject: Re: Extending Leon-Sparc page table size to 32k
Message-Id: <20081120.020011.111551760.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <e8611b790811181236q5c36993dq1da2d43888c5c7b2@mail.gmail.com>
In-Reply-To: <e8611b790811181236q5c36993dq1da2d43888c5c7b2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "k e" <eiselekd@gmail.com>
Date: Tue, 18 Nov 2008 21:36:24 +0100

> So I could at max form a 8*64Q2 entry software PTE-table that would
> only be 2k.
> However the page size would be 32k anyway.

So you would be able to have (32 / 2) PTE tables in one page.
I don't see what the problem is with that.

> Could someone explain why there is a need to join hardware PTE-Tables together
> to form chunks of 4k (PAGE_SIZE, but in my case 32k).

Because the kernel works with struct page for PTE level pages,
and if that memory is in highmem it does a kmap() on that page
when modifying PTEs.

> Is this only a performance consideration or would I run into trouble
> if using only 2k
> chunks of 512 enties?

I don't see any problem with this.  Just modify the indexing so that
32K page indexes are used at the PTE level, and modify the calculations
that determine how many PTE tables fit into a page for allocation.
