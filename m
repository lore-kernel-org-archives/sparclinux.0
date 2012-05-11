From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 11 May 2012 21:35:06 +0000
Subject: [PATCH 03/14] sparc32: remove sun4c traps
Message-Id: <1336772117-1539-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We used to runtime patch the trap table for srmmu.
With the removal of sun4c support this is no longer required.

With the sun4c trap removed we can remove all the referenced
trap handling which is sun4c specific.
This also allwos us to get rid of the nosun4c.c file that
contained only dummy functions/data.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/head_32.h |    4 +-
 arch/sparc/include/asm/memreg.h  |   51 --------
 arch/sparc/kernel/devices.c      |    4 -
 arch/sparc/kernel/entry.S        |  248 --------------------------------------
 arch/sparc/kernel/head_32.S      |    6 +-
 arch/sparc/kernel/setup_32.c     |    9 --
 arch/sparc/mm/Makefile           |    2 -
 arch/sparc/mm/fault_32.c         |   89 --------------
 arch/sparc/mm/nosun4c.c          |   54 --------
 arch/sparc/mm/srmmu.c            |    5 -
 10 files changed, 4 insertions(+), 468 deletions(-)
 delete mode 100644 arch/sparc/include/asm/memreg.h
 delete mode 100644 arch/sparc/mm/nosun4c.c

diff --git a/arch/sparc/include/asm/head_32.h b/arch/sparc/include/asm/head_32.h
index 5ceb7fa..2546039 100644
--- a/arch/sparc/include/asm/head_32.h
+++ b/arch/sparc/include/asm/head_32.h
@@ -18,9 +18,7 @@
 #define TRAP_ENTRY(type, label) \
 	rd %psr, %l0; b label; rd %wim, %l3; nop;
 
-/* Data/text faults. Defaults to sun4c version at boot time. */
-#define SPARC_TFAULT rd %psr, %l0; rd %wim, %l3; b sun4c_fault; mov 1, %l7;
-#define SPARC_DFAULT rd %psr, %l0; rd %wim, %l3; b sun4c_fault; mov 0, %l7;
+/* Data/text faults */
 #define SRMMU_TFAULT rd %psr, %l0; rd %wim, %l3; b srmmu_fault; mov 1, %l7;
 #define SRMMU_DFAULT rd %psr, %l0; rd %wim, %l3; b srmmu_fault; mov 0, %l7;
 
