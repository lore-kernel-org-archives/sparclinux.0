From: David Miller <davem@davemloft.net>
Date: Thu, 27 Sep 2012 07:45:18 +0000
Subject: [PATCH] sparc64: Add SPARC-T4 optimized memcpy.
Message-Id: <20120927.034518.2250968754026502091.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


		Before		After
		--------------	--------------
bw_tcp:         1288.53 MB/sec	1637.77 MB/sec
bw_pipe:        1517.18 MB/sec	2107.61 MB/sec
bw_unix:        1838.38 MB/sec	2640.91 MB/sec

make -s -j128
allmodconfig	5min 49sec	5min 31sec

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/head_64.S        |   14 +-
 arch/sparc/lib/Makefile            |    3 +
 arch/sparc/lib/NG4copy_from_user.S |   30 +++
 arch/sparc/lib/NG4copy_page.S      |   57 ++++++
 arch/sparc/lib/NG4copy_to_user.S   |   39 ++++
 arch/sparc/lib/NG4memcpy.S         |  360 ++++++++++++++++++++++++++++++++=
++++
 arch/sparc/lib/NG4patch.S          |   43 +++++
 arch/sparc/lib/NGpage.S            |    2 +
 8 files changed, 546 insertions(+), 2 deletions(-)
 create mode 100644 arch/sparc/lib/NG4copy_from_user.S
 create mode 100644 arch/sparc/lib/NG4copy_page.S
 create mode 100644 arch/sparc/lib/NG4copy_to_user.S
 create mode 100644 arch/sparc/lib/NG4memcpy.S
 create mode 100644 arch/sparc/lib/NG4patch.S

diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index b42ddbf..ee5dcce 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -559,10 +559,10 @@ niagara_tlb_fixup:
 	be,pt	%xcc, niagara2_patch
 	 nop
 	cmp	%g1, SUN4V_CHIP_NIAGARA4
-	be,pt	%xcc, niagara2_patch
+	be,pt	%xcc, niagara4_patch
 	 nop
 	cmp	%g1, SUN4V_CHIP_NIAGARA5
-	be,pt	%xcc, niagara2_patch
+	be,pt	%xcc, niagara4_patch
 	 nop
=20
 	call	generic_patch_copyops
@@ -573,6 +573,16 @@ niagara_tlb_fixup:
 	 nop
=20
 	ba,a,pt	%xcc, 80f
+niagara4_patch:
+	call	niagara4_patch_copyops
+	 nop
+	call	niagara_patch_bzero
+	 nop
+	call	niagara4_patch_pageops
+	 nop
+
+	ba,a,pt	%xcc, 80f
+
 niagara2_patch:
 	call	niagara2_patch_copyops
 	 nop
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index dff4096..30f6ab5 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -32,6 +32,9 @@ lib-$(CONFIG_SPARC64) +=3D NGpatch.o NGpage.o NGbzero.o
 lib-$(CONFIG_SPARC64) +=3D NG2memcpy.o NG2copy_from_user.o NG2copy_to_user=
.o
 lib-$(CONFIG_SPARC64) +=3D  NG2patch.o
=20
+lib-$(CONFIG_SPARC64) +=3D NG4memcpy.o NG4copy_from_user.o NG4copy_to_user=
.o
+lib-$(CONFIG_SPARC64) +=3D  NG4patch.o NG4copy_page.o
+
 lib-$(CONFIG_SPARC64) +=3D GENmemcpy.o GENcopy_from_user.o GENcopy_to_user=
.o
 lib-$(CONFIG_SPARC64) +=3D GENpatch.o GENpage.o GENbzero.o
