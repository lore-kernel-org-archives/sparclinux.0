From: David Miller <davem@davemloft.net>
Date: Sat, 06 Oct 2012 04:23:01 +0000
Subject: [PATCH 1/2] sparc64: Niagara-4 bzero/memset, plus use MRU stores in page copy.
Message-Id: <20121006.002301.1232666623245788670.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


This adds optimized memset/bzero/page-clear routines for Niagara-4.

We basically can do what powerpc has been able to do for a decade (via
the "dcbz" instruction), which is use cache line clearing stores for
bzero and memsets with a 'c' argument of zero.

As long as we make the cache initializing store to each 32-byte
subblock of the L2 cache line, it works.

As with other Niagara-4 optimized routines, the key is to make sure to
avoid any usage of the %asi register, as reads and writes to it cost
at least 50 cycles.

For the user clear cases, we don't use these new routines, we use the
Niagara-1 variants instead.  Those have to use %asi in an unavoidable
way.

A Niagara-4 8K page clear costs just under 600 cycles.

Add definitions of the MRU variants of the cache initializing store
ASIs.  By default, cache initializing stores install the line as Least
Recently Used.  If we know we're going to use the data immediately
(which is true for page copies and clears) we can use the Most
Recently Used variant, to decrease the likelyhood of the lines being
evicted before they get used.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/asi.h   |   19 ++++++++
 arch/sparc/kernel/head_64.S    |    2 +-
 arch/sparc/lib/Makefile        |    2 +-
 arch/sparc/lib/NG4clear_page.S |   29 +++++++++++
 arch/sparc/lib/NG4copy_page.S  |   16 +++---
 arch/sparc/lib/NG4memset.S     |  105 ++++++++++++++++++++++++++++++++++++=
++++
 arch/sparc/lib/NG4patch.S      |   15 +++++-
 7 files changed, 176 insertions(+), 12 deletions(-)
 create mode 100644 arch/sparc/lib/NG4clear_page.S
 create mode 100644 arch/sparc/lib/NG4memset.S

diff --git a/arch/sparc/include/asm/asi.h b/arch/sparc/include/asm/asi.h
index cc0006d..aace6f3 100644
--- a/arch/sparc/include/asm/asi.h
+++ b/arch/sparc/include/asm/asi.h
@@ -270,9 +270,28 @@
 #define ASI_BLK_INIT_QUAD_LDD_P	0xe2 /* (NG) init-store, twin load,
 				      * primary, implicit
 				      */
+#define ASI_BLK_INIT_QUAD_LDD_S	0xe3 /* (NG) init-store, twin load,
+				      * secondary, implicit
+				      */
 #define ASI_BLK_P		0xf0 /* Primary, blk ld/st		*/
 #define ASI_BLK_S		0xf1 /* Secondary, blk ld/st		*/
+#define ASI_ST_BLKINIT_MRU_P	0xf2 /* (NG4) init-store, twin load,
+				      * Most-Recently-Used, primary,
+				      * implicit
+				      */
+#define ASI_ST_BLKINIT_MRU_S	0xf2 /* (NG4) init-store, twin load,
+				      * Most-Recently-Used, secondary,
+				      * implicit
+				      */
 #define ASI_BLK_PL		0xf8 /* Primary, blk ld/st, little	*/
 #define ASI_BLK_SL		0xf9 /* Secondary, blk ld/st, little	*/
+#define ASI_ST_BLKINIT_MRU_PL	0xfa /* (NG4) init-store, twin load,
+				      * Most-Recently-Used, primary,
+				      * implicit, little-endian
+				      */
+#define ASI_ST_BLKINIT_MRU_SL	0xfb /* (NG4) init-store, twin load,
+				      * Most-Recently-Used, secondary,
+				      * implicit, little-endian
+				      */
=20
 #endif /* _SPARC_ASI_H */
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index ee5dcce..2feb15c 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -576,7 +576,7 @@ niagara_tlb_fixup:
 niagara4_patch:
 	call	niagara4_patch_copyops
 	 nop
