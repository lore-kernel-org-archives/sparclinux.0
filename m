From: Ed L Cashin <ecashin@uga.edu>
Date: Wed, 21 Jan 2004 16:43:20 +0000
Subject: Re: TLB miss handler code
Message-Id: <87fze96ymv.fsf@uga.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
In-Reply-To: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Nawab Ali <alin@ececs.uc.edu> writes:

> Hi Ed,
> Thanx for pointing out the file. I checked out the do_sparc64_fault
> function in arch/sparc64/mm/fault.c (2.6.0).
>
> This is the code snippet I found.
> if ((fault_code & FAULT_CODE_ITLB) && (fault_code & FAULT_CODE_DTLB))
> 	BUG();

That case is a bug, so it's not what you're looking for.  The test
checks whether the fault code says that it's a dTLB *and* an iTLB
miss, which doesn't make any sense.

You're interested in the non-buggy case.  In 2.6.0-test11, I can
follow that the call sequence: do_sparc64_fault calls
mm/memory.c:handle_mm_fault which calls handle_pte_fault.  Eventually
update_mmu_cache and the assembly __update_mmu_cache are called.

arch/sparc64/mm/ultra.S has the actual code that fills the TLBs.  All
you have to do is decide where in that path it makes sense for you to
add your code.  Maybe about the time update_mmu_cache is called.

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