=20
diff --git a/arch/sparc/lib/NG4copy_from_user.S b/arch/sparc/lib/NG4copy_fr=
om_user.S
new file mode 100644
index 0000000..c8e9830
--- /dev/null
+++ b/arch/sparc/lib/NG4copy_from_user.S
@@ -0,0 +1,30 @@
+/* NG4copy_from_user.S: Niagara-2 optimized copy from userspace.
+ *
+ * Copyright (C) 2012 David S. Miller (davem@davemloft.net)
+ */
+
+#define EX_LD(x)		\
+98:	x;			\
+	.section __ex_table,"a";\
+	.align 4;		\
+	.word 98b, __retl_one_asi;\
+	.text;			\
+	.align 4;
+
+#ifndef ASI_AIUS
+#define ASI_AIUS	0x11
+#endif
+
+#define FUNC_NAME		NG4copy_from_user
+#define LOAD(type,addr,dest)	type##a [addr] %asi, dest
+#define EX_RETVAL(x)		0
+
+#ifdef __KERNEL__
+#define PREAMBLE					\
+	rd		%asi, %g1;			\
+	cmp		%g1, ASI_AIUS;			\
+	bne,pn		%icc, ___copy_in_user;		\
+	 nop
+#endif
+
+#include "NG4memcpy.S"
diff --git a/arch/sparc/lib/NG4copy_page.S b/arch/sparc/lib/NG4copy_page.S
new file mode 100644
index 0000000..f30ec10
--- /dev/null
+++ b/arch/sparc/lib/NG4copy_page.S
@@ -0,0 +1,57 @@
+/* NG4copy_page.S: Niagara-4 optimized copy page.
+ *
+ * Copyright (C) 2012 (davem@davemloft.net)
+ */
+
+#include <asm/asi.h>
+#include <asm/page.h>
+
+	.text
+	.align		32
+
+	.register	%g2, #scratch
+	.register	%g3, #scratch
+
+	.globl		NG4copy_user_page
+NG4copy_user_page:	/* %o0=DEst, %o1=3Dsrc, %o2=3Dvaddr */
+	prefetch	[%o1 + 0x000], #n_reads_strong
+	prefetch	[%o1 + 0x040], #n_reads_strong
+	prefetch	[%o1 + 0x080], #n_reads_strong
+	prefetch	[%o1 + 0x0c0], #n_reads_strong
+	set		PAGE_SIZE, %g7
+	prefetch	[%o1 + 0x100], #n_reads_strong
+	prefetch	[%o1 + 0x140], #n_reads_strong
+	prefetch	[%o1 + 0x180], #n_reads_strong
+	prefetch	[%o1 + 0x1c0], #n_reads_strong
+1:
+	ldx		[%o1 + 0x00], %o2
+	subcc		%g7, 0x40, %g7
+	ldx		[%o1 + 0x08], %o3
+	ldx		[%o1 + 0x10], %o4
+	ldx		[%o1 + 0x18], %o5
+	ldx		[%o1 + 0x20], %g1
+	stxa		%o2, [%o0] ASI_BLK_INIT_QUAD_LDD_P
+	add		%o0, 0x08, %o0
+	ldx		[%o1 + 0x28], %g2
+	stxa		%o3, [%o0] ASI_BLK_INIT_QUAD_LDD_P
+	add		%o0, 0x08, %o0
+	ldx		[%o1 + 0x30], %g3
+	stxa		%o4, [%o0] ASI_BLK_INIT_QUAD_LDD_P
+	add		%o0, 0x08, %o0
+	ldx		[%o1 + 0x38], %o2
+	add		%o1, 0x40, %o1
+	stxa		%o5, [%o0] ASI_BLK_INIT_QUAD_LDD_P
+	add		%o0, 0x08, %o0
+	stxa		%g1, [%o0] ASI_BLK_INIT_QUAD_LDD_P
+	add		%o0, 0x08, %o0
+	stxa		%g2, [%o0] ASI_BLK_INIT_QUAD_LDD_P
+	add		%o0, 0x08, %o0
+	stxa		%g3, [%o0] ASI_BLK_INIT_QUAD_LDD_P
+	add		%o0, 0x08, %o0
+	stxa		%o2, [%o0] ASI_BLK_INIT_QUAD_LDD_P
+	add		%o0, 0x08, %o0
+	bne,pt		%icc, 1b
+	 prefetch	[%o1 + 0x200], #n_reads_strong
+	retl
+	 membar		#StoreLoad | #StoreStore
+	.size		NG4copy_user_page,.-NG4copy_user_page
diff --git a/arch/sparc/lib/NG4copy_to_user.S b/arch/sparc/lib/NG4copy_to_u=
ser.S
new file mode 100644
index 0000000..9744c454
--- /dev/null
+++ b/arch/sparc/lib/NG4copy_to_user.S
@@ -0,0 +1,39 @@
+/* NG4copy_to_user.S: Niagara-4 optimized copy to userspace.
+ *
+ * Copyright (C) 2012 David S. Miller (davem@davemloft.net)
+ */
+
+#define EX_ST(x)		\
+98:	x;			\
+	.section __ex_table,"a";\
+	.align 4;		\
+	.word 98b, __retl_one_asi;\
+	.text;			\
+	.align 4;
+
+#ifndef ASI_AIUS
+#define ASI_AIUS	0x11
+#endif
+
+#ifndef ASI_BLK_INIT_QUAD_LDD_AIUS
+#define ASI_BLK_INIT_QUAD_LDD_AIUS 0x23
+#endif
+
+#define FUNC_NAME		NG4copy_to_user
+#define STORE(type,src,addr)	type##a src, [addr] %asi
+#define STORE_ASI		ASI_BLK_INIT_QUAD_LDD_AIUS
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
+	bne,pn		%icc, ___copy_in_user;		\
+	 nop
+#endif
+
+#include "NG4memcpy.S"
diff --git a/arch/sparc/lib/NG4memcpy.S b/arch/sparc/lib/NG4memcpy.S
new file mode 100644
index 0000000..6f4b526
--- /dev/null
+++ b/arch/sparc/lib/NG4memcpy.S
@@ -0,0 +1,360 @@
+/* NG4memcpy.S: Niagara-4 optimized memcpy.
+ *
+ * Copyright (C) 2012 David S. Miller (davem@davemloft.net)
+ */
+
+#ifdef __KERNEL__
+#include <asm/visasm.h>
+#include <asm/asi.h>
+#define GLOBAL_SPARE	%g7
+#else
+#define ASI_BLK_INIT_QUAD_LDD_P 0xe2
+#define FPRS_FEF  0x04
+
+/* On T4 it is very expensive to access ASRs like %fprs and
+ * %asi, avoiding a read or a write can save ~50 cycles.
+ */
+#define FPU_ENTER			\
+	rd	%fprs, %o5;		\
+	andcc	%o5, FPRS_FEF, %g0;	\
+	be,a,pn	%icc, 999f;		\
+	 wr	%g0, FPRS_FEF, %fprs;	\
+	999:
+
+#ifdef MEMCPY_DEBUG
+#define VISEntryHalf FPU_ENTER; \
+		     clr %g1; clr %g2; clr %g3; clr %g5; subcc %g0, %g0, %g0;
+#define VISExitHalf and %o5, FPRS_FEF, %o5; wr %o5, 0x0, %fprs
+#else
+#define VISEntryHalf FPU_ENTER
+#define VISExitHalf and %o5, FPRS_FEF, %o5; wr %o5, 0x0, %fprs
+#endif
+
+#define GLOBAL_SPARE	%g5
+#endif
+
+#ifndef STORE_ASI
+#ifndef SIMULATE_NIAGARA_ON_NON_NIAGARA
+#define STORE_ASI	ASI_BLK_INIT_QUAD_LDD_P
+#else
+#define STORE_ASI	0x80		/* ASI_P */
+#endif
+#endif
+
+#ifndef EX_LD
+#define EX_LD(x)	x
+#endif
+
+#ifndef EX_ST
+#define EX_ST(x)	x
+#endif
+
+#ifndef EX_RETVAL
+#define EX_RETVAL(x)	x
+#endif
+
+#ifndef LOAD
+#define LOAD(type,addr,dest)	type [addr], dest
+#endif
+
+#ifndef STORE
+#ifndef MEMCPY_DEBUG
+#define STORE(type,src,addr)	type src, [addr]
+#else
+#define STORE(type,src,addr)	type##a src, [addr] %asi
+#endif
+#endif
+
+#ifndef STORE_INIT
+#define STORE_INIT(src,addr)	stxa src, [addr] STORE_ASI
+#endif
+
+#ifndef FUNC_NAME
+#define FUNC_NAME	NG4memcpy
+#endif
+#ifndef PREAMBLE
+#define PREAMBLE
+#endif
+
+#ifndef XCC
+#define XCC xcc
+#endif
+
+	.register	%g2,#scratch
+	.register	%g3,#scratch
+
+	.text
+	.align		64
+
+	.globl	FUNC_NAME
+	.type	FUNC_NAME,#function
+FUNC_NAME:	/* %o0=3Ddst, %o1=3Dsrc, %o2=3Dlen */
+#ifdef MEMCPY_DEBUG
+	wr		%g0, 0x80, %asi
+#endif
+	srlx		%o2, 31, %g2
+	cmp		%g2, 0
+	tne		%XCC, 5
+	PREAMBLE
+	mov		%o0, %o3
+	brz,pn		%o2, .Lexit
+	 cmp		%o2, 3
+	ble,pn		%icc, .Ltiny
+	 cmp		%o2, 19
+	ble,pn		%icc, .Lsmall
+	 or		%o0, %o1, %g2
+	cmp		%o2, 128
+	bl,pn		%icc, .Lmedium
+	 nop
+
+.Llarge:/* len >=3D 0x80 */
+	/* First get dest 8 byte aligned.  */
+	sub		%g0, %o0, %g1
+	and		%g1, 0x7, %g1
+	brz,pt		%g1, 51f
+	 sub		%o2, %g1, %o2
+=09
+1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2))
+	add		%o1, 1, %o1
+	subcc		%g1, 1, %g1
+	add		%o0, 1, %o0
+	bne,pt		%icc, 1b
+	 EX_ST(STORE(stb, %g2, %o0 - 0x01))
+
+51:	LOAD(prefetch, %o1 + 0x040, #n_reads_strong)
+	LOAD(prefetch, %o1 + 0x080, #n_reads_strong)
+	LOAD(prefetch, %o1 + 0x0c0, #n_reads_strong)
+	LOAD(prefetch, %o1 + 0x100, #n_reads_strong)
+	LOAD(prefetch, %o1 + 0x140, #n_reads_strong)
+	LOAD(prefetch, %o1 + 0x180, #n_reads_strong)
+	LOAD(prefetch, %o1 + 0x1c0, #n_reads_strong)
+	LOAD(prefetch, %o1 + 0x200, #n_reads_strong)
+
+	/* Check if we can use the straight fully aligned
+	 * loop, or we require the alignaddr/faligndata variant.
+	 */
+	andcc		%o1, 0x7, %o5
+	bne,pn		%icc, .Llarge_src_unaligned
+	 sub		%g0, %o0, %g1
+
+	/* Legitimize the use of initializing stores by getting dest
+	 * to be 64-byte aligned.
+	 */
+	and		%g1, 0x3f, %g1
+	brz,pt		%g1, .Llarge_aligned
+	 sub		%o2, %g1, %o2
+=09
+1:	EX_LD(LOAD(ldx, %o1 + 0x00, %g2))
+	add		%o1, 8, %o1
+	subcc		%g1, 8, %g1
+	add		%o0, 8, %o0
+	bne,pt		%icc, 1b
+	 EX_ST(STORE(stx, %g2, %o0 - 0x08))
+
+.Llarge_aligned:
+	/* len >=3D 0x80 && src 8-byte aligned && dest 8-byte aligned */
+	andn		%o2, 0x3f, %o4
+	sub		%o2, %o4, %o2
+
+1:	EX_LD(LOAD(ldx, %o1 + 0x00, %g1))
+	add		%o1, 0x40, %o1
+	EX_LD(LOAD(ldx, %o1 - 0x38, %g2))
+	subcc		%o4, 0x40, %o4
+	EX_LD(LOAD(ldx, %o1 - 0x30, %g3))
+	EX_LD(LOAD(ldx, %o1 - 0x28, GLOBAL_SPARE))
+	EX_LD(LOAD(ldx, %o1 - 0x20, %o5))
+	EX_ST(STORE_INIT(%g1, %o0))
+	add		%o0, 0x08, %o0
+	EX_ST(STORE_INIT(%g2, %o0))
+	add		%o0, 0x08, %o0
+	EX_LD(LOAD(ldx, %o1 - 0x18, %g2))
+	EX_ST(STORE_INIT(%g3, %o0))
+	add		%o0, 0x08, %o0
+	EX_LD(LOAD(ldx, %o1 - 0x10, %g3))
+	EX_ST(STORE_INIT(GLOBAL_SPARE, %o0))
+	add		%o0, 0x08, %o0
+	EX_LD(LOAD(ldx, %o1 - 0x08, GLOBAL_SPARE))
+	EX_ST(STORE_INIT(%o5, %o0))
+	add		%o0, 0x08, %o0
+	EX_ST(STORE_INIT(%g2, %o0))
+	add		%o0, 0x08, %o0
+	EX_ST(STORE_INIT(%g3, %o0))
+	add		%o0, 0x08, %o0
+	EX_ST(STORE_INIT(GLOBAL_SPARE, %o0))
+	add		%o0, 0x08, %o0
+	bne,pt		%icc, 1b
+	 LOAD(prefetch, %o1 + 0x200, #n_reads_strong)
+
+	membar		#StoreLoad | #StoreStore
+
+	brz,pn		%o2, .Lexit
+	 cmp		%o2, 19
+	ble,pn		%icc, .Lsmall_unaligned
+	 nop
+	ba,a,pt		%icc, .Lmedium_noprefetch
+
+.Lexit:	retl
+	 mov		EX_RETVAL(%o3), %o0
+
+.Llarge_src_unaligned:
+	andn		%o2, 0x3f, %o4
+	sub		%o2, %o4, %o2
+	VISEntryHalf
+	alignaddr	%o1, %g0, %g1
+	add		%o1, %o4, %o1
+	EX_LD(LOAD(ldd, %g1 + 0x00, %f0))
+1:	EX_LD(LOAD(ldd, %g1 + 0x08, %f2))
+	subcc		%o4, 0x40, %o4
+	EX_LD(LOAD(ldd, %g1 + 0x10, %f4))
+	EX_LD(LOAD(ldd, %g1 + 0x18, %f6))
+	EX_LD(LOAD(ldd, %g1 + 0x20, %f8))
+	EX_LD(LOAD(ldd, %g1 + 0x28, %f10))
+	EX_LD(LOAD(ldd, %g1 + 0x30, %f12))
+	EX_LD(LOAD(ldd, %g1 + 0x38, %f14))
+	faligndata	%f0, %f2, %f16
+	EX_LD(LOAD(ldd, %g1 + 0x40, %f0))
+	faligndata	%f2, %f4, %f18
+	add		%g1, 0x40, %g1
+	faligndata	%f4, %f6, %f20
+	faligndata	%f6, %f8, %f22
+	faligndata	%f8, %f10, %f24
+	faligndata	%f10, %f12, %f26
+	faligndata	%f12, %f14, %f28
+	faligndata	%f14, %f0, %f30
+	EX_ST(STORE(std, %f16, %o0 + 0x00))
+	EX_ST(STORE(std, %f18, %o0 + 0x08))
+	EX_ST(STORE(std, %f20, %o0 + 0x10))
+	EX_ST(STORE(std, %f22, %o0 + 0x18))
+	EX_ST(STORE(std, %f24, %o0 + 0x20))
+	EX_ST(STORE(std, %f26, %o0 + 0x28))
+	EX_ST(STORE(std, %f28, %o0 + 0x30))
+	EX_ST(STORE(std, %f30, %o0 + 0x38))
+	add		%o0, 0x40, %o0
+	bne,pt		%icc, 1b
+	 LOAD(prefetch, %g1 + 0x200, #n_reads_strong)
+	VISExitHalf
+
+	brz,pn		%o2, .Lexit
+	 cmp		%o2, 19
+	ble,pn		%icc, .Lsmall_unaligned
+	 nop
+	ba,a,pt		%icc, .Lmedium_unaligned
+
+.Lmedium:
+	LOAD(prefetch, %o1 + 0x40, #n_reads_strong)
+	andcc		%g2, 0x7, %g0
+	bne,pn		%icc, .Lmedium_unaligned
+	 nop
+.Lmedium_noprefetch:
+	andncc		%o2, 0x20 - 1, %o5
+	be,pn		%icc, 2f
+	 sub		%o2, %o5, %o2
+1:	EX_LD(LOAD(ldx, %o1 + 0x00, %g1))
+	EX_LD(LOAD(ldx, %o1 + 0x08, %g2))
+	EX_LD(LOAD(ldx, %o1 + 0x10, GLOBAL_SPARE))
+	EX_LD(LOAD(ldx, %o1 + 0x18, %o4))
+	add		%o1, 0x20, %o1
+	subcc		%o5, 0x20, %o5
+	EX_ST(STORE(stx, %g1, %o0 + 0x00))
+	EX_ST(STORE(stx, %g2, %o0 + 0x08))
+	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x10))
+	EX_ST(STORE(stx, %o4, %o0 + 0x18))
+	bne,pt		%icc, 1b
+	 add		%o0, 0x20, %o0
+2:	andcc		%o2, 0x18, %o5
+	be,pt		%icc, 3f
+	 sub		%o2, %o5, %o2
+1:	EX_LD(LOAD(ldx, %o1 + 0x00, %g1))
+	add		%o1, 0x08, %o1
+	add		%o0, 0x08, %o0
+	subcc		%o5, 0x08, %o5
+	bne,pt		%icc, 1b
+	 EX_ST(STORE(stx, %g1, %o0 - 0x08))
+3:	brz,pt		%o2, .Lexit
+	 cmp		%o2, 0x04
+	bl,pn		%icc, .Ltiny
+	 nop
+	EX_LD(LOAD(lduw, %o1 + 0x00, %g1))
+	add		%o1, 0x04, %o1
+	add		%o0, 0x04, %o0
+	subcc		%o2, 0x04, %o2
+	bne,pn		%icc, .Ltiny
+	 EX_ST(STORE(stw, %g1, %o0 - 0x04))
+	ba,a,pt		%icc, .Lexit
+.Lmedium_unaligned:
+	/* First get dest 8 byte aligned.  */
+	sub		%g0, %o0, %g1
+	and		%g1, 0x7, %g1
+	brz,pt		%g1, 2f
+	 sub		%o2, %g1, %o2
+=09
+1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2))
+	add		%o1, 1, %o1
+	subcc		%g1, 1, %g1
+	add		%o0, 1, %o0
+	bne,pt		%icc, 1b
+	 EX_ST(STORE(stb, %g2, %o0 - 0x01))
+2:
+	and		%o1, 0x7, %g1
+	brz,pn		%g1, .Lmedium_noprefetch
+	 sll		%g1, 3, %g1
+	mov		64, %g2
+	sub		%g2, %g1, %g2
+	andn		%o1, 0x7, %o1
+	EX_LD(LOAD(ldx, %o1 + 0x00, %o4))
+	sllx		%o4, %g1, %o4
+	andn		%o2, 0x08 - 1, %o5
+	sub		%o2, %o5, %o2
+1:	EX_LD(LOAD(ldx, %o1 + 0x08, %g3))
+	add		%o1, 0x08, %o1
+	subcc		%o5, 0x08, %o5
+	srlx		%g3, %g2, GLOBAL_SPARE
+	or		GLOBAL_SPARE, %o4, GLOBAL_SPARE
+	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x00))
+	add		%o0, 0x08, %o0
+	bne,pt		%icc, 1b
+	 sllx		%g3, %g1, %o4
+	srl		%g1, 3, %g1
+	add		%o1, %g1, %o1
+	brz,pn		%o2, .Lexit
+	 nop
+	ba,pt		%icc, .Lsmall_unaligned
+
+.Ltiny:
+	EX_LD(LOAD(ldub, %o1 + 0x00, %g1))
+	subcc		%o2, 1, %o2
+	be,pn		%icc, .Lexit
+	 EX_ST(STORE(stb, %g1, %o0 + 0x00))
+	EX_LD(LOAD(ldub, %o1 + 0x01, %g1))
+	subcc		%o2, 1, %o2
+	be,pn		%icc, .Lexit
+	 EX_ST(STORE(stb, %g1, %o0 + 0x01))
+	EX_LD(LOAD(ldub, %o1 + 0x02, %g1))
+	ba,pt		%icc, .Lexit
+	 EX_ST(STORE(stb, %g1, %o0 + 0x02))
+
+.Lsmall:
+	andcc		%g2, 0x3, %g0
+	bne,pn		%icc, .Lsmall_unaligned
+	 andn		%o2, 0x4 - 1, %o5
+	sub		%o2, %o5, %o2
+1:
+	EX_LD(LOAD(lduw, %o1 + 0x00, %g1))
+	add		%o1, 0x04, %o1
+	subcc		%o5, 0x04, %o5
+	add		%o0, 0x04, %o0
+	bne,pt		%icc, 1b
+	 EX_ST(STORE(stw, %g1, %o0 - 0x04))
+	brz,pt		%o2, .Lexit
+	 nop
+	ba,a,pt		%icc, .Ltiny
+
+.Lsmall_unaligned:
+1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g1))
+	add		%o1, 1, %o1
+	add		%o0, 1, %o0
+	subcc		%o2, 1, %o2
+	bne,pt		%icc, 1b
+	 EX_ST(STORE(stb, %g1, %o0 - 0x01))
+	ba,a,pt		%icc, .Lexit
+	.size		FUNC_NAME, .-FUNC_NAME
diff --git a/arch/sparc/lib/NG4patch.S b/arch/sparc/lib/NG4patch.S
new file mode 100644
index 0000000..c21c34c
--- /dev/null
+++ b/arch/sparc/lib/NG4patch.S
@@ -0,0 +1,43 @@
+/* NG4patch.S: Patch Ultra-I routines with Niagara-4 variant.
+ *
+ * Copyright (C) 2012 David S. Miller <davem@davemloft.net>
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
+	.globl	niagara4_patch_copyops
+	.type	niagara4_patch_copyops,#function
+niagara4_patch_copyops:
+	NG_DO_PATCH(memcpy, NG4memcpy)
+	NG_DO_PATCH(___copy_from_user, NG4copy_from_user)
+	NG_DO_PATCH(___copy_to_user, NG4copy_to_user)
+	retl
+	 nop
+	.size	niagara4_patch_copyops,.-niagara4_patch_copyops
+
+	.globl	niagara4_patch_pageops
+	.type	niagara4_patch_pageops,#function
+niagara4_patch_pageops:
+	NG_DO_PATCH(copy_user_page, NG4copy_user_page)
+	NG_DO_PATCH(_clear_page, NGclear_page)
+	NG_DO_PATCH(clear_user_page, NGclear_user_page)
+	retl
+	 nop
+	.size	niagara4_patch_pageops,.-niagara4_patch_pageops
diff --git a/arch/sparc/lib/NGpage.S b/arch/sparc/lib/NGpage.S
index b9e790b..423d46e 100644
--- a/arch/sparc/lib/NGpage.S
+++ b/arch/sparc/lib/NGpage.S
@@ -59,6 +59,8 @@ NGcopy_user_page:	/* %o0=DEst, %o1=3Dsrc, %o2=3Dvaddr */
 	 restore
=20
 	.align		32
+	.globl		NGclear_page
+	.globl		NGclear_user_page
 NGclear_page:		/* %o0=DEst */
 NGclear_user_page:	/* %o0=DEst, %o1=3Dvaddr */
 	rd		%asi, %g3
--=20
1.7.10.4

