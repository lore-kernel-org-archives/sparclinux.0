From: Rob Gardner <rob.gardner@oracle.com>
Date: Wed, 23 Dec 2015 06:24:49 +0000
Subject: [PATCH] sparc64: fix FP corruption in user copy functions
Message-Id: <1450851889-8950-1-git-send-email-rob.gardner@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Short story: Exception handlers used by some copy_to_user() and
copy_from_user() functions do not diligently clean up floating point
register usage, and this can result in a user process seeing invalid
values in floating point registers. This sometimes makes the process
fail.

Long story: Several cpu-specific (NG4, NG2, U1, U3) memcpy functions
use floating point registers and VIS alignaddr/faligndata to
accelerate data copying when source and dest addresses don't align
well. Linux uses a lazy scheme for saving floating point registers; It
is not done upon entering the kernel since it's a very expensive
operation. Rather, it is done only when needed. If the kernel ends up
not using FP regs during the course of some trap or system call, then
it can return to user space without saving or restoring them.

The various memcpy functions begin their FP code with VISEntry (or a
variation thereof), which saves the FP regs. They conclude their FP
code with VISExit (or a variation) which essentially marks the FP regs
"clean", ie, they contain no unsaved values. fprs.FPRS_FEF is turned
off so that a lazy restore will be triggered when/if the user process
accesses floating point regs again.

The bug is that the user copy variants of memcpy, copy_from_user() and
copy_to_user(), employ an exception handling mechanism to detect faults
when accessing user space addresses, and when this handler is invoked,
an immediate return from the function is forced, and VISExit is not
executed, thus leaving the fprs register in an indeterminate state,
but often with fprs.FPRS_FEF set and one or more dirty bits. This
results in a return to user space with invalid values in the FP regs,
and since fprs.FPRS_FEF is on, no lazy restore occurs.

This bug affects copy_to_user() and copy_from_user() for NG4, NG2,
U3, and U1. All are fixed by using a new exception handler for those
loads and stores that are done during the time between VISEnter and
VISExit.

n.b. In NG4memcpy, the problematic code can be triggered by a copy
size greater than 128 bytes and an unaligned source address.  This bug
is known to be the cause of random user process memory corruptions
while perf is running with the callgraph option (ie, perf record -g).
This occurs because perf uses copy_from_user() to read user stacks,
and may fault when it follows a stack frame pointer off to an
invalid page. Validation checks on the stack address just obscure
the underlying problem.

Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
Signed-off-by: Dave Aldridge <david.j.aldridge@oracle.com>
---
 arch/sparc/kernel/head_64.S        |   13 ++++
 arch/sparc/lib/NG2copy_from_user.S |    8 +++
 arch/sparc/lib/NG2copy_to_user.S   |    8 +++
 arch/sparc/lib/NG2memcpy.S         |  118 +++++++++++++++++++-----------------
 arch/sparc/lib/NG4copy_from_user.S |    8 +++
 arch/sparc/lib/NG4copy_to_user.S   |    8 +++
 arch/sparc/lib/NG4memcpy.S         |   40 ++++++------
 arch/sparc/lib/U1copy_from_user.S  |    8 +++
 arch/sparc/lib/U1copy_to_user.S    |    8 +++
 arch/sparc/lib/U1memcpy.S          |   48 ++++++++-------
 arch/sparc/lib/U3copy_from_user.S  |    8 +++
 arch/sparc/lib/U3copy_to_user.S    |    8 +++
 arch/sparc/lib/U3memcpy.S          |   86 ++++++++++++++------------
 13 files changed, 235 insertions(+), 134 deletions(-)

diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 3d61fca..f2d30ca 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -946,6 +946,12 @@ ENTRY(__retl_one)
 	 mov	1, %o0
 ENDPROC(__retl_one)
 
+ENTRY(__retl_one_fp)
+	VISExitHalf
+	retl
+	 mov	1, %o0
+ENDPROC(__retl_one_fp)
+
 ENTRY(__ret_one_asi)
 	wr	%g0, ASI_AIUS, %asi
 	ret
@@ -958,6 +964,13 @@ ENTRY(__retl_one_asi)
 	 mov	1, %o0
 ENDPROC(__retl_one_asi)
 
+ENTRY(__retl_one_asi_fp)
+	wr	%g0, ASI_AIUS, %asi
+	VISExitHalf
+	retl
+	 mov	1, %o0
+ENDPROC(__retl_one_asi_fp)
+
 ENTRY(__retl_o1)
 	retl
 	 mov	%o1, %o0
diff --git a/arch/sparc/lib/NG2copy_from_user.S b/arch/sparc/lib/NG2copy_from_user.S
index 119ccb9..d5242b8 100644
--- a/arch/sparc/lib/NG2copy_from_user.S
+++ b/arch/sparc/lib/NG2copy_from_user.S
@@ -11,6 +11,14 @@
 	.text;			\
 	.align 4;
 
+#define EX_LD_FP(x)		\
+98:	x;			\
+	.section __ex_table,"a";\
+	.align 4;		\
+	.word 98b, __retl_one_asi_fp;\
+	.text;			\
+	.align 4;
+
 #ifndef ASI_AIUS
 #define ASI_AIUS	0x11
 #endif
diff --git a/arch/sparc/lib/NG2copy_to_user.S b/arch/sparc/lib/NG2copy_to_user.S
index 7fe1cce..4e962d9 100644
--- a/arch/sparc/lib/NG2copy_to_user.S
+++ b/arch/sparc/lib/NG2copy_to_user.S
@@ -11,6 +11,14 @@
 	.text;			\
 	.align 4;
 
