From: "David S. Miller" <davem@redhat.com>
Date: Wed, 21 Jan 2004 21:34:55 +0000
Subject: Re: TLB miss handler code
Message-Id: <20040121133455.6dc86673.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
In-Reply-To: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 21 Jan 2004 12:21:06 -0500
Ed L Cashin <ecashin@uga.edu> wrote:

> I really do not understand how it is getting the pte so fast.  It
> looks like it doesn't do any locking but just performs a couple quick
> calculations to get the address of the pte.

The page tables of the current process are mapped virtually and linearlly
starting at VPTE_BASE, in this way a PTE lookup is merely computed via
VPTE_BASE + (tlb_miss_vaddr >> SHIFT).

This can, itself, cause a TLB miss, for the VPTE_BASE page table mapping,
which is serviced by the code in dtlb_backend.S.

> Incidentally, why are those fast TLB-miss handlers in
> arch/sparc64/kernel and not arch/sparc64/mm?

Bacause these handlers are included directly in the trap table.
