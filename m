From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 10 Oct 2005 23:14:17 +0000
Subject: Re: Yesterdays git does not boot on U5
Message-Id: <20051010.161417.60261513.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0510101057330.28936@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0510101057330.28936@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 10 Oct 2005 13:27:30 -0700 (PDT)

> I've fired up my ultra5 and I'll try to fix this.

This should fix it, please let me know how it goes.

Thanks.

diff-tree 5d8e1b181c4ad63e6ca90d51287b31afd400d2eb (from f96c3bbe91117402f13119ce9e609db9087ed58f)
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Mon Oct 10 16:12:13 2005 -0700

    [SPARC64]: Fix Ultra5, Ultra60, et al. boot failures.
    
    On the boot processor, we need to do the move onto the Linux trap
    table a little bit differently else we'll take unhandlable faults in
    the firmware address space.
    
    Previously we would do the following:
    
    1) Disable PSTATE_IE in %pstate.
    2) Set %tba by hand to sparc64_ttable_tl0
    3) Initialize alternate, mmu, and interrupt global
       trap registers.
    4) Call prom_set_traptable()
    
    That doesn't work very well actually with the way we boot the kernel
    VM these days.  It worked by luck on many systems because the firmware
    accesses for the prom_set_traptable() call happened to be loaded into
    the TLB already, something we cannot assume.
    
    So the new scheme is this:
    
    1) Clear PSTATE_IE in %pstate and set %pil to 15
    2) Call prom_set_traptable()
    3) Initialize alternate, mmu, and interrupt global
       trap registers.
    
    and this works quite well.  This sequence has been moved into a
    callable function in assembler named setup-trap_table().  The idea is
    that eventually trampoline.S can use this code as well.  That isn't
    possible currently due to some complications, but eventually we should
    be able to do it.
    
    Thanks to Meelis Roos for the Ultra5 boot failure report.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/kernel/head.S b/arch/sparc64/kernel/head.S
index 2434049..f1dcdf8 100644
--- a/arch/sparc64/kernel/head.S
+++ b/arch/sparc64/kernel/head.S
@@ -382,32 +382,79 @@ tlb_fixup_done:
 	 nop
 	/* Not reached... */
 
-/* IMPORTANT NOTE: Whenever making changes here, check
- * trampoline.S as well. -jj */
-	.globl	setup_tba
-setup_tba:	/* i0 = is_starfire */
-	save	%sp, -160, %sp
+	/* This is meant to allow the sharing of this code between
+	 * boot processor invocation (via setup_tba() below) and
+	 * secondary processor startup (via trampoline.S).  The
+	 * former does use this code, the latter does not yet due
+	 * to some complexities.  That should be fixed up at some
+	 * point.
+	 */
+	.globl	setup_trap_table
+setup_trap_table:
+	save	%sp, -192, %sp
+
+	/* Force interrupts to be disabled.  Transferring over to
+	 * the Linux trap table is a very delicate operation.
+	 * Until we are actually on the Linux trap table, we cannot
+	 * get the PAGE_OFFSET linear mappings translated.  We need
+	 * that mapping to be setup in order to initialize the firmware
+	 * page tables.
+	 *
+	 * So there is this window of time, from the return from
+	 * prom_set_trap_table() until inherit_prom_mappings_post()
+	 * (in arch/sparc64/mm/init.c) completes, during which no
+	 * firmware address space accesses can be made.
+	 */
+	rdpr	%pstate, %o1
+	andn	%o1, PSTATE_IE, %o1
+	wrpr	%o1, 0x0, %pstate
+	wrpr	%g0, 15, %pil
 
-	rdpr	%tba, %g7
-	sethi	%hi(prom_tba), %o1
-	or	%o1, %lo(prom_tba), %o1
-	stx	%g7, [%o1]
+	/* Ok, now make the final valid firmware call to jump over
+	 * to the Linux trap table.
+	 */
+	call	prom_set_trap_table
+	 sethi	%hi(sparc64_ttable_tl0), %o0
+
+	/* Start using proper page size encodings in ctx register.  */
+	sethi	%hi(sparc64_kern_pri_context), %g3
+	ldx	[%g3 + %lo(sparc64_kern_pri_context)], %g2
+	mov	PRIMARY_CONTEXT, %g1
+	stxa	%g2, [%g1] ASI_DMMU
+	membar	#Sync
+
+	/* The Linux trap handlers expect various trap global registers
+	 * to be setup with some fixed values.  So here we set these
+	 * up very carefully.  These globals are:
+	 *
+	 * Alternate Globals (PSTATE_AG):
+	 *
+	 * %g6			--> current_thread_info()
+	 *
+	 * MMU Globals (PSTATE_MG):
+	 *
+	 * %g1			--> TLB_SFSR
+	 * %g2			--> ((_PAGE_VALID | _PAGE_SZ4MB |
+	 *			      _PAGE_CP | _PAGE_CV | _PAGE_P | _PAGE_W)
+	 *			     ^ 0xfffff80000000000)
+	 * (this %g2 value is used for computing the PAGE_OFFSET kernel
+	 *  TLB entries quickly, the virtual address of the fault XOR'd
+	 *  with this %g2 value is the PTE to load into the TLB)
+	 * %g3			--> VPTE_BASE_CHEETAH or VPTE_BASE_SPITFIRE
+	 *
+	 * Interrupt Globals (PSTATE_IG, setup by init_irqwork_curcpu()):
+	 *
+	 * %g6			--> __irq_work[smp_processor_id()]
+	 */
 