+#define EX_ST_FP(x)		\
+98:	x;			\
+	.section __ex_table,"a";\
+	.align 4;		\
+	.word 98b, __retl_one_asi_fp;\
+	.text;			\
+	.align 4;
+
 #ifndef ASI_AIUS
 #define ASI_AIUS	0x11
 #endif
diff --git a/arch/sparc/lib/NG2memcpy.S b/arch/sparc/lib/NG2memcpy.S
index 30eee6e..d5f585d 100644
--- a/arch/sparc/lib/NG2memcpy.S
+++ b/arch/sparc/lib/NG2memcpy.S
@@ -34,10 +34,16 @@
 #ifndef EX_LD
 #define EX_LD(x)	x
 #endif
+#ifndef EX_LD_FP
+#define EX_LD_FP(x)	x
+#endif
 
 #ifndef EX_ST
 #define EX_ST(x)	x
 #endif
+#ifndef EX_ST_FP
+#define EX_ST_FP(x)	x
+#endif
 
 #ifndef EX_RETVAL
 #define EX_RETVAL(x)	x
@@ -134,40 +140,40 @@
 	fsrc2		%x6, %f12; \
 	fsrc2		%x7, %f14;
 #define FREG_LOAD_1(base, x0) \
-	EX_LD(LOAD(ldd, base + 0x00, %x0))
+	EX_LD_FP(LOAD(ldd, base + 0x00, %x0))
 #define FREG_LOAD_2(base, x0, x1) \
-	EX_LD(LOAD(ldd, base + 0x00, %x0)); \
-	EX_LD(LOAD(ldd, base + 0x08, %x1));
+	EX_LD_FP(LOAD(ldd, base + 0x00, %x0)); \
+	EX_LD_FP(LOAD(ldd, base + 0x08, %x1));
 #define FREG_LOAD_3(base, x0, x1, x2) \
-	EX_LD(LOAD(ldd, base + 0x00, %x0)); \
-	EX_LD(LOAD(ldd, base + 0x08, %x1)); \
-	EX_LD(LOAD(ldd, base + 0x10, %x2));
+	EX_LD_FP(LOAD(ldd, base + 0x00, %x0)); \
+	EX_LD_FP(LOAD(ldd, base + 0x08, %x1)); \
+	EX_LD_FP(LOAD(ldd, base + 0x10, %x2));
 #define FREG_LOAD_4(base, x0, x1, x2, x3) \
-	EX_LD(LOAD(ldd, base + 0x00, %x0)); \
-	EX_LD(LOAD(ldd, base + 0x08, %x1)); \
-	EX_LD(LOAD(ldd, base + 0x10, %x2)); \
-	EX_LD(LOAD(ldd, base + 0x18, %x3));
+	EX_LD_FP(LOAD(ldd, base + 0x00, %x0)); \
+	EX_LD_FP(LOAD(ldd, base + 0x08, %x1)); \
+	EX_LD_FP(LOAD(ldd, base + 0x10, %x2)); \
+	EX_LD_FP(LOAD(ldd, base + 0x18, %x3));
 #define FREG_LOAD_5(base, x0, x1, x2, x3, x4) \
-	EX_LD(LOAD(ldd, base + 0x00, %x0)); \
-	EX_LD(LOAD(ldd, base + 0x08, %x1)); \
-	EX_LD(LOAD(ldd, base + 0x10, %x2)); \
-	EX_LD(LOAD(ldd, base + 0x18, %x3)); \
-	EX_LD(LOAD(ldd, base + 0x20, %x4));
+	EX_LD_FP(LOAD(ldd, base + 0x00, %x0)); \
+	EX_LD_FP(LOAD(ldd, base + 0x08, %x1)); \
+	EX_LD_FP(LOAD(ldd, base + 0x10, %x2)); \
+	EX_LD_FP(LOAD(ldd, base + 0x18, %x3)); \
+	EX_LD_FP(LOAD(ldd, base + 0x20, %x4));
 #define FREG_LOAD_6(base, x0, x1, x2, x3, x4, x5) \
-	EX_LD(LOAD(ldd, base + 0x00, %x0)); \
-	EX_LD(LOAD(ldd, base + 0x08, %x1)); \
-	EX_LD(LOAD(ldd, base + 0x10, %x2)); \
-	EX_LD(LOAD(ldd, base + 0x18, %x3)); \
-	EX_LD(LOAD(ldd, base + 0x20, %x4)); \
-	EX_LD(LOAD(ldd, base + 0x28, %x5));
+	EX_LD_FP(LOAD(ldd, base + 0x00, %x0)); \
+	EX_LD_FP(LOAD(ldd, base + 0x08, %x1)); \
+	EX_LD_FP(LOAD(ldd, base + 0x10, %x2)); \
+	EX_LD_FP(LOAD(ldd, base + 0x18, %x3)); \
+	EX_LD_FP(LOAD(ldd, base + 0x20, %x4)); \
+	EX_LD_FP(LOAD(ldd, base + 0x28, %x5));
 #define FREG_LOAD_7(base, x0, x1, x2, x3, x4, x5, x6) \