-	call	niagara_patch_bzero
+	call	niagara4_patch_bzero
 	 nop
 	call	niagara4_patch_pageops
 	 nop
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 30f6ab5..8410065f2 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -33,7 +33,7 @@ lib-$(CONFIG_SPARC64) +=3D NG2memcpy.o NG2copy_from_user.=
o NG2copy_to_user.o
 lib-$(CONFIG_SPARC64) +=3D  NG2patch.o
=20
 lib-$(CONFIG_SPARC64) +=3D NG4memcpy.o NG4copy_from_user.o NG4copy_to_user=
.o
-lib-$(CONFIG_SPARC64) +=3D  NG4patch.o NG4copy_page.o
+lib-$(CONFIG_SPARC64) +=3D  NG4patch.o NG4copy_page.o NG4clear_page.o NG4m=
emset.o
=20
 lib-$(CONFIG_SPARC64) +=3D GENmemcpy.o GENcopy_from_user.o GENcopy_to_user=
.o
 lib-$(CONFIG_SPARC64) +=3D GENpatch.o GENpage.o GENbzero.o
diff --git a/arch/sparc/lib/NG4clear_page.S b/arch/sparc/lib/NG4clear_page.S
new file mode 100644
index 0000000..e16c882
--- /dev/null
+++ b/arch/sparc/lib/NG4clear_page.S
@@ -0,0 +1,29 @@
+/* NG4copy_page.S: Niagara-4 optimized clear page.
+ *
+ * Copyright (C) 2012 (davem@davemloft.net)
+ */
+
+#include <asm/asi.h>
+#include <asm/page.h>
+
+	.text
+
+	.register	%g3, #scratch
+
+	.align		32
+	.globl		NG4clear_page
+	.globl		NG4clear_user_page
+NG4clear_page:		/* %o0=DEst */
+NG4clear_user_page:	/* %o0=DEst, %o1=3Dvaddr */
+	set		PAGE_SIZE, %g7
+	mov		0x20, %g3
+1:	stxa		%g0, [%o0 + %g0] ASI_ST_BLKINIT_MRU_P
+	subcc		%g7, 0x40, %g7
+	stxa		%g0, [%o0 + %g3] ASI_ST_BLKINIT_MRU_P
+	bne,pt		%xcc, 1b
+	 add		%o0, 0x40, %o0
+	membar		#StoreLoad|#StoreStore
+	retl
+	 nop
+	.size		NG4clear_page,.-NG4clear_page
+	.size		NG4clear_user_page,.-NG4clear_user_page
\ No newline at end of file
diff --git a/arch/sparc/lib/NG4copy_page.S b/arch/sparc/lib/NG4copy_page.S
index f30ec10..28504e8 100644
--- a/arch/sparc/lib/NG4copy_page.S
+++ b/arch/sparc/lib/NG4copy_page.S
@@ -30,25 +30,25 @@ NG4copy_user_page:	/* %o0=DEst, %o1=3Dsrc, %o2=3Dvaddr =
*/
 	ldx		[%o1 + 0x10], %o4
 	ldx		[%o1 + 0x18], %o5
 	ldx		[%o1 + 0x20], %g1
-	stxa		%o2, [%o0] ASI_BLK_INIT_QUAD_LDD_P
+	stxa		%o2, [%o0] ASI_ST_BLKINIT_MRU_P
 	add		%o0, 0x08, %o0
 	ldx		[%o1 + 0x28], %g2
-	stxa		%o3, [%o0] ASI_BLK_INIT_QUAD_LDD_P
+	stxa		%o3, [%o0] ASI_ST_BLKINIT_MRU_P
 	add		%o0, 0x08, %o0
 	ldx		[%o1 + 0x30], %g3
-	stxa		%o4, [%o0] ASI_BLK_INIT_QUAD_LDD_P
+	stxa		%o4, [%o0] ASI_ST_BLKINIT_MRU_P
 	add		%o0, 0x08, %o0
 	ldx		[%o1 + 0x38], %o2
 	add		%o1, 0x40, %o1