diff --git a/arch/sparc/include/asm/memreg.h b/arch/sparc/include/asm/memreg.h
deleted file mode 100644
index 845ad2b..0000000
--- a/arch/sparc/include/asm/memreg.h
+++ /dev/null
@@ -1,51 +0,0 @@
-#ifndef _SPARC_MEMREG_H
-#define _SPARC_MEMREG_H
-/* memreg.h:  Definitions of the values found in the synchronous
- *            and asynchronous memory error registers when a fault
- *            occurs on the sun4c.
- *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- */
-
-/* First the synchronous error codes, these are usually just
- * normal page faults.
- */
-
-#define SUN4C_SYNC_WDRESET   0x0001  /* watchdog reset */
-#define SUN4C_SYNC_SIZE      0x0002  /* bad access size? whuz this? */
-#define SUN4C_SYNC_PARITY    0x0008  /* bad ram chips caused a parity error */
-#define SUN4C_SYNC_SBUS      0x0010  /* the SBUS had some problems... */
-#define SUN4C_SYNC_NOMEM     0x0020  /* translation to non-existent ram */
-#define SUN4C_SYNC_PROT      0x0040  /* access violated pte protections */
-#define SUN4C_SYNC_NPRESENT  0x0080  /* pte said that page was not present */
-#define SUN4C_SYNC_BADWRITE  0x8000  /* while writing something went bogus */
-
-#define SUN4C_SYNC_BOLIXED  \
-        (SUN4C_SYNC_WDRESET | SUN4C_SYNC_SIZE | SUN4C_SYNC_SBUS | \
-         SUN4C_SYNC_NOMEM | SUN4C_SYNC_PARITY)
-
-/* Now the asynchronous error codes, these are almost always produced
- * by the cache writing things back to memory and getting a bad translation.
- * Bad DVMA transactions can cause these faults too.
- */
-
-#define SUN4C_ASYNC_BADDVMA 0x0010  /* error during DVMA access */
-#define SUN4C_ASYNC_NOMEM   0x0020  /* write back pointed to bad phys addr */
-#define SUN4C_ASYNC_BADWB   0x0080  /* write back points to non-present page */
-
-/* Memory parity error register with associated bit constants. */
-#ifndef __ASSEMBLY__
-extern __volatile__ unsigned long __iomem *sun4c_memerr_reg;
-#endif
-
-#define	SUN4C_MPE_ERROR	0x80	/* Parity error detected. (ro) */
-#define	SUN4C_MPE_MULTI	0x40	/* Multiple parity errors detected. (ro) */
-#define	SUN4C_MPE_TEST	0x20	/* Write inverse parity. (rw) */
-#define	SUN4C_MPE_CHECK	0x10	/* Enable parity checking. (rw) */
-#define	SUN4C_MPE_ERR00	0x08	/* Parity error in bits 0-7. (ro) */
-#define	SUN4C_MPE_ERR08	0x04	/* Parity error in bits 8-15. (ro) */
-#define	SUN4C_MPE_ERR16	0x02	/* Parity error in bits 16-23. (ro) */
-#define	SUN4C_MPE_ERR24	0x01	/* Parity error in bits 24-31. (ro) */
-#define	SUN4C_MPE_ERRS	0x0F	/* Bit mask for the error bits. (ro) */
-
-#endif /* !(_SPARC_MEMREG_H) */
diff --git a/arch/sparc/kernel/devices.c b/arch/sparc/kernel/devices.c
index 6b2f56a..3d465e8 100644
--- a/arch/sparc/kernel/devices.c
+++ b/arch/sparc/kernel/devices.c
@@ -21,7 +21,6 @@
 #include <asm/cpu_type.h>
 
 extern void clock_stop_probe(void); /* tadpole.c */
-extern void sun4c_probe_memerr_reg(void);
 
 static char *cpu_mid_prop(void)
 {
@@ -139,7 +138,4 @@ void __init device_scan(void)
 		auxio_power_probe();
 	}
 	clock_stop_probe();
-
-	if (ARCH_SUN4C)
-		sun4c_probe_memerr_reg();
 }
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index e0e0b81..8abe65d 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -17,7 +17,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/psr.h>
 #include <asm/vaddrs.h>
-#include <asm/memreg.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/pgtsun4c.h>
@@ -829,253 +828,6 @@ vac_hwflush_patch2_on:		sta	%g0, [%l3 + %l7] ASI_HWFLUSHSEG
 	.globl	vac_hwflush_patch2
 
 	.align	4