-	EX_LD(LOAD(ldd, base + 0x00, %x0)); \
-	EX_LD(LOAD(ldd, base + 0x08, %x1)); \
-	EX_LD(LOAD(ldd, base + 0x10, %x2)); \
-	EX_LD(LOAD(ldd, base + 0x18, %x3)); \
-	EX_LD(LOAD(ldd, base + 0x20, %x4)); \
-	EX_LD(LOAD(ldd, base + 0x28, %x5)); \
-	EX_LD(LOAD(ldd, base + 0x30, %x6));
+	EX_LD_FP(LOAD(ldd, base + 0x00, %x0)); \
+	EX_LD_FP(LOAD(ldd, base + 0x08, %x1)); \
+	EX_LD_FP(LOAD(ldd, base + 0x10, %x2)); \
+	EX_LD_FP(LOAD(ldd, base + 0x18, %x3)); \
+	EX_LD_FP(LOAD(ldd, base + 0x20, %x4)); \
+	EX_LD_FP(LOAD(ldd, base + 0x28, %x5)); \
+	EX_LD_FP(LOAD(ldd, base + 0x30, %x6));
 
 	.register	%g2,#scratch
 	.register	%g3,#scratch
@@ -275,11 +281,11 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	 nop
 	/* fall through for 0 < low bits < 8 */
 110:	sub		%o4, 64, %g2
-	EX_LD(LOAD_BLK(%g2, %f0))
-1:	EX_ST(STORE_INIT(%g0, %o4 + %g3))
-	EX_LD(LOAD_BLK(%o4, %f16))
+	EX_LD_FP(LOAD_BLK(%g2, %f0))
+1:	EX_ST_FP(STORE_INIT(%g0, %o4 + %g3))
+	EX_LD_FP(LOAD_BLK(%o4, %f16))
 	FREG_FROB(f0, f2, f4, f6, f8, f10, f12, f14, f16)
-	EX_ST(STORE_BLK(%f0, %o4 + %g3))
+	EX_ST_FP(STORE_BLK(%f0, %o4 + %g3))
 	FREG_MOVE_8(f16, f18, f20, f22, f24, f26, f28, f30)
 	subcc		%g1, 64, %g1
 	add		%o4, 64, %o4
@@ -290,10 +296,10 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 
 120:	sub		%o4, 56, %g2
 	FREG_LOAD_7(%g2, f0, f2, f4, f6, f8, f10, f12)
-1:	EX_ST(STORE_INIT(%g0, %o4 + %g3))
-	EX_LD(LOAD_BLK(%o4, %f16))
+1:	EX_ST_FP(STORE_INIT(%g0, %o4 + %g3))
+	EX_LD_FP(LOAD_BLK(%o4, %f16))
 	FREG_FROB(f0, f2, f4, f6, f8, f10, f12, f16, f18)
-	EX_ST(STORE_BLK(%f0, %o4 + %g3))
+	EX_ST_FP(STORE_BLK(%f0, %o4 + %g3))
 	FREG_MOVE_7(f18, f20, f22, f24, f26, f28, f30)
 	subcc		%g1, 64, %g1
 	add		%o4, 64, %o4
@@ -304,10 +310,10 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 
 130:	sub		%o4, 48, %g2
 	FREG_LOAD_6(%g2, f0, f2, f4, f6, f8, f10)
-1:	EX_ST(STORE_INIT(%g0, %o4 + %g3))
-	EX_LD(LOAD_BLK(%o4, %f16))
+1:	EX_ST_FP(STORE_INIT(%g0, %o4 + %g3))
+	EX_LD_FP(LOAD_BLK(%o4, %f16))
 	FREG_FROB(f0, f2, f4, f6, f8, f10, f16, f18, f20)
-	EX_ST(STORE_BLK(%f0, %o4 + %g3))
+	EX_ST_FP(STORE_BLK(%f0, %o4 + %g3))
 	FREG_MOVE_6(f20, f22, f24, f26, f28, f30)
 	subcc		%g1, 64, %g1
 	add		%o4, 64, %o4
@@ -318,10 +324,10 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 
 140:	sub		%o4, 40, %g2
 	FREG_LOAD_5(%g2, f0, f2, f4, f6, f8)
-1:	EX_ST(STORE_INIT(%g0, %o4 + %g3))
-	EX_LD(LOAD_BLK(%o4, %f16))
+1:	EX_ST_FP(STORE_INIT(%g0, %o4 + %g3))
+	EX_LD_FP(LOAD_BLK(%o4, %f16))
 	FREG_FROB(f0, f2, f4, f6, f8, f16, f18, f20, f22)
-	EX_ST(STORE_BLK(%f0, %o4 + %g3))
+	EX_ST_FP(STORE_BLK(%f0, %o4 + %g3))
 	FREG_MOVE_5(f22, f24, f26, f28, f30)
 	subcc		%g1, 64, %g1
 	add		%o4, 64, %o4
@@ -332,10 +338,10 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 
 150:	sub		%o4, 32, %g2
 	FREG_LOAD_4(%g2, f0, f2, f4, f6)
-1:	EX_ST(STORE_INIT(%g0, %o4 + %g3))
-	EX_LD(LOAD_BLK(%o4, %f16))
+1:	EX_ST_FP(STORE_INIT(%g0, %o4 + %g3))
+	EX_LD_FP(LOAD_BLK(%o4, %f16))
 	FREG_FROB(f0, f2, f4, f6, f16, f18, f20, f22, f24)
-	EX_ST(STORE_BLK(%f0, %o4 + %g3))
+	EX_ST_FP(STORE_BLK(%f0, %o4 + %g3))
 	FREG_MOVE_4(f24, f26, f28, f30)
 	subcc		%g1, 64, %g1
 	add		%o4, 64, %o4
@@ -346,10 +352,10 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 
 160:	sub		%o4, 24, %g2
 	FREG_LOAD_3(%g2, f0, f2, f4)
-1:	EX_ST(STORE_INIT(%g0, %o4 + %g3))
-	EX_LD(LOAD_BLK(%o4, %f16))
+1:	EX_ST_FP(STORE_INIT(%g0, %o4 + %g3))
+	EX_LD_FP(LOAD_BLK(%o4, %f16))
 	FREG_FROB(f0, f2, f4, f16, f18, f20, f22, f24, f26)
