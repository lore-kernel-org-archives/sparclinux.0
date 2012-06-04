From: David Miller <davem@davemloft.net>
Date: Mon, 04 Jun 2012 20:32:21 +0000
Subject: Re: sparc32: some more testing
Message-Id: <20120604.163221.2026535893727793130.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
In-Reply-To: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 4 Jun 2012 21:43:25 +0200

> I need to find a way to extend the initial mapping without the need
> to access allocated memory.

There may be an easy way to do this, depending upon the what we can
expect when we're loaded into physical memory.

The SRMMU page table allows you to map PTE's at any level of the
three-level page table hierarchy.  The interpretation of the entries
is determined by the lowest bits, these are the SRMMU_ET_* values.

So at the top PGD level, you can encode a 16MB PTE.

At the PMD level, you can encode a 256K PTE.

And of course at the PTE level you can encode a normal 4K PTE.

So let's say that we can determine that we're always mapped using
a 16MB aligned piece of physical memory, well them you can just
do something like write a series of 16MB PTEs into the PGD slots
that correspond go KERNBASE.

You won't need to allocate any ram to do this.  You just write the
PGD entries which already exist.

The head_32.S code does some of this for you already.  It locates
the PGD table the prom has mapped us with, and calculates the
entry for KERNBASE:

		lda	[%g4] ASI_M_BYPASS, %o1		! This is a level 1 ptr
		srl	%o1, 0x4, %o1			! Clear low 4 bits
		sll	%o1, 0x8, %o1			! Make physical

Now %o1 contains the physical address of the PGD table that maps the
kernel.

		/* Ok, pull in the PTD. */
		lda	[%o1] ASI_M_BYPASS, %o2		! This is the 0x0 16MB pgd

This is loading pgd[0]

		add	%o1, KERNBASE >> (SRMMU_PGDIR_SHIFT - 2), %o3

%o3 now holds "&pgd[KERNBASE >> SRMMU_PGDIR_SHIFT]", entries written
here influence the translations made for KERNBASE.

		sta	%o2, [%o3] ASI_M_BYPASS

And then this just stores pgd[0] into pgd[KERNBASE >> SRMMU_PGDIR_SHIFT].

So what you might want to try is changing that last store into
code implementing a different strategy.

First, figure out where we're mapped by chasing the page table chains
to figure out what physical address the kernel is mapped at.  The
first level dereference is done by the second load above, so in %o2
we have the PGD for virtual address 0x0.

		and	%o2, SRMMU_ET_MASK, %g1
		cmp	%g1, SRMMU_ET_PTE
		be	have_pte
		 andn	%o2, SRMMU_ET_MASK, %o2
		lda	[%o2] ASI_M_BYPASS, %o2		! PMD
		and	%o2, SRMMU_ET_MASK, %g1
		cmp	%g1, SRMMU_ET_PTE
		be	have_pte
		 andn	%o2, SRMMU_ET_MASK, %o2
		lda	[%o2] ASI_M_BYPASS, %o2		! PTE
		and	%o2, SRMMU_ET_MASK, %g1
		cmp	%g1, SRMMU_ET_PTE
		be	have_pte
		 andn	%o2, SRMMU_ET_MASK, %o2
		ba,a	MAPPING_BUG
	...
have_pte:
		/* Clear non-page bits */
		srl	%o2, 8, %o2
		sll	%o2, 8, %o2

And now %o2 is the physical page the kernel was mapped at.
Now you can try to validate if it is 16MB aligned or not.

		sethi	%hi(1 << 24), %g1
		andncc	%o2, %g1, %g0
		bne	MAPPING_NOT_16MB_ALIGNED
		 nop

Assuming we pass that test, you can then construct the 16MB
ptes to place info the PGD slots for KERNBASE.

#define KERN_MAP	(SRMMU_ET_PTE | SRMMU_CACHE | SRMMU_PRIV \
			 SRMMU_DIRTY | SRMMU_REF)

		or	%o2, KERN_MAP, %o2
		st	%o2, [%o3] ASI_M_BYPASS
		add	%o2, %g1, %o2
		add	%o3, 4, %o3
		st	%o2, [%o3] ASI_M_BYPASS
		add	%o2, %g1, %o2
		add	%o3, 4, %o3
		st	%o2, [%o3] ASI_M_BYPASS
		add	%o2, %g1, %o2
		add	%o3, 4, %o3
		st	%o2, [%o3] ASI_M_BYPASS

That should map the first 64MB at KERNBASE.

Hope this helps.

			      
		
