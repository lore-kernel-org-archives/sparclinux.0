From: Bob Picco <bpicco@meloft.net>
Date: Sat, 27 Sep 2014 20:46:51 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20140927204651.GL4211@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Sat Sep 27 2014, 02:28:12PM EDT]
> 
> Ok Bob, I hope this finally does it.
Me too.
> 
> We now move fully to 4 level page tables. :-)
Okay.
> 
> 64-bit userland can now take advantage of this increased virtual
> address space as well.
Okay.
> 
> The other adjustment here is that we increase the size of the vmalloc
> region, as needed, so that embedded percpu areas should always fit.
Okay.
> 
> This has openned the door for a bunch of cleanups.  For example, we
> could put the OBP mappings into the kernel page tables and consolidate
> several ktlb code paths.  In fact, everything should be serviced from
> the kernel page tables at that point and the only thing to take care
> with is to properly use the 4MB kernel TSB rather than the 8Kb kernel
> TSB when handling PAGE_OFFSET linear area misses when DEBUG_PAGEALLOC
> is disabled.
Okay.
> 
> Anyways, let me know how these work for you.  I'll be running tests
> on my T4-2 all weekend.
I'll commence with T5-2 which is local to me.

M7-4 came up with an older kernel of mine but with hardware faults.

thanx!
