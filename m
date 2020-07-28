From: Mike Rapoport <rppt@kernel.org>
Date: Tue, 28 Jul 2020 05:11:44 +0000
Subject: [PATCH 06/15] powerpc: fadamp: simplify fadump_reserve_crash_area()
Message-Id: <20200728051153.1590-7-rppt@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200728051153.1590-1-rppt@kernel.org>
In-Reply-To: <20200728051153.1590-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Stafford Horne <shorne@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Palmer Dabbelt <palmer@dabbelt.com>, Christoph Hellwig <hch@lst.de>, Mike Rapoport <rppt@kernel.org>

From: Mike Rapoport <rppt@linux.ibm.com>

fadump_reserve_crash_area() reserves memory from a specified base address
till the end of the RAM.

Replace iteration through the memblock.memory with a single call to
memblock_reserve() with appropriate  that will take care of proper memory
reservation.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/powerpc/kernel/fadump.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 78ab9a6ee6ac..2446a61e3c25 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1658,25 +1658,7 @@ int __init fadump_reserve_mem(void)
 /* Preserve everything above the base address */
 static void __init fadump_reserve_crash_area(u64 base)
 {
-	struct memblock_region *reg;
-	u64 mstart, msize;
-
-	for_each_memblock(memory, reg) {
-		mstart = reg->base;
-		msize  = reg->size;
-
-		if ((mstart + msize) < base)
-			continue;
-
-		if (mstart < base) {
-			msize -= (base - mstart);
-			mstart = base;
-		}
-
-		pr_info("Reserving %lluMB of memory at %#016llx for preserving crash data",
-			(msize >> 20), mstart);
-		memblock_reserve(mstart, msize);
-	}
+	memblock_reserve(base, memblock_end_of_DRAM() - base);
 }
 
 unsigned long __init arch_reserved_kernel_pages(void)
-- 
2.26.2
