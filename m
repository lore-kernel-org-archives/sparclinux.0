From: David Miller <davem@davemloft.net>
Date: Wed, 17 Sep 2014 21:00:48 +0000
Subject: Re: [PATCH] sparc64: valid physical address bitmap
Message-Id: <20140917.170048.1791485242002606199.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410886337-16116-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410886337-16116-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Tue, 16 Sep 2014 12:52:17 -0400

> From: bob picco <bpicco@meloft.net>
> 
> We need to constrain the size of sparc64_valid_addr_bitmap. Historically
> it has been sized according to maximum physical address and 4Mb DIMM size.
> This was sufficient with older sparc64 before larger physical address bits.
> 
> This patch limits the bitmap to 64Kb by a smaller value for a physical
> address bits which cover the vast majority of sparc64.
> 
> The last_valid_pfn is used to limit the physical address limit within
> the ktlb miss for identity address checking and increase the megabyte shift
> granularity of the check for a valid pfn.
> 
> An LDOM guest might have an issue with this depending on how the PA to
> RA ranges were assigned by the control domain. Though this issue already
> seems to exist for a granularity less than 4Mb which is the current
> bitmap shift and test.
> 
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Bob Picco <bob.picco@oracle.com>

Let's stop fighting this thing.

Instead, let's just kill the bitmap off completely and scan the 'reg'
property of the 'memory' OF node.  It's well formed and very small,
and now it doesn't matter what granularity works or not for LDOM
guests as well.

Bonus is that the BSS section shrinks by 4MB after this change.

This is a really delicate change, the more testing the better.  I've
only done basic sanity tests on T4-2 so far.

==========
[PATCH] sparc64: Kill sparc64_valid_addr_bitmap.

It keeps growing as we try and increase the number of physical memory
bits we support.

We really don't need it, we can just loop over the 'memory' OF node's
'reg' property which represents all valid physical memory.  These
arrays tend to be well formed, and not very large at all.

Since we are now using this in the kernel TLB miss handler fast path
we perform some straightforward transformations on the array.  First,
we merge as many entries together as we can, there are several prtconf
dumps I've seen where this will trigger.

Second, we mark the end of the array with a zero entry, so that the
kernel TLB miss handler has to keep less state in registers during the
scan.

