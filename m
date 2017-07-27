From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 27 Jul 2017 21:57:29 +0000
Subject: [PATCH RFC 3/4] arch/sparc: Optimized memcpy, memset, copy_to_user, copy_from_user for M7
Message-Id: <1501192650-1043374-3-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1501192650-1043374-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1501192650-1043374-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, babu.moger@oracle.com

New algorithm that takes advantage of the M7 block init store
ASI, ie, overlapping pipelines and miss buffer filling.
Full details in code comments.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
---
 arch/sparc/kernel/head_64.S       |   12 +-
 arch/sparc/lib/M7copy_from_user.S |   41 ++
 arch/sparc/lib/M7copy_to_user.S   |   51 ++
 arch/sparc/lib/M7memcpy.S         |  924 +++++++++++++++++++++++++++++++++++++
 arch/sparc/lib/M7memset.S         |  354 ++++++++++++++
 arch/sparc/lib/M7patch.S          |   55 +++
 arch/sparc/lib/Makefile           |    3 +
 7 files changed, 1439 insertions(+), 1 deletions(-)
 create mode 100644 arch/sparc/lib/M7copy_from_user.S
 create mode 100644 arch/sparc/lib/M7copy_to_user.S
 create mode 100644 arch/sparc/lib/M7memcpy.S
 create mode 100644 arch/sparc/lib/M7memset.S
 create mode 100644 arch/sparc/lib/M7patch.S

diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 41a4073..a7de798 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -600,7 +600,7 @@ niagara_tlb_fixup:
 	be,pt	%xcc, niagara4_patch
 	 nop
 	cmp	%g1, SUN4V_CHIP_SPARC_M7
-	be,pt	%xcc, niagara4_patch
+	be,pt	%xcc, sparc_m7_patch
 	 nop
 	cmp	%g1, SUN4V_CHIP_SPARC_SN
 	be,pt	%xcc, niagara4_patch
@@ -615,6 +615,16 @@ niagara_tlb_fixup:
 
 	ba,a,pt	%xcc, 80f
 	 nop
+sparc_m7_patch:
+	call	m7_patch_copyops
+	 nop
+	call	m7_patch_bzero
+	 nop
+	call	m7_patch_pageops
+	 nop
+
+	ba,a,pt	%xcc, 80f
+	 nop
 niagara4_patch:
 	call	niagara4_patch_copyops
 	 nop