-	EX_ST(STORE_BLK(%f0, %o4 + %g3))
+	EX_ST_FP(STORE_BLK(%f0, %o4 + %g3))
 	FREG_MOVE_3(f26, f28, f30)
 	subcc		%g1, 64, %g1
 	add		%o4, 64, %o4
@@ -360,10 +366,10 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 
 170:	sub		%o4, 16, %g2
 	FREG_LOAD_2(%g2, f0, f2)
-1:	EX_ST(STORE_INIT(%g0, %o4 + %g3))
-	EX_LD(LOAD_BLK(%o4, %f16))
+1:	EX_ST_FP(STORE_INIT(%g0, %o4 + %g3))
+	EX_LD_FP(LOAD_BLK(%o4, %f16))
 	FREG_FROB(f0, f2, f16, f18, f20, f22, f24, f26, f28)
-	EX_ST(STORE_BLK(%f0, %o4 + %g3))
+	EX_ST_FP(STORE_BLK(%f0, %o4 + %g3))
 	FREG_MOVE_2(f28, f30)
 	subcc		%g1, 64, %g1
 	add		%o4, 64, %o4
@@ -374,10 +380,10 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 
 180:	sub		%o4, 8, %g2
 	FREG_LOAD_1(%g2, f0)
-1:	EX_ST(STORE_INIT(%g0, %o4 + %g3))
-	EX_LD(LOAD_BLK(%o4, %f16))
+1:	EX_ST_FP(STORE_INIT(%g0, %o4 + %g3))
+	EX_LD_FP(LOAD_BLK(%o4, %f16))
 	FREG_FROB(f0, f16, f18, f20, f22, f24, f26, f28, f30)
-	EX_ST(STORE_BLK(%f0, %o4 + %g3))
+	EX_ST_FP(STORE_BLK(%f0, %o4 + %g3))
 	FREG_MOVE_1(f30)
 	subcc		%g1, 64, %g1
 	add		%o4, 64, %o4
@@ -387,10 +393,10 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	 nop
 
 190:
-1:	EX_ST(STORE_INIT(%g0, %o4 + %g3))
+1:	EX_ST_FP(STORE_INIT(%g0, %o4 + %g3))
 	subcc		%g1, 64, %g1
