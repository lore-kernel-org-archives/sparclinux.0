From: David Miller <davem@davemloft.net>
Date: Mon, 28 May 2007 03:16:45 +0000
Subject: Re: [RFT] [SPARC] Emulate cmpxchg like parisc
Message-Id: <20070527.201645.63127984.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070525201143.GB14171@fattire.cabal.ca>
In-Reply-To: <20070525201143.GB14171@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kyle McMartin <kyle@parisc-linux.org>
Date: Sun, 27 May 2007 23:11:14 -0400

> Yeah, David Howells wanted to use cmpxchg in his work struct patch, but
> had to not because not everyone implements it.
> 
> >From what I can tell, very few arches actually have CAS, and others
> emulate it with LL/SC type implementations.

That's fine, as a LL/SC implementation of cmpxchg() is fully
atomic and would work in concert with a userspace cmpxchg()
implemented with LL/SC.

It's the platforms that lack CAS _and_ some kind of LL/SC
which are problematic.

Sparc32 SMP cpus (sparcv8 sun4m and later) have a 'swap' instruction
but that does not have an inifinite consensus number like CAS and
LL/SC, so it can't be used to implement cmpxchg() (and also the
non-SMP sparc32 chips lack the instruction).