The BSS section is now 4MB smaller after this change.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/page_64.h    |   3 -
 arch/sparc/include/asm/pgtable_64.h |  10 +--
 arch/sparc/kernel/ktlb.S            |  67 +++++----------
 arch/sparc/mm/init_64.c             | 159 +++++++++++++++++-------------------
 arch/sparc/mm/init_64.h             |   3 -
 5 files changed, 97 insertions(+), 145 deletions(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index bf10998..4af4e69 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -129,9 +129,6 @@ extern unsigned long PAGE_OFFSET;
  */
 #define MAX_PHYS_ADDRESS_BITS	47
 
-/* These two shift counts are used when indexing sparc64_valid_addr_bitmap
- * and kpte_linear_bitmap.
- */
 #define ILOG2_4MB		22
 #define ILOG2_256MB		28
 
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 3770bf5..895a9c3 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -73,15 +73,7 @@
 
 #include <linux/sched.h>
 
-extern unsigned long sparc64_valid_addr_bitmap[];
-
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-static inline bool __kern_addr_valid(unsigned long paddr)
-{
-	if ((paddr >> MAX_PHYS_ADDRESS_BITS) != 0UL)
-		return false;
-	return test_bit(paddr >> ILOG2_4MB, sparc64_valid_addr_bitmap);
-}
+bool __kern_addr_valid(unsigned long paddr);
 
 static inline bool kern_addr_valid(unsigned long addr)
 {
diff --git a/arch/sparc/kernel/ktlb.S b/arch/sparc/kernel/ktlb.S
index 605d492..7036a65 100644
--- a/arch/sparc/kernel/ktlb.S
+++ b/arch/sparc/kernel/ktlb.S
@@ -150,68 +150,39 @@ kvmap_dtlb_4v:
 	 * Must preserve %g1 and %g6 (TAG).
 	 */
 kvmap_dtlb_tsb4m_miss:
-	/* Clear the PAGE_OFFSET top virtual bits, shift
-	 * down to get PFN, and make sure PFN is in range.
-	 */
+	/* Clear the PAGE_OFFSET top virtual bits. */
 661:	sllx		%g4, 0, %g5
 	.section	.page_offset_shift_patch, "ax"
 	.word		661b
 	.previous
 
-	/* Check to see if we know about valid memory at the 4MB
-	 * chunk this physical address will reside within.
-	 */
-661:	srlx		%g5, MAX_PHYS_ADDRESS_BITS, %g2
-	.section	.page_offset_shift_patch, "ax"
-	.word		661b
-	.previous
-
-	brnz,pn		%g2, kvmap_dtlb_longpath
-	 nop
-
-	/* This unconditional branch and delay-slot nop gets patched
-	 * by the sethi sequence once the bitmap is properly setup.
-	 */
-	.globl		valid_addr_bitmap_insn
-valid_addr_bitmap_insn:
-	ba,pt		%xcc, 2f
-	 nop
-	.subsection	2
-	.globl		valid_addr_bitmap_patch
-valid_addr_bitmap_patch:
-	sethi		%hi(sparc64_valid_addr_bitmap), %g7
-	or		%g7, %lo(sparc64_valid_addr_bitmap), %g7
-	.previous
+	sethi		%hi(pall), %g7
 
-661:	srlx		%g5, ILOG2_4MB, %g2
+	/* Physical address in %g5. */
+661:	srlx		%g5, 0, %g5
 	.section	.page_offset_shift_patch, "ax"
 	.word		661b
 	.previous
 
-	srlx		%g2, 6, %g5
-	and		%g2, 63, %g2
-	sllx		%g5, 3, %g5
-	ldx		[%g7 + %g5], %g5
-	mov		1, %g7
-	sllx		%g7, %g2, %g7
-	andcc		%g5, %g7, %g0
-	be,pn		%xcc, kvmap_dtlb_longpath
-
-2:	 sethi		%hi(kpte_linear_bitmap), %g2
+	or		%g7, %lo(pall), %g7
 
-	/* Get the 256MB physical address index. */
-661:	sllx		%g4, 0, %g5
-	.section	.page_offset_shift_patch, "ax"
-	.word		661b
-	.previous
+1:	ldx		[%g7 + 0x08], %g3		/* reg_size */
+	ldx		[%g7 + 0x00], %g2		/* phys_addr */
+	brz,pn		%g3, kvmap_dtlb_longpath	/* end of array? */
+	 cmp		%g5, %g2
+	blu,pn		%xcc, 8f
+	 add		%g2, %g3, %g2
+	cmp		%g5, %g2
+	blu,pt		%xcc, 2f			/* full match */
+	 nop
+8:	ba,pt		%xcc, 1b
+	 add		%g7, 0x10, %g7
 
+	/* Physical address is still in %g5. */
+2:	sethi		%hi(kpte_linear_bitmap), %g2
+	srlx		%g5, ILOG2_256MB, %g5
 	or		%g2, %lo(kpte_linear_bitmap), %g2
 
-661:	srlx		%g5, ILOG2_256MB, %g5
-	.section	.page_offset_shift_patch, "ax"
-	.word		661b
-	.previous
-
 	and		%g5, (32 - 1), %g7
 
 	/* Divide by 32 to get the offset into the bitmask.  */
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index c30a796..4acabb0 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -165,10 +165,6 @@ static void __init read_obp_memory(const char *property,
 	     cmp_p64, NULL);
 }
 
-unsigned long sparc64_valid_addr_bitmap[VALID_ADDR_BITMAP_BYTES /
-					sizeof(unsigned long)];
-EXPORT_SYMBOL(sparc64_valid_addr_bitmap);
-
 /* Kernel physical address base and size in bytes.  */
 unsigned long kern_base __read_mostly;
 unsigned long kern_size __read_mostly;
@@ -1366,8 +1362,82 @@ static unsigned long __init bootmem_init(unsigned long phys_base)
 	return end_pfn;
 }
 