-	.globl	sun4c_fault
-
-! %l0 = %psr
-! %l1 = %pc
-! %l2 = %npc
-! %l3 = %wim
-! %l7 = 1 for textfault
-! We want error in %l5, vaddr in %l6
-sun4c_fault:
-	sethi	%hi(AC_SYNC_ERR), %l4
-	add	%l4, 0x4, %l6			! AC_SYNC_VA in %l6
-	lda	[%l6] ASI_CONTROL, %l5		! Address
-	lda	[%l4] ASI_CONTROL, %l6		! Error, retained for a bit
-
-	andn	%l5, 0xfff, %l5			! Encode all info into l7
-	srl	%l6, 14, %l4
-
-	and	%l4, 2, %l4
-	or	%l5, %l4, %l4
-
-	or	%l4, %l7, %l7			! l7 = [addr,write,txtfault]
-
-	andcc	%l0, PSR_PS, %g0
-	be	sun4c_fault_fromuser
-	 andcc	%l7, 1, %g0			! Text fault?
-
-	be	1f
-	 sethi	%hi(KERNBASE), %l4
-
-	mov	%l1, %l5			! PC
-
-1:
-	cmp	%l5, %l4
-	blu	sun4c_fault_fromuser
-	 sethi	%hi(~((1 << SUN4C_REAL_PGDIR_SHIFT) - 1)), %l4
-
-	/* If the kernel references a bum kernel pointer, or a pte which
-	 * points to a non existent page in ram, we will run this code
-	 * _forever_ and lock up the machine!!!!! So we must check for
-	 * this condition, the AC_SYNC_ERR bits are what we must examine.
-	 * Also a parity error would make this happen as well.  So we just
-	 * check that we are in fact servicing a tlb miss and not some
-	 * other type of fault for the kernel.
-	 */
-	andcc	%l6, 0x80, %g0
-	be	sun4c_fault_fromuser
-	 and	%l5, %l4, %l5
-
-	/* Test for NULL pte_t * in vmalloc area. */
-	sethi   %hi(VMALLOC_START), %l4
-	cmp     %l5, %l4
-	blu,a   invalid_segment_patch1
-	 lduXa	[%l5] ASI_SEGMAP, %l4
-
-	sethi   %hi(swapper_pg_dir), %l4
-	srl     %l5, SUN4C_PGDIR_SHIFT, %l6
-	or      %l4, %lo(swapper_pg_dir), %l4
-	sll     %l6, 2, %l6
-	ld      [%l4 + %l6], %l4
-	andcc   %l4, PAGE_MASK, %g0
-	be      sun4c_fault_fromuser
-	 lduXa  [%l5] ASI_SEGMAP, %l4
-
-invalid_segment_patch1:
-	cmp	%l4, 0x7f
-	bne	1f
-	 sethi	%hi(sun4c_kfree_ring), %l4
-	or	%l4, %lo(sun4c_kfree_ring), %l4
-	ld	[%l4 + 0x18], %l3
-	deccc	%l3			! do we have a free entry?
-	bcs,a	2f			! no, unmap one.
-	 sethi	%hi(sun4c_kernel_ring), %l4
-
-	st	%l3, [%l4 + 0x18]	! sun4c_kfree_ring.num_entries--
-
-	ld	[%l4 + 0x00], %l6	! entry = sun4c_kfree_ring.ringhd.next
-	st	%l5, [%l6 + 0x08]	! entry->vaddr = address
-
-	ld	[%l6 + 0x00], %l3	! next = entry->next
-	ld	[%l6 + 0x04], %l7	! entry->prev
-
-	st	%l7, [%l3 + 0x04]	! next->prev = entry->prev
-	st	%l3, [%l7 + 0x00]	! entry->prev->next = next
-
-	sethi	%hi(sun4c_kernel_ring), %l4
-	or	%l4, %lo(sun4c_kernel_ring), %l4
-					! head = &sun4c_kernel_ring.ringhd
-
-	ld	[%l4 + 0x00], %l7	! head->next
-
-	st	%l4, [%l6 + 0x04]	! entry->prev = head
-	st	%l7, [%l6 + 0x00]	! entry->next = head->next
-	st	%l6, [%l7 + 0x04]	! head->next->prev = entry
-
-	st	%l6, [%l4 + 0x00]	! head->next = entry
-
-	ld	[%l4 + 0x18], %l3
-	inc	%l3			! sun4c_kernel_ring.num_entries++
-	st	%l3, [%l4 + 0x18]
-	b	4f
-	 ld	[%l6 + 0x08], %l5
-
-2:
-	or	%l4, %lo(sun4c_kernel_ring), %l4
-					! head = &sun4c_kernel_ring.ringhd
-
-	ld	[%l4 + 0x04], %l6	! entry = head->prev
-
-	ld	[%l6 + 0x08], %l3	! tmp = entry->vaddr
-
-	! Flush segment from the cache.
-	sethi	%hi((64 * 1024)), %l7
-9:
-vac_hwflush_patch1:
-vac_linesize_patch:
-	subcc	%l7, 16, %l7
-	bne	9b
-vac_hwflush_patch2:
-	 sta	%g0, [%l3 + %l7] ASI_FLUSHSEG
-
-	st	%l5, [%l6 + 0x08]	! entry->vaddr = address
-
-	ld	[%l6 + 0x00], %l5	! next = entry->next
-	ld	[%l6 + 0x04], %l7	! entry->prev
-
-	st	%l7, [%l5 + 0x04]	! next->prev = entry->prev
-	st	%l5, [%l7 + 0x00]	! entry->prev->next = next
-	st	%l4, [%l6 + 0x04]	! entry->prev = head
-
-	ld	[%l4 + 0x00], %l7	! head->next
-
-	st	%l7, [%l6 + 0x00]	! entry->next = head->next
-	st	%l6, [%l7 + 0x04]	! head->next->prev = entry
-	st	%l6, [%l4 + 0x00]	! head->next = entry
-
-	mov	%l3, %l5		! address = tmp
-
-4:
-num_context_patch1:
-	mov	0x08, %l7
-
-	ld	[%l6 + 0x08], %l4
-	ldub	[%l6 + 0x0c], %l3
-	or	%l4, %l3, %l4		! encode new vaddr/pseg into l4
-
-	sethi	%hi(AC_CONTEXT), %l3
-	lduba	[%l3] ASI_CONTROL, %l6
-
-	/* Invalidate old mapping, instantiate new mapping,
-	 * for each context.  Registers l6/l7 are live across
-	 * this loop.
-	 */
-3:	deccc	%l7
-	sethi	%hi(AC_CONTEXT), %l3
-	stba	%l7, [%l3] ASI_CONTROL
-invalid_segment_patch2:
-	mov	0x7f, %l3
-	stXa	%l3, [%l5] ASI_SEGMAP
-	andn	%l4, 0x1ff, %l3
-	bne	3b
-	 stXa	%l4, [%l3] ASI_SEGMAP
-
-	sethi	%hi(AC_CONTEXT), %l3
-	stba	%l6, [%l3] ASI_CONTROL
-
-	andn	%l4, 0x1ff, %l5
-
-1:
-	sethi	%hi(VMALLOC_START), %l4
-	cmp	%l5, %l4
-
-	bgeu	1f
-	 mov	1 << (SUN4C_REAL_PGDIR_SHIFT - PAGE_SHIFT), %l7
-
-	sethi	%hi(KERNBASE), %l6
-
-	sub	%l5, %l6, %l4
-	srl	%l4, PAGE_SHIFT, %l4
-	sethi	%hi((SUN4C_PAGE_KERNEL & 0xf4000000)), %l3
-	or	%l3, %l4, %l3
-
-	sethi	%hi(PAGE_SIZE), %l4
-
-2:
-	sta	%l3, [%l5] ASI_PTE
-	deccc	%l7
-	inc	%l3
-	bne	2b
-	 add	%l5, %l4, %l5
-
-	b	7f
-	 sethi	%hi(sun4c_kernel_faults), %l4
-
-1:
-	srl	%l5, SUN4C_PGDIR_SHIFT, %l3
-	sethi	%hi(swapper_pg_dir), %l4
-	or	%l4, %lo(swapper_pg_dir), %l4
-	sll	%l3, 2, %l3
-	ld	[%l4 + %l3], %l4
-	and	%l4, PAGE_MASK, %l4
-
-	srl	%l5, (PAGE_SHIFT - 2), %l6
-	and	%l6, ((SUN4C_PTRS_PER_PTE - 1) << 2), %l6
-	add	%l6, %l4, %l6
-
-	sethi	%hi(PAGE_SIZE), %l4
-
-2:
-	ld	[%l6], %l3
-	deccc	%l7
-	sta	%l3, [%l5] ASI_PTE
-	add	%l6, 0x4, %l6
-	bne	2b
-	 add	%l5, %l4, %l5
-
-	sethi	%hi(sun4c_kernel_faults), %l4
-7:
-	ld	[%l4 + %lo(sun4c_kernel_faults)], %l3
-	inc	%l3
-	st	%l3, [%l4 + %lo(sun4c_kernel_faults)]
-
-	/* Restore condition codes */
-	wr	%l0, 0x0, %psr
-	WRITE_PAUSE
-	jmp	%l1
-	 rett	%l2
-
-sun4c_fault_fromuser:
-	SAVE_ALL
-	 nop
-	
-	mov	%l7, %o1		! Decode the info from %l7
-	mov	%l7, %o2
-	and	%o1, 1, %o1		! arg2 = text_faultp
-	mov	%l7, %o3
-	and	%o2, 2, %o2		! arg3 = writep
-	andn	%o3, 0xfff, %o3		! arg4 = faulting address
-
-	wr	%l0, PSR_ET, %psr
-	WRITE_PAUSE
-
-	call	do_sun4c_fault
-	 add	%sp, STACKFRAME_SZ, %o0	! arg1 = pt_regs ptr
-
-	RESTORE_ALL
-
-	.align	4
 	.globl	srmmu_fault
 srmmu_fault:
 	mov	0x400, %l5
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 054a49f..0e23ff3 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -84,7 +84,7 @@ trapbase_cpu0:
 #endif
 /* We get control passed to us here at t_zero. */
 t_zero:	b gokernel; nop; nop; nop;
