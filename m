From: Joseph Myers <joseph@codesourcery.com>
Date: Thu, 02 Jul 2015 15:54:34 +0000
Subject: [PATCH 7/8] sparc/math-emu: Move sparc from math-emu-old to math-emu
Message-Id: <alpine.DEB.2.10.1507021553390.29415@digraph.polyomino.org.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, mpe@ellerman.id.au

From: Joseph Myers <joseph@codesourcery.com>

This patch moves sparc from math-emu-old to math-emu, updating it for
the API changes.

The following cleanup (that goes beyond mechanical conversion to new
APIs) is included in this patch because of its close connection to the
API changes:

* On SPARC, comparisons now use raw unpacking (this should not in fact
  change how the emulation behaves, just make it more efficient).

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

---

diff --git a/arch/sparc/include/asm/sfp-machine_32.h b/arch/sparc/include/asm/sfp-machine_32.h
index 838c9d58..53ce267 100644
--- a/arch/sparc/include/asm/sfp-machine_32.h
+++ b/arch/sparc/include/asm/sfp-machine_32.h
@@ -50,6 +50,7 @@
 #define _FP_NANSIGN_Q		0
 
 #define _FP_KEEPNANFRACP 1
+#define _FP_QNANNEGATEDP 0
 
 /* If one NaN is signaling and the other is not,
  * we choose that one, otherwise we choose X.
@@ -209,4 +210,6 @@ extern struct task_struct *last_task_used_math;
 #define FP_TRAPPING_EXCEPTIONS ((last_task_used_math->thread.fsr >> 23) & 0x1f)
 #endif
 
+#define _FP_TININESS_AFTER_ROUNDING 0
+
 #endif
diff --git a/arch/sparc/include/asm/sfp-machine_64.h b/arch/sparc/include/asm/sfp-machine_64.h
index ca913ef..a83dbf6 100644
--- a/arch/sparc/include/asm/sfp-machine_64.h
+++ b/arch/sparc/include/asm/sfp-machine_64.h
@@ -48,6 +48,7 @@
 #define _FP_NANSIGN_Q		0
 
 #define _FP_KEEPNANFRACP 1
+#define _FP_QNANNEGATEDP 0
 
 /* If one NaN is signaling and the other is not,
  * we choose that one, otherwise we choose X.
@@ -90,4 +91,6 @@
 
 #define FP_TRAPPING_EXCEPTIONS ((current_thread_info()->xfsr[0] >> 23) & 0x1f)
 
+#define _FP_TININESS_AFTER_ROUNDING 0
+
 #endif
diff --git a/arch/sparc/math-emu/math_32.c b/arch/sparc/math-emu/math_32.c
index 3aaaeef..f708ee0 100644
--- a/arch/sparc/math-emu/math_32.c
+++ b/arch/sparc/math-emu/math_32.c
@@ -71,10 +71,10 @@
 #include <asm/uaccess.h>
 
 #include "sfp-util_32.h"
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/single.h>
-#include <math-emu-old/double.h>
-#include <math-emu-old/quad.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/single.h>
+#include <math-emu/double.h>
+#include <math-emu/quad.h>
 
 #define FLOATFUNC(x) extern int x(void *,void *,void *)
 
@@ -276,9 +276,11 @@ static int do_one_mathemu(u32 insn, unsigned long *pfsr, unsigned long *fregs)
 	/* Emulate the given insn, updating fsr and fregs appropriately. */
 	int type = 0;
 	/* r is rd, b is rs2 and a is rs1. The *u arg tells
-	   whether the argument should be packed/unpacked (0 - do not unpack/pack, 1 - unpack/pack)
+	   whether and how the argument should be packed/unpacked
+	   (0 - do not unpack/pack, 1 - unpack/pack raw, 2 - semi-raw,
+	   3 - cooked)
 	   non-u args tells the size of the argument (0 - no argument, 1 - single, 2 - double, 3 - quad */
-#define TYPE(dummy, r, ru, b, bu, a, au) type = (au << 2) | (a << 0) | (bu << 5) | (b << 3) | (ru << 8) | (r << 6)
+#define TYPE(dummy, r, ru, b, bu, a, au) type = (au << 2) | (a << 0) | (bu << 6) | (b << 4) | (ru << 10) | (r << 8)
 	int freg;
 	argp rs1 = NULL, rs2 = NULL, rd = NULL;
 	FP_DECL_EX;