-static struct linux_prom64_registers pall[MAX_BANKS] __initdata;
-static int pall_ents __initdata;
+/* pall[] is exported for the sake of the kernel linear TLB miss handler */
+struct linux_prom64_registers pall[MAX_BANKS + 1];
+static int pall_ents;
+
+bool __kern_addr_valid(unsigned long paddr)
+{
+	int i;
+
+	for (i = 0; i < pall_ents; i++) {
+		struct linux_prom64_registers *p = &pall[i];
+
+		if (paddr < p->phys_addr)
+			continue;
+		if (paddr >= (p->phys_addr + p->reg_size))
+			continue;
+
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(__kern_addr_valid);
+
+static void __init optimize_pall(void)
+{
+	int i;
+
+	/* First pass, strip out all zero length entries.  This is important
+	 * because a zero reg_size marks the end of the array.
+	 */
+	for (i = 0; i < pall_ents; i++) {
+		struct linux_prom64_registers *p = &pall[i];
+
+		if (p->reg_size)
+			continue;
+
+		memmove(p, p + 1, (pall_ents - i) * sizeof(*p));
+		pall_ents--;
+		i--;
+	}
+
+	/* Second pass, merge all adjacent entries.  */
+	for (i = 0; i < pall_ents; i++) {
+		struct linux_prom64_registers *p = &pall[i];
+		unsigned long begin, end;
+		int j;
+
+		begin = p->phys_addr;
+		end = p->phys_addr + p->reg_size;
+		for (j = i + 1; j < pall_ents; j++) {
+			struct linux_prom64_registers *q;
+
+			q = &pall[j];
+			if (end = q->phys_addr) {
+				end += q->reg_size;
+			} else if (begin = q->phys_addr + q->reg_size) {
+				begin -= q->reg_size;
+			} else
+				continue;
+
+			memmove(q, q + 1, (pall_ents - j) * sizeof(*q));
+			pall_ents--;
+
+			j--;
+		}
+
+		p->phys_addr = begin;
+		p->reg_size = end - begin;
+	}
+
+	/* Force a sentinal after the last entry to simplify the kernel TLB miss
+	 * handler's scan of this table.
+	 */
+	pall[pall_ents].phys_addr = 0UL;
+	pall[pall_ents].reg_size = 0UL;
+}
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static unsigned long __ref kernel_map_range(unsigned long pstart,
@@ -2011,6 +2081,7 @@ void __init paging_init(void)
 	 */
 	read_obp_translations();
 	read_obp_memory("reg", &pall[0], &pall_ents);
+	optimize_pall();
 	read_obp_memory("available", &pavail[0], &pavail_ents);
 	read_obp_memory("available", &pavail[0], &pavail_ents);
 
@@ -2160,70 +2231,6 @@ int page_in_phys_avail(unsigned long paddr)
 	return 0;
 }
 
-static struct linux_prom64_registers pavail_rescan[MAX_BANKS] __initdata;
-static int pavail_rescan_ents __initdata;
-
-/* Certain OBP calls, such as fetching "available" properties, can
- * claim physical memory.  So, along with initializing the valid
- * address bitmap, what we do here is refetch the physical available
- * memory list again, and make sure it provides at least as much
- * memory as 'pavail' does.
- */
-static void __init setup_valid_addr_bitmap_from_pavail(unsigned long *bitmap)
-{
-	int i;
-
-	read_obp_memory("available", &pavail_rescan[0], &pavail_rescan_ents);
-
-	for (i = 0; i < pavail_ents; i++) {
-		unsigned long old_start, old_end;
-
-		old_start = pavail[i].phys_addr;
-		old_end = old_start + pavail[i].reg_size;
-		while (old_start < old_end) {
-			int n;
-
-			for (n = 0; n < pavail_rescan_ents; n++) {
-				unsigned long new_start, new_end;
-
-				new_start = pavail_rescan[n].phys_addr;
-				new_end = new_start +
-					pavail_rescan[n].reg_size;
-
-				if (new_start <= old_start &&
-				    new_end >= (old_start + PAGE_SIZE)) {
-					set_bit(old_start >> ILOG2_4MB, bitmap);
-					goto do_next_page;
-				}
-			}
-
-			prom_printf("mem_init: Lost memory in pavail\n");
-			prom_printf("mem_init: OLD start[%lx] size[%lx]\n",
-				    pavail[i].phys_addr,
-				    pavail[i].reg_size);
-			prom_printf("mem_init: NEW start[%lx] size[%lx]\n",
-				    pavail_rescan[i].phys_addr,
-				    pavail_rescan[i].reg_size);
-			prom_printf("mem_init: Cannot continue, aborting.\n");
-			prom_halt();
-
-		do_next_page:
-			old_start += PAGE_SIZE;
-		}
-	}
-}
-
-static void __init patch_tlb_miss_handler_bitmap(void)
-{
-	extern unsigned int valid_addr_bitmap_insn[];
-	extern unsigned int valid_addr_bitmap_patch[];
-
-	valid_addr_bitmap_insn[1] = valid_addr_bitmap_patch[1];
-	mb();
-	valid_addr_bitmap_insn[0] = valid_addr_bitmap_patch[0];
-	flushi(&valid_addr_bitmap_insn[0]);
-}
-
 static void __init register_page_bootmem_info(void)
 {
 #ifdef CONFIG_NEED_MULTIPLE_NODES
@@ -2236,18 +2243,6 @@ static void __init register_page_bootmem_info(void)
 }
 void __init mem_init(void)
 {
-	unsigned long addr, last;
-
-	addr = PAGE_OFFSET + kern_base;
-	last = PAGE_ALIGN(kern_size) + addr;
-	while (addr < last) {
-		set_bit(__pa(addr) >> ILOG2_4MB, sparc64_valid_addr_bitmap);
-		addr += PAGE_SIZE;
-	}
-
-	setup_valid_addr_bitmap_from_pavail(sparc64_valid_addr_bitmap);
-	patch_tlb_miss_handler_bitmap();
-
 	high_memory = __va(last_valid_pfn << PAGE_SHIFT);
 
 	register_page_bootmem_info();
diff --git a/arch/sparc/mm/init_64.h b/arch/sparc/mm/init_64.h
index 0668b36..bdef0a6 100644
--- a/arch/sparc/mm/init_64.h
+++ b/arch/sparc/mm/init_64.h
@@ -11,9 +11,6 @@
 #define KPTE_BITMAP_CHUNK_SZ		(256UL * 1024UL * 1024UL)
 #define KPTE_BITMAP_BYTES	\
 	((MAX_PHYS_ADDRESS / KPTE_BITMAP_CHUNK_SZ) / 4)
-#define VALID_ADDR_BITMAP_CHUNK_SZ	(4UL * 1024UL * 1024UL)
-#define VALID_ADDR_BITMAP_BYTES	\
-	((MAX_PHYS_ADDRESS / VALID_ADDR_BITMAP_CHUNK_SZ) / 8)
 
 extern unsigned long kern_linear_pte_xor[4];
 extern unsigned long kpte_linear_bitmap[KPTE_BITMAP_BYTES / sizeof(unsigned long)];
-- 
1.8.1.2

