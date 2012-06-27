From: David Miller <davem@davemloft.net>
Date: Wed, 27 Jun 2012 08:32:32 +0000
Subject: [PATCH] sparc64: Consistently use fsrc2 rather than fmovd in optimized asm.
Message-Id: <20120627.013232.1762150599521845137.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Because fsrc2, unlike fmovd, does not update the %fsr register.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

I noticed this offhand while reading several Niagara manuals,
and the documentation consistently states that fsrc2 is as
fast or faster to execute as well as having less side effects
than fmovd.

 arch/sparc/lib/NG2memcpy.S |   72 ++++++++++++++++++++++----------------------
 arch/sparc/lib/U1memcpy.S  |    4 +--
 arch/sparc/lib/copy_page.S |   56 +++++++++++++++++-----------------
 3 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/arch/sparc/lib/NG2memcpy.S b/arch/sparc/lib/NG2memcpy.S
index 0aed756..03eadf6 100644
--- a/arch/sparc/lib/NG2memcpy.S
+++ b/arch/sparc/lib/NG2memcpy.S
@@ -90,49 +90,49 @@
 	faligndata	%x7, %x8, %f14;
 
 #define FREG_MOVE_1(x0) \
-	fmovd		%x0, %f0;
+	fsrc2		%x0, %f0;
 #define FREG_MOVE_2(x0, x1) \
-	fmovd		%x0, %f0; \
-	fmovd		%x1, %f2;
+	fsrc2		%x0, %f0; \
+	fsrc2		%x1, %f2;
 #define FREG_MOVE_3(x0, x1, x2) \
-	fmovd		%x0, %f0; \
-	fmovd		%x1, %f2; \
-	fmovd		%x2, %f4;
+	fsrc2		%x0, %f0; \
+	fsrc2		%x1, %f2; \
+	fsrc2		%x2, %f4;
 #define FREG_MOVE_4(x0, x1, x2, x3) \
-	fmovd		%x0, %f0; \
-	fmovd		%x1, %f2; \
-	fmovd		%x2, %f4; \
-	fmovd		%x3, %f6;
+	fsrc2		%x0, %f0; \
+	fsrc2		%x1, %f2; \
+	fsrc2		%x2, %f4; \
+	fsrc2		%x3, %f6;
 #define FREG_MOVE_5(x0, x1, x2, x3, x4) \
-	fmovd		%x0, %f0; \
-	fmovd		%x1, %f2; \
-	fmovd		%x2, %f4; \
-	fmovd		%x3, %f6; \
-	fmovd		%x4, %f8;
+	fsrc2		%x0, %f0; \
+	fsrc2		%x1, %f2; \
+	fsrc2		%x2, %f4; \
+	fsrc2		%x3, %f6; \
+	fsrc2		%x4, %f8;
 #define FREG_MOVE_6(x0, x1, x2, x3, x4, x5) \
-	fmovd		%x0, %f0; \
-	fmovd		%x1, %f2; \
-	fmovd		%x2, %f4; \
-	fmovd		%x3, %f6; \
-	fmovd		%x4, %f8; \
-	fmovd		%x5, %f10;
+	fsrc2		%x0, %f0; \
+	fsrc2		%x1, %f2; \
+	fsrc2		%x2, %f4; \
+	fsrc2		%x3, %f6; \
+	fsrc2		%x4, %f8; \
+	fsrc2		%x5, %f10;
 #define FREG_MOVE_7(x0, x1, x2, x3, x4, x5, x6) \
-	fmovd		%x0, %f0; \
-	fmovd		%x1, %f2; \
-	fmovd		%x2, %f4; \
-	fmovd		%x3, %f6; \
-	fmovd		%x4, %f8; \
-	fmovd		%x5, %f10; \
-	fmovd		%x6, %f12;
+	fsrc2		%x0, %f0; \
+	fsrc2		%x1, %f2; \
+	fsrc2		%x2, %f4; \
+	fsrc2		%x3, %f6; \
+	fsrc2		%x4, %f8; \
+	fsrc2		%x5, %f10; \
+	fsrc2		%x6, %f12;
 #define FREG_MOVE_8(x0, x1, x2, x3, x4, x5, x6, x7) \
-	fmovd		%x0, %f0; \
-	fmovd		%x1, %f2; \
-	fmovd		%x2, %f4; \
-	fmovd		%x3, %f6; \
-	fmovd		%x4, %f8; \
-	fmovd		%x5, %f10; \
-	fmovd		%x6, %f12; \
-	fmovd		%x7, %f14;
+	fsrc2		%x0, %f0; \
+	fsrc2		%x1, %f2; \
+	fsrc2		%x2, %f4; \
+	fsrc2		%x3, %f6; \
+	fsrc2		%x4, %f8; \
+	fsrc2		%x5, %f10; \
+	fsrc2		%x6, %f12; \
+	fsrc2		%x7, %f14;
 #define FREG_LOAD_1(base, x0) \
 	EX_LD(LOAD(ldd, base + 0x00, %x0))
 #define FREG_LOAD_2(base, x0, x1) \
diff --git a/arch/sparc/lib/U1memcpy.S b/arch/sparc/lib/U1memcpy.S
index bafd2fc..b67142b 100644
--- a/arch/sparc/lib/U1memcpy.S
+++ b/arch/sparc/lib/U1memcpy.S
@@ -109,7 +109,7 @@
 #define UNEVEN_VISCHUNK_LAST(dest, f0, f1, left)	\
 	subcc			%left, 8, %left;	\
 	bl,pn			%xcc, 95f;		\
