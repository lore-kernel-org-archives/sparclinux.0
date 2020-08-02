From: Mike Rapoport <rppt@kernel.org>
Date: Sun, 02 Aug 2020 16:35:51 +0000
Subject: [PATCH v2 07/17] mircoblaze: drop unneeded NUMA and sparsemem initializations
Message-Id: <20200802163601.8189-8-rppt@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200802163601.8189-1-rppt@kernel.org>
In-Reply-To: <20200802163601.8189-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Baoquan He <bhe@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@lst.de>, Dave Hansen <dave.hansen@linux.intel.com>, Emil Renner Berthing <kernel@esmil.dk>, Ingo Molnar <mingo@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>

From: Mike Rapoport <rppt@linux.ibm.com>

microblaze does not support neither NUMA not SPARSMEM, so there is no point
to call memblock_set_node() and sparse_memory_present_with_active_regions()
functions during microblaze memory initialization.

Remove these calls and the surrounding code.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/microblaze/mm/init.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 521b59ba716c..49e0c241f9b1 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -105,9 +105,8 @@ static void __init paging_init(void)
 
 void __init setup_memory(void)
 {
-	struct memblock_region *reg;
-
 #ifndef CONFIG_MMU
+	struct memblock_region *reg;
 	u32 kernel_align_start, kernel_align_size;
 
 	/* Find main memory where is the kernel */
@@ -161,20 +160,6 @@ void __init setup_memory(void)
 	pr_info("%s: max_low_pfn: %#lx\n", __func__, max_low_pfn);
 	pr_info("%s: max_pfn: %#lx\n", __func__, max_pfn);
 
-	/* Add active regions with valid PFNs */
-	for_each_memblock(memory, reg) {
-		unsigned long start_pfn, end_pfn;
-
-		start_pfn = memblock_region_memory_base_pfn(reg);
-		end_pfn = memblock_region_memory_end_pfn(reg);
-		memblock_set_node(start_pfn << PAGE_SHIFT,
-				  (end_pfn - start_pfn) << PAGE_SHIFT,
-				  &memblock.memory, 0);
-	}
-
-	/* XXX need to clip this if using highmem? */
-	sparse_memory_present_with_active_regions(0);
-
 	paging_init();
 }
 
-- 
2.26.2
