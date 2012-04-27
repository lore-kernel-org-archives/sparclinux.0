From: David Miller <davem@davemloft.net>
Date: Fri, 27 Apr 2012 17:34:07 +0000
Subject: Re: [PATCH] sparc64: Use node local allocations for IRQ stacks.
Message-Id: <20120427.133407.61533308345211487.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120426.235507.1967848292117984225.davem@davemloft.net>
In-Reply-To: <20120426.235507.1967848292117984225.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 27 Apr 2012 19:27:50 +0200

> This assignment looks redundant. I cannot see any uses of max_mapnr
> in the kernel (which is relevant for sparc64).

pfn_valid() via asm-generic/page.h

> Knowing that sparc64 just got converted to NO_BOOTMEM it
> hurts my eyes to see memblock_alloc() be replaced
> by __alloc_bootmem_node().

Since the stack allocations happen now (for the sake of setting
up the NUMA mappings) after bootmem init, it's prudent to use
the alloc_bootmem interfaces.

Not only visually, but syntactically as it provides:

1) fallbacks to non-NUMA allocations when NUMA node specific
   allocations fail.

2) a virtual pointer to zero'd memory so we don't need that __va() and
   memset crap