@@ -286,6 +288,7 @@ static int do_one_mathemu(u32 insn, unsigned long *pfsr, unsigned long *fregs)
 	FP_DECL_D(DA); FP_DECL_D(DB); FP_DECL_D(DR);
 	FP_DECL_Q(QA); FP_DECL_Q(QB); FP_DECL_Q(QR);
 	int IR;
+	unsigned int UIR;
 	long fsr;
 
 #ifdef DEBUG_MATHEMU
@@ -294,30 +297,30 @@ static int do_one_mathemu(u32 insn, unsigned long *pfsr, unsigned long *fregs)
 
 	if ((insn & 0xc1f80000) = 0x81a00000)	/* FPOP1 */ {
 		switch ((insn >> 5) & 0x1ff) {
-		case FSQRTQ: TYPE(3,3,1,3,1,0,0); break;
+		case FSQRTQ: TYPE(3,3,3,3,3,0,0); break;
 		case FADDQ:
-		case FSUBQ:
+		case FSUBQ: TYPE(3,3,2,3,2,3,2); break;
 		case FMULQ:
-		case FDIVQ: TYPE(3,3,1,3,1,3,1); break;
-		case FDMULQ: TYPE(3,3,1,2,1,2,1); break;
-		case FQTOS: TYPE(3,1,1,3,1,0,0); break;
-		case FQTOD: TYPE(3,2,1,3,1,0,0); break;
+		case FDIVQ: TYPE(3,3,3,3,3,3,3); break;
+		case FDMULQ: TYPE(3,3,3,2,1,2,1); break;
+		case FQTOS: TYPE(3,1,2,3,2,0,0); break;
+		case FQTOD: TYPE(3,2,2,3,2,0,0); break;
 		case FITOQ: TYPE(3,3,1,1,0,0,0); break;
 		case FSTOQ: TYPE(3,3,1,1,1,0,0); break;
 		case FDTOQ: TYPE(3,3,1,2,1,0,0); break;
 		case FQTOI: TYPE(3,1,0,3,1,0,0); break;
-		case FSQRTS: TYPE(2,1,1,1,1,0,0); break;
-		case FSQRTD: TYPE(2,2,1,2,1,0,0); break;
+		case FSQRTS: TYPE(2,1,3,1,3,0,0); break;
+		case FSQRTD: TYPE(2,2,3,2,3,0,0); break;
 		case FADDD:
-		case FSUBD:
+		case FSUBD: TYPE(2,2,2,2,2,2,2); break;
 		case FMULD:
-		case FDIVD: TYPE(2,2,1,2,1,2,1); break;
+		case FDIVD: TYPE(2,2,3,2,3,2,3); break;
 		case FADDS:
-		case FSUBS:
+		case FSUBS: TYPE(2,1,2,1,2,1,2); break;
 		case FMULS:
-		case FDIVS: TYPE(2,1,1,1,1,1,1); break;
-		case FSMULD: TYPE(2,2,1,1,1,1,1); break;
-		case FDTOS: TYPE(2,1,1,2,1,0,0); break;
+		case FDIVS: TYPE(2,1,3,1,3,1,3); break;
+		case FSMULD: TYPE(2,2,3,1,1,1,1); break;
+		case FDTOS: TYPE(2,1,2,2,2,0,0); break;
 		case FSTOD: TYPE(2,2,1,1,1,0,0); break;
 		case FSTOI: TYPE(2,1,0,1,1,0,0); break;
 		case FDTOI: TYPE(2,1,0,2,1,0,0); break;
@@ -366,13 +369,19 @@ static int do_one_mathemu(u32 insn, unsigned long *pfsr, unsigned long *fregs)
 		}
 	}
 	rs1 = (argp)&fregs[freg];
