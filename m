From: "David S. Miller" <davem@davemloft.net>
Date: Sun, 31 Oct 2004 01:50:31 +0000
Subject: Re: flush_dcache_page()/flush_icache_page() for larger page sizes
Message-Id: <20041030185031.3aabf6b2.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20041029230347.GK12934@holomorphy.com>
In-Reply-To: <20041029230347.GK12934@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 29 Oct 2004 16:03:47 -0700
William Lee Irwin III <wli@holomorphy.com> wrote:

> I'm trying to figure out how to implement analogues of flush_icache_page()
> and flush_dcache_page() for larger pagesizes (or otherwise determine if
> I need to at all) on UltraSPARC, and am having trouble tracking down
> the relevant documentation. If someone could name some relevant
> document(s), I'd be much obliged.

If you use a 16K or larger page size (which means anything other
than the current 8K) flush_dcache_page() is totally unnecessary
as D-cache aliases become impossible with 16K and larger page sizes.
See the L1DCACHE_SIZE > PAGE_SIZE checks in routines such as
arch/sparc64/mm/init.c:fluah_dcache_page_impl() and friends.

flush_icache_page() is really easy to cons up.  Just do a loop
of "flushi %0" for the first address in each 32-byte block of
the page.  Use virtual addresses.  Ie:

#include <asm/system.h>

	for (addr = page_vaddr; addr < page_vaddr + PAGE_SIZE; addr += 32)
		flushi(addr);

There is a lot of code in the sparc64 port which is there explicitly
to handle multiple page sizes.

Actually, __flush_dcache_page() as written will handle any page size.
It searches the entire 16K D-cache for the matching physical addresses.

Everywhere I look there is code handling the various page sizes
appropriately.  If you're asking for how to implement these
flushes you must see some case which isn't handled, what might
that be?