-t_tflt:	SPARC_TFAULT                        /* Inst. Access Exception        */
+t_tflt:	SRMMU_TFAULT                        /* Inst. Access Exception        */
 t_bins:	TRAP_ENTRY(0x2, bad_instruction)    /* Illegal Instruction           */
 t_pins:	TRAP_ENTRY(0x3, priv_instruction)   /* Privileged Instruction        */
 t_fpd:	TRAP_ENTRY(0x4, fpd_trap_handler)   /* Floating Point Disabled       */
@@ -92,7 +92,7 @@ t_wovf:	WINDOW_SPILL                        /* Window Overflow               */
 t_wunf:	WINDOW_FILL                         /* Window Underflow              */
 t_mna:	TRAP_ENTRY(0x7, mna_handler)        /* Memory Address Not Aligned    */
 t_fpe:	TRAP_ENTRY(0x8, fpe_trap_handler)   /* Floating Point Exception      */
-t_dflt:	SPARC_DFAULT                        /* Data Miss Exception           */
+t_dflt:	SRMMU_DFAULT                        /* Data Miss Exception           */
 t_tio:	TRAP_ENTRY(0xa, do_tag_overflow)    /* Tagged Instruction Ovrflw     */
 t_wpt:	TRAP_ENTRY(0xb, do_watchpoint)      /* Watchpoint Detected           */
 t_badc:	BAD_TRAP(0xc) BAD_TRAP(0xd) BAD_TRAP(0xe) BAD_TRAP(0xf) BAD_TRAP(0x10)