-	switch (type & 0x7) {
-	case 7: FP_UNPACK_QP (QA, rs1); break;
-	case 6: FP_UNPACK_DP (DA, rs1); break;
-	case 5: FP_UNPACK_SP (SA, rs1); break;
+	switch (type & 0xf) {
+	case 7: FP_UNPACK_RAW_QP (QA, rs1); break;
+	case 6: FP_UNPACK_RAW_DP (DA, rs1); break;
+	case 5: FP_UNPACK_RAW_SP (SA, rs1); break;
+	case 11: FP_UNPACK_SEMIRAW_QP (QA, rs1); break;
+	case 10: FP_UNPACK_SEMIRAW_DP (DA, rs1); break;
+	case 9: FP_UNPACK_SEMIRAW_SP (SA, rs1); break;
+	case 15: FP_UNPACK_QP (QA, rs1); break;
+	case 14: FP_UNPACK_DP (DA, rs1); break;
+	case 13: FP_UNPACK_SP (SA, rs1); break;
 	}
 	freg = (insn & 0x1f);
-	switch ((type >> 3) & 0x3) {			/* same again for rs2 */
+	switch ((type >> 4) & 0x3) {			/* same again for rs2 */
 	case 3:
 		if (freg & 3) {				/* quadwords must have bits 4&5 of the */
 							/* encoded reg. number set to zero. */
@@ -387,13 +396,19 @@ static int do_one_mathemu(u32 insn, unsigned long *pfsr, unsigned long *fregs)
 		}
 	}
 	rs2 = (argp)&fregs[freg];
-	switch ((type >> 3) & 0x7) {
-	case 7: FP_UNPACK_QP (QB, rs2); break;
-	case 6: FP_UNPACK_DP (DB, rs2); break;
-	case 5: FP_UNPACK_SP (SB, rs2); break;
+	switch ((type >> 4) & 0xf) {
+	case 7: FP_UNPACK_RAW_QP (QA, rs2); break;
+	case 6: FP_UNPACK_RAW_DP (DA, rs2); break;
+	case 5: FP_UNPACK_RAW_SP (SA, rs2); break;
+	case 11: FP_UNPACK_SEMIRAW_QP (QA, rs2); break;
+	case 10: FP_UNPACK_SEMIRAW_DP (DA, rs2); break;
+	case 9: FP_UNPACK_SEMIRAW_SP (SA, rs2); break;
+	case 15: FP_UNPACK_QP (QA, rs2); break;
+	case 14: FP_UNPACK_DP (DA, rs2); break;
+	case 13: FP_UNPACK_SP (SA, rs2); break;
 	}
 	freg = ((insn >> 25) & 0x1f);
-	switch ((type >> 6) & 0x3) {			/* and finally rd. This one's a bit different */
+	switch ((type >> 8) & 0x3) {			/* and finally rd. This one's a bit different */
 	case 0:						/* dest is fcc. (this must be FCMPQ or FCMPEQ) */
 		if (freg) {				/* V8 has only one set of condition codes, so */
 							/* anything but 0 in the rd field is an error */
@@ -433,11 +448,15 @@ static int do_one_mathemu(u32 insn, unsigned long *pfsr, unsigned long *fregs)
 	case FSUBQ: FP_SUB_Q (QR, QA, QB); break;
 	/* * */
 	case FMULS: FP_MUL_S (SR, SA, SB); break;
-	case FSMULD: FP_CONV (D, S, 2, 1, DA, SA);
-		     FP_CONV (D, S, 2, 1, DB, SB);
+	case FSMULD: FP_EXTEND (D, S, 2, 1, DA, SA);
+		     _FP_UNPACK_CANONICAL (D, 2, DA);
+		     FP_EXTEND (D, S, 2, 1, DB, SB);
+		     _FP_UNPACK_CANONICAL (D, 2, DB);
 	case FMULD: FP_MUL_D (DR, DA, DB); break;
-	case FDMULQ: FP_CONV (Q, D, 4, 2, QA, DA);
-		     FP_CONV (Q, D, 4, 2, QB, DB);
+	case FDMULQ: FP_EXTEND (Q, D, 4, 2, QA, DA);
+		     _FP_UNPACK_CANONICAL (Q, 4, QA);
+		     FP_EXTEND (Q, D, 4, 2, QB, DB);
+		     _FP_UNPACK_CANONICAL (Q, 4, QB);
 	case FMULQ: FP_MUL_Q (QR, QA, QB); break;
 	/* / */
 	case FDIVS: FP_DIV_S (SR, SA, SB); break;
@@ -452,50 +471,41 @@ static int do_one_mathemu(u32 insn, unsigned long *pfsr, unsigned long *fregs)
 	case FABSS: rd->s = rs2->s & 0x7fffffff; break;
 	case FNEGS: rd->s = rs2->s ^ 0x80000000; break;
 	/* float to int */
-	case FSTOI: FP_TO_INT_S (IR, SB, 32, 1); break;
-	case FDTOI: FP_TO_INT_D (IR, DB, 32, 1); break;
-	case FQTOI: FP_TO_INT_Q (IR, QB, 32, 1); break;
+	case FSTOI: FP_TO_INT_S (UIR, SB, 32, 1); IR = UIR; break;
+	case FDTOI: FP_TO_INT_D (UIR, DB, 32, 1); IR = UIR; break;
+	case FQTOI: FP_TO_INT_Q (UIR, QB, 32, 1); IR = UIR; break;
 	/* int to float */
-	case FITOS: IR = rs2->s; FP_FROM_INT_S (SR, IR, 32, int); break;
-	case FITOD: IR = rs2->s; FP_FROM_INT_D (DR, IR, 32, int); break;
-	case FITOQ: IR = rs2->s; FP_FROM_INT_Q (QR, IR, 32, int); break;
+	case FITOS: IR = rs2->s; FP_FROM_INT_S (SR, IR, 32, unsigned int);
+		    break;
+	case FITOD: IR = rs2->s; FP_FROM_INT_D (DR, IR, 32, unsigned int);
+		    break;
+	case FITOQ: IR = rs2->s; FP_FROM_INT_Q (QR, IR, 32, unsigned int);
+		    break;
 	/* float to float */
-	case FSTOD: FP_CONV (D, S, 2, 1, DR, SB); break;
-	case FSTOQ: FP_CONV (Q, S, 4, 1, QR, SB); break;
-	case FDTOQ: FP_CONV (Q, D, 4, 2, QR, DB); break;
-	case FDTOS: FP_CONV (S, D, 1, 2, SR, DB); break;
-	case FQTOS: FP_CONV (S, Q, 1, 4, SR, QB); break;
-	case FQTOD: FP_CONV (D, Q, 2, 4, DR, QB); break;
+	case FSTOD: FP_EXTEND (D, S, 2, 1, DR, SB); break;
+	case FSTOQ: FP_EXTEND (Q, S, 4, 1, QR, SB); break;
+	case FDTOQ: FP_EXTEND (Q, D, 4, 2, QR, DB); break;
+	case FDTOS: FP_TRUNC (S, D, 1, 2, SR, DB); break;
+	case FQTOS: FP_TRUNC (S, Q, 1, 4, SR, QB); break;
+	case FQTOD: FP_TRUNC (D, Q, 2, 4, DR, QB); break;
 	/* comparison */
 	case FCMPS:
 	case FCMPES:
-		FP_CMP_S(IR, SB, SA, 3);
-		if (IR = 3 &&
-		    (((insn >> 5) & 0x1ff) = FCMPES ||
-		     FP_ISSIGNAN_S(SA) ||
-		     FP_ISSIGNAN_S(SB)))
-			FP_SET_EXCEPTION (FP_EX_INVALID);
+		FP_CMP_S(IR, SB, SA, 3,
+			((insn >> 5) & 0x1ff) = FCMPES ? 2 : 1);
 		break;
 	case FCMPD:
 	case FCMPED:
-		FP_CMP_D(IR, DB, DA, 3);
-		if (IR = 3 &&
-		    (((insn >> 5) & 0x1ff) = FCMPED ||
-		     FP_ISSIGNAN_D(DA) ||
-		     FP_ISSIGNAN_D(DB)))
-			FP_SET_EXCEPTION (FP_EX_INVALID);
+		FP_CMP_D(IR, DB, DA, 3,
+			((insn >> 5) & 0x1ff) = FCMPED ? 2 : 1);
 		break;
 	case FCMPQ:
 	case FCMPEQ:
-		FP_CMP_Q(IR, QB, QA, 3);
-		if (IR = 3 &&
-		    (((insn >> 5) & 0x1ff) = FCMPEQ ||
-		     FP_ISSIGNAN_Q(QA) ||
-		     FP_ISSIGNAN_Q(QB)))
-			FP_SET_EXCEPTION (FP_EX_INVALID);
+		FP_CMP_Q(IR, QB, QA, 3,
+			((insn >> 5) & 0x1ff) = FCMPEQ ? 2 : 1);
 	}
 	if (!FP_INHIBIT_RESULTS) {
-		switch ((type >> 6) & 0x7) {
+		switch ((type >> 8) & 0xf) {
 		case 0: fsr = *pfsr;
 			if (IR = -1) IR = 2;
 			/* fcc is always fcc0 */
@@ -503,9 +513,15 @@ static int do_one_mathemu(u32 insn, unsigned long *pfsr, unsigned long *fregs)
 			*pfsr = fsr;
 			break;
 		case 1: rd->s = IR; break;
-		case 5: FP_PACK_SP (rd, SR); break;
-		case 6: FP_PACK_DP (rd, DR); break;
-		case 7: FP_PACK_QP (rd, QR); break;
+		case 5: FP_PACK_RAW_SP (rd, SR); break;
+		case 6: FP_PACK_RAW_DP (rd, DR); break;
+		case 7: FP_PACK_RAW_QP (rd, QR); break;
+		case 9: FP_PACK_SEMIRAW_SP (rd, SR); break;
+		case 10: FP_PACK_SEMIRAW_DP (rd, DR); break;
+		case 11: FP_PACK_SEMIRAW_QP (rd, QR); break;
+		case 13: FP_PACK_SP (rd, SR); break;
+		case 14: FP_PACK_DP (rd, DR); break;
+		case 15: FP_PACK_QP (rd, QR); break;
 		}
 	}
 	if (_fex = 0)
diff --git a/arch/sparc/math-emu/math_64.c b/arch/sparc/math-emu/math_64.c
index c720cbb..973db59 100644
--- a/arch/sparc/math-emu/math_64.c
+++ b/arch/sparc/math-emu/math_64.c
@@ -19,10 +19,10 @@
 #include <asm/cacheflush.h>
 
 #include "sfp-util_64.h"
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/single.h>
-#include <math-emu-old/double.h>
-#include <math-emu-old/quad.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/single.h>
+#include <math-emu/double.h>
+#include <math-emu/quad.h>
 
 /* QUAD - ftt = 3 */
 #define FMOVQ	0x003
@@ -170,9 +170,11 @@ int do_mathemu(struct pt_regs *regs, struct fpustate *f, bool illegal_insn_trap)
 	u32 insn = 0;
 	int type = 0;
 	/* ftt tells which ftt it may happen in, r is rd, b is rs2 and a is rs1. The *u arg tells
-	   whether the argument should be packed/unpacked (0 - do not unpack/pack, 1 - unpack/pack)
+	   whether and how the argument should be packed/unpacked
+	   (0 - do not unpack/pack, 1 - unpack/pack raw, 2 - semi-raw,
+	   3- cooked)
 	   non-u args tells the size of the argument (0 - no argument, 1 - single, 2 - double, 3 - quad */
-#define TYPE(ftt, r, ru, b, bu, a, au) type = (au << 2) | (a << 0) | (bu << 5) | (b << 3) | (ru << 8) | (r << 6) | (ftt << 9)
+#define TYPE(ftt, r, ru, b, bu, a, au) type = (au << 2) | (a << 0) | (bu << 6) | (b << 4) | (ru << 10) | (r << 8) | (ftt << 12)
 	int freg;
 	static u64 zero[2] = { 0L, 0L };
 	int flags;
@@ -181,7 +183,9 @@ int do_mathemu(struct pt_regs *regs, struct fpustate *f, bool illegal_insn_trap)
 	FP_DECL_D(DA); FP_DECL_D(DB); FP_DECL_D(DR);
 	FP_DECL_Q(QA); FP_DECL_Q(QB); FP_DECL_Q(QR);
 	int IR;
+	unsigned int UIR;
 	long XR, xfsr;
+	unsigned long UXR;
 
 	if (tstate & TSTATE_PRIV)
 		die_if_kernel("unfinished/unimplemented FPop from kernel", regs);
@@ -195,16 +199,16 @@ int do_mathemu(struct pt_regs *regs, struct fpustate *f, bool illegal_insn_trap)
 			case FMOVQ:
 			case FNEGQ:
 			case FABSQ: TYPE(3,3,0,3,0,0,0); break;
-			case FSQRTQ: TYPE(3,3,1,3,1,0,0); break;
+			case FSQRTQ: TYPE(3,3,3,3,3,0,0); break;
 			case FADDQ:
-			case FSUBQ:
+			case FSUBQ: TYPE(3,3,2,3,2,3,2); break;
 			case FMULQ:
-			case FDIVQ: TYPE(3,3,1,3,1,3,1); break;
-			case FDMULQ: TYPE(3,3,1,2,1,2,1); break;
+			case FDIVQ: TYPE(3,3,3,3,3,3,3); break;
+			case FDMULQ: TYPE(3,3,3,2,1,2,1); break;
 			case FQTOX: TYPE(3,2,0,3,1,0,0); break;
 			case FXTOQ: TYPE(3,3,1,2,0,0,0); break;
-			case FQTOS: TYPE(3,1,1,3,1,0,0); break;
-			case FQTOD: TYPE(3,2,1,3,1,0,0); break;
+			case FQTOS: TYPE(3,1,2,3,2,0,0); break;
+			case FQTOD: TYPE(3,2,2,3,2,0,0); break;
 			case FITOQ: TYPE(3,3,1,1,0,0,0); break;
 			case FSTOQ: TYPE(3,3,1,1,1,0,0); break;
 			case FDTOQ: TYPE(3,3,1,2,1,0,0); break;
@@ -219,7 +223,7 @@ int do_mathemu(struct pt_regs *regs, struct fpustate *f, bool illegal_insn_trap)
 				unsigned long x = current_thread_info()->xfsr[0];
 
 				x = (x >> 14) & 0x7;
-				TYPE(x,1,1,1,1,0,0);
+				TYPE(x,1,3,1,3,0,0);
 				break;
 			}
 
@@ -227,23 +231,23 @@ int do_mathemu(struct pt_regs *regs, struct fpustate *f, bool illegal_insn_trap)
 				unsigned long x = current_thread_info()->xfsr[0];
 
 				x = (x >> 14) & 0x7;
-				TYPE(x,2,1,2,1,0,0);
+				TYPE(x,2,3,2,3,0,0);
 				break;
 			}
 
 			/* SUBNORMAL - ftt = 2 */
 			case FADDD:
-			case FSUBD:
+			case FSUBD: TYPE(2,2,2,2,2,2,2); break;
 			case FMULD:
-			case FDIVD: TYPE(2,2,1,2,1,2,1); break;
+			case FDIVD: TYPE(2,2,3,2,3,2,3); break;
 			case FADDS:
-			case FSUBS:
+			case FSUBS: TYPE(2,1,2,1,2,1,2); break;
 			case FMULS:
-			case FDIVS: TYPE(2,1,1,1,1,1,1); break;
-			case FSMULD: TYPE(2,2,1,1,1,1,1); break;
+			case FDIVS: TYPE(2,1,3,1,3,1,3); break;
+			case FSMULD: TYPE(2,2,3,1,1,1,1); break;
 			case FSTOX: TYPE(2,2,0,1,1,0,0); break;
 			case FDTOX: TYPE(2,2,0,2,1,0,0); break;
-			case FDTOS: TYPE(2,1,1,2,1,0,0); break;
+			case FDTOS: TYPE(2,1,2,2,2,0,0); break;
 			case FSTOD: TYPE(2,2,1,1,1,0,0); break;
 			case FSTOI: TYPE(2,1,0,1,1,0,0); break;
 			case FDTOI: TYPE(2,1,0,2,1,0,0); break;
@@ -365,7 +369,7 @@ int do_mathemu(struct pt_regs *regs, struct fpustate *f, bool illegal_insn_trap)
 		 */
 		if (!illegal_insn_trap) {
 			int ftt = (current_thread_info()->xfsr[0] >> 14) & 0x7;
-			if (ftt != (type >> 9))
+			if (ftt != (type >> 12))
 				goto err;
 		}
 		current_thread_info()->xfsr[0] &= ~0x1c000;
@@ -382,13 +386,19 @@ int do_mathemu(struct pt_regs *regs, struct fpustate *f, bool illegal_insn_trap)
 				rs1 = (argp)&zero;
 			break;
 		}
-		switch (type & 0x7) {
-		case 7: FP_UNPACK_QP (QA, rs1); break;
-		case 6: FP_UNPACK_DP (DA, rs1); break;
-		case 5: FP_UNPACK_SP (SA, rs1); break;
+		switch (type & 0xf) {
+		case 7: FP_UNPACK_RAW_QP (QA, rs1); break;
+		case 6: FP_UNPACK_RAW_DP (DA, rs1); break;
+		case 5: FP_UNPACK_RAW_SP (SA, rs1); break;
+		case 11: FP_UNPACK_SEMIRAW_QP (QA, rs1); break;
+		case 10: FP_UNPACK_SEMIRAW_DP (DA, rs1); break;
+		case 9: FP_UNPACK_SEMIRAW_SP (SA, rs1); break;
+		case 15: FP_UNPACK_QP (QA, rs1); break;
+		case 14: FP_UNPACK_DP (DA, rs1); break;
+		case 13: FP_UNPACK_SP (SA, rs1); break;
 		}
 		freg = (insn & 0x1f);
-		switch ((type >> 3) & 0x3) {
+		switch ((type >> 4) & 0x3) {
 		case 3: if (freg & 2) {
 				current_thread_info()->xfsr[0] |= (6 << 14) /* invalid_fp_register */;
 				goto err;
@@ -400,13 +410,19 @@ int do_mathemu(struct pt_regs *regs, struct fpustate *f, bool illegal_insn_trap)
 				rs2 = (argp)&zero;
 			break;
 		}
-		switch ((type >> 3) & 0x7) {
-		case 7: FP_UNPACK_QP (QB, rs2); break;
-		case 6: FP_UNPACK_DP (DB, rs2); break;
-		case 5: FP_UNPACK_SP (SB, rs2); break;
+		switch ((type >> 4) & 0xf) {
+		case 7: FP_UNPACK_RAW_QP (QB, rs2); break;
+		case 6: FP_UNPACK_RAW_DP (DB, rs2); break;
+		case 5: FP_UNPACK_RAW_SP (SB, rs2); break;
+		case 11: FP_UNPACK_SEMIRAW_QP (QB, rs2); break;
+		case 10: FP_UNPACK_SEMIRAW_DP (DB, rs2); break;
+		case 9: FP_UNPACK_SEMIRAW_SP (SB, rs2); break;
+		case 15: FP_UNPACK_QP (QB, rs2); break;
+		case 14: FP_UNPACK_DP (DB, rs2); break;
+		case 13: FP_UNPACK_SP (SB, rs2); break;
 		}
 		freg = ((insn >> 25) & 0x1f);
-		switch ((type >> 6) & 0x3) {
+		switch ((type >> 8) & 0x3) {
 		case 3: if (freg & 2) {
 				current_thread_info()->xfsr[0] |= (6 << 14) /* invalid_fp_register */;
 				goto err;
@@ -438,11 +454,15 @@ int do_mathemu(struct pt_regs *regs, struct fpustate *f, bool illegal_insn_trap)
 		case FSUBQ: FP_SUB_Q (QR, QA, QB); break;
 		/* * */
 		case FMULS: FP_MUL_S (SR, SA, SB); break;
-		case FSMULD: FP_CONV (D, S, 1, 1, DA, SA);
-			     FP_CONV (D, S, 1, 1, DB, SB);
+		case FSMULD: FP_EXTEND (D, S, 1, 1, DA, SA);
+			     _FP_UNPACK_CANONICAL (D, 1, DA);
+			     FP_EXTEND (D, S, 1, 1, DB, SB);
+			     _FP_UNPACK_CANONICAL (D, 1, DB);
 		case FMULD: FP_MUL_D (DR, DA, DB); break;
-		case FDMULQ: FP_CONV (Q, D, 2, 1, QA, DA);
-			     FP_CONV (Q, D, 2, 1, QB, DB);
+		case FDMULQ: FP_EXTEND (Q, D, 2, 1, QA, DA);
+			     _FP_UNPACK_CANONICAL (Q, 2, QA);
+			     FP_EXTEND (Q, D, 2, 1, QB, DB);
+			     _FP_UNPACK_CANONICAL (Q, 2, QB);
 		case FMULQ: FP_MUL_Q (QR, QA, QB); break;
 		/* / */
 		case FDIVS: FP_DIV_S (SR, SA, SB); break;
@@ -457,41 +477,37 @@ int do_mathemu(struct pt_regs *regs, struct fpustate *f, bool illegal_insn_trap)
 		case FABSQ: rd->q[0] = rs2->q[0] & 0x7fffffffffffffffUL; rd->q[1] = rs2->q[1]; break;
 		case FNEGQ: rd->q[0] = rs2->q[0] ^ 0x8000000000000000UL; rd->q[1] = rs2->q[1]; break;
 		/* float to int */
-		case FSTOI: FP_TO_INT_S (IR, SB, 32, 1); break;
-		case FDTOI: FP_TO_INT_D (IR, DB, 32, 1); break;
-		case FQTOI: FP_TO_INT_Q (IR, QB, 32, 1); break;
-		case FSTOX: FP_TO_INT_S (XR, SB, 64, 1); break;
-		case FDTOX: FP_TO_INT_D (XR, DB, 64, 1); break;
-		case FQTOX: FP_TO_INT_Q (XR, QB, 64, 1); break;
+		case FSTOI: FP_TO_INT_S (UIR, SB, 32, 1); IR = UIR; break;
+		case FDTOI: FP_TO_INT_D (UIR, DB, 32, 1); IR = UIR; break;
+		case FQTOI: FP_TO_INT_Q (UIR, QB, 32, 1); IR = UIR; break;
+		case FSTOX: FP_TO_INT_S (UXR, SB, 64, 1); XR = UXR; break;
+		case FDTOX: FP_TO_INT_D (UXR, DB, 64, 1); XR = UXR; break;
+		case FQTOX: FP_TO_INT_Q (UXR, QB, 64, 1); XR = UXR; break;
 		/* int to float */
-		case FITOQ: IR = rs2->s; FP_FROM_INT_Q (QR, IR, 32, int); break;
-		case FXTOQ: XR = rs2->d; FP_FROM_INT_Q (QR, XR, 64, long); break;
+		case FITOQ: IR = rs2->s; FP_FROM_INT_Q (QR, IR, 32, unsigned int); break;
+		case FXTOQ: XR = rs2->d; FP_FROM_INT_Q (QR, XR, 64, unsigned long); break;
 		/* Only Ultra-III generates these */
-		case FXTOS: XR = rs2->d; FP_FROM_INT_S (SR, XR, 64, long); break;
-		case FXTOD: XR = rs2->d; FP_FROM_INT_D (DR, XR, 64, long); break;
+		case FXTOS: XR = rs2->d; FP_FROM_INT_S (SR, XR, 64, unsigned long); break;
+		case FXTOD: XR = rs2->d; FP_FROM_INT_D (DR, XR, 64, unsigned long); break;
 #if 0		/* Optimized inline in sparc64/kernel/entry.S */
-		case FITOS: IR = rs2->s; FP_FROM_INT_S (SR, IR, 32, int); break;
+		case FITOS: IR = rs2->s; FP_FROM_INT_S (SR, IR, 32, unsigned int); break;
 #endif
-		case FITOD: IR = rs2->s; FP_FROM_INT_D (DR, IR, 32, int); break;
+		case FITOD: IR = rs2->s; FP_FROM_INT_D (DR, IR, 32, unsigned int); break;
 		/* float to float */
-		case FSTOD: FP_CONV (D, S, 1, 1, DR, SB); break;
-		case FSTOQ: FP_CONV (Q, S, 2, 1, QR, SB); break;
-		case FDTOQ: FP_CONV (Q, D, 2, 1, QR, DB); break;
-		case FDTOS: FP_CONV (S, D, 1, 1, SR, DB); break;
-		case FQTOS: FP_CONV (S, Q, 1, 2, SR, QB); break;
-		case FQTOD: FP_CONV (D, Q, 1, 2, DR, QB); break;
+		case FSTOD: FP_EXTEND (D, S, 1, 1, DR, SB); break;
+		case FSTOQ: FP_EXTEND (Q, S, 2, 1, QR, SB); break;
+		case FDTOQ: FP_EXTEND (Q, D, 2, 1, QR, DB); break;
+		case FDTOS: FP_TRUNC (S, D, 1, 1, SR, DB); break;
+		case FQTOS: FP_TRUNC (S, Q, 1, 2, SR, QB); break;
+		case FQTOD: FP_TRUNC (D, Q, 1, 2, DR, QB); break;
 		/* comparison */
 		case FCMPQ:
 		case FCMPEQ:
-			FP_CMP_Q(XR, QB, QA, 3);
-			if (XR = 3 &&
-			    (((insn >> 5) & 0x1ff) = FCMPEQ ||
-			     FP_ISSIGNAN_Q(QA) ||
-			     FP_ISSIGNAN_Q(QB)))
-				FP_SET_EXCEPTION (FP_EX_INVALID);
+			FP_CMP_Q(XR, QB, QA, 3,
+				((insn >> 5) & 0x1ff) = FCMPEQ ? 2 : 1);
 		}
 		if (!FP_INHIBIT_RESULTS) {
-			switch ((type >> 6) & 0x7) {
+			switch ((type >> 8) & 0xf) {
 			case 0: xfsr = current_thread_info()->xfsr[0];
 				if (XR = -1) XR = 2;
 				switch (freg & 3) {
@@ -505,9 +521,15 @@ int do_mathemu(struct pt_regs *regs, struct fpustate *f, bool illegal_insn_trap)
 				break;
 			case 1: rd->s = IR; break;
 			case 2: rd->d = XR; break;
-			case 5: FP_PACK_SP (rd, SR); break;
-			case 6: FP_PACK_DP (rd, DR); break;
-			case 7: FP_PACK_QP (rd, QR); break;
+			case 5: FP_PACK_RAW_SP (rd, SR); break;
+			case 6: FP_PACK_RAW_DP (rd, DR); break;
+			case 7: FP_PACK_RAW_QP (rd, QR); break;
+			case 9: FP_PACK_SEMIRAW_SP (rd, SR); break;
+			case 10: FP_PACK_SEMIRAW_DP (rd, DR); break;
+			case 11: FP_PACK_SEMIRAW_QP (rd, QR); break;
+			case 13: FP_PACK_SP (rd, SR); break;
+			case 14: FP_PACK_DP (rd, DR); break;
+			case 15: FP_PACK_QP (rd, QR); break;
 			}
 		}
 


-- 
Joseph S. Myers
joseph@codesourcery.com
