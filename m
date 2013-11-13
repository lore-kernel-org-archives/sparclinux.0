From: Bob Picco <bpicco@meloft.net>
Date: Wed, 13 Nov 2013 22:23:02 +0000
Subject: Re: [PATCH v3 9/9] sparc64: Encode huge PMDs using PTE encoding.
Message-Id: <20131113222302.GC30860@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20131113.021856.1528152135184652144.davem@davemloft.net>
In-Reply-To: <20131113.021856.1528152135184652144.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Wed Nov 13 2013, 03:54:52PM EST]
> From: David Miller <davem@davemloft.net>
> Date: Wed, 13 Nov 2013 15:26:30 -0500 (EST)
> 
> > From: David Miller <davem@davemloft.net>
> > Date: Wed, 13 Nov 2013 15:25:36 -0500 (EST)
> > 
> >> From: Bob Picco <bpicco@meloft.net>
> >> Date: Wed, 13 Nov 2013 09:42:47 -0500
> >> 
> >>>>  		addr &= HPAGE_MASK;
> >>>> -		if (pmd_val(orig) & PMD_ISHUGE) {
> >>> 						^^
> >>> 					The left curly bracket was dropped.
> >> 
> >> I can't believe it, but it compiles with the brace both present, and removed.
> >> I don't know how this is possible.
> > 
> > Nevermind, my config lacked TRANSPARENT_HUGEPAGE, ignore me :-)
> 
> Ok here is the fixed version of patch #9, thanks Bob.
> 
> --------------------
> [PATCH v4 9/9] sparc64: Encode huge PMDs using PTE encoding.
> 
> Now that we have 64-bits for PMDs we can stop using special encodings
> for the huge PMD values, and just put real PTEs in there.
> 
> We allocate a _PAGE_PMD_HUGE bit to distinguish between plain PMDs and
> huge ones.  It is the same for both 4U and 4V PTE layouts.
> 
> We also use _PAGE_SPECIAL to indicate the splitting state, since a
> huge PMD cannot also be special.
> 
> All of the PMD --> PTE translation code disappears, and most of the
> huge PMD bit modifications and tests just degenerate into the PTE
> operations.  In particular USER_PGTABLE_CHECK_PMD_HUGE becomes
> trivial.
> 
> As a side effect, normal PMDs don't shift the physical address around.
> This also speeds up the page table walks in the TLB miss paths since
> they don't have to do the shifts any more.
> 
> Another non-trivial aspect is that pte_modify() has to be changed
> to preserve the _PAGE_PMD_HUGE bits as well as the page size field
> of the pte.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
Acked-by: Bob Picco <bob.picco@oracle.com>
