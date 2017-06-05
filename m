From: David Miller <davem@davemloft.net>
Date: Mon, 05 Jun 2017 02:27:46 +0000
Subject: Re: [v1 2/6] sparc64: access tick function from variable
Message-Id: <20170604.222746.42222438487794944.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1496428854-936411-3-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1496428854-936411-3-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri,  2 Jun 2017 14:40:50 -0400

> In timer_64.c tick functions are access via pointer (tick_ops), every time
> clock is read, there is one extra load to get to the function.
> 
> This patch optimizes it, by accessing functions pointer from value.
> 
> Current ched_clock():
> sethi  %hi(0xb9b400), %g1
> ldx  [ %g1 + 0x250 ], %g1  ! <tick_ops>
> ldx  [ %g1 ], %g1
> call  %g1
> nop
> sethi  %hi(0xb9b400), %g1
> ldx  [ %g1 + 0x300 ], %g1  ! <timer_ticks_per_nsec_quotient>
> mulx  %o0, %g1, %g1
> rett  %i7 + 8
> srlx  %g1, 0xa, %o0
> 
> New sched_clock():
> sethi  %hi(0xb9b400), %g1
> ldx  [ %g1 + 0x340 ], %g1
> call  %g1
> nop
> sethi  %hi(0xb9b400), %g1
> ldx  [ %g1 + 0x378 ], %g1
> mulx  %o0, %g1, %g1
> rett  %i7 + 8
> srlx  %g1, 0xa, %o0
> 
> Before three loads, now two loads.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>

For the tick read itself itt's probably time for code patching, and
thus taking the number of loads down to one.

It's not that hard, the largest code sequence is for hummingbird which
is about 13 or 14 instructions.

So just make a tick_get_tick() assembler function that's a software
trap instruction and then 14 or 15 nops.  Patch in the correct
assembler into this function as early as possible, and then just call
it directly instead of using the ops.

We do this for so many things (TLB flushes etc.) so there are many
examples to cull the implementation from.

In the end we'll get your early boot timestamps for free, load count
wise.

Thanks.