-	EX_LD(LOAD_BLK(%o4, %f0))
-	EX_ST(STORE_BLK(%f0, %o4 + %g3))
+	EX_LD_FP(LOAD_BLK(%o4, %f0))
+	EX_ST_FP(STORE_BLK(%f0, %o4 + %g3))
 	add		%o4, 64, %o4
 	bne,pt		%xcc, 1b
 	 LOAD(prefetch, %o4 + 64, #one_read)
diff --git a/arch/sparc/lib/NG4copy_from_user.S b/arch/sparc/lib/NG4copy_from_user.S
index fd9f903..2e8ee7a 100644
--- a/arch/sparc/lib/NG4copy_from_user.S
+++ b/arch/sparc/lib/NG4copy_from_user.S
@@ -11,6 +11,14 @@
 	.text;			\
 	.align 4;
 
+#define EX_LD_FP(x)		\
+98:	x;			\
+	.section __ex_table,"a";\
+	.align 4;		\
+	.word 98b, __retl_one_asi_fp;\
+	.text;			\
+	.align 4;
+
 #ifndef ASI_AIUS
 #define ASI_AIUS	0x11
 #endif
diff --git a/arch/sparc/lib/NG4copy_to_user.S b/arch/sparc/lib/NG4copy_to_user.S
index 9744c454..be0bf45 100644
--- a/arch/sparc/lib/NG4copy_to_user.S
+++ b/arch/sparc/lib/NG4copy_to_user.S
@@ -11,6 +11,14 @@
 	.text;			\
 	.align 4;
 
+#define EX_ST_FP(x)		\
+98:	x;			\
+	.section __ex_table,"a";\
+	.align 4;		\
+	.word 98b, __retl_one_asi_fp;\
+	.text;			\
+	.align 4;
+
 #ifndef ASI_AIUS
 #define ASI_AIUS	0x11
 #endif
diff --git a/arch/sparc/lib/NG4memcpy.S b/arch/sparc/lib/NG4memcpy.S
index 140527a..b8a341a 100644
--- a/arch/sparc/lib/NG4memcpy.S
+++ b/arch/sparc/lib/NG4memcpy.S
@@ -48,10 +48,16 @@
 #ifndef EX_LD
 #define EX_LD(x)	x
 #endif
+#ifndef EX_LD_FP
+#define EX_LD_FP(x)	x
+#endif
 
 #ifndef EX_ST
 #define EX_ST(x)	x
 #endif
+#ifndef EX_ST_FP
+#define EX_ST_FP(x)	x
+#endif
 
 #ifndef EX_RETVAL
 #define EX_RETVAL(x)	x
@@ -210,17 +216,17 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	sub		%o2, %o4, %o2
 	alignaddr	%o1, %g0, %g1
 	add		%o1, %o4, %o1
-	EX_LD(LOAD(ldd, %g1 + 0x00, %f0))
-1:	EX_LD(LOAD(ldd, %g1 + 0x08, %f2))
+	EX_LD_FP(LOAD(ldd, %g1 + 0x00, %f0))
+1:	EX_LD_FP(LOAD(ldd, %g1 + 0x08, %f2))
 	subcc		%o4, 0x40, %o4
-	EX_LD(LOAD(ldd, %g1 + 0x10, %f4))
-	EX_LD(LOAD(ldd, %g1 + 0x18, %f6))
-	EX_LD(LOAD(ldd, %g1 + 0x20, %f8))
-	EX_LD(LOAD(ldd, %g1 + 0x28, %f10))
-	EX_LD(LOAD(ldd, %g1 + 0x30, %f12))
-	EX_LD(LOAD(ldd, %g1 + 0x38, %f14))
+	EX_LD_FP(LOAD(ldd, %g1 + 0x10, %f4))
+	EX_LD_FP(LOAD(ldd, %g1 + 0x18, %f6))
+	EX_LD_FP(LOAD(ldd, %g1 + 0x20, %f8))
+	EX_LD_FP(LOAD(ldd, %g1 + 0x28, %f10))
+	EX_LD_FP(LOAD(ldd, %g1 + 0x30, %f12))
+	EX_LD_FP(LOAD(ldd, %g1 + 0x38, %f14))
 	faligndata	%f0, %f2, %f16
-	EX_LD(LOAD(ldd, %g1 + 0x40, %f0))
+	EX_LD_FP(LOAD(ldd, %g1 + 0x40, %f0))
 	faligndata	%f2, %f4, %f18
 	add		%g1, 0x40, %g1
 	faligndata	%f4, %f6, %f20
@@ -229,14 +235,14 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	faligndata	%f10, %f12, %f26
 	faligndata	%f12, %f14, %f28
 	faligndata	%f14, %f0, %f30
-	EX_ST(STORE(std, %f16, %o0 + 0x00))
-	EX_ST(STORE(std, %f18, %o0 + 0x08))
-	EX_ST(STORE(std, %f20, %o0 + 0x10))
-	EX_ST(STORE(std, %f22, %o0 + 0x18))
-	EX_ST(STORE(std, %f24, %o0 + 0x20))
-	EX_ST(STORE(std, %f26, %o0 + 0x28))
-	EX_ST(STORE(std, %f28, %o0 + 0x30))
-	EX_ST(STORE(std, %f30, %o0 + 0x38))
+	EX_ST_FP(STORE(std, %f16, %o0 + 0x00))
+	EX_ST_FP(STORE(std, %f18, %o0 + 0x08))
+	EX_ST_FP(STORE(std, %f20, %o0 + 0x10))
+	EX_ST_FP(STORE(std, %f22, %o0 + 0x18))
+	EX_ST_FP(STORE(std, %f24, %o0 + 0x20))
+	EX_ST_FP(STORE(std, %f26, %o0 + 0x28))
+	EX_ST_FP(STORE(std, %f28, %o0 + 0x30))
+	EX_ST_FP(STORE(std, %f30, %o0 + 0x38))
 	add		%o0, 0x40, %o0
 	bne,pt		%icc, 1b
 	 LOAD(prefetch, %g1 + 0x200, #n_reads_strong)
diff --git a/arch/sparc/lib/U1copy_from_user.S b/arch/sparc/lib/U1copy_from_user.S
index a6ae2ea..ecc5692 100644
--- a/arch/sparc/lib/U1copy_from_user.S
+++ b/arch/sparc/lib/U1copy_from_user.S
@@ -11,6 +11,14 @@
 	.text;			\
 	.align 4;
 
+#define EX_LD_FP(x)		\
+98:	x;			\
+	.section __ex_table,"a";\
+	.align 4;		\
+	.word 98b, __retl_one_fp;\
+	.text;			\
+	.align 4;
+
 #define FUNC_NAME		___copy_from_user
 #define LOAD(type,addr,dest)	type##a [addr] %asi, dest
 #define LOAD_BLK(addr,dest)	ldda [addr] ASI_BLK_AIUS, dest
diff --git a/arch/sparc/lib/U1copy_to_user.S b/arch/sparc/lib/U1copy_to_user.S
index f4b970e..9eea392 100644
--- a/arch/sparc/lib/U1copy_to_user.S
+++ b/arch/sparc/lib/U1copy_to_user.S
@@ -11,6 +11,14 @@
 	.text;			\
 	.align 4;
 
+#define EX_ST_FP(x)		\
+98:	x;			\
+	.section __ex_table,"a";\
+	.align 4;		\
+	.word 98b, __retl_one_fp;\
+	.text;			\
+	.align 4;
+
 #define FUNC_NAME		___copy_to_user
 #define STORE(type,src,addr)	type##a src, [addr] ASI_AIUS
 #define STORE_BLK(src,addr)	stda src, [addr] ASI_BLK_AIUS
diff --git a/arch/sparc/lib/U1memcpy.S b/arch/sparc/lib/U1memcpy.S
index b67142b..3e6209e 100644
--- a/arch/sparc/lib/U1memcpy.S
+++ b/arch/sparc/lib/U1memcpy.S
@@ -25,10 +25,16 @@
 #ifndef EX_LD
 #define EX_LD(x)	x
 #endif
+#ifndef EX_LD_FP
+#define EX_LD_FP(x)	x
+#endif
 
 #ifndef EX_ST
 #define EX_ST(x)	x
 #endif
+#ifndef EX_ST_FP
+#define EX_ST_FP(x)	x
+#endif
 
 #ifndef EX_RETVAL
 #define EX_RETVAL(x)	x
@@ -73,8 +79,8 @@
 	faligndata		%f8, %f9, %f62;
 
 #define MAIN_LOOP_CHUNK(src, dest, fdest, fsrc, len, jmptgt)	\
-	EX_LD(LOAD_BLK(%src, %fdest));				\
-	EX_ST(STORE_BLK(%fsrc, %dest));				\
+	EX_LD_FP(LOAD_BLK(%src, %fdest));				\
+	EX_ST_FP(STORE_BLK(%fsrc, %dest));				\
 	add			%src, 0x40, %src;		\
 	subcc			%len, 0x40, %len;		\
 	be,pn			%xcc, jmptgt;			\
@@ -89,12 +95,12 @@
 
 #define DO_SYNC			membar	#Sync;
 #define STORE_SYNC(dest, fsrc)				\
-	EX_ST(STORE_BLK(%fsrc, %dest));			\
+	EX_ST_FP(STORE_BLK(%fsrc, %dest));			\
 	add			%dest, 0x40, %dest;	\
 	DO_SYNC
 
 #define STORE_JUMP(dest, fsrc, target)			\
-	EX_ST(STORE_BLK(%fsrc, %dest));			\
+	EX_ST_FP(STORE_BLK(%fsrc, %dest));			\
 	add			%dest, 0x40, %dest;	\
 	ba,pt			%xcc, target;		\
 	 nop;
@@ -103,7 +109,7 @@
 	subcc			%left, 8, %left;\
 	bl,pn			%xcc, 95f;	\
 	 faligndata		%f0, %f1, %f48;	\
-	EX_ST(STORE(std, %f48, %dest));		\
+	EX_ST_FP(STORE(std, %f48, %dest));		\
 	add			%dest, 8, %dest;
 
 #define UNEVEN_VISCHUNK_LAST(dest, f0, f1, left)	\
@@ -160,8 +166,8 @@ FUNC_NAME:		/* %o0=dst, %o1=src, %o2=len */
 	 and		%g2, 0x38, %g2
 
 1:	subcc		%g1, 0x1, %g1
-	EX_LD(LOAD(ldub, %o1 + 0x00, %o3))
-	EX_ST(STORE(stb, %o3, %o1 + %GLOBAL_SPARE))
+	EX_LD_FP(LOAD(ldub, %o1 + 0x00, %o3))
+	EX_ST_FP(STORE(stb, %o3, %o1 + %GLOBAL_SPARE))
 	bgu,pt		%XCC, 1b
 	 add		%o1, 0x1, %o1
 
@@ -172,20 +178,20 @@ FUNC_NAME:		/* %o0=dst, %o1=src, %o2=len */
 	be,pt		%icc, 3f
 	 alignaddr	%o1, %g0, %o1
 
-	EX_LD(LOAD(ldd, %o1, %f4))
-1:	EX_LD(LOAD(ldd, %o1 + 0x8, %f6))
+	EX_LD_FP(LOAD(ldd, %o1, %f4))
+1:	EX_LD_FP(LOAD(ldd, %o1 + 0x8, %f6))
 	add		%o1, 0x8, %o1
 	subcc		%g2, 0x8, %g2
 	faligndata	%f4, %f6, %f0
-	EX_ST(STORE(std, %f0, %o0))
+	EX_ST_FP(STORE(std, %f0, %o0))
 	be,pn		%icc, 3f
 	 add		%o0, 0x8, %o0
 
-	EX_LD(LOAD(ldd, %o1 + 0x8, %f4))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x8, %f4))
 	add		%o1, 0x8, %o1
 	subcc		%g2, 0x8, %g2
 	faligndata	%f6, %f4, %f0
