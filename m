From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Wed, 09 Sep 2020 10:38:58 +0000
Subject: Re: Flushing transparent hugepages
Message-Id: <87tuw74559.fsf@linux.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200818150736.GQ17456@casper.infradead.org>
In-Reply-To: <20200818150736.GQ17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>, linux-arch@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vineet Gupta <vgupta@synopsys.com>, linuxppc-dev@lists.ozlabs.org, Russell King <linux@armlinux.org.uk>, linux-mips@vger.kernel.org, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org

Matthew Wilcox <willy@infradead.org> writes:

> PowerPC has special handling of hugetlbfs pages.  Well, that's what
> the config option says, but actually it handles THP as well.  If
> the config option is enabled.
>
> #ifdef CONFIG_HUGETLB_PAGE
>         if (PageCompound(page)) {
>                 flush_dcache_icache_hugepage(page);
>                 return;
>         }
> #endif

I do have a change posted sometime back to avoid that confusion.
http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20200320103256.229365-1-aneesh.kumar@linux.ibm.com/

But IIUC we use the head page flags (PG_arch_1) to track whether we need
the flush or not.

>
> By the way, THPs can be mapped askew -- that is, at an offset which
> means you can't use a PMD to map a PMD sized page.
>
> Anyway, we don't really have consensus between the various architectures
> on how to handle either THPs or hugetlb pages.  It's not contemplated
> in Documentation/core-api/cachetlb.rst so there's no real surprise
> we've diverged.
>
> What would you _like_ to see?  Would you rather flush_dcache_page()
> were called once for each subpage, or would you rather maintain
> the page-needs-flushing state once per compound page?  We could also
> introduce flush_dcache_thp() if some architectures would prefer it one
> way and one the other, although that brings into question what to do
> for hugetlbfs pages.
>
> It might not be a bad idea to centralise the handling of all this stuff
> somewhere.  Sounds like the kind of thing Arnd would like to do ;-) I'll
> settle for getting enough clear feedback about what the various arch
> maintainers want that I can write a documentation update for cachetlb.rst.
