From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 06 Jan 2009 19:52:06 +0000
Subject: Re: ftrace breaks sparc64 build
Message-Id: <20090106195206.GA16880@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.DEB.1.10.0901051458460.25066@gandalf.stny.rr.com> <20090106.103234.163615537.davem@davemloft.net> <alpine.DEB.1.10.0901061342570.10871@gandalf.stny.rr.com> <20090106.110114.103656110.davem@davemloft.net>
In-Reply-To: <20090106.110114.103656110.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org, srostedt@redhat.com, mingo@elte.hu, sparclinux@vger.kernel.org

On Tue, Jan 06, 2009 at 11:01:14AM -0800, David Miller wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> Date: Tue, 6 Jan 2009 13:52:36 -0500 (EST)
> 
> > I would hate to black list archs just because it gives warnings.
> 
> At the very least arch/sparc should build cleanly now because
> I took your ldc.c change

Unfortunately not.
With sparc64 I saw warnings in three additional files.
I cooked up the following to avoid the warnings.

The patch to unaligned_64.c is just an ugly hack.
The patch in viohs.c makes it easier to read IMO.
The patch to init_64.c is likewise a nice cleanup.

I will re-review and submit the latter two as proper patches.
I see no way to refactor unaligned_64.c so it keep
current behaviour and is equal readable.

	Sam

diff --git a/arch/sparc/kernel/unaligned_64.c b/arch/sparc/kernel/unaligned_64.c
index 203ddfa..f005799 100644
--- a/arch/sparc/kernel/unaligned_64.c
+++ b/arch/sparc/kernel/unaligned_64.c
@@ -601,11 +601,13 @@ void handle_lddfmna(struct pt_regs *regs, unsigned long sfar, unsigned long sfsr
 		pc = (u32)pc;
 	if (get_user(insn, (u32 __user *) pc) != -EFAULT) {
 		int asi = decode_asi(insn, regs);
+		int rfirst, rsecond;
 		if ((asi > ASI_SNFL) ||
 		    (asi < ASI_P))
 			goto daex;
-		if (get_user(first, (u32 __user *)sfar) ||
-		     get_user(second, (u32 __user *)(sfar + 4))) {
+		rfirst = get_user(first, (u32 __user *)sfar);
+		rsecond = get_user(second, (u32 __user *)(sfar + 4));
+		if (rfirst || rsecond) {
 			if (asi & 0x2) /* NF */ {
 				first = 0; second = 0;
 			} else
diff --git a/arch/sparc/kernel/viohs.c b/arch/sparc/kernel/viohs.c
index 708fa17..aa6ac70 100644
--- a/arch/sparc/kernel/viohs.c
+++ b/arch/sparc/kernel/viohs.c
@@ -337,8 +337,10 @@ static int process_ver_nack(struct vio_driver_state *vio,
 	viodbg(HS, "GOT VERSION NACK maj[%u] min[%u] devclass[%u]\n",
 	       pkt->major, pkt->minor, pkt->dev_class);
 
-	if ((pkt->major = 0 && pkt->minor = 0) ||
-	    !(nver = find_by_major(vio, pkt->major)))
+	if (pkt->major = 0 && pkt->minor = 0)
+		return handshake_failure(vio);
+	nver = find_by_major(vio, pkt->major);
+	if (!nver)
 		return handshake_failure(vio);
 
 	if (send_version(vio, nver->major, nver->minor) < 0)
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index c04b111..26f59df 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -259,21 +259,15 @@ static inline void tsb_insert(struct tsb *ent, unsigned long tag, unsigned long
 unsigned long _PAGE_ALL_SZ_BITS __read_mostly;
 unsigned long _PAGE_SZBITS __read_mostly;
 
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t pte)
+static void try_flush_dcache(unsigned long pfn)
 {
-	struct mm_struct *mm;
-	struct tsb *tsb;
-	unsigned long tag, flags;
-	unsigned long tsb_index, tsb_hash_shift;
+	unsigned long pg_flags;
+	struct page *page;
 
-	if (tlb_type != hypervisor) {
-		unsigned long pfn = pte_pfn(pte);
-		unsigned long pg_flags;
-		struct page *page;
-
-		if (pfn_valid(pfn) &&
-		    (page = pfn_to_page(pfn), page_mapping(page)) &&
-		    ((pg_flags = page->flags) & (1UL << PG_dcache_dirty))) {
+	page = pfn_to_page(pfn);
+	if (page && page_mapping(page)) {
+		pg_flags = page->flags;
+		if (pg_flags & (1UL << PG_dcache_dirty)) {
 			int cpu = ((pg_flags >> PG_dcache_cpu_shift) &
 				   PG_dcache_cpu_mask);
 			int this_cpu = get_cpu();
@@ -291,6 +285,21 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t p
 			put_cpu();
 		}
 	}
+}
+
+void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t pte)
+{
+	struct mm_struct *mm;
+	struct tsb *tsb;
+	unsigned long tag, flags;
+	unsigned long tsb_index, tsb_hash_shift;
+
+	if (tlb_type != hypervisor) {
+		unsigned long pfn = pte_pfn(pte);
+
+		if (pfn_valid(pfn))
+			try_flush_dcache(pfn);
+	}
 
 	mm = vma->vm_mm;
 

