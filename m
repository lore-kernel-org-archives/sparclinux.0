From: David Miller <davem@davemloft.net>
Date: Thu, 03 Sep 2009 09:54:25 +0000
Subject: Re: SILO & Ext4
Message-Id: <20090903.025425.253601562.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Mon, 8 Jun 2009 01:01:00 +0100 (BST)

> Last time I looked at this, the primary problem was not where the
> kernel was loaded but that it only relocated the first 3 MB of kernel
> thus restricting the kernel to a maximum size of 3 MB
> (.text+.data). It is a relativly simple patch to head.S to change this
> to 8 MB which sould be enough to provide a usable kernel.

This is true on sun4c, and it's controlled by this constant
0x300000 loaded into %g5 in arch/sparc/kernel/head_32.S:

sun4c_remap:
		mov	0, %g3			! source base
		set	KERNBASE, %g4		! destination base
		set	0x300000, %g5		! upper bound 3MB
		mov	1, %l6
		sll	%l6, 18, %l6		! sun4c mmu segmap size

(same applies to the sun4_mutant_remap and sun4_normal_remap code)

For sun4m/sun4d SRMMU, we inherit up to 16MB of whatever is
mapped at address 0x0.  This corresponds to one PGD entry
in the PGD table for context 0, and is copied by the following
for non-Viking srmmu chips:

srmmu_nviking:
		set	AC_M_CTPR, %g1
		lda	[%g1] ASI_M_MMUREGS, %g1	! get ctx table ptr
		sll	%g1, 0x4, %g1			! make physical addr
		lda	[%g1] ASI_M_BYPASS, %g1		! ptr to level 1 pg_table
		srl	%g1, 0x4, %g1
		sll	%g1, 0x8, %g1			! make phys addr for l1 tbl

		lda	[%g1] ASI_M_BYPASS, %g2		! get level1 entry for 0x0
		add	%g1, KERNBASE >> (SRMMU_PGDIR_SHIFT - 2), %g3
		sta	%g2, [%g3] ASI_M_BYPASS		! place at KERNBASE entry

So for the sun4c case, yes, increasing the 3MB constant in the
sun4c_remap code would help us get further here.

And srmmu should already be propagating up to 16MB of mappings.

But the next issue is to make sure that the code in the memory
management initialization also is ready to handle this mapping
inheritance properly.

For SRMMU, it seems to me that arch/sparc/mm/srmmu.c:map_kernel()
is doing this (note that: KERNBASE = PAGE_OFFSET).

For SUN4C, the arch/sparc/mm/sun4c.c:sun4c_init_map_kernelprom() code
looks like it locks into the TLB everything up to symbol &_end so
that should be good too.

But of course this has been tried I guess and it doesn't work so
simply like that for whatever reason :-)