diff --git a/arch/sparc/lib/M7copy_from_user.S b/arch/sparc/lib/M7copy_from_user.S
new file mode 100644
index 0000000..d0689d7
--- /dev/null
+++ b/arch/sparc/lib/M7copy_from_user.S
@@ -0,0 +1,41 @@
+/*
+ * M7copy_from_user.S: SPARC M7 optimized copy from userspace.
+ *
+ * Copyright (c) 2016, Oracle and/or its affiliates. All rights reserved.
+ */
+
+
+#define EX_LD(x)			\
+98:	x;				\
+	.section __ex_table,"a";	\
+	.align 4;			\
+	.word 98b, __restore_asi;	\
+	.text;				\
+	.align 4;
+
+#define EX_LD_FP(x)			\
+98:	x;				\
+	.section __ex_table,"a";	\
+	.align 4;			\
+	.word 98b, __restore_asi_fp;	\
+	.text;				\
+	.align 4;
+
+
+#ifndef ASI_AIUS
+#define ASI_AIUS	0x11
+#endif
+
+#define FUNC_NAME		M7copy_from_user
+#define LOAD(type,addr,dest)	type##a [addr] %asi, dest
+#define EX_RETVAL(x)		0
+
+#ifdef __KERNEL__
+#define PREAMBLE					\
+	rd		%asi, %g1;			\
+	cmp		%g1, ASI_AIUS;			\
+	bne,pn		%icc, raw_copy_in_user;		\
+	nop
+#endif
+
+#include "M7memcpy.S"
diff --git a/arch/sparc/lib/M7copy_to_user.S b/arch/sparc/lib/M7copy_to_user.S
new file mode 100644
index 0000000..d3be132
--- /dev/null
+++ b/arch/sparc/lib/M7copy_to_user.S
@@ -0,0 +1,51 @@
+/*
+ * M7copy_to_user.S: SPARC M7 optimized copy to userspace.
+ *
+ * Copyright (c) 2016, Oracle and/or its affiliates. All rights reserved.
+ */
+
+
+#define EX_ST(x)			\
+98:	x;				\
+	.section __ex_table,"a";	\
+	.align 4;			\
+	.word 98b, __restore_asi;	\
+	.text;				\
+	.align 4;
+
+#define EX_ST_FP(x)			\
+98:	x;				\
+	.section __ex_table,"a";	\
+	.align 4;			\
+	.word 98b, __restore_asi_fp;	\
+	.text;				\
+	.align 4;
+
+
+#ifndef ASI_AIUS
+#define ASI_AIUS	0x11
+#endif
+
+#ifndef ASI_BLK_INIT_QUAD_LDD_AIUS
+#define ASI_BLK_INIT_QUAD_LDD_AIUS 0x23
+#endif
+
+#define FUNC_NAME		M7copy_to_user
+#define STORE(type,src,addr)	type##a src, [addr] %asi
+#define STORE_ASI		ASI_BLK_INIT_QUAD_LDD_AIUS
+#define	STORE_MRU_ASI		ASI_ST_BLKINIT_MRU_S
+#define EX_RETVAL(x)		0
+
+#ifdef __KERNEL__
+	/* Writing to %asi is _expensive_ so we hardcode it.
+	 * Reading %asi to check for KERNEL_DS is comparatively
+	 * cheap.
+	 */
+#define PREAMBLE					\
+	rd		%asi, %g1;			\
+	cmp		%g1, ASI_AIUS;			\
+	bne,pn		%icc, raw_copy_in_user;		\
+	nop
+#endif
+
+#include "M7memcpy.S"
diff --git a/arch/sparc/lib/M7memcpy.S b/arch/sparc/lib/M7memcpy.S
new file mode 100644
index 0000000..d49f702
--- /dev/null
+++ b/arch/sparc/lib/M7memcpy.S
@@ -0,0 +1,924 @@
+/*
+ * M7memcpy: Optimized SPARC M7 memcpy
+ *
+ * Copyright (c) 2016, Oracle and/or its affiliates. All rights reserved.
+ */
+
+	.file	"M7memcpy.S"
+
+/*
+ * memcpy(s1, s2, len)
+ *
+ * Copy s2 to s1, always copy n bytes.
+ * Note: this C code does not work for overlapped copies.
+ *
+ * Fast assembler language version of the following C-program for memcpy
+ * which represents the `standard' for the C-library.
+ *
+ *	void *
+ *	memcpy(void *s, const void *s0, size_t n)
+ *	{
+ *		if (n != 0) {
+ *		    char *s1 = s;
+ *		    const char *s2 = s0;
+ *		    do {
+ *			*s1++ = *s2++;
+ *		    } while (--n != 0);
+ *		}
+ *		return (s);
+ *	}
+ *
+ *
+ * SPARC T7/M7 Flow :
+ *
+ * if (count < SMALL_MAX) {
+ *   if count < SHORTCOPY              (SHORTCOPY=3)
+ *	copy bytes; exit with dst addr
+ *   if src & dst aligned on word boundary but not long word boundary,
+ *     copy with ldw/stw; branch to finish_up
+ *   if src & dst aligned on long word boundary
+ *     copy with ldx/stx; branch to finish_up
+ *   if src & dst not aligned and length <= SHORTCHECK   (SHORTCHECK)
+ *     copy bytes; exit with dst addr
+ *   move enough bytes to get src to word boundary
+ *   if dst now on word boundary
+ * move_words:
+ *     copy words; branch to finish_up
+ *   if dst now on half word boundary
+ *     load words, shift half words, store words; branch to finish_up
+ *   if dst on byte 1
+ *     load words, shift 3 bytes, store words; branch to finish_up
+ *   if dst on byte 3
+ *     load words, shift 1 byte, store words; branch to finish_up
+ * finish_up:
+ *     copy bytes; exit with dst addr
+ * } else {                                         More than SMALL_MAX bytes
+ *   move bytes until dst is on long word boundary
+ *   if( src is on long word boundary ) {
+ *     if (count < MED_MAX) {
+ * finish_long:					   src/dst aligned on 8 bytes
+ *       copy with ldx/stx in 8-way unrolled loop;
+ *       copy final 0-63 bytes; exit with dst addr
+ *     } else {				     src/dst aligned; count > MED_MAX
+ *       align dst on 64 byte boundary; for main data movement:
+ *       prefetch src data to L2 cache; let HW prefetch move data to L1 cache
+ *       Use BIS (block initializing store) to avoid copying store cache
+ *       lines from memory. But pre-store first element of each cache line
+ *       ST_CHUNK lines in advance of the rest of that cache line. That
+ *       gives time for replacement cache lines to be written back without
+ *       excess STQ and Miss Buffer filling. Repeat until near the end,
+ *       then finish up storing before going to finish_long.
+ *     }
+ *   } else {                                   src/dst not aligned on 8 bytes
+ *     if src is word aligned and count < MED_WMAX
+ *       move words in 8-way unrolled loop
+ *       move final 0-31 bytes; exit with dst addr
+ *     if count < MED_UMAX
+ *       use alignaddr/faligndata combined with ldd/std in 8-way
+ *       unrolled loop to move data.
+ *       go to unalign_done
+ *     else
+ *       setup alignaddr for faligndata instructions
+ *       align dst on 64 byte boundary; prefetch src data to L1 cache
+ *       loadx8, falign, block-store, prefetch loop
+ *	 (only use block-init-store when src/dst on 8 byte boundaries.)
+ * unalign_done:
+ *       move remaining bytes for unaligned cases. exit with dst addr.
+ * }
+ *
+ */
+
+#include <asm/visasm.h>
+#include <asm/asi.h>
+
+#if !defined(EX_LD) && !defined(EX_ST)
+#define NON_USER_COPY
+#endif
+
+#ifndef EX_LD
+#define EX_LD(x)	x
+#endif
+#ifndef EX_LD_FP
+#define EX_LD_FP(x)	x
+#endif
+
+#ifndef EX_ST
+#define EX_ST(x)	x
+#endif
+#ifndef EX_ST_FP
+#define EX_ST_FP(x)	x
+#endif
+
+#ifndef EX_RETVAL
+#define EX_RETVAL(x)    x
+#endif
+
+#ifndef LOAD
+#define LOAD(type,addr,dest)	type [addr], dest
+#endif
+
+#ifndef STORE
+#define STORE(type,src,addr)	type src, [addr]
+#endif
+
+/*
+ * ASI_BLK_INIT_QUAD_LDD_P/ASI_BLK_INIT_QUAD_LDD_S marks the cache
+ * line as "least recently used" which means if many threads are
+ * active, it has a high probability of being pushed out of the cache
+ * between the first initializing store and the final stores.
+ * Thus, we use ASI_ST_BLKINIT_MRU_P/ASI_ST_BLKINIT_MRU_S which
+ * marks the cache line as "most recently used" for all
+ * but the last cache line
+ */
+#ifndef STORE_ASI
+#ifndef SIMULATE_NIAGARA_ON_NON_NIAGARA
+#define STORE_ASI	ASI_BLK_INIT_QUAD_LDD_P
+#else
+#define STORE_ASI	0x80		/* ASI_P */
+#endif
+#endif
+
+#ifndef STORE_MRU_ASI
+#ifndef SIMULATE_NIAGARA_ON_NON_NIAGARA
+#define STORE_MRU_ASI	ASI_ST_BLKINIT_MRU_P
+#else
+#define STORE_MRU_ASI	0x80		/* ASI_P */
+#endif
+#endif
+
+#ifndef STORE_INIT
+#define STORE_INIT(src,addr)	stxa src, [addr] STORE_ASI
+#endif
+
+#ifndef STORE_INIT_MRU
+#define STORE_INIT_MRU(src,addr)	stxa src, [addr] STORE_MRU_ASI
+#endif
+
+#ifndef FUNC_NAME
+#define FUNC_NAME	M7memcpy
+#endif
+
+#ifndef PREAMBLE
+#define PREAMBLE
+#endif
+
+#define	BLOCK_SIZE	64
+#define	SHORTCOPY	3
+#define	SHORTCHECK	14
+#define	SHORT_LONG	64	/* max copy for short longword-aligned case */
+				/* must be at least 64 */
+#define	SMALL_MAX	128
+#define	MED_UMAX	1024	/* max copy for medium un-aligned case */
+#define	MED_WMAX	1024	/* max copy for medium word-aligned case */
+#define	MED_MAX		1024	/* max copy for medium longword-aligned case */
+#define ST_CHUNK	24	/* ST_CHUNK - block of values for BIS Store */
+#define ALIGN_PRE	24	/* distance for aligned prefetch loop */
+
+        .register      %g2,#scratch
+
+       .section        ".text"
+       .global FUNC_NAME
+       .type   FUNC_NAME, #function
+       .align  16
+FUNC_NAME:
+	srlx            %o2, 31, %g2
+	cmp             %g2, 0
+	tne             %xcc, 5
+	PREAMBLE
+	mov		%o0, %g1	! save %o0
+	brz,pn          %o2, .Lsmallx
+
+	cmp            %o2, 3
+        ble,pn          %icc, .Ltiny_cp
+         cmp            %o2, 19
+        ble,pn          %icc, .Lsmall_cp
+         or             %o0, %o1, %g2
+        cmp             %o2, SMALL_MAX
+        bl,pn           %icc, .Lmedium_cp
+         nop
+
+.Lmedium:
+	neg	%o0, %o5
+	andcc	%o5, 7, %o5		! bytes till DST 8 byte aligned
+	brz,pt	%o5, .Ldst_aligned_on_8
+
+	! %o5 has the bytes to be written in partial store.
+	 sub	%o2, %o5, %o2
+	sub	%o1, %o0, %o1		! %o1 gets the difference
+7:					! dst aligning loop
+	add	%o1, %o0, %o4
+	EX_LD(LOAD(ldub, %o4, %o4))	! load one byte
+	subcc	%o5, 1, %o5
+	EX_ST(STORE(stb, %o4, %o0))
+	bgu,pt	%ncc, 7b
+	 add	%o0, 1, %o0		! advance dst
+	add	%o1, %o0, %o1		! restore %o1
+.Ldst_aligned_on_8:
+	andcc	%o1, 7, %o5
+	brnz,pt	%o5, .Lsrc_dst_unaligned_on_8
+	 nop
+
+.Lsrc_dst_aligned_on_8:
+	! check if we are copying MED_MAX or more bytes
+        set MED_MAX, %o3
+        cmp %o2, %o3 			! limit to store buffer size
+	bgu,pn	%ncc, .Llarge_align8_copy
+	 nop
+
+/*
+ * Special case for handling when src and dest are both long word aligned
+ * and total data to move is less than MED_MAX bytes
+ */
+.Lmedlong:
+	subcc	%o2, 63, %o2		! adjust length to allow cc test
+	ble,pn	%ncc, .Lmedl63		! skip big loop if less than 64 bytes
+	 nop
+.Lmedl64:
+	EX_LD(LOAD(ldx, %o1, %o4))	! load
+	subcc	%o2, 64, %o2		! decrement length count
+	EX_ST(STORE(stx, %o4, %o0))	! and store
+	EX_LD(LOAD(ldx, %o1+8, %o3))	! a block of 64 bytes
+	EX_ST(STORE(stx, %o3, %o0+8))
+	EX_LD(LOAD(ldx, %o1+16, %o4))
+	EX_ST(STORE(stx, %o4, %o0+16))
+	EX_LD(LOAD(ldx, %o1+24, %o3))
+	EX_ST(STORE(stx, %o3, %o0+24))
+	EX_LD(LOAD(ldx, %o1+32, %o4))	! load
+	EX_ST(STORE(stx, %o4, %o0+32))	! and store
+	EX_LD(LOAD(ldx, %o1+40, %o3))	! a block of 64 bytes
+	add	%o1, 64, %o1		! increase src ptr by 64
+	EX_ST(STORE(stx, %o3, %o0+40))
+	EX_LD(LOAD(ldx, %o1-16, %o4))
+	add	%o0, 64, %o0		! increase dst ptr by 64
+	EX_ST(STORE(stx, %o4, %o0-16))
+	EX_LD(LOAD(ldx, %o1-8, %o3))
+	bgu,pt	%ncc, .Lmedl64		! repeat if at least 64 bytes left
+	 EX_ST(STORE(stx, %o3, %o0-8))
+.Lmedl63:
+	addcc	%o2, 32, %o2		! adjust remaining count
+	ble,pt	%ncc, .Lmedl31		! to skip if 31 or fewer bytes left
+	 nop
+	EX_LD(LOAD(ldx, %o1, %o4))	! load
+	sub	%o2, 32, %o2		! decrement length count
+	EX_ST(STORE(stx, %o4, %o0))	! and store
+	EX_LD(LOAD(ldx, %o1+8, %o3))	! a block of 32 bytes
+	add	%o1, 32, %o1		! increase src ptr by 32
+	EX_ST(STORE(stx, %o3, %o0+8))
+	EX_LD(LOAD(ldx, %o1-16, %o4))
+	add	%o0, 32, %o0		! increase dst ptr by 32
+	EX_ST(STORE(stx, %o4, %o0-16))
+	EX_LD(LOAD(ldx, %o1-8, %o3))
+	EX_ST(STORE(stx, %o3, %o0-8))
+.Lmedl31:
+	addcc	%o2, 16, %o2		! adjust remaining count
+	ble,pt	%ncc, .Lmedl15		! skip if 15 or fewer bytes left
+	 nop				!
+	EX_LD(LOAD(ldx, %o1, %o4))
+	add	%o1, 16, %o1		! increase src ptr by 16
+	EX_ST(STORE(stx, %o4, %o0))
+	sub	%o2, 16, %o2		! decrease count by 16
+	EX_LD(LOAD(ldx, %o1-8, %o3))
+	add	%o0, 16, %o0		! increase dst ptr by 16
+	EX_ST(STORE(stx, %o3, %o0-8))
+.Lmedl15:
+	addcc	%o2, 15, %o2		! restore count
+	bz,pt	%ncc, .Lsmallx	! exit if finished
+	 cmp	%o2, 8
+	blt,pt	%ncc, .Lmedw7		! skip if 7 or fewer bytes left
+	 tst	%o2
+	EX_LD(LOAD(ldx, %o1, %o4))	! load 8 bytes
+	add	%o1, 8, %o1		! increase src ptr by 8
+	add	%o0, 8, %o0		! increase dst ptr by 8
+	subcc	%o2, 8, %o2		! decrease count by 8
+	bnz,pn	%ncc, .Lmedw7
+	EX_ST(STORE(stx, %o4, %o0-8))	! and store 8 bytes
+	retl
+	 mov	EX_RETVAL(%g1), %o0	! restore %o0
+
+	.align 16
+.Lsrc_dst_unaligned_on_8:
+	! DST is 8-byte aligned, src is not
+2:
+	andcc	%o1, 0x3, %o5		! test word alignment
+	bnz,pt	%ncc, .Lunalignsetup	! branch to skip if not word aligned
+	 nop
+
+/*
+ * Handle all cases where src and dest are aligned on word
+ * boundaries. Use unrolled loops for better performance.
+ * This option wins over standard large data move when
+ * source and destination is in cache for.Lmedium
+ * to short data moves.
+ */
+        set MED_WMAX, %o3
+        cmp %o2, %o3 			! limit to store buffer size
+	bge,pt	%ncc, .Lunalignrejoin	! otherwise rejoin main loop
+	 nop
+
+	subcc	%o2, 31, %o2		! adjust length to allow cc test
+					! for end of loop
+	ble,pt	%ncc, .Lmedw31		! skip big loop if less than 16
+.Lmedw32:
+	EX_LD(LOAD(ld, %o1, %o4))	! move a block of 32 bytes
+	sllx	%o4, 32, %o5
+	EX_LD(LOAD(ld, %o1+4, %o4))
+	or	%o4, %o5, %o5
+	EX_ST(STORE(stx, %o5, %o0))
+	subcc	%o2, 32, %o2		! decrement length count
+	EX_LD(LOAD(ld, %o1+8, %o4))
+	sllx	%o4, 32, %o5
+	EX_LD(LOAD(ld, %o1+12, %o4))
+	or	%o4, %o5, %o5
+	EX_ST(STORE(stx, %o5, %o0+8))
+	add	%o1, 32, %o1		! increase src ptr by 32
+	EX_LD(LOAD(ld, %o1-16, %o4))
+	sllx	%o4, 32, %o5
+	EX_LD(LOAD(ld, %o1-12, %o4))
+	or	%o4, %o5, %o5
+	EX_ST(STORE(stx, %o5, %o0+16))
+	add	%o0, 32, %o0		! increase dst ptr by 32
+	EX_LD(LOAD(ld, %o1-8, %o4))
+	sllx	%o4, 32, %o5
+	EX_LD(LOAD(ld, %o1-4, %o4))
+	or	%o4, %o5, %o5
+	bgu,pt	%ncc, .Lmedw32		! repeat if at least 32 bytes left
+	 EX_ST(STORE(stx, %o5, %o0-8))
+.Lmedw31:
+	addcc	%o2, 31, %o2		! restore count
+
+	bz,pt	%ncc, .Lsmallx	! exit if finished
+	 nop
+	cmp	%o2, 16
+	blt,pt	%ncc, .Lmedw15
+	 nop
+	EX_LD(LOAD(ld, %o1, %o4))	! move a block of 16 bytes
+	sllx	%o4, 32, %o5
+	subcc	%o2, 16, %o2		! decrement length count
+	EX_LD(LOAD(ld, %o1+4, %o4))
+	or	%o4, %o5, %o5
+	EX_ST(STORE(stx, %o5, %o0))
+	add	%o1, 16, %o1		! increase src ptr by 16
+	EX_LD(LOAD(ld, %o1-8, %o4))
+	add	%o0, 16, %o0		! increase dst ptr by 16
+	sllx	%o4, 32, %o5
+	EX_LD(LOAD(ld, %o1-4, %o4))
+	or	%o4, %o5, %o5
+	EX_ST(STORE(stx, %o5, %o0-8))
+.Lmedw15:
+	bz,pt	%ncc, .Lsmallx	! exit if finished
+	 cmp	%o2, 8
+	blt,pn	%ncc, .Lmedw7		! skip if 7 or fewer bytes left
+	 tst	%o2
+	EX_LD(LOAD(ld, %o1, %o4))	! load 4 bytes
+	subcc	%o2, 8, %o2		! decrease count by 8
+	EX_ST(STORE(stw, %o4, %o0))	! and store 4 bytes
+	add	%o1, 8, %o1		! increase src ptr by 8
+	EX_LD(LOAD(ld, %o1-4, %o3))	! load 4 bytes
+	add	%o0, 8, %o0		! increase dst ptr by 8
+	EX_ST(STORE(stw, %o3, %o0-4))	! and store 4 bytes
+	bz,pt	%ncc, .Lsmallx	! exit if finished
+.Lmedw7:				! count is ge 1, less than 8
+	cmp	%o2, 4			! check for 4 bytes left
+	blt,pn	%ncc, .Lsmallleft3	! skip if 3 or fewer bytes left
+	 nop				!
+	EX_LD(LOAD(ld, %o1, %o4))	! load 4 bytes
+	add	%o1, 4, %o1		! increase src ptr by 4
+	add	%o0, 4, %o0		! increase dst ptr by 4
+	subcc	%o2, 4, %o2		! decrease count by 4
+	bnz	.Lsmallleft3
+	 EX_ST(STORE(stw, %o4, %o0-4))! and store 4 bytes
+	retl
+	 mov	EX_RETVAL(%g1), %o0
+
+	.align 16
+.Llarge_align8_copy:			! Src and dst share 8 byte alignment
+	! align dst to 64 byte boundary
+	andcc	%o0, 0x3f, %o3		! %o3 = 0 means dst is 64 byte aligned
+	brz,pn	%o3, .Laligned_to_64
+	 andcc	%o0, 8, %o3		! odd long words to move?
+	brz,pt	%o3, .Laligned_to_16
+	 nop
+	EX_LD(LOAD(ldx, %o1, %o4))
+	sub	%o2, 8, %o2
+	add	%o1, 8, %o1		! increment src ptr
+	add	%o0, 8, %o0		! increment dst ptr
+	EX_ST(STORE(stx, %o4, %o0-8))
+.Laligned_to_16:
+	andcc	%o0, 16, %o3		! pair of long words to move?
+	brz,pt	%o3, .Laligned_to_32
+	 nop
+	EX_LD(LOAD(ldx, %o1, %o4))
+	sub	%o2, 16, %o2
+	EX_ST(STORE(stx, %o4, %o0))
+	add	%o1, 16, %o1		! increment src ptr
+	EX_LD(LOAD(ldx, %o1-8, %o4))
+	add	%o0, 16, %o0		! increment dst ptr
+	EX_ST(STORE(stx, %o4, %o0-8))
+.Laligned_to_32:
+	andcc	%o0, 32, %o3		! four long words to move?
+	brz,pt	%o3, .Laligned_to_64
+	 nop
+	EX_LD(LOAD(ldx, %o1, %o4))
+	sub	%o2, 32, %o2
+	EX_ST(STORE(stx, %o4, %o0))
+	EX_LD(LOAD(ldx, %o1+8, %o4))
+	EX_ST(STORE(stx, %o4, %o0+8))
+	EX_LD(LOAD(ldx, %o1+16, %o4))
+	EX_ST(STORE(stx, %o4, %o0+16))
+	add	%o1, 32, %o1		! increment src ptr
+	EX_LD(LOAD(ldx, %o1-8, %o4))
+	add	%o0, 32, %o0		! increment dst ptr
+	EX_ST(STORE(stx, %o4, %o0-8))
+.Laligned_to_64:
+!
+!	Using block init store (BIS) instructions to avoid fetching cache
+!	lines from memory. Use ST_CHUNK stores to first element of each cache
+!	line (similar to prefetching) to avoid overfilling STQ or miss buffers.
+!	Gives existing cache lines time to be moved out of L1/L2/L3 cache.
+!	Initial stores using MRU version of BIS to keep cache line in
+!	cache until we are ready to store final element of cache line.
+!	Then store last element using the LRU version of BIS.
+!
+	andn	%o2, 0x3f, %o5		! %o5 is multiple of block size
+	and	%o2, 0x3f, %o2		! residue bytes in %o2
+!
+!	We use STORE_MRU_ASI for the first seven stores to each cache line
+!	followed by STORE_ASI (mark as LRU) for the last store. That
+!	mixed approach reduces the probability that the cache line is removed
+!	before we finish setting it, while minimizing the effects on
+!	other cached values during a large memcpy
+!
+!	ST_CHUNK batches up initial BIS operations for several cache lines
+!	to allow multiple requests to not be blocked by overflowing the
+!	the store miss buffer. Then the matching stores for all those
+!	BIS operations are executed.
+!
+
+	sub	%o0, 8, %o0		! adjust %o0 for ASI alignment
+.Lalign_loop:
+	cmp	%o5, ST_CHUNK*64
+	blu,pt	%ncc, .Lalign_loop_fin
+	 mov	ST_CHUNK,%o3
+.Lalign_loop_start:
+	prefetch [%o1 + (ALIGN_PRE * BLOCK_SIZE)], 21
+	subcc	%o3, 1, %o3
+	EX_LD(LOAD(ldx, %o1, %o4))
+	add	%o1, 64, %o1
+	add	%o0, 8, %o0
+	EX_ST(STORE_INIT_MRU(%o4, %o0))
+	bgu	%ncc,.Lalign_loop_start
+	 add	%o0, 56, %o0
+
+	mov	ST_CHUNK,%o3
+	sllx	%o3, 6, %o4		! ST_CHUNK*64
+	sub	%o1, %o4, %o1		! reset %o1
+	sub	%o0, %o4, %o0		! reset %o0
+
+.Lalign_loop_rest:
+	EX_LD(LOAD(ldx, %o1+8, %o4))
+	add	%o0, 16, %o0
+	EX_ST(STORE_INIT_MRU(%o4, %o0))
+	EX_LD(LOAD(ldx, %o1+16, %o4))
+	add	%o0, 8, %o0
+	EX_ST(STORE_INIT_MRU(%o4, %o0))
+	subcc	%o3, 1, %o3
+	EX_LD(LOAD(ldx, %o1+24, %o4))
+	add	%o0, 8, %o0
+	EX_ST(STORE_INIT_MRU(%o4, %o0))
+	EX_LD(LOAD(ldx, %o1+32, %o4))
+	add	%o0, 8, %o0
+	EX_ST(STORE_INIT_MRU(%o4, %o0))
+	EX_LD(LOAD(ldx, %o1+40, %o4))
+	add	%o0, 8, %o0
+	EX_ST(STORE_INIT_MRU(%o4, %o0))
+	EX_LD(LOAD(ldx, %o1+48, %o4))
+	add	%o1, 64, %o1
+	add	%o0, 8, %o0
+	EX_ST(STORE_INIT_MRU(%o4, %o0))
+	add	%o0, 8, %o0
+	EX_LD(LOAD(ldx, %o1-8, %o4))
+	sub	%o5, 64, %o5
+	bgu	%ncc,.Lalign_loop_rest
+	! mark cache line as LRU
+	 EX_ST(STORE_INIT(%o4, %o0))
+
+	cmp	%o5, ST_CHUNK*64
+	bgu,pt	%ncc, .Lalign_loop_start
+	 mov	ST_CHUNK,%o3
+
+	cmp	%o5, 0
+	beq	.Lalign_done
+	 nop
+.Lalign_loop_fin:
+	EX_LD(LOAD(ldx, %o1, %o4))
+	EX_ST(STORE(stx, %o4, %o0+8))
+	EX_LD(LOAD(ldx, %o1+8, %o4))
+	EX_ST(STORE(stx, %o4, %o0+8+8))
+	EX_LD(LOAD(ldx, %o1+16, %o4))
+	EX_ST(STORE(stx, %o4, %o0+8+16))
+	subcc	%o5, 64, %o5
+	EX_LD(LOAD(ldx, %o1+24, %o4))
+	EX_ST(STORE(stx, %o4, %o0+8+24))
+	EX_LD(LOAD(ldx, %o1+32, %o4))
+	EX_ST(STORE(stx, %o4, %o0+8+32))
+	EX_LD(LOAD(ldx, %o1+40, %o4))
+	EX_ST(STORE(stx, %o4, %o0+8+40))
+	EX_LD(LOAD(ldx, %o1+48, %o4))
+	add	%o1, 64, %o1
+	EX_ST(STORE(stx, %o4, %o0+8+48))
+	add	%o0, 64, %o0
+	EX_LD(LOAD(ldx, %o1-8, %o4))
+	bgu	%ncc,.Lalign_loop_fin
+	 EX_ST(STORE(stx, %o4, %o0))
+
+.Lalign_done:
+	add	%o0, 8, %o0		! restore %o0 from ASI alignment
+	membar	#StoreStore
+	sub	%o2, 63, %o2		! adjust length to allow cc test
+	ba	.Lmedl63		! in .Lmedl63
+	 nop
+
+	.align 16
+	! Dst is on 8 byte boundary; src is not; remaining count > SMALL_MAX
+.Lunalignsetup:
+.Lunalignrejoin:
+	mov	%g1, %o3	! save %g1 as VISEntryHalf clobbers it
+#ifdef NON_USER_COPY
+	VISEntryHalfFast(.Lmedium_vis_entry_fail_cp)
+#else
+	VISEntryHalf
+#endif
+	mov	%o3, %g1	! restore %g1
+
+	set MED_UMAX, %o3
+	cmp %o2, %o3 		! check for.Lmedium unaligned limit
+	bge,pt	%ncc,.Lunalign_large
+	 prefetch [%o1 + (4 * BLOCK_SIZE)], 20
+	andn	%o2, 0x3f, %o5		! %o5 is multiple of block size
+	and	%o2, 0x3f, %o2		! residue bytes in %o2
+	cmp	%o2, 8			! Insure we do not load beyond
+	bgt	.Lunalign_adjust	! end of source buffer
+	 andn	%o1, 0x7, %o4		! %o4 has long word aligned src address
+	add	%o2, 64, %o2		! adjust to leave loop
+	sub	%o5, 64, %o5		! early if necessary
+.Lunalign_adjust:
+	alignaddr %o1, %g0, %g0		! generate %gsr
+	add	%o1, %o5, %o1		! advance %o1 to after blocks
+	EX_LD_FP(LOAD(ldd, %o4, %f0))
+.Lunalign_loop:
+	EX_LD_FP(LOAD(ldd, %o4+8, %f2))
+	faligndata %f0, %f2, %f16
+	EX_LD_FP(LOAD(ldd, %o4+16, %f4))
+	subcc	%o5, BLOCK_SIZE, %o5
+	EX_ST_FP(STORE(std, %f16, %o0))
+	faligndata %f2, %f4, %f18
+	EX_LD_FP(LOAD(ldd, %o4+24, %f6))
+	EX_ST_FP(STORE(std, %f18, %o0+8))
+	faligndata %f4, %f6, %f20
+	EX_LD_FP(LOAD(ldd, %o4+32, %f8))
+	EX_ST_FP(STORE(std, %f20, %o0+16))
+	faligndata %f6, %f8, %f22
+	EX_LD_FP(LOAD(ldd, %o4+40, %f10))
+	EX_ST_FP(STORE(std, %f22, %o0+24))
+	faligndata %f8, %f10, %f24
+	EX_LD_FP(LOAD(ldd, %o4+48, %f12))
+	EX_ST_FP(STORE(std, %f24, %o0+32))
+	faligndata %f10, %f12, %f26
+	EX_LD_FP(LOAD(ldd, %o4+56, %f14))
+	add	%o4, BLOCK_SIZE, %o4
+	EX_ST_FP(STORE(std, %f26, %o0+40))
+	faligndata %f12, %f14, %f28
+	EX_LD_FP(LOAD(ldd, %o4, %f0))
+	EX_ST_FP(STORE(std, %f28, %o0+48))
+	faligndata %f14, %f0, %f30
+	EX_ST_FP(STORE(std, %f30, %o0+56))
+	add	%o0, BLOCK_SIZE, %o0
+	bgu,pt	%ncc, .Lunalign_loop
+	 prefetch [%o4 + (5 * BLOCK_SIZE)], 20
+	ba	.Lunalign_done
+	 nop
+
+.Lunalign_large:
+	andcc	%o0, 0x3f, %o3		! is dst 64-byte block aligned?
+	bz	%ncc, .Lunalignsrc
+	 sub	%o3, 64, %o3		! %o3 will be multiple of 8
+	neg	%o3			! bytes until dest is 64 byte aligned
+	sub	%o2, %o3, %o2		! update cnt with bytes to be moved
+	! Move bytes according to source alignment
+	andcc	%o1, 0x1, %o5
+	bnz	%ncc, .Lunalignbyte	! check for byte alignment
+	 nop
+	andcc	%o1, 2, %o5		! check for half word alignment
+	bnz	%ncc, .Lunalignhalf
+	 nop
+	! Src is word aligned
+.Lunalignword:
+	EX_LD_FP(LOAD(ld, %o1, %o4))	! load 4 bytes
+	add	%o1, 8, %o1		! increase src ptr by 8
+	EX_ST_FP(STORE(stw, %o4, %o0))	! and store 4 bytes
+	subcc	%o3, 8, %o3		! decrease count by 8
+	EX_LD_FP(LOAD(ld, %o1-4, %o4))	! load 4 bytes
+	add	%o0, 8, %o0		! increase dst ptr by 8
+	bnz	%ncc, .Lunalignword
+	 EX_ST_FP(STORE(stw, %o4, %o0-4))! and store 4 bytes
+	ba	.Lunalignsrc
+	 nop
+
+	! Src is half-word aligned
+.Lunalignhalf:
+	EX_LD_FP(LOAD(lduh, %o1, %o4))	! load 2 bytes
+	sllx	%o4, 32, %o5		! shift left
+	EX_LD_FP(LOAD(lduw, %o1+2, %o4))
+	or	%o4, %o5, %o5
+	sllx	%o5, 16, %o5
+	EX_LD_FP(LOAD(lduh, %o1+6, %o4))
+	or	%o4, %o5, %o5
+	EX_ST_FP(STORE(stx, %o5, %o0))
+	add	%o1, 8, %o1
+	subcc	%o3, 8, %o3
+	bnz	%ncc, .Lunalignhalf
+	 add	%o0, 8, %o0
+	ba	.Lunalignsrc
+	 nop
+
+	! Src is Byte aligned
+.Lunalignbyte:
+	sub	%o0, %o1, %o0		! share pointer advance
+.Lunalignbyte_loop:
+	EX_LD_FP(LOAD(ldub, %o1, %o4))
+	sllx	%o4, 56, %o5
+	EX_LD_FP(LOAD(lduh, %o1+1, %o4))
+	sllx	%o4, 40, %o4
+	or	%o4, %o5, %o5
+	EX_LD_FP(LOAD(lduh, %o1+3, %o4))
+	sllx	%o4, 24, %o4
+	or	%o4, %o5, %o5
+	EX_LD_FP(LOAD(lduh, %o1+5, %o4))
+	sllx	%o4,  8, %o4
+	or	%o4, %o5, %o5
+	EX_LD_FP(LOAD(ldub, %o1+7, %o4))
+	or	%o4, %o5, %o5
+	add	%o0, %o1, %o0
+	EX_ST_FP(STORE(stx, %o5, %o0))
+	sub	%o0, %o1, %o0
+	subcc	%o3, 8, %o3
+	bnz	%ncc, .Lunalignbyte_loop
+	 add	%o1, 8, %o1
+	add	%o0,%o1, %o0 		! restore pointer
+
+	! Destination is now block (64 byte aligned)
+.Lunalignsrc:
+	andn	%o2, 0x3f, %o5		! %o5 is multiple of block size
+	and	%o2, 0x3f, %o2		! residue bytes in %o2
+	add	%o2, 64, %o2		! Insure we do not load beyond
+	sub	%o5, 64, %o5		! end of source buffer
+
+	andn	%o1, 0x7, %o4		! %o4 has long word aligned src address
+	alignaddr %o1, %g0, %g0		! generate %gsr
+	add	%o1, %o5, %o1		! advance %o1 to after blocks
+
+	EX_LD_FP(LOAD(ldd, %o4, %f14))
+	add	%o4, 8, %o4
+.Lunalign_sloop:
+	EX_LD_FP(LOAD(ldd, %o4, %f16))
+	faligndata %f14, %f16, %f0
+	EX_LD_FP(LOAD(ldd, %o4+8, %f18))
+	faligndata %f16, %f18, %f2
+	EX_LD_FP(LOAD(ldd, %o4+16, %f20))
+	faligndata %f18, %f20, %f4
+	EX_ST_FP(STORE(std, %f0, %o0))
+	subcc	%o5, 64, %o5
+	EX_LD_FP(LOAD(ldd, %o4+24, %f22))
+	faligndata %f20, %f22, %f6
+	EX_ST_FP(STORE(std, %f2, %o0+8))
+	EX_LD_FP(LOAD(ldd, %o4+32, %f24))
+	faligndata %f22, %f24, %f8
+	EX_ST_FP(STORE(std, %f4, %o0+16))
+	EX_LD_FP(LOAD(ldd, %o4+40, %f26))
+	faligndata %f24, %f26, %f10
+	EX_ST_FP(STORE(std, %f6, %o0+24))
+	EX_LD_FP(LOAD(ldd, %o4+48, %f28))
+	faligndata %f26, %f28, %f12
+	EX_ST_FP(STORE(std, %f8, %o0+32))
+	add	%o4, 64, %o4
+	EX_LD_FP(LOAD(ldd, %o4-8, %f30))
+	faligndata %f28, %f30, %f14
+	EX_ST_FP(STORE(std, %f10, %o0+40))
+	EX_ST_FP(STORE(std, %f12, %o0+48))
+	add	%o0, 64, %o0
+	EX_ST_FP(STORE(std, %f14, %o0-8))
+	fsrc2	%f30, %f14
+	bgu,pt	%ncc, .Lunalign_sloop
+	 prefetch [%o4 + (8 * BLOCK_SIZE)], 20
+
+.Lunalign_done:
+	! Handle trailing bytes, 64 to 127
+	! Dest long word aligned, Src not long word aligned
+	cmp	%o2, 15
+	bleu	%ncc, .Lunalign_short
+
+	 andn	%o2, 0x7, %o5		! %o5 is multiple of 8
+	and	%o2, 0x7, %o2		! residue bytes in %o2
+	add	%o2, 8, %o2
+	sub	%o5, 8, %o5		! insure we do not load past end of src
+	andn	%o1, 0x7, %o4		! %o4 has long word aligned src address
+	add	%o1, %o5, %o1		! advance %o1 to after multiple of 8
+	EX_LD_FP(LOAD(ldd, %o4, %f0))	! fetch partial word
+.Lunalign_by8:
+	EX_LD_FP(LOAD(ldd, %o4+8, %f2))
+	add	%o4, 8, %o4
+	faligndata %f0, %f2, %f16
+	subcc	%o5, 8, %o5
+	EX_ST_FP(STORE(std, %f16, %o0))
+	fsrc2	%f2, %f0
+	bgu,pt	%ncc, .Lunalign_by8
+	 add	%o0, 8, %o0
+
+.Lunalign_short:
+#ifdef NON_USER_COPY
+	VISExitHalfFast
+#else
+	VISExitHalf
+#endif
+	ba	.Lsmallrest
+	 nop
+
+/*
+ * This is a special case of nested memcpy. This can happen when kernel
+ * calls unaligned memcpy back to back without saving FP registers. We need
+ * traps(context switch) to save/restore FP registers. If the kernel calls
+ * memcpy without this trap sequence we will hit FP corruption. Let's use
+ * the normal integer load/store method in this case.
+ */
+
+#ifdef NON_USER_COPY
+.Lmedium_vis_entry_fail_cp:
+	or	%o0, %o1, %g2
+#endif
+.Lmedium_cp:
+	LOAD(prefetch, %o1 + 0x40, #n_reads_strong)
+	andcc	%g2, 0x7, %g0
+	bne,pn	%ncc, .Lmedium_unaligned_cp
+	 nop
+
+.Lmedium_noprefetch_cp:
+	andncc	%o2, 0x20 - 1, %o5
+	be,pn	%ncc, 2f
+	 sub	%o2, %o5, %o2
+1:	EX_LD(LOAD(ldx, %o1 + 0x00, %o3))
+	EX_LD(LOAD(ldx, %o1 + 0x08, %g2))
+	EX_LD(LOAD(ldx, %o1 + 0x10, %g7))
+	EX_LD(LOAD(ldx, %o1 + 0x18, %o4))
+	add	%o1, 0x20, %o1
+	subcc	%o5, 0x20, %o5
+	EX_ST(STORE(stx, %o3, %o0 + 0x00))
+	EX_ST(STORE(stx, %g2, %o0 + 0x08))
+	EX_ST(STORE(stx, %g7, %o0 + 0x10))
+	EX_ST(STORE(stx, %o4, %o0 + 0x18))
+	bne,pt	%ncc, 1b
+	 add	%o0, 0x20, %o0
+2:	andcc	%o2, 0x18, %o5
+	be,pt	%ncc, 3f
+	 sub	%o2, %o5, %o2
+1:	EX_LD(LOAD(ldx, %o1 + 0x00, %o3))
+	add	%o1, 0x08, %o1
+	add	%o0, 0x08, %o0
+	subcc	%o5, 0x08, %o5
+	bne,pt	%ncc, 1b
+	 EX_ST(STORE(stx, %o3, %o0 - 0x08))
+3:	brz,pt	%o2, .Lexit_cp
+	 cmp	%o2, 0x04
+	bl,pn	%ncc, .Ltiny_cp
+	 nop
+	EX_LD(LOAD(lduw, %o1 + 0x00, %o3))
+	add	%o1, 0x04, %o1
+	add	%o0, 0x04, %o0
+	subcc	%o2, 0x04, %o2
+	bne,pn	%ncc, .Ltiny_cp
+	 EX_ST(STORE(stw, %o3, %o0 - 0x04))
+	ba,a,pt	%ncc, .Lexit_cp
+
+.Lmedium_unaligned_cp:
+	/* First get dest 8 byte aligned.  */
+	sub	%g0, %o0, %o3
+	and	%o3, 0x7, %o3
+	brz,pt	%o3, 2f
+	 sub	%o2, %o3, %o2
+
+1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2))
+	add	%o1, 1, %o1
+	subcc	%o3, 1, %o3
+	add	%o0, 1, %o0
+	bne,pt	%ncc, 1b
+	 EX_ST(STORE(stb, %g2, %o0 - 0x01))
+2:
+	and	%o1, 0x7, %o3
+	brz,pn	%o3, .Lmedium_noprefetch_cp
+	 sll	%o3, 3, %o3
+	mov	64, %g2
+	sub	%g2, %o3, %g2
+	andn	%o1, 0x7, %o1
+	EX_LD(LOAD(ldx, %o1 + 0x00, %o4))
+	sllx	%o4, %o3, %o4
+	andn	%o2, 0x08 - 1, %o5
+	sub	%o2, %o5, %o2
+
+1:	EX_LD(LOAD(ldx, %o1 + 0x08, %g3))
+	add	%o1, 0x08, %o1
+	subcc	%o5, 0x08, %o5
+	srlx	%g3, %g2, %g7
+	or	%g7, %o4, %g7
+	EX_ST(STORE(stx, %g7, %o0 + 0x00))
+	add	%o0, 0x08, %o0
+	bne,pt	%ncc, 1b
+	 sllx	%g3, %o3, %o4
+	srl	%o3, 3, %o3
+	add	%o1, %o3, %o1
+	brz,pn	%o2, .Lexit_cp
+	 nop
+	ba,pt	%ncc, .Lsmall_unaligned_cp
+
+.Ltiny_cp:
+	EX_LD(LOAD(ldub, %o1 + 0x00, %o3))
+	subcc	%o2, 1, %o2
+	be,pn	%ncc, .Lexit_cp
+	 EX_ST(STORE(stb, %o3, %o0 + 0x00))
+	EX_LD(LOAD(ldub, %o1 + 0x01, %o3))
+	subcc	%o2, 1, %o2
+	be,pn	%ncc, .Lexit_cp
+	 EX_ST(STORE(stb, %o3, %o0 + 0x01))
+	EX_LD(LOAD(ldub, %o1 + 0x02, %o3))
+	ba,pt	%ncc, .Lexit_cp
+	 EX_ST(STORE(stb, %o3, %o0 + 0x02))
+
+.Lsmall_cp:
+	andcc	%g2, 0x3, %g0
+	bne,pn	%ncc, .Lsmall_unaligned_cp
+	 andn	%o2, 0x4 - 1, %o5
+	sub	%o2, %o5, %o2
+1:
+	EX_LD(LOAD(lduw, %o1 + 0x00, %o3))
+	add	%o1, 0x04, %o1
+	subcc	%o5, 0x04, %o5
+	add	%o0, 0x04, %o0
+	bne,pt	%ncc, 1b
+	 EX_ST(STORE(stw, %o3, %o0 - 0x04))
+	brz,pt	%o2, .Lexit_cp
+	 nop
+	ba,a,pt	%ncc, .Ltiny_cp
+
+.Lsmall_unaligned_cp:
+1:	EX_LD(LOAD(ldub, %o1 + 0x00, %o3))
+	add	%o1, 1, %o1
+	add	%o0, 1, %o0
+	subcc	%o2, 1, %o2
+	bne,pt	%ncc, 1b
+	 EX_ST(STORE(stb, %o3, %o0 - 0x01))
+	ba,a,pt	%ncc, .Lexit_cp
+
+.Lsmallrest:
+	tst	%o2
+	bz,pt	%ncc, .Lsmallx
+	 cmp	%o2, 4
+	blt,pn	%ncc, .Lsmallleft3
+	 nop
+	sub	%o2, 3, %o2
+.Lsmallnotalign4:
+	EX_LD(LOAD(ldub, %o1, %o3))! read byte
+	subcc	%o2, 4, %o2		! reduce count by 4
+	EX_ST(STORE(stb, %o3, %o0))	! write byte
+	EX_LD(LOAD(ldub, %o1+1, %o3))! repeat for total of 4 bytes
+	add	%o1, 4, %o1		! advance SRC by 4
+	EX_ST(STORE(stb, %o3, %o0+1))
+	EX_LD(LOAD(ldub, %o1-2, %o3))
+	add	%o0, 4, %o0		! advance DST by 4
+	EX_ST(STORE(stb, %o3, %o0-2))
+	EX_LD(LOAD(ldub, %o1-1, %o3))
+	bgu,pt	%ncc, .Lsmallnotalign4	! loop til 3 or fewer bytes remain
+	EX_ST(STORE(stb, %o3, %o0-1))
+	addcc	%o2, 3, %o2		! restore count
+	bz,pt	%ncc, .Lsmallx
+.Lsmallleft3:				! 1, 2, or 3 bytes remain
+	subcc	%o2, 1, %o2
+	EX_LD(LOAD(ldub, %o1, %o3))	! load one byte
+	bz,pt	%ncc, .Lsmallx
+	 EX_ST(STORE(stb, %o3, %o0))	! store one byte
+	EX_LD(LOAD(ldub, %o1+1, %o3))	! load second byte
+	subcc	%o2, 1, %o2
+	bz,pt	%ncc, .Lsmallx
+	 EX_ST(STORE(stb, %o3, %o0+1))! store second byte
+	EX_LD(LOAD(ldub, %o1+2, %o3))	! load third byte
+	EX_ST(STORE(stb, %o3, %o0+2))	! store third byte
+.Lsmallx:
+	retl
+	 mov	EX_RETVAL(%g1), %o0
+.Lsmallfin:
+	tst	%o2
+	bnz,pn	%ncc, .Lsmallleft3
+	 nop
+	retl
+	 mov	EX_RETVAL(%g1), %o0	! restore %o0
+.Lexit_cp:
+	retl
+	 mov	EX_RETVAL(%g1), %o0
+	.size  FUNC_NAME, .-FUNC_NAME
diff --git a/arch/sparc/lib/M7memset.S b/arch/sparc/lib/M7memset.S
new file mode 100644
index 0000000..9a144e8
--- /dev/null
+++ b/arch/sparc/lib/M7memset.S
@@ -0,0 +1,354 @@
+/*
+ * M7memset.S: SPARC M7 optimized memset.
+ *
+ * Copyright (c) 2016, Oracle and/or its affiliates.  All rights reserved.
+ */
+
+/*
+ * M7memset.S: M7 optimized memset.
+ *
+ * char *memset(sp, c, n)
+ *
+ * Set an array of n chars starting at sp to the character c.
+ * Return sp.
+ *
+ * Fast assembler language version of the following C-program for memset
+ * which represents the `standard' for the C-library.
+ *
+ *	void *
+ *	memset(void *sp1, int c, size_t n)
+ *	{
+ *	    if (n != 0) {
+ *		char *sp = sp1;
+ *		do {
+ *		    *sp++ = (char)c;
+ *		} while (--n != 0);
+ *	    }
+ *	    return (sp1);
+ *	}
+ *
+ * The algorithm is as follows :
+ *
+ *	For small 6 or fewer bytes stores, bytes will be stored.
+ *
+ *	For less than 32 bytes stores, align the address on 4 byte boundary.
+ *	Then store as many 4-byte chunks, followed by trailing bytes.
+ *
+ *	For sizes greater than 32 bytes, align the address on 8 byte boundary.
+ *	if (count >= 64) {
+ *      	store 8-bytes chunks to align the address on 64 byte boundary
+ *		if (value to be set is zero && count >= MIN_ZERO) {
+ *              	Using BIS stores, set the first long word of each
+ *			64-byte cache line to zero which will also clear the
+ *			other seven long words of the cache line.
+ *       	}
+ *       	else if (count >= MIN_LOOP) {
+ *       		Using BIS stores, set the first long word of each of
+ *              	ST_CHUNK cache lines (64 bytes each) before the main
+ *			loop is entered.
+ *              	In the main loop, continue pre-setting the first long
+ *              	word of each cache line ST_CHUNK lines in advance while
+ *              	setting the other seven long words (56 bytes) of each
+ * 			cache line until fewer than ST_CHUNK*64 bytes remain.
+ *			Then set the remaining seven long words of each cache
+ * 			line that has already had its first long word set.
+ *       	}
+ *       	store remaining data in 64-byte chunks until less than
+ *       	64 bytes remain.
+ *       }
+ *       Store as many 8-byte chunks, followed by trailing bytes.
+ *
+ * BIS = Block Init Store
+ *   Doing the advance store of the first element of the cache line
+ *   initiates the displacement of a cache line while only using a single
+ *   instruction in the pipeline. That avoids various pipeline delays,
+ *   such as filling the miss buffer. The performance effect is
+ *   similar to prefetching for normal stores.
+ *   The special case for zero fills runs faster and uses fewer instruction
+ *   cycles than the normal memset loop.
+ *
+ * We only use BIS for memset of greater than MIN_LOOP bytes because a sequence
+ * BIS stores must be followed by a membar #StoreStore. The benefit of
+ * the BIS store must be balanced against the cost of the membar operation.
+ */
+
+/*
+ * ASI_STBI_P marks the cache line as "least recently used"
+ * which means if many threads are active, it has a high chance
+ * of being pushed out of the cache between the first initializing
+ * store and the final stores.
+ * Thus, we use ASI_STBIMRU_P which marks the cache line as
+ * "most recently used" for all but the last store to the cache line.
+ */
+
+#include <asm/asi.h>
+#include <asm/page.h>
+
+#define ASI_STBI_P      ASI_BLK_INIT_QUAD_LDD_P
+#define ASI_STBIMRU_P   ASI_ST_BLKINIT_MRU_P
+
+
+#define ST_CHUNK        24   /* multiple of 4 due to loop unrolling */
+#define MIN_LOOP        16320
+#define MIN_ZERO        512
+
+
+	.section	".text"
+	.align		32
+
+/*
+ * Define clear_page(dest) as memset(dest, 0, PAGE_SIZE)
+ * (can create a more optimized version later.)
+ */
+	.globl		M7clear_page
+	.globl		M7clear_user_page
+M7clear_page:		/* clear_page(dest) */
+M7clear_user_page:
+	set	PAGE_SIZE, %o1
+	/* fall through into bzero code */
+
+	.size		M7clear_page,.-M7clear_page
+	.size		M7clear_user_page,.-M7clear_user_page
+
+/*
+ * Define bzero(dest, n) as memset(dest, 0, n)
+ * (can create a more optimized version later.)
+ */
+	.globl		M7bzero
+M7bzero:		/* bzero(dest, size) */
+	mov %o1, %o2
+	mov 0, %o1
+	/* fall through into memset code */
+
+	.size		M7bzero,.-M7bzero
+
+        .global M7memset
+        .type   M7memset, #function
+        .register %g3, #scratch
+M7memset:
+         mov     %o0, %o5                ! copy sp1 before using it
+        cmp     %o2, 7                  ! if small counts, just write bytes
+        bleu,pn %ncc, .wrchar
+         and     %o1, 0xff, %o1          ! o1 is (char)c
+
+        sll     %o1, 8, %o3
+        or      %o1, %o3, %o1           ! now o1 has 2 bytes of c
+        sll     %o1, 16, %o3
+        cmp     %o2, 32
+        blu,pn  %ncc, .wdalign
+         or      %o1, %o3, %o1           ! now o1 has 4 bytes of c
+
+        sllx    %o1, 32, %o3
+        or      %o1, %o3, %o1           ! now o1 has 8 bytes of c
+
+.dbalign:
+        andcc   %o5, 7, %o3             ! is sp1 aligned on a 8 byte bound?
+        bz,pt   %ncc, .blkalign         ! already long word aligned
+         sub     %o3, 8, %o3             ! -(bytes till long word aligned)
+
+        add     %o2, %o3, %o2           ! update o2 with new count
+        ! Set -(%o3) bytes till sp1 long word aligned
+1:      stb     %o1, [%o5]              ! there is at least 1 byte to set
+	inccc   %o3                     ! byte clearing loop
+        bl,pt   %ncc, 1b
+	 inc     %o5
+
+        ! Now sp1 is long word aligned (sp1 is found in %o5)
+.blkalign:
+        cmp     %o2, 64                 ! check if there are 64 bytes to set
+        blu,pn  %ncc, .wrshort
+         mov     %o2, %o3
+
+        andcc   %o5, 63, %o3            ! is sp1 block aligned?
+        bz,pt   %ncc, .blkwr            ! now block aligned
+         sub     %o3, 64, %o3            ! o3 is -(bytes till block aligned)
+        add     %o2, %o3, %o2           ! o2 is the remainder
+
+        ! Store -(%o3) bytes till dst is block (64 byte) aligned.
+        ! Use long word stores.
+        ! Recall that dst is already long word aligned
+1:
+        addcc   %o3, 8, %o3
+        stx     %o1, [%o5]
+        bl,pt   %ncc, 1b
+         add     %o5, 8, %o5
+
+        ! Now sp1 is block aligned
+.blkwr:
+        andn    %o2, 63, %o4            ! calculate size of blocks in bytes
+        brz,pn  %o1, .wrzero            ! special case if c = 0
+         and     %o2, 63, %o3            ! %o3 = bytes left after blk stores.
+
+        set     MIN_LOOP, %g1
+        cmp     %o4, %g1                ! check there are enough bytes to set
+	blu,pn  %ncc, .short_set        ! to justify cost of membar
+                                        ! must be > pre-cleared lines
+         nop
+
+        ! initial cache-clearing stores
+        ! get store pipeline moving
+	rd	%asi, %g3		! save %asi to be restored later
+        wr     %g0, ASI_STBIMRU_P, %asi
+
+!       Primary memset loop for large memsets
+.wr_loop:
+        sub     %o5, 8, %o5		! adjust %o5 for ASI store alignment
+        mov     ST_CHUNK, %g1
+.wr_loop_start:
+        stxa    %o1, [%o5+8]%asi
+        subcc   %g1, 4, %g1
+        stxa    %o1, [%o5+8+64]%asi
+        add     %o5, 256, %o5
+        stxa    %o1, [%o5+8-128]%asi
+        bgu     %ncc, .wr_loop_start
+         stxa    %o1, [%o5+8-64]%asi
+
+        sub     %o5, ST_CHUNK*64, %o5	! reset %o5
+        mov     ST_CHUNK, %g1
+
+.wr_loop_rest:
+        stxa    %o1, [%o5+8+8]%asi
+        sub     %o4, 64, %o4
+        stxa    %o1, [%o5+16+8]%asi
+        subcc   %g1, 1, %g1
+        stxa    %o1, [%o5+24+8]%asi
+        stxa    %o1, [%o5+32+8]%asi
+        stxa    %o1, [%o5+40+8]%asi
+        add     %o5, 64, %o5
+        stxa    %o1, [%o5-8]%asi
+        bgu     %ncc, .wr_loop_rest
+         stxa    %o1, [%o5]ASI_STBI_P
+
+        ! If more than ST_CHUNK*64 bytes remain to set, continue
+        ! setting the first long word of each cache line in advance
+        ! to keep the store pipeline moving.
+
+        cmp     %o4, ST_CHUNK*64
+        bge,pt  %ncc, .wr_loop_start
+         mov     ST_CHUNK, %g1
+
+        brz,a,pn %o4, .asi_done
+         add     %o5, 8, %o5             ! restore %o5 offset
+
+.wr_loop_small:
+        stxa    %o1, [%o5+8]%asi
+        stxa    %o1, [%o5+8+8]%asi
+        stxa    %o1, [%o5+16+8]%asi
+        stxa    %o1, [%o5+24+8]%asi
+        stxa    %o1, [%o5+32+8]%asi
+        subcc   %o4, 64, %o4
+        stxa    %o1, [%o5+40+8]%asi
+        add     %o5, 64, %o5
+        stxa    %o1, [%o5-8]%asi
+        bgu,pt  %ncc, .wr_loop_small
+         stxa    %o1, [%o5]ASI_STBI_P
+
+        ba      .asi_done
+         add     %o5, 8, %o5             ! restore %o5 offset
+
+!       Special case loop for zero fill memsets
+!       For each 64 byte cache line, single STBI to first element
+!       clears line
+!
+.wrzero:
+        cmp     %o4, MIN_ZERO           ! check if enough bytes to set
+                                        ! to pay %asi + membar cost
+        blu     %ncc, .short_set
+         nop
+        sub     %o4, 256, %o4
+
+.wrzero_loop:
+
+        mov     64, %g3
+        stxa    %o1, [%o5]ASI_STBI_P
+        subcc   %o4, 256, %o4
+        stxa    %o1, [%o5+%g3]ASI_STBI_P
+        add     %o5, 256, %o5
+        sub     %g3, 192, %g3
+        stxa    %o1, [%o5+%g3]ASI_STBI_P
+        add %g3, 64, %g3
+        bge,pt  %ncc, .wrzero_loop
+         stxa    %o1, [%o5+%g3]ASI_STBI_P
+        add     %o4, 256, %o4
+
+        brz,pn  %o4, .bsi_done
+         nop
+.wrzero_small:
+        stxa    %o1, [%o5]ASI_STBI_P
+        subcc   %o4, 64, %o4
+        bgu,pt  %ncc, .wrzero_small
+         add     %o5, 64, %o5
+	ba,a	.bsi_done
+
+.asi_done:
+	wr	%g3, 0x0, %asi		! restored saved %asi
+.bsi_done:
+        membar  #StoreStore             ! required by use of Block Store Init
+
+.short_set:
+        cmp     %o4, 64                 ! check if 64 bytes to set
+        blu     %ncc, 5f
+         nop
+4:                                      ! set final blocks of 64 bytes
+        stx     %o1, [%o5]
+        stx     %o1, [%o5+8]
+        stx     %o1, [%o5+16]
+        stx     %o1, [%o5+24]
+        subcc   %o4, 64, %o4
+        stx     %o1, [%o5+32]
+        stx     %o1, [%o5+40]
+        add     %o5, 64, %o5
+        stx     %o1, [%o5-16]
+        bgu,pt  %ncc, 4b
+         stx     %o1, [%o5-8]
+
+5:
+        ! Set the remaining long words
+.wrshort:
+        subcc   %o3, 8, %o3             ! Can we store any long words?
+        blu,pn  %ncc, .wrchars
+         and     %o2, 7, %o2             ! calc bytes left after long words
+6:
+        subcc   %o3, 8, %o3
+        stx     %o1, [%o5]              ! store the long words
+        bgeu,pt %ncc, 6b
+         add     %o5, 8, %o5
+
+.wrchars:                               ! check for extra chars
+        brnz    %o2, .wrfin
+         nop
+        retl
+         nop
+
+.wdalign:
+        andcc   %o5, 3, %o3             ! is sp1 aligned on a word boundary
+        bz,pn   %ncc, .wrword
+         andn    %o2, 3, %o3             ! create word sized count in %o3
+
+        dec     %o2                     ! decrement count
+        stb     %o1, [%o5]              ! clear a byte
+        b       .wdalign
+         inc     %o5                     ! next byte
+
+.wrword:
+        subcc   %o3, 4, %o3
+        st      %o1, [%o5]              ! 4-byte writing loop
+        bnz,pt  %ncc, .wrword
+         add     %o5, 4, %o5
+
+        and     %o2, 3, %o2             ! leftover count, if any
+
+.wrchar:
+        ! Set the remaining bytes, if any
+        brz     %o2, .exit
+         nop
+.wrfin:
+        deccc   %o2
+        stb     %o1, [%o5]
+        bgu,pt  %ncc, .wrfin
+         inc     %o5
+.exit:
+        retl                            ! %o0 was preserved
+         nop
+
+	.size		M7memset,.-M7memset
diff --git a/arch/sparc/lib/M7patch.S b/arch/sparc/lib/M7patch.S
new file mode 100644
index 0000000..01fe107
--- /dev/null
+++ b/arch/sparc/lib/M7patch.S
@@ -0,0 +1,55 @@
+/*
+ * M7patch.S: Patch generic routines with M7 variant.
+ *
+ * Copyright (c) 2016, Oracle and/or its affiliates.  All rights reserved.
+ */
+
+#define BRANCH_ALWAYS	0x10680000
+#define NOP		0x01000000
+#define NG_DO_PATCH(OLD, NEW)	\
+	sethi	%hi(NEW), %g1; \
+	or	%g1, %lo(NEW), %g1; \
+	sethi	%hi(OLD), %g2; \
+	or	%g2, %lo(OLD), %g2; \
+	sub	%g1, %g2, %g1; \
+	sethi	%hi(BRANCH_ALWAYS), %g3; \
+	sll	%g1, 11, %g1; \
+	srl	%g1, 11 + 2, %g1; \
+	or	%g3, %lo(BRANCH_ALWAYS), %g3; \
+	or	%g3, %g1, %g3; \
+	stw	%g3, [%g2]; \
+	sethi	%hi(NOP), %g3; \
+	or	%g3, %lo(NOP), %g3; \
+	stw	%g3, [%g2 + 0x4]; \
+	flush	%g2;
+
+	.globl	m7_patch_copyops
+	.type	m7_patch_copyops,#function
+m7_patch_copyops:
+	NG_DO_PATCH(memcpy, M7memcpy)
+	NG_DO_PATCH(raw_copy_from_user, M7copy_from_user)
+	NG_DO_PATCH(raw_copy_to_user, M7copy_to_user)
+	retl
+	 nop
+	.size	m7_patch_copyops,.-m7_patch_copyops
+
+	.globl	m7_patch_bzero
+	.type	m7_patch_bzero,#function
+m7_patch_bzero:
+	NG_DO_PATCH(memset, M7memset)
+	NG_DO_PATCH(__bzero, M7bzero)
+	NG_DO_PATCH(__clear_user, NGclear_user)
+	NG_DO_PATCH(tsb_init, NGtsb_init)
+	retl
+	 nop
+	.size	m7_patch_bzero,.-m7_patch_bzero
+
+	.globl	m7_patch_pageops
+	.type	m7_patch_pageops,#function
+m7_patch_pageops:
+	NG_DO_PATCH(copy_user_page, NG4copy_user_page)
+	NG_DO_PATCH(_clear_page, M7clear_page)
+	NG_DO_PATCH(clear_user_page, M7clear_user_page)
+	retl
+	 nop
+	.size	m7_patch_pageops,.-m7_patch_pageops
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 37930c0..a1a2d39 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -38,6 +38,9 @@ lib-$(CONFIG_SPARC64) +=  NG4patch.o NG4copy_page.o NG4clear_page.o NG4memset.o
 
 lib-$(CONFIG_SPARC64) += Memcpy_utils.o
 
+lib-$(CONFIG_SPARC64) += M7memcpy.o M7copy_from_user.o M7copy_to_user.o
+lib-$(CONFIG_SPARC64) += M7patch.o M7memset.o
+
 lib-$(CONFIG_SPARC64) += GENmemcpy.o GENcopy_from_user.o GENcopy_to_user.o
 lib-$(CONFIG_SPARC64) += GENpatch.o GENpage.o GENbzero.o
 
-- 
1.7.1