-	stxa		%o5, [%o0] ASI_BLK_INIT_QUAD_LDD_P
+	stxa		%o5, [%o0] ASI_ST_BLKINIT_MRU_P
 	add		%o0, 0x08, %o0
-	stxa		%g1, [%o0] ASI_BLK_INIT_QUAD_LDD_P
+	stxa		%g1, [%o0] ASI_ST_BLKINIT_MRU_P
 	add		%o0, 0x08, %o0
-	stxa		%g2, [%o0] ASI_BLK_INIT_QUAD_LDD_P
+	stxa		%g2, [%o0] ASI_ST_BLKINIT_MRU_P
 	add		%o0, 0x08, %o0
-	stxa		%g3, [%o0] ASI_BLK_INIT_QUAD_LDD_P
+	stxa		%g3, [%o0] ASI_ST_BLKINIT_MRU_P
 	add		%o0, 0x08, %o0
-	stxa		%o2, [%o0] ASI_BLK_INIT_QUAD_LDD_P
+	stxa		%o2, [%o0] ASI_ST_BLKINIT_MRU_P
 	add		%o0, 0x08, %o0
 	bne,pt		%icc, 1b
 	 prefetch	[%o1 + 0x200], #n_reads_strong
diff --git a/arch/sparc/lib/NG4memset.S b/arch/sparc/lib/NG4memset.S
new file mode 100644
index 0000000..41da4bd
--- /dev/null
+++ b/arch/sparc/lib/NG4memset.S
@@ -0,0 +1,105 @@
+/* NG4memset.S: Niagara-4 optimized memset/bzero.
+ *
+ * Copyright (C) 2012 David S. Miller (davem@davemloft.net)
+ */
+
+#include <asm/asi.h>
+
+	.register	%g2, #scratch
+	.register	%g3, #scratch
+
+	.text
+	.align		32
+	.globl		NG4memset
+NG4memset:
+	andcc		%o1, 0xff, %o4
+	be,pt		%icc, 1f
+	 mov		%o2, %o1
+	sllx		%o4, 8, %g1
+	or		%g1, %o4, %o2
+	sllx		%o2, 16, %g1
+	or		%g1, %o2, %o2
+	sllx		%o2, 32, %g1
+	ba,pt		%icc, 1f
+	 or		%g1, %o2, %o4
+	.size		NG4memset,.-NG4memset
+
+	.align		32
+	.globl		NG4bzero
+NG4bzero:
+	clr		%o4
+1:	cmp		%o1, 16
+	ble		%icc, .Ltiny
+	 mov		%o0, %o3
+	sub		%g0, %o0, %g1
+	and		%g1, 0x7, %g1
+	brz,pt		%g1, .Laligned8
+	 sub		%o1, %g1, %o1
+1:	stb		%o4, [%o0 + 0x00]
+	subcc		%g1, 1, %g1
+	bne,pt		%icc, 1b
+	 add		%o0, 1, %o0
+.Laligned8:
+	cmp		%o1, 64 + (64 - 8)
+	ble		.Lmedium
+	 sub		%g0, %o0, %g1
+	andcc		%g1, (64 - 1), %g1
+	brz,pn		%g1, .Laligned64
+	 sub		%o1, %g1, %o1
+1:	stx		%o4, [%o0 + 0x00]
+	subcc		%g1, 8, %g1
+	bne,pt		%icc, 1b
+	 add		%o0, 0x8, %o0
+.Laligned64:
+	andn		%o1, 64 - 1, %g1
+	sub		%o1, %g1, %o1
+	brnz,pn		%o4, .Lnon_bzero_loop
+	 mov		0x20, %g2
+1:	stxa		%o4, [%o0 + %g0] ASI_BLK_INIT_QUAD_LDD_P
+	subcc		%g1, 0x40, %g1
+	stxa		%o4, [%o0 + %g2] ASI_BLK_INIT_QUAD_LDD_P
+	bne,pt		%icc, 1b
+	 add		%o0, 0x40, %o0
+.Lpostloop:
+	cmp		%o1, 8
+	bl,pn		%icc, .Ltiny
+	 membar		#StoreStore|#StoreLoad
+.Lmedium:
+	andn		%o1, 0x7, %g1
+	sub		%o1, %g1, %o1
+1:	stx		%o4, [%o0 + 0x00]
+	subcc		%g1, 0x8, %g1
+	bne,pt		%icc, 1b
+	 add		%o0, 0x08, %o0
+	andcc		%o1, 0x4, %g1
+	be,pt		%icc, .Ltiny
+	 sub		%o1, %g1, %o1
+	stw		%o4, [%o0 + 0x00]
+	add		%o0, 0x4, %o0
+.Ltiny:
+	cmp		%o1, 0
+	be,pn		%icc, .Lexit
+1:	 subcc		%o1, 1, %o1
+	stb		%o4, [%o0 + 0x00]
+	bne,pt		%icc, 1b
+	 add		%o0, 1, %o0
+.Lexit:
+	retl
+	 mov		%o3, %o0
+.Lnon_bzero_loop:
+	mov		0x08, %g3
+	mov		0x28, %o5
+1:	stxa		%o4, [%o0 + %g0] ASI_BLK_INIT_QUAD_LDD_P
+	subcc		%g1, 0x40, %g1
+	stxa		%o4, [%o0 + %g2] ASI_BLK_INIT_QUAD_LDD_P
+	stxa		%o4, [%o0 + %g3] ASI_BLK_INIT_QUAD_LDD_P
+	stxa		%o4, [%o0 + %o5] ASI_BLK_INIT_QUAD_LDD_P
+	add		%o0, 0x10, %o0
+	stxa		%o4, [%o0 + %g0] ASI_BLK_INIT_QUAD_LDD_P
+	stxa		%o4, [%o0 + %g2] ASI_BLK_INIT_QUAD_LDD_P
+	stxa		%o4, [%o0 + %g3] ASI_BLK_INIT_QUAD_LDD_P
+	stxa		%o4, [%o0 + %o5] ASI_BLK_INIT_QUAD_LDD_P
+	bne,pt		%icc, 1b
+	 add		%o0, 0x30, %o0
+	ba,a,pt		%icc, .Lpostloop
+	.size		NG4bzero,.-NG4bzero
diff --git a/arch/sparc/lib/NG4patch.S b/arch/sparc/lib/NG4patch.S
index c21c34c..a114cbc 100644
--- a/arch/sparc/lib/NG4patch.S
+++ b/arch/sparc/lib/NG4patch.S
@@ -32,12 +32,23 @@ niagara4_patch_copyops:
 	 nop
 	.size	niagara4_patch_copyops,.-niagara4_patch_copyops
=20
+	.globl	niagara4_patch_bzero
+	.type	niagara4_patch_bzero,#function
+niagara4_patch_bzero:
+	NG_DO_PATCH(memset, NG4memset)
+	NG_DO_PATCH(__bzero, NG4bzero)
+	NG_DO_PATCH(__clear_user, NGclear_user)
+	NG_DO_PATCH(tsb_init, NGtsb_init)
+	retl
+	 nop
+	.size	niagara4_patch_bzero,.-niagara4_patch_bzero
+
 	.globl	niagara4_patch_pageops
 	.type	niagara4_patch_pageops,#function
 niagara4_patch_pageops:
 	NG_DO_PATCH(copy_user_page, NG4copy_user_page)
-	NG_DO_PATCH(_clear_page, NGclear_page)
-	NG_DO_PATCH(clear_user_page, NGclear_user_page)
+	NG_DO_PATCH(_clear_page, NG4clear_page)
+	NG_DO_PATCH(clear_user_page, NG4clear_user_page)
 	retl
 	 nop
 	.size	niagara4_patch_pageops,.-niagara4_patch_pageops
--=20
1.7.10.4

