From: Ed L Cashin <ecashin@uga.edu>
Date: Wed, 21 Jan 2004 17:21:06 +0000
Subject: Re: TLB miss handler code
Message-Id: <87brox1am5.fsf@uga.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
In-Reply-To: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> So, in nearly 3 days of this thread nobody has discovered
> the arch/sparc64/kernel/{itlb,dtlb}_*.S files yet.
>
> I find this particularly amusing :-)

It is funny, but I bet there are lurkers who know and aren't speaking
up.

Examining those files (although my sparc asm isn't good) it looks like
not all TLB misses go through do_sparc64_fault, which I suppose is
your point.  In fact, it looks like do_sparc64_fault gets invoked only
when the instruction causing the TLB miss is also causing a page
fault.  I had mistakenly assumed that (fault_code & FAULT_CODE_?TLB)
inside of do_sparc64_fault meant it was just a TLB miss.

Rather, if it's just a TLB miss, the fast handler itself takes care of
filling the TLB.  (I'm unfamiliar with the "retry" instruction, but
the comment says "Trap return".)  

I really do not understand how it is getting the pte so fast.  It
looks like it doesn't do any locking but just performs a couple quick
calculations to get the address of the pte.

Incidentally, why are those fast TLB-miss handlers in
arch/sparc64/kernel and not arch/sparc64/mm?

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