-	/* Setup "Linux" globals 8-) */
 	rdpr	%pstate, %o1
 	mov	%g6, %o2
-	wrpr	%o1, (PSTATE_AG|PSTATE_IE), %pstate
-	sethi	%hi(sparc64_ttable_tl0), %g1
-	wrpr	%g1, %tba
+	wrpr	%o1, PSTATE_AG, %pstate
 	mov	%o2, %g6
 
-	/* Set up MMU globals */
-	wrpr	%o1, (PSTATE_MG|PSTATE_IE), %pstate
-
-	/* Set fixed globals used by dTLB miss handler. */
 #define KERN_HIGHBITS		((_PAGE_VALID|_PAGE_SZ4MB)^0xfffff80000000000)
 #define KERN_LOWBITS		(_PAGE_CP | _PAGE_CV | _PAGE_P | _PAGE_W)
-
+	wrpr	%o1, PSTATE_MG, %pstate
 	mov	TSB_REG, %g1
 	stxa	%g0, [%g1] ASI_DMMU
 	membar	#Sync
@@ -419,17 +466,17 @@ setup_tba:	/* i0 = is_starfire */
 	sllx	%g2, 32, %g2
 	or	%g2, KERN_LOWBITS, %g2
 
-	BRANCH_IF_ANY_CHEETAH(g3,g7,cheetah_vpte_base)
-	ba,pt	%xcc, spitfire_vpte_base
+	BRANCH_IF_ANY_CHEETAH(g3,g7,8f)
+	ba,pt	%xcc, 9f
 	 nop
 
-cheetah_vpte_base:
+8:
 	sethi		%uhi(VPTE_BASE_CHEETAH), %g3
 	or		%g3, %ulo(VPTE_BASE_CHEETAH), %g3
 	ba,pt		%xcc, 2f
 	 sllx		%g3, 32, %g3
 
-spitfire_vpte_base:
+9:
 	sethi		%uhi(VPTE_BASE_SPITFIRE), %g3
 	or		%g3, %ulo(VPTE_BASE_SPITFIRE), %g3
 	sllx		%g3, 32, %g3
@@ -455,29 +502,37 @@ spitfire_vpte_base:
 	sllx	%o2, 32, %o2
 	wr	%o2, %asr25
 
-	/* Ok, we're done setting up all the state our trap mechanims needs,
-	 * now get back into normal globals and let the PROM know what is up.
-	 */
 2:
 	wrpr	%g0, %g0, %wstate
-	wrpr	%o1, PSTATE_IE, %pstate
+	wrpr	%o1, 0x0, %pstate
 
 	call	init_irqwork_curcpu
 	 nop
 
-	call	prom_set_trap_table
-	 sethi	%hi(sparc64_ttable_tl0), %o0
-
-	/* Start using proper page size encodings in ctx register.  */
-	sethi	%hi(sparc64_kern_pri_context), %g3
-	ldx	[%g3 + %lo(sparc64_kern_pri_context)], %g2
-	mov	PRIMARY_CONTEXT, %g1
-	stxa	%g2, [%g1] ASI_DMMU
-	membar	#Sync
-
+	/* Now we can turn interrupts back on. */
 	rdpr	%pstate, %o1
 	or	%o1, PSTATE_IE, %o1
 	wrpr	%o1, 0, %pstate
+	wrpr	%g0, 0x0, %pil
+
+	ret
+	 restore
+
+	.globl	setup_tba
+setup_tba:	/* i0 = is_starfire */
+	save	%sp, -192, %sp
+
+	/* The boot processor is the only cpu which invokes this
+	 * routine, the other cpus set things up via trampoline.S.
+	 * So save the OBP trap table address here.
+	 */
+	rdpr	%tba, %g7
+	sethi	%hi(prom_tba), %o1
+	or	%o1, %lo(prom_tba), %o1
+	stx	%g7, [%o1]
+
+	call	setup_trap_table
+	 nop
 
 	ret
 	 restore
