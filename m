From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 28 Aug 2020 17:06:08 +0000
Subject: Re: Flushing transparent hugepages
Message-Id: <20200828170608.GJ3169@gaia>
List-Id: <sparclinux.vger.kernel.org>
References: <20200818150736.GQ17456@casper.infradead.org>
 <20200818160815.GA16191@willie-the-truck>
In-Reply-To: <20200818160815.GA16191@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Will Deacon <will@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-arch@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-mm@kvack.org

On Tue, Aug 18, 2020 at 05:08:16PM +0100, Will Deacon wrote:
> On Tue, Aug 18, 2020 at 04:07:36PM +0100, Matthew Wilcox wrote:
> > For example, arm64 seems confused in this scenario:
> > 
> > void flush_dcache_page(struct page *page)
> > {
> >         if (test_bit(PG_dcache_clean, &page->flags))
> >                 clear_bit(PG_dcache_clean, &page->flags);
> > }
> > 
> > ...
> > 
> > void __sync_icache_dcache(pte_t pte)
> > {
> >         struct page *page = pte_page(pte);
> > 
> >         if (!test_and_set_bit(PG_dcache_clean, &page->flags))
> >                 sync_icache_aliases(page_address(page), page_size(page));
> > }
> > 
> > So arm64 keeps track on a per-page basis which ones have been flushed.
> > page_size() will return PAGE_SIZE if called on a tail page or regular
> > page, but will return PAGE_SIZE << compound_order if called on a head
> > page.  So this will either over-flush, or it's missing the opportunity
> > to clear the bits on all the subpages which have now been flushed.
> 
> Hmm, that seems to go all the way back to 2014 as the result of a bug fix
> in 923b8f5044da ("arm64: mm: Make icache synchronisation logic huge page
> aware") which has a Reported-by Mark and a CC stable, suggesting something
> _was_ going wrong at the time :/ Was there a point where the tail pages
> could end up with PG_arch_1 uncleared on allocation?

In my experience, it's the other way around: you can end up with
PG_arch_1 cleared in a tail page when the head one was set (splitting
THP).

> > What would you _like_ to see?  Would you rather flush_dcache_page()
> > were called once for each subpage, or would you rather maintain
> > the page-needs-flushing state once per compound page?  We could also
> > introduce flush_dcache_thp() if some architectures would prefer it one
> > way and one the other, although that brings into question what to do
> > for hugetlbfs pages.
> 
> For arm64, we'd like to see PG_arch_1 preserved during huge page splitting
> [1], but there was a worry that it might break x86 and s390. It's also not
> clear to me that we can change __sync_icache_dcache() as it's called when
> we're installing the entry in the page-table, so why would it be called
> again for the tail pages?

Indeed, __sync_icache_dcache() is called from set_pte_at() on the head
page, though it could always iterate and flush the tail pages
individually (I think we could have done this in commit 923b8f5044da).
Currently I suspect it does some over-flushing if you use THP on
executable pages (it's a no-op on non-exec pages).

With MTE (arm64 memory tagging) I'm introducing a PG_arch_2 flag and
losing this is more problematic as it can lead to clearing valid tags.
In the subsequent patch [2], mte_sync_tags() (also called from
set_pte_at()) checks the PG_arch_2 in each page of a compound one.

My preference would be to treat both PG_arch_1 and _2 similarly.

> [1] https://lore.kernel.org/linux-arch/20200703153718.16973-8-catalin.marinas@arm.com/

[2] https://lore.kernel.org/linux-arch/20200703153718.16973-9-catalin.marinas@arm.com/

-- 
Catalin
