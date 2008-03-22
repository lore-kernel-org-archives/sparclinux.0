From: David Miller <davem@davemloft.net>
Date: Sat, 22 Mar 2008 00:15:13 +0000
Subject: Re: [SILO PATCH]: Support larger sparc64 kernels
Message-Id: <20080321.171513.50078766.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080321.171208.194307718.davem@davemloft.net>
In-Reply-To: <20080321.171208.194307718.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 21 Mar 2008 17:12:08 -0700 (PDT)

> This SILO patch, coupled with a sparc64 kernel patch which
> I've checked into the sparc-2.6 GIT tree and will post
> as a follow-up, allows up to 64MB kernel images.

And here is that kernel patch:

commit 64658743fdd40021e3ac91e8ff260ad06578dd23
Author: David S. Miller <davem@davemloft.net>
Date:   Fri Mar 21 17:01:38 2008 -0700

    [SPARC64]: Remove most limitations to kernel image size.
    
    Currently kernel images are limited to 8MB in size, and this causes
    problems especially when enabling features that take up a lot of
    kernel image space such as lockdep.
    
    The code now will align the kernel image size up to 4MB and map that
    many locked TLB entries.  So, the only practical limitation is the
    number of available locked TLB entries which is 16 on Cheetah and 64
    on pre-Cheetah sparc64 cpus.  Niagara cpus don't actually have hw
    locked TLB entry support.  Rather, the hypervisor transparently
    provides support for "locked" TLB entries since it runs with physical
    addressing and does the initial TLB miss processing.
    
    Fully utilizing this change requires some help from SILO, a patch for
    which will be submitted to the maintainer.  Essentially, SILO will
    only currently map up to 8MB for the kernel image and that needs to be
    increased.
    
    Note that neither this patch nor the SILO bits will help with network
    booting.  The openfirmware code will only map up to a certain amount
    of kernel image during a network boot and there isn't much we can to
    about that other than to implemented a layered network booting
    facility.  Solaris has this, and calls it "wanboot" and we may
    implement something similar at some point.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/kernel/head.S b/arch/sparc64/kernel/head.S
index 44b105c..34f8ff5 100644
--- a/arch/sparc64/kernel/head.S
+++ b/arch/sparc64/kernel/head.S
@@ -288,8 +288,12 @@ sun4v_chip_type:
 	/* Leave arg2 as-is, prom_mmu_ihandle_cache */
 	mov	-1, %l3
 	stx	%l3, [%sp + 2047 + 128 + 0x28]	! arg3: mode (-1 default)
-	sethi	%hi(8 * 1024 * 1024), %l3
-	stx	%l3, [%sp + 2047 + 128 + 0x30]	! arg4: size (8MB)
+	/* 4MB align the kernel image size. */
+	set	(_end - KERNBASE), %l3
+	set	((4 * 1024 * 1024) - 1), %l4
+	add	%l3, %l4, %l3
+	andn	%l3, %l4, %l3
+	stx	%l3, [%sp + 2047 + 128 + 0x30]	! arg4: roundup(ksize, 4MB)
 	sethi	%hi(KERNBASE), %l3
 	stx	%l3, [%sp + 2047 + 128 + 0x38]	! arg5: vaddr (KERNBASE)
 	stx	%g0, [%sp + 2047 + 128 + 0x40]	! arg6: empty
