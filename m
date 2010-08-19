From: David Miller <davem@davemloft.net>
Date: Thu, 19 Aug 2010 00:16:28 +0000
Subject: Re: [PATCH] sparc64: simple microoptimizations for atomic functions
Message-Id: <20100818.171628.15253701.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1008181402450.9287@hs20-bc2-1.build.redhat.com>
In-Reply-To: <Pine.LNX.4.64.1008181402450.9287@hs20-bc2-1.build.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 18 Aug 2010 19:44:05 -0400 (EDT)

> 
> 
> On Wed, 18 Aug 2010, David Miller wrote:
> 
>> These routines, when contention backoff is disabled, have
>> intentionally been coded to be perfectly 8 instructions, which is
>> exactly 32 bytes, which is exactly 1 I-cache line.  You'll find that
>> much of the by-hand sparc64 assembler routines have been written to be
>> a multiple of 8 instructions.
> 
> They are not:
> 0000000000000000 <atomic_add>:
> 0000000000000028 <atomic_sub>:
> 0000000000000050 <atomic_add_ret>:
> 000000000000007c <atomic_sub_ret>:
> 00000000000000a8 <atomic64_add>:
> 00000000000000d0 <atomic64_sub>:
> 00000000000000f8 <atomic64_add_ret>:
> 0000000000000124 <atomic64_sub_ret>:
> 
> (on UP compile without backoff). That dummy backoff code produces jump 
> forward and backward.

That's a bug, it should be just an empty macro expansion.

>> So actually you're changes are likely to hurt performance from a cache
>> line and pipelining viewpoint.
>> 
>> Furthermore, talking about saving one cycle (which I don't even think
>> you'll get) when the CAS instruction itself is going to stall the chip
>> for ~50 cycles is not all that worthwhile either.
> 
> If it's like x86 --- i.e. flush the whole pipe and execute microcode, that 
> it doesn't make much sense to optimize ticks in the pipeline.

Yes, CAS bascially puts a bunch of micro-ops into the pipeline to
do the load/compare/conditional-store atomically.