@@ -120,7 +120,7 @@ t_cpdis:TRAP_ENTRY(0x24, do_cp_disabled)    /* Co-Processor Disabled         */
 t_uflsh:SKIP_TRAP(0x25, unimp_flush)        /* Unimplemented FLUSH inst.     */
 t_bad26:BAD_TRAP(0x26) BAD_TRAP(0x27)
 t_cpexc:TRAP_ENTRY(0x28, do_cp_exception)   /* Co-Processor Exception        */
-t_dacce:SPARC_DFAULT                        /* Data Access Error             */
+t_dacce:SRMMU_DFAULT                        /* Data Access Error             */
 t_hwdz:	TRAP_ENTRY(0x2a, do_hw_divzero)     /* Division by zero, you lose... */
 t_dserr:BAD_TRAP(0x2b)                      /* Data Store Error              */
 t_daccm:BAD_TRAP(0x2c)                      /* Data Access MMU-Miss          */
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index d444468..a2123ad 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -182,13 +182,6 @@ static void __init boot_flags_init(char *commands)
 	}
 }
 
-/* This routine will in the future do all the nasty prom stuff
- * to probe for the mmu type and its parameters, etc. This will
- * also be where SMP things happen.
- */
-
-extern void sun4c_probe_vac(void);
-
 extern unsigned short root_flags;
 extern unsigned short root_dev;
 extern unsigned short ram_flags;