diff --git a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
index cc45473..5a1126b 100644
--- a/arch/sparc64/kernel/smp.c
+++ b/arch/sparc64/kernel/smp.c
@@ -284,14 +284,17 @@ static void ldom_startcpu_cpuid(unsigned int cpu, unsigned long thread_reg)
 {
 	extern unsigned long sparc64_ttable_tl0;
 	extern unsigned long kern_locked_tte_data;
-	extern int bigkernel;
 	struct hvtramp_descr *hdesc;
 	unsigned long trampoline_ra;
 	struct trap_per_cpu *tb;
 	u64 tte_vaddr, tte_data;
 	unsigned long hv_err;
+	int i;
 
-	hdesc = kzalloc(sizeof(*hdesc), GFP_KERNEL);
+	hdesc = kzalloc(sizeof(*hdesc) +
+			(sizeof(struct hvtramp_mapping) *
+			 num_kernel_image_mappings - 1),
+			GFP_KERNEL);
 	if (!hdesc) {
 		printk(KERN_ERR "ldom_startcpu_cpuid: Cannot allocate "
 		       "hvtramp_descr.\n");
@@ -299,7 +302,7 @@ static void ldom_startcpu_cpuid(unsigned int cpu, unsigned long thread_reg)
 	}
 
 	hdesc->cpu = cpu;
-	hdesc->num_mappings = (bigkernel ? 2 : 1);
+	hdesc->num_mappings = num_kernel_image_mappings;
 
 	tb = &trap_block[cpu];
 	tb->hdesc = hdesc;
@@ -312,13 +315,11 @@ static void ldom_startcpu_cpuid(unsigned int cpu, unsigned long thread_reg)
 	tte_vaddr = (unsigned long) KERNBASE;
 	tte_data = kern_locked_tte_data;
 
-	hdesc->maps[0].vaddr = tte_vaddr;
-	hdesc->maps[0].tte   = tte_data;
-	if (bigkernel) {
+	for (i = 0; i < hdesc->num_mappings; i++) {
+		hdesc->maps[i].vaddr = tte_vaddr;
+		hdesc->maps[i].tte   = tte_data;
 		tte_vaddr += 0x400000;
 		tte_data  += 0x400000;
-		hdesc->maps[1].vaddr = tte_vaddr;
-		hdesc->maps[1].tte   = tte_data;
 	}
 
 	trampoline_ra = kimage_addr_to_ra(hv_cpu_startup);
diff --git a/arch/sparc64/kernel/trampoline.S b/arch/sparc64/kernel/trampoline.S
index 4ae2e52..56ff552 100644
--- a/arch/sparc64/kernel/trampoline.S
+++ b/arch/sparc64/kernel/trampoline.S
@@ -105,7 +105,7 @@ startup_continue:
 	wr		%g2, 0, %tick_cmpr
 
 	/* Call OBP by hand to lock KERNBASE into i/d tlbs.
-	 * We lock 2 consequetive entries if we are 'bigkernel'.
+	 * We lock 'num_kernel_image_mappings' consequetive entries.
 	 */
 	sethi		%hi(prom_entry_lock), %g2
 1:	ldstub		[%g2 + %lo(prom_entry_lock)], %g1
@@ -119,6 +119,29 @@ startup_continue:
 	add		%l2, -(192 + 128), %sp
 	flushw
 
+	/* Setup the loop variables:
+	 * %l3: VADDR base
+	 * %l4: TTE base
+	 * %l5: Loop iterator, iterates from 0 to 'num_kernel_image_mappings'
+	 * %l6: Number of TTE entries to map
+	 * %l7: Highest TTE entry number, we count down
+	 */
+	sethi		%hi(KERNBASE), %l3
+	sethi		%hi(kern_locked_tte_data), %l4
+	ldx		[%l4 + %lo(kern_locked_tte_data)], %l4
+	clr		%l5
+	sethi		%hi(num_kernel_image_mappings), %l6
+	lduw		[%l6 + %lo(num_kernel_image_mappings)], %l6
+	add		%l6, 1, %l6
+
+	mov		15, %l7
+	BRANCH_IF_ANY_CHEETAH(g1,g5,2f)
+
+	mov		63, %l7
+2:
+
+3:
+	/* Lock into I-MMU */
 	sethi		%hi(call_method), %g2
 	or		%g2, %lo(call_method), %g2
 	stx		%g2, [%sp + 2047 + 128 + 0x00]
@@ -132,63 +155,26 @@ startup_continue:
 	sethi		%hi(prom_mmu_ihandle_cache), %g2
 	lduw		[%g2 + %lo(prom_mmu_ihandle_cache)], %g2
 	stx		%g2, [%sp + 2047 + 128 + 0x20]
-	sethi		%hi(KERNBASE), %g2
-	stx		%g2, [%sp + 2047 + 128 + 0x28]
-	sethi		%hi(kern_locked_tte_data), %g2
-	ldx		[%g2 + %lo(kern_locked_tte_data)], %g2
-	stx		%g2, [%sp + 2047 + 128 + 0x30]
-
-	mov		15, %g2
-	BRANCH_IF_ANY_CHEETAH(g1,g5,1f)
 
-	mov		63, %g2
-1:
-	stx		%g2, [%sp + 2047 + 128 + 0x38]
-	sethi		%hi(p1275buf), %g2
-	or		%g2, %lo(p1275buf), %g2
-	ldx		[%g2 + 0x08], %o1
-	call		%o1
-	 add		%sp, (2047 + 128), %o0
+	/* Each TTE maps 4MB, convert index to offset.  */
+	sllx		%l5, 22, %g1
 
-	sethi		%hi(bigkernel), %g2
-	lduw		[%g2 + %lo(bigkernel)], %g2
-	brz,pt		%g2, do_dtlb
-	 nop
+	add		%l3, %g1, %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x28]	! VADDR
+	add		%l4, %g1, %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x30]	! TTE
 