-	EX_ST(STORE(std, %f0, %o0))
+	EX_ST_FP(STORE(std, %f0, %o0))
 	bne,pt		%icc, 1b
 	 add		%o0, 0x8, %o0
 
@@ -208,13 +214,13 @@ FUNC_NAME:		/* %o0=dst, %o1=src, %o2=len */
 	add		%g1, %GLOBAL_SPARE, %g1
 	subcc		%o2, %g3, %o2
 
-	EX_LD(LOAD_BLK(%o1, %f0))
+	EX_LD_FP(LOAD_BLK(%o1, %f0))
 	add		%o1, 0x40, %o1
 	add		%g1, %g3, %g1
-	EX_LD(LOAD_BLK(%o1, %f16))
+	EX_LD_FP(LOAD_BLK(%o1, %f16))
 	add		%o1, 0x40, %o1
 	sub		%GLOBAL_SPARE, 0x80, %GLOBAL_SPARE
-	EX_LD(LOAD_BLK(%o1, %f32))
+	EX_LD_FP(LOAD_BLK(%o1, %f32))
 	add		%o1, 0x40, %o1
 
 	/* There are 8 instances of the unrolled loop,
@@ -426,28 +432,28 @@ FUNC_NAME:		/* %o0=dst, %o1=src, %o2=len */
 62:	FINISH_VISCHUNK(o0, f44, f46, g3)
 63:	UNEVEN_VISCHUNK_LAST(o0, f46, f0,  g3)
 
-93:	EX_LD(LOAD(ldd, %o1, %f2))
+93:	EX_LD_FP(LOAD(ldd, %o1, %f2))
 	add		%o1, 8, %o1
 	subcc		%g3, 8, %g3
 	faligndata	%f0, %f2, %f8
-	EX_ST(STORE(std, %f8, %o0))
+	EX_ST_FP(STORE(std, %f8, %o0))
 	bl,pn		%xcc, 95f
 	 add		%o0, 8, %o0
-	EX_LD(LOAD(ldd, %o1, %f0))
+	EX_LD_FP(LOAD(ldd, %o1, %f0))
 	add		%o1, 8, %o1
 	subcc		%g3, 8, %g3
 	faligndata	%f2, %f0, %f8
-	EX_ST(STORE(std, %f8, %o0))
+	EX_ST_FP(STORE(std, %f8, %o0))
 	bge,pt		%xcc, 93b
 	 add		%o0, 8, %o0
 
 95:	brz,pt		%o2, 2f
 	 mov		%g1, %o1
 
