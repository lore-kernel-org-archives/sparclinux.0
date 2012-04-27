From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 27 Apr 2012 17:58:16 +0000
Subject: Re: [PATCH] sparc64: Use node local allocations for IRQ stacks.
Message-Id: <20120427175816.GA5591@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120426.235507.1967848292117984225.davem@davemloft.net>
In-Reply-To: <20120426.235507.1967848292117984225.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Apr 27, 2012 at 01:34:07PM -0400, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Fri, 27 Apr 2012 19:27:50 +0200
> 
> > This assignment looks redundant. I cannot see any uses of max_mapnr
> > in the kernel (which is relevant for sparc64).
> 
> pfn_valid() via asm-generic/page.h

asm-generic/page.h is for non-MMU architectures.
It includes:
#ifdef CONFIG_MMU
#error need to prove a real asm/page.h
#endif

> 
> > Knowing that sparc64 just got converted to NO_BOOTMEM it
> > hurts my eyes to see memblock_alloc() be replaced
> > by __alloc_bootmem_node().
> 
> Since the stack allocations happen now (for the sake of setting
> up the NUMA mappings) after bootmem init, it's prudent to use
> the alloc_bootmem interfaces.

It was my understanding that everything provided by mm/nobootmem.c
is wrappers provided for backward compatibility with the old
bootmem based early allocator.
And that we later would make this file optional when.

But I seems to be wrong here.

	Sam
