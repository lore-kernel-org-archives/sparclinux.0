From: Ed L Cashin <ecashin@uga.edu>
Date: Wed, 21 Jan 2004 22:11:29 +0000
Subject: Re: TLB miss handler code
Message-Id: <87broxj6jy.fsf@uga.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
In-Reply-To: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

...
> The page tables of the current process are mapped virtually and linearlly
> starting at VPTE_BASE, in this way a PTE lookup is merely computed via
> VPTE_BASE + (tlb_miss_vaddr >> SHIFT).
>
> This can, itself, cause a TLB miss, for the VPTE_BASE page table mapping,
> which is serviced by the code in dtlb_backend.S.

That seems like a very clever idea.  At least it's very efficient!  

>> Incidentally, why are those fast TLB-miss handlers in
>> arch/sparc64/kernel and not arch/sparc64/mm?
>
> Bacause these handlers are included directly in the trap table.

OK.  Thanks much for the response.  It is a lot more concrete now.

I think Nawab Ali (the OP) has his work cut out for him, though.
Logging the pte on every TLB miss sounds tricky at best, given that
these fast handlers will service most misses.

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