-1:	EX_LD(LOAD(ldub, %o1, %o3))
+1:	EX_LD_FP(LOAD(ldub, %o1, %o3))
 	add		%o1, 1, %o1
 	subcc		%o2, 1, %o2
-	EX_ST(STORE(stb, %o3, %o0))
+	EX_ST_FP(STORE(stb, %o3, %o0))
 	bne,pt		%xcc, 1b
 	 add		%o0, 1, %o0
 
diff --git a/arch/sparc/lib/U3copy_from_user.S b/arch/sparc/lib/U3copy_from_user.S
index b1acd13..88ad73d 100644
--- a/arch/sparc/lib/U3copy_from_user.S
+++ b/arch/sparc/lib/U3copy_from_user.S
@@ -11,6 +11,14 @@
 	.text;			\
 	.align 4;
 
+#define EX_LD_FP(x)		\
+98:	x;			\
+	.section __ex_table,"a";\
+	.align 4;		\
+	.word 98b, __retl_one_fp;\
+	.text;			\
+	.align 4;
+
 #define FUNC_NAME		U3copy_from_user
 #define LOAD(type,addr,dest)	type##a [addr] %asi, dest
 #define EX_RETVAL(x)		0
diff --git a/arch/sparc/lib/U3copy_to_user.S b/arch/sparc/lib/U3copy_to_user.S
index ef1e493..845139d 100644
--- a/arch/sparc/lib/U3copy_to_user.S
+++ b/arch/sparc/lib/U3copy_to_user.S
@@ -11,6 +11,14 @@
 	.text;			\
 	.align 4;
 
+#define EX_ST_FP(x)		\
+98:	x;			\
+	.section __ex_table,"a";\
+	.align 4;		\
+	.word 98b, __retl_one_fp;\
+	.text;			\
+	.align 4;
+
 #define FUNC_NAME		U3copy_to_user
 #define STORE(type,src,addr)	type##a src, [addr] ASI_AIUS
 #define STORE_BLK(src,addr)	stda src, [addr] ASI_BLK_AIUS
diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
index 7cae9cc..491ee69 100644
--- a/arch/sparc/lib/U3memcpy.S
+++ b/arch/sparc/lib/U3memcpy.S
@@ -24,10 +24,16 @@
 #ifndef EX_LD
 #define EX_LD(x)	x
 #endif
+#ifndef EX_LD_FP
+#define EX_LD_FP(x)	x
+#endif
 
 #ifndef EX_ST
 #define EX_ST(x)	x
 #endif
+#ifndef EX_ST_FP
+#define EX_ST_FP(x)	x
+#endif
 
 #ifndef EX_RETVAL
 #define EX_RETVAL(x)	x
@@ -120,8 +126,8 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	 and		%g2, 0x38, %g2
 
 1:	subcc		%g1, 0x1, %g1
-	EX_LD(LOAD(ldub, %o1 + 0x00, %o3))
-	EX_ST(STORE(stb, %o3, %o1 + GLOBAL_SPARE))
+	EX_LD_FP(LOAD(ldub, %o1 + 0x00, %o3))
+	EX_ST_FP(STORE(stb, %o3, %o1 + GLOBAL_SPARE))
 	bgu,pt		%XCC, 1b
 	 add		%o1, 0x1, %o1
 
@@ -132,20 +138,20 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	be,pt		%icc, 3f
 	 alignaddr	%o1, %g0, %o1
 
-	EX_LD(LOAD(ldd, %o1, %f4))
-1:	EX_LD(LOAD(ldd, %o1 + 0x8, %f6))
+	EX_LD_FP(LOAD(ldd, %o1, %f4))
+1:	EX_LD_FP(LOAD(ldd, %o1 + 0x8, %f6))
 	add		%o1, 0x8, %o1
 	subcc		%g2, 0x8, %g2
 	faligndata	%f4, %f6, %f0
-	EX_ST(STORE(std, %f0, %o0))
+	EX_ST_FP(STORE(std, %f0, %o0))
 	be,pn		%icc, 3f
 	 add		%o0, 0x8, %o0
 
-	EX_LD(LOAD(ldd, %o1 + 0x8, %f4))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x8, %f4))
 	add		%o1, 0x8, %o1
 	subcc		%g2, 0x8, %g2
 	faligndata	%f6, %f4, %f2
-	EX_ST(STORE(std, %f2, %o0))
+	EX_ST_FP(STORE(std, %f2, %o0))
 	bne,pt		%icc, 1b
 	 add		%o0, 0x8, %o0
 
@@ -155,25 +161,25 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	LOAD(prefetch, %o1 + 0x080, #one_read)
 	LOAD(prefetch, %o1 + 0x0c0, #one_read)
 	LOAD(prefetch, %o1 + 0x100, #one_read)
-	EX_LD(LOAD(ldd, %o1 + 0x000, %f0))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x000, %f0))
 	LOAD(prefetch, %o1 + 0x140, #one_read)
-	EX_LD(LOAD(ldd, %o1 + 0x008, %f2))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x008, %f2))
 	LOAD(prefetch, %o1 + 0x180, #one_read)
-	EX_LD(LOAD(ldd, %o1 + 0x010, %f4))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x010, %f4))
 	LOAD(prefetch, %o1 + 0x1c0, #one_read)
 	faligndata	%f0, %f2, %f16
-	EX_LD(LOAD(ldd, %o1 + 0x018, %f6))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x018, %f6))
 	faligndata	%f2, %f4, %f18
