From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 18 Aug 2010 23:44:05 +0000
Subject: Re: [PATCH] sparc64: simple microoptimizations for atomic functions
Message-Id: <Pine.LNX.4.64.1008181933540.17901@hs20-bc2-1.build.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1008181402450.9287@hs20-bc2-1.build.redhat.com>
In-Reply-To: <Pine.LNX.4.64.1008181402450.9287@hs20-bc2-1.build.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Wed, 18 Aug 2010, David Miller wrote:

> From: Mikulas Patocka <mpatocka@redhat.com>
> Date: Wed, 18 Aug 2010 18:08:49 -0400 (EDT)
> 
> > I don't think such microoptimizations can be measured. It may save an 
> > I-cacheline --- but who knows if exactly this cacheline makes some effect 
> > or not?
> 
> These routines, when contention backoff is disabled, have
> intentionally been coded to be perfectly 8 instructions, which is
> exactly 32 bytes, which is exactly 1 I-cache line.  You'll find that
> much of the by-hand sparc64 assembler routines have been written to be
> a multiple of 8 instructions.

They are not:
0000000000000000 <atomic_add>:
0000000000000028 <atomic_sub>:
0000000000000050 <atomic_add_ret>:
000000000000007c <atomic_sub_ret>:
00000000000000a8 <atomic64_add>:
00000000000000d0 <atomic64_sub>:
00000000000000f8 <atomic64_add_ret>:
0000000000000124 <atomic64_sub_ret>:

(on UP compile without backoff). That dummy backoff code produces jump 
forward and backward.

> Because if you don't start a function on an I-cache line you get a
> partial fetch when it's called, therefore making it impossible to fill
> the pipeline even if the instructions could be executed in parallel.

So add .align there.

> So actually you're changes are likely to hurt performance from a cache
> line and pipelining viewpoint.
> 
> Furthermore, talking about saving one cycle (which I don't even think
> you'll get) when the CAS instruction itself is going to stall the chip
> for ~50 cycles is not all that worthwhile either.

If it's like x86 --- i.e. flush the whole pipe and execute microcode, that 
it doesn't make much sense to optimize ticks in the pipeline. Optimizing 
for cache pollution could make some sense.

Mikulas

> The UltraSPARC-I,II,III et al. programming manuals are pretty clear
> about code generation guidelines, I've been reading them for 10+
> years, and that is what I've used to guide the writing of the
> assembler code.  I've also run the code through simulators (when
> possible) and done cycle analysis (both hot and cold cache cases) on
> real hardware for these routines.
> 
> So I basically expect the same kind of considerations from you if you
> want to "optimize" this code :-)
> 
> I value your contribution but seriously I think the code is fine and
> optimal as-is.
> 
