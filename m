From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 09:41:18 +0000
Subject: Re: HyperSPARC RT625 Cache Controler, Ross CY7C605 Cache
Message-Id: <20080828.024118.166054084.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Piet Delaney <piet.delaney@tensilica.com>
Date: Thu, 28 Aug 2008 02:29:44 -0700

> I noticed that some of the sparc MMU code had support for coloring
> in a mm hyperSPARC file, but it seemed to be related to DMA. In our
> current code we do cache flushes in the user copy code for copies
> that would cause dirty aliases cache lines and have additional code
> like pte_alloc_one_kernel() in arch/xtensa/mm/pgtable.c which keeps
> allocating pages until it gets one with a compatible color.  I
> haven't seen anything odd like this in the SPARC mm code yet.  How
> does the Linux SPARC code deal with cache coloring support for
> Sun4m?

It handles it by:

1) Enforcing a mmap() shared writable memory boundary equal to
   the L2 cache size.

2) When colors cannot avoid being violated, we flush the cache.

It's extremely expensive, especially on SMP.  And #2 happens
a lot because we access user mapped pages on the kernel side
using a fixed linear mapping and thus a fixed color, and
that color often conflicts with the virtual address userspace
is using for the same page, so we have to cache flush.