-	EX_LD(LOAD(ldd, %o1 + 0x020, %f8))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x020, %f8))
 	faligndata	%f4, %f6, %f20
-	EX_LD(LOAD(ldd, %o1 + 0x028, %f10))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x028, %f10))
 	faligndata	%f6, %f8, %f22
 
-	EX_LD(LOAD(ldd, %o1 + 0x030, %f12))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x030, %f12))
 	faligndata	%f8, %f10, %f24
-	EX_LD(LOAD(ldd, %o1 + 0x038, %f14))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x038, %f14))
 	faligndata	%f10, %f12, %f26
-	EX_LD(LOAD(ldd, %o1 + 0x040, %f0))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x040, %f0))
 
 	subcc		GLOBAL_SPARE, 0x80, GLOBAL_SPARE
 	add		%o1, 0x40, %o1
@@ -184,26 +190,26 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 
 	.align		64
 1:
-	EX_LD(LOAD(ldd, %o1 + 0x008, %f2))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x008, %f2))
 	faligndata	%f12, %f14, %f28
-	EX_LD(LOAD(ldd, %o1 + 0x010, %f4))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x010, %f4))
 	faligndata	%f14, %f0, %f30
-	EX_ST(STORE_BLK(%f16, %o0))
-	EX_LD(LOAD(ldd, %o1 + 0x018, %f6))
+	EX_ST_FP(STORE_BLK(%f16, %o0))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x018, %f6))
 	faligndata	%f0, %f2, %f16
 	add		%o0, 0x40, %o0
 
-	EX_LD(LOAD(ldd, %o1 + 0x020, %f8))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x020, %f8))
 	faligndata	%f2, %f4, %f18
-	EX_LD(LOAD(ldd, %o1 + 0x028, %f10))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x028, %f10))
 	faligndata	%f4, %f6, %f20
-	EX_LD(LOAD(ldd, %o1 + 0x030, %f12))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x030, %f12))
 	subcc		%o3, 0x01, %o3
 	faligndata	%f6, %f8, %f22
-	EX_LD(LOAD(ldd, %o1 + 0x038, %f14))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x038, %f14))
 
 	faligndata	%f8, %f10, %f24
-	EX_LD(LOAD(ldd, %o1 + 0x040, %f0))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x040, %f0))
 	LOAD(prefetch, %o1 + 0x1c0, #one_read)
 	faligndata	%f10, %f12, %f26
 	bg,pt		%XCC, 1b
@@ -211,29 +217,29 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 
 	/* Finally we copy the last full 64-byte block. */
 2:
-	EX_LD(LOAD(ldd, %o1 + 0x008, %f2))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x008, %f2))
 	faligndata	%f12, %f14, %f28
-	EX_LD(LOAD(ldd, %o1 + 0x010, %f4))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x010, %f4))
 	faligndata	%f14, %f0, %f30
-	EX_ST(STORE_BLK(%f16, %o0))
-	EX_LD(LOAD(ldd, %o1 + 0x018, %f6))
+	EX_ST_FP(STORE_BLK(%f16, %o0))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x018, %f6))
 	faligndata	%f0, %f2, %f16
-	EX_LD(LOAD(ldd, %o1 + 0x020, %f8))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x020, %f8))
 	faligndata	%f2, %f4, %f18
-	EX_LD(LOAD(ldd, %o1 + 0x028, %f10))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x028, %f10))
 	faligndata	%f4, %f6, %f20
-	EX_LD(LOAD(ldd, %o1 + 0x030, %f12))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x030, %f12))
 	faligndata	%f6, %f8, %f22
-	EX_LD(LOAD(ldd, %o1 + 0x038, %f14))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x038, %f14))
 	faligndata	%f8, %f10, %f24
 	cmp		%g1, 0
 	be,pt		%XCC, 1f
 	 add		%o0, 0x40, %o0
-	EX_LD(LOAD(ldd, %o1 + 0x040, %f0))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x040, %f0))
 1:	faligndata	%f10, %f12, %f26
 	faligndata	%f12, %f14, %f28
 	faligndata	%f14, %f0, %f30
-	EX_ST(STORE_BLK(%f16, %o0))
+	EX_ST_FP(STORE_BLK(%f16, %o0))
 	add		%o0, 0x40, %o0
 	add		%o1, 0x40, %o1
 	membar		#Sync
@@ -253,20 +259,20 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 
 	sub		%o2, %g2, %o2
 	be,a,pt		%XCC, 1f
-	 EX_LD(LOAD(ldd, %o1 + 0x00, %f0))
+	 EX_LD_FP(LOAD(ldd, %o1 + 0x00, %f0))
 
-1:	EX_LD(LOAD(ldd, %o1 + 0x08, %f2))
+1:	EX_LD_FP(LOAD(ldd, %o1 + 0x08, %f2))
 	add		%o1, 0x8, %o1
 	subcc		%g2, 0x8, %g2
 	faligndata	%f0, %f2, %f8
-	EX_ST(STORE(std, %f8, %o0))
+	EX_ST_FP(STORE(std, %f8, %o0))
 	be,pn		%XCC, 2f
 	 add		%o0, 0x8, %o0
-	EX_LD(LOAD(ldd, %o1 + 0x08, %f0))
+	EX_LD_FP(LOAD(ldd, %o1 + 0x08, %f0))
 	add		%o1, 0x8, %o1
 	subcc		%g2, 0x8, %g2
 	faligndata	%f2, %f0, %f8
-	EX_ST(STORE(std, %f8, %o0))
+	EX_ST_FP(STORE(std, %f8, %o0))
 	bne,pn		%XCC, 1b
 	 add		%o0, 0x8, %o0
 
-- 
1.7.9.5

