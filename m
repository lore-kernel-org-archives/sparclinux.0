From: Will Deacon <will@kernel.org>
Date: Tue, 18 Aug 2020 16:08:16 +0000
Subject: Re: Flushing transparent hugepages
Message-Id: <20200818160815.GA16191@willie-the-truck>
List-Id: <sparclinux.vger.kernel.org>
References: <20200818150736.GQ17456@casper.infradead.org>
In-Reply-To: <20200818150736.GQ17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-arch@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-mm@kvack.org

On Tue, Aug 18, 2020 at 04:07:36PM +0100, Matthew Wilcox wrote:
> For example, arm64 seems confused in this scenario:
> 
> void flush_dcache_page(struct page *page)
> {
>         if (test_bit(PG_dcache_clean, &page->flags))
>                 clear_bit(PG_dcache_clean, &page->flags);
> }
> 
> ...
> 
> void __sync_icache_dcache(pte_t pte)
> {
>         struct page *page = pte_page(pte);
> 
>         if (!test_and_set_bit(PG_dcache_clean, &page->flags))
>                 sync_icache_aliases(page_address(page), page_size(page));
> }
> 
> So arm64 keeps track on a per-page basis which ones have been flushed.
> page_size() will return PAGE_SIZE if called on a tail page or regular
> page, but will return PAGE_SIZE << compound_order if called on a head
> page.  So this will either over-flush, or it's missing the opportunity
> to clear the bits on all the subpages which have now been flushed.

Hmm, that seems to go all the way back to 2014 as the result of a bug fix
in 923b8f5044da ("arm64: mm: Make icache synchronisation logic huge page
aware") which has a Reported-by Mark and a CC stable, suggesting something
_was_ going wrong at the time :/ Was there a point where the tail pages
could end up with PG_arch_1 uncleared on allocation?

> What would you _like_ to see?  Would you rather flush_dcache_page()
> were called once for each subpage, or would you rather maintain
> the page-needs-flushing state once per compound page?  We could also
> introduce flush_dcache_thp() if some architectures would prefer it one
> way and one the other, although that brings into question what to do
> for hugetlbfs pages.

For arm64, we'd like to see PG_arch_1 preserved during huge page splitting
[1], but there was a worry that it might break x86 and s390. It's also not
clear to me that we can change __sync_icache_dcache() as it's called when
we're installing the entry in the page-table, so why would it be called
again for the tail pages?

Will

[1] https://lore.kernel.org/linux-arch/20200703153718.16973-8-catalin.marinas@arm.com/
