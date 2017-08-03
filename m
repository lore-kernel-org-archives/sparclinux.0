From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 03 Aug 2017 21:23:39 +0000
Subject: [v5 01/15] x86/mm: reserve only exiting low pages
Message-Id: <1501795433-982645-2-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1501795433-982645-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1501795433-982645-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Struct pages are initialized by going through __init_single_page(). Since
the existing physical memory in memblock is represented in memblock.memory
list, struct page for every page from this list goes through
__init_single_page().

The second memblock list: memblock.reserved, manages the allocated memory.
The memory that won't be available to kernel allocator. So, every page from
this list goes through reserve_bootmem_region(), where certain struct page
fields are set, the assumption being that the struct pages have been
initialized beforehand.

In trim_low_memory_range() we unconditionally reserve memoryfrom PFN 0, but
memblock.memory might start at a later PFN. For example, in QEMU,
e820__memblock_setup() can use PFN 1 as the first PFN in memblock.memory,
so PFN 0 is not on memblock.memory (and hence isn't initialized via
__init_single_page) but is on memblock.reserved (and hence we set fields in
the uninitialized struct page).

Currently, the struct page memory is always zeroed during allocation,
which prevents this problem from being detected. But, if some asserts
provided by CONFIG_DEBUG_VM_PGFLAGS are tighten, this problem may become
visible in existing kernels.

In this patchset we will stop zeroing struct page memory during allocation.
Therefore, this bug must be fixed in order to avoid random assert failures
caused by CONFIG_DEBUG_VM_PGFLAGS triggers.

The fix is to reserve memory from the first existing PFN.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
---
 arch/x86/kernel/setup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3486d0498800..489cdc141bcb 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -790,7 +790,10 @@ early_param("reservelow", parse_reservelow);
 
 static void __init trim_low_memory_range(void)
 {
-	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
+	unsigned long min_pfn = find_min_pfn_with_active_regions();
+	phys_addr_t base = min_pfn << PAGE_SHIFT;
+
+	memblock_reserve(base, ALIGN(reserve_low, PAGE_SIZE));
 }
 	
 /*
-- 
2.13.4

