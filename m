From: Mike Rapoport <rppt@kernel.org>
Date: Sun, 24 May 2020 16:53:58 +0000
Subject: [PATCH] sparc32: register memory occupied by kernel as memblock.memory
Message-Id: <20200524165358.27188-1-rppt@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>

From: Mike Rapoport <rppt@linux.ibm.com>

sparc32 never registered the memory occupied by the kernel image with
memblock_add() and it only reserved this memory with meblock_reserve().

With openbios as system firmware, the memory occupied by the kernel is
reserved in openbios and removed from mem.available. The prom setup code in
the kernel uses mem.available to set up the memory banks and essentially
there is a hole for the memory occupied by the kernel image.

Later in bootmem_init() this memory is memblock_reserve()d.

Up until recently, memmap initialization would call __init_single_page()
for the pages in that hole, the free_low_memory_core_early() would mark
them as reserved and everything would be Ok.

After the change in memmap initialization introduced by the commit "mm:
memmap_init: iterate over memblock regions rather that check each PFN", the
hole is skipped and the page structs for it are not initialized. And when
they are passed from memblock to page allocator as reserved, the latter
gets confused.

Simply registering the memory occupied by the kernel with memblock_add()
resolves this issue.

Tested on qemu-system-sparc with Debian Etch [1] userspace.

[1] https://people.debian.org/~aurel32/qemu/sparc/debian_etch_sparc_small.qcow2

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Link: https://lkml.kernel.org/r/20200517000050.GA87467@roeck-us.nlllllet/ 
---

David,

I'd really appreciate your Ack or an explanation where my analysis is wrong :)

 arch/sparc/mm/init_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index e45160839f79..eb2946b1df8a 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -192,6 +192,7 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 	/* Reserve the kernel text/data/bss. */
 	size = (start_pfn << PAGE_SHIFT) - phys_base;
 	memblock_reserve(phys_base, size);
+	memblock_add(phys_base, size);
 
 	size = memblock_phys_mem_size() - memblock_reserved_size();
 	*pages_avail = (size >> PAGE_SHIFT) - high_pages;
-- 
2.26.2
