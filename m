From: Mike Rapoport <rppt@kernel.org>
Date: Tue, 28 Jul 2020 05:11:43 +0000
Subject: [PATCH 05/15] h8300, nds32, openrisc: simplify detection of memory extents
Message-Id: <20200728051153.1590-6-rppt@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200728051153.1590-1-rppt@kernel.org>
In-Reply-To: <20200728051153.1590-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Stafford Horne <shorne@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Palmer Dabbelt <palmer@dabbelt.com>, Christoph Hellwig <hch@lst.de>, Mike Rapoport <rppt@kernel.org>

From: Mike Rapoport <rppt@linux.ibm.com>

Instead of traversing memblock.memory regions to find memory_start and
memory_end, simply query memblock_{start,end}_of_DRAM().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/h8300/kernel/setup.c    | 8 +++-----
 arch/nds32/kernel/setup.c    | 8 ++------
 arch/openrisc/kernel/setup.c | 9 ++-------
 3 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/arch/h8300/kernel/setup.c b/arch/h8300/kernel/setup.c
index 28ac88358a89..0281f92eea3d 100644
--- a/arch/h8300/kernel/setup.c
+++ b/arch/h8300/kernel/setup.c
@@ -74,17 +74,15 @@ static void __init bootmem_init(void)
 	memory_end = memory_start = 0;
 
 	/* Find main memory where is the kernel */
-	for_each_memblock(memory, region) {
-		memory_start = region->base;
-		memory_end = region->base + region->size;
-	}
+	memory_start = memblock_start_of_DRAM();
+	memory_end = memblock_end_of_DRAM();
 
 	if (!memory_end)
 		panic("No memory!");
 
 	/* setup bootmem globals (we use no_bootmem, but mm still depends on this) */
 	min_low_pfn = PFN_UP(memory_start);
-	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
+	max_low_pfn = PFN_DOWN(memory_end);
 	max_pfn = max_low_pfn;
 
 	memblock_reserve(__pa(_stext), _end - _stext);
diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
index a066efbe53c0..c356e484dcab 100644
--- a/arch/nds32/kernel/setup.c
+++ b/arch/nds32/kernel/setup.c
@@ -249,12 +249,8 @@ static void __init setup_memory(void)
 	memory_end = memory_start = 0;
 
 	/* Find main memory where is the kernel */
-	for_each_memblock(memory, region) {
-		memory_start = region->base;
-		memory_end = region->base + region->size;
-		pr_info("%s: Memory: 0x%x-0x%x\n", __func__,
-			memory_start, memory_end);
-	}
+	memory_start = memblock_start_of_DRAM();
+	memory_end = memblock_end_of_DRAM();
 
 	if (!memory_end) {
 		panic("No memory!");
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 8aa438e1f51f..c5706153d3b6 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -48,17 +48,12 @@ static void __init setup_memory(void)
 	unsigned long ram_start_pfn;
 	unsigned long ram_end_pfn;
 	phys_addr_t memory_start, memory_end;
-	struct memblock_region *region;
 
 	memory_end = memory_start = 0;
 
 	/* Find main memory where is the kernel, we assume its the only one */
-	for_each_memblock(memory, region) {
-		memory_start = region->base;
-		memory_end = region->base + region->size;
-		printk(KERN_INFO "%s: Memory: 0x%x-0x%x\n", __func__,
-		       memory_start, memory_end);
-	}
+	memory_start = memblock_start_of_DRAM();
+	memory_end = memblock_end_of_DRAM();
 
 	if (!memory_end) {
 		panic("No memory!");
-- 
2.26.2
