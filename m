From: David Miller <davem@davemloft.net>
Date: Wed, 18 Aug 2010 23:03:30 +0000
Subject: Re: [PATCH] sparc64: simple microoptimizations for atomic functions
Message-Id: <20100818.160330.35031080.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1008181402450.9287@hs20-bc2-1.build.redhat.com>
In-Reply-To: <Pine.LNX.4.64.1008181402450.9287@hs20-bc2-1.build.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 18 Aug 2010 18:08:49 -0400 (EDT)

> I don't think such microoptimizations can be measured. It may save an 
> I-cacheline --- but who knows if exactly this cacheline makes some effect 
> or not?

These routines, when contention backoff is disabled, have
intentionally been coded to be perfectly 8 instructions, which is
exactly 32 bytes, which is exactly 1 I-cache line.  You'll find that
much of the by-hand sparc64 assembler routines have been written to be
a multiple of 8 instructions.

Because if you don't start a function on an I-cache line you get a
partial fetch when it's called, therefore making it impossible to fill
the pipeline even if the instructions could be executed in parallel.

So actually you're changes are likely to hurt performance from a cache
line and pipelining viewpoint.

Furthermore, talking about saving one cycle (which I don't even think
you'll get) when the CAS instruction itself is going to stall the chip
for ~50 cycles is not all that worthwhile either.

The UltraSPARC-I,II,III et al. programming manuals are pretty clear
about code generation guidelines, I've been reading them for 10+
years, and that is what I've used to guide the writing of the
assembler code.  I've also run the code through simulators (when
possible) and done cycle analysis (both hot and cold cache cases) on
real hardware for these routines.

So I basically expect the same kind of considerations from you if you
want to "optimize" this code :-)

I value your contribution but seriously I think the code is fine and
optimal as-is.
