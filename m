From: David Miller <davem@davemloft.net>
Date: Sat, 27 Sep 2014 18:28:12 +0000
Subject: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20140927.142812.2031647355756795530.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Ok Bob, I hope this finally does it.

We now move fully to 4 level page tables. :-)

64-bit userland can now take advantage of this increased virtual
address space as well.

The other adjustment here is that we increase the size of the vmalloc
region, as needed, so that embedded percpu areas should always fit.

This has openned the door for a bunch of cleanups.  For example, we
could put the OBP mappings into the kernel page tables and consolidate
several ktlb code paths.  In fact, everything should be serviced from
the kernel page tables at that point and the only thing to take care
with is to properly use the 4MB kernel TSB rather than the 8Kb kernel
TSB when handling PAGE_OFFSET linear area misses when DEBUG_PAGEALLOC
is disabled.

Anyways, let me know how these work for you.  I'll be running tests
on my T4-2 all weekend.

Signed-off-by: David S. Miller <davem@davemloft.net>