-	 fsrc1			%f0, %f1;
+	 fsrc2			%f0, %f1;
 
 #define UNEVEN_VISCHUNK(dest, f0, f1, left)		\
 	UNEVEN_VISCHUNK_LAST(dest, f0, f1, left)	\
@@ -201,7 +201,7 @@ FUNC_NAME:		/* %o0=dst, %o1=src, %o2=len */
 	andn		%o1, (0x40 - 1), %o1
 	and		%g2, 7, %g2
 	andncc		%g3, 0x7, %g3
-	fmovd		%f0, %f2
+	fsrc2		%f0, %f2
 	sub		%g3, 0x8, %g3
 	sub		%o2, %GLOBAL_SPARE, %o2
 
diff --git a/arch/sparc/lib/copy_page.S b/arch/sparc/lib/copy_page.S
index b243d3b..4d2df32 100644
--- a/arch/sparc/lib/copy_page.S
+++ b/arch/sparc/lib/copy_page.S
@@ -34,10 +34,10 @@
 #endif
 
 #define TOUCH(reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7)	\
-	fmovd	%reg0, %f48; 	fmovd	%reg1, %f50;		\
-	fmovd	%reg2, %f52; 	fmovd	%reg3, %f54;		\
-	fmovd	%reg4, %f56; 	fmovd	%reg5, %f58;		\
-	fmovd	%reg6, %f60; 	fmovd	%reg7, %f62;
+	fsrc2	%reg0, %f48; 	fsrc2	%reg1, %f50;		\
+	fsrc2	%reg2, %f52; 	fsrc2	%reg3, %f54;		\
+	fsrc2	%reg4, %f56; 	fsrc2	%reg5, %f58;		\
+	fsrc2	%reg6, %f60; 	fsrc2	%reg7, %f62;
 
 	.text
 
@@ -104,60 +104,60 @@ cheetah_copy_page_insn:
 	prefetch	[%o1 + 0x140], #one_read
 	ldd		[%o1 + 0x010], %f4
 	prefetch	[%o1 + 0x180], #one_read
-	fmovd		%f0, %f16
+	fsrc2		%f0, %f16
 	ldd		[%o1 + 0x018], %f6
-	fmovd		%f2, %f18
+	fsrc2		%f2, %f18
 	ldd		[%o1 + 0x020], %f8
-	fmovd		%f4, %f20
+	fsrc2		%f4, %f20
 	ldd		[%o1 + 0x028], %f10
-	fmovd		%f6, %f22
+	fsrc2		%f6, %f22
 	ldd		[%o1 + 0x030], %f12
-	fmovd		%f8, %f24
+	fsrc2		%f8, %f24
 	ldd		[%o1 + 0x038], %f14
-	fmovd		%f10, %f26
+	fsrc2		%f10, %f26
 	ldd		[%o1 + 0x040], %f0
 1:	ldd		[%o1 + 0x048], %f2
-	fmovd		%f12, %f28
+	fsrc2		%f12, %f28
 	ldd		[%o1 + 0x050], %f4
-	fmovd		%f14, %f30
+	fsrc2		%f14, %f30
 	stda		%f16, [%o0] ASI_BLK_P
 	ldd		[%o1 + 0x058], %f6
-	fmovd		%f0, %f16
+	fsrc2		%f0, %f16
 	ldd		[%o1 + 0x060], %f8
-	fmovd		%f2, %f18
+	fsrc2		%f2, %f18
 	ldd		[%o1 + 0x068], %f10
-	fmovd		%f4, %f20
+	fsrc2		%f4, %f20
 	ldd		[%o1 + 0x070], %f12
-	fmovd		%f6, %f22
+	fsrc2		%f6, %f22
 	ldd		[%o1 + 0x078], %f14
-	fmovd		%f8, %f24
+	fsrc2		%f8, %f24
 	ldd		[%o1 + 0x080], %f0
 	prefetch	[%o1 + 0x180], #one_read
-	fmovd		%f10, %f26
+	fsrc2		%f10, %f26
 	subcc		%o2, 1, %o2
 	add		%o0, 0x40, %o0
 	bne,pt		%xcc, 1b
 	 add		%o1, 0x40, %o1
 
 	ldd		[%o1 + 0x048], %f2
-	fmovd		%f12, %f28
+	fsrc2		%f12, %f28
 	ldd		[%o1 + 0x050], %f4
-	fmovd		%f14, %f30
+	fsrc2		%f14, %f30
 	stda		%f16, [%o0] ASI_BLK_P
 	ldd		[%o1 + 0x058], %f6
-	fmovd		%f0, %f16
+	fsrc2		%f0, %f16
 	ldd		[%o1 + 0x060], %f8
-	fmovd		%f2, %f18
+	fsrc2		%f2, %f18
 	ldd		[%o1 + 0x068], %f10
-	fmovd		%f4, %f20
+	fsrc2		%f4, %f20
 	ldd		[%o1 + 0x070], %f12
-	fmovd		%f6, %f22
+	fsrc2		%f6, %f22
 	add		%o0, 0x40, %o0
 	ldd		[%o1 + 0x078], %f14
-	fmovd		%f8, %f24
-	fmovd		%f10, %f26
-	fmovd		%f12, %f28
-	fmovd		%f14, %f30
+	fsrc2		%f8, %f24
+	fsrc2		%f10, %f26
+	fsrc2		%f12, %f28
+	fsrc2		%f14, %f30
 	stda		%f16, [%o0] ASI_BLK_P
 	membar		#Sync
 	VISExitHalf
-- 
1.7.10