-	sethi		%hi(call_method), %g2
-	or		%g2, %lo(call_method), %g2
-	stx		%g2, [%sp + 2047 + 128 + 0x00]
-	mov		5, %g2
-	stx		%g2, [%sp + 2047 + 128 + 0x08]
-	mov		1, %g2
-	stx		%g2, [%sp + 2047 + 128 + 0x10]
-	sethi		%hi(itlb_load), %g2
-	or		%g2, %lo(itlb_load), %g2
-	stx		%g2, [%sp + 2047 + 128 + 0x18]
-	sethi		%hi(prom_mmu_ihandle_cache), %g2
-	lduw		[%g2 + %lo(prom_mmu_ihandle_cache)], %g2
-	stx		%g2, [%sp + 2047 + 128 + 0x20]
-	sethi		%hi(KERNBASE + 0x400000), %g2
-	stx		%g2, [%sp + 2047 + 128 + 0x28]
-	sethi		%hi(kern_locked_tte_data), %g2
-	ldx		[%g2 + %lo(kern_locked_tte_data)], %g2
-	sethi		%hi(0x400000), %g1
-	add		%g2, %g1, %g2
-	stx		%g2, [%sp + 2047 + 128 + 0x30]
-
-	mov		14, %g2
-	BRANCH_IF_ANY_CHEETAH(g1,g5,1f)
-
-	mov		62, %g2
-1:
+	/* TTE index is highest minus loop index.  */
+	sub		%l7, %l5, %g2
 	stx		%g2, [%sp + 2047 + 128 + 0x38]
+
 	sethi		%hi(p1275buf), %g2
 	or		%g2, %lo(p1275buf), %g2
 	ldx		[%g2 + 0x08], %o1
 	call		%o1
 	 add		%sp, (2047 + 128), %o0
 
-do_dtlb:
+	/* Lock into D-MMU */
 	sethi		%hi(call_method), %g2
 	or		%g2, %lo(call_method), %g2
 	stx		%g2, [%sp + 2047 + 128 + 0x00]
@@ -202,65 +188,30 @@ do_dtlb:
 	sethi		%hi(prom_mmu_ihandle_cache), %g2
 	lduw		[%g2 + %lo(prom_mmu_ihandle_cache)], %g2
 	stx		%g2, [%sp + 2047 + 128 + 0x20]