@@ -275,8 +268,6 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	idprom_init();
-	if (ARCH_SUN4C)
-		sun4c_probe_vac();
 	load_mmu();
 
 	phys_base = 0xffffffffUL;
diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index 2e68054..697eab7 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -17,5 +17,3 @@ obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 
 # Only used by sparc32
 obj-$(CONFIG_HIGHMEM)   += highmem.o
-
-obj-$(CONFIG_SPARC32) += nosun4c.o
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index f3e6921..7348121 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -24,7 +24,6 @@
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/memreg.h>
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 #include <asm/smp.h>
@@ -70,8 +69,6 @@ asmlinkage void sparc_lvl15_nmi(struct pt_regs *regs, unsigned long serr,
 	printk("       Synchronous Vaddr %08lx\n", svaddr);
 	printk("      Asynchronous Error %08lx\n", aerr);
 	printk("      Asynchronous Vaddr %08lx\n", avaddr);
-	if (sun4c_memerr_reg)
-		printk("     Memory Parity Error %08lx\n", *sun4c_memerr_reg);
 	printk("REGISTER DUMP:\n");
 	show_regs(regs);
 	prom_halt();
@@ -422,92 +419,6 @@ vmalloc_fault:
 	}
 }
 
-asmlinkage void do_sun4c_fault(struct pt_regs *regs, int text_fault, int write,
-			       unsigned long address)
-{
-	extern void sun4c_update_mmu_cache(struct vm_area_struct *,
-					   unsigned long,pte_t *);
-	extern pte_t *sun4c_pte_offset_kernel(pmd_t *,unsigned long);
-	struct task_struct *tsk = current;
-	struct mm_struct *mm = tsk->mm;
-	pgd_t *pgdp;
-	pte_t *ptep;
-
-	if (text_fault) {
-		address = regs->pc;
-	} else if (!write &&
-		   !(regs->psr & PSR_PS)) {
-		unsigned int insn, __user *ip;
-
-		ip = (unsigned int __user *)regs->pc;
-		if (!get_user(insn, ip)) {
-			if ((insn & 0xc1680000) = 0xc0680000)
-				write = 1;
-		}
-	}
-
-	if (!mm) {
-		/* We are oopsing. */
-		do_sparc_fault(regs, text_fault, write, address);
-		BUG();	/* P3 Oops already, you bitch */
-	}
-
-	pgdp = pgd_offset(mm, address);
-	ptep = sun4c_pte_offset_kernel((pmd_t *) pgdp, address);
-
-	if (pgd_val(*pgdp)) {
-	    if (write) {
-		if ((pte_val(*ptep) & (_SUN4C_PAGE_WRITE|_SUN4C_PAGE_PRESENT))
-				   = (_SUN4C_PAGE_WRITE|_SUN4C_PAGE_PRESENT)) {
-			unsigned long flags;
-
-			*ptep = __pte(pte_val(*ptep) | _SUN4C_PAGE_ACCESSED |
-				      _SUN4C_PAGE_MODIFIED |
-				      _SUN4C_PAGE_VALID |
-				      _SUN4C_PAGE_DIRTY);
-
-			local_irq_save(flags);
-			if (sun4c_get_segmap(address) != invalid_segment) {
-				sun4c_put_pte(address, pte_val(*ptep));
-				local_irq_restore(flags);
-				return;
-			}
-			local_irq_restore(flags);
-		}
-	    } else {
-		if ((pte_val(*ptep) & (_SUN4C_PAGE_READ|_SUN4C_PAGE_PRESENT))
-				   = (_SUN4C_PAGE_READ|_SUN4C_PAGE_PRESENT)) {
-			unsigned long flags;
-
-			*ptep = __pte(pte_val(*ptep) | _SUN4C_PAGE_ACCESSED |
-				      _SUN4C_PAGE_VALID);
-
-			local_irq_save(flags);
-			if (sun4c_get_segmap(address) != invalid_segment) {
-				sun4c_put_pte(address, pte_val(*ptep));
-				local_irq_restore(flags);
-				return;
-			}
-			local_irq_restore(flags);
-		}
-	    }
-	}
-
-	/* This conditional is 'interesting'. */
-	if (pgd_val(*pgdp) && !(write && !(pte_val(*ptep) & _SUN4C_PAGE_WRITE))
-	    && (pte_val(*ptep) & _SUN4C_PAGE_VALID))
-		/* Note: It is safe to not grab the MMAP semaphore here because
-		 *       we know that update_mmu_cache() will not sleep for
-		 *       any reason (at least not in the current implementation)
-		 *       and therefore there is no danger of another thread getting
-		 *       on the CPU and doing a shrink_mmap() on this vma.
-		 */
-		sun4c_update_mmu_cache (find_vma(current->mm, address), address,
-					ptep);
-	else
-		do_sparc_fault(regs, text_fault, write, address);
-}
-
 /* This always deals with user addresses. */
 static void force_user_fault(unsigned long address, int write)
 {
diff --git a/arch/sparc/mm/nosun4c.c b/arch/sparc/mm/nosun4c.c
deleted file mode 100644
index 0e0e8cf..0000000
--- a/arch/sparc/mm/nosun4c.c
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * nosun4c.c: This file is a bunch of dummies for SMP compiles, 
- *         so that it does not need sun4c and avoid ifdefs.
- *
- * Copyright (C) 1998 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- */
-
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/init.h>
-#include <asm/pgtable.h>
-
-static char shouldnothappen[] __initdata = "32bit SMP kernel only supports sun4m and sun4d\n";
-
-/* Dummies */
-struct sun4c_mmu_ring {
-	unsigned long xxx1[3];
-	unsigned char xxx2[2];
-	int xxx3;
-};
-struct sun4c_mmu_ring sun4c_kernel_ring;
-struct sun4c_mmu_ring sun4c_kfree_ring;
-unsigned long sun4c_kernel_faults;
-unsigned long *sun4c_memerr_reg;
-
-static void __init should_not_happen(void)
-{
-	prom_printf(shouldnothappen);
-	prom_halt();
-}
-
-pte_t *sun4c_pte_offset(pmd_t * dir, unsigned long address)
-{
-	return NULL;
-}
-
-pte_t *sun4c_pte_offset_kernel(pmd_t *dir, unsigned long address)
-{
-	return NULL;
-}
-
-void sun4c_update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
-{
-}
-
-void __init sun4c_probe_vac(void)
-{
-	should_not_happen();
-}
-
-void __init sun4c_probe_memerr_reg(void)
-{
-	should_not_happen();
-}
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index f37fbb2..7fd4cc3 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -2134,8 +2134,6 @@ extern unsigned long spwin_mmu_patchme, fwin_mmu_patchme,
 extern unsigned long spwin_srmmu_stackchk, srmmu_fwin_stackchk,
 	tsetup_srmmu_stackchk, srmmu_rett_stackchk;
 
-extern unsigned long srmmu_fault;
-
 #define PATCH_BRANCH(insn, dest) do { \
 		iaddr = &(insn); \
 		daddr = &(dest); \
@@ -2150,9 +2148,6 @@ static void __init patch_window_trap_handlers(void)
 	PATCH_BRANCH(fwin_mmu_patchme, srmmu_fwin_stackchk);
 	PATCH_BRANCH(tsetup_mmu_patchme, tsetup_srmmu_stackchk);
 	PATCH_BRANCH(rtrap_mmu_patchme, srmmu_rett_stackchk);
-	PATCH_BRANCH(sparc_ttable[SP_TRAP_TFLT].inst_three, srmmu_fault);
-	PATCH_BRANCH(sparc_ttable[SP_TRAP_DFLT].inst_three, srmmu_fault);
-	PATCH_BRANCH(sparc_ttable[SP_TRAP_DACC].inst_three, srmmu_fault);
 }
 
 #ifdef CONFIG_SMP
-- 
1.6.0.6