-	sethi		%hi(KERNBASE), %g2
-	stx		%g2, [%sp + 2047 + 128 + 0x28]
-	sethi		%hi(kern_locked_tte_data), %g2
-	ldx		[%g2 + %lo(kern_locked_tte_data)], %g2
-	stx		%g2, [%sp + 2047 + 128 + 0x30]
 
-	mov		15, %g2
-	BRANCH_IF_ANY_CHEETAH(g1,g5,1f)
+	/* Each TTE maps 4MB, convert index to offset.  */
+	sllx		%l5, 22, %g1
 
-	mov		63, %g2
-1:
+	add		%l3, %g1, %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x28]	! VADDR
+	add		%l4, %g1, %g2
+	stx		%g2, [%sp + 2047 + 128 + 0x30]	! TTE
 
+	/* TTE index is highest minus loop index.  */
+	sub		%l7, %l5, %g2
 	stx		%g2, [%sp + 2047 + 128 + 0x38]
+
 	sethi		%hi(p1275buf), %g2
 	or		%g2, %lo(p1275buf), %g2
 	ldx		[%g2 + 0x08], %o1
 	call		%o1
 	 add		%sp, (2047 + 128), %o0
 
-	sethi		%hi(bigkernel), %g2
-	lduw		[%g2 + %lo(bigkernel)], %g2
-	brz,pt		%g2, do_unlock
+	add		%l5, 1, %l5
+	cmp		%l5, %l6
+	bne,pt		%xcc, 3b
 	 nop
 
-	sethi		%hi(call_method), %g2
-	or		%g2, %lo(call_method), %g2
-	stx		%g2, [%sp + 2047 + 128 + 0x00]
-	mov		5, %g2
-	stx		%g2, [%sp + 2047 + 128 + 0x08]
-	mov		1, %g2
-	stx		%g2, [%sp + 2047 + 128 + 0x10]
-	sethi		%hi(dtlb_load), %g2
-	or		%g2, %lo(dtlb_load), %g2
-	stx		%g2, [%sp + 2047 + 128 + 0x18]
-	sethi		%hi(prom_mmu_ihandle_cache), %g2
-	lduw		[%g2 + %lo(prom_mmu_ihandle_cache)], %g2
-	stx		%g2, [%sp + 2047 + 128 + 0x20]
-	sethi		%hi(KERNBASE + 0x400000), %g2
-	stx		%g2, [%sp + 2047 + 128 + 0x28]
-	sethi		%hi(kern_locked_tte_data), %g2
-	ldx		[%g2 + %lo(kern_locked_tte_data)], %g2
-	sethi		%hi(0x400000), %g1
-	add		%g2, %g1, %g2
-	stx		%g2, [%sp + 2047 + 128 + 0x30]
-
-	mov		14, %g2
-	BRANCH_IF_ANY_CHEETAH(g1,g5,1f)
-
-	mov		62, %g2
-1:
-
-	stx		%g2, [%sp + 2047 + 128 + 0x38]
-	sethi		%hi(p1275buf), %g2
-	or		%g2, %lo(p1275buf), %g2
-	ldx		[%g2 + 0x08], %o1
-	call		%o1
-	 add		%sp, (2047 + 128), %o0
-
-do_unlock:
 	sethi		%hi(prom_entry_lock), %g2
 	stb		%g0, [%g2 + %lo(prom_entry_lock)]
 	membar		#StoreStore | #StoreLoad
@@ -269,47 +220,36 @@ do_unlock:
 	 nop
 
 niagara_lock_tlb:
+	sethi		%hi(KERNBASE), %l3
+	sethi		%hi(kern_locked_tte_data), %l4
+	ldx		[%l4 + %lo(kern_locked_tte_data)], %l4
+	clr		%l5
+	sethi		%hi(num_kernel_image_mappings), %l6
+	lduw		[%l6 + %lo(num_kernel_image_mappings)], %l6
+	add		%l6, 1, %l6
+
+1:
 	mov		HV_FAST_MMU_MAP_PERM_ADDR, %o5
-	sethi		%hi(KERNBASE), %o0
+	sllx		%l5, 22, %g2
+	add		%l3, %g2, %o0
 	clr		%o1
-	sethi		%hi(kern_locked_tte_data), %o2
-	ldx		[%o2 + %lo(kern_locked_tte_data)], %o2
+	add		%l4, %g2, %o2
 	mov		HV_MMU_IMMU, %o3
 	ta		HV_FAST_TRAP
 
 	mov		HV_FAST_MMU_MAP_PERM_ADDR, %o5
-	sethi		%hi(KERNBASE), %o0
+	sllx		%l5, 22, %g2
+	add		%l3, %g2, %o0
 	clr		%o1
-	sethi		%hi(kern_locked_tte_data), %o2
-	ldx		[%o2 + %lo(kern_locked_tte_data)], %o2
+	add		%l4, %g2, %o2
 	mov		HV_MMU_DMMU, %o3
 	ta		HV_FAST_TRAP
 
-	sethi		%hi(bigkernel), %g2
-	lduw		[%g2 + %lo(bigkernel)], %g2
-	brz,pt		%g2, after_lock_tlb
+	add		%l5, 1, %l5
+	cmp		%l5, %l6
+	bne,pt		%xcc, 1b
 	 nop
 
-	mov		HV_FAST_MMU_MAP_PERM_ADDR, %o5
-	sethi		%hi(KERNBASE + 0x400000), %o0
-	clr		%o1
-	sethi		%hi(kern_locked_tte_data), %o2
-	ldx		[%o2 + %lo(kern_locked_tte_data)], %o2
-	sethi		%hi(0x400000), %o3
-	add		%o2, %o3, %o2
-	mov		HV_MMU_IMMU, %o3
-	ta		HV_FAST_TRAP
-
-	mov		HV_FAST_MMU_MAP_PERM_ADDR, %o5
-	sethi		%hi(KERNBASE + 0x400000), %o0
-	clr		%o1
-	sethi		%hi(kern_locked_tte_data), %o2
-	ldx		[%o2 + %lo(kern_locked_tte_data)], %o2
-	sethi		%hi(0x400000), %o3
-	add		%o2, %o3, %o2
-	mov		HV_MMU_DMMU, %o3
-	ta		HV_FAST_TRAP
-
 after_lock_tlb:
 	wrpr		%g0, (PSTATE_PRIV | PSTATE_PEF), %pstate
 	wr		%g0, 0, %fprs
diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
index b5c3041..466fd6c 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -166,7 +166,7 @@ unsigned long sparc64_kern_pri_context __read_mostly;
 unsigned long sparc64_kern_pri_nuc_bits __read_mostly;
 unsigned long sparc64_kern_sec_context __read_mostly;
 
-int bigkernel = 0;
+int num_kernel_image_mappings;
 
 #ifdef CONFIG_DEBUG_DCFLUSH
 atomic_t dcpage_flushes = ATOMIC_INIT(0);
@@ -572,7 +572,7 @@ static unsigned long kern_large_tte(unsigned long paddr);
 static void __init remap_kernel(void)
 {
 	unsigned long phys_page, tte_vaddr, tte_data;
-	int tlb_ent = sparc64_highest_locked_tlbent();
+	int i, tlb_ent = sparc64_highest_locked_tlbent();
 
 	tte_vaddr = (unsigned long) KERNBASE;
 	phys_page = (prom_boot_mapping_phys_low >> 22UL) << 22UL;
@@ -582,27 +582,20 @@ static void __init remap_kernel(void)
 
 	/* Now lock us into the TLBs via Hypervisor or OBP. */
 	if (tlb_type = hypervisor) {
-		hypervisor_tlb_lock(tte_vaddr, tte_data, HV_MMU_DMMU);
-		hypervisor_tlb_lock(tte_vaddr, tte_data, HV_MMU_IMMU);
-		if (bigkernel) {
-			tte_vaddr += 0x400000;
-			tte_data += 0x400000;
+		for (i = 0; i < num_kernel_image_mappings; i++) {
 			hypervisor_tlb_lock(tte_vaddr, tte_data, HV_MMU_DMMU);
 			hypervisor_tlb_lock(tte_vaddr, tte_data, HV_MMU_IMMU);
+			tte_vaddr += 0x400000;
+			tte_data += 0x400000;
 		}
 	} else {
-		prom_dtlb_load(tlb_ent, tte_data, tte_vaddr);
-		prom_itlb_load(tlb_ent, tte_data, tte_vaddr);
-		if (bigkernel) {
-			tlb_ent -= 1;
-			prom_dtlb_load(tlb_ent,
-				       tte_data + 0x400000, 
-				       tte_vaddr + 0x400000);
-			prom_itlb_load(tlb_ent,
-				       tte_data + 0x400000, 
-				       tte_vaddr + 0x400000);
+		for (i = 0; i < num_kernel_image_mappings; i++) {
+			prom_dtlb_load(tlb_ent - i, tte_data, tte_vaddr);
+			prom_itlb_load(tlb_ent - i, tte_data, tte_vaddr);
+			tte_vaddr += 0x400000;
+			tte_data += 0x400000;
 		}
-		sparc64_highest_unlocked_tlb_ent = tlb_ent - 1;
+		sparc64_highest_unlocked_tlb_ent = tlb_ent - i;
 	}
 	if (tlb_type = cheetah_plus) {
 		sparc64_kern_pri_context = (CTX_CHEETAH_PLUS_CTX0 |
@@ -1352,12 +1345,9 @@ void __init paging_init(void)
 	shift = kern_base + PAGE_OFFSET - ((unsigned long)KERNBASE);
 
 	real_end = (unsigned long)_end;
-	if ((real_end > ((unsigned long)KERNBASE + 0x400000)))
-		bigkernel = 1;
-	if ((real_end > ((unsigned long)KERNBASE + 0x800000))) {
-		prom_printf("paging_init: Kernel > 8MB, too large.\n");
-		prom_halt();
-	}
+	num_kernel_image_mappings = DIV_ROUND_UP(real_end - KERNBASE, 1 << 22);
+	printk("Kernel: Using %d locked TLB entries for main kernel image.\n",
+	       num_kernel_image_mappings);
 
 	/* Set kernel pgd to upper alias so physical page computations
 	 * work.
diff --git a/include/asm-sparc64/hvtramp.h b/include/asm-sparc64/hvtramp.h
index c7dd6ad..b2b9b94 100644
--- a/include/asm-sparc64/hvtramp.h
+++ b/include/asm-sparc64/hvtramp.h
@@ -16,7 +16,7 @@ struct hvtramp_descr {
 	__u64			fault_info_va;
 	__u64			fault_info_pa;
 	__u64			thread_reg;
-	struct hvtramp_mapping	maps[2];
+	struct hvtramp_mapping	maps[1];
 };
 
 extern void hv_cpu_startup(unsigned long hvdescr_pa);
diff --git a/include/asm-sparc64/spitfire.h b/include/asm-sparc64/spitfire.h
index 63b7040..985ea7e 100644
--- a/include/asm-sparc64/spitfire.h
+++ b/include/asm-sparc64/spitfire.h
@@ -63,6 +63,8 @@ extern void cheetah_enable_pcache(void);
 	 SPITFIRE_HIGHEST_LOCKED_TLBENT : \
 	 CHEETAH_HIGHEST_LOCKED_TLBENT)
 
+extern int num_kernel_image_mappings;
+
 /* The data cache is write through, so this just invalidates the
  * specified line.
  */
