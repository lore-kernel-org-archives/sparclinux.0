From: Joseph Myers <joseph@codesourcery.com>
Date: Tue, 19 May 2015 22:16:47 +0000
Subject: [PATCH] Update kernel math-emu code from current glibc soft-fp
Message-Id: <alpine.DEB.2.10.1505192206580.28384@digraph.polyomino.org.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

From: Joseph Myers <joseph@codesourcery.com>

The include/math-emu code (used for alpha powerpc sh sparc, and to a
very limited extent for s390) was taken from an old version of glibc's
soft-fp code around 15 years ago (in the pre-git era, anyway, and some
of the initial code may have been developed around 1997-9 with a view
to being used in both places).  Since then, there have only been a
handful of small changes in the kernel version, while the glibc
version has been extensively developed, with many bug fixes,
performance improvements and miscellaneous cleanups, and is also now
used in libgcc, including for __float128 on x86_64 since GCC 4.3 (see
<https://ols.fedoraproject.org/GCC/Reprints-2006/sidwell-reprint.pdf>
for more information regarding performance improvements and use in
libgcc).

Thus the kernel version is missing those various improvements and it
would make sense to update it to include them (as was noted back in
2006 <https://sourceware.org/ml/libc-alpha/2006-02/msg00075.html> when
a large group of changes went into glibc).  I believe it also makes
sense to aim to have *exactly* the same code in both places to
simplify future updates of the kernel version.  (And in particular, as
external code imported largely verbatim into the kernel,
include/math-emu has never followed the kernel coding style and it
doesn't make sense for it to do so.)

I made an analysis of what kernel-local changes there were to this
code in <https://sourceware.org/ml/libc-alpha/2013-10/msg00345.html>,
and since then have added the various missing features to the glibc
version so that it is feature-complete regarding features used in the
kernel and so that exactly the same code is usable in both places.
This patch updates the include/math-emu code, and its kernel users, so
that the shared code is identical to glibc's current soft-fp code.

Regarding what testing seems appropriate for this patch, see my notes
in <https://sourceware.org/ml/libc-alpha/2015-02/msg00107.html>.  I've
done that testing for powerpc (both e500 and emulation of classic hard
float).  For reports of testing on other architectures, see
<https://sourceware.org/ml/libc-alpha/2015-05/msg00372.html> (alpha),
<https://sourceware.org/ml/libc-alpha/2015-04/msg00154.html> (s390),
<http://marc.info/?l=linux-sh&m2440262415395&w=2> (sh),
<http://marc.info/?l=linux-sparc&m2437304707509&w=2> (sparc); the
fixes indicated in those reports as needed on particular architectures
have been integrated into this version.

The bulk of the changes are updating the code from glibc, and a
detailed review of that part probably does not make sense in this
context if you want to aim for the same code in both places.  The
trickier part is the architecture updates for the various API changes
in soft-fp since the version used by the kernel.  The following
changes have occurred in the soft-fp API since the version used in the
kernel and so are addressed in the architecture updates in this patch.
(This list only includes changes relating to features used in the
kernel, not pure new features that aren't relevant to updating
existing code, and not pure bug fixes.)

* <https://sourceware.org/ml/libc-alpha/2006-02/msg00028.html>

  - Semi-raw unpacking is added, as something intermediate between raw
    and cooked unpacking, for efficiency.

  - Addition and subtraction are changed to work on semi-raw values.
    Thus, cooked results of multiplication can't be passed directly
    into addition, as was done in some kernel emulations of fused
    multiply-add, but that isn't a proper fused operation anyway (a
    proper fused operation involves using the unrounded multiplication
    result in twice the input precision, not an intermediate value in
    input precision plus three working bits); the appropriate fix is
    to use the new fused multiply-add support in soft-fp.

  - Conversions from one floating-point type to another now use
    FP_EXTEND (raw) and FP_TRUNC (semi-raw) instead of FP_CONV
    (cooked).  Those operations now deal with quieting signaling NaNs.

  - Conversions from floating-point to integer now use raw inputs, and
    require the integer variable passed to the FP_TO_INT macros to
    have unsigned type.

  - Conversions from integer to floating-point now use raw outputs.

* <https://sourceware.org/ml/libc-alpha/2006-02/msg00044.html>

  - Conversions from integer to floating-point now pass the name of an
    unsigned type to the FP_FROM_INT macros, not a signed type to
    which "unsigned" is added in the macro definition.

* <https://sourceware.org/ml/libc-alpha/2013-04/msg00646.html>

  - soft-fp supports the reversed quiet NaN convention used on MIPS
    and HPPA; sfp-machine.h must define _FP_QNANNEGATEDP (to 0, for
    architectures using the normal convention; to 1, for architectures
    using the MIPS convention).

* <https://sourceware.org/ml/libc-alpha/2013-10/msg00348.html>

  - Negation now works on raw values.

* <https://sourceware.org/ml/libc-alpha/2014-02/msg00068.html>

  - soft-fp now supports after-rounding tininess detection for
    architectures where that is the defined way in which tiny results
    are detected (of the architectures for which the Linux kernel uses
    this code, that's Alpha and SH).  sfp-machine.h must define
    _FP_TININESS_AFTER_ROUNDING to either 0 or 1.

* <https://sourceware.org/ml/libc-alpha/2014-09/msg00411.html>

  - FP_CLEAR_EXCEPTIONS is removed; all uses in the Linux kernel are
    no longer needed as, now unpacking only occurs in the correct
    format, exceptions are already clear at that point.

* <https://sourceware.org/ml/libc-alpha/2014-09/msg00461.html>

  - The FP_CMP macros have an extra argument to specify when
    exceptions should be set (0 for no exception setting, 1 for
    exceptions only for signaling NaNs, 2 for exceptions for all
    NaNs).  In the old version in the kernel, it was necessary for the
    caller to handle all exception setting for comparisons.

* <https://sourceware.org/ml/libc-alpha/2014-09/msg00488.html>

  - FP_DENORM_ZERO does not set "inexact" when flushing to zero, as
    that does not appear to match the documented semantics for either
    of the architectures (Alpha and SH) for which the kernel uses
    FP_DENORM_ZERO.  FP_DENORM_ZERO is also checked for comparisons
    (the documentation for both Alpha and SH is explicit that their
    corresponding control bits do apply to comparisons).

* <https://sourceware.org/ml/libc-alpha/2014-09/msg00462.html>

  - The more precise FP_EX_INVALID_* exceptions include more cases
    than in the kernel version (in particular, FP_EX_INVALID_IMZ_FMA
    is split out from FP_EX_INVALID_IMZ, so if only the latter is
    defined then fma using the new fma support would not raise that
    exception any more - except that this doesn't actually affect
    powerpc because it hardcodes setting various exceptions in
    powerpc-specific code despite also defining FP_EX_INVALID_*).

Generally this patch only does cleanups and bug fixes to
architecture-specific code when they are closely connected to API
changes in the new code (either required by such API changes, or the
new API means the idiomatic way to do something has changed).  Where
something was already odd with the old version of the code, or
apparently did not match documented instruction set semantics, it's
not changed if that seems unconnected to the update from glibc.  I've
noted various such cases (especially for powerpc) that may be
addressed in followup patch series once the main upgrade is in (or,
where the fix seems more complicated and difficult to fix without
convenient access to the architecture for testing, I may just list the
issues on the relevant architecture mailing list).

The following architecture-specific cleanups or bug fixes (that might
change how the emulation behaves, or that go beyond mechanical
conversion to new APIs) are included in this patch because of their
close connection to the API changes:

* Alpha and SH now use after-rounding tininess detection.

* On Alpha, extensions from single to double now use FP_EXTEND with
  raw unpacking instead of the previous hardcoded code with cooked
  unpacking; these should be equivalent and the new code, with the
  optimizations in FP_EXTEND relative to the old FP_CONV, should be as
  efficient as the previous hardcoded code.

* On PowerPC and SH, fused multiply-add operations now use the new
  soft-fp fma support (meaning they are properly fused rather than
  only having 3 extra bits precision on the intermediate result of the
  multiplication).

* On PowerPC for SPE floating-point emulation, the pre-existing bug of
  comparisons using cooked unpacking is fixed (as the structure of the
  code meant unpacking types naturally needed specifying explicitly
  for all operations).  This should not in fact change how the
  emulation behaves, other than making it more efficient.  Various
  operations that should not have unpacked at all now no longer unpack
  instead of using cooked unpacking, so avoiding spurious exceptions
  on signaling NaNs (on the other case of arguments that are actually
  a different floating-point type but would wrongly be interpreted as
  signaling NaNs by the unpacking, FP_CLEAR_EXCEPTIONS may have
  avoided the issue).

* On SPARC, comparisons now use raw unpacking (this should not in fact
  change how the emulation behaves, just make it more efficient).

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

---

diff --git a/arch/alpha/include/asm/sfp-machine.h b/arch/alpha/include/asm/sfp-machine.h
index 5fe63af..96c266a 100644
--- a/arch/alpha/include/asm/sfp-machine.h
+++ b/arch/alpha/include/asm/sfp-machine.h
@@ -48,6 +48,7 @@
 #define _FP_NANSIGN_Q		1
 
 #define _FP_KEEPNANFRACP 1
+#define _FP_QNANNEGATEDP 0
 
 /* Alpha Architecture Handbook, 4.7.10.4 sais that
  * we should prefer any type of NaN in Fb, then Fa.
@@ -79,4 +80,6 @@
 /* We write the results always */
 #define FP_INHIBIT_RESULTS 0
 
+#define _FP_TININESS_AFTER_ROUNDING 1
+
 #endif
diff --git a/arch/alpha/math-emu/math.c b/arch/alpha/math-emu/math.c
index 58c2669..1fdb122 100644
--- a/arch/alpha/math-emu/math.c
+++ b/arch/alpha/math-emu/math.c
@@ -127,17 +127,27 @@ alpha_fp_emul (unsigned long pc)
 		va = alpha_read_fp_reg_s(fa);
 		vb = alpha_read_fp_reg_s(fb);
 		
-		FP_UNPACK_SP(SA, &va);
-		FP_UNPACK_SP(SB, &vb);
+		switch (func) {
+		case FOP_FNC_SUBx:
+		case FOP_FNC_ADDx:
+			FP_UNPACK_SEMIRAW_SP(SA, &va);
+			FP_UNPACK_SEMIRAW_SP(SB, &vb);
+			break;
+
+		default:
+			FP_UNPACK_SP(SA, &va);
+			FP_UNPACK_SP(SB, &vb);
+			break;
+		}
 
 		switch (func) {
 		case FOP_FNC_SUBx:
 			FP_SUB_S(SR, SA, SB);
-			goto pack_s;
+			goto pack_semiraw_s;
 
 		case FOP_FNC_ADDx:
 			FP_ADD_S(SR, SA, SB);
-			goto pack_s;
+			goto pack_semiraw_s;
 
 		case FOP_FNC_MULx:
 			FP_MUL_S(SR, SA, SB);
@@ -160,26 +170,10 @@ alpha_fp_emul (unsigned long pc)
 		if ((func & ~3) = FOP_FNC_CMPxUN) {
 			FP_UNPACK_RAW_DP(DA, &va);
 			FP_UNPACK_RAW_DP(DB, &vb);
-			if (!DA_e && !_FP_FRAC_ZEROP_1(DA)) {
-				FP_SET_EXCEPTION(FP_EX_DENORM);
-				if (FP_DENORM_ZERO)
-					_FP_FRAC_SET_1(DA, _FP_ZEROFRAC_1);
-			}
-			if (!DB_e && !_FP_FRAC_ZEROP_1(DB)) {
-				FP_SET_EXCEPTION(FP_EX_DENORM);
-				if (FP_DENORM_ZERO)
-					_FP_FRAC_SET_1(DB, _FP_ZEROFRAC_1);
-			}
-			FP_CMP_D(res, DA, DB, 3);
-			vc = 0x4000000000000000UL;
 			/* CMPTEQ, CMPTUN don't trap on QNaN,
 			   while CMPTLT and CMPTLE do */
-			if (res = 3
-			    && ((func & 3) >= 2
-				|| FP_ISSIGNAN_D(DA)
-				|| FP_ISSIGNAN_D(DB))) {
-				FP_SET_EXCEPTION(FP_EX_INVALID);
-			}
+			FP_CMP_D(res, DA, DB, 3, (func & 3) >= 2 ? 2 : 1);
+			vc = 0x4000000000000000UL;
 			switch (func) {
 			case FOP_FNC_CMPxUN: if (res != 3) vc = 0; break;
 			case FOP_FNC_CMPxEQ: if (res) vc = 0; break;
@@ -189,55 +183,64 @@ alpha_fp_emul (unsigned long pc)
 			goto done_d;
 		}
 
-		FP_UNPACK_DP(DA, &va);
-		FP_UNPACK_DP(DB, &vb);
-
 		switch (func) {
 		case FOP_FNC_SUBx:
-			FP_SUB_D(DR, DA, DB);
-			goto pack_d;
-
 		case FOP_FNC_ADDx:
-			FP_ADD_D(DR, DA, DB);
-			goto pack_d;
-
-		case FOP_FNC_MULx:
-			FP_MUL_D(DR, DA, DB);
-			goto pack_d;
-
-		case FOP_FNC_DIVx:
-			FP_DIV_D(DR, DA, DB);
-			goto pack_d;
-
-		case FOP_FNC_SQRTx:
-			FP_SQRT_D(DR, DB);
-			goto pack_d;
+			FP_UNPACK_SEMIRAW_DP(DA, &va);
+			FP_UNPACK_SEMIRAW_DP(DB, &vb);
+			break;
 
 		case FOP_FNC_CVTxS:
 			/* It is irritating that DEC encoded CVTST with
 			   SRC = T_floating.  It is also interesting that
 			   the bit used to tell the two apart is /U... */
 			if (insn & 0x2000) {
-				FP_CONV(S,D,1,1,SR,DB);
-				goto pack_s;
+				FP_UNPACK_SEMIRAW_DP(DB, &vb);
+				FP_TRUNC(S,D,1,1,SR,DB);
+				goto pack_semiraw_s;
 			} else {
 				vb = alpha_read_fp_reg_s(fb);
-				FP_UNPACK_SP(SB, &vb);
-				DR_c = DB_c;
-				DR_s = DB_s;
-				DR_e = DB_e + (1024 - 128);
-				DR_f = SB_f << (52 - 23);
-				goto pack_d;
+				FP_UNPACK_RAW_SP(SB, &vb);
+				FP_EXTEND(D,S,1,1,DR,SB);
+				goto pack_raw_d;
 			}
 
 		case FOP_FNC_CVTxQ:
-			if (DB_c = FP_CLS_NAN
+			FP_UNPACK_RAW_DP(DB, &vb);
+			if (DB_e = _FP_EXPMAX_D
 			    && (_FP_FRAC_HIGH_RAW_D(DB) & _FP_QNANBIT_D)) {
 			  /* AAHB Table B-2 says QNaN should not trigger INV */
 				vc = 0;
 			} else
 				FP_TO_INT_ROUND_D(vc, DB, 64, 2);
 			goto done_d;
+
+		default:
+			FP_UNPACK_DP(DA, &va);
+			FP_UNPACK_DP(DB, &vb);
+			break;
+		}
+
+		switch (func) {
+		case FOP_FNC_SUBx:
+			FP_SUB_D(DR, DA, DB);
+			goto pack_semiraw_d;
+
+		case FOP_FNC_ADDx:
+			FP_ADD_D(DR, DA, DB);
+			goto pack_semiraw_d;
+
+		case FOP_FNC_MULx:
+			FP_MUL_D(DR, DA, DB);
+			goto pack_d;
+
+		case FOP_FNC_DIVx:
+			FP_DIV_D(DR, DA, DB);
+			goto pack_d;
+
+		case FOP_FNC_SQRTx:
+			FP_SQRT_D(DR, DB);
+			goto pack_d;
 		}
 		goto bad_insn;
 
@@ -256,26 +259,44 @@ alpha_fp_emul (unsigned long pc)
 			goto done_d;
 
 		case FOP_FNC_CVTxS:
-			FP_FROM_INT_S(SR, ((long)vb), 64, long);
-			goto pack_s;
+			FP_FROM_INT_S(SR, ((long)vb), 64, unsigned long);
+			goto pack_raw_s;
 
 		case FOP_FNC_CVTxT:
-			FP_FROM_INT_D(DR, ((long)vb), 64, long);
-			goto pack_d;
+			FP_FROM_INT_D(DR, ((long)vb), 64, unsigned long);
+			goto pack_raw_d;
 		}
 		goto bad_insn;
 	}
 	goto bad_insn;
 
+pack_raw_s:
+	FP_PACK_RAW_SP(&vc, SR);
+	goto packed_s;
+
+pack_semiraw_s:
+	FP_PACK_SEMIRAW_SP(&vc, SR);
+	goto packed_s;
+
 pack_s:
 	FP_PACK_SP(&vc, SR);
+packed_s:
 	if ((_fex & FP_EX_UNDERFLOW) && (swcr & IEEE_MAP_UMZ))
 		vc = 0;
 	alpha_write_fp_reg_s(fc, vc);
 	goto done;
 
+pack_raw_d:
+	FP_PACK_RAW_DP(&vc, DR);
+	goto packed_d;
+
+pack_semiraw_d:
+	FP_PACK_SEMIRAW_DP(&vc, DR);
+	goto packed_d;
+
 pack_d:
 	FP_PACK_DP(&vc, DR);
+packed_d:
 	if ((_fex & FP_EX_UNDERFLOW) && (swcr & IEEE_MAP_UMZ))
 		vc = 0;
 done_d:
diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/include/asm/sfp-machine.h
index d89beab..607ee14 100644
--- a/arch/powerpc/include/asm/sfp-machine.h
+++ b/arch/powerpc/include/asm/sfp-machine.h
@@ -82,6 +82,9 @@
 #define _FP_MUL_MEAT_S(R,X,Y)   _FP_MUL_MEAT_1_wide(_FP_WFRACBITS_S,R,X,Y,umul_ppmm)
 #define _FP_MUL_MEAT_D(R,X,Y)   _FP_MUL_MEAT_2_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
 
+#define _FP_MUL_MEAT_DW_S(R,X,Y)   _FP_MUL_MEAT_DW_1_wide(_FP_WFRACBITS_S,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_DW_D(R,X,Y)   _FP_MUL_MEAT_DW_2_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
+
 #define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_udiv_norm(S,R,X,Y)
 #define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_2_udiv(D,R,X,Y)
 
@@ -96,6 +99,7 @@
 #define _FP_NANSIGN_Q		0
 
 #define _FP_KEEPNANFRACP 1
+#define _FP_QNANNEGATEDP 0
 
 #ifdef FP_EX_BOOKE_E500_SPE
 #define FP_EX_INEXACT		(1 << 21)
@@ -178,15 +182,40 @@
 		_FP_PACK_RAW_2_P(D, val, X);				\
    } while (0)
 
+#define __FP_PACK_SEMIRAW_D(val,X)			\
+   do {									\
+	_FP_PACK_SEMIRAW(D, 2, X);					\
+	if (!FP_CUR_EXCEPTIONS || !__FPU_TRAP_P(FP_CUR_EXCEPTIONS))	\
+		_FP_PACK_RAW_2_P(D, val, X);				\
+   } while (0)
+
 #define __FP_PACK_DS(val,X)							\
    do {										\
 	   FP_DECL_S(__X);							\
-	   FP_CONV(S, D, 1, 2, __X, X);						\
+	   if (X##_c != FP_CLS_NAN)						\
+		   _FP_FRAC_SRS_2(X, _FP_WFRACBITS_D - _FP_WFRACBITS_S,		\
+			   _FP_WFRACBITS_D);					\
+	   else									\
+		   _FP_FRAC_SRL_2(X, _FP_WFRACBITS_D - _FP_WFRACBITS_S);	\
+	   _FP_FRAC_COPY_1_2(__X, X);						\
+	   __X##_e = X##_e;							\
+	   __X##_c = X##_c;							\
+	   __X##_s = X##_s;							\
 	   _FP_PACK_CANONICAL(S, 1, __X);					\
 	   if (!FP_CUR_EXCEPTIONS || !__FPU_TRAP_P(FP_CUR_EXCEPTIONS)) {	\
-		   _FP_UNPACK_CANONICAL(S, 1, __X);				\
-		   FP_CONV(D, S, 2, 1, X, __X);					\
-		   _FP_PACK_CANONICAL(D, 2, X);					\
+		   FP_EXTEND(D, S, 2, 1, X, __X);				\
+		   if (!FP_CUR_EXCEPTIONS || !__FPU_TRAP_P(FP_CUR_EXCEPTIONS))	\
+		   _FP_PACK_RAW_2_P(D, val, X);					\
+	   }									\
+   } while (0)
+
+#define __FP_PACK_SEMIRAW_DS(val,X)						\
+   do {										\
+	   FP_DECL_S(__X);							\
+	   FP_TRUNC(S, D, 1, 2, __X, X);					\
+	   _FP_PACK_SEMIRAW(S, 1, __X);						\
+	   if (!FP_CUR_EXCEPTIONS || !__FPU_TRAP_P(FP_CUR_EXCEPTIONS)) {	\
+		   FP_EXTEND(D, S, 2, 1, X, __X);				\
 		   if (!FP_CUR_EXCEPTIONS || !__FPU_TRAP_P(FP_CUR_EXCEPTIONS))	\
 		   _FP_PACK_RAW_2_P(D, val, X);					\
 	   }									\
@@ -198,6 +227,8 @@
 	__FPU_FPSCR & 0x3;		\
 })
 
+#define _FP_TININESS_AFTER_ROUNDING 0
+
 /* the asm fragments go here: all these are taken from glibc-2.0.5's
  * stdlib/longlong.h
  */
diff --git a/arch/powerpc/math-emu/fadd.c b/arch/powerpc/math-emu/fadd.c
index 0158a16..6deb27a 100644
--- a/arch/powerpc/math-emu/fadd.c
+++ b/arch/powerpc/math-emu/fadd.c
@@ -18,8 +18,8 @@ fadd(void *frD, void *frA, void *frB)
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
 #endif
 
-	FP_UNPACK_DP(A, frA);
-	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_SEMIRAW_DP(A, frA);
+	FP_UNPACK_SEMIRAW_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -32,7 +32,7 @@ fadd(void *frD, void *frA, void *frB)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	__FP_PACK_D(frD, R);
+	__FP_PACK_SEMIRAW_D(frD, R);
 
 	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fadds.c b/arch/powerpc/math-emu/fadds.c
index 5930f40..9e2fb9e 100644
--- a/arch/powerpc/math-emu/fadds.c
+++ b/arch/powerpc/math-emu/fadds.c
@@ -19,8 +19,8 @@ fadds(void *frD, void *frA, void *frB)
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
 #endif
 
-	FP_UNPACK_DP(A, frA);
-	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_SEMIRAW_DP(A, frA);
+	FP_UNPACK_SEMIRAW_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -33,7 +33,7 @@ fadds(void *frD, void *frA, void *frB)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	__FP_PACK_DS(frD, R);
+	__FP_PACK_SEMIRAW_DS(frD, R);
 
 	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fcmpo.c b/arch/powerpc/math-emu/fcmpo.c
index 5bce011..8ebdb28 100644
--- a/arch/powerpc/math-emu/fcmpo.c
+++ b/arch/powerpc/math-emu/fcmpo.c
@@ -30,7 +30,7 @@ fcmpo(u32 *ccr, int crfD, void *frA, void *frB)
 	if (A_c = FP_CLS_NAN || B_c = FP_CLS_NAN)
 		FP_SET_EXCEPTION(EFLAG_VXVC);
 
-	FP_CMP_D(cmp, A, B, 2);
+	FP_CMP_D(cmp, A, B, 2, 0);
 	cmp = code[(cmp + 1) & 3];
 
 	__FPU_FPSCR &= ~(0x1f000);
diff --git a/arch/powerpc/math-emu/fcmpu.c b/arch/powerpc/math-emu/fcmpu.c
index d4fb1ba..3b385c6 100644
--- a/arch/powerpc/math-emu/fcmpu.c
+++ b/arch/powerpc/math-emu/fcmpu.c
@@ -27,7 +27,7 @@ fcmpu(u32 *ccr, int crfD, void *frA, void *frB)
 	printk("B: %ld %lu %lu %ld (%ld)\n", B_s, B_f1, B_f0, B_e, B_c);
 #endif
 
-	FP_CMP_D(cmp, A, B, 2);
+	FP_CMP_D(cmp, A, B, 2, 0);
 	cmp = code[(cmp + 1) & 3];
 
 	__FPU_FPSCR &= ~(0x1f000);
diff --git a/arch/powerpc/math-emu/fctiw.c b/arch/powerpc/math-emu/fctiw.c
index f694440..9d7c7c9 100644
--- a/arch/powerpc/math-emu/fctiw.c
+++ b/arch/powerpc/math-emu/fctiw.c
@@ -13,7 +13,7 @@ fctiw(u32 *frD, void *frB)
 	FP_DECL_EX;
 	unsigned int r;
 
-	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_RAW_DP(B, frB);
 	FP_TO_INT_D(r, B, 32, 1);
 	frD[1] = r;
 
diff --git a/arch/powerpc/math-emu/fctiwz.c b/arch/powerpc/math-emu/fctiwz.c
index 71e782f..d55b3e7 100644
--- a/arch/powerpc/math-emu/fctiwz.c
+++ b/arch/powerpc/math-emu/fctiwz.c
@@ -18,7 +18,7 @@ fctiwz(u32 *frD, void *frB)
 	__FPU_FPSCR &= ~(3);
 	__FPU_FPSCR |= FP_RND_ZERO;
 
-	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_RAW_DP(B, frB);
 	FP_TO_INT_D(r, B, 32, 1);
 	frD[1] = r;
 
diff --git a/arch/powerpc/math-emu/fmadd.c b/arch/powerpc/math-emu/fmadd.c
index 8c3f20a..0f450fb 100644
--- a/arch/powerpc/math-emu/fmadd.c
+++ b/arch/powerpc/math-emu/fmadd.c
@@ -13,7 +13,6 @@ fmadd(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
-	FP_DECL_D(T);
 	FP_DECL_EX;
 
 #ifdef DEBUG
@@ -34,12 +33,7 @@ fmadd(void *frD, void *frA, void *frB, void *frC)
 	    (A_c = FP_CLS_ZERO && C_c = FP_CLS_INF))
                 FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
-	FP_MUL_D(T, A, C);
-
-	if (T_s != B_s && T_c = FP_CLS_INF && B_c = FP_CLS_INF)
-		FP_SET_EXCEPTION(EFLAG_VXISI);
-
-	FP_ADD_D(R, T, B);
+	FP_FMA_D(R, A, C, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
diff --git a/arch/powerpc/math-emu/fmadds.c b/arch/powerpc/math-emu/fmadds.c
index 794fb31..79885eb 100644
--- a/arch/powerpc/math-emu/fmadds.c
+++ b/arch/powerpc/math-emu/fmadds.c
@@ -14,7 +14,6 @@ fmadds(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
-	FP_DECL_D(T);
 	FP_DECL_EX;
 
 #ifdef DEBUG
@@ -35,12 +34,7 @@ fmadds(void *frD, void *frA, void *frB, void *frC)
 	    (A_c = FP_CLS_ZERO && C_c = FP_CLS_INF))
                 FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
-	FP_MUL_D(T, A, C);
-
-	if (T_s != B_s && T_c = FP_CLS_INF && B_c = FP_CLS_INF)
-		FP_SET_EXCEPTION(EFLAG_VXISI);
-
-	FP_ADD_D(R, T, B);
+	FP_FMA_D(R, A, C, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
diff --git a/arch/powerpc/math-emu/fmsub.c b/arch/powerpc/math-emu/fmsub.c
index 626f6fe..ee2385d 100644
--- a/arch/powerpc/math-emu/fmsub.c
+++ b/arch/powerpc/math-emu/fmsub.c
@@ -13,7 +13,6 @@ fmsub(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
-	FP_DECL_D(T);
 	FP_DECL_EX;
 
 #ifdef DEBUG
@@ -34,15 +33,10 @@ fmsub(void *frD, void *frA, void *frB, void *frC)
 	    (A_c = FP_CLS_ZERO && C_c = FP_CLS_INF))
 		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
-	FP_MUL_D(T, A, C);
-
 	if (B_c != FP_CLS_NAN)
 		B_s ^= 1;
 
-	if (T_s != B_s && T_c = FP_CLS_INF && B_c = FP_CLS_INF)
-		FP_SET_EXCEPTION(EFLAG_VXISI);
-
-	FP_ADD_D(R, T, B);
+	FP_FMA_D(R, A, C, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
diff --git a/arch/powerpc/math-emu/fmsubs.c b/arch/powerpc/math-emu/fmsubs.c
index 3425bc8..fe081c0 100644
--- a/arch/powerpc/math-emu/fmsubs.c
+++ b/arch/powerpc/math-emu/fmsubs.c
@@ -14,7 +14,6 @@ fmsubs(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
-	FP_DECL_D(T);
 	FP_DECL_EX;
 
 #ifdef DEBUG
@@ -35,15 +34,10 @@ fmsubs(void *frD, void *frA, void *frB, void *frC)
 	    (A_c = FP_CLS_ZERO && C_c = FP_CLS_INF))
 		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
-	FP_MUL_D(T, A, C);
-
 	if (B_c != FP_CLS_NAN)
 		B_s ^= 1;
 
-	if (T_s != B_s && T_c = FP_CLS_INF && B_c = FP_CLS_INF)
-		FP_SET_EXCEPTION(EFLAG_VXISI);
-
-	FP_ADD_D(R, T, B);
+	FP_FMA_D(R, A, C, B);
 
 #ifdef DEBUG
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
diff --git a/arch/powerpc/math-emu/fnmadd.c b/arch/powerpc/math-emu/fnmadd.c
index e817bc5..330353e6 100644
--- a/arch/powerpc/math-emu/fnmadd.c
+++ b/arch/powerpc/math-emu/fnmadd.c
@@ -13,7 +13,6 @@ fnmadd(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
-	FP_DECL_D(T);
 	FP_DECL_EX;
 
 #ifdef DEBUG
@@ -34,12 +33,7 @@ fnmadd(void *frD, void *frA, void *frB, void *frC)
 	    (A_c = FP_CLS_ZERO && C_c = FP_CLS_INF))
                 FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
-	FP_MUL_D(T, A, C);
-
-	if (T_s != B_s && T_c = FP_CLS_INF && B_c = FP_CLS_INF)
-		FP_SET_EXCEPTION(EFLAG_VXISI);
-
-	FP_ADD_D(R, T, B);
+	FP_FMA_D(R, A, C, B);
 
 	if (R_c != FP_CLS_NAN)
 		R_s ^= 1;
diff --git a/arch/powerpc/math-emu/fnmadds.c b/arch/powerpc/math-emu/fnmadds.c
index 4db4b7d..dd27045 100644
--- a/arch/powerpc/math-emu/fnmadds.c
+++ b/arch/powerpc/math-emu/fnmadds.c
@@ -14,7 +14,6 @@ fnmadds(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
-	FP_DECL_D(T);
 	FP_DECL_EX;
 
 #ifdef DEBUG
@@ -35,12 +34,7 @@ fnmadds(void *frD, void *frA, void *frB, void *frC)
 	    (A_c = FP_CLS_ZERO && C_c = FP_CLS_INF))
                 FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
-	FP_MUL_D(T, A, C);
-
-	if (T_s != B_s && T_c = FP_CLS_INF && B_c = FP_CLS_INF)
-		FP_SET_EXCEPTION(EFLAG_VXISI);
-
-	FP_ADD_D(R, T, B);
+	FP_FMA_D(R, A, C, B);
 
 	if (R_c != FP_CLS_NAN)
 		R_s ^= 1;
diff --git a/arch/powerpc/math-emu/fnmsub.c b/arch/powerpc/math-emu/fnmsub.c
index f65979f..87c8b4c 100644
--- a/arch/powerpc/math-emu/fnmsub.c
+++ b/arch/powerpc/math-emu/fnmsub.c
@@ -13,7 +13,6 @@ fnmsub(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
-	FP_DECL_D(T);
 	FP_DECL_EX;
 
 #ifdef DEBUG
@@ -34,15 +33,10 @@ fnmsub(void *frD, void *frA, void *frB, void *frC)
 	    (A_c = FP_CLS_ZERO && C_c = FP_CLS_INF))
 		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
-	FP_MUL_D(T, A, C);
-
 	if (B_c != FP_CLS_NAN)
 		B_s ^= 1;
 
-	if (T_s != B_s && T_c = FP_CLS_INF && B_c = FP_CLS_INF)
-		FP_SET_EXCEPTION(EFLAG_VXISI);
-
-	FP_ADD_D(R, T, B);
+	FP_FMA_D(R, A, C, B);
 
 	if (R_c != FP_CLS_NAN)
 		R_s ^= 1;
diff --git a/arch/powerpc/math-emu/fnmsubs.c b/arch/powerpc/math-emu/fnmsubs.c
index 9021dac..72b860b 100644
--- a/arch/powerpc/math-emu/fnmsubs.c
+++ b/arch/powerpc/math-emu/fnmsubs.c
@@ -14,7 +14,6 @@ fnmsubs(void *frD, void *frA, void *frB, void *frC)
 	FP_DECL_D(A);
 	FP_DECL_D(B);
 	FP_DECL_D(C);
-	FP_DECL_D(T);
 	FP_DECL_EX;
 
 #ifdef DEBUG
@@ -35,15 +34,10 @@ fnmsubs(void *frD, void *frA, void *frB, void *frC)
 	    (A_c = FP_CLS_ZERO && C_c = FP_CLS_INF))
 		FP_SET_EXCEPTION(EFLAG_VXIMZ);
 
-	FP_MUL_D(T, A, C);
-
 	if (B_c != FP_CLS_NAN)
 		B_s ^= 1;
 
-	if (T_s != B_s && T_c = FP_CLS_INF && B_c = FP_CLS_INF)
-		FP_SET_EXCEPTION(EFLAG_VXISI);
-
-	FP_ADD_D(R, T, B);
+	FP_FMA_D(R, A, C, B);
 
 	if (R_c != FP_CLS_NAN)
 		R_s ^= 1;
diff --git a/arch/powerpc/math-emu/fsub.c b/arch/powerpc/math-emu/fsub.c
index 02c5dff..8070976 100644
--- a/arch/powerpc/math-emu/fsub.c
+++ b/arch/powerpc/math-emu/fsub.c
@@ -18,8 +18,8 @@ fsub(void *frD, void *frA, void *frB)
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
 #endif
 
-	FP_UNPACK_DP(A, frA);
-	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_SEMIRAW_DP(A, frA);
+	FP_UNPACK_SEMIRAW_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -38,7 +38,7 @@ fsub(void *frD, void *frA, void *frB)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	__FP_PACK_D(frD, R);
+	__FP_PACK_SEMIRAW_D(frD, R);
 
 	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/fsubs.c b/arch/powerpc/math-emu/fsubs.c
index 5d9b18c..5b96755 100644
--- a/arch/powerpc/math-emu/fsubs.c
+++ b/arch/powerpc/math-emu/fsubs.c
@@ -19,8 +19,8 @@ fsubs(void *frD, void *frA, void *frB)
 	printk("%s: %p %p %p\n", __func__, frD, frA, frB);
 #endif
 
-	FP_UNPACK_DP(A, frA);
-	FP_UNPACK_DP(B, frB);
+	FP_UNPACK_SEMIRAW_DP(A, frA);
+	FP_UNPACK_SEMIRAW_DP(B, frB);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
@@ -39,7 +39,7 @@ fsubs(void *frD, void *frA, void *frB)
 	printk("D: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	__FP_PACK_DS(frD, R);
+	__FP_PACK_SEMIRAW_DS(frD, R);
 
 	return FP_CUR_EXCEPTIONS;
 }
diff --git a/arch/powerpc/math-emu/lfs.c b/arch/powerpc/math-emu/lfs.c
index 434ed27..16da2c2 100644
--- a/arch/powerpc/math-emu/lfs.c
+++ b/arch/powerpc/math-emu/lfs.c
@@ -22,25 +22,20 @@ lfs(void *frD, void *ea)
 	if (copy_from_user(&f, ea, sizeof(float)))
 		return -EFAULT;
 
-	FP_UNPACK_S(A, f);
+	FP_UNPACK_RAW_S(A, f);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %ld (%ld) [%08lx]\n", A_s, A_f, A_e, A_c,
 	       *(unsigned long *)&f);
 #endif
 
-	FP_CONV(D, S, 2, 1, R, A);
+	_FP_EXTEND_CNAN(D, S, 2, 1, R, A, 0);
 
 #ifdef DEBUG
 	printk("R: %ld %lu %lu %ld (%ld)\n", R_s, R_f1, R_f0, R_e, R_c);
 #endif
 
-	if (R_c = FP_CLS_NAN) {
-		R_e = _FP_EXPMAX_D;
-		_FP_PACK_RAW_2_P(D, frD, R);
-	} else {
-		__FP_PACK_D(frD, R);
-	}
+	FP_PACK_RAW_DP(frD, R);
 
 	return 0;
 }
diff --git a/arch/powerpc/math-emu/math_efp.c b/arch/powerpc/math-emu/math_efp.c
index 28337c9..833394c 100644
--- a/arch/powerpc/math-emu/math_efp.c
+++ b/arch/powerpc/math-emu/math_efp.c
@@ -99,6 +99,11 @@
 #define XB	4
 #define XCR	5
 #define NOTYPE	0
+#define TYPE_MASK	7
+#define UNONE	0
+#define URAW	8
+#define USEMI	16
+#define UCOOK	24
 
 #define SIGN_BIT_S	(1UL << 31)
 #define SIGN_BIT_D	(1ULL << 63)
@@ -114,64 +119,64 @@ union dw_union {
 
 static unsigned long insn_type(unsigned long speinsn)
 {
-	unsigned long ret = NOTYPE;
+	unsigned long ret = NOTYPE|UNONE;
 
 	switch (speinsn & 0x7ff) {
-	case EFSABS:	ret = XA;	break;
-	case EFSADD:	ret = AB;	break;
-	case EFSCFD:	ret = XB;	break;
-	case EFSCMPEQ:	ret = XCR;	break;
-	case EFSCMPGT:	ret = XCR;	break;
-	case EFSCMPLT:	ret = XCR;	break;
-	case EFSCTSF:	ret = XB;	break;
-	case EFSCTSI:	ret = XB;	break;
-	case EFSCTSIZ:	ret = XB;	break;
-	case EFSCTUF:	ret = XB;	break;
-	case EFSCTUI:	ret = XB;	break;
-	case EFSCTUIZ:	ret = XB;	break;
-	case EFSDIV:	ret = AB;	break;
-	case EFSMUL:	ret = AB;	break;
-	case EFSNABS:	ret = XA;	break;
-	case EFSNEG:	ret = XA;	break;
-	case EFSSUB:	ret = AB;	break;
-	case EFSCFSI:	ret = XB;	break;
-
-	case EVFSABS:	ret = XA;	break;
-	case EVFSADD:	ret = AB;	break;
-	case EVFSCMPEQ:	ret = XCR;	break;
-	case EVFSCMPGT:	ret = XCR;	break;
-	case EVFSCMPLT:	ret = XCR;	break;
-	case EVFSCTSF:	ret = XB;	break;
-	case EVFSCTSI:	ret = XB;	break;
-	case EVFSCTSIZ:	ret = XB;	break;
-	case EVFSCTUF:	ret = XB;	break;
-	case EVFSCTUI:	ret = XB;	break;
-	case EVFSCTUIZ:	ret = XB;	break;
-	case EVFSDIV:	ret = AB;	break;
-	case EVFSMUL:	ret = AB;	break;
-	case EVFSNABS:	ret = XA;	break;
-	case EVFSNEG:	ret = XA;	break;
-	case EVFSSUB:	ret = AB;	break;
-
-	case EFDABS:	ret = XA;	break;
-	case EFDADD:	ret = AB;	break;
-	case EFDCFS:	ret = XB;	break;
-	case EFDCMPEQ:	ret = XCR;	break;
-	case EFDCMPGT:	ret = XCR;	break;
-	case EFDCMPLT:	ret = XCR;	break;
-	case EFDCTSF:	ret = XB;	break;
-	case EFDCTSI:	ret = XB;	break;
-	case EFDCTSIDZ:	ret = XB;	break;
-	case EFDCTSIZ:	ret = XB;	break;
-	case EFDCTUF:	ret = XB;	break;
-	case EFDCTUI:	ret = XB;	break;
-	case EFDCTUIDZ:	ret = XB;	break;
-	case EFDCTUIZ:	ret = XB;	break;
-	case EFDDIV:	ret = AB;	break;
-	case EFDMUL:	ret = AB;	break;
-	case EFDNABS:	ret = XA;	break;
-	case EFDNEG:	ret = XA;	break;
-	case EFDSUB:	ret = AB;	break;
+	case EFSABS:	ret = XA|UNONE;	break;
+	case EFSADD:	ret = AB|USEMI;	break;
+	case EFSCFD:	ret = XB|UNONE;	break;
+	case EFSCMPEQ:	ret = XCR|URAW;	break;
+	case EFSCMPGT:	ret = XCR|URAW;	break;
+	case EFSCMPLT:	ret = XCR|URAW;	break;
+	case EFSCTSF:	ret = XB|URAW;	break;
+	case EFSCTSI:	ret = XB|URAW;	break;
+	case EFSCTSIZ:	ret = XB|URAW;	break;
+	case EFSCTUF:	ret = XB|URAW;	break;
+	case EFSCTUI:	ret = XB|URAW;	break;
+	case EFSCTUIZ:	ret = XB|URAW;	break;
+	case EFSDIV:	ret = AB|UCOOK;	break;
+	case EFSMUL:	ret = AB|UCOOK;	break;
+	case EFSNABS:	ret = XA|UNONE;	break;
+	case EFSNEG:	ret = XA|UNONE;	break;
+	case EFSSUB:	ret = AB|USEMI;	break;
+	case EFSCFSI:	ret = XB|UNONE;	break;
+
+	case EVFSABS:	ret = XA|UNONE;	break;
+	case EVFSADD:	ret = AB|USEMI;	break;
+	case EVFSCMPEQ:	ret = XCR|URAW;	break;
+	case EVFSCMPGT:	ret = XCR|URAW;	break;
+	case EVFSCMPLT:	ret = XCR|URAW;	break;
+	case EVFSCTSF:	ret = XB|URAW;	break;
+	case EVFSCTSI:	ret = XB|URAW;	break;
+	case EVFSCTSIZ:	ret = XB|URAW;	break;
+	case EVFSCTUF:	ret = XB|URAW;	break;
+	case EVFSCTUI:	ret = XB|URAW;	break;
+	case EVFSCTUIZ:	ret = XB|URAW;	break;
+	case EVFSDIV:	ret = AB|UCOOK;	break;
+	case EVFSMUL:	ret = AB|UCOOK;	break;
+	case EVFSNABS:	ret = XA|UNONE;	break;
+	case EVFSNEG:	ret = XA|UNONE;	break;
+	case EVFSSUB:	ret = AB|USEMI;	break;
+
+	case EFDABS:	ret = XA|UNONE;	break;
+	case EFDADD:	ret = AB|USEMI;	break;
+	case EFDCFS:	ret = XB|UNONE;	break;
+	case EFDCMPEQ:	ret = XCR|URAW;	break;
+	case EFDCMPGT:	ret = XCR|URAW;	break;
+	case EFDCMPLT:	ret = XCR|URAW;	break;
+	case EFDCTSF:	ret = XB|URAW;	break;
+	case EFDCTSI:	ret = XB|URAW;	break;
+	case EFDCTSIDZ:	ret = XB|URAW;	break;
+	case EFDCTSIZ:	ret = XB|URAW;	break;
+	case EFDCTUF:	ret = XB|URAW;	break;
+	case EFDCTUI:	ret = XB|URAW;	break;
+	case EFDCTUIDZ:	ret = XB|URAW;	break;
+	case EFDCTUIZ:	ret = XB|URAW;	break;
+	case EFDDIV:	ret = AB|UCOOK;	break;
+	case EFDMUL:	ret = AB|UCOOK;	break;
+	case EFDNABS:	ret = XA|UNONE;	break;
+	case EFDNEG:	ret = XA|UNONE;	break;
+	case EFDSUB:	ret = AB|USEMI;	break;
 	}
 
 	return ret;
@@ -191,7 +196,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 		return -EINVAL;         /* not an spe instruction */
 
 	type = insn_type(speinsn);
-	if (type = NOTYPE)
+	if (type = (NOTYPE|UNONE))
 		goto illegal;
 
 	func = speinsn & 0x7ff;
@@ -219,14 +224,18 @@ int do_spe_mathemu(struct pt_regs *regs)
 		FP_DECL_S(SA); FP_DECL_S(SB); FP_DECL_S(SR);
 
 		switch (type) {
-		case AB:
-		case XCR:
-			FP_UNPACK_SP(SA, va.wp + 1);
-		case XB:
-			FP_UNPACK_SP(SB, vb.wp + 1);
+		case XCR|URAW:
+			FP_UNPACK_RAW_SP(SA, va.wp + 1);
+		case XB|URAW:
+			FP_UNPACK_RAW_SP(SB, vb.wp + 1);
+			break;
+		case AB|USEMI:
+			FP_UNPACK_SEMIRAW_SP(SA, va.wp + 1);
+			FP_UNPACK_SEMIRAW_SP(SB, vb.wp + 1);
 			break;
-		case XA:
+		case AB|UCOOK:
 			FP_UNPACK_SP(SA, va.wp + 1);
+			FP_UNPACK_SP(SB, vb.wp + 1);
 			break;
 		}
 
@@ -248,11 +257,11 @@ int do_spe_mathemu(struct pt_regs *regs)
 
 		case EFSADD:
 			FP_ADD_S(SR, SA, SB);
-			goto pack_s;
+			goto pack_semiraw_s;
 
 		case EFSSUB:
 			FP_SUB_S(SR, SA, SB);
-			goto pack_s;
+			goto pack_semiraw_s;
 
 		case EFSMUL:
 			FP_MUL_S(SR, SA, SB);
@@ -288,14 +297,13 @@ int do_spe_mathemu(struct pt_regs *regs)
 
 		case EFSCFD: {
 			FP_DECL_D(DB);
-			FP_CLEAR_EXCEPTIONS;
-			FP_UNPACK_DP(DB, vb.dp);
+			FP_UNPACK_SEMIRAW_DP(DB, vb.dp);
 
-			pr_debug("DB: %ld %08lx %08lx %ld (%ld)\n",
-					DB_s, DB_f1, DB_f0, DB_e, DB_c);
+			pr_debug("DB: %ld %08lx %08lx %ld\n",
+					DB_s, DB_f1, DB_f0, DB_e);
 
-			FP_CONV(S, D, 1, 2, SR, DB);
-			goto pack_s;
+			FP_TRUNC(S, D, 1, 2, SR, DB);
+			goto pack_semiraw_s;
 		}
 
 		case EFSCTSI:
@@ -325,6 +333,12 @@ int do_spe_mathemu(struct pt_regs *regs)
 		}
 		break;
 
+pack_semiraw_s:
+		pr_debug("SR: %ld %08lx %ld\n", SR_s, SR_f, SR_e);
+
+		FP_PACK_SEMIRAW_SP(vc.wp + 1, SR);
+		goto update_regs;
+
 pack_s:
 		pr_debug("SR: %ld %08lx %ld (%ld)\n", SR_s, SR_f, SR_e, SR_c);
 
@@ -332,9 +346,7 @@ pack_s:
 		goto update_regs;
 
 cmp_s:
-		FP_CMP_S(IR, SA, SB, 3);
-		if (IR = 3 && (FP_ISSIGNAN_S(SA) || FP_ISSIGNAN_S(SB)))
-			FP_SET_EXCEPTION(FP_EX_INVALID);
+		FP_CMP_S(IR, SA, SB, 3, 1);
 		if (IR = cmp) {
 			IR = 0x4;
 		} else {
@@ -347,14 +359,18 @@ cmp_s:
 		FP_DECL_D(DA); FP_DECL_D(DB); FP_DECL_D(DR);
 
 		switch (type) {
-		case AB:
-		case XCR:
-			FP_UNPACK_DP(DA, va.dp);
-		case XB:
-			FP_UNPACK_DP(DB, vb.dp);
+		case XCR|URAW:
+			FP_UNPACK_RAW_DP(DA, va.dp);
+		case XB|URAW:
+			FP_UNPACK_RAW_DP(DB, vb.dp);
 			break;
-		case XA:
+		case AB|USEMI:
+			FP_UNPACK_SEMIRAW_DP(DA, va.dp);
+			FP_UNPACK_SEMIRAW_DP(DB, vb.dp);
+			break;
+		case AB|UCOOK:
 			FP_UNPACK_DP(DA, va.dp);
+			FP_UNPACK_DP(DB, vb.dp);
 			break;
 		}
 
@@ -378,11 +394,11 @@ cmp_s:
 
 		case EFDADD:
 			FP_ADD_D(DR, DA, DB);
-			goto pack_d;
+			goto pack_semiraw_d;
 
 		case EFDSUB:
 			FP_SUB_D(DR, DA, DB);
-			goto pack_d;
+			goto pack_semiraw_d;
 
 		case EFDMUL:
 			FP_MUL_D(DR, DA, DB);
@@ -418,14 +434,13 @@ cmp_s:
 
 		case EFDCFS: {
 			FP_DECL_S(SB);
-			FP_CLEAR_EXCEPTIONS;
-			FP_UNPACK_SP(SB, vb.wp + 1);
+			FP_UNPACK_RAW_SP(SB, vb.wp + 1);
 
-			pr_debug("SB: %ld %08lx %ld (%ld)\n",
-					SB_s, SB_f, SB_e, SB_c);
+			pr_debug("SB: %ld %08lx %ld\n",
+					SB_s, SB_f, SB_e);
 
-			FP_CONV(D, S, 2, 1, DR, SB);
-			goto pack_d;
+			FP_EXTEND(D, S, 2, 1, DR, SB);
+			goto pack_raw_d;
 		}
 
 		case EFDCTUIDZ:
@@ -466,6 +481,20 @@ cmp_s:
 		}
 		break;
 
+pack_raw_d:
+		pr_debug("DR: %ld %08lx %08lx %ld\n",
+				DR_s, DR_f1, DR_f0, DR_e);
+
+		FP_PACK_RAW_DP(vc.dp, DR);
+		goto update_regs;
+
+pack_semiraw_d:
+		pr_debug("DR: %ld %08lx %08lx %ld\n",
+				DR_s, DR_f1, DR_f0, DR_e);
+
+		FP_PACK_SEMIRAW_DP(vc.dp, DR);
+		goto update_regs;
+
 pack_d:
 		pr_debug("DR: %ld %08lx %08lx %ld (%ld)\n",
 				DR_s, DR_f1, DR_f0, DR_e, DR_c);
@@ -474,9 +503,7 @@ pack_d:
 		goto update_regs;
 
 cmp_d:
-		FP_CMP_D(IR, DA, DB, 3);
-		if (IR = 3 && (FP_ISSIGNAN_D(DA) || FP_ISSIGNAN_D(DB)))
-			FP_SET_EXCEPTION(FP_EX_INVALID);
+		FP_CMP_D(IR, DA, DB, 3, 1);
 		if (IR = cmp) {
 			IR = 0x4;
 		} else {
@@ -492,18 +519,25 @@ cmp_d:
 		int IR0, IR1;
 
 		switch (type) {
-		case AB:
-		case XCR:
+		case XCR|URAW:
+			FP_UNPACK_RAW_SP(SA0, va.wp);
+			FP_UNPACK_RAW_SP(SA1, va.wp + 1);
+		case XB|URAW:
+			FP_UNPACK_RAW_SP(SB0, vb.wp);
+			FP_UNPACK_RAW_SP(SB1, vb.wp + 1);
+			break;
+		case AB|USEMI:
+			FP_UNPACK_SEMIRAW_SP(SA0, va.wp);
+			FP_UNPACK_SEMIRAW_SP(SA1, va.wp + 1);
+			FP_UNPACK_SEMIRAW_SP(SB0, vb.wp);
+			FP_UNPACK_SEMIRAW_SP(SB1, vb.wp + 1);
+			break;
+		case AB|UCOOK:
 			FP_UNPACK_SP(SA0, va.wp);
 			FP_UNPACK_SP(SA1, va.wp + 1);
-		case XB:
 			FP_UNPACK_SP(SB0, vb.wp);
 			FP_UNPACK_SP(SB1, vb.wp + 1);
 			break;
-		case XA:
-			FP_UNPACK_SP(SA0, va.wp);
-			FP_UNPACK_SP(SA1, va.wp + 1);
-			break;
 		}
 
 		pr_debug("SA0: %ld %08lx %ld (%ld)\n",
@@ -534,12 +568,12 @@ cmp_d:
 		case EVFSADD:
 			FP_ADD_S(SR0, SA0, SB0);
 			FP_ADD_S(SR1, SA1, SB1);
-			goto pack_vs;
+			goto pack_semiraw_vs;
 
 		case EVFSSUB:
 			FP_SUB_S(SR0, SA0, SB0);
 			FP_SUB_S(SR1, SA1, SB1);
-			goto pack_vs;
+			goto pack_semiraw_vs;
 
 		case EVFSMUL:
 			FP_MUL_S(SR0, SA0, SB0);
@@ -624,6 +658,16 @@ cmp_d:
 		}
 		break;
 
+pack_semiraw_vs:
+		pr_debug("SR0: %ld %08lx %ld\n",
+				SR0_s, SR0_f, SR0_e);
+		pr_debug("SR1: %ld %08lx %ld\n",
+				SR1_s, SR1_f, SR1_e);
+
+		FP_PACK_SEMIRAW_SP(vc.wp, SR0);
+		FP_PACK_SEMIRAW_SP(vc.wp + 1, SR1);
+		goto update_regs;
+
 pack_vs:
 		pr_debug("SR0: %ld %08lx %ld (%ld)\n",
 				SR0_s, SR0_f, SR0_e, SR0_c);
@@ -638,12 +682,8 @@ cmp_vs:
 		{
 			int ch, cl;
 
-			FP_CMP_S(IR0, SA0, SB0, 3);
-			FP_CMP_S(IR1, SA1, SB1, 3);
-			if (IR0 = 3 && (FP_ISSIGNAN_S(SA0) || FP_ISSIGNAN_S(SB0)))
-				FP_SET_EXCEPTION(FP_EX_INVALID);
-			if (IR1 = 3 && (FP_ISSIGNAN_S(SA1) || FP_ISSIGNAN_S(SB1)))
-				FP_SET_EXCEPTION(FP_EX_INVALID);
+			FP_CMP_S(IR0, SA0, SB0, 3, 1);
+			FP_CMP_S(IR1, SA1, SB1, 3, 1);
 			ch = (IR0 = cmp) ? 1 : 0;
 			cl = (IR1 = cmp) ? 1 : 0;
 			IR = (ch << 3) | (cl << 2) | ((ch | cl) << 1) |
@@ -737,7 +777,7 @@ int speround_handler(struct pt_regs *regs)
 		return -EINVAL;         /* not an spe instruction */
 
 	func = speinsn & 0x7ff;
-	type = insn_type(func);
+	type = insn_type(func) & TYPE_MASK;
 	if (type = XCR) return -ENOSYS;
 
 	__FPU_FPSCR = mfspr(SPRN_SPEFSCR);
diff --git a/arch/powerpc/math-emu/stfs.c b/arch/powerpc/math-emu/stfs.c
index 6122147..6072b14 100644
--- a/arch/powerpc/math-emu/stfs.c
+++ b/arch/powerpc/math-emu/stfs.c
@@ -19,19 +19,19 @@ stfs(void *frS, void *ea)
 	printk("%s: S %p, ea %p\n", __func__, frS, ea);
 #endif
 
-	FP_UNPACK_DP(A, frS);
+	FP_UNPACK_SEMIRAW_DP(A, frS);
 
 #ifdef DEBUG
 	printk("A: %ld %lu %lu %ld (%ld)\n", A_s, A_f1, A_f0, A_e, A_c);
 #endif
 
-	FP_CONV(S, D, 1, 2, R, A);
+	FP_TRUNC(S, D, 1, 2, R, A);
 
 #ifdef DEBUG
 	printk("R: %ld %lu %ld (%ld)\n", R_s, R_f, R_e, R_c);
 #endif
 
-	_FP_PACK_CANONICAL(S, 1, R);
+	_FP_PACK_SEMIRAW(S, 1, R);
 	if (!FP_CUR_EXCEPTIONS || !__FPU_TRAP_P(FP_CUR_EXCEPTIONS)) {
 		_FP_PACK_RAW_1_P(S, &f, R);
 		if (copy_to_user(ea, &f, sizeof(float)))
diff --git a/arch/s390/include/asm/sfp-machine.h b/arch/s390/include/asm/sfp-machine.h
index 4e16aed..67f9eed 100644
--- a/arch/s390/include/asm/sfp-machine.h
+++ b/arch/s390/include/asm/sfp-machine.h
@@ -38,6 +38,13 @@
 #define _FP_MUL_MEAT_Q(R,X,Y)					\
   _FP_MUL_MEAT_4_wide(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
 
+#define _FP_MUL_MEAT_DW_S(R,X,Y)				\
+  _FP_MUL_MEAT_DW_1_wide(_FP_WFRACBITS_S,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_DW_D(R,X,Y)				\
+  _FP_MUL_MEAT_DW_2_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_DW_Q(R,X,Y)				\
+  _FP_MUL_MEAT_DW_4_wide(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
+
 #define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_udiv(S,R,X,Y)
 #define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_2_udiv(D,R,X,Y)
 #define _FP_DIV_MEAT_Q(R,X,Y)	_FP_DIV_MEAT_4_udiv(Q,R,X,Y)
@@ -50,6 +57,7 @@
 #define _FP_NANSIGN_Q		0
 
 #define _FP_KEEPNANFRACP 1
+#define _FP_QNANNEGATEDP 0
 
 /*
  * If one NaN is signaling and the other is not,
@@ -139,4 +147,6 @@
 /* We write the results always */
 #define FP_INHIBIT_RESULTS 0
 
+#define _FP_TININESS_AFTER_ROUNDING 0
+
 #endif
diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
index 99babea..f963474 100644
--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -418,6 +418,7 @@ void s390_adjust_jiffies(void)
 	FP_DECL_S(SA); FP_DECL_S(SB); FP_DECL_S(SR);
 	FP_DECL_EX;
 	unsigned int capability;
+	int mode = 0;
 
 	info = (void *) get_zeroed_page(GFP_KERNEL);
 	if (!info)
@@ -436,11 +437,15 @@ void s390_adjust_jiffies(void)
 		 * point division .. math-emu here we come :-)
 		 */
 		FP_UNPACK_SP(SA, &fmil);
-		if ((info->capability >> 23) = 0)
-			FP_FROM_INT_S(SB, (long) info->capability, 64, long);
+		if ((info->capability >> 23) = 0) {
+			long r = info->capability;
+			FP_FROM_INT_S(SB, r, 64, unsigned long);
+		}
 		else
-			FP_UNPACK_SP(SB, &info->capability);
+			FP_UNPACK_RAW_SP(SB, &info->capability);
+		_FP_UNPACK_CANONICAL(S, 1, SB);
 		FP_DIV_S(SR, SA, SB);
+		_FP_PACK_CANONICAL(S, 1, SR);
 		FP_TO_INT_S(capability, SR, 32, 0);
 	} else
 		/*
diff --git a/arch/sh/include/asm/sfp-machine.h b/arch/sh/include/asm/sfp-machine.h
index d3c5484..01e05fe 100644
--- a/arch/sh/include/asm/sfp-machine.h
+++ b/arch/sh/include/asm/sfp-machine.h
@@ -37,6 +37,13 @@
 #define _FP_MUL_MEAT_Q(R,X,Y)					\
   _FP_MUL_MEAT_4_wide(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
 
+#define _FP_MUL_MEAT_DW_S(R,X,Y)				\
+  _FP_MUL_MEAT_DW_1_wide(_FP_WFRACBITS_S,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_DW_D(R,X,Y)				\
+  _FP_MUL_MEAT_DW_2_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_DW_Q(R,X,Y)				\
+  _FP_MUL_MEAT_DW_4_wide(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
+
 #define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_udiv(S,R,X,Y)
 #define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_2_udiv(D,R,X,Y)
 #define _FP_DIV_MEAT_Q(R,X,Y)	_FP_DIV_MEAT_4_udiv(Q,R,X,Y)
@@ -49,6 +56,7 @@
 #define _FP_NANSIGN_Q		0
 
 #define _FP_KEEPNANFRACP 1
+#define _FP_QNANNEGATEDP 0
 
 /*
  * If one NaN is signaling and the other is not,
@@ -80,5 +88,7 @@
 #define FP_EX_UNDERFLOW		(1<<1)
 #define FP_EX_INEXACT		(1<<0)
 
+#define _FP_TININESS_AFTER_ROUNDING 1
+
 #endif
 
diff --git a/arch/sh/math-emu/math.c b/arch/sh/math-emu/math.c
index 04aa55f..5975df5 100644
--- a/arch/sh/math-emu/math.c
+++ b/arch/sh/math-emu/math.c
@@ -55,11 +55,26 @@
 #define READ(d,a)	({if(get_user(d, (typeof (d)*)a)) return -EFAULT;})
 
 #define PACK_S(r,f)	FP_PACK_SP(&r,f)
+#define PACK_SEMIRAW_S(r,f)	FP_PACK_SEMIRAW_SP(&r,f)
+#define PACK_RAW_S(r,f)	FP_PACK_RAW_SP(&r,f)
 #define UNPACK_S(f,r)	FP_UNPACK_SP(f,&r)
+#define UNPACK_SEMIRAW_S(f,r)	FP_UNPACK_SEMIRAW_SP(f,&r)
+#define UNPACK_RAW_S(f,r)	FP_UNPACK_RAW_SP(f,&r)
 #define PACK_D(r,f) \
 	{u32 t[2]; FP_PACK_DP(t,f); ((u32*)&r)[0]=t[1]; ((u32*)&r)[1]=t[0];}
+#define PACK_SEMIRAW_D(r,f) \
+	{u32 t[2]; FP_PACK_SEMIRAW_DP(t,f); ((u32*)&r)[0]=t[1]; \
+		((u32*)&r)[1]=t[0];}
+#define PACK_RAW_D(r,f) \
+	{u32 t[2]; FP_PACK_RAW_DP(t,f); ((u32*)&r)[0]=t[1]; ((u32*)&r)[1]=t[0];}
 #define UNPACK_D(f,r) \
 	{u32 t[2]; t[0]=((u32*)&r)[1]; t[1]=((u32*)&r)[0]; FP_UNPACK_DP(f,t);}
+#define UNPACK_SEMIRAW_D(f,r) \
+	{u32 t[2]; t[0]=((u32*)&r)[1]; t[1]=((u32*)&r)[0]; \
+		FP_UNPACK_SEMIRAW_DP(f,t);}
+#define UNPACK_RAW_D(f,r) \
+	{u32 t[2]; t[0]=((u32*)&r)[1]; t[1]=((u32*)&r)[0]; \
+		FP_UNPACK_RAW_DP(f,t);}
 
 // 2 args instructions.
 #define BOTH_PRmn(op,x) \
@@ -68,11 +83,11 @@
 #define CMP_X(SZ,R,M,N) do{ \
 	FP_DECL_##SZ(Fm); FP_DECL_##SZ(Fn); \
 	UNPACK_##SZ(Fm, M); UNPACK_##SZ(Fn, N); \
-	FP_CMP_##SZ(R, Fn, Fm, 2); }while(0)
+	FP_CMP_##SZ(R, Fn, Fm, 2, 0); }while(0)
 #define EQ_X(SZ,R,M,N) do{ \
 	FP_DECL_##SZ(Fm); FP_DECL_##SZ(Fn); \
 	UNPACK_##SZ(Fm, M); UNPACK_##SZ(Fn, N); \
-	FP_CMP_EQ_##SZ(R, Fn, Fm); }while(0)
+	FP_CMP_EQ_##SZ(R, Fn, Fm, 0); }while(0)
 #define CMP(OP) ({ int r; BOTH_PRmn(OP##_X,r); r; })
 
 static int
@@ -102,17 +117,23 @@ fcmp_eq(struct sh_fpu_soft_struct *fregs, struct pt_regs *regs, int m, int n)
 	FP_##OP##_##SZ(Fr, Fn, Fm); \
 	PACK_##SZ(N, Fr); }while(0)
 
+#define ARITH_SEMIRAW_X(SZ,OP,M,N) do{ \
+	FP_DECL_##SZ(Fm); FP_DECL_##SZ(Fn); FP_DECL_##SZ(Fr); \
+	UNPACK_SEMIRAW_##SZ(Fm, M); UNPACK_SEMIRAW_##SZ(Fn, N); \
+	FP_##OP##_##SZ(Fr, Fn, Fm); \
+	PACK_SEMIRAW_##SZ(N, Fr); }while(0)
+
 static int
 fadd(struct sh_fpu_soft_struct *fregs, struct pt_regs *regs, int m, int n)
 {
-	BOTH_PRmn(ARITH_X, ADD);
+	BOTH_PRmn(ARITH_SEMIRAW_X, ADD);
 	return 0;
 }
 
 static int
 fsub(struct sh_fpu_soft_struct *fregs, struct pt_regs *regs, int m, int n)
 {
-	BOTH_PRmn(ARITH_X, SUB);
+	BOTH_PRmn(ARITH_SEMIRAW_X, SUB);
 	return 0;
 }
 
@@ -135,15 +156,13 @@ fmac(struct sh_fpu_soft_struct *fregs, struct pt_regs *regs, int m, int n)
 {
 	FP_DECL_EX;
 	FP_DECL_S(Fr);
-	FP_DECL_S(Ft);
 	FP_DECL_S(F0);
 	FP_DECL_S(Fm);
 	FP_DECL_S(Fn);
 	UNPACK_S(F0, FR0);
 	UNPACK_S(Fm, FRm);
 	UNPACK_S(Fn, FRn);
-	FP_MUL_S(Ft, Fm, F0);
-	FP_ADD_S(Fr, Fn, Ft);
+	FP_FMA_S(Fr, Fm, F0, Fn);
 	PACK_S(FRn, Fr);
 	return 0;
 }
@@ -284,8 +303,8 @@ NOTYETn(fsrra)
 
 #define EMU_FLOAT_X(SZ,N) do { \
 	FP_DECL_##SZ(Fn); \
-	FP_FROM_INT_##SZ(Fn, FPUL, 32, int); \
-	PACK_##SZ(N, Fn); }while(0)
+	FP_FROM_INT_##SZ(Fn, FPUL, 32, unsigned int); \
+	PACK_RAW_##SZ(N, Fn); }while(0)
 static int ffloat(struct sh_fpu_soft_struct *fregs, int n)
 {
 	FP_DECL_EX;
@@ -300,7 +319,7 @@ static int ffloat(struct sh_fpu_soft_struct *fregs, int n)
 
 #define EMU_FTRC_X(SZ,N) do { \
 	FP_DECL_##SZ(Fn); \
-	UNPACK_##SZ(Fn, N); \
+	UNPACK_RAW_##SZ(Fn, N); \
 	FP_TO_INT_##SZ(FPUL, Fn, 32, 1); }while(0)
 static int ftrc(struct sh_fpu_soft_struct *fregs, int n)
 {
@@ -319,9 +338,9 @@ static int fcnvsd(struct sh_fpu_soft_struct *fregs, int n)
 	FP_DECL_EX;
 	FP_DECL_S(Fn);
 	FP_DECL_D(Fr);
-	UNPACK_S(Fn, FPUL);
-	FP_CONV(D, S, 2, 1, Fr, Fn);
-	PACK_D(DRn, Fr);
+	UNPACK_RAW_S(Fn, FPUL);
+	FP_EXTEND(D, S, 2, 1, Fr, Fn);
+	PACK_RAW_D(DRn, Fr);
 	return 0;
 }
 
@@ -330,9 +349,9 @@ static int fcnvds(struct sh_fpu_soft_struct *fregs, int n)
 	FP_DECL_EX;
 	FP_DECL_D(Fn);
 	FP_DECL_S(Fr);
-	UNPACK_D(Fn, DRn);
-	FP_CONV(S, D, 1, 2, Fr, Fn);
-	PACK_S(FPUL, Fr);
+	UNPACK_SEMIRAW_D(Fn, DRn);
+	FP_TRUNC(S, D, 1, 2, Fr, Fn);
+	PACK_SEMIRAW_S(FPUL, Fr);
 	return 0;
 }
 
diff --git a/arch/sparc/include/asm/sfp-machine_32.h b/arch/sparc/include/asm/sfp-machine_32.h
index 838c9d5..53ce267 100644
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
index 5ce8f2f..f708ee0 100644
--- a/arch/sparc/math-emu/math_32.c
+++ b/arch/sparc/math-emu/math_32.c
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
index 034aadb..973db59 100644
--- a/arch/sparc/math-emu/math_64.c
+++ b/arch/sparc/math-emu/math_64.c
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
 
diff --git a/include/math-emu/double.h b/include/math-emu/double.h
index 655ccf1..a05713f 100644
--- a/include/math-emu/double.h
+++ b/include/math-emu/double.h
@@ -1,6 +1,6 @@
 /* Software floating-point emulation.
    Definitions for IEEE Double Precision
-   Copyright (C) 1997,1998,1999 Free Software Foundation, Inc.
+   Copyright (C) 1997-2015 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
    Contributed by Richard Henderson (rth@cygnus.com),
 		  Jakub Jelinek (jj@ultra.linux.cz),
@@ -8,31 +8,41 @@
 		  Peter Maydell (pmaydell@chiark.greenend.org.uk).
 
    The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Library General Public License as
-   published by the Free Software Foundation; either version 2 of the
-   License, or (at your option) any later version.
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   In addition to the permissions in the GNU Lesser General Public
+   License, the Free Software Foundation gives you unlimited
+   permission to link the compiled version of this file into
+   combinations with other programs, and to distribute those
+   combinations without any restriction coming from the use of this
+   file.  (The Lesser General Public License restrictions do apply in
+   other respects; for example, they cover modification of the file,
+   and distribution when not linked into a combine executable.)
 
    The GNU C Library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Library General Public License for more details.
+   Lesser General Public License for more details.
 
-   You should have received a copy of the GNU Library General Public
-   License along with the GNU C Library; see the file COPYING.LIB.  If
-   not, write to the Free Software Foundation, Inc.,
-   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
 
-#ifndef    __MATH_EMU_DOUBLE_H__
-#define    __MATH_EMU_DOUBLE_H__
+#ifndef SOFT_FP_DOUBLE_H
+#define SOFT_FP_DOUBLE_H	1
 
 #if _FP_W_TYPE_SIZE < 32
-#error "Here's a nickel kid.  Go buy yourself a real computer."
+# error "Here's a nickel kid.  Go buy yourself a real computer."
 #endif
 
 #if _FP_W_TYPE_SIZE < 64
-#define _FP_FRACTBITS_D		(2 * _FP_W_TYPE_SIZE)
+# define _FP_FRACTBITS_D	(2 * _FP_W_TYPE_SIZE)
+# define _FP_FRACTBITS_DW_D	(4 * _FP_W_TYPE_SIZE)
 #else
-#define _FP_FRACTBITS_D		_FP_W_TYPE_SIZE
+# define _FP_FRACTBITS_D	_FP_W_TYPE_SIZE
+# define _FP_FRACTBITS_DW_D	(2 * _FP_W_TYPE_SIZE)
 #endif
 
 #define _FP_FRACBITS_D		53
@@ -44,162 +54,270 @@
 #define _FP_EXPMAX_D		2047
 
 #define _FP_QNANBIT_D		\
-	((_FP_W_TYPE)1 << (_FP_FRACBITS_D-2) % _FP_W_TYPE_SIZE)
+	((_FP_W_TYPE) 1 << (_FP_FRACBITS_D-2) % _FP_W_TYPE_SIZE)
+#define _FP_QNANBIT_SH_D		\
+	((_FP_W_TYPE) 1 << (_FP_FRACBITS_D-2+_FP_WORKBITS) % _FP_W_TYPE_SIZE)
 #define _FP_IMPLBIT_D		\
-	((_FP_W_TYPE)1 << (_FP_FRACBITS_D-1) % _FP_W_TYPE_SIZE)
+	((_FP_W_TYPE) 1 << (_FP_FRACBITS_D-1) % _FP_W_TYPE_SIZE)
+#define _FP_IMPLBIT_SH_D		\
+	((_FP_W_TYPE) 1 << (_FP_FRACBITS_D-1+_FP_WORKBITS) % _FP_W_TYPE_SIZE)
 #define _FP_OVERFLOW_D		\
-	((_FP_W_TYPE)1 << _FP_WFRACBITS_D % _FP_W_TYPE_SIZE)
+	((_FP_W_TYPE) 1 << _FP_WFRACBITS_D % _FP_W_TYPE_SIZE)
+
+#define _FP_WFRACBITS_DW_D	(2 * _FP_WFRACBITS_D)
+#define _FP_WFRACXBITS_DW_D	(_FP_FRACTBITS_DW_D - _FP_WFRACBITS_DW_D)
+#define _FP_HIGHBIT_DW_D	\
+  ((_FP_W_TYPE) 1 << (_FP_WFRACBITS_DW_D - 1) % _FP_W_TYPE_SIZE)
+
+typedef float DFtype __attribute__ ((mode (DF)));
 
 #if _FP_W_TYPE_SIZE < 64
 
 union _FP_UNION_D
 {
-  double flt;
-  struct {
-#if __BYTE_ORDER = __BIG_ENDIAN
+  DFtype flt;
+  struct _FP_STRUCT_LAYOUT
+  {
+# if __BYTE_ORDER = __BIG_ENDIAN
     unsigned sign  : 1;
     unsigned exp   : _FP_EXPBITS_D;
     unsigned frac1 : _FP_FRACBITS_D - (_FP_IMPLBIT_D != 0) - _FP_W_TYPE_SIZE;
     unsigned frac0 : _FP_W_TYPE_SIZE;
-#else
+# else
     unsigned frac0 : _FP_W_TYPE_SIZE;
     unsigned frac1 : _FP_FRACBITS_D - (_FP_IMPLBIT_D != 0) - _FP_W_TYPE_SIZE;
     unsigned exp   : _FP_EXPBITS_D;
     unsigned sign  : 1;
-#endif
-  } bits __attribute__((packed));
+# endif
+  } bits __attribute__ ((packed));
 };
 
-#define FP_DECL_D(X)		_FP_DECL(2,X)
-#define FP_UNPACK_RAW_D(X,val)	_FP_UNPACK_RAW_2(D,X,val)
-#define FP_UNPACK_RAW_DP(X,val)	_FP_UNPACK_RAW_2_P(D,X,val)
-#define FP_PACK_RAW_D(val,X)	_FP_PACK_RAW_2(D,val,X)
-#define FP_PACK_RAW_DP(val,X)		\
-  do {					\
-    if (!FP_INHIBIT_RESULTS)		\
-      _FP_PACK_RAW_2_P(D,val,X);	\
-  } while (0)
-
-#define FP_UNPACK_D(X,val)		\
-  do {					\
-    _FP_UNPACK_RAW_2(D,X,val);		\
-    _FP_UNPACK_CANONICAL(D,2,X);	\
-  } while (0)
-
-#define FP_UNPACK_DP(X,val)		\
-  do {					\
-    _FP_UNPACK_RAW_2_P(D,X,val);	\
-    _FP_UNPACK_CANONICAL(D,2,X);	\
-  } while (0)
-
-#define FP_PACK_D(val,X)		\
-  do {					\
-    _FP_PACK_CANONICAL(D,2,X);		\
-    _FP_PACK_RAW_2(D,val,X);		\
-  } while (0)
-
-#define FP_PACK_DP(val,X)		\
-  do {					\
-    _FP_PACK_CANONICAL(D,2,X);		\
-    if (!FP_INHIBIT_RESULTS)		\
-      _FP_PACK_RAW_2_P(D,val,X);	\
-  } while (0)
-
-#define FP_ISSIGNAN_D(X)		_FP_ISSIGNAN(D,2,X)
-#define FP_NEG_D(R,X)			_FP_NEG(D,2,R,X)
-#define FP_ADD_D(R,X,Y)			_FP_ADD(D,2,R,X,Y)
-#define FP_SUB_D(R,X,Y)			_FP_SUB(D,2,R,X,Y)
-#define FP_MUL_D(R,X,Y)			_FP_MUL(D,2,R,X,Y)
-#define FP_DIV_D(R,X,Y)			_FP_DIV(D,2,R,X,Y)
-#define FP_SQRT_D(R,X)			_FP_SQRT(D,2,R,X)
-#define _FP_SQRT_MEAT_D(R,S,T,X,Q)	_FP_SQRT_MEAT_2(R,S,T,X,Q)
-
-#define FP_CMP_D(r,X,Y,un)	_FP_CMP(D,2,r,X,Y,un)
-#define FP_CMP_EQ_D(r,X,Y)	_FP_CMP_EQ(D,2,r,X,Y)
-
-#define FP_TO_INT_D(r,X,rsz,rsg)	_FP_TO_INT(D,2,r,X,rsz,rsg)
-#define FP_TO_INT_ROUND_D(r,X,rsz,rsg)	_FP_TO_INT_ROUND(D,2,r,X,rsz,rsg)
-#define FP_FROM_INT_D(X,r,rs,rt)	_FP_FROM_INT(D,2,X,r,rs,rt)
-
-#define _FP_FRAC_HIGH_D(X)	_FP_FRAC_HIGH_2(X)
-#define _FP_FRAC_HIGH_RAW_D(X)	_FP_FRAC_HIGH_2(X)
+# define FP_DECL_D(X)		_FP_DECL (2, X)
+# define FP_UNPACK_RAW_D(X, val)	_FP_UNPACK_RAW_2 (D, X, (val))
+# define FP_UNPACK_RAW_DP(X, val)	_FP_UNPACK_RAW_2_P (D, X, (val))
+# define FP_PACK_RAW_D(val, X)	_FP_PACK_RAW_2 (D, (val), X)
+# define FP_PACK_RAW_DP(val, X)			\
+  do						\
+    {						\
+      if (!FP_INHIBIT_RESULTS)			\
+	_FP_PACK_RAW_2_P (D, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_UNPACK_D(X, val)			\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_2 (D, X, (val));		\
+      _FP_UNPACK_CANONICAL (D, 2, X);		\
+    }						\
+  while (0)
+
+# define FP_UNPACK_DP(X, val)			\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_2_P (D, X, (val));		\
+      _FP_UNPACK_CANONICAL (D, 2, X);		\
+    }						\
+  while (0)
+
+# define FP_UNPACK_SEMIRAW_D(X, val)		\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_2 (D, X, (val));		\
+      _FP_UNPACK_SEMIRAW (D, 2, X);		\
+    }						\
+  while (0)
+
+# define FP_UNPACK_SEMIRAW_DP(X, val)		\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_2_P (D, X, (val));		\
+      _FP_UNPACK_SEMIRAW (D, 2, X);		\
+    }						\
+  while (0)
+
+# define FP_PACK_D(val, X)			\
+  do						\
+    {						\
+      _FP_PACK_CANONICAL (D, 2, X);		\
+      _FP_PACK_RAW_2 (D, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_PACK_DP(val, X)			\
+  do						\
+    {						\
+      _FP_PACK_CANONICAL (D, 2, X);		\
+      if (!FP_INHIBIT_RESULTS)			\
+	_FP_PACK_RAW_2_P (D, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_PACK_SEMIRAW_D(val, X)		\
+  do						\
+    {						\
+      _FP_PACK_SEMIRAW (D, 2, X);		\
+      _FP_PACK_RAW_2 (D, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_PACK_SEMIRAW_DP(val, X)		\
+  do						\
+    {						\
+      _FP_PACK_SEMIRAW (D, 2, X);		\
+      if (!FP_INHIBIT_RESULTS)			\
+	_FP_PACK_RAW_2_P (D, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_ISSIGNAN_D(X)		_FP_ISSIGNAN (D, 2, X)
+# define FP_NEG_D(R, X)			_FP_NEG (D, 2, R, X)
+# define FP_ADD_D(R, X, Y)		_FP_ADD (D, 2, R, X, Y)
+# define FP_SUB_D(R, X, Y)		_FP_SUB (D, 2, R, X, Y)
+# define FP_MUL_D(R, X, Y)		_FP_MUL (D, 2, R, X, Y)
+# define FP_DIV_D(R, X, Y)		_FP_DIV (D, 2, R, X, Y)
+# define FP_SQRT_D(R, X)		_FP_SQRT (D, 2, R, X)
+# define _FP_SQRT_MEAT_D(R, S, T, X, Q)	_FP_SQRT_MEAT_2 (R, S, T, X, (Q))
+# define FP_FMA_D(R, X, Y, Z)		_FP_FMA (D, 2, 4, R, X, Y, Z)
+
+# define FP_CMP_D(r, X, Y, un, ex)	_FP_CMP (D, 2, (r), X, Y, (un), (ex))
+# define FP_CMP_EQ_D(r, X, Y, ex)	_FP_CMP_EQ (D, 2, (r), X, Y, (ex))
+# define FP_CMP_UNORD_D(r, X, Y, ex)	_FP_CMP_UNORD (D, 2, (r), X, Y, (ex))
+
+# define FP_TO_INT_D(r, X, rsz, rsg)	_FP_TO_INT (D, 2, (r), X, (rsz), (rsg))
+# define FP_TO_INT_ROUND_D(r, X, rsz, rsg)	\
+  _FP_TO_INT_ROUND (D, 2, (r), X, (rsz), (rsg))
+# define FP_FROM_INT_D(X, r, rs, rt)	_FP_FROM_INT (D, 2, X, (r), (rs), rt)
+
+# define _FP_FRAC_HIGH_D(X)	_FP_FRAC_HIGH_2 (X)
+# define _FP_FRAC_HIGH_RAW_D(X)	_FP_FRAC_HIGH_2 (X)
+
+# define _FP_FRAC_HIGH_DW_D(X)	_FP_FRAC_HIGH_4 (X)
 
 #else
 
 union _FP_UNION_D
 {
-  double flt;
-  struct {
-#if __BYTE_ORDER = __BIG_ENDIAN
-    unsigned sign : 1;
-    unsigned exp  : _FP_EXPBITS_D;
-    unsigned long frac : _FP_FRACBITS_D - (_FP_IMPLBIT_D != 0);
-#else
-    unsigned long frac : _FP_FRACBITS_D - (_FP_IMPLBIT_D != 0);
-    unsigned exp  : _FP_EXPBITS_D;
-    unsigned sign : 1;
-#endif
-  } bits __attribute__((packed));
+  DFtype flt;
+  struct _FP_STRUCT_LAYOUT
+  {
+# if __BYTE_ORDER = __BIG_ENDIAN
+    unsigned sign   : 1;
+    unsigned exp    : _FP_EXPBITS_D;
+    _FP_W_TYPE frac : _FP_FRACBITS_D - (_FP_IMPLBIT_D != 0);
+# else
+    _FP_W_TYPE frac : _FP_FRACBITS_D - (_FP_IMPLBIT_D != 0);
+    unsigned exp    : _FP_EXPBITS_D;
+    unsigned sign   : 1;
+# endif
+  } bits __attribute__ ((packed));
 };
 
-#define FP_DECL_D(X)		_FP_DECL(1,X)
-#define FP_UNPACK_RAW_D(X,val)	_FP_UNPACK_RAW_1(D,X,val)
-#define FP_UNPACK_RAW_DP(X,val)	_FP_UNPACK_RAW_1_P(D,X,val)
-#define FP_PACK_RAW_D(val,X)	_FP_PACK_RAW_1(D,val,X)
-#define FP_PACK_RAW_DP(val,X)		\
-  do {					\
-    if (!FP_INHIBIT_RESULTS)		\
-      _FP_PACK_RAW_1_P(D,val,X);	\
-  } while (0)
-
-#define FP_UNPACK_D(X,val)		\
-  do {					\
-    _FP_UNPACK_RAW_1(D,X,val);		\
-    _FP_UNPACK_CANONICAL(D,1,X);	\
-  } while (0)
-
-#define FP_UNPACK_DP(X,val)		\
-  do {					\
-    _FP_UNPACK_RAW_1_P(D,X,val);	\
-    _FP_UNPACK_CANONICAL(D,1,X);	\
-  } while (0)
-
-#define FP_PACK_D(val,X)		\
-  do {					\
-    _FP_PACK_CANONICAL(D,1,X);		\
-    _FP_PACK_RAW_1(D,val,X);		\
-  } while (0)
-
-#define FP_PACK_DP(val,X)		\
-  do {					\
-    _FP_PACK_CANONICAL(D,1,X);		\
-    if (!FP_INHIBIT_RESULTS)		\
-      _FP_PACK_RAW_1_P(D,val,X);	\
-  } while (0)
-
-#define FP_ISSIGNAN_D(X)		_FP_ISSIGNAN(D,1,X)
-#define FP_NEG_D(R,X)			_FP_NEG(D,1,R,X)
-#define FP_ADD_D(R,X,Y)			_FP_ADD(D,1,R,X,Y)
-#define FP_SUB_D(R,X,Y)			_FP_SUB(D,1,R,X,Y)
-#define FP_MUL_D(R,X,Y)			_FP_MUL(D,1,R,X,Y)
-#define FP_DIV_D(R,X,Y)			_FP_DIV(D,1,R,X,Y)
-#define FP_SQRT_D(R,X)			_FP_SQRT(D,1,R,X)
-#define _FP_SQRT_MEAT_D(R,S,T,X,Q)	_FP_SQRT_MEAT_1(R,S,T,X,Q)
+# define FP_DECL_D(X)		_FP_DECL (1, X)
+# define FP_UNPACK_RAW_D(X, val)	_FP_UNPACK_RAW_1 (D, X, (val))
+# define FP_UNPACK_RAW_DP(X, val)	_FP_UNPACK_RAW_1_P (D, X, (val))
+# define FP_PACK_RAW_D(val, X)	_FP_PACK_RAW_1 (D, (val), X)
+# define FP_PACK_RAW_DP(val, X)			\
+  do						\
+    {						\
+      if (!FP_INHIBIT_RESULTS)			\
+	_FP_PACK_RAW_1_P (D, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_UNPACK_D(X, val)			\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_1 (D, X, (val));		\
+      _FP_UNPACK_CANONICAL (D, 1, X);		\
+    }						\
+  while (0)
+
+# define FP_UNPACK_DP(X, val)			\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_1_P (D, X, (val));		\
+      _FP_UNPACK_CANONICAL (D, 1, X);		\
+    }						\
+  while (0)
+
+# define FP_UNPACK_SEMIRAW_D(X, val)		\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_1 (D, X, (val));		\
+      _FP_UNPACK_SEMIRAW (D, 1, X);		\
+    }						\
+  while (0)
+
+# define FP_UNPACK_SEMIRAW_DP(X, val)		\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_1_P (D, X, (val));		\
+      _FP_UNPACK_SEMIRAW (D, 1, X);		\
+    }						\
+  while (0)
+
+# define FP_PACK_D(val, X)			\
+  do						\
+    {						\
+      _FP_PACK_CANONICAL (D, 1, X);		\
+      _FP_PACK_RAW_1 (D, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_PACK_DP(val, X)			\
+  do						\
+    {						\
+      _FP_PACK_CANONICAL (D, 1, X);		\
+      if (!FP_INHIBIT_RESULTS)			\
+	_FP_PACK_RAW_1_P (D, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_PACK_SEMIRAW_D(val, X)		\
+  do						\
+    {						\
+      _FP_PACK_SEMIRAW (D, 1, X);		\
+      _FP_PACK_RAW_1 (D, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_PACK_SEMIRAW_DP(val, X)		\
+  do						\
+    {						\
+      _FP_PACK_SEMIRAW (D, 1, X);		\
+      if (!FP_INHIBIT_RESULTS)			\
+	_FP_PACK_RAW_1_P (D, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_ISSIGNAN_D(X)		_FP_ISSIGNAN (D, 1, X)
+# define FP_NEG_D(R, X)			_FP_NEG (D, 1, R, X)
+# define FP_ADD_D(R, X, Y)		_FP_ADD (D, 1, R, X, Y)
+# define FP_SUB_D(R, X, Y)		_FP_SUB (D, 1, R, X, Y)
+# define FP_MUL_D(R, X, Y)		_FP_MUL (D, 1, R, X, Y)
+# define FP_DIV_D(R, X, Y)		_FP_DIV (D, 1, R, X, Y)
+# define FP_SQRT_D(R, X)		_FP_SQRT (D, 1, R, X)
+# define _FP_SQRT_MEAT_D(R, S, T, X, Q)	_FP_SQRT_MEAT_1 (R, S, T, X, (Q))
+# define FP_FMA_D(R, X, Y, Z)		_FP_FMA (D, 1, 2, R, X, Y, Z)
 
 /* The implementation of _FP_MUL_D and _FP_DIV_D should be chosen by
    the target machine.  */
 
-#define FP_CMP_D(r,X,Y,un)	_FP_CMP(D,1,r,X,Y,un)
-#define FP_CMP_EQ_D(r,X,Y)	_FP_CMP_EQ(D,1,r,X,Y)
+# define FP_CMP_D(r, X, Y, un, ex)	_FP_CMP (D, 1, (r), X, Y, (un), (ex))
+# define FP_CMP_EQ_D(r, X, Y, ex)	_FP_CMP_EQ (D, 1, (r), X, Y, (ex))
+# define FP_CMP_UNORD_D(r, X, Y, ex)	_FP_CMP_UNORD (D, 1, (r), X, Y, (ex))
 
-#define FP_TO_INT_D(r,X,rsz,rsg)	_FP_TO_INT(D,1,r,X,rsz,rsg)
-#define FP_TO_INT_ROUND_D(r,X,rsz,rsg)	_FP_TO_INT_ROUND(D,1,r,X,rsz,rsg)
-#define FP_FROM_INT_D(X,r,rs,rt)	_FP_FROM_INT(D,1,X,r,rs,rt)
+# define FP_TO_INT_D(r, X, rsz, rsg)	_FP_TO_INT (D, 1, (r), X, (rsz), (rsg))
+# define FP_TO_INT_ROUND_D(r, X, rsz, rsg)	\
+  _FP_TO_INT_ROUND (D, 1, (r), X, (rsz), (rsg))
+# define FP_FROM_INT_D(X, r, rs, rt)	_FP_FROM_INT (D, 1, X, (r), (rs), rt)
 
-#define _FP_FRAC_HIGH_D(X)	_FP_FRAC_HIGH_1(X)
-#define _FP_FRAC_HIGH_RAW_D(X)	_FP_FRAC_HIGH_1(X)
+# define _FP_FRAC_HIGH_D(X)	_FP_FRAC_HIGH_1 (X)
+# define _FP_FRAC_HIGH_RAW_D(X)	_FP_FRAC_HIGH_1 (X)
 
-#endif /* W_TYPE_SIZE < 64 */
+# define _FP_FRAC_HIGH_DW_D(X)	_FP_FRAC_HIGH_2 (X)
 
+#endif /* W_TYPE_SIZE < 64 */
 
-#endif /* __MATH_EMU_DOUBLE_H__ */
+#endif /* !SOFT_FP_DOUBLE_H */
diff --git a/include/math-emu/op-1.h b/include/math-emu/op-1.h
index 3be3bb4..e3a91bf 100644
--- a/include/math-emu/op-1.h
+++ b/include/math-emu/op-1.h
@@ -1,6 +1,6 @@
 /* Software floating-point emulation.
    Basic one-word fraction declaration and manipulation.
-   Copyright (C) 1997,1998,1999 Free Software Foundation, Inc.
+   Copyright (C) 1997-2015 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
    Contributed by Richard Henderson (rth@cygnus.com),
 		  Jakub Jelinek (jj@ultra.linux.cz),
@@ -8,193 +8,260 @@
 		  Peter Maydell (pmaydell@chiark.greenend.org.uk).
 
    The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Library General Public License as
-   published by the Free Software Foundation; either version 2 of the
-   License, or (at your option) any later version.
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   In addition to the permissions in the GNU Lesser General Public
+   License, the Free Software Foundation gives you unlimited
+   permission to link the compiled version of this file into
+   combinations with other programs, and to distribute those
+   combinations without any restriction coming from the use of this
+   file.  (The Lesser General Public License restrictions do apply in
+   other respects; for example, they cover modification of the file,
+   and distribution when not linked into a combine executable.)
 
    The GNU C Library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Library General Public License for more details.
+   Lesser General Public License for more details.
 
-   You should have received a copy of the GNU Library General Public
-   License along with the GNU C Library; see the file COPYING.LIB.  If
-   not, write to the Free Software Foundation, Inc.,
-   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
 
-#ifndef    __MATH_EMU_OP_1_H__
-#define    __MATH_EMU_OP_1_H__
+#ifndef SOFT_FP_OP_1_H
+#define SOFT_FP_OP_1_H	1
 
-#define _FP_FRAC_DECL_1(X)	_FP_W_TYPE X##_f=0
-#define _FP_FRAC_COPY_1(D,S)	(D##_f = S##_f)
-#define _FP_FRAC_SET_1(X,I)	(X##_f = I)
+#define _FP_FRAC_DECL_1(X)	_FP_W_TYPE X##_f _FP_ZERO_INIT
+#define _FP_FRAC_COPY_1(D, S)	(D##_f = S##_f)
+#define _FP_FRAC_SET_1(X, I)	(X##_f = I)
 #define _FP_FRAC_HIGH_1(X)	(X##_f)
 #define _FP_FRAC_LOW_1(X)	(X##_f)
-#define _FP_FRAC_WORD_1(X,w)	(X##_f)
-
-#define _FP_FRAC_ADDI_1(X,I)	(X##_f += I)
-#define _FP_FRAC_SLL_1(X,N)			\
-  do {						\
-    if (__builtin_constant_p(N) && (N) = 1)	\
-      X##_f += X##_f;				\
-    else					\
-      X##_f <<= (N);				\
-  } while (0)
-#define _FP_FRAC_SRL_1(X,N)	(X##_f >>= N)
+#define _FP_FRAC_WORD_1(X, w)	(X##_f)
+
+#define _FP_FRAC_ADDI_1(X, I)	(X##_f += I)
+#define _FP_FRAC_SLL_1(X, N)			\
+  do						\
+    {						\
+      if (__builtin_constant_p (N) && (N) = 1)	\
+	X##_f += X##_f;				\
+      else					\
+	X##_f <<= (N);				\
+    }						\
+  while (0)
+#define _FP_FRAC_SRL_1(X, N)	(X##_f >>= N)
 
 /* Right shift with sticky-lsb.  */
-#define _FP_FRAC_SRS_1(X,N,sz)	__FP_FRAC_SRS_1(X##_f, N, sz)
-
-#define __FP_FRAC_SRS_1(X,N,sz)						\
-   (X = (X >> (N) | (__builtin_constant_p(N) && (N) = 1		\
-		     ? X & 1 : (X << (_FP_W_TYPE_SIZE - (N))) != 0)))
-
-#define _FP_FRAC_ADD_1(R,X,Y)	(R##_f = X##_f + Y##_f)
-#define _FP_FRAC_SUB_1(R,X,Y)	(R##_f = X##_f - Y##_f)
-#define _FP_FRAC_DEC_1(X,Y)	(X##_f -= Y##_f)
-#define _FP_FRAC_CLZ_1(z, X)	__FP_CLZ(z, X##_f)
-
-/* Predicates */
-#define _FP_FRAC_NEGP_1(X)	((_FP_WS_TYPE)X##_f < 0)
+#define _FP_FRAC_SRST_1(X, S, N, sz)	__FP_FRAC_SRST_1 (X##_f, S, (N), (sz))
+#define _FP_FRAC_SRS_1(X, N, sz)	__FP_FRAC_SRS_1 (X##_f, (N), (sz))
+
+#define __FP_FRAC_SRST_1(X, S, N, sz)			\
+  do							\
+    {							\
+      S = (__builtin_constant_p (N) && (N) = 1		\
+	   ? X & 1					\
+	   : (X << (_FP_W_TYPE_SIZE - (N))) != 0);	\
+      X = X >> (N);					\
+    }							\
+  while (0)
+
+#define __FP_FRAC_SRS_1(X, N, sz)				\
+  (X = (X >> (N) | (__builtin_constant_p (N) && (N) = 1	\
+		    ? X & 1					\
+		    : (X << (_FP_W_TYPE_SIZE - (N))) != 0)))
+
+#define _FP_FRAC_ADD_1(R, X, Y)	(R##_f = X##_f + Y##_f)
+#define _FP_FRAC_SUB_1(R, X, Y)	(R##_f = X##_f - Y##_f)
+#define _FP_FRAC_DEC_1(X, Y)	(X##_f -= Y##_f)
+#define _FP_FRAC_CLZ_1(z, X)	__FP_CLZ ((z), X##_f)
+
+/* Predicates.  */
+#define _FP_FRAC_NEGP_1(X)	((_FP_WS_TYPE) X##_f < 0)
 #define _FP_FRAC_ZEROP_1(X)	(X##_f = 0)
-#define _FP_FRAC_OVERP_1(fs,X)	(X##_f & _FP_OVERFLOW_##fs)
-#define _FP_FRAC_CLEAR_OVERP_1(fs,X)	(X##_f &= ~_FP_OVERFLOW_##fs)
+#define _FP_FRAC_OVERP_1(fs, X)	(X##_f & _FP_OVERFLOW_##fs)
+#define _FP_FRAC_CLEAR_OVERP_1(fs, X)	(X##_f &= ~_FP_OVERFLOW_##fs)
+#define _FP_FRAC_HIGHBIT_DW_1(fs, X)	(X##_f & _FP_HIGHBIT_DW_##fs)
 #define _FP_FRAC_EQ_1(X, Y)	(X##_f = Y##_f)
 #define _FP_FRAC_GE_1(X, Y)	(X##_f >= Y##_f)
 #define _FP_FRAC_GT_1(X, Y)	(X##_f > Y##_f)
 
 #define _FP_ZEROFRAC_1		0
 #define _FP_MINFRAC_1		1
-#define _FP_MAXFRAC_1		(~(_FP_WS_TYPE)0)
-
-/*
- * Unpack the raw bits of a native fp value.  Do not classify or
- * normalize the data.
- */
-
-#define _FP_UNPACK_RAW_1(fs, X, val)				\
-  do {								\
-    union _FP_UNION_##fs _flo; _flo.flt = (val);		\
-								\
-    X##_f = _flo.bits.frac;					\
-    X##_e = _flo.bits.exp;					\
-    X##_s = _flo.bits.sign;					\
-  } while (0)
-
-#define _FP_UNPACK_RAW_1_P(fs, X, val)				\
-  do {								\
-    union _FP_UNION_##fs *_flo =				\
-      (union _FP_UNION_##fs *)(val);				\
-								\
-    X##_f = _flo->bits.frac;					\
-    X##_e = _flo->bits.exp;					\
-    X##_s = _flo->bits.sign;					\
-  } while (0)
-
-/*
- * Repack the raw bits of a native fp value.
- */
-
-#define _FP_PACK_RAW_1(fs, val, X)				\
-  do {								\
-    union _FP_UNION_##fs _flo;					\
-								\
-    _flo.bits.frac = X##_f;					\
-    _flo.bits.exp  = X##_e;					\
-    _flo.bits.sign = X##_s;					\
-								\
-    (val) = _flo.flt;						\
-  } while (0)
-
-#define _FP_PACK_RAW_1_P(fs, val, X)				\
-  do {								\
-    union _FP_UNION_##fs *_flo =				\
-      (union _FP_UNION_##fs *)(val);				\
-								\
-    _flo->bits.frac = X##_f;					\
-    _flo->bits.exp  = X##_e;					\
-    _flo->bits.sign = X##_s;					\
-  } while (0)
-
-
-/*
- * Multiplication algorithms:
- */
+#define _FP_MAXFRAC_1		(~(_FP_WS_TYPE) 0)
+
+/* Unpack the raw bits of a native fp value.  Do not classify or
+   normalize the data.  */
+
+#define _FP_UNPACK_RAW_1(fs, X, val)			\
+  do							\
+    {							\
+      union _FP_UNION_##fs _FP_UNPACK_RAW_1_flo;	\
+      _FP_UNPACK_RAW_1_flo.flt = (val);			\
+							\
+      X##_f = _FP_UNPACK_RAW_1_flo.bits.frac;		\
+      X##_e = _FP_UNPACK_RAW_1_flo.bits.exp;		\
+      X##_s = _FP_UNPACK_RAW_1_flo.bits.sign;		\
+    }							\
+  while (0)
+
+#define _FP_UNPACK_RAW_1_P(fs, X, val)			\
+  do							\
+    {							\
+      union _FP_UNION_##fs *_FP_UNPACK_RAW_1_P_flo	\
+	= (union _FP_UNION_##fs *) (val);		\
+							\
+      X##_f = _FP_UNPACK_RAW_1_P_flo->bits.frac;	\
+      X##_e = _FP_UNPACK_RAW_1_P_flo->bits.exp;		\
+      X##_s = _FP_UNPACK_RAW_1_P_flo->bits.sign;	\
+    }							\
+  while (0)
+
+/* Repack the raw bits of a native fp value.  */
+
+#define _FP_PACK_RAW_1(fs, val, X)		\
+  do						\
+    {						\
+      union _FP_UNION_##fs _FP_PACK_RAW_1_flo;	\
+						\
+      _FP_PACK_RAW_1_flo.bits.frac = X##_f;	\
+      _FP_PACK_RAW_1_flo.bits.exp  = X##_e;	\
+      _FP_PACK_RAW_1_flo.bits.sign = X##_s;	\
+						\
+      (val) = _FP_PACK_RAW_1_flo.flt;		\
+    }						\
+  while (0)
+
+#define _FP_PACK_RAW_1_P(fs, val, X)			\
+  do							\
+    {							\
+      union _FP_UNION_##fs *_FP_PACK_RAW_1_P_flo	\
+	= (union _FP_UNION_##fs *) (val);		\
+							\
+      _FP_PACK_RAW_1_P_flo->bits.frac = X##_f;		\
+      _FP_PACK_RAW_1_P_flo->bits.exp  = X##_e;		\
+      _FP_PACK_RAW_1_P_flo->bits.sign = X##_s;		\
+    }							\
+  while (0)
+
+
+/* Multiplication algorithms: */
 
 /* Basic.  Assuming the host word size is >= 2*FRACBITS, we can do the
    multiplication immediately.  */
 
+#define _FP_MUL_MEAT_DW_1_imm(wfracbits, R, X, Y)	\
+  do							\
+    {							\
+      R##_f = X##_f * Y##_f;				\
+    }							\
+  while (0)
+
 #define _FP_MUL_MEAT_1_imm(wfracbits, R, X, Y)				\
-  do {									\
-    R##_f = X##_f * Y##_f;						\
-    /* Normalize since we know where the msb of the multiplicands	\
-       were (bit B), we know that the msb of the of the product is	\
-       at either 2B or 2B-1.  */					\
-    _FP_FRAC_SRS_1(R, wfracbits-1, 2*wfracbits);			\
-  } while (0)
+  do									\
+    {									\
+      _FP_MUL_MEAT_DW_1_imm ((wfracbits), R, X, Y);			\
+      /* Normalize since we know where the msb of the multiplicands	\
+	 were (bit B), we know that the msb of the of the product is	\
+	 at either 2B or 2B-1.  */					\
+      _FP_FRAC_SRS_1 (R, (wfracbits)-1, 2*(wfracbits));			\
+    }									\
+  while (0)
 
 /* Given a 1W * 1W => 2W primitive, do the extended multiplication.  */
 
+#define _FP_MUL_MEAT_DW_1_wide(wfracbits, R, X, Y, doit)	\
+  do								\
+    {								\
+      doit (R##_f1, R##_f0, X##_f, Y##_f);			\
+    }								\
+  while (0)
+
 #define _FP_MUL_MEAT_1_wide(wfracbits, R, X, Y, doit)			\
-  do {									\
-    _FP_W_TYPE _Z_f0, _Z_f1;						\
-    doit(_Z_f1, _Z_f0, X##_f, Y##_f);					\
-    /* Normalize since we know where the msb of the multiplicands	\
-       were (bit B), we know that the msb of the of the product is	\
-       at either 2B or 2B-1.  */					\
-    _FP_FRAC_SRS_2(_Z, wfracbits-1, 2*wfracbits);			\
-    R##_f = _Z_f0;							\
-  } while (0)
+  do									\
+    {									\
+      _FP_FRAC_DECL_2 (_FP_MUL_MEAT_1_wide_Z);				\
+      _FP_MUL_MEAT_DW_1_wide ((wfracbits), _FP_MUL_MEAT_1_wide_Z,	\
+			      X, Y, doit);				\
+      /* Normalize since we know where the msb of the multiplicands	\
+	 were (bit B), we know that the msb of the of the product is	\
+	 at either 2B or 2B-1.  */					\
+      _FP_FRAC_SRS_2 (_FP_MUL_MEAT_1_wide_Z, (wfracbits)-1,		\
+		      2*(wfracbits));					\
+      R##_f = _FP_MUL_MEAT_1_wide_Z_f0;					\
+    }									\
+  while (0)
 
 /* Finally, a simple widening multiply algorithm.  What fun!  */
 
-#define _FP_MUL_MEAT_1_hard(wfracbits, R, X, Y)				\
-  do {									\
-    _FP_W_TYPE _xh, _xl, _yh, _yl, _z_f0, _z_f1, _a_f0, _a_f1;		\
-									\
-    /* split the words in half */					\
-    _xh = X##_f >> (_FP_W_TYPE_SIZE/2);					\
-    _xl = X##_f & (((_FP_W_TYPE)1 << (_FP_W_TYPE_SIZE/2)) - 1);		\
-    _yh = Y##_f >> (_FP_W_TYPE_SIZE/2);					\
-    _yl = Y##_f & (((_FP_W_TYPE)1 << (_FP_W_TYPE_SIZE/2)) - 1);		\
+#define _FP_MUL_MEAT_DW_1_hard(wfracbits, R, X, Y)			\
+  do									\
+    {									\
+      _FP_W_TYPE _FP_MUL_MEAT_DW_1_hard_xh, _FP_MUL_MEAT_DW_1_hard_xl;	\
+      _FP_W_TYPE _FP_MUL_MEAT_DW_1_hard_yh, _FP_MUL_MEAT_DW_1_hard_yl;	\
+      _FP_FRAC_DECL_2 (_FP_MUL_MEAT_DW_1_hard_a);			\
 									\
-    /* multiply the pieces */						\
-    _z_f0 = _xl * _yl;							\
-    _a_f0 = _xh * _yl;							\
-    _a_f1 = _xl * _yh;							\
-    _z_f1 = _xh * _yh;							\
+      /* Split the words in half.  */					\
+      _FP_MUL_MEAT_DW_1_hard_xh = X##_f >> (_FP_W_TYPE_SIZE/2);		\
+      _FP_MUL_MEAT_DW_1_hard_xl						\
+	= X##_f & (((_FP_W_TYPE) 1 << (_FP_W_TYPE_SIZE/2)) - 1);	\
+      _FP_MUL_MEAT_DW_1_hard_yh = Y##_f >> (_FP_W_TYPE_SIZE/2);		\
+      _FP_MUL_MEAT_DW_1_hard_yl						\
+	= Y##_f & (((_FP_W_TYPE) 1 << (_FP_W_TYPE_SIZE/2)) - 1);	\
 									\
-    /* reassemble into two full words */				\
-    if ((_a_f0 += _a_f1) < _a_f1)					\
-      _z_f1 += (_FP_W_TYPE)1 << (_FP_W_TYPE_SIZE/2);			\
-    _a_f1 = _a_f0 >> (_FP_W_TYPE_SIZE/2);				\
-    _a_f0 = _a_f0 << (_FP_W_TYPE_SIZE/2);				\
-    _FP_FRAC_ADD_2(_z, _z, _a);						\
+      /* Multiply the pieces.  */					\
+      R##_f0 = _FP_MUL_MEAT_DW_1_hard_xl * _FP_MUL_MEAT_DW_1_hard_yl;	\
+      _FP_MUL_MEAT_DW_1_hard_a_f0					\
+	= _FP_MUL_MEAT_DW_1_hard_xh * _FP_MUL_MEAT_DW_1_hard_yl;	\
+      _FP_MUL_MEAT_DW_1_hard_a_f1					\
+	= _FP_MUL_MEAT_DW_1_hard_xl * _FP_MUL_MEAT_DW_1_hard_yh;	\
+      R##_f1 = _FP_MUL_MEAT_DW_1_hard_xh * _FP_MUL_MEAT_DW_1_hard_yh;	\
 									\
-    /* normalize */							\
-    _FP_FRAC_SRS_2(_z, wfracbits - 1, 2*wfracbits);			\
-    R##_f = _z_f0;							\
-  } while (0)
+      /* Reassemble into two full words.  */				\
+      if ((_FP_MUL_MEAT_DW_1_hard_a_f0 += _FP_MUL_MEAT_DW_1_hard_a_f1)	\
+	  < _FP_MUL_MEAT_DW_1_hard_a_f1)				\
+	R##_f1 += (_FP_W_TYPE) 1 << (_FP_W_TYPE_SIZE/2);		\
+      _FP_MUL_MEAT_DW_1_hard_a_f1					\
+	= _FP_MUL_MEAT_DW_1_hard_a_f0 >> (_FP_W_TYPE_SIZE/2);		\
+      _FP_MUL_MEAT_DW_1_hard_a_f0					\
+	= _FP_MUL_MEAT_DW_1_hard_a_f0 << (_FP_W_TYPE_SIZE/2);		\
+      _FP_FRAC_ADD_2 (R, R, _FP_MUL_MEAT_DW_1_hard_a);			\
+    }									\
+  while (0)
+
+#define _FP_MUL_MEAT_1_hard(wfracbits, R, X, Y)			\
+  do								\
+    {								\
+      _FP_FRAC_DECL_2 (_FP_MUL_MEAT_1_hard_z);			\
+      _FP_MUL_MEAT_DW_1_hard ((wfracbits),			\
+			      _FP_MUL_MEAT_1_hard_z, X, Y);	\
+								\
+      /* Normalize.  */						\
+      _FP_FRAC_SRS_2 (_FP_MUL_MEAT_1_hard_z,			\
+		      (wfracbits) - 1, 2*(wfracbits));		\
+      R##_f = _FP_MUL_MEAT_1_hard_z_f0;				\
+    }								\
+  while (0)
 
 
-/*
- * Division algorithms:
- */
+/* Division algorithms: */
 
 /* Basic.  Assuming the host word size is >= 2*FRACBITS, we can do the
    division immediately.  Give this macro either _FP_DIV_HELP_imm for
    C primitives or _FP_DIV_HELP_ldiv for the ISO function.  Which you
    choose will depend on what the compiler does with divrem4.  */
 
-#define _FP_DIV_MEAT_1_imm(fs, R, X, Y, doit)		\
-  do {							\
-    _FP_W_TYPE _q, _r;					\
-    X##_f <<= (X##_f < Y##_f				\
-	       ? R##_e--, _FP_WFRACBITS_##fs		\
-	       : _FP_WFRACBITS_##fs - 1);		\
-    doit(_q, _r, X##_f, Y##_f);				\
-    R##_f = _q | (_r != 0);				\
-  } while (0)
+#define _FP_DIV_MEAT_1_imm(fs, R, X, Y, doit)				\
+  do									\
+    {									\
+      _FP_W_TYPE _FP_DIV_MEAT_1_imm_q, _FP_DIV_MEAT_1_imm_r;		\
+      X##_f <<= (X##_f < Y##_f						\
+		 ? R##_e--, _FP_WFRACBITS_##fs				\
+		 : _FP_WFRACBITS_##fs - 1);				\
+      doit (_FP_DIV_MEAT_1_imm_q, _FP_DIV_MEAT_1_imm_r, X##_f, Y##_f);	\
+      R##_f = _FP_DIV_MEAT_1_imm_q | (_FP_DIV_MEAT_1_imm_r != 0);	\
+    }									\
+  while (0)
 
 /* GCC's longlong.h defines a 2W / 1W => (1W,1W) primitive udiv_qrnnd
    that may be useful in this situation.  This first is for a primitive
@@ -202,102 +269,101 @@
    for UDIV_NEEDS_NORMALIZATION to tell which your machine needs.  */
 
 #define _FP_DIV_MEAT_1_udiv_norm(fs, R, X, Y)				\
-  do {									\
-    _FP_W_TYPE _nh, _nl, _q, _r, _y;					\
+  do									\
+    {									\
+      _FP_W_TYPE _FP_DIV_MEAT_1_udiv_norm_nh;				\
+      _FP_W_TYPE _FP_DIV_MEAT_1_udiv_norm_nl;				\
+      _FP_W_TYPE _FP_DIV_MEAT_1_udiv_norm_q;				\
+      _FP_W_TYPE _FP_DIV_MEAT_1_udiv_norm_r;				\
+      _FP_W_TYPE _FP_DIV_MEAT_1_udiv_norm_y;				\
+									\
+      /* Normalize Y -- i.e. make the most significant bit set.  */	\
+      _FP_DIV_MEAT_1_udiv_norm_y = Y##_f << _FP_WFRACXBITS_##fs;	\
 									\
-    /* Normalize Y -- i.e. make the most significant bit set.  */	\
-    _y = Y##_f << _FP_WFRACXBITS_##fs;					\
+      /* Shift X op correspondingly high, that is, up one full word.  */ \
+      if (X##_f < Y##_f)						\
+	{								\
+	  R##_e--;							\
+	  _FP_DIV_MEAT_1_udiv_norm_nl = 0;				\
+	  _FP_DIV_MEAT_1_udiv_norm_nh = X##_f;				\
+	}								\
+      else								\
+	{								\
+	  _FP_DIV_MEAT_1_udiv_norm_nl = X##_f << (_FP_W_TYPE_SIZE - 1);	\
+	  _FP_DIV_MEAT_1_udiv_norm_nh = X##_f >> 1;			\
+	}								\
 									\
-    /* Shift X op correspondingly high, that is, up one full word.  */	\
-    if (X##_f < Y##_f)							\
-      {									\
-	R##_e--;							\
-	_nl = 0;							\
-	_nh = X##_f;							\
-      }									\
-    else								\
-      {									\
-	_nl = X##_f << (_FP_W_TYPE_SIZE - 1);				\
-	_nh = X##_f >> 1;						\
-      }									\
-    									\
-    udiv_qrnnd(_q, _r, _nh, _nl, _y);					\
-    R##_f = _q | (_r != 0);						\
-  } while (0)
-
-#define _FP_DIV_MEAT_1_udiv(fs, R, X, Y)		\
-  do {							\
-    _FP_W_TYPE _nh, _nl, _q, _r;			\
-    if (X##_f < Y##_f)					\
-      {							\
-	R##_e--;					\
-	_nl = X##_f << _FP_WFRACBITS_##fs;		\
-	_nh = X##_f >> _FP_WFRACXBITS_##fs;		\
-      }							\
-    else						\
-      {							\
-	_nl = X##_f << (_FP_WFRACBITS_##fs - 1);	\
-	_nh = X##_f >> (_FP_WFRACXBITS_##fs + 1);	\
-      }							\
-    udiv_qrnnd(_q, _r, _nh, _nl, Y##_f);		\
-    R##_f = _q | (_r != 0);				\
-  } while (0)
-  
-  
-/*
- * Square root algorithms:
- * We have just one right now, maybe Newton approximation
- * should be added for those machines where division is fast.
- */
- 
-#define _FP_SQRT_MEAT_1(R, S, T, X, q)			\
-  do {							\
-    while (q != _FP_WORK_ROUND)				\
-      {							\
-        T##_f = S##_f + q;				\
-        if (T##_f <= X##_f)				\
-          {						\
-            S##_f = T##_f + q;				\
-            X##_f -= T##_f;				\
-            R##_f += q;					\
-          }						\
-        _FP_FRAC_SLL_1(X, 1);				\
-        q >>= 1;					\
-      }							\
-    if (X##_f)						\
-      {							\
-	if (S##_f < X##_f)				\
-	  R##_f |= _FP_WORK_ROUND;			\
-	R##_f |= _FP_WORK_STICKY;			\
-      }							\
-  } while (0)
-
-/*
- * Assembly/disassembly for converting to/from integral types.  
- * No shifting or overflow handled here.
- */
-
-#define _FP_FRAC_ASSEMBLE_1(r, X, rsize)	(r = X##_f)
-#define _FP_FRAC_DISASSEMBLE_1(X, r, rsize)	(X##_f = r)
-
-
-/*
- * Convert FP values between word sizes
- */
-
-#define _FP_FRAC_CONV_1_1(dfs, sfs, D, S)				\
-  do {									\
-    D##_f = S##_f;							\
-    if (_FP_WFRACBITS_##sfs > _FP_WFRACBITS_##dfs)			\
-      {									\
-	if (S##_c != FP_CLS_NAN)					\
-	  _FP_FRAC_SRS_1(D, (_FP_WFRACBITS_##sfs-_FP_WFRACBITS_##dfs),	\
-			 _FP_WFRACBITS_##sfs);				\
-	else								\
-	  _FP_FRAC_SRL_1(D, (_FP_WFRACBITS_##sfs-_FP_WFRACBITS_##dfs));	\
-      }									\
-    else								\
-      D##_f <<= _FP_WFRACBITS_##dfs - _FP_WFRACBITS_##sfs;		\
-  } while (0)
-
-#endif /* __MATH_EMU_OP_1_H__ */
+      udiv_qrnnd (_FP_DIV_MEAT_1_udiv_norm_q,				\
+		  _FP_DIV_MEAT_1_udiv_norm_r,				\
+		  _FP_DIV_MEAT_1_udiv_norm_nh,				\
+		  _FP_DIV_MEAT_1_udiv_norm_nl,				\
+		  _FP_DIV_MEAT_1_udiv_norm_y);				\
+      R##_f = (_FP_DIV_MEAT_1_udiv_norm_q				\
+	       | (_FP_DIV_MEAT_1_udiv_norm_r != 0));			\
+    }									\
+  while (0)
+
+#define _FP_DIV_MEAT_1_udiv(fs, R, X, Y)				\
+  do									\
+    {									\
+      _FP_W_TYPE _FP_DIV_MEAT_1_udiv_nh, _FP_DIV_MEAT_1_udiv_nl;	\
+      _FP_W_TYPE _FP_DIV_MEAT_1_udiv_q, _FP_DIV_MEAT_1_udiv_r;		\
+      if (X##_f < Y##_f)						\
+	{								\
+	  R##_e--;							\
+	  _FP_DIV_MEAT_1_udiv_nl = X##_f << _FP_WFRACBITS_##fs;		\
+	  _FP_DIV_MEAT_1_udiv_nh = X##_f >> _FP_WFRACXBITS_##fs;	\
+	}								\
+      else								\
+	{								\
+	  _FP_DIV_MEAT_1_udiv_nl = X##_f << (_FP_WFRACBITS_##fs - 1);	\
+	  _FP_DIV_MEAT_1_udiv_nh = X##_f >> (_FP_WFRACXBITS_##fs + 1);	\
+	}								\
+      udiv_qrnnd (_FP_DIV_MEAT_1_udiv_q, _FP_DIV_MEAT_1_udiv_r,		\
+		  _FP_DIV_MEAT_1_udiv_nh, _FP_DIV_MEAT_1_udiv_nl,	\
+		  Y##_f);						\
+      R##_f = _FP_DIV_MEAT_1_udiv_q | (_FP_DIV_MEAT_1_udiv_r != 0);	\
+    }									\
+  while (0)
+
+
+/* Square root algorithms:
+   We have just one right now, maybe Newton approximation
+   should be added for those machines where division is fast.  */
+
+#define _FP_SQRT_MEAT_1(R, S, T, X, q)		\
+  do						\
+    {						\
+      while ((q) != _FP_WORK_ROUND)		\
+	{					\
+	  T##_f = S##_f + (q);			\
+	  if (T##_f <= X##_f)			\
+	    {					\
+	      S##_f = T##_f + (q);		\
+	      X##_f -= T##_f;			\
+	      R##_f += (q);			\
+	    }					\
+	  _FP_FRAC_SLL_1 (X, 1);		\
+	  (q) >>= 1;				\
+	}					\
+      if (X##_f)				\
+	{					\
+	  if (S##_f < X##_f)			\
+	    R##_f |= _FP_WORK_ROUND;		\
+	  R##_f |= _FP_WORK_STICKY;		\
+	}					\
+    }						\
+  while (0)
+
+/* Assembly/disassembly for converting to/from integral types.
+   No shifting or overflow handled here.  */
+
+#define _FP_FRAC_ASSEMBLE_1(r, X, rsize)	((r) = X##_f)
+#define _FP_FRAC_DISASSEMBLE_1(X, r, rsize)	(X##_f = (r))
+
+
+/* Convert FP values between word sizes.  */
+
+#define _FP_FRAC_COPY_1_1(D, S)		(D##_f = S##_f)
+
+#endif /* !SOFT_FP_OP_1_H */
diff --git a/include/math-emu/op-2.h b/include/math-emu/op-2.h
index 4f26ecc..a51eb6b 100644
--- a/include/math-emu/op-2.h
+++ b/include/math-emu/op-2.h
@@ -1,6 +1,6 @@
 /* Software floating-point emulation.
    Basic two-word fraction declaration and manipulation.
-   Copyright (C) 1997,1998,1999 Free Software Foundation, Inc.
+   Copyright (C) 1997-2015 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
    Contributed by Richard Henderson (rth@cygnus.com),
 		  Jakub Jelinek (jj@ultra.linux.cz),
@@ -8,113 +8,140 @@
 		  Peter Maydell (pmaydell@chiark.greenend.org.uk).
 
    The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Library General Public License as
-   published by the Free Software Foundation; either version 2 of the
-   License, or (at your option) any later version.
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   In addition to the permissions in the GNU Lesser General Public
+   License, the Free Software Foundation gives you unlimited
+   permission to link the compiled version of this file into
+   combinations with other programs, and to distribute those
+   combinations without any restriction coming from the use of this
+   file.  (The Lesser General Public License restrictions do apply in
+   other respects; for example, they cover modification of the file,
+   and distribution when not linked into a combine executable.)
 
    The GNU C Library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Library General Public License for more details.
+   Lesser General Public License for more details.
 
-   You should have received a copy of the GNU Library General Public
-   License along with the GNU C Library; see the file COPYING.LIB.  If
-   not, write to the Free Software Foundation, Inc.,
-   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
 
-#ifndef __MATH_EMU_OP_2_H__
-#define __MATH_EMU_OP_2_H__
+#ifndef SOFT_FP_OP_2_H
+#define SOFT_FP_OP_2_H	1
 
-#define _FP_FRAC_DECL_2(X)	_FP_W_TYPE X##_f0 = 0, X##_f1 = 0
-#define _FP_FRAC_COPY_2(D,S)	(D##_f0 = S##_f0, D##_f1 = S##_f1)
-#define _FP_FRAC_SET_2(X,I)	__FP_FRAC_SET_2(X, I)
+#define _FP_FRAC_DECL_2(X)				\
+  _FP_W_TYPE X##_f0 _FP_ZERO_INIT, X##_f1 _FP_ZERO_INIT
+#define _FP_FRAC_COPY_2(D, S)	(D##_f0 = S##_f0, D##_f1 = S##_f1)
+#define _FP_FRAC_SET_2(X, I)	__FP_FRAC_SET_2 (X, I)
 #define _FP_FRAC_HIGH_2(X)	(X##_f1)
 #define _FP_FRAC_LOW_2(X)	(X##_f0)
-#define _FP_FRAC_WORD_2(X,w)	(X##_f##w)
-
-#define _FP_FRAC_SLL_2(X,N)						\
-  do {									\
-    if ((N) < _FP_W_TYPE_SIZE)						\
-      {									\
-	if (__builtin_constant_p(N) && (N) = 1) 			\
-	  {								\
-	    X##_f1 = X##_f1 + X##_f1 + (((_FP_WS_TYPE)(X##_f0)) < 0);	\
-	    X##_f0 += X##_f0;						\
-	  }								\
-	else								\
-	  {								\
-	    X##_f1 = X##_f1 << (N) | X##_f0 >> (_FP_W_TYPE_SIZE - (N));	\
-	    X##_f0 <<= (N);						\
-	  }								\
-      }									\
-    else								\
-      {									\
-	X##_f1 = X##_f0 << ((N) - _FP_W_TYPE_SIZE);			\
-	X##_f0 = 0;							\
-      }									\
-  } while (0)
-
-#define _FP_FRAC_SRL_2(X,N)						\
-  do {									\
-    if ((N) < _FP_W_TYPE_SIZE)						\
-      {									\
-	X##_f0 = X##_f0 >> (N) | X##_f1 << (_FP_W_TYPE_SIZE - (N));	\
-	X##_f1 >>= (N);							\
-      }									\
-    else								\
-      {									\
-	X##_f0 = X##_f1 >> ((N) - _FP_W_TYPE_SIZE);			\
-	X##_f1 = 0;							\
-      }									\
-  } while (0)
+#define _FP_FRAC_WORD_2(X, w)	(X##_f##w)
+
+#define _FP_FRAC_SLL_2(X, N)						\
+  (void) (((N) < _FP_W_TYPE_SIZE)					\
+	  ? ({								\
+	      if (__builtin_constant_p (N) && (N) = 1)			\
+		{							\
+		  X##_f1 = X##_f1 + X##_f1 + (((_FP_WS_TYPE) (X##_f0)) < 0); \
+		  X##_f0 += X##_f0;					\
+		}							\
+	      else							\
+		{							\
+		  X##_f1 = X##_f1 << (N) | X##_f0 >> (_FP_W_TYPE_SIZE - (N)); \
+		  X##_f0 <<= (N);					\
+		}							\
+	      0;							\
+	    })								\
+	  : ({								\
+	      X##_f1 = X##_f0 << ((N) - _FP_W_TYPE_SIZE);		\
+	      X##_f0 = 0;						\
+	    }))
+
+
+#define _FP_FRAC_SRL_2(X, N)						\
+  (void) (((N) < _FP_W_TYPE_SIZE)					\
+	  ? ({								\
+	      X##_f0 = X##_f0 >> (N) | X##_f1 << (_FP_W_TYPE_SIZE - (N)); \
+	      X##_f1 >>= (N);						\
+	    })								\
+	  : ({								\
+	      X##_f0 = X##_f1 >> ((N) - _FP_W_TYPE_SIZE);		\
+	      X##_f1 = 0;						\
+	    }))
 
 /* Right shift with sticky-lsb.  */
-#define _FP_FRAC_SRS_2(X,N,sz)						\
-  do {									\
-    if ((N) < _FP_W_TYPE_SIZE)						\
-      {									\
-	X##_f0 = (X##_f1 << (_FP_W_TYPE_SIZE - (N)) | X##_f0 >> (N) |	\
-		  (__builtin_constant_p(N) && (N) = 1			\
+#define _FP_FRAC_SRST_2(X, S, N, sz)					\
+  (void) (((N) < _FP_W_TYPE_SIZE)					\
+	  ? ({								\
+	      S = (__builtin_constant_p (N) && (N) = 1			\
 		   ? X##_f0 & 1						\
-		   : (X##_f0 << (_FP_W_TYPE_SIZE - (N))) != 0));	\
-	X##_f1 >>= (N);							\
-      }									\
-    else								\
-      {									\
-	X##_f0 = (X##_f1 >> ((N) - _FP_W_TYPE_SIZE) |			\
-		(((X##_f1 << (2*_FP_W_TYPE_SIZE - (N))) | X##_f0) != 0)); \
-	X##_f1 = 0;							\
-      }									\
-  } while (0)
-
-#define _FP_FRAC_ADDI_2(X,I)	\
-  __FP_FRAC_ADDI_2(X##_f1, X##_f0, I)
-
-#define _FP_FRAC_ADD_2(R,X,Y)	\
-  __FP_FRAC_ADD_2(R##_f1, R##_f0, X##_f1, X##_f0, Y##_f1, Y##_f0)
-
-#define _FP_FRAC_SUB_2(R,X,Y)	\
-  __FP_FRAC_SUB_2(R##_f1, R##_f0, X##_f1, X##_f0, Y##_f1, Y##_f0)
-
-#define _FP_FRAC_DEC_2(X,Y)	\
-  __FP_FRAC_DEC_2(X##_f1, X##_f0, Y##_f1, Y##_f0)
-
-#define _FP_FRAC_CLZ_2(R,X)	\
-  do {				\
-    if (X##_f1)			\
-      __FP_CLZ(R,X##_f1);	\
-    else 			\
-    {				\
-      __FP_CLZ(R,X##_f0);	\
-      R += _FP_W_TYPE_SIZE;	\
-    }				\
-  } while(0)
-
-/* Predicates */
-#define _FP_FRAC_NEGP_2(X)	((_FP_WS_TYPE)X##_f1 < 0)
+		   : (X##_f0 << (_FP_W_TYPE_SIZE - (N))) != 0);		\
+	      X##_f0 = (X##_f1 << (_FP_W_TYPE_SIZE - (N)) | X##_f0 >> (N)); \
+	      X##_f1 >>= (N);						\
+	    })								\
+	  : ({								\
+	      S = ((((N) = _FP_W_TYPE_SIZE				\
+		     ? 0						\
+		     : (X##_f1 << (2*_FP_W_TYPE_SIZE - (N))))		\
+		    | X##_f0) != 0);					\
+	      X##_f0 = (X##_f1 >> ((N) - _FP_W_TYPE_SIZE));		\
+	      X##_f1 = 0;						\
+	    }))
+
+#define _FP_FRAC_SRS_2(X, N, sz)					\
+  (void) (((N) < _FP_W_TYPE_SIZE)					\
+	  ? ({								\
+	      X##_f0 = (X##_f1 << (_FP_W_TYPE_SIZE - (N)) | X##_f0 >> (N) \
+			| (__builtin_constant_p (N) && (N) = 1		\
+			   ? X##_f0 & 1					\
+			   : (X##_f0 << (_FP_W_TYPE_SIZE - (N))) != 0)); \
+	      X##_f1 >>= (N);						\
+	    })								\
+	  : ({								\
+	      X##_f0 = (X##_f1 >> ((N) - _FP_W_TYPE_SIZE)		\
+			| ((((N) = _FP_W_TYPE_SIZE			\
+			     ? 0					\
+			     : (X##_f1 << (2*_FP_W_TYPE_SIZE - (N))))	\
+			    | X##_f0) != 0));				\
+	      X##_f1 = 0;						\
+	    }))
+
+#define _FP_FRAC_ADDI_2(X, I)	\
+  __FP_FRAC_ADDI_2 (X##_f1, X##_f0, I)
+
+#define _FP_FRAC_ADD_2(R, X, Y)	\
+  __FP_FRAC_ADD_2 (R##_f1, R##_f0, X##_f1, X##_f0, Y##_f1, Y##_f0)
+
+#define _FP_FRAC_SUB_2(R, X, Y)	\
+  __FP_FRAC_SUB_2 (R##_f1, R##_f0, X##_f1, X##_f0, Y##_f1, Y##_f0)
+
+#define _FP_FRAC_DEC_2(X, Y)	\
+  __FP_FRAC_DEC_2 (X##_f1, X##_f0, Y##_f1, Y##_f0)
+
+#define _FP_FRAC_CLZ_2(R, X)			\
+  do						\
+    {						\
+      if (X##_f1)				\
+	__FP_CLZ ((R), X##_f1);			\
+      else					\
+	{					\
+	  __FP_CLZ ((R), X##_f0);		\
+	  (R) += _FP_W_TYPE_SIZE;		\
+	}					\
+    }						\
+  while (0)
+
+/* Predicates.  */
+#define _FP_FRAC_NEGP_2(X)	((_FP_WS_TYPE) X##_f1 < 0)
 #define _FP_FRAC_ZEROP_2(X)	((X##_f1 | X##_f0) = 0)
-#define _FP_FRAC_OVERP_2(fs,X)	(_FP_FRAC_HIGH_##fs(X) & _FP_OVERFLOW_##fs)
-#define _FP_FRAC_CLEAR_OVERP_2(fs,X)	(_FP_FRAC_HIGH_##fs(X) &= ~_FP_OVERFLOW_##fs)
+#define _FP_FRAC_OVERP_2(fs, X)	(_FP_FRAC_HIGH_##fs (X) & _FP_OVERFLOW_##fs)
+#define _FP_FRAC_CLEAR_OVERP_2(fs, X)	(_FP_FRAC_HIGH_##fs (X) &= ~_FP_OVERFLOW_##fs)
+#define _FP_FRAC_HIGHBIT_DW_2(fs, X)	\
+  (_FP_FRAC_HIGH_DW_##fs (X) & _FP_HIGHBIT_DW_##fs)
 #define _FP_FRAC_EQ_2(X, Y)	(X##_f1 = Y##_f1 && X##_f0 = Y##_f0)
 #define _FP_FRAC_GT_2(X, Y)	\
   (X##_f1 > Y##_f1 || (X##_f1 = Y##_f1 && X##_f0 > Y##_f0))
@@ -123,491 +150,556 @@
 
 #define _FP_ZEROFRAC_2		0, 0
 #define _FP_MINFRAC_2		0, 1
-#define _FP_MAXFRAC_2		(~(_FP_WS_TYPE)0), (~(_FP_WS_TYPE)0)
+#define _FP_MAXFRAC_2		(~(_FP_WS_TYPE) 0), (~(_FP_WS_TYPE) 0)
 
-/*
- * Internals 
- */
+/* Internals.  */
 
-#define __FP_FRAC_SET_2(X,I1,I0)	(X##_f0 = I0, X##_f1 = I1)
+#define __FP_FRAC_SET_2(X, I1, I0)	(X##_f0 = I0, X##_f1 = I1)
 
-#define __FP_CLZ_2(R, xh, xl)	\
-  do {				\
-    if (xh)			\
-      __FP_CLZ(R,xh);		\
-    else 			\
-    {				\
-      __FP_CLZ(R,xl);		\
-      R += _FP_W_TYPE_SIZE;	\
-    }				\
-  } while(0)
+#define __FP_CLZ_2(R, xh, xl)			\
+  do						\
+    {						\
+      if (xh)					\
+	__FP_CLZ ((R), xh);			\
+      else					\
+	{					\
+	  __FP_CLZ ((R), xl);			\
+	  (R) += _FP_W_TYPE_SIZE;		\
+	}					\
+    }						\
+  while (0)
 
 #if 0
 
-#ifndef __FP_FRAC_ADDI_2
-#define __FP_FRAC_ADDI_2(xh, xl, i)	\
+# ifndef __FP_FRAC_ADDI_2
+#  define __FP_FRAC_ADDI_2(xh, xl, i)	\
   (xh += ((xl += i) < i))
-#endif
-#ifndef __FP_FRAC_ADD_2
-#define __FP_FRAC_ADD_2(rh, rl, xh, xl, yh, yl)	\
+# endif
+# ifndef __FP_FRAC_ADD_2
+#  define __FP_FRAC_ADD_2(rh, rl, xh, xl, yh, yl)	\
   (rh = xh + yh + ((rl = xl + yl) < xl))
-#endif
-#ifndef __FP_FRAC_SUB_2
-#define __FP_FRAC_SUB_2(rh, rl, xh, xl, yh, yl)	\
+# endif
+# ifndef __FP_FRAC_SUB_2
+#  define __FP_FRAC_SUB_2(rh, rl, xh, xl, yh, yl)	\
   (rh = xh - yh - ((rl = xl - yl) > xl))
-#endif
-#ifndef __FP_FRAC_DEC_2
-#define __FP_FRAC_DEC_2(xh, xl, yh, yl)	\
-  do {					\
-    UWtype _t = xl;			\
-    xh -= yh + ((xl -= yl) > _t);	\
-  } while (0)
-#endif
+# endif
+# ifndef __FP_FRAC_DEC_2
+#  define __FP_FRAC_DEC_2(xh, xl, yh, yl)		\
+  do							\
+    {							\
+      UWtype __FP_FRAC_DEC_2_t = xl;			\
+      xh -= yh + ((xl -= yl) > __FP_FRAC_DEC_2_t);	\
+    }							\
+  while (0)
+# endif
 
 #else
 
-#undef __FP_FRAC_ADDI_2
-#define __FP_FRAC_ADDI_2(xh, xl, i)	add_ssaaaa(xh, xl, xh, xl, 0, i)
-#undef __FP_FRAC_ADD_2
-#define __FP_FRAC_ADD_2			add_ssaaaa
-#undef __FP_FRAC_SUB_2
-#define __FP_FRAC_SUB_2			sub_ddmmss
-#undef __FP_FRAC_DEC_2
-#define __FP_FRAC_DEC_2(xh, xl, yh, yl)	sub_ddmmss(xh, xl, xh, xl, yh, yl)
+# undef __FP_FRAC_ADDI_2
+# define __FP_FRAC_ADDI_2(xh, xl, i)	add_ssaaaa (xh, xl, xh, xl, 0, i)
+# undef __FP_FRAC_ADD_2
+# define __FP_FRAC_ADD_2		add_ssaaaa
+# undef __FP_FRAC_SUB_2
+# define __FP_FRAC_SUB_2		sub_ddmmss
+# undef __FP_FRAC_DEC_2
+# define __FP_FRAC_DEC_2(xh, xl, yh, yl)	\
+  sub_ddmmss (xh, xl, xh, xl, yh, yl)
 
 #endif
 
-/*
- * Unpack the raw bits of a native fp value.  Do not classify or
- * normalize the data.
- */
+/* Unpack the raw bits of a native fp value.  Do not classify or
+   normalize the data.  */
 
 #define _FP_UNPACK_RAW_2(fs, X, val)			\
-  do {							\
-    union _FP_UNION_##fs _flo; _flo.flt = (val);	\
+  do							\
+    {							\
+      union _FP_UNION_##fs _FP_UNPACK_RAW_2_flo;	\
+      _FP_UNPACK_RAW_2_flo.flt = (val);			\
 							\
-    X##_f0 = _flo.bits.frac0;				\
-    X##_f1 = _flo.bits.frac1;				\
-    X##_e  = _flo.bits.exp;				\
-    X##_s  = _flo.bits.sign;				\
-  } while (0)
+      X##_f0 = _FP_UNPACK_RAW_2_flo.bits.frac0;		\
+      X##_f1 = _FP_UNPACK_RAW_2_flo.bits.frac1;		\
+      X##_e  = _FP_UNPACK_RAW_2_flo.bits.exp;		\
+      X##_s  = _FP_UNPACK_RAW_2_flo.bits.sign;		\
+    }							\
+  while (0)
 
 #define _FP_UNPACK_RAW_2_P(fs, X, val)			\
-  do {							\
-    union _FP_UNION_##fs *_flo =			\
-      (union _FP_UNION_##fs *)(val);			\
-							\
-    X##_f0 = _flo->bits.frac0;				\
-    X##_f1 = _flo->bits.frac1;				\
-    X##_e  = _flo->bits.exp;				\
-    X##_s  = _flo->bits.sign;				\
-  } while (0)
-
-
-/*
- * Repack the raw bits of a native fp value.
- */
-
-#define _FP_PACK_RAW_2(fs, val, X)			\
-  do {							\
-    union _FP_UNION_##fs _flo;				\
-							\
-    _flo.bits.frac0 = X##_f0;				\
-    _flo.bits.frac1 = X##_f1;				\
-    _flo.bits.exp   = X##_e;				\
-    _flo.bits.sign  = X##_s;				\
+  do							\
+    {							\
+      union _FP_UNION_##fs *_FP_UNPACK_RAW_2_P_flo	\
+	= (union _FP_UNION_##fs *) (val);		\
 							\
-    (val) = _flo.flt;					\
-  } while (0)
+      X##_f0 = _FP_UNPACK_RAW_2_P_flo->bits.frac0;	\
+      X##_f1 = _FP_UNPACK_RAW_2_P_flo->bits.frac1;	\
+      X##_e  = _FP_UNPACK_RAW_2_P_flo->bits.exp;	\
+      X##_s  = _FP_UNPACK_RAW_2_P_flo->bits.sign;	\
+    }							\
+  while (0)
+
+
+/* Repack the raw bits of a native fp value.  */
+
+#define _FP_PACK_RAW_2(fs, val, X)		\
+  do						\
+    {						\
+      union _FP_UNION_##fs _FP_PACK_RAW_2_flo;	\
+						\
+      _FP_PACK_RAW_2_flo.bits.frac0 = X##_f0;	\
+      _FP_PACK_RAW_2_flo.bits.frac1 = X##_f1;	\
+      _FP_PACK_RAW_2_flo.bits.exp   = X##_e;	\
+      _FP_PACK_RAW_2_flo.bits.sign  = X##_s;	\
+						\
+      (val) = _FP_PACK_RAW_2_flo.flt;		\
+    }						\
+  while (0)
 
 #define _FP_PACK_RAW_2_P(fs, val, X)			\
-  do {							\
-    union _FP_UNION_##fs *_flo =			\
-      (union _FP_UNION_##fs *)(val);			\
+  do							\
+    {							\
+      union _FP_UNION_##fs *_FP_PACK_RAW_2_P_flo	\
+	= (union _FP_UNION_##fs *) (val);		\
 							\
-    _flo->bits.frac0 = X##_f0;				\
-    _flo->bits.frac1 = X##_f1;				\
-    _flo->bits.exp   = X##_e;				\
-    _flo->bits.sign  = X##_s;				\
-  } while (0)
+      _FP_PACK_RAW_2_P_flo->bits.frac0 = X##_f0;	\
+      _FP_PACK_RAW_2_P_flo->bits.frac1 = X##_f1;	\
+      _FP_PACK_RAW_2_P_flo->bits.exp   = X##_e;		\
+      _FP_PACK_RAW_2_P_flo->bits.sign  = X##_s;		\
+    }							\
+  while (0)
 
 
-/*
- * Multiplication algorithms:
- */
+/* Multiplication algorithms: */
 
 /* Given a 1W * 1W => 2W primitive, do the extended multiplication.  */
 
-#define _FP_MUL_MEAT_2_wide(wfracbits, R, X, Y, doit)			\
-  do {									\
-    _FP_FRAC_DECL_4(_z); _FP_FRAC_DECL_2(_b); _FP_FRAC_DECL_2(_c);	\
+#define _FP_MUL_MEAT_DW_2_wide(wfracbits, R, X, Y, doit)		\
+  do									\
+    {									\
+      _FP_FRAC_DECL_2 (_FP_MUL_MEAT_DW_2_wide_b);			\
+      _FP_FRAC_DECL_2 (_FP_MUL_MEAT_DW_2_wide_c);			\
 									\
-    doit(_FP_FRAC_WORD_4(_z,1), _FP_FRAC_WORD_4(_z,0), X##_f0, Y##_f0);	\
-    doit(_b_f1, _b_f0, X##_f0, Y##_f1);					\
-    doit(_c_f1, _c_f0, X##_f1, Y##_f0);					\
-    doit(_FP_FRAC_WORD_4(_z,3), _FP_FRAC_WORD_4(_z,2), X##_f1, Y##_f1);	\
+      doit (_FP_FRAC_WORD_4 (R, 1), _FP_FRAC_WORD_4 (R, 0),		\
+	    X##_f0, Y##_f0);						\
+      doit (_FP_MUL_MEAT_DW_2_wide_b_f1, _FP_MUL_MEAT_DW_2_wide_b_f0,	\
+	    X##_f0, Y##_f1);						\
+      doit (_FP_MUL_MEAT_DW_2_wide_c_f1, _FP_MUL_MEAT_DW_2_wide_c_f0,	\
+	    X##_f1, Y##_f0);						\
+      doit (_FP_FRAC_WORD_4 (R, 3), _FP_FRAC_WORD_4 (R, 2),		\
+	    X##_f1, Y##_f1);						\
 									\
-    __FP_FRAC_ADD_3(_FP_FRAC_WORD_4(_z,3),_FP_FRAC_WORD_4(_z,2),	\
-		    _FP_FRAC_WORD_4(_z,1), 0, _b_f1, _b_f0,		\
-		    _FP_FRAC_WORD_4(_z,3),_FP_FRAC_WORD_4(_z,2),	\
-		    _FP_FRAC_WORD_4(_z,1));				\
-    __FP_FRAC_ADD_3(_FP_FRAC_WORD_4(_z,3),_FP_FRAC_WORD_4(_z,2),	\
-		    _FP_FRAC_WORD_4(_z,1), 0, _c_f1, _c_f0,		\
-		    _FP_FRAC_WORD_4(_z,3),_FP_FRAC_WORD_4(_z,2),	\
-		    _FP_FRAC_WORD_4(_z,1));				\
+      __FP_FRAC_ADD_3 (_FP_FRAC_WORD_4 (R, 3), _FP_FRAC_WORD_4 (R, 2),	\
+		       _FP_FRAC_WORD_4 (R, 1), 0,			\
+		       _FP_MUL_MEAT_DW_2_wide_b_f1,			\
+		       _FP_MUL_MEAT_DW_2_wide_b_f0,			\
+		       _FP_FRAC_WORD_4 (R, 3), _FP_FRAC_WORD_4 (R, 2),	\
+		       _FP_FRAC_WORD_4 (R, 1));				\
+      __FP_FRAC_ADD_3 (_FP_FRAC_WORD_4 (R, 3), _FP_FRAC_WORD_4 (R, 2),	\
+		       _FP_FRAC_WORD_4 (R, 1), 0,			\
+		       _FP_MUL_MEAT_DW_2_wide_c_f1,			\
+		       _FP_MUL_MEAT_DW_2_wide_c_f0,			\
+		       _FP_FRAC_WORD_4 (R, 3), _FP_FRAC_WORD_4 (R, 2),	\
+		       _FP_FRAC_WORD_4 (R, 1));				\
+    }									\
+  while (0)
+
+#define _FP_MUL_MEAT_2_wide(wfracbits, R, X, Y, doit)			\
+  do									\
+    {									\
+      _FP_FRAC_DECL_4 (_FP_MUL_MEAT_2_wide_z);				\
+									\
+      _FP_MUL_MEAT_DW_2_wide ((wfracbits), _FP_MUL_MEAT_2_wide_z,	\
+			      X, Y, doit);				\
 									\
-    /* Normalize since we know where the msb of the multiplicands	\
-       were (bit B), we know that the msb of the of the product is	\
-       at either 2B or 2B-1.  */					\
-    _FP_FRAC_SRS_4(_z, wfracbits-1, 2*wfracbits);			\
-    R##_f0 = _FP_FRAC_WORD_4(_z,0);					\
-    R##_f1 = _FP_FRAC_WORD_4(_z,1);					\
-  } while (0)
+      /* Normalize since we know where the msb of the multiplicands	\
+	 were (bit B), we know that the msb of the of the product is	\
+	 at either 2B or 2B-1.  */					\
+      _FP_FRAC_SRS_4 (_FP_MUL_MEAT_2_wide_z, (wfracbits)-1,		\
+		      2*(wfracbits));					\
+      R##_f0 = _FP_FRAC_WORD_4 (_FP_MUL_MEAT_2_wide_z, 0);		\
+      R##_f1 = _FP_FRAC_WORD_4 (_FP_MUL_MEAT_2_wide_z, 1);		\
+    }									\
+  while (0)
 
 /* Given a 1W * 1W => 2W primitive, do the extended multiplication.
    Do only 3 multiplications instead of four. This one is for machines
    where multiplication is much more expensive than subtraction.  */
 
-#define _FP_MUL_MEAT_2_wide_3mul(wfracbits, R, X, Y, doit)		\
-  do {									\
-    _FP_FRAC_DECL_4(_z); _FP_FRAC_DECL_2(_b); _FP_FRAC_DECL_2(_c);	\
-    _FP_W_TYPE _d;							\
-    int _c1, _c2;							\
+#define _FP_MUL_MEAT_DW_2_wide_3mul(wfracbits, R, X, Y, doit)		\
+  do									\
+    {									\
+      _FP_FRAC_DECL_2 (_FP_MUL_MEAT_DW_2_wide_3mul_b);			\
+      _FP_FRAC_DECL_2 (_FP_MUL_MEAT_DW_2_wide_3mul_c);			\
+      _FP_W_TYPE _FP_MUL_MEAT_DW_2_wide_3mul_d;				\
+      int _FP_MUL_MEAT_DW_2_wide_3mul_c1;				\
+      int _FP_MUL_MEAT_DW_2_wide_3mul_c2;				\
 									\
-    _b_f0 = X##_f0 + X##_f1;						\
-    _c1 = _b_f0 < X##_f0;						\
-    _b_f1 = Y##_f0 + Y##_f1;						\
-    _c2 = _b_f1 < Y##_f0;						\
-    doit(_d, _FP_FRAC_WORD_4(_z,0), X##_f0, Y##_f0);			\
-    doit(_FP_FRAC_WORD_4(_z,2), _FP_FRAC_WORD_4(_z,1), _b_f0, _b_f1);	\
-    doit(_c_f1, _c_f0, X##_f1, Y##_f1);					\
+      _FP_MUL_MEAT_DW_2_wide_3mul_b_f0 = X##_f0 + X##_f1;		\
+      _FP_MUL_MEAT_DW_2_wide_3mul_c1					\
+	= _FP_MUL_MEAT_DW_2_wide_3mul_b_f0 < X##_f0;			\
+      _FP_MUL_MEAT_DW_2_wide_3mul_b_f1 = Y##_f0 + Y##_f1;		\
+      _FP_MUL_MEAT_DW_2_wide_3mul_c2					\
+	= _FP_MUL_MEAT_DW_2_wide_3mul_b_f1 < Y##_f0;			\
+      doit (_FP_MUL_MEAT_DW_2_wide_3mul_d, _FP_FRAC_WORD_4 (R, 0),	\
+	    X##_f0, Y##_f0);						\
+      doit (_FP_FRAC_WORD_4 (R, 2), _FP_FRAC_WORD_4 (R, 1),		\
+	    _FP_MUL_MEAT_DW_2_wide_3mul_b_f0,				\
+	    _FP_MUL_MEAT_DW_2_wide_3mul_b_f1);				\
+      doit (_FP_MUL_MEAT_DW_2_wide_3mul_c_f1,				\
+	    _FP_MUL_MEAT_DW_2_wide_3mul_c_f0, X##_f1, Y##_f1);		\
 									\
-    _b_f0 &= -_c2;							\
-    _b_f1 &= -_c1;							\
-    __FP_FRAC_ADD_3(_FP_FRAC_WORD_4(_z,3),_FP_FRAC_WORD_4(_z,2),	\
-		    _FP_FRAC_WORD_4(_z,1), (_c1 & _c2), 0, _d,		\
-		    0, _FP_FRAC_WORD_4(_z,2), _FP_FRAC_WORD_4(_z,1));	\
-    __FP_FRAC_ADDI_2(_FP_FRAC_WORD_4(_z,3),_FP_FRAC_WORD_4(_z,2),	\
-		     _b_f0);						\
-    __FP_FRAC_ADDI_2(_FP_FRAC_WORD_4(_z,3),_FP_FRAC_WORD_4(_z,2),	\
-		     _b_f1);						\
-    __FP_FRAC_DEC_3(_FP_FRAC_WORD_4(_z,3),_FP_FRAC_WORD_4(_z,2),	\
-		    _FP_FRAC_WORD_4(_z,1),				\
-		    0, _d, _FP_FRAC_WORD_4(_z,0));			\
-    __FP_FRAC_DEC_3(_FP_FRAC_WORD_4(_z,3),_FP_FRAC_WORD_4(_z,2),	\
-		    _FP_FRAC_WORD_4(_z,1), 0, _c_f1, _c_f0);		\
-    __FP_FRAC_ADD_2(_FP_FRAC_WORD_4(_z,3), _FP_FRAC_WORD_4(_z,2),	\
-		    _c_f1, _c_f0,					\
-		    _FP_FRAC_WORD_4(_z,3), _FP_FRAC_WORD_4(_z,2));	\
+      _FP_MUL_MEAT_DW_2_wide_3mul_b_f0					\
+	&= -_FP_MUL_MEAT_DW_2_wide_3mul_c2;				\
+      _FP_MUL_MEAT_DW_2_wide_3mul_b_f1					\
+	&= -_FP_MUL_MEAT_DW_2_wide_3mul_c1;				\
+      __FP_FRAC_ADD_3 (_FP_FRAC_WORD_4 (R, 3), _FP_FRAC_WORD_4 (R, 2),	\
+		       _FP_FRAC_WORD_4 (R, 1),				\
+		       (_FP_MUL_MEAT_DW_2_wide_3mul_c1			\
+			& _FP_MUL_MEAT_DW_2_wide_3mul_c2), 0,		\
+		       _FP_MUL_MEAT_DW_2_wide_3mul_d,			\
+		       0, _FP_FRAC_WORD_4 (R, 2), _FP_FRAC_WORD_4 (R, 1)); \
+      __FP_FRAC_ADDI_2 (_FP_FRAC_WORD_4 (R, 3), _FP_FRAC_WORD_4 (R, 2),	\
+			_FP_MUL_MEAT_DW_2_wide_3mul_b_f0);		\
+      __FP_FRAC_ADDI_2 (_FP_FRAC_WORD_4 (R, 3), _FP_FRAC_WORD_4 (R, 2),	\
+			_FP_MUL_MEAT_DW_2_wide_3mul_b_f1);		\
+      __FP_FRAC_DEC_3 (_FP_FRAC_WORD_4 (R, 3), _FP_FRAC_WORD_4 (R, 2),	\
+		       _FP_FRAC_WORD_4 (R, 1),				\
+		       0, _FP_MUL_MEAT_DW_2_wide_3mul_d,		\
+		       _FP_FRAC_WORD_4 (R, 0));				\
+      __FP_FRAC_DEC_3 (_FP_FRAC_WORD_4 (R, 3), _FP_FRAC_WORD_4 (R, 2),	\
+		       _FP_FRAC_WORD_4 (R, 1), 0,			\
+		       _FP_MUL_MEAT_DW_2_wide_3mul_c_f1,		\
+		       _FP_MUL_MEAT_DW_2_wide_3mul_c_f0);		\
+      __FP_FRAC_ADD_2 (_FP_FRAC_WORD_4 (R, 3), _FP_FRAC_WORD_4 (R, 2),	\
+		       _FP_MUL_MEAT_DW_2_wide_3mul_c_f1,		\
+		       _FP_MUL_MEAT_DW_2_wide_3mul_c_f0,		\
+		       _FP_FRAC_WORD_4 (R, 3), _FP_FRAC_WORD_4 (R, 2));	\
+    }									\
+  while (0)
+
+#define _FP_MUL_MEAT_2_wide_3mul(wfracbits, R, X, Y, doit)		\
+  do									\
+    {									\
+      _FP_FRAC_DECL_4 (_FP_MUL_MEAT_2_wide_3mul_z);			\
 									\
-    /* Normalize since we know where the msb of the multiplicands	\
-       were (bit B), we know that the msb of the of the product is	\
-       at either 2B or 2B-1.  */					\
-    _FP_FRAC_SRS_4(_z, wfracbits-1, 2*wfracbits);			\
-    R##_f0 = _FP_FRAC_WORD_4(_z,0);					\
-    R##_f1 = _FP_FRAC_WORD_4(_z,1);					\
-  } while (0)
+      _FP_MUL_MEAT_DW_2_wide_3mul ((wfracbits),				\
+				   _FP_MUL_MEAT_2_wide_3mul_z,		\
+				   X, Y, doit);				\
+									\
+      /* Normalize since we know where the msb of the multiplicands	\
+	 were (bit B), we know that the msb of the of the product is	\
+	 at either 2B or 2B-1.  */					\
+      _FP_FRAC_SRS_4 (_FP_MUL_MEAT_2_wide_3mul_z,			\
+		      (wfracbits)-1, 2*(wfracbits));			\
+      R##_f0 = _FP_FRAC_WORD_4 (_FP_MUL_MEAT_2_wide_3mul_z, 0);		\
+      R##_f1 = _FP_FRAC_WORD_4 (_FP_MUL_MEAT_2_wide_3mul_z, 1);		\
+    }									\
+  while (0)
+
+#define _FP_MUL_MEAT_DW_2_gmp(wfracbits, R, X, Y)	\
+  do							\
+    {							\
+      _FP_W_TYPE _FP_MUL_MEAT_DW_2_gmp_x[2];		\
+      _FP_W_TYPE _FP_MUL_MEAT_DW_2_gmp_y[2];		\
+      _FP_MUL_MEAT_DW_2_gmp_x[0] = X##_f0;		\
+      _FP_MUL_MEAT_DW_2_gmp_x[1] = X##_f1;		\
+      _FP_MUL_MEAT_DW_2_gmp_y[0] = Y##_f0;		\
+      _FP_MUL_MEAT_DW_2_gmp_y[1] = Y##_f1;		\
+							\
+      mpn_mul_n (R##_f, _FP_MUL_MEAT_DW_2_gmp_x,	\
+		 _FP_MUL_MEAT_DW_2_gmp_y, 2);		\
+    }							\
+  while (0)
 
 #define _FP_MUL_MEAT_2_gmp(wfracbits, R, X, Y)				\
-  do {									\
-    _FP_FRAC_DECL_4(_z);						\
-    _FP_W_TYPE _x[2], _y[2];						\
-    _x[0] = X##_f0; _x[1] = X##_f1;					\
-    _y[0] = Y##_f0; _y[1] = Y##_f1;					\
+  do									\
+    {									\
+      _FP_FRAC_DECL_4 (_FP_MUL_MEAT_2_gmp_z);				\
 									\
-    mpn_mul_n(_z_f, _x, _y, 2);						\
+      _FP_MUL_MEAT_DW_2_gmp ((wfracbits), _FP_MUL_MEAT_2_gmp_z, X, Y);	\
 									\
-    /* Normalize since we know where the msb of the multiplicands	\
-       were (bit B), we know that the msb of the of the product is	\
-       at either 2B or 2B-1.  */					\
-    _FP_FRAC_SRS_4(_z, wfracbits-1, 2*wfracbits);			\
-    R##_f0 = _z_f[0];							\
-    R##_f1 = _z_f[1];							\
-  } while (0)
+      /* Normalize since we know where the msb of the multiplicands	\
+	 were (bit B), we know that the msb of the of the product is	\
+	 at either 2B or 2B-1.  */					\
+      _FP_FRAC_SRS_4 (_FP_MUL_MEAT_2_gmp_z, (wfracbits)-1,		\
+		      2*(wfracbits));					\
+      R##_f0 = _FP_MUL_MEAT_2_gmp_z_f[0];				\
+      R##_f1 = _FP_MUL_MEAT_2_gmp_z_f[1];				\
+    }									\
+  while (0)
 
 /* Do at most 120x120$0 bits multiplication using double floating
    point multiplication.  This is useful if floating point
    multiplication has much bigger throughput than integer multiply.
    It is supposed to work for _FP_W_TYPE_SIZE 64 and wfracbits
-   between 106 and 120 only.  
+   between 106 and 120 only.
    Caller guarantees that X and Y has (1LLL << (wfracbits - 1)) set.
    SETFETZ is a macro which will disable all FPU exceptions and set rounding
    towards zero,  RESETFE should optionally reset it back.  */
 
-#define _FP_MUL_MEAT_2_120_240_double(wfracbits, R, X, Y, setfetz, resetfe)	\
-  do {										\
-    static const double _const[] = {						\
-      /* 2^-24 */ 5.9604644775390625e-08,					\
-      /* 2^-48 */ 3.5527136788005009e-15,					\
-      /* 2^-72 */ 2.1175823681357508e-22,					\
-      /* 2^-96 */ 1.2621774483536189e-29,					\
-      /* 2^28 */ 2.68435456e+08,						\
-      /* 2^4 */ 1.600000e+01,							\
-      /* 2^-20 */ 9.5367431640625e-07,						\
-      /* 2^-44 */ 5.6843418860808015e-14,					\
-      /* 2^-68 */ 3.3881317890172014e-21,					\
-      /* 2^-92 */ 2.0194839173657902e-28,					\
-      /* 2^-116 */ 1.2037062152420224e-35};					\
-    double _a240, _b240, _c240, _d240, _e240, _f240, 				\
-	   _g240, _h240, _i240, _j240, _k240;					\
-    union { double d; UDItype i; } _l240, _m240, _n240, _o240,			\
-				   _p240, _q240, _r240, _s240;			\
-    UDItype _t240, _u240, _v240, _w240, _x240, _y240 = 0;			\
-										\
-    if (wfracbits < 106 || wfracbits > 120)					\
-      abort();									\
-										\
-    setfetz;									\
-										\
-    _e240 = (double)(long)(X##_f0 & 0xffffff);					\
-    _j240 = (double)(long)(Y##_f0 & 0xffffff);					\
-    _d240 = (double)(long)((X##_f0 >> 24) & 0xffffff);				\
-    _i240 = (double)(long)((Y##_f0 >> 24) & 0xffffff);				\
-    _c240 = (double)(long)(((X##_f1 << 16) & 0xffffff) | (X##_f0 >> 48));	\
-    _h240 = (double)(long)(((Y##_f1 << 16) & 0xffffff) | (Y##_f0 >> 48));	\
-    _b240 = (double)(long)((X##_f1 >> 8) & 0xffffff);				\
-    _g240 = (double)(long)((Y##_f1 >> 8) & 0xffffff);				\
-    _a240 = (double)(long)(X##_f1 >> 32);					\
-    _f240 = (double)(long)(Y##_f1 >> 32);					\
-    _e240 *= _const[3];								\
-    _j240 *= _const[3];								\
-    _d240 *= _const[2];								\
-    _i240 *= _const[2];								\
-    _c240 *= _const[1];								\
-    _h240 *= _const[1];								\
-    _b240 *= _const[0];								\
-    _g240 *= _const[0];								\
-    _s240.d =							      _e240*_j240;\
-    _r240.d =						_d240*_j240 + _e240*_i240;\
-    _q240.d =				  _c240*_j240 + _d240*_i240 + _e240*_h240;\
-    _p240.d =		    _b240*_j240 + _c240*_i240 + _d240*_h240 + _e240*_g240;\
-    _o240.d = _a240*_j240 + _b240*_i240 + _c240*_h240 + _d240*_g240 + _e240*_f240;\
-    _n240.d = _a240*_i240 + _b240*_h240 + _c240*_g240 + _d240*_f240;		\
-    _m240.d = _a240*_h240 + _b240*_g240 + _c240*_f240;				\
-    _l240.d = _a240*_g240 + _b240*_f240;					\
-    _k240 =   _a240*_f240;							\
-    _r240.d += _s240.d;								\
-    _q240.d += _r240.d;								\
-    _p240.d += _q240.d;								\
-    _o240.d += _p240.d;								\
-    _n240.d += _o240.d;								\
-    _m240.d += _n240.d;								\
-    _l240.d += _m240.d;								\
-    _k240 += _l240.d;								\
-    _s240.d -= ((_const[10]+_s240.d)-_const[10]);				\
-    _r240.d -= ((_const[9]+_r240.d)-_const[9]);					\
-    _q240.d -= ((_const[8]+_q240.d)-_const[8]);					\
-    _p240.d -= ((_const[7]+_p240.d)-_const[7]);					\
-    _o240.d += _const[7];							\
-    _n240.d += _const[6];							\
-    _m240.d += _const[5];							\
-    _l240.d += _const[4];							\
-    if (_s240.d != 0.0) _y240 = 1;						\
-    if (_r240.d != 0.0) _y240 = 1;						\
-    if (_q240.d != 0.0) _y240 = 1;						\
-    if (_p240.d != 0.0) _y240 = 1;						\
-    _t240 = (DItype)_k240;							\
-    _u240 = _l240.i;								\
-    _v240 = _m240.i;								\
-    _w240 = _n240.i;								\
-    _x240 = _o240.i;								\
-    R##_f1 = (_t240 << (128 - (wfracbits - 1)))					\
-	     | ((_u240 & 0xffffff) >> ((wfracbits - 1) - 104));			\
-    R##_f0 = ((_u240 & 0xffffff) << (168 - (wfracbits - 1)))			\
-    	     | ((_v240 & 0xffffff) << (144 - (wfracbits - 1)))			\
-    	     | ((_w240 & 0xffffff) << (120 - (wfracbits - 1)))			\
-    	     | ((_x240 & 0xffffff) >> ((wfracbits - 1) - 96))			\
-    	     | _y240;								\
-    resetfe;									\
-  } while (0)
-
-/*
- * Division algorithms:
- */
+#define _FP_MUL_MEAT_2_120_240_double(wfracbits, R, X, Y, setfetz, resetfe) \
+  do									\
+    {									\
+      static const double _const[] =					\
+	{								\
+	  /* 2^-24 */ 5.9604644775390625e-08,				\
+	  /* 2^-48 */ 3.5527136788005009e-15,				\
+	  /* 2^-72 */ 2.1175823681357508e-22,				\
+	  /* 2^-96 */ 1.2621774483536189e-29,				\
+	  /* 2^28 */ 2.68435456e+08,					\
+	  /* 2^4 */ 1.600000e+01,					\
+	  /* 2^-20 */ 9.5367431640625e-07,				\
+	  /* 2^-44 */ 5.6843418860808015e-14,				\
+	  /* 2^-68 */ 3.3881317890172014e-21,				\
+	  /* 2^-92 */ 2.0194839173657902e-28,				\
+	  /* 2^-116 */ 1.2037062152420224e-35				\
+	};								\
+      double _a240, _b240, _c240, _d240, _e240, _f240,			\
+	_g240, _h240, _i240, _j240, _k240;				\
+      union { double d; UDItype i; } _l240, _m240, _n240, _o240,	\
+				       _p240, _q240, _r240, _s240;	\
+      UDItype _t240, _u240, _v240, _w240, _x240, _y240 = 0;		\
+									\
+      _FP_STATIC_ASSERT ((wfracbits) >= 106 && (wfracbits) <= 120,	\
+			 "wfracbits out of range");			\
+									\
+      setfetz;								\
+									\
+      _e240 = (double) (long) (X##_f0 & 0xffffff);			\
+      _j240 = (double) (long) (Y##_f0 & 0xffffff);			\
+      _d240 = (double) (long) ((X##_f0 >> 24) & 0xffffff);		\
+      _i240 = (double) (long) ((Y##_f0 >> 24) & 0xffffff);		\
+      _c240 = (double) (long) (((X##_f1 << 16) & 0xffffff) | (X##_f0 >> 48)); \
+      _h240 = (double) (long) (((Y##_f1 << 16) & 0xffffff) | (Y##_f0 >> 48)); \
+      _b240 = (double) (long) ((X##_f1 >> 8) & 0xffffff);		\
+      _g240 = (double) (long) ((Y##_f1 >> 8) & 0xffffff);		\
+      _a240 = (double) (long) (X##_f1 >> 32);				\
+      _f240 = (double) (long) (Y##_f1 >> 32);				\
+      _e240 *= _const[3];						\
+      _j240 *= _const[3];						\
+      _d240 *= _const[2];						\
+      _i240 *= _const[2];						\
+      _c240 *= _const[1];						\
+      _h240 *= _const[1];						\
+      _b240 *= _const[0];						\
+      _g240 *= _const[0];						\
+      _s240.d =							      _e240*_j240; \
+      _r240.d =						_d240*_j240 + _e240*_i240; \
+      _q240.d =				  _c240*_j240 + _d240*_i240 + _e240*_h240; \
+      _p240.d =		    _b240*_j240 + _c240*_i240 + _d240*_h240 + _e240*_g240; \
+      _o240.d = _a240*_j240 + _b240*_i240 + _c240*_h240 + _d240*_g240 + _e240*_f240; \
+      _n240.d = _a240*_i240 + _b240*_h240 + _c240*_g240 + _d240*_f240;	\
+      _m240.d = _a240*_h240 + _b240*_g240 + _c240*_f240;		\
+      _l240.d = _a240*_g240 + _b240*_f240;				\
+      _k240 =   _a240*_f240;						\
+      _r240.d += _s240.d;						\
+      _q240.d += _r240.d;						\
+      _p240.d += _q240.d;						\
+      _o240.d += _p240.d;						\
+      _n240.d += _o240.d;						\
+      _m240.d += _n240.d;						\
+      _l240.d += _m240.d;						\
+      _k240 += _l240.d;							\
+      _s240.d -= ((_const[10]+_s240.d)-_const[10]);			\
+      _r240.d -= ((_const[9]+_r240.d)-_const[9]);			\
+      _q240.d -= ((_const[8]+_q240.d)-_const[8]);			\
+      _p240.d -= ((_const[7]+_p240.d)-_const[7]);			\
+      _o240.d += _const[7];						\
+      _n240.d += _const[6];						\
+      _m240.d += _const[5];						\
+      _l240.d += _const[4];						\
+      if (_s240.d != 0.0)						\
+	_y240 = 1;							\
+      if (_r240.d != 0.0)						\
+	_y240 = 1;							\
+      if (_q240.d != 0.0)						\
+	_y240 = 1;							\
+      if (_p240.d != 0.0)						\
+	_y240 = 1;							\
+      _t240 = (DItype) _k240;						\
+      _u240 = _l240.i;							\
+      _v240 = _m240.i;							\
+      _w240 = _n240.i;							\
+      _x240 = _o240.i;							\
+      R##_f1 = ((_t240 << (128 - (wfracbits - 1)))			\
+		| ((_u240 & 0xffffff) >> ((wfracbits - 1) - 104)));	\
+      R##_f0 = (((_u240 & 0xffffff) << (168 - (wfracbits - 1)))		\
+		| ((_v240 & 0xffffff) << (144 - (wfracbits - 1)))	\
+		| ((_w240 & 0xffffff) << (120 - (wfracbits - 1)))	\
+		| ((_x240 & 0xffffff) >> ((wfracbits - 1) - 96))	\
+		| _y240);						\
+      resetfe;								\
+    }									\
+  while (0)
+
+/* Division algorithms: */
 
 #define _FP_DIV_MEAT_2_udiv(fs, R, X, Y)				\
-  do {									\
-    _FP_W_TYPE _n_f2, _n_f1, _n_f0, _r_f1, _r_f0, _m_f1, _m_f0;		\
-    if (_FP_FRAC_GT_2(X, Y))						\
-      {									\
-	_n_f2 = X##_f1 >> 1;						\
-	_n_f1 = X##_f1 << (_FP_W_TYPE_SIZE - 1) | X##_f0 >> 1;		\
-	_n_f0 = X##_f0 << (_FP_W_TYPE_SIZE - 1);			\
-      }									\
-    else								\
-      {									\
-	R##_e--;							\
-	_n_f2 = X##_f1;							\
-	_n_f1 = X##_f0;							\
-	_n_f0 = 0;							\
-      }									\
+  do									\
+    {									\
+      _FP_W_TYPE _FP_DIV_MEAT_2_udiv_n_f2;				\
+      _FP_W_TYPE _FP_DIV_MEAT_2_udiv_n_f1;				\
+      _FP_W_TYPE _FP_DIV_MEAT_2_udiv_n_f0;				\
+      _FP_W_TYPE _FP_DIV_MEAT_2_udiv_r_f1;				\
+      _FP_W_TYPE _FP_DIV_MEAT_2_udiv_r_f0;				\
+      _FP_W_TYPE _FP_DIV_MEAT_2_udiv_m_f1;				\
+      _FP_W_TYPE _FP_DIV_MEAT_2_udiv_m_f0;				\
+      if (_FP_FRAC_GE_2 (X, Y))						\
+	{								\
+	  _FP_DIV_MEAT_2_udiv_n_f2 = X##_f1 >> 1;			\
+	  _FP_DIV_MEAT_2_udiv_n_f1					\
+	    = X##_f1 << (_FP_W_TYPE_SIZE - 1) | X##_f0 >> 1;		\
+	  _FP_DIV_MEAT_2_udiv_n_f0					\
+	    = X##_f0 << (_FP_W_TYPE_SIZE - 1);				\
+	}								\
+      else								\
+	{								\
+	  R##_e--;							\
+	  _FP_DIV_MEAT_2_udiv_n_f2 = X##_f1;				\
+	  _FP_DIV_MEAT_2_udiv_n_f1 = X##_f0;				\
+	  _FP_DIV_MEAT_2_udiv_n_f0 = 0;					\
+	}								\
 									\
-    /* Normalize, i.e. make the most significant bit of the 		\
-       denominator set. */						\
-    _FP_FRAC_SLL_2(Y, _FP_WFRACXBITS_##fs);				\
+      /* Normalize, i.e. make the most significant bit of the		\
+	 denominator set.  */						\
+      _FP_FRAC_SLL_2 (Y, _FP_WFRACXBITS_##fs);				\
 									\
-    udiv_qrnnd(R##_f1, _r_f1, _n_f2, _n_f1, Y##_f1);			\
-    umul_ppmm(_m_f1, _m_f0, R##_f1, Y##_f0);				\
-    _r_f0 = _n_f0;							\
-    if (_FP_FRAC_GT_2(_m, _r))						\
-      {									\
-	R##_f1--;							\
-	_FP_FRAC_ADD_2(_r, Y, _r);					\
-	if (_FP_FRAC_GE_2(_r, Y) && _FP_FRAC_GT_2(_m, _r))		\
-	  {								\
-	    R##_f1--;							\
-	    _FP_FRAC_ADD_2(_r, Y, _r);					\
-	  }								\
-      }									\
-    _FP_FRAC_DEC_2(_r, _m);						\
+      udiv_qrnnd (R##_f1, _FP_DIV_MEAT_2_udiv_r_f1,			\
+		  _FP_DIV_MEAT_2_udiv_n_f2, _FP_DIV_MEAT_2_udiv_n_f1,	\
+		  Y##_f1);						\
+      umul_ppmm (_FP_DIV_MEAT_2_udiv_m_f1, _FP_DIV_MEAT_2_udiv_m_f0,	\
+		 R##_f1, Y##_f0);					\
+      _FP_DIV_MEAT_2_udiv_r_f0 = _FP_DIV_MEAT_2_udiv_n_f0;		\
+      if (_FP_FRAC_GT_2 (_FP_DIV_MEAT_2_udiv_m, _FP_DIV_MEAT_2_udiv_r))	\
+	{								\
+	  R##_f1--;							\
+	  _FP_FRAC_ADD_2 (_FP_DIV_MEAT_2_udiv_r, Y,			\
+			  _FP_DIV_MEAT_2_udiv_r);			\
+	  if (_FP_FRAC_GE_2 (_FP_DIV_MEAT_2_udiv_r, Y)			\
+	      && _FP_FRAC_GT_2 (_FP_DIV_MEAT_2_udiv_m,			\
+				_FP_DIV_MEAT_2_udiv_r))			\
+	    {								\
+	      R##_f1--;							\
+	      _FP_FRAC_ADD_2 (_FP_DIV_MEAT_2_udiv_r, Y,			\
+			      _FP_DIV_MEAT_2_udiv_r);			\
+	    }								\
+	}								\
+      _FP_FRAC_DEC_2 (_FP_DIV_MEAT_2_udiv_r, _FP_DIV_MEAT_2_udiv_m);	\
 									\
-    if (_r_f1 = Y##_f1)						\
-      {									\
-	/* This is a special case, not an optimization			\
-	   (_r/Y##_f1 would not fit into UWtype).			\
-	   As _r is guaranteed to be < Y,  R##_f0 can be either		\
-	   (UWtype)-1 or (UWtype)-2.  But as we know what kind		\
-	   of bits it is (sticky, guard, round),  we don't care.	\
-	   We also don't care what the reminder is,  because the	\
-	   guard bit will be set anyway.  -jj */			\
-	R##_f0 = -1;							\
-      }									\
-    else								\
-      {									\
-	udiv_qrnnd(R##_f0, _r_f1, _r_f1, _r_f0, Y##_f1);		\
-	umul_ppmm(_m_f1, _m_f0, R##_f0, Y##_f0);			\
-	_r_f0 = 0;							\
-	if (_FP_FRAC_GT_2(_m, _r))					\
-	  {								\
-	    R##_f0--;							\
-	    _FP_FRAC_ADD_2(_r, Y, _r);					\
-	    if (_FP_FRAC_GE_2(_r, Y) && _FP_FRAC_GT_2(_m, _r))		\
-	      {								\
-		R##_f0--;						\
-		_FP_FRAC_ADD_2(_r, Y, _r);				\
-	      }								\
-	  }								\
-	if (!_FP_FRAC_EQ_2(_r, _m))					\
-	  R##_f0 |= _FP_WORK_STICKY;					\
-      }									\
-  } while (0)
-
-
-#define _FP_DIV_MEAT_2_gmp(fs, R, X, Y)					\
-  do {									\
-    _FP_W_TYPE _x[4], _y[2], _z[4];					\
-    _y[0] = Y##_f0; _y[1] = Y##_f1;					\
-    _x[0] = _x[3] = 0;							\
-    if (_FP_FRAC_GT_2(X, Y))						\
-      {									\
-	R##_e++;							\
-	_x[1] = (X##_f0 << (_FP_WFRACBITS_##fs-1 - _FP_W_TYPE_SIZE) |	\
-		 X##_f1 >> (_FP_W_TYPE_SIZE -				\
-			    (_FP_WFRACBITS_##fs-1 - _FP_W_TYPE_SIZE)));	\
-	_x[2] = X##_f1 << (_FP_WFRACBITS_##fs-1 - _FP_W_TYPE_SIZE);	\
-      }									\
-    else								\
-      {									\
-	_x[1] = (X##_f0 << (_FP_WFRACBITS_##fs - _FP_W_TYPE_SIZE) |	\
-		 X##_f1 >> (_FP_W_TYPE_SIZE -				\
-			    (_FP_WFRACBITS_##fs - _FP_W_TYPE_SIZE)));	\
-	_x[2] = X##_f1 << (_FP_WFRACBITS_##fs - _FP_W_TYPE_SIZE);	\
-      }									\
-									\
-    (void) mpn_divrem (_z, 0, _x, 4, _y, 2);				\
-    R##_f1 = _z[1];							\
-    R##_f0 = _z[0] | ((_x[0] | _x[1]) != 0);				\
-  } while (0)
-
-
-/*
- * Square root algorithms:
- * We have just one right now, maybe Newton approximation
- * should be added for those machines where division is fast.
- */
- 
-#define _FP_SQRT_MEAT_2(R, S, T, X, q)			\
-  do {							\
-    while (q)						\
-      {							\
-	T##_f1 = S##_f1 + q;				\
-	if (T##_f1 <= X##_f1)				\
-	  {						\
-	    S##_f1 = T##_f1 + q;			\
-	    X##_f1 -= T##_f1;				\
-	    R##_f1 += q;				\
-	  }						\
-	_FP_FRAC_SLL_2(X, 1);				\
-	q >>= 1;					\
-      }							\
-    q = (_FP_W_TYPE)1 << (_FP_W_TYPE_SIZE - 1);		\
-    while (q != _FP_WORK_ROUND)				\
-      {							\
-	T##_f0 = S##_f0 + q;				\
-	T##_f1 = S##_f1;				\
-	if (T##_f1 < X##_f1 || 				\
-	    (T##_f1 = X##_f1 && T##_f0 <= X##_f0))	\
-	  {						\
-	    S##_f0 = T##_f0 + q;			\
-	    S##_f1 += (T##_f0 > S##_f0);		\
-	    _FP_FRAC_DEC_2(X, T);			\
-	    R##_f0 += q;				\
-	  }						\
-	_FP_FRAC_SLL_2(X, 1);				\
-	q >>= 1;					\
-      }							\
-    if (X##_f0 | X##_f1)				\
-      {							\
-	if (S##_f1 < X##_f1 || 				\
-	    (S##_f1 = X##_f1 && S##_f0 < X##_f0))	\
-	  R##_f0 |= _FP_WORK_ROUND;			\
-	R##_f0 |= _FP_WORK_STICKY;			\
-      }							\
-  } while (0)
-
-
-/*
- * Assembly/disassembly for converting to/from integral types.  
- * No shifting or overflow handled here.
- */
+      if (_FP_DIV_MEAT_2_udiv_r_f1 = Y##_f1)				\
+	{								\
+	  /* This is a special case, not an optimization		\
+	     (_FP_DIV_MEAT_2_udiv_r/Y##_f1 would not fit into UWtype).	\
+	     As _FP_DIV_MEAT_2_udiv_r is guaranteed to be < Y,		\
+	     R##_f0 can be either (UWtype)-1 or (UWtype)-2.  But as we	\
+	     know what kind of bits it is (sticky, guard, round),	\
+	     we don't care.  We also don't care what the reminder is,	\
+	     because the guard bit will be set anyway.  -jj */		\
+	  R##_f0 = -1;							\
+	}								\
+      else								\
+	{								\
+	  udiv_qrnnd (R##_f0, _FP_DIV_MEAT_2_udiv_r_f1,			\
+		      _FP_DIV_MEAT_2_udiv_r_f1,				\
+		      _FP_DIV_MEAT_2_udiv_r_f0, Y##_f1);		\
+	  umul_ppmm (_FP_DIV_MEAT_2_udiv_m_f1,				\
+		     _FP_DIV_MEAT_2_udiv_m_f0, R##_f0, Y##_f0);		\
+	  _FP_DIV_MEAT_2_udiv_r_f0 = 0;					\
+	  if (_FP_FRAC_GT_2 (_FP_DIV_MEAT_2_udiv_m,			\
+			     _FP_DIV_MEAT_2_udiv_r))			\
+	    {								\
+	      R##_f0--;							\
+	      _FP_FRAC_ADD_2 (_FP_DIV_MEAT_2_udiv_r, Y,			\
+			      _FP_DIV_MEAT_2_udiv_r);			\
+	      if (_FP_FRAC_GE_2 (_FP_DIV_MEAT_2_udiv_r, Y)		\
+		  && _FP_FRAC_GT_2 (_FP_DIV_MEAT_2_udiv_m,		\
+				    _FP_DIV_MEAT_2_udiv_r))		\
+		{							\
+		  R##_f0--;						\
+		  _FP_FRAC_ADD_2 (_FP_DIV_MEAT_2_udiv_r, Y,		\
+				  _FP_DIV_MEAT_2_udiv_r);		\
+		}							\
+	    }								\
+	  if (!_FP_FRAC_EQ_2 (_FP_DIV_MEAT_2_udiv_r,			\
+			      _FP_DIV_MEAT_2_udiv_m))			\
+	    R##_f0 |= _FP_WORK_STICKY;					\
+	}								\
+    }									\
+  while (0)
+
+
+/* Square root algorithms:
+   We have just one right now, maybe Newton approximation
+   should be added for those machines where division is fast.  */
+
+#define _FP_SQRT_MEAT_2(R, S, T, X, q)				\
+  do								\
+    {								\
+      while (q)							\
+	{							\
+	  T##_f1 = S##_f1 + (q);				\
+	  if (T##_f1 <= X##_f1)					\
+	    {							\
+	      S##_f1 = T##_f1 + (q);				\
+	      X##_f1 -= T##_f1;					\
+	      R##_f1 += (q);					\
+	    }							\
+	  _FP_FRAC_SLL_2 (X, 1);				\
+	  (q) >>= 1;						\
+	}							\
+      (q) = (_FP_W_TYPE) 1 << (_FP_W_TYPE_SIZE - 1);		\
+      while ((q) != _FP_WORK_ROUND)				\
+	{							\
+	  T##_f0 = S##_f0 + (q);				\
+	  T##_f1 = S##_f1;					\
+	  if (T##_f1 < X##_f1					\
+	      || (T##_f1 = X##_f1 && T##_f0 <= X##_f0))	\
+	    {							\
+	      S##_f0 = T##_f0 + (q);				\
+	      S##_f1 += (T##_f0 > S##_f0);			\
+	      _FP_FRAC_DEC_2 (X, T);				\
+	      R##_f0 += (q);					\
+	    }							\
+	  _FP_FRAC_SLL_2 (X, 1);				\
+	  (q) >>= 1;						\
+	}							\
+      if (X##_f0 | X##_f1)					\
+	{							\
+	  if (S##_f1 < X##_f1					\
+	      || (S##_f1 = X##_f1 && S##_f0 < X##_f0))		\
+	    R##_f0 |= _FP_WORK_ROUND;				\
+	  R##_f0 |= _FP_WORK_STICKY;				\
+	}							\
+    }								\
+  while (0)
+
+
+/* Assembly/disassembly for converting to/from integral types.
+   No shifting or overflow handled here.  */
 
 #define _FP_FRAC_ASSEMBLE_2(r, X, rsize)	\
-  do {						\
-    if (rsize <= _FP_W_TYPE_SIZE)		\
-      r = X##_f0;				\
-    else					\
-      {						\
-	r = X##_f1;				\
-	r <<= _FP_W_TYPE_SIZE;			\
-	r += X##_f0;				\
-      }						\
-  } while (0)
-
-#define _FP_FRAC_DISASSEMBLE_2(X, r, rsize)				\
-  do {									\
-    X##_f0 = r;								\
-    X##_f1 = (rsize <= _FP_W_TYPE_SIZE ? 0 : r >> _FP_W_TYPE_SIZE);	\
-  } while (0)
-
-/*
- * Convert FP values between word sizes
- */
-
-#define _FP_FRAC_CONV_1_2(dfs, sfs, D, S)				\
-  do {									\
-    if (S##_c != FP_CLS_NAN)						\
-      _FP_FRAC_SRS_2(S, (_FP_WFRACBITS_##sfs - _FP_WFRACBITS_##dfs),	\
-		     _FP_WFRACBITS_##sfs);				\
-    else								\
-      _FP_FRAC_SRL_2(S, (_FP_WFRACBITS_##sfs - _FP_WFRACBITS_##dfs));	\
-    D##_f = S##_f0;							\
-  } while (0)
-
-#define _FP_FRAC_CONV_2_1(dfs, sfs, D, S)				\
-  do {									\
-    D##_f0 = S##_f;							\
-    D##_f1 = 0;								\
-    _FP_FRAC_SLL_2(D, (_FP_WFRACBITS_##dfs - _FP_WFRACBITS_##sfs));	\
-  } while (0)
+  (void) (((rsize) <= _FP_W_TYPE_SIZE)		\
+	  ? ({ (r) = X##_f0; })			\
+	  : ({					\
+	      (r) = X##_f1;			\
+	      (r) <<= _FP_W_TYPE_SIZE;		\
+	      (r) += X##_f0;			\
+	    }))
 
-#endif
+#define _FP_FRAC_DISASSEMBLE_2(X, r, rsize)	\
+  do						\
+    {						\
+      X##_f0 = (r);				\
+      X##_f1 = ((rsize) <= _FP_W_TYPE_SIZE	\
+		? 0				\
+		: (r) >> _FP_W_TYPE_SIZE);	\
+    }						\
+  while (0)
+
+/* Convert FP values between word sizes.  */
+
+#define _FP_FRAC_COPY_1_2(D, S)		(D##_f = S##_f0)
+
+#define _FP_FRAC_COPY_2_1(D, S)		((D##_f0 = S##_f), (D##_f1 = 0))
+
+#define _FP_FRAC_COPY_2_2(D, S)		_FP_FRAC_COPY_2 (D, S)
+
+#endif /* !SOFT_FP_OP_2_H */
diff --git a/include/math-emu/op-4.h b/include/math-emu/op-4.h
index ba226f8..a580517 100644
--- a/include/math-emu/op-4.h
+++ b/include/math-emu/op-4.h
@@ -1,6 +1,6 @@
 /* Software floating-point emulation.
    Basic four-word fraction declaration and manipulation.
-   Copyright (C) 1997,1998,1999 Free Software Foundation, Inc.
+   Copyright (C) 1997-2015 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
    Contributed by Richard Henderson (rth@cygnus.com),
 		  Jakub Jelinek (jj@ultra.linux.cz),
@@ -8,685 +8,868 @@
 		  Peter Maydell (pmaydell@chiark.greenend.org.uk).
 
    The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Library General Public License as
-   published by the Free Software Foundation; either version 2 of the
-   License, or (at your option) any later version.
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   In addition to the permissions in the GNU Lesser General Public
+   License, the Free Software Foundation gives you unlimited
+   permission to link the compiled version of this file into
+   combinations with other programs, and to distribute those
+   combinations without any restriction coming from the use of this
+   file.  (The Lesser General Public License restrictions do apply in
+   other respects; for example, they cover modification of the file,
+   and distribution when not linked into a combine executable.)
 
    The GNU C Library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Library General Public License for more details.
+   Lesser General Public License for more details.
 
-   You should have received a copy of the GNU Library General Public
-   License along with the GNU C Library; see the file COPYING.LIB.  If
-   not, write to the Free Software Foundation, Inc.,
-   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
 
-#ifndef __MATH_EMU_OP_4_H__
-#define __MATH_EMU_OP_4_H__
+#ifndef SOFT_FP_OP_4_H
+#define SOFT_FP_OP_4_H	1
 
 #define _FP_FRAC_DECL_4(X)	_FP_W_TYPE X##_f[4]
-#define _FP_FRAC_COPY_4(D,S)			\
+#define _FP_FRAC_COPY_4(D, S)			\
   (D##_f[0] = S##_f[0], D##_f[1] = S##_f[1],	\
    D##_f[2] = S##_f[2], D##_f[3] = S##_f[3])
-#define _FP_FRAC_SET_4(X,I)	__FP_FRAC_SET_4(X, I)
+#define _FP_FRAC_SET_4(X, I)	__FP_FRAC_SET_4 (X, I)
 #define _FP_FRAC_HIGH_4(X)	(X##_f[3])
 #define _FP_FRAC_LOW_4(X)	(X##_f[0])
-#define _FP_FRAC_WORD_4(X,w)	(X##_f[w])
-
-#define _FP_FRAC_SLL_4(X,N)						\
-  do {									\
-    _FP_I_TYPE _up, _down, _skip, _i;					\
-    _skip = (N) / _FP_W_TYPE_SIZE;					\
-    _up = (N) % _FP_W_TYPE_SIZE;					\
-    _down = _FP_W_TYPE_SIZE - _up;					\
-    if (!_up)								\
-      for (_i = 3; _i >= _skip; --_i)					\
-	X##_f[_i] = X##_f[_i-_skip];					\
-    else								\
-      {									\
-	for (_i = 3; _i > _skip; --_i)					\
-	  X##_f[_i] = X##_f[_i-_skip] << _up				\
-		      | X##_f[_i-_skip-1] >> _down;			\
-	X##_f[_i--] = X##_f[0] << _up; 					\
-      }									\
-    for (; _i >= 0; --_i)						\
-      X##_f[_i] = 0;							\
-  } while (0)
-
-/* This one was broken too */
-#define _FP_FRAC_SRL_4(X,N)						\
-  do {									\
-    _FP_I_TYPE _up, _down, _skip, _i;					\
-    _skip = (N) / _FP_W_TYPE_SIZE;					\
-    _down = (N) % _FP_W_TYPE_SIZE;					\
-    _up = _FP_W_TYPE_SIZE - _down;					\
-    if (!_down)								\
-      for (_i = 0; _i <= 3-_skip; ++_i)					\
-	X##_f[_i] = X##_f[_i+_skip];					\
-    else								\
-      {									\
-	for (_i = 0; _i < 3-_skip; ++_i)				\
-	  X##_f[_i] = X##_f[_i+_skip] >> _down				\
-		      | X##_f[_i+_skip+1] << _up;			\
-	X##_f[_i++] = X##_f[3] >> _down;				\
-      }									\
-    for (; _i < 4; ++_i)						\
-      X##_f[_i] = 0;							\
-  } while (0)
-
-
-/* Right shift with sticky-lsb. 
- * What this actually means is that we do a standard right-shift,
- * but that if any of the bits that fall off the right hand side
- * were one then we always set the LSbit.
- */
-#define _FP_FRAC_SRS_4(X,N,size)					\
-  do {									\
-    _FP_I_TYPE _up, _down, _skip, _i;					\
-    _FP_W_TYPE _s;							\
-    _skip = (N) / _FP_W_TYPE_SIZE;					\
-    _down = (N) % _FP_W_TYPE_SIZE;					\
-    _up = _FP_W_TYPE_SIZE - _down;					\
-    for (_s = _i = 0; _i < _skip; ++_i)					\
-      _s |= X##_f[_i];							\
-    _s |= X##_f[_i] << _up;						\
-/* s is now != 0 if we want to set the LSbit */				\
-    if (!_down)								\
-      for (_i = 0; _i <= 3-_skip; ++_i)					\
-	X##_f[_i] = X##_f[_i+_skip];					\
-    else								\
-      {									\
-	for (_i = 0; _i < 3-_skip; ++_i)				\
-	  X##_f[_i] = X##_f[_i+_skip] >> _down				\
-		      | X##_f[_i+_skip+1] << _up;			\
-	X##_f[_i++] = X##_f[3] >> _down;				\
-      }									\
-    for (; _i < 4; ++_i)						\
-      X##_f[_i] = 0;							\
-    /* don't fix the LSB until the very end when we're sure f[0] is stable */	\
-    X##_f[0] |= (_s != 0);						\
-  } while (0)
-
-#define _FP_FRAC_ADD_4(R,X,Y)						\
-  __FP_FRAC_ADD_4(R##_f[3], R##_f[2], R##_f[1], R##_f[0],		\
-		  X##_f[3], X##_f[2], X##_f[1], X##_f[0],		\
-		  Y##_f[3], Y##_f[2], Y##_f[1], Y##_f[0])
-
-#define _FP_FRAC_SUB_4(R,X,Y)						\
-  __FP_FRAC_SUB_4(R##_f[3], R##_f[2], R##_f[1], R##_f[0],		\
-		  X##_f[3], X##_f[2], X##_f[1], X##_f[0],		\
-		  Y##_f[3], Y##_f[2], Y##_f[1], Y##_f[0])
-
-#define _FP_FRAC_DEC_4(X,Y)						\
-  __FP_FRAC_DEC_4(X##_f[3], X##_f[2], X##_f[1], X##_f[0],		\
-		  Y##_f[3], Y##_f[2], Y##_f[1], Y##_f[0])
-
-#define _FP_FRAC_ADDI_4(X,I)						\
-  __FP_FRAC_ADDI_4(X##_f[3], X##_f[2], X##_f[1], X##_f[0], I)
-
-#define _FP_ZEROFRAC_4  0,0,0,0
-#define _FP_MINFRAC_4   0,0,0,1
-#define _FP_MAXFRAC_4	(~(_FP_WS_TYPE)0), (~(_FP_WS_TYPE)0), (~(_FP_WS_TYPE)0), (~(_FP_WS_TYPE)0)
+#define _FP_FRAC_WORD_4(X, w)	(X##_f[w])
+
+#define _FP_FRAC_SLL_4(X, N)						\
+  do									\
+    {									\
+      _FP_I_TYPE _FP_FRAC_SLL_4_up, _FP_FRAC_SLL_4_down;		\
+      _FP_I_TYPE _FP_FRAC_SLL_4_skip, _FP_FRAC_SLL_4_i;			\
+      _FP_FRAC_SLL_4_skip = (N) / _FP_W_TYPE_SIZE;			\
+      _FP_FRAC_SLL_4_up = (N) % _FP_W_TYPE_SIZE;			\
+      _FP_FRAC_SLL_4_down = _FP_W_TYPE_SIZE - _FP_FRAC_SLL_4_up;	\
+      if (!_FP_FRAC_SLL_4_up)						\
+	for (_FP_FRAC_SLL_4_i = 3;					\
+	     _FP_FRAC_SLL_4_i >= _FP_FRAC_SLL_4_skip;			\
+	     --_FP_FRAC_SLL_4_i)					\
+	  X##_f[_FP_FRAC_SLL_4_i]					\
+	    = X##_f[_FP_FRAC_SLL_4_i-_FP_FRAC_SLL_4_skip];		\
+      else								\
+	{								\
+	  for (_FP_FRAC_SLL_4_i = 3;					\
+	       _FP_FRAC_SLL_4_i > _FP_FRAC_SLL_4_skip;			\
+	       --_FP_FRAC_SLL_4_i)					\
+	    X##_f[_FP_FRAC_SLL_4_i]					\
+	      = ((X##_f[_FP_FRAC_SLL_4_i-_FP_FRAC_SLL_4_skip]		\
+		  << _FP_FRAC_SLL_4_up)					\
+		 | (X##_f[_FP_FRAC_SLL_4_i-_FP_FRAC_SLL_4_skip-1]	\
+		    >> _FP_FRAC_SLL_4_down));				\
+	  X##_f[_FP_FRAC_SLL_4_i--] = X##_f[0] << _FP_FRAC_SLL_4_up;	\
+	}								\
+      for (; _FP_FRAC_SLL_4_i >= 0; --_FP_FRAC_SLL_4_i)			\
+	X##_f[_FP_FRAC_SLL_4_i] = 0;					\
+    }									\
+  while (0)
+
+/* This one was broken too.  */
+#define _FP_FRAC_SRL_4(X, N)						\
+  do									\
+    {									\
+      _FP_I_TYPE _FP_FRAC_SRL_4_up, _FP_FRAC_SRL_4_down;		\
+      _FP_I_TYPE _FP_FRAC_SRL_4_skip, _FP_FRAC_SRL_4_i;			\
+      _FP_FRAC_SRL_4_skip = (N) / _FP_W_TYPE_SIZE;			\
+      _FP_FRAC_SRL_4_down = (N) % _FP_W_TYPE_SIZE;			\
+      _FP_FRAC_SRL_4_up = _FP_W_TYPE_SIZE - _FP_FRAC_SRL_4_down;	\
+      if (!_FP_FRAC_SRL_4_down)						\
+	for (_FP_FRAC_SRL_4_i = 0;					\
+	     _FP_FRAC_SRL_4_i <= 3-_FP_FRAC_SRL_4_skip;			\
+	     ++_FP_FRAC_SRL_4_i)					\
+	  X##_f[_FP_FRAC_SRL_4_i]					\
+	    = X##_f[_FP_FRAC_SRL_4_i+_FP_FRAC_SRL_4_skip];		\
+      else								\
+	{								\
+	  for (_FP_FRAC_SRL_4_i = 0;					\
+	       _FP_FRAC_SRL_4_i < 3-_FP_FRAC_SRL_4_skip;		\
+	       ++_FP_FRAC_SRL_4_i)					\
+	    X##_f[_FP_FRAC_SRL_4_i]					\
+	      = ((X##_f[_FP_FRAC_SRL_4_i+_FP_FRAC_SRL_4_skip]		\
+		  >> _FP_FRAC_SRL_4_down)				\
+		 | (X##_f[_FP_FRAC_SRL_4_i+_FP_FRAC_SRL_4_skip+1]	\
+		    << _FP_FRAC_SRL_4_up));				\
+	  X##_f[_FP_FRAC_SRL_4_i++] = X##_f[3] >> _FP_FRAC_SRL_4_down;	\
+	}								\
+      for (; _FP_FRAC_SRL_4_i < 4; ++_FP_FRAC_SRL_4_i)			\
+	X##_f[_FP_FRAC_SRL_4_i] = 0;					\
+    }									\
+  while (0)
+
+
+/* Right shift with sticky-lsb.
+   What this actually means is that we do a standard right-shift,
+   but that if any of the bits that fall off the right hand side
+   were one then we always set the LSbit.  */
+#define _FP_FRAC_SRST_4(X, S, N, size)					\
+  do									\
+    {									\
+      _FP_I_TYPE _FP_FRAC_SRST_4_up, _FP_FRAC_SRST_4_down;		\
+      _FP_I_TYPE _FP_FRAC_SRST_4_skip, _FP_FRAC_SRST_4_i;		\
+      _FP_W_TYPE _FP_FRAC_SRST_4_s;					\
+      _FP_FRAC_SRST_4_skip = (N) / _FP_W_TYPE_SIZE;			\
+      _FP_FRAC_SRST_4_down = (N) % _FP_W_TYPE_SIZE;			\
+      _FP_FRAC_SRST_4_up = _FP_W_TYPE_SIZE - _FP_FRAC_SRST_4_down;	\
+      for (_FP_FRAC_SRST_4_s = _FP_FRAC_SRST_4_i = 0;			\
+	   _FP_FRAC_SRST_4_i < _FP_FRAC_SRST_4_skip;			\
+	   ++_FP_FRAC_SRST_4_i)						\
+	_FP_FRAC_SRST_4_s |= X##_f[_FP_FRAC_SRST_4_i];			\
+      if (!_FP_FRAC_SRST_4_down)					\
+	for (_FP_FRAC_SRST_4_i = 0;					\
+	     _FP_FRAC_SRST_4_i <= 3-_FP_FRAC_SRST_4_skip;		\
+	     ++_FP_FRAC_SRST_4_i)					\
+	  X##_f[_FP_FRAC_SRST_4_i]					\
+	    = X##_f[_FP_FRAC_SRST_4_i+_FP_FRAC_SRST_4_skip];		\
+      else								\
+	{								\
+	  _FP_FRAC_SRST_4_s						\
+	    |= X##_f[_FP_FRAC_SRST_4_i] << _FP_FRAC_SRST_4_up;		\
+	  for (_FP_FRAC_SRST_4_i = 0;					\
+	       _FP_FRAC_SRST_4_i < 3-_FP_FRAC_SRST_4_skip;		\
+	       ++_FP_FRAC_SRST_4_i)					\
+	    X##_f[_FP_FRAC_SRST_4_i]					\
+	      = ((X##_f[_FP_FRAC_SRST_4_i+_FP_FRAC_SRST_4_skip]		\
+		  >> _FP_FRAC_SRST_4_down)				\
+		 | (X##_f[_FP_FRAC_SRST_4_i+_FP_FRAC_SRST_4_skip+1]	\
+		    << _FP_FRAC_SRST_4_up));				\
+	  X##_f[_FP_FRAC_SRST_4_i++]					\
+	    = X##_f[3] >> _FP_FRAC_SRST_4_down;				\
+	}								\
+      for (; _FP_FRAC_SRST_4_i < 4; ++_FP_FRAC_SRST_4_i)		\
+	X##_f[_FP_FRAC_SRST_4_i] = 0;					\
+      S = (_FP_FRAC_SRST_4_s != 0);					\
+    }									\
+  while (0)
+
+#define _FP_FRAC_SRS_4(X, N, size)				\
+  do								\
+    {								\
+      int _FP_FRAC_SRS_4_sticky;				\
+      _FP_FRAC_SRST_4 (X, _FP_FRAC_SRS_4_sticky, (N), (size));	\
+      X##_f[0] |= _FP_FRAC_SRS_4_sticky;			\
+    }								\
+  while (0)
+
+#define _FP_FRAC_ADD_4(R, X, Y)					\
+  __FP_FRAC_ADD_4 (R##_f[3], R##_f[2], R##_f[1], R##_f[0],	\
+		   X##_f[3], X##_f[2], X##_f[1], X##_f[0],	\
+		   Y##_f[3], Y##_f[2], Y##_f[1], Y##_f[0])
+
+#define _FP_FRAC_SUB_4(R, X, Y)					\
+  __FP_FRAC_SUB_4 (R##_f[3], R##_f[2], R##_f[1], R##_f[0],	\
+		   X##_f[3], X##_f[2], X##_f[1], X##_f[0],	\
+		   Y##_f[3], Y##_f[2], Y##_f[1], Y##_f[0])
+
+#define _FP_FRAC_DEC_4(X, Y)					\
+  __FP_FRAC_DEC_4 (X##_f[3], X##_f[2], X##_f[1], X##_f[0],	\
+		   Y##_f[3], Y##_f[2], Y##_f[1], Y##_f[0])
+
+#define _FP_FRAC_ADDI_4(X, I)					\
+  __FP_FRAC_ADDI_4 (X##_f[3], X##_f[2], X##_f[1], X##_f[0], I)
+
+#define _FP_ZEROFRAC_4  0, 0, 0, 0
+#define _FP_MINFRAC_4   0, 0, 0, 1
+#define _FP_MAXFRAC_4	(~(_FP_WS_TYPE) 0), (~(_FP_WS_TYPE) 0), (~(_FP_WS_TYPE) 0), (~(_FP_WS_TYPE) 0)
 
 #define _FP_FRAC_ZEROP_4(X)     ((X##_f[0] | X##_f[1] | X##_f[2] | X##_f[3]) = 0)
-#define _FP_FRAC_NEGP_4(X)      ((_FP_WS_TYPE)X##_f[3] < 0)
-#define _FP_FRAC_OVERP_4(fs,X)  (_FP_FRAC_HIGH_##fs(X) & _FP_OVERFLOW_##fs)
-#define _FP_FRAC_CLEAR_OVERP_4(fs,X)  (_FP_FRAC_HIGH_##fs(X) &= ~_FP_OVERFLOW_##fs)
-
-#define _FP_FRAC_EQ_4(X,Y)				\
- (X##_f[0] = Y##_f[0] && X##_f[1] = Y##_f[1]		\
-  && X##_f[2] = Y##_f[2] && X##_f[3] = Y##_f[3])
-
-#define _FP_FRAC_GT_4(X,Y)				\
- (X##_f[3] > Y##_f[3] ||				\
-  (X##_f[3] = Y##_f[3] && (X##_f[2] > Y##_f[2] ||	\
-   (X##_f[2] = Y##_f[2] && (X##_f[1] > Y##_f[1] ||	\
-    (X##_f[1] = Y##_f[1] && X##_f[0] > Y##_f[0])	\
-   ))							\
-  ))							\
- )
-
-#define _FP_FRAC_GE_4(X,Y)				\
- (X##_f[3] > Y##_f[3] ||				\
-  (X##_f[3] = Y##_f[3] && (X##_f[2] > Y##_f[2] ||	\
-   (X##_f[2] = Y##_f[2] && (X##_f[1] > Y##_f[1] ||	\
-    (X##_f[1] = Y##_f[1] && X##_f[0] >= Y##_f[0])	\
-   ))							\
-  ))							\
- )
-
-
-#define _FP_FRAC_CLZ_4(R,X)		\
-  do {					\
-    if (X##_f[3])			\
-    {					\
-	__FP_CLZ(R,X##_f[3]);		\
-    }					\
-    else if (X##_f[2])			\
-    {					\
-	__FP_CLZ(R,X##_f[2]);		\
-	R += _FP_W_TYPE_SIZE;		\
-    }					\
-    else if (X##_f[1])			\
-    {					\
-	__FP_CLZ(R,X##_f[2]);		\
-	R += _FP_W_TYPE_SIZE*2;		\
-    }					\
-    else				\
-    {					\
-	__FP_CLZ(R,X##_f[0]);		\
-	R += _FP_W_TYPE_SIZE*3;		\
-    }					\
-  } while(0)
-
-
-#define _FP_UNPACK_RAW_4(fs, X, val)				\
-  do {								\
-    union _FP_UNION_##fs _flo; _flo.flt = (val);		\
-    X##_f[0] = _flo.bits.frac0;					\
-    X##_f[1] = _flo.bits.frac1;					\
-    X##_f[2] = _flo.bits.frac2;					\
-    X##_f[3] = _flo.bits.frac3;					\
-    X##_e  = _flo.bits.exp;					\
-    X##_s  = _flo.bits.sign;					\
-  } while (0)
-
-#define _FP_UNPACK_RAW_4_P(fs, X, val)				\
-  do {								\
-    union _FP_UNION_##fs *_flo =				\
-      (union _FP_UNION_##fs *)(val);				\
-								\
-    X##_f[0] = _flo->bits.frac0;				\
-    X##_f[1] = _flo->bits.frac1;				\
-    X##_f[2] = _flo->bits.frac2;				\
-    X##_f[3] = _flo->bits.frac3;				\
-    X##_e  = _flo->bits.exp;					\
-    X##_s  = _flo->bits.sign;					\
-  } while (0)
-
-#define _FP_PACK_RAW_4(fs, val, X)				\
-  do {								\
-    union _FP_UNION_##fs _flo;					\
-    _flo.bits.frac0 = X##_f[0];					\
-    _flo.bits.frac1 = X##_f[1];					\
-    _flo.bits.frac2 = X##_f[2];					\
-    _flo.bits.frac3 = X##_f[3];					\
-    _flo.bits.exp   = X##_e;					\
-    _flo.bits.sign  = X##_s;					\
-    (val) = _flo.flt;				   		\
-  } while (0)
-
-#define _FP_PACK_RAW_4_P(fs, val, X)				\
-  do {								\
-    union _FP_UNION_##fs *_flo =				\
-      (union _FP_UNION_##fs *)(val);				\
-								\
-    _flo->bits.frac0 = X##_f[0];				\
-    _flo->bits.frac1 = X##_f[1];				\
-    _flo->bits.frac2 = X##_f[2];				\
-    _flo->bits.frac3 = X##_f[3];				\
-    _flo->bits.exp   = X##_e;					\
-    _flo->bits.sign  = X##_s;					\
-  } while (0)
-
-/*
- * Multiplication algorithms:
- */
+#define _FP_FRAC_NEGP_4(X)      ((_FP_WS_TYPE) X##_f[3] < 0)
+#define _FP_FRAC_OVERP_4(fs, X)  (_FP_FRAC_HIGH_##fs (X) & _FP_OVERFLOW_##fs)
+#define _FP_FRAC_HIGHBIT_DW_4(fs, X)	\
+  (_FP_FRAC_HIGH_DW_##fs (X) & _FP_HIGHBIT_DW_##fs)
+#define _FP_FRAC_CLEAR_OVERP_4(fs, X)  (_FP_FRAC_HIGH_##fs (X) &= ~_FP_OVERFLOW_##fs)
+
+#define _FP_FRAC_EQ_4(X, Y)				\
+  (X##_f[0] = Y##_f[0] && X##_f[1] = Y##_f[1]		\
+   && X##_f[2] = Y##_f[2] && X##_f[3] = Y##_f[3])
+
+#define _FP_FRAC_GT_4(X, Y)				\
+  (X##_f[3] > Y##_f[3]					\
+   || (X##_f[3] = Y##_f[3]				\
+       && (X##_f[2] > Y##_f[2]				\
+	   || (X##_f[2] = Y##_f[2]			\
+	       && (X##_f[1] > Y##_f[1]			\
+		   || (X##_f[1] = Y##_f[1]		\
+		       && X##_f[0] > Y##_f[0]))))))
+
+#define _FP_FRAC_GE_4(X, Y)				\
+  (X##_f[3] > Y##_f[3]					\
+   || (X##_f[3] = Y##_f[3]				\
+       && (X##_f[2] > Y##_f[2]				\
+	   || (X##_f[2] = Y##_f[2]			\
+	       && (X##_f[1] > Y##_f[1]			\
+		   || (X##_f[1] = Y##_f[1]		\
+		       && X##_f[0] >= Y##_f[0]))))))
+
+
+#define _FP_FRAC_CLZ_4(R, X)			\
+  do						\
+    {						\
+      if (X##_f[3])				\
+	__FP_CLZ ((R), X##_f[3]);		\
+      else if (X##_f[2])			\
+	{					\
+	  __FP_CLZ ((R), X##_f[2]);		\
+	  (R) += _FP_W_TYPE_SIZE;		\
+	}					\
+      else if (X##_f[1])			\
+	{					\
+	  __FP_CLZ ((R), X##_f[1]);		\
+	  (R) += _FP_W_TYPE_SIZE*2;		\
+	}					\
+      else					\
+	{					\
+	  __FP_CLZ ((R), X##_f[0]);		\
+	  (R) += _FP_W_TYPE_SIZE*3;		\
+	}					\
+    }						\
+  while (0)
+
+
+#define _FP_UNPACK_RAW_4(fs, X, val)			\
+  do							\
+    {							\
+      union _FP_UNION_##fs _FP_UNPACK_RAW_4_flo;	\
+      _FP_UNPACK_RAW_4_flo.flt = (val);			\
+      X##_f[0] = _FP_UNPACK_RAW_4_flo.bits.frac0;	\
+      X##_f[1] = _FP_UNPACK_RAW_4_flo.bits.frac1;	\
+      X##_f[2] = _FP_UNPACK_RAW_4_flo.bits.frac2;	\
+      X##_f[3] = _FP_UNPACK_RAW_4_flo.bits.frac3;	\
+      X##_e  = _FP_UNPACK_RAW_4_flo.bits.exp;		\
+      X##_s  = _FP_UNPACK_RAW_4_flo.bits.sign;		\
+    }							\
+  while (0)
+
+#define _FP_UNPACK_RAW_4_P(fs, X, val)			\
+  do							\
+    {							\
+      union _FP_UNION_##fs *_FP_UNPACK_RAW_4_P_flo	\
+	= (union _FP_UNION_##fs *) (val);		\
+							\
+      X##_f[0] = _FP_UNPACK_RAW_4_P_flo->bits.frac0;	\
+      X##_f[1] = _FP_UNPACK_RAW_4_P_flo->bits.frac1;	\
+      X##_f[2] = _FP_UNPACK_RAW_4_P_flo->bits.frac2;	\
+      X##_f[3] = _FP_UNPACK_RAW_4_P_flo->bits.frac3;	\
+      X##_e  = _FP_UNPACK_RAW_4_P_flo->bits.exp;	\
+      X##_s  = _FP_UNPACK_RAW_4_P_flo->bits.sign;	\
+    }							\
+  while (0)
+
+#define _FP_PACK_RAW_4(fs, val, X)		\
+  do						\
+    {						\
+      union _FP_UNION_##fs _FP_PACK_RAW_4_flo;	\
+      _FP_PACK_RAW_4_flo.bits.frac0 = X##_f[0];	\
+      _FP_PACK_RAW_4_flo.bits.frac1 = X##_f[1];	\
+      _FP_PACK_RAW_4_flo.bits.frac2 = X##_f[2];	\
+      _FP_PACK_RAW_4_flo.bits.frac3 = X##_f[3];	\
+      _FP_PACK_RAW_4_flo.bits.exp   = X##_e;	\
+      _FP_PACK_RAW_4_flo.bits.sign  = X##_s;	\
+      (val) = _FP_PACK_RAW_4_flo.flt;		\
+    }						\
+  while (0)
+
+#define _FP_PACK_RAW_4_P(fs, val, X)			\
+  do							\
+    {							\
+      union _FP_UNION_##fs *_FP_PACK_RAW_4_P_flo	\
+	= (union _FP_UNION_##fs *) (val);		\
+							\
+      _FP_PACK_RAW_4_P_flo->bits.frac0 = X##_f[0];	\
+      _FP_PACK_RAW_4_P_flo->bits.frac1 = X##_f[1];	\
+      _FP_PACK_RAW_4_P_flo->bits.frac2 = X##_f[2];	\
+      _FP_PACK_RAW_4_P_flo->bits.frac3 = X##_f[3];	\
+      _FP_PACK_RAW_4_P_flo->bits.exp   = X##_e;		\
+      _FP_PACK_RAW_4_P_flo->bits.sign  = X##_s;		\
+    }							\
+  while (0)
+
+/* Multiplication algorithms: */
 
 /* Given a 1W * 1W => 2W primitive, do the extended multiplication.  */
 
-#define _FP_MUL_MEAT_4_wide(wfracbits, R, X, Y, doit)			    \
-  do {									    \
-    _FP_FRAC_DECL_8(_z); _FP_FRAC_DECL_2(_b); _FP_FRAC_DECL_2(_c);	    \
-    _FP_FRAC_DECL_2(_d); _FP_FRAC_DECL_2(_e); _FP_FRAC_DECL_2(_f);	    \
-									    \
-    doit(_FP_FRAC_WORD_8(_z,1), _FP_FRAC_WORD_8(_z,0), X##_f[0], Y##_f[0]); \
-    doit(_b_f1, _b_f0, X##_f[0], Y##_f[1]);				    \
-    doit(_c_f1, _c_f0, X##_f[1], Y##_f[0]);				    \
-    doit(_d_f1, _d_f0, X##_f[1], Y##_f[1]);				    \
-    doit(_e_f1, _e_f0, X##_f[0], Y##_f[2]);				    \
-    doit(_f_f1, _f_f0, X##_f[2], Y##_f[0]);				    \
-    __FP_FRAC_ADD_3(_FP_FRAC_WORD_8(_z,3),_FP_FRAC_WORD_8(_z,2),	    \
-		    _FP_FRAC_WORD_8(_z,1), 0,_b_f1,_b_f0,		    \
-		    0,0,_FP_FRAC_WORD_8(_z,1));				    \
-    __FP_FRAC_ADD_3(_FP_FRAC_WORD_8(_z,3),_FP_FRAC_WORD_8(_z,2),	    \
-		    _FP_FRAC_WORD_8(_z,1), 0,_c_f1,_c_f0,		    \
-		    _FP_FRAC_WORD_8(_z,3),_FP_FRAC_WORD_8(_z,2),	    \
-		    _FP_FRAC_WORD_8(_z,1));				    \
-    __FP_FRAC_ADD_3(_FP_FRAC_WORD_8(_z,4),_FP_FRAC_WORD_8(_z,3),	    \
-		    _FP_FRAC_WORD_8(_z,2), 0,_d_f1,_d_f0,		    \
-		    0,_FP_FRAC_WORD_8(_z,3),_FP_FRAC_WORD_8(_z,2));	    \
-    __FP_FRAC_ADD_3(_FP_FRAC_WORD_8(_z,4),_FP_FRAC_WORD_8(_z,3),	    \
-		    _FP_FRAC_WORD_8(_z,2), 0,_e_f1,_e_f0,		    \
-		    _FP_FRAC_WORD_8(_z,4),_FP_FRAC_WORD_8(_z,3),	    \
-		    _FP_FRAC_WORD_8(_z,2));				    \
-    __FP_FRAC_ADD_3(_FP_FRAC_WORD_8(_z,4),_FP_FRAC_WORD_8(_z,3),	    \
-		    _FP_FRAC_WORD_8(_z,2), 0,_f_f1,_f_f0,		    \
-		    _FP_FRAC_WORD_8(_z,4),_FP_FRAC_WORD_8(_z,3),	    \
-		    _FP_FRAC_WORD_8(_z,2));				    \
-    doit(_b_f1, _b_f0, X##_f[0], Y##_f[3]);				    \
-    doit(_c_f1, _c_f0, X##_f[3], Y##_f[0]);				    \
-    doit(_d_f1, _d_f0, X##_f[1], Y##_f[2]);				    \
-    doit(_e_f1, _e_f0, X##_f[2], Y##_f[1]);				    \
-    __FP_FRAC_ADD_3(_FP_FRAC_WORD_8(_z,5),_FP_FRAC_WORD_8(_z,4),	    \
-		    _FP_FRAC_WORD_8(_z,3), 0,_b_f1,_b_f0,		    \
-		    0,_FP_FRAC_WORD_8(_z,4),_FP_FRAC_WORD_8(_z,3));	    \
-    __FP_FRAC_ADD_3(_FP_FRAC_WORD_8(_z,5),_FP_FRAC_WORD_8(_z,4),	    \
-		    _FP_FRAC_WORD_8(_z,3), 0,_c_f1,_c_f0,		    \
-		    _FP_FRAC_WORD_8(_z,5),_FP_FRAC_WORD_8(_z,4),	    \
-		    _FP_FRAC_WORD_8(_z,3));				    \
-    __FP_FRAC_ADD_3(_FP_FRAC_WORD_8(_z,5),_FP_FRAC_WORD_8(_z,4),	    \
-		    _FP_FRAC_WORD_8(_z,3), 0,_d_f1,_d_f0,		    \
-		    _FP_FRAC_WORD_8(_z,5),_FP_FRAC_WORD_8(_z,4),	    \
-		    _FP_FRAC_WORD_8(_z,3));				    \
-    __FP_FRAC_ADD_3(_FP_FRAC_WORD_8(_z,5),_FP_FRAC_WORD_8(_z,4),	    \
-		    _FP_FRAC_WORD_8(_z,3), 0,_e_f1,_e_f0,		    \
-		    _FP_FRAC_WORD_8(_z,5),_FP_FRAC_WORD_8(_z,4),	    \
-		    _FP_FRAC_WORD_8(_z,3));				    \
-    doit(_b_f1, _b_f0, X##_f[2], Y##_f[2]);				    \
-    doit(_c_f1, _c_f0, X##_f[1], Y##_f[3]);				    \
-    doit(_d_f1, _d_f0, X##_f[3], Y##_f[1]);				    \
-    doit(_e_f1, _e_f0, X##_f[2], Y##_f[3]);				    \
-    doit(_f_f1, _f_f0, X##_f[3], Y##_f[2]);				    \
-    __FP_FRAC_ADD_3(_FP_FRAC_WORD_8(_z,6),_FP_FRAC_WORD_8(_z,5),	    \
-		    _FP_FRAC_WORD_8(_z,4), 0,_b_f1,_b_f0,		    \
-		    0,_FP_FRAC_WORD_8(_z,5),_FP_FRAC_WORD_8(_z,4));	    \
-    __FP_FRAC_ADD_3(_FP_FRAC_WORD_8(_z,6),_FP_FRAC_WORD_8(_z,5),	    \
-		    _FP_FRAC_WORD_8(_z,4), 0,_c_f1,_c_f0,		    \
-		    _FP_FRAC_WORD_8(_z,6),_FP_FRAC_WORD_8(_z,5),	    \
-		    _FP_FRAC_WORD_8(_z,4));				    \
-    __FP_FRAC_ADD_3(_FP_FRAC_WORD_8(_z,6),_FP_FRAC_WORD_8(_z,5),	    \
-		    _FP_FRAC_WORD_8(_z,4), 0,_d_f1,_d_f0,		    \
-		    _FP_FRAC_WORD_8(_z,6),_FP_FRAC_WORD_8(_z,5),	    \
-		    _FP_FRAC_WORD_8(_z,4));				    \
-    __FP_FRAC_ADD_3(_FP_FRAC_WORD_8(_z,7),_FP_FRAC_WORD_8(_z,6),	    \
-		    _FP_FRAC_WORD_8(_z,5), 0,_e_f1,_e_f0,		    \
-		    0,_FP_FRAC_WORD_8(_z,6),_FP_FRAC_WORD_8(_z,5));	    \
-    __FP_FRAC_ADD_3(_FP_FRAC_WORD_8(_z,7),_FP_FRAC_WORD_8(_z,6),	    \
-		    _FP_FRAC_WORD_8(_z,5), 0,_f_f1,_f_f0,		    \
-		    _FP_FRAC_WORD_8(_z,7),_FP_FRAC_WORD_8(_z,6),	    \
-		    _FP_FRAC_WORD_8(_z,5));				    \
-    doit(_b_f1, _b_f0, X##_f[3], Y##_f[3]);				    \
-    __FP_FRAC_ADD_2(_FP_FRAC_WORD_8(_z,7),_FP_FRAC_WORD_8(_z,6),	    \
-		    _b_f1,_b_f0,					    \
-		    _FP_FRAC_WORD_8(_z,7),_FP_FRAC_WORD_8(_z,6));	    \
-									    \
-    /* Normalize since we know where the msb of the multiplicands	    \
-       were (bit B), we know that the msb of the of the product is	    \
-       at either 2B or 2B-1.  */					    \
-    _FP_FRAC_SRS_8(_z, wfracbits-1, 2*wfracbits);			    \
-    __FP_FRAC_SET_4(R, _FP_FRAC_WORD_8(_z,3), _FP_FRAC_WORD_8(_z,2),	    \
-		    _FP_FRAC_WORD_8(_z,1), _FP_FRAC_WORD_8(_z,0));	    \
-  } while (0)
-
-#define _FP_MUL_MEAT_4_gmp(wfracbits, R, X, Y)				    \
-  do {									    \
-    _FP_FRAC_DECL_8(_z);						    \
-									    \
-    mpn_mul_n(_z_f, _x_f, _y_f, 4);					    \
-									    \
-    /* Normalize since we know where the msb of the multiplicands	    \
-       were (bit B), we know that the msb of the of the product is	    \
-       at either 2B or 2B-1.  */					    \
-    _FP_FRAC_SRS_8(_z, wfracbits-1, 2*wfracbits);	 		    \
-    __FP_FRAC_SET_4(R, _FP_FRAC_WORD_8(_z,3), _FP_FRAC_WORD_8(_z,2),	    \
-		    _FP_FRAC_WORD_8(_z,1), _FP_FRAC_WORD_8(_z,0));	    \
-  } while (0)
-
-/*
- * Helper utility for _FP_DIV_MEAT_4_udiv:
- * pppp = m * nnn
- */
-#define umul_ppppmnnn(p3,p2,p1,p0,m,n2,n1,n0)				    \
-  do {									    \
-    UWtype _t;								    \
-    umul_ppmm(p1,p0,m,n0);						    \
-    umul_ppmm(p2,_t,m,n1);						    \
-    __FP_FRAC_ADDI_2(p2,p1,_t);						    \
-    umul_ppmm(p3,_t,m,n2);						    \
-    __FP_FRAC_ADDI_2(p3,p2,_t);						    \
-  } while (0)
-
-/*
- * Division algorithms:
- */
-
-#define _FP_DIV_MEAT_4_udiv(fs, R, X, Y)				    \
-  do {									    \
-    int _i;								    \
-    _FP_FRAC_DECL_4(_n); _FP_FRAC_DECL_4(_m);				    \
-    _FP_FRAC_SET_4(_n, _FP_ZEROFRAC_4);					    \
-    if (_FP_FRAC_GT_4(X, Y))						    \
-      {									    \
-	_n_f[3] = X##_f[0] << (_FP_W_TYPE_SIZE - 1);			    \
-	_FP_FRAC_SRL_4(X, 1);						    \
-      }									    \
-    else								    \
-      R##_e--;								    \
-									    \
-    /* Normalize, i.e. make the most significant bit of the 		    \
-       denominator set. */						    \
-    _FP_FRAC_SLL_4(Y, _FP_WFRACXBITS_##fs);				    \
-									    \
-    for (_i = 3; ; _i--)						    \
-      {									    \
-        if (X##_f[3] = Y##_f[3])					    \
-          {								    \
-            /* This is a special case, not an optimization		    \
-               (X##_f[3]/Y##_f[3] would not fit into UWtype).		    \
-               As X## is guaranteed to be < Y,  R##_f[_i] can be either	    \
-               (UWtype)-1 or (UWtype)-2.  */				    \
-            R##_f[_i] = -1;						    \
-            if (!_i)							    \
-	      break;							    \
-            __FP_FRAC_SUB_4(X##_f[3], X##_f[2], X##_f[1], X##_f[0],	    \
-			    Y##_f[2], Y##_f[1], Y##_f[0], 0,		    \
-			    X##_f[2], X##_f[1], X##_f[0], _n_f[_i]);	    \
-            _FP_FRAC_SUB_4(X, Y, X);					    \
-            if (X##_f[3] > Y##_f[3])					    \
-              {								    \
-                R##_f[_i] = -2;						    \
-                _FP_FRAC_ADD_4(X, Y, X);				    \
-              }								    \
-          }								    \
-        else								    \
-          {								    \
-            udiv_qrnnd(R##_f[_i], X##_f[3], X##_f[3], X##_f[2], Y##_f[3]);  \
-            umul_ppppmnnn(_m_f[3], _m_f[2], _m_f[1], _m_f[0],		    \
-			  R##_f[_i], Y##_f[2], Y##_f[1], Y##_f[0]);	    \
-            X##_f[2] = X##_f[1];					    \
-            X##_f[1] = X##_f[0];					    \
-            X##_f[0] = _n_f[_i];					    \
-            if (_FP_FRAC_GT_4(_m, X))					    \
-              {								    \
-                R##_f[_i]--;						    \
-                _FP_FRAC_ADD_4(X, Y, X);				    \
-                if (_FP_FRAC_GE_4(X, Y) && _FP_FRAC_GT_4(_m, X))	    \
-                  {							    \
-		    R##_f[_i]--;					    \
-		    _FP_FRAC_ADD_4(X, Y, X);				    \
-                  }							    \
-              }								    \
-            _FP_FRAC_DEC_4(X, _m);					    \
-            if (!_i)							    \
-	      {								    \
-		if (!_FP_FRAC_EQ_4(X, _m))				    \
-		  R##_f[0] |= _FP_WORK_STICKY;				    \
-		break;							    \
-	      }								    \
-          }								    \
-      }									    \
-  } while (0)
-
-
-/*
- * Square root algorithms:
- * We have just one right now, maybe Newton approximation
- * should be added for those machines where division is fast.
- */
- 
-#define _FP_SQRT_MEAT_4(R, S, T, X, q)				\
-  do {								\
-    while (q)							\
-      {								\
-	T##_f[3] = S##_f[3] + q;				\
-	if (T##_f[3] <= X##_f[3])				\
-	  {							\
-	    S##_f[3] = T##_f[3] + q;				\
-	    X##_f[3] -= T##_f[3];				\
-	    R##_f[3] += q;					\
-	  }							\
-	_FP_FRAC_SLL_4(X, 1);					\
-	q >>= 1;						\
-      }								\
-    q = (_FP_W_TYPE)1 << (_FP_W_TYPE_SIZE - 1);			\
-    while (q)							\
-      {								\
-	T##_f[2] = S##_f[2] + q;				\
-	T##_f[3] = S##_f[3];					\
-	if (T##_f[3] < X##_f[3] || 				\
-	    (T##_f[3] = X##_f[3] && T##_f[2] <= X##_f[2]))	\
-	  {							\
-	    S##_f[2] = T##_f[2] + q;				\
-	    S##_f[3] += (T##_f[2] > S##_f[2]);			\
-	    __FP_FRAC_DEC_2(X##_f[3], X##_f[2],			\
-			    T##_f[3], T##_f[2]);		\
-	    R##_f[2] += q;					\
-	  }							\
-	_FP_FRAC_SLL_4(X, 1);					\
-	q >>= 1;						\
-      }								\
-    q = (_FP_W_TYPE)1 << (_FP_W_TYPE_SIZE - 1);			\
-    while (q)							\
-      {								\
-	T##_f[1] = S##_f[1] + q;				\
-	T##_f[2] = S##_f[2];					\
-	T##_f[3] = S##_f[3];					\
-	if (T##_f[3] < X##_f[3] || 				\
-	    (T##_f[3] = X##_f[3] && (T##_f[2] < X##_f[2] ||	\
-	     (T##_f[2] = X##_f[2] && T##_f[1] <= X##_f[1]))))	\
-	  {							\
-	    S##_f[1] = T##_f[1] + q;				\
-	    S##_f[2] += (T##_f[1] > S##_f[1]);			\
-	    S##_f[3] += (T##_f[2] > S##_f[2]);			\
-	    __FP_FRAC_DEC_3(X##_f[3], X##_f[2], X##_f[1],	\
-	    		    T##_f[3], T##_f[2], T##_f[1]);	\
-	    R##_f[1] += q;					\
-	  }							\
-	_FP_FRAC_SLL_4(X, 1);					\
-	q >>= 1;						\
-      }								\
-    q = (_FP_W_TYPE)1 << (_FP_W_TYPE_SIZE - 1);			\
-    while (q != _FP_WORK_ROUND)					\
-      {								\
-	T##_f[0] = S##_f[0] + q;				\
-	T##_f[1] = S##_f[1];					\
-	T##_f[2] = S##_f[2];					\
-	T##_f[3] = S##_f[3];					\
-	if (_FP_FRAC_GE_4(X,T))					\
-	  {							\
-	    S##_f[0] = T##_f[0] + q;				\
-	    S##_f[1] += (T##_f[0] > S##_f[0]);			\
-	    S##_f[2] += (T##_f[1] > S##_f[1]);			\
-	    S##_f[3] += (T##_f[2] > S##_f[2]);			\
-	    _FP_FRAC_DEC_4(X, T);				\
-	    R##_f[0] += q;					\
-	  }							\
-	_FP_FRAC_SLL_4(X, 1);					\
-	q >>= 1;						\
-      }								\
-    if (!_FP_FRAC_ZEROP_4(X))					\
-      {								\
-	if (_FP_FRAC_GT_4(X,S))					\
-	  R##_f[0] |= _FP_WORK_ROUND;				\
-	R##_f[0] |= _FP_WORK_STICKY;				\
-      }								\
-  } while (0)
-
-
-/*
- * Internals 
- */
-
-#define __FP_FRAC_SET_4(X,I3,I2,I1,I0)					\
+#define _FP_MUL_MEAT_DW_4_wide(wfracbits, R, X, Y, doit)		\
+  do									\
+    {									\
+      _FP_FRAC_DECL_2 (_FP_MUL_MEAT_DW_4_wide_b);			\
+      _FP_FRAC_DECL_2 (_FP_MUL_MEAT_DW_4_wide_c);			\
+      _FP_FRAC_DECL_2 (_FP_MUL_MEAT_DW_4_wide_d);			\
+      _FP_FRAC_DECL_2 (_FP_MUL_MEAT_DW_4_wide_e);			\
+      _FP_FRAC_DECL_2 (_FP_MUL_MEAT_DW_4_wide_f);			\
+									\
+      doit (_FP_FRAC_WORD_8 (R, 1), _FP_FRAC_WORD_8 (R, 0),		\
+	    X##_f[0], Y##_f[0]);					\
+      doit (_FP_MUL_MEAT_DW_4_wide_b_f1, _FP_MUL_MEAT_DW_4_wide_b_f0,	\
+	    X##_f[0], Y##_f[1]);					\
+      doit (_FP_MUL_MEAT_DW_4_wide_c_f1, _FP_MUL_MEAT_DW_4_wide_c_f0,	\
+	    X##_f[1], Y##_f[0]);					\
+      doit (_FP_MUL_MEAT_DW_4_wide_d_f1, _FP_MUL_MEAT_DW_4_wide_d_f0,	\
+	    X##_f[1], Y##_f[1]);					\
+      doit (_FP_MUL_MEAT_DW_4_wide_e_f1, _FP_MUL_MEAT_DW_4_wide_e_f0,	\
+	    X##_f[0], Y##_f[2]);					\
+      doit (_FP_MUL_MEAT_DW_4_wide_f_f1, _FP_MUL_MEAT_DW_4_wide_f_f0,	\
+	    X##_f[2], Y##_f[0]);					\
+      __FP_FRAC_ADD_3 (_FP_FRAC_WORD_8 (R, 3), _FP_FRAC_WORD_8 (R, 2),	\
+		       _FP_FRAC_WORD_8 (R, 1), 0,			\
+		       _FP_MUL_MEAT_DW_4_wide_b_f1,			\
+		       _FP_MUL_MEAT_DW_4_wide_b_f0,			\
+		       0, 0, _FP_FRAC_WORD_8 (R, 1));			\
+      __FP_FRAC_ADD_3 (_FP_FRAC_WORD_8 (R, 3), _FP_FRAC_WORD_8 (R, 2),	\
+		       _FP_FRAC_WORD_8 (R, 1), 0,			\
+		       _FP_MUL_MEAT_DW_4_wide_c_f1,			\
+		       _FP_MUL_MEAT_DW_4_wide_c_f0,			\
+		       _FP_FRAC_WORD_8 (R, 3), _FP_FRAC_WORD_8 (R, 2),	\
+		       _FP_FRAC_WORD_8 (R, 1));				\
+      __FP_FRAC_ADD_3 (_FP_FRAC_WORD_8 (R, 4), _FP_FRAC_WORD_8 (R, 3),	\
+		       _FP_FRAC_WORD_8 (R, 2), 0,			\
+		       _FP_MUL_MEAT_DW_4_wide_d_f1,			\
+		       _FP_MUL_MEAT_DW_4_wide_d_f0,			\
+		       0, _FP_FRAC_WORD_8 (R, 3), _FP_FRAC_WORD_8 (R, 2)); \
+      __FP_FRAC_ADD_3 (_FP_FRAC_WORD_8 (R, 4), _FP_FRAC_WORD_8 (R, 3),	\
+		       _FP_FRAC_WORD_8 (R, 2), 0,			\
+		       _FP_MUL_MEAT_DW_4_wide_e_f1,			\
+		       _FP_MUL_MEAT_DW_4_wide_e_f0,			\
+		       _FP_FRAC_WORD_8 (R, 4), _FP_FRAC_WORD_8 (R, 3),	\
+		       _FP_FRAC_WORD_8 (R, 2));				\
+      __FP_FRAC_ADD_3 (_FP_FRAC_WORD_8 (R, 4), _FP_FRAC_WORD_8 (R, 3),	\
+		       _FP_FRAC_WORD_8 (R, 2), 0,			\
+		       _FP_MUL_MEAT_DW_4_wide_f_f1,			\
+		       _FP_MUL_MEAT_DW_4_wide_f_f0,			\
+		       _FP_FRAC_WORD_8 (R, 4), _FP_FRAC_WORD_8 (R, 3),	\
+		       _FP_FRAC_WORD_8 (R, 2));				\
+      doit (_FP_MUL_MEAT_DW_4_wide_b_f1,				\
+	    _FP_MUL_MEAT_DW_4_wide_b_f0, X##_f[0], Y##_f[3]);		\
+      doit (_FP_MUL_MEAT_DW_4_wide_c_f1,				\
+	    _FP_MUL_MEAT_DW_4_wide_c_f0, X##_f[3], Y##_f[0]);		\
+      doit (_FP_MUL_MEAT_DW_4_wide_d_f1, _FP_MUL_MEAT_DW_4_wide_d_f0,	\
+	    X##_f[1], Y##_f[2]);					\
+      doit (_FP_MUL_MEAT_DW_4_wide_e_f1, _FP_MUL_MEAT_DW_4_wide_e_f0,	\
+	    X##_f[2], Y##_f[1]);					\
+      __FP_FRAC_ADD_3 (_FP_FRAC_WORD_8 (R, 5), _FP_FRAC_WORD_8 (R, 4),	\
+		       _FP_FRAC_WORD_8 (R, 3), 0,			\
+		       _FP_MUL_MEAT_DW_4_wide_b_f1,			\
+		       _FP_MUL_MEAT_DW_4_wide_b_f0,			\
+		       0, _FP_FRAC_WORD_8 (R, 4), _FP_FRAC_WORD_8 (R, 3)); \
+      __FP_FRAC_ADD_3 (_FP_FRAC_WORD_8 (R, 5), _FP_FRAC_WORD_8 (R, 4),	\
+		       _FP_FRAC_WORD_8 (R, 3), 0,			\
+		       _FP_MUL_MEAT_DW_4_wide_c_f1,			\
+		       _FP_MUL_MEAT_DW_4_wide_c_f0,			\
+		       _FP_FRAC_WORD_8 (R, 5), _FP_FRAC_WORD_8 (R, 4),	\
+		       _FP_FRAC_WORD_8 (R, 3));				\
+      __FP_FRAC_ADD_3 (_FP_FRAC_WORD_8 (R, 5), _FP_FRAC_WORD_8 (R, 4),	\
+		       _FP_FRAC_WORD_8 (R, 3), 0,			\
+		       _FP_MUL_MEAT_DW_4_wide_d_f1,			\
+		       _FP_MUL_MEAT_DW_4_wide_d_f0,			\
+		       _FP_FRAC_WORD_8 (R, 5), _FP_FRAC_WORD_8 (R, 4),	\
+		       _FP_FRAC_WORD_8 (R, 3));				\
+      __FP_FRAC_ADD_3 (_FP_FRAC_WORD_8 (R, 5), _FP_FRAC_WORD_8 (R, 4),	\
+		       _FP_FRAC_WORD_8 (R, 3), 0,			\
+		       _FP_MUL_MEAT_DW_4_wide_e_f1,			\
+		       _FP_MUL_MEAT_DW_4_wide_e_f0,			\
+		       _FP_FRAC_WORD_8 (R, 5), _FP_FRAC_WORD_8 (R, 4),	\
+		       _FP_FRAC_WORD_8 (R, 3));				\
+      doit (_FP_MUL_MEAT_DW_4_wide_b_f1, _FP_MUL_MEAT_DW_4_wide_b_f0,	\
+	    X##_f[2], Y##_f[2]);					\
+      doit (_FP_MUL_MEAT_DW_4_wide_c_f1, _FP_MUL_MEAT_DW_4_wide_c_f0,	\
+	    X##_f[1], Y##_f[3]);					\
+      doit (_FP_MUL_MEAT_DW_4_wide_d_f1, _FP_MUL_MEAT_DW_4_wide_d_f0,	\
+	    X##_f[3], Y##_f[1]);					\
+      doit (_FP_MUL_MEAT_DW_4_wide_e_f1, _FP_MUL_MEAT_DW_4_wide_e_f0,	\
+	    X##_f[2], Y##_f[3]);					\
+      doit (_FP_MUL_MEAT_DW_4_wide_f_f1, _FP_MUL_MEAT_DW_4_wide_f_f0,	\
+	    X##_f[3], Y##_f[2]);					\
+      __FP_FRAC_ADD_3 (_FP_FRAC_WORD_8 (R, 6), _FP_FRAC_WORD_8 (R, 5),	\
+		       _FP_FRAC_WORD_8 (R, 4), 0,			\
+		       _FP_MUL_MEAT_DW_4_wide_b_f1,			\
+		       _FP_MUL_MEAT_DW_4_wide_b_f0,			\
+		       0, _FP_FRAC_WORD_8 (R, 5), _FP_FRAC_WORD_8 (R, 4)); \
+      __FP_FRAC_ADD_3 (_FP_FRAC_WORD_8 (R, 6), _FP_FRAC_WORD_8 (R, 5),	\
+		       _FP_FRAC_WORD_8 (R, 4), 0,			\
+		       _FP_MUL_MEAT_DW_4_wide_c_f1,			\
+		       _FP_MUL_MEAT_DW_4_wide_c_f0,			\
+		       _FP_FRAC_WORD_8 (R, 6), _FP_FRAC_WORD_8 (R, 5),	\
+		       _FP_FRAC_WORD_8 (R, 4));				\
+      __FP_FRAC_ADD_3 (_FP_FRAC_WORD_8 (R, 6), _FP_FRAC_WORD_8 (R, 5),	\
+		       _FP_FRAC_WORD_8 (R, 4), 0,			\
+		       _FP_MUL_MEAT_DW_4_wide_d_f1,			\
+		       _FP_MUL_MEAT_DW_4_wide_d_f0,			\
+		       _FP_FRAC_WORD_8 (R, 6), _FP_FRAC_WORD_8 (R, 5),	\
+		       _FP_FRAC_WORD_8 (R, 4));				\
+      __FP_FRAC_ADD_3 (_FP_FRAC_WORD_8 (R, 7), _FP_FRAC_WORD_8 (R, 6),	\
+		       _FP_FRAC_WORD_8 (R, 5), 0,			\
+		       _FP_MUL_MEAT_DW_4_wide_e_f1,			\
+		       _FP_MUL_MEAT_DW_4_wide_e_f0,			\
+		       0, _FP_FRAC_WORD_8 (R, 6), _FP_FRAC_WORD_8 (R, 5)); \
+      __FP_FRAC_ADD_3 (_FP_FRAC_WORD_8 (R, 7), _FP_FRAC_WORD_8 (R, 6),	\
+		       _FP_FRAC_WORD_8 (R, 5), 0,			\
+		       _FP_MUL_MEAT_DW_4_wide_f_f1,			\
+		       _FP_MUL_MEAT_DW_4_wide_f_f0,			\
+		       _FP_FRAC_WORD_8 (R, 7), _FP_FRAC_WORD_8 (R, 6),	\
+		       _FP_FRAC_WORD_8 (R, 5));				\
+      doit (_FP_MUL_MEAT_DW_4_wide_b_f1, _FP_MUL_MEAT_DW_4_wide_b_f0,	\
+	    X##_f[3], Y##_f[3]);					\
+      __FP_FRAC_ADD_2 (_FP_FRAC_WORD_8 (R, 7), _FP_FRAC_WORD_8 (R, 6),	\
+		       _FP_MUL_MEAT_DW_4_wide_b_f1,			\
+		       _FP_MUL_MEAT_DW_4_wide_b_f0,			\
+		       _FP_FRAC_WORD_8 (R, 7), _FP_FRAC_WORD_8 (R, 6));	\
+    }									\
+  while (0)
+
+#define _FP_MUL_MEAT_4_wide(wfracbits, R, X, Y, doit)			\
+  do									\
+    {									\
+      _FP_FRAC_DECL_8 (_FP_MUL_MEAT_4_wide_z);				\
+									\
+      _FP_MUL_MEAT_DW_4_wide ((wfracbits), _FP_MUL_MEAT_4_wide_z,	\
+			      X, Y, doit);				\
+									\
+      /* Normalize since we know where the msb of the multiplicands	\
+	 were (bit B), we know that the msb of the of the product is	\
+	 at either 2B or 2B-1.  */					\
+      _FP_FRAC_SRS_8 (_FP_MUL_MEAT_4_wide_z, (wfracbits)-1,		\
+		      2*(wfracbits));					\
+      __FP_FRAC_SET_4 (R, _FP_FRAC_WORD_8 (_FP_MUL_MEAT_4_wide_z, 3),	\
+		       _FP_FRAC_WORD_8 (_FP_MUL_MEAT_4_wide_z, 2),	\
+		       _FP_FRAC_WORD_8 (_FP_MUL_MEAT_4_wide_z, 1),	\
+		       _FP_FRAC_WORD_8 (_FP_MUL_MEAT_4_wide_z, 0));	\
+    }									\
+  while (0)
+
+#define _FP_MUL_MEAT_DW_4_gmp(wfracbits, R, X, Y)	\
+  do							\
+    {							\
+      mpn_mul_n (R##_f, _x_f, _y_f, 4);			\
+    }							\
+  while (0)
+
+#define _FP_MUL_MEAT_4_gmp(wfracbits, R, X, Y)				\
+  do									\
+    {									\
+      _FP_FRAC_DECL_8 (_FP_MUL_MEAT_4_gmp_z);				\
+									\
+      _FP_MUL_MEAT_DW_4_gmp ((wfracbits), _FP_MUL_MEAT_4_gmp_z, X, Y);	\
+									\
+      /* Normalize since we know where the msb of the multiplicands	\
+	 were (bit B), we know that the msb of the of the product is	\
+	 at either 2B or 2B-1.  */					\
+      _FP_FRAC_SRS_8 (_FP_MUL_MEAT_4_gmp_z, (wfracbits)-1,		\
+		      2*(wfracbits));					\
+      __FP_FRAC_SET_4 (R, _FP_FRAC_WORD_8 (_FP_MUL_MEAT_4_gmp_z, 3),	\
+		       _FP_FRAC_WORD_8 (_FP_MUL_MEAT_4_gmp_z, 2),	\
+		       _FP_FRAC_WORD_8 (_FP_MUL_MEAT_4_gmp_z, 1),	\
+		       _FP_FRAC_WORD_8 (_FP_MUL_MEAT_4_gmp_z, 0));	\
+    }									\
+  while (0)
+
+/* Helper utility for _FP_DIV_MEAT_4_udiv:
+ * pppp = m * nnn.  */
+#define umul_ppppmnnn(p3, p2, p1, p0, m, n2, n1, n0)	\
+  do							\
+    {							\
+      UWtype umul_ppppmnnn_t;				\
+      umul_ppmm (p1, p0, m, n0);			\
+      umul_ppmm (p2, umul_ppppmnnn_t, m, n1);		\
+      __FP_FRAC_ADDI_2 (p2, p1, umul_ppppmnnn_t);	\
+      umul_ppmm (p3, umul_ppppmnnn_t, m, n2);		\
+      __FP_FRAC_ADDI_2 (p3, p2, umul_ppppmnnn_t);	\
+    }							\
+  while (0)
+
+/* Division algorithms: */
+
+#define _FP_DIV_MEAT_4_udiv(fs, R, X, Y)				\
+  do									\
+    {									\
+      int _FP_DIV_MEAT_4_udiv_i;					\
+      _FP_FRAC_DECL_4 (_FP_DIV_MEAT_4_udiv_n);				\
+      _FP_FRAC_DECL_4 (_FP_DIV_MEAT_4_udiv_m);				\
+      _FP_FRAC_SET_4 (_FP_DIV_MEAT_4_udiv_n, _FP_ZEROFRAC_4);		\
+      if (_FP_FRAC_GE_4 (X, Y))						\
+	{								\
+	  _FP_DIV_MEAT_4_udiv_n_f[3]					\
+	    = X##_f[0] << (_FP_W_TYPE_SIZE - 1);			\
+	  _FP_FRAC_SRL_4 (X, 1);					\
+	}								\
+      else								\
+	R##_e--;							\
+									\
+      /* Normalize, i.e. make the most significant bit of the		\
+	 denominator set.  */						\
+      _FP_FRAC_SLL_4 (Y, _FP_WFRACXBITS_##fs);				\
+									\
+      for (_FP_DIV_MEAT_4_udiv_i = 3; ; _FP_DIV_MEAT_4_udiv_i--)	\
+	{								\
+	  if (X##_f[3] = Y##_f[3])					\
+	    {								\
+	      /* This is a special case, not an optimization		\
+		 (X##_f[3]/Y##_f[3] would not fit into UWtype).		\
+		 As X## is guaranteed to be < Y,			\
+		 R##_f[_FP_DIV_MEAT_4_udiv_i] can be either		\
+		 (UWtype)-1 or (UWtype)-2.  */				\
+	      R##_f[_FP_DIV_MEAT_4_udiv_i] = -1;			\
+	      if (!_FP_DIV_MEAT_4_udiv_i)				\
+		break;							\
+	      __FP_FRAC_SUB_4 (X##_f[3], X##_f[2], X##_f[1], X##_f[0],	\
+			       Y##_f[2], Y##_f[1], Y##_f[0], 0,		\
+			       X##_f[2], X##_f[1], X##_f[0],		\
+			       _FP_DIV_MEAT_4_udiv_n_f[_FP_DIV_MEAT_4_udiv_i]); \
+	      _FP_FRAC_SUB_4 (X, Y, X);					\
+	      if (X##_f[3] > Y##_f[3])					\
+		{							\
+		  R##_f[_FP_DIV_MEAT_4_udiv_i] = -2;			\
+		  _FP_FRAC_ADD_4 (X, Y, X);				\
+		}							\
+	    }								\
+	  else								\
+	    {								\
+	      udiv_qrnnd (R##_f[_FP_DIV_MEAT_4_udiv_i],			\
+			  X##_f[3], X##_f[3], X##_f[2], Y##_f[3]);	\
+	      umul_ppppmnnn (_FP_DIV_MEAT_4_udiv_m_f[3],		\
+			     _FP_DIV_MEAT_4_udiv_m_f[2],		\
+			     _FP_DIV_MEAT_4_udiv_m_f[1],		\
+			     _FP_DIV_MEAT_4_udiv_m_f[0],		\
+			     R##_f[_FP_DIV_MEAT_4_udiv_i],		\
+			     Y##_f[2], Y##_f[1], Y##_f[0]);		\
+	      X##_f[2] = X##_f[1];					\
+	      X##_f[1] = X##_f[0];					\
+	      X##_f[0]							\
+		= _FP_DIV_MEAT_4_udiv_n_f[_FP_DIV_MEAT_4_udiv_i];	\
+	      if (_FP_FRAC_GT_4 (_FP_DIV_MEAT_4_udiv_m, X))		\
+		{							\
+		  R##_f[_FP_DIV_MEAT_4_udiv_i]--;			\
+		  _FP_FRAC_ADD_4 (X, Y, X);				\
+		  if (_FP_FRAC_GE_4 (X, Y)				\
+		      && _FP_FRAC_GT_4 (_FP_DIV_MEAT_4_udiv_m, X))	\
+		    {							\
+		      R##_f[_FP_DIV_MEAT_4_udiv_i]--;			\
+		      _FP_FRAC_ADD_4 (X, Y, X);				\
+		    }							\
+		}							\
+	      _FP_FRAC_DEC_4 (X, _FP_DIV_MEAT_4_udiv_m);		\
+	      if (!_FP_DIV_MEAT_4_udiv_i)				\
+		{							\
+		  if (!_FP_FRAC_EQ_4 (X, _FP_DIV_MEAT_4_udiv_m))	\
+		    R##_f[0] |= _FP_WORK_STICKY;			\
+		  break;						\
+		}							\
+	    }								\
+	}								\
+    }									\
+  while (0)
+
+
+/* Square root algorithms:
+   We have just one right now, maybe Newton approximation
+   should be added for those machines where division is fast.  */
+
+#define _FP_SQRT_MEAT_4(R, S, T, X, q)					\
+  do									\
+    {									\
+      while (q)								\
+	{								\
+	  T##_f[3] = S##_f[3] + (q);					\
+	  if (T##_f[3] <= X##_f[3])					\
+	    {								\
+	      S##_f[3] = T##_f[3] + (q);				\
+	      X##_f[3] -= T##_f[3];					\
+	      R##_f[3] += (q);						\
+	    }								\
+	  _FP_FRAC_SLL_4 (X, 1);					\
+	  (q) >>= 1;							\
+	}								\
+      (q) = (_FP_W_TYPE) 1 << (_FP_W_TYPE_SIZE - 1);			\
+      while (q)								\
+	{								\
+	  T##_f[2] = S##_f[2] + (q);					\
+	  T##_f[3] = S##_f[3];						\
+	  if (T##_f[3] < X##_f[3]					\
+	      || (T##_f[3] = X##_f[3] && T##_f[2] <= X##_f[2]))	\
+	    {								\
+	      S##_f[2] = T##_f[2] + (q);				\
+	      S##_f[3] += (T##_f[2] > S##_f[2]);			\
+	      __FP_FRAC_DEC_2 (X##_f[3], X##_f[2],			\
+			       T##_f[3], T##_f[2]);			\
+	      R##_f[2] += (q);						\
+	    }								\
+	  _FP_FRAC_SLL_4 (X, 1);					\
+	  (q) >>= 1;							\
+	}								\
+      (q) = (_FP_W_TYPE) 1 << (_FP_W_TYPE_SIZE - 1);			\
+      while (q)								\
+	{								\
+	  T##_f[1] = S##_f[1] + (q);					\
+	  T##_f[2] = S##_f[2];						\
+	  T##_f[3] = S##_f[3];						\
+	  if (T##_f[3] < X##_f[3]					\
+	      || (T##_f[3] = X##_f[3]					\
+		  && (T##_f[2] < X##_f[2]				\
+		      || (T##_f[2] = X##_f[2]				\
+			  && T##_f[1] <= X##_f[1]))))			\
+	    {								\
+	      S##_f[1] = T##_f[1] + (q);				\
+	      S##_f[2] += (T##_f[1] > S##_f[1]);			\
+	      S##_f[3] += (T##_f[2] > S##_f[2]);			\
+	      __FP_FRAC_DEC_3 (X##_f[3], X##_f[2], X##_f[1],		\
+			       T##_f[3], T##_f[2], T##_f[1]);		\
+	      R##_f[1] += (q);						\
+	    }								\
+	  _FP_FRAC_SLL_4 (X, 1);					\
+	  (q) >>= 1;							\
+	}								\
+      (q) = (_FP_W_TYPE) 1 << (_FP_W_TYPE_SIZE - 1);			\
+      while ((q) != _FP_WORK_ROUND)					\
+	{								\
+	  T##_f[0] = S##_f[0] + (q);					\
+	  T##_f[1] = S##_f[1];						\
+	  T##_f[2] = S##_f[2];						\
+	  T##_f[3] = S##_f[3];						\
+	  if (_FP_FRAC_GE_4 (X, T))					\
+	    {								\
+	      S##_f[0] = T##_f[0] + (q);				\
+	      S##_f[1] += (T##_f[0] > S##_f[0]);			\
+	      S##_f[2] += (T##_f[1] > S##_f[1]);			\
+	      S##_f[3] += (T##_f[2] > S##_f[2]);			\
+	      _FP_FRAC_DEC_4 (X, T);					\
+	      R##_f[0] += (q);						\
+	    }								\
+	  _FP_FRAC_SLL_4 (X, 1);					\
+	  (q) >>= 1;							\
+	}								\
+      if (!_FP_FRAC_ZEROP_4 (X))					\
+	{								\
+	  if (_FP_FRAC_GT_4 (X, S))					\
+	    R##_f[0] |= _FP_WORK_ROUND;					\
+	  R##_f[0] |= _FP_WORK_STICKY;					\
+	}								\
+    }									\
+  while (0)
+
+
+/* Internals.  */
+
+#define __FP_FRAC_SET_4(X, I3, I2, I1, I0)			\
   (X##_f[3] = I3, X##_f[2] = I2, X##_f[1] = I1, X##_f[0] = I0)
 
 #ifndef __FP_FRAC_ADD_3
-#define __FP_FRAC_ADD_3(r2,r1,r0,x2,x1,x0,y2,y1,y0)		\
-  do {								\
-    int _c1, _c2;							\
-    r0 = x0 + y0;						\
-    _c1 = r0 < x0;						\
-    r1 = x1 + y1;						\
-    _c2 = r1 < x1;						\
-    r1 += _c1;							\
-    _c2 |= r1 < _c1;						\
-    r2 = x2 + y2 + _c2;						\
-  } while (0)
+# define __FP_FRAC_ADD_3(r2, r1, r0, x2, x1, x0, y2, y1, y0)	\
+  do								\
+    {								\
+      _FP_W_TYPE __FP_FRAC_ADD_3_c1, __FP_FRAC_ADD_3_c2;	\
+      r0 = x0 + y0;						\
+      __FP_FRAC_ADD_3_c1 = r0 < x0;				\
+      r1 = x1 + y1;						\
+      __FP_FRAC_ADD_3_c2 = r1 < x1;				\
+      r1 += __FP_FRAC_ADD_3_c1;					\
+      __FP_FRAC_ADD_3_c2 |= r1 < __FP_FRAC_ADD_3_c1;		\
+      r2 = x2 + y2 + __FP_FRAC_ADD_3_c2;			\
+    }								\
+  while (0)
 #endif
 
 #ifndef __FP_FRAC_ADD_4
-#define __FP_FRAC_ADD_4(r3,r2,r1,r0,x3,x2,x1,x0,y3,y2,y1,y0)	\
-  do {								\
-    int _c1, _c2, _c3;						\
-    r0 = x0 + y0;						\
-    _c1 = r0 < x0;						\
-    r1 = x1 + y1;						\
-    _c2 = r1 < x1;						\
-    r1 += _c1;							\
-    _c2 |= r1 < _c1;						\
-    r2 = x2 + y2;						\
-    _c3 = r2 < x2;						\
-    r2 += _c2;							\
-    _c3 |= r2 < _c2;						\
-    r3 = x3 + y3 + _c3;						\
-  } while (0)
+# define __FP_FRAC_ADD_4(r3, r2, r1, r0, x3, x2, x1, x0, y3, y2, y1, y0) \
+  do									\
+    {									\
+      _FP_W_TYPE __FP_FRAC_ADD_4_c1, __FP_FRAC_ADD_4_c2;		\
+      _FP_W_TYPE __FP_FRAC_ADD_4_c3;					\
+      r0 = x0 + y0;							\
+      __FP_FRAC_ADD_4_c1 = r0 < x0;					\
+      r1 = x1 + y1;							\
+      __FP_FRAC_ADD_4_c2 = r1 < x1;					\
+      r1 += __FP_FRAC_ADD_4_c1;						\
+      __FP_FRAC_ADD_4_c2 |= r1 < __FP_FRAC_ADD_4_c1;			\
+      r2 = x2 + y2;							\
+      __FP_FRAC_ADD_4_c3 = r2 < x2;					\
+      r2 += __FP_FRAC_ADD_4_c2;						\
+      __FP_FRAC_ADD_4_c3 |= r2 < __FP_FRAC_ADD_4_c2;			\
+      r3 = x3 + y3 + __FP_FRAC_ADD_4_c3;				\
+    }									\
+  while (0)
 #endif
 
 #ifndef __FP_FRAC_SUB_3
-#define __FP_FRAC_SUB_3(r2,r1,r0,x2,x1,x0,y2,y1,y0)		\
-  do {								\
-    int _c1, _c2;							\
-    r0 = x0 - y0;						\
-    _c1 = r0 > x0;						\
-    r1 = x1 - y1;						\
-    _c2 = r1 > x1;						\
-    r1 -= _c1;							\
-    _c2 |= r1 > _c1;						\
-    r2 = x2 - y2 - _c2;						\
-  } while (0)
+# define __FP_FRAC_SUB_3(r2, r1, r0, x2, x1, x0, y2, y1, y0)	\
+  do								\
+    {								\
+      _FP_W_TYPE __FP_FRAC_SUB_3_c1, __FP_FRAC_SUB_3_c2;	\
+      r0 = x0 - y0;						\
+      __FP_FRAC_SUB_3_c1 = r0 > x0;				\
+      r1 = x1 - y1;						\
+      __FP_FRAC_SUB_3_c2 = r1 > x1;				\
+      r1 -= __FP_FRAC_SUB_3_c1;					\
+      __FP_FRAC_SUB_3_c2 |= __FP_FRAC_SUB_3_c1 && (y1 = x1);	\
+      r2 = x2 - y2 - __FP_FRAC_SUB_3_c2;			\
+    }								\
+  while (0)
 #endif
 
 #ifndef __FP_FRAC_SUB_4
-#define __FP_FRAC_SUB_4(r3,r2,r1,r0,x3,x2,x1,x0,y3,y2,y1,y0)	\
-  do {								\
-    int _c1, _c2, _c3;						\
-    r0 = x0 - y0;						\
-    _c1 = r0 > x0;						\
-    r1 = x1 - y1;						\
-    _c2 = r1 > x1;						\
-    r1 -= _c1;							\
-    _c2 |= r1 > _c1;						\
-    r2 = x2 - y2;						\
-    _c3 = r2 > x2;						\
-    r2 -= _c2;							\
-    _c3 |= r2 > _c2;						\
-    r3 = x3 - y3 - _c3;						\
-  } while (0)
+# define __FP_FRAC_SUB_4(r3, r2, r1, r0, x3, x2, x1, x0, y3, y2, y1, y0) \
+  do									\
+    {									\
+      _FP_W_TYPE __FP_FRAC_SUB_4_c1, __FP_FRAC_SUB_4_c2;		\
+      _FP_W_TYPE __FP_FRAC_SUB_4_c3;					\
+      r0 = x0 - y0;							\
+      __FP_FRAC_SUB_4_c1 = r0 > x0;					\
+      r1 = x1 - y1;							\
+      __FP_FRAC_SUB_4_c2 = r1 > x1;					\
+      r1 -= __FP_FRAC_SUB_4_c1;						\
+      __FP_FRAC_SUB_4_c2 |= __FP_FRAC_SUB_4_c1 && (y1 = x1);		\
+      r2 = x2 - y2;							\
+      __FP_FRAC_SUB_4_c3 = r2 > x2;					\
+      r2 -= __FP_FRAC_SUB_4_c2;						\
+      __FP_FRAC_SUB_4_c3 |= __FP_FRAC_SUB_4_c2 && (y2 = x2);		\
+      r3 = x3 - y3 - __FP_FRAC_SUB_4_c3;				\
+    }									\
+  while (0)
 #endif
 
 #ifndef __FP_FRAC_DEC_3
-#define __FP_FRAC_DEC_3(x2,x1,x0,y2,y1,y0)				\
-  do {									\
-    UWtype _t0, _t1, _t2;						\
-    _t0 = x0, _t1 = x1, _t2 = x2;					\
-    __FP_FRAC_SUB_3 (x2, x1, x0, _t2, _t1, _t0, y2, y1, y0);		\
-  } while (0)
+# define __FP_FRAC_DEC_3(x2, x1, x0, y2, y1, y0)		\
+  do								\
+    {								\
+      UWtype __FP_FRAC_DEC_3_t0, __FP_FRAC_DEC_3_t1;		\
+      UWtype __FP_FRAC_DEC_3_t2;				\
+      __FP_FRAC_DEC_3_t0 = x0;					\
+      __FP_FRAC_DEC_3_t1 = x1;					\
+      __FP_FRAC_DEC_3_t2 = x2;					\
+      __FP_FRAC_SUB_3 (x2, x1, x0, __FP_FRAC_DEC_3_t2,		\
+		       __FP_FRAC_DEC_3_t1, __FP_FRAC_DEC_3_t0,	\
+		       y2, y1, y0);				\
+    }								\
+  while (0)
 #endif
 
 #ifndef __FP_FRAC_DEC_4
-#define __FP_FRAC_DEC_4(x3,x2,x1,x0,y3,y2,y1,y0)			\
-  do {									\
-    UWtype _t0, _t1, _t2, _t3;						\
-    _t0 = x0, _t1 = x1, _t2 = x2, _t3 = x3;				\
-    __FP_FRAC_SUB_4 (x3,x2,x1,x0,_t3,_t2,_t1,_t0, y3,y2,y1,y0);		\
-  } while (0)
+# define __FP_FRAC_DEC_4(x3, x2, x1, x0, y3, y2, y1, y0)	\
+  do								\
+    {								\
+      UWtype __FP_FRAC_DEC_4_t0, __FP_FRAC_DEC_4_t1;		\
+      UWtype __FP_FRAC_DEC_4_t2, __FP_FRAC_DEC_4_t3;		\
+      __FP_FRAC_DEC_4_t0 = x0;					\
+      __FP_FRAC_DEC_4_t1 = x1;					\
+      __FP_FRAC_DEC_4_t2 = x2;					\
+      __FP_FRAC_DEC_4_t3 = x3;					\
+      __FP_FRAC_SUB_4 (x3, x2, x1, x0, __FP_FRAC_DEC_4_t3,	\
+		       __FP_FRAC_DEC_4_t2, __FP_FRAC_DEC_4_t1,	\
+		       __FP_FRAC_DEC_4_t0, y3, y2, y1, y0);	\
+    }								\
+  while (0)
 #endif
 
 #ifndef __FP_FRAC_ADDI_4
-#define __FP_FRAC_ADDI_4(x3,x2,x1,x0,i)					\
-  do {									\
-    UWtype _t;								\
-    _t = ((x0 += i) < i);						\
-    x1 += _t; _t = (x1 < _t);						\
-    x2 += _t; _t = (x2 < _t);						\
-    x3 += _t;								\
-  } while (0)
+# define __FP_FRAC_ADDI_4(x3, x2, x1, x0, i)		\
+  do							\
+    {							\
+      UWtype __FP_FRAC_ADDI_4_t;			\
+      __FP_FRAC_ADDI_4_t = ((x0 += i) < i);		\
+      x1 += __FP_FRAC_ADDI_4_t;				\
+      __FP_FRAC_ADDI_4_t = (x1 < __FP_FRAC_ADDI_4_t);	\
+      x2 += __FP_FRAC_ADDI_4_t;				\
+      __FP_FRAC_ADDI_4_t = (x2 < __FP_FRAC_ADDI_4_t);	\
+      x3 += __FP_FRAC_ADDI_4_t;				\
+    }							\
+  while (0)
 #endif
 
 /* Convert FP values between word sizes. This appears to be more
- * complicated than I'd have expected it to be, so these might be
- * wrong... These macros are in any case somewhat bogus because they
- * use information about what various FRAC_n variables look like 
- * internally [eg, that 2 word vars are X_f0 and x_f1]. But so do
- * the ones in op-2.h and op-1.h. 
- */
-#define _FP_FRAC_CONV_1_4(dfs, sfs, D, S)				\
-   do {									\
-     if (S##_c != FP_CLS_NAN)						\
-       _FP_FRAC_SRS_4(S, (_FP_WFRACBITS_##sfs - _FP_WFRACBITS_##dfs),	\
-			  _FP_WFRACBITS_##sfs);				\
-     else								\
-       _FP_FRAC_SRL_4(S, (_FP_WFRACBITS_##sfs - _FP_WFRACBITS_##dfs));	\
-     D##_f = S##_f[0];							\
-  } while (0)
-
-#define _FP_FRAC_CONV_2_4(dfs, sfs, D, S)				\
-   do {									\
-     if (S##_c != FP_CLS_NAN)						\
-       _FP_FRAC_SRS_4(S, (_FP_WFRACBITS_##sfs - _FP_WFRACBITS_##dfs),	\
-		      _FP_WFRACBITS_##sfs);				\
-     else								\
-       _FP_FRAC_SRL_4(S, (_FP_WFRACBITS_##sfs - _FP_WFRACBITS_##dfs));	\
-     D##_f0 = S##_f[0];							\
-     D##_f1 = S##_f[1];							\
-  } while (0)
-
-/* Assembly/disassembly for converting to/from integral types.  
- * No shifting or overflow handled here.
- */
-/* Put the FP value X into r, which is an integer of size rsize. */
+   complicated than I'd have expected it to be, so these might be
+   wrong... These macros are in any case somewhat bogus because they
+   use information about what various FRAC_n variables look like
+   internally [eg, that 2 word vars are X_f0 and x_f1]. But so do
+   the ones in op-2.h and op-1.h.  */
+#define _FP_FRAC_COPY_1_4(D, S)		(D##_f = S##_f[0])
+
+#define _FP_FRAC_COPY_2_4(D, S)			\
+  do						\
+    {						\
+      D##_f0 = S##_f[0];			\
+      D##_f1 = S##_f[1];			\
+    }						\
+  while (0)
+
+/* Assembly/disassembly for converting to/from integral types.
+   No shifting or overflow handled here.  */
+/* Put the FP value X into r, which is an integer of size rsize.  */
 #define _FP_FRAC_ASSEMBLE_4(r, X, rsize)				\
-  do {									\
-    if (rsize <= _FP_W_TYPE_SIZE)					\
-      r = X##_f[0];							\
-    else if (rsize <= 2*_FP_W_TYPE_SIZE)				\
+  do									\
     {									\
-      r = X##_f[1];							\
-      r <<= _FP_W_TYPE_SIZE;						\
-      r += X##_f[0];							\
+      if ((rsize) <= _FP_W_TYPE_SIZE)					\
+	(r) = X##_f[0];							\
+	else if ((rsize) <= 2*_FP_W_TYPE_SIZE)				\
+	{								\
+	  (r) = X##_f[1];						\
+	  (r) = ((rsize) <= _FP_W_TYPE_SIZE				\
+		 ? 0							\
+		 : (r) << _FP_W_TYPE_SIZE);				\
+	  (r) += X##_f[0];						\
+	}								\
+      else								\
+	{								\
+	  /* I'm feeling lazy so we deal with int = 3words		\
+	     (implausible) and int = 4words as a single case.  */	\
+	  (r) = X##_f[3];						\
+	  (r) = ((rsize) <= _FP_W_TYPE_SIZE				\
+		 ? 0							\
+		 : (r) << _FP_W_TYPE_SIZE);				\
+	  (r) += X##_f[2];						\
+	  (r) = ((rsize) <= _FP_W_TYPE_SIZE				\
+		 ? 0							\
+		 : (r) << _FP_W_TYPE_SIZE);				\
+	  (r) += X##_f[1];						\
+	  (r) = ((rsize) <= _FP_W_TYPE_SIZE				\
+		 ? 0							\
+		 : (r) << _FP_W_TYPE_SIZE);				\
+	  (r) += X##_f[0];						\
+	}								\
     }									\
-    else								\
-    {									\
-      /* I'm feeling lazy so we deal with int = 3words (implausible)*/	\
-      /* and int = 4words as a single case.			 */	\
-      r = X##_f[3];							\
-      r <<= _FP_W_TYPE_SIZE;						\
-      r += X##_f[2];							\
-      r <<= _FP_W_TYPE_SIZE;						\
-      r += X##_f[1];							\
-      r <<= _FP_W_TYPE_SIZE;						\
-      r += X##_f[0];							\
-    }									\
-  } while (0)
+  while (0)
 
 /* "No disassemble Number Five!" */
-/* move an integer of size rsize into X's fractional part. We rely on
- * the _f[] array consisting of words of size _FP_W_TYPE_SIZE to avoid
- * having to mask the values we store into it.
- */
-#define _FP_FRAC_DISASSEMBLE_4(X, r, rsize)				\
-  do {									\
-    X##_f[0] = r;							\
-    X##_f[1] = (rsize <= _FP_W_TYPE_SIZE ? 0 : r >> _FP_W_TYPE_SIZE);	\
-    X##_f[2] = (rsize <= 2*_FP_W_TYPE_SIZE ? 0 : r >> 2*_FP_W_TYPE_SIZE); \
-    X##_f[3] = (rsize <= 3*_FP_W_TYPE_SIZE ? 0 : r >> 3*_FP_W_TYPE_SIZE); \
-  } while (0)
-
-#define _FP_FRAC_CONV_4_1(dfs, sfs, D, S)				\
-   do {									\
-     D##_f[0] = S##_f;							\
-     D##_f[1] = D##_f[2] = D##_f[3] = 0;				\
-     _FP_FRAC_SLL_4(D, (_FP_WFRACBITS_##dfs - _FP_WFRACBITS_##sfs));	\
-   } while (0)
-
-#define _FP_FRAC_CONV_4_2(dfs, sfs, D, S)				\
-   do {									\
-     D##_f[0] = S##_f0;							\
-     D##_f[1] = S##_f1;							\
-     D##_f[2] = D##_f[3] = 0;						\
-     _FP_FRAC_SLL_4(D, (_FP_WFRACBITS_##dfs - _FP_WFRACBITS_##sfs));	\
-   } while (0)
-
-#endif
+/* Move an integer of size rsize into X's fractional part. We rely on
+   the _f[] array consisting of words of size _FP_W_TYPE_SIZE to avoid
+   having to mask the values we store into it.  */
+#define _FP_FRAC_DISASSEMBLE_4(X, r, rsize)	\
+  do						\
+    {						\
+      X##_f[0] = (r);				\
+      X##_f[1] = ((rsize) <= _FP_W_TYPE_SIZE	\
+		  ? 0				\
+		  : (r) >> _FP_W_TYPE_SIZE);	\
+      X##_f[2] = ((rsize) <= 2*_FP_W_TYPE_SIZE	\
+		  ? 0				\
+		  : (r) >> 2*_FP_W_TYPE_SIZE);	\
+      X##_f[3] = ((rsize) <= 3*_FP_W_TYPE_SIZE	\
+		  ? 0				\
+		  : (r) >> 3*_FP_W_TYPE_SIZE);	\
+    }						\
+  while (0)
+
+#define _FP_FRAC_COPY_4_1(D, S)			\
+  do						\
+    {						\
+      D##_f[0] = S##_f;				\
+      D##_f[1] = D##_f[2] = D##_f[3] = 0;	\
+    }						\
+  while (0)
+
+#define _FP_FRAC_COPY_4_2(D, S)			\
+  do						\
+    {						\
+      D##_f[0] = S##_f0;			\
+      D##_f[1] = S##_f1;			\
+      D##_f[2] = D##_f[3] = 0;			\
+    }						\
+  while (0)
+
+#define _FP_FRAC_COPY_4_4(D, S)	_FP_FRAC_COPY_4 (D, S)
+
+#endif /* !SOFT_FP_OP_4_H */
diff --git a/include/math-emu/op-8.h b/include/math-emu/op-8.h
index 8b8c05e..5267ae3 100644
--- a/include/math-emu/op-8.h
+++ b/include/math-emu/op-8.h
@@ -1,107 +1,150 @@
 /* Software floating-point emulation.
    Basic eight-word fraction declaration and manipulation.
-   Copyright (C) 1997,1998,1999 Free Software Foundation, Inc.
+   Copyright (C) 1997-2015 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
    Contributed by Richard Henderson (rth@cygnus.com),
 		  Jakub Jelinek (jj@ultra.linux.cz) and
 		  Peter Maydell (pmaydell@chiark.greenend.org.uk).
-                                                         
+
    The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Library General Public License as
-   published by the Free Software Foundation; either version 2 of the
-   License, or (at your option) any later version.
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   In addition to the permissions in the GNU Lesser General Public
+   License, the Free Software Foundation gives you unlimited
+   permission to link the compiled version of this file into
+   combinations with other programs, and to distribute those
+   combinations without any restriction coming from the use of this
+   file.  (The Lesser General Public License restrictions do apply in
+   other respects; for example, they cover modification of the file,
+   and distribution when not linked into a combine executable.)
 
    The GNU C Library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Library General Public License for more details.
+   Lesser General Public License for more details.
 
-   You should have received a copy of the GNU Library General Public
-   License along with the GNU C Library; see the file COPYING.LIB.  If
-   not, write to the Free Software Foundation, Inc.,
-   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
 
-#ifndef __MATH_EMU_OP_8_H__
-#define __MATH_EMU_OP_8_H__
+#ifndef SOFT_FP_OP_8_H
+#define SOFT_FP_OP_8_H	1
 
 /* We need just a few things from here for op-4, if we ever need some
-   other macros, they can be added. */
+   other macros, they can be added.  */
 #define _FP_FRAC_DECL_8(X)	_FP_W_TYPE X##_f[8]
 #define _FP_FRAC_HIGH_8(X)	(X##_f[7])
 #define _FP_FRAC_LOW_8(X)	(X##_f[0])
-#define _FP_FRAC_WORD_8(X,w)	(X##_f[w])
+#define _FP_FRAC_WORD_8(X, w)	(X##_f[w])
 
-#define _FP_FRAC_SLL_8(X,N)						\
-  do {									\
-    _FP_I_TYPE _up, _down, _skip, _i;					\
-    _skip = (N) / _FP_W_TYPE_SIZE;					\
-    _up = (N) % _FP_W_TYPE_SIZE;					\
-    _down = _FP_W_TYPE_SIZE - _up;					\
-    if (!_up)								\
-      for (_i = 7; _i >= _skip; --_i)					\
-	X##_f[_i] = X##_f[_i-_skip];					\
-    else								\
-      {									\
-	for (_i = 7; _i > _skip; --_i)					\
-	  X##_f[_i] = X##_f[_i-_skip] << _up				\
-		      | X##_f[_i-_skip-1] >> _down;			\
-	X##_f[_i--] = X##_f[0] << _up; 					\
-      }									\
-    for (; _i >= 0; --_i)						\
-      X##_f[_i] = 0;							\
-  } while (0)
+#define _FP_FRAC_SLL_8(X, N)						\
+  do									\
+    {									\
+      _FP_I_TYPE _FP_FRAC_SLL_8_up, _FP_FRAC_SLL_8_down;		\
+      _FP_I_TYPE _FP_FRAC_SLL_8_skip, _FP_FRAC_SLL_8_i;			\
+      _FP_FRAC_SLL_8_skip = (N) / _FP_W_TYPE_SIZE;			\
+      _FP_FRAC_SLL_8_up = (N) % _FP_W_TYPE_SIZE;			\
+      _FP_FRAC_SLL_8_down = _FP_W_TYPE_SIZE - _FP_FRAC_SLL_8_up;	\
+      if (!_FP_FRAC_SLL_8_up)						\
+	for (_FP_FRAC_SLL_8_i = 7;					\
+	     _FP_FRAC_SLL_8_i >= _FP_FRAC_SLL_8_skip;			\
+	     --_FP_FRAC_SLL_8_i)					\
+	  X##_f[_FP_FRAC_SLL_8_i]					\
+	    = X##_f[_FP_FRAC_SLL_8_i-_FP_FRAC_SLL_8_skip];		\
+      else								\
+	{								\
+	  for (_FP_FRAC_SLL_8_i = 7;					\
+	       _FP_FRAC_SLL_8_i > _FP_FRAC_SLL_8_skip;			\
+	       --_FP_FRAC_SLL_8_i)					\
+	    X##_f[_FP_FRAC_SLL_8_i]					\
+	      = ((X##_f[_FP_FRAC_SLL_8_i-_FP_FRAC_SLL_8_skip]		\
+		  << _FP_FRAC_SLL_8_up)					\
+		 | (X##_f[_FP_FRAC_SLL_8_i-_FP_FRAC_SLL_8_skip-1]	\
+		    >> _FP_FRAC_SLL_8_down));				\
+	  X##_f[_FP_FRAC_SLL_8_i--] = X##_f[0] << _FP_FRAC_SLL_8_up;	\
+	}								\
+      for (; _FP_FRAC_SLL_8_i >= 0; --_FP_FRAC_SLL_8_i)			\
+	X##_f[_FP_FRAC_SLL_8_i] = 0;					\
+    }									\
+  while (0)
 
-#define _FP_FRAC_SRL_8(X,N)						\
-  do {									\
-    _FP_I_TYPE _up, _down, _skip, _i;					\
-    _skip = (N) / _FP_W_TYPE_SIZE;					\
-    _down = (N) % _FP_W_TYPE_SIZE;					\
-    _up = _FP_W_TYPE_SIZE - _down;					\
-    if (!_down)								\
-      for (_i = 0; _i <= 7-_skip; ++_i)					\
-	X##_f[_i] = X##_f[_i+_skip];					\
-    else								\
-      {									\
-	for (_i = 0; _i < 7-_skip; ++_i)				\
-	  X##_f[_i] = X##_f[_i+_skip] >> _down				\
-		      | X##_f[_i+_skip+1] << _up;			\
-	X##_f[_i++] = X##_f[7] >> _down;				\
-      }									\
-    for (; _i < 8; ++_i)						\
-      X##_f[_i] = 0;							\
-  } while (0)
+#define _FP_FRAC_SRL_8(X, N)						\
+  do									\
+    {									\
+      _FP_I_TYPE _FP_FRAC_SRL_8_up, _FP_FRAC_SRL_8_down;		\
+      _FP_I_TYPE _FP_FRAC_SRL_8_skip, _FP_FRAC_SRL_8_i;			\
+      _FP_FRAC_SRL_8_skip = (N) / _FP_W_TYPE_SIZE;			\
+      _FP_FRAC_SRL_8_down = (N) % _FP_W_TYPE_SIZE;			\
+      _FP_FRAC_SRL_8_up = _FP_W_TYPE_SIZE - _FP_FRAC_SRL_8_down;	\
+      if (!_FP_FRAC_SRL_8_down)						\
+	for (_FP_FRAC_SRL_8_i = 0;					\
+	     _FP_FRAC_SRL_8_i <= 7-_FP_FRAC_SRL_8_skip;			\
+	     ++_FP_FRAC_SRL_8_i)					\
+	  X##_f[_FP_FRAC_SRL_8_i]					\
+	    = X##_f[_FP_FRAC_SRL_8_i+_FP_FRAC_SRL_8_skip];		\
+      else								\
+	{								\
+	  for (_FP_FRAC_SRL_8_i = 0;					\
+	       _FP_FRAC_SRL_8_i < 7-_FP_FRAC_SRL_8_skip;		\
+	       ++_FP_FRAC_SRL_8_i)					\
+	    X##_f[_FP_FRAC_SRL_8_i]					\
+	      = ((X##_f[_FP_FRAC_SRL_8_i+_FP_FRAC_SRL_8_skip]		\
+		  >> _FP_FRAC_SRL_8_down)				\
+		 | (X##_f[_FP_FRAC_SRL_8_i+_FP_FRAC_SRL_8_skip+1]	\
+		    << _FP_FRAC_SRL_8_up));				\
+	  X##_f[_FP_FRAC_SRL_8_i++] = X##_f[7] >> _FP_FRAC_SRL_8_down;	\
+	}								\
+      for (; _FP_FRAC_SRL_8_i < 8; ++_FP_FRAC_SRL_8_i)			\
+	X##_f[_FP_FRAC_SRL_8_i] = 0;					\
+    }									\
+  while (0)
 
 
-/* Right shift with sticky-lsb. 
- * What this actually means is that we do a standard right-shift,
- * but that if any of the bits that fall off the right hand side
- * were one then we always set the LSbit.
- */
-#define _FP_FRAC_SRS_8(X,N,size)					\
-  do {									\
-    _FP_I_TYPE _up, _down, _skip, _i;					\
-    _FP_W_TYPE _s;							\
-    _skip = (N) / _FP_W_TYPE_SIZE;					\
-    _down = (N) % _FP_W_TYPE_SIZE;					\
-    _up = _FP_W_TYPE_SIZE - _down;					\
-    for (_s = _i = 0; _i < _skip; ++_i)					\
-      _s |= X##_f[_i];							\
-    _s |= X##_f[_i] << _up;						\
-/* s is now != 0 if we want to set the LSbit */				\
-    if (!_down)								\
-      for (_i = 0; _i <= 7-_skip; ++_i)					\
-	X##_f[_i] = X##_f[_i+_skip];					\
-    else								\
-      {									\
-	for (_i = 0; _i < 7-_skip; ++_i)				\
-	  X##_f[_i] = X##_f[_i+_skip] >> _down				\
-		      | X##_f[_i+_skip+1] << _up;			\
-	X##_f[_i++] = X##_f[7] >> _down;				\
-      }									\
-    for (; _i < 8; ++_i)						\
-      X##_f[_i] = 0;							\
-    /* don't fix the LSB until the very end when we're sure f[0] is stable */	\
-    X##_f[0] |= (_s != 0);						\
-  } while (0)
+/* Right shift with sticky-lsb.
+   What this actually means is that we do a standard right-shift,
+   but that if any of the bits that fall off the right hand side
+   were one then we always set the LSbit.  */
+#define _FP_FRAC_SRS_8(X, N, size)					\
+  do									\
+    {									\
+      _FP_I_TYPE _FP_FRAC_SRS_8_up, _FP_FRAC_SRS_8_down;		\
+      _FP_I_TYPE _FP_FRAC_SRS_8_skip, _FP_FRAC_SRS_8_i;			\
+      _FP_W_TYPE _FP_FRAC_SRS_8_s;					\
+      _FP_FRAC_SRS_8_skip = (N) / _FP_W_TYPE_SIZE;			\
+      _FP_FRAC_SRS_8_down = (N) % _FP_W_TYPE_SIZE;			\
+      _FP_FRAC_SRS_8_up = _FP_W_TYPE_SIZE - _FP_FRAC_SRS_8_down;	\
+      for (_FP_FRAC_SRS_8_s = _FP_FRAC_SRS_8_i = 0;			\
+	   _FP_FRAC_SRS_8_i < _FP_FRAC_SRS_8_skip;			\
+	   ++_FP_FRAC_SRS_8_i)						\
+	_FP_FRAC_SRS_8_s |= X##_f[_FP_FRAC_SRS_8_i];			\
+      if (!_FP_FRAC_SRS_8_down)						\
+	for (_FP_FRAC_SRS_8_i = 0;					\
+	     _FP_FRAC_SRS_8_i <= 7-_FP_FRAC_SRS_8_skip;			\
+	     ++_FP_FRAC_SRS_8_i)					\
+	  X##_f[_FP_FRAC_SRS_8_i]					\
+	    = X##_f[_FP_FRAC_SRS_8_i+_FP_FRAC_SRS_8_skip];		\
+      else								\
+	{								\
+	  _FP_FRAC_SRS_8_s						\
+	    |= X##_f[_FP_FRAC_SRS_8_i] << _FP_FRAC_SRS_8_up;		\
+	  for (_FP_FRAC_SRS_8_i = 0;					\
+	       _FP_FRAC_SRS_8_i < 7-_FP_FRAC_SRS_8_skip;		\
+	       ++_FP_FRAC_SRS_8_i)					\
+	    X##_f[_FP_FRAC_SRS_8_i]					\
+	      = ((X##_f[_FP_FRAC_SRS_8_i+_FP_FRAC_SRS_8_skip]		\
+		  >> _FP_FRAC_SRS_8_down)				\
+		 | (X##_f[_FP_FRAC_SRS_8_i+_FP_FRAC_SRS_8_skip+1]	\
+		    << _FP_FRAC_SRS_8_up));				\
+	  X##_f[_FP_FRAC_SRS_8_i++] = X##_f[7] >> _FP_FRAC_SRS_8_down;	\
+	}								\
+      for (; _FP_FRAC_SRS_8_i < 8; ++_FP_FRAC_SRS_8_i)			\
+	X##_f[_FP_FRAC_SRS_8_i] = 0;					\
+      /* Don't fix the LSB until the very end when we're sure f[0] is	\
+	 stable.  */							\
+      X##_f[0] |= (_FP_FRAC_SRS_8_s != 0);				\
+    }									\
+  while (0)
 
-#endif
+#endif /* !SOFT_FP_OP_8_H */
diff --git a/include/math-emu/op-common.h b/include/math-emu/op-common.h
index 6bdf8c6..080ef0e 100644
--- a/include/math-emu/op-common.h
+++ b/include/math-emu/op-common.h
@@ -1,5 +1,5 @@
 /* Software floating-point emulation. Common operations.
-   Copyright (C) 1997,1998,1999 Free Software Foundation, Inc.
+   Copyright (C) 1997-2015 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
    Contributed by Richard Henderson (rth@cygnus.com),
 		  Jakub Jelinek (jj@ultra.linux.cz),
@@ -7,870 +7,2123 @@
 		  Peter Maydell (pmaydell@chiark.greenend.org.uk).
 
    The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Library General Public License as
-   published by the Free Software Foundation; either version 2 of the
-   License, or (at your option) any later version.
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   In addition to the permissions in the GNU Lesser General Public
+   License, the Free Software Foundation gives you unlimited
+   permission to link the compiled version of this file into
+   combinations with other programs, and to distribute those
+   combinations without any restriction coming from the use of this
+   file.  (The Lesser General Public License restrictions do apply in
+   other respects; for example, they cover modification of the file,
+   and distribution when not linked into a combine executable.)
 
    The GNU C Library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Library General Public License for more details.
-
-   You should have received a copy of the GNU Library General Public
-   License along with the GNU C Library; see the file COPYING.LIB.  If
-   not, write to the Free Software Foundation, Inc.,
-   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
-
-#ifndef __MATH_EMU_OP_COMMON_H__
-#define __MATH_EMU_OP_COMMON_H__
-
-#define _FP_DECL(wc, X)			\
-  _FP_I_TYPE X##_c=0, X##_s=0, X##_e=0;	\
-  _FP_FRAC_DECL_##wc(X)
-
-/*
- * Finish truly unpacking a native fp value by classifying the kind
- * of fp value and normalizing both the exponent and the fraction.
- */
-
-#define _FP_UNPACK_CANONICAL(fs, wc, X)					\
-do {									\
-  switch (X##_e)							\
-  {									\
-  default:								\
-    _FP_FRAC_HIGH_RAW_##fs(X) |= _FP_IMPLBIT_##fs;			\
-    _FP_FRAC_SLL_##wc(X, _FP_WORKBITS);					\
-    X##_e -= _FP_EXPBIAS_##fs;						\
-    X##_c = FP_CLS_NORMAL;						\
-    break;								\
-									\
-  case 0:								\
-    if (_FP_FRAC_ZEROP_##wc(X))						\
-      X##_c = FP_CLS_ZERO;						\
-    else								\
-      {									\
-	/* a denormalized number */					\
-	_FP_I_TYPE _shift;						\
-	_FP_FRAC_CLZ_##wc(_shift, X);					\
-	_shift -= _FP_FRACXBITS_##fs;					\
-	_FP_FRAC_SLL_##wc(X, (_shift+_FP_WORKBITS));			\
-	X##_e -= _FP_EXPBIAS_##fs - 1 + _shift;				\
-	X##_c = FP_CLS_NORMAL;						\
-	FP_SET_EXCEPTION(FP_EX_DENORM);					\
-	if (FP_DENORM_ZERO)						\
-	  {								\
-	    FP_SET_EXCEPTION(FP_EX_INEXACT);				\
-	    X##_c = FP_CLS_ZERO;					\
-	  }								\
-      }									\
-    break;								\
-									\
-  case _FP_EXPMAX_##fs:							\
-    if (_FP_FRAC_ZEROP_##wc(X))						\
-      X##_c = FP_CLS_INF;						\
-    else								\
-      {									\
-	X##_c = FP_CLS_NAN;						\
-	/* Check for signaling NaN */					\
-	if (!(_FP_FRAC_HIGH_RAW_##fs(X) & _FP_QNANBIT_##fs))		\
-	  FP_SET_EXCEPTION(FP_EX_INVALID | FP_EX_INVALID_SNAN);		\
-      }									\
-    break;								\
-  }									\
-} while (0)
-
-/*
- * Before packing the bits back into the native fp result, take care
- * of such mundane things as rounding and overflow.  Also, for some
- * kinds of fp values, the original parts may not have been fully
- * extracted -- but that is ok, we can regenerate them now.
- */
-
-#define _FP_PACK_CANONICAL(fs, wc, X)				\
-do {								\
-  switch (X##_c)						\
-  {								\
-  case FP_CLS_NORMAL:						\
-    X##_e += _FP_EXPBIAS_##fs;					\
-    if (X##_e > 0)						\
-      {								\
-	_FP_ROUND(wc, X);					\
-	if (_FP_FRAC_OVERP_##wc(fs, X))				\
-	  {							\
-	    _FP_FRAC_CLEAR_OVERP_##wc(fs, X);			\
-	    X##_e++;						\
-	  }							\
-	_FP_FRAC_SRL_##wc(X, _FP_WORKBITS);			\
-	if (X##_e >= _FP_EXPMAX_##fs)				\
-	  {							\
-	    /* overflow */					\
-	    switch (FP_ROUNDMODE)				\
-	      {							\
-	      case FP_RND_NEAREST:				\
-		X##_c = FP_CLS_INF;				\
-		break;						\
-	      case FP_RND_PINF:					\
-		if (!X##_s) X##_c = FP_CLS_INF;			\
-		break;						\
-	      case FP_RND_MINF:					\
-		if (X##_s) X##_c = FP_CLS_INF;			\
-		break;						\
-	      }							\
-	    if (X##_c = FP_CLS_INF)				\
-	      {							\
-		/* Overflow to infinity */			\
-		X##_e = _FP_EXPMAX_##fs;			\
-		_FP_FRAC_SET_##wc(X, _FP_ZEROFRAC_##wc);	\
-	      }							\
-	    else						\
-	      {							\
-		/* Overflow to maximum normal */		\
-		X##_e = _FP_EXPMAX_##fs - 1;			\
-		_FP_FRAC_SET_##wc(X, _FP_MAXFRAC_##wc);		\
-	      }							\
-	    FP_SET_EXCEPTION(FP_EX_OVERFLOW);			\
-            FP_SET_EXCEPTION(FP_EX_INEXACT);			\
-	  }							\
-      }								\
-    else							\
-      {								\
-	/* we've got a denormalized number */			\
-	X##_e = -X##_e + 1;					\
-	if (X##_e <= _FP_WFRACBITS_##fs)			\
-	  {							\
-	    _FP_FRAC_SRS_##wc(X, X##_e, _FP_WFRACBITS_##fs);	\
-	    if (_FP_FRAC_HIGH_##fs(X)				\
-		& (_FP_OVERFLOW_##fs >> 1))			\
-	      {							\
-	        X##_e = 1;					\
-	        _FP_FRAC_SET_##wc(X, _FP_ZEROFRAC_##wc);	\
-	      }							\
-	    else						\
-	      {							\
-		_FP_ROUND(wc, X);				\
-		if (_FP_FRAC_HIGH_##fs(X)			\
-		   & (_FP_OVERFLOW_##fs >> 1))			\
-		  {						\
-		    X##_e = 1;					\
-		    _FP_FRAC_SET_##wc(X, _FP_ZEROFRAC_##wc);	\
-		    FP_SET_EXCEPTION(FP_EX_INEXACT);		\
-		  }						\
-		else						\
-		  {						\
-		    X##_e = 0;					\
-		    _FP_FRAC_SRL_##wc(X, _FP_WORKBITS);		\
-		  }						\
-	      }							\
-	    if ((FP_CUR_EXCEPTIONS & FP_EX_INEXACT) ||		\
-		(FP_TRAPPING_EXCEPTIONS & FP_EX_UNDERFLOW))	\
-		FP_SET_EXCEPTION(FP_EX_UNDERFLOW);		\
-	  }							\
-	else							\
-	  {							\
-	    /* underflow to zero */				\
-	    X##_e = 0;						\
-	    if (!_FP_FRAC_ZEROP_##wc(X))			\
-	      {							\
-	        _FP_FRAC_SET_##wc(X, _FP_MINFRAC_##wc);		\
-	        _FP_ROUND(wc, X);				\
-	        _FP_FRAC_LOW_##wc(X) >>= (_FP_WORKBITS);	\
-	      }							\
-	    FP_SET_EXCEPTION(FP_EX_UNDERFLOW);			\
-	  }							\
-      }								\
-    break;							\
-								\
-  case FP_CLS_ZERO:						\
-    X##_e = 0;							\
-    _FP_FRAC_SET_##wc(X, _FP_ZEROFRAC_##wc);			\
-    break;							\
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
+
+#ifndef SOFT_FP_OP_COMMON_H
+#define SOFT_FP_OP_COMMON_H	1
+
+#define _FP_DECL(wc, X)						\
+  _FP_I_TYPE X##_c __attribute__ ((unused)) _FP_ZERO_INIT;	\
+  _FP_I_TYPE X##_s __attribute__ ((unused)) _FP_ZERO_INIT;	\
+  _FP_I_TYPE X##_e __attribute__ ((unused)) _FP_ZERO_INIT;	\
+  _FP_FRAC_DECL_##wc (X)
+
+/* Test whether the qNaN bit denotes a signaling NaN.  */
+#define _FP_FRAC_SNANP(fs, X)				\
+  ((_FP_QNANNEGATEDP)					\
+   ? (_FP_FRAC_HIGH_RAW_##fs (X) & _FP_QNANBIT_##fs)	\
+   : !(_FP_FRAC_HIGH_RAW_##fs (X) & _FP_QNANBIT_##fs))
+#define _FP_FRAC_SNANP_SEMIRAW(fs, X)			\
+  ((_FP_QNANNEGATEDP)					\
+   ? (_FP_FRAC_HIGH_##fs (X) & _FP_QNANBIT_SH_##fs)	\
+   : !(_FP_FRAC_HIGH_##fs (X) & _FP_QNANBIT_SH_##fs))
+
+/* Finish truly unpacking a native fp value by classifying the kind
+   of fp value and normalizing both the exponent and the fraction.  */
+
+#define _FP_UNPACK_CANONICAL(fs, wc, X)				\
+  do								\
+    {								\
+      switch (X##_e)						\
+	{							\
+	default:						\
+	  _FP_FRAC_HIGH_RAW_##fs (X) |= _FP_IMPLBIT_##fs;	\
+	  _FP_FRAC_SLL_##wc (X, _FP_WORKBITS);			\
+	  X##_e -= _FP_EXPBIAS_##fs;				\
+	  X##_c = FP_CLS_NORMAL;				\
+	  break;						\
 								\
-  case FP_CLS_INF:						\
-    X##_e = _FP_EXPMAX_##fs;					\
-    _FP_FRAC_SET_##wc(X, _FP_ZEROFRAC_##wc);			\
-    break;							\
+	case 0:							\
+	  if (_FP_FRAC_ZEROP_##wc (X))				\
+	    X##_c = FP_CLS_ZERO;				\
+	  else if (FP_DENORM_ZERO)				\
+	    {							\
+	      X##_c = FP_CLS_ZERO;				\
+	      _FP_FRAC_SET_##wc (X, _FP_ZEROFRAC_##wc);		\
+	      FP_SET_EXCEPTION (FP_EX_DENORM);			\
+	    }							\
+	  else							\
+	    {							\
+	      /* A denormalized number.  */			\
+	      _FP_I_TYPE _FP_UNPACK_CANONICAL_shift;		\
+	      _FP_FRAC_CLZ_##wc (_FP_UNPACK_CANONICAL_shift,	\
+				 X);				\
+	      _FP_UNPACK_CANONICAL_shift -= _FP_FRACXBITS_##fs;	\
+	      _FP_FRAC_SLL_##wc (X, (_FP_UNPACK_CANONICAL_shift \
+				     + _FP_WORKBITS));		\
+	      X##_e -= (_FP_EXPBIAS_##fs - 1			\
+			+ _FP_UNPACK_CANONICAL_shift);		\
+	      X##_c = FP_CLS_NORMAL;				\
+	      FP_SET_EXCEPTION (FP_EX_DENORM);			\
+	    }							\
+	  break;						\
 								\
-  case FP_CLS_NAN:						\
-    X##_e = _FP_EXPMAX_##fs;					\
-    if (!_FP_KEEPNANFRACP)					\
-      {								\
-	_FP_FRAC_SET_##wc(X, _FP_NANFRAC_##fs);			\
-	X##_s = _FP_NANSIGN_##fs;				\
-      }								\
-    else							\
-      _FP_FRAC_HIGH_RAW_##fs(X) |= _FP_QNANBIT_##fs;		\
-    break;							\
-  }								\
-} while (0)
+	case _FP_EXPMAX_##fs:					\
+	  if (_FP_FRAC_ZEROP_##wc (X))				\
+	    X##_c = FP_CLS_INF;					\
+	  else							\
+	    {							\
+	      X##_c = FP_CLS_NAN;				\
+	      /* Check for signaling NaN.  */			\
+	      if (_FP_FRAC_SNANP (fs, X))			\
+		FP_SET_EXCEPTION (FP_EX_INVALID			\
+				  | FP_EX_INVALID_SNAN);	\
+	    }							\
+	  break;						\
+	}							\
+    }								\
+  while (0)
+
+/* Finish unpacking an fp value in semi-raw mode: the mantissa is
+   shifted by _FP_WORKBITS but the implicit MSB is not inserted and
+   other classification is not done.  */
+#define _FP_UNPACK_SEMIRAW(fs, wc, X)	_FP_FRAC_SLL_##wc (X, _FP_WORKBITS)
+
+/* Check whether a raw or semi-raw input value should be flushed to
+   zero, and flush it to zero if so.  */
+#define _FP_CHECK_FLUSH_ZERO(fs, wc, X)			\
+  do							\
+    {							\
+      if (FP_DENORM_ZERO				\
+	  && X##_e = 0					\
+	  && !_FP_FRAC_ZEROP_##wc (X))			\
+	{						\
+	  _FP_FRAC_SET_##wc (X, _FP_ZEROFRAC_##wc);	\
+	  FP_SET_EXCEPTION (FP_EX_DENORM);		\
+	}						\
+    }							\
+  while (0)
+
+/* A semi-raw value has overflowed to infinity.  Adjust the mantissa
+   and exponent appropriately.  */
+#define _FP_OVERFLOW_SEMIRAW(fs, wc, X)			\
+  do							\
+    {							\
+      if (FP_ROUNDMODE = FP_RND_NEAREST		\
+	  || (FP_ROUNDMODE = FP_RND_PINF && !X##_s)	\
+	  || (FP_ROUNDMODE = FP_RND_MINF && X##_s))	\
+	{						\
+	  X##_e = _FP_EXPMAX_##fs;			\
+	  _FP_FRAC_SET_##wc (X, _FP_ZEROFRAC_##wc);	\
+	}						\
+      else						\
+	{						\
+	  X##_e = _FP_EXPMAX_##fs - 1;			\
+	  _FP_FRAC_SET_##wc (X, _FP_MAXFRAC_##wc);	\
+	}						\
+      FP_SET_EXCEPTION (FP_EX_INEXACT);			\
+      FP_SET_EXCEPTION (FP_EX_OVERFLOW);		\
+    }							\
+  while (0)
+
+/* Check for a semi-raw value being a signaling NaN and raise the
+   invalid exception if so.  */
+#define _FP_CHECK_SIGNAN_SEMIRAW(fs, wc, X)			\
+  do								\
+    {								\
+      if (X##_e = _FP_EXPMAX_##fs				\
+	  && !_FP_FRAC_ZEROP_##wc (X)				\
+	  && _FP_FRAC_SNANP_SEMIRAW (fs, X))			\
+	FP_SET_EXCEPTION (FP_EX_INVALID | FP_EX_INVALID_SNAN);	\
+    }								\
+  while (0)
+
+/* Choose a NaN result from an operation on two semi-raw NaN
+   values.  */
+#define _FP_CHOOSENAN_SEMIRAW(fs, wc, R, X, Y, OP)			\
+  do									\
+    {									\
+      /* _FP_CHOOSENAN expects raw values, so shift as required.  */	\
+      _FP_FRAC_SRL_##wc (X, _FP_WORKBITS);				\
+      _FP_FRAC_SRL_##wc (Y, _FP_WORKBITS);				\
+      _FP_CHOOSENAN (fs, wc, R, X, Y, OP);				\
+      _FP_FRAC_SLL_##wc (R, _FP_WORKBITS);				\
+    }									\
+  while (0)
+
+/* Make the fractional part a quiet NaN, preserving the payload
+   if possible, otherwise make it the canonical quiet NaN and set
+   the sign bit accordingly.  */
+#define _FP_SETQNAN(fs, wc, X)					\
+  do								\
+    {								\
+      if (_FP_QNANNEGATEDP)					\
+	{							\
+	  _FP_FRAC_HIGH_RAW_##fs (X) &= _FP_QNANBIT_##fs - 1;	\
+	  if (_FP_FRAC_ZEROP_##wc (X))				\
+	    {							\
+	      X##_s = _FP_NANSIGN_##fs;				\
+	      _FP_FRAC_SET_##wc (X, _FP_NANFRAC_##fs);		\
+	    }							\
+	}							\
+      else							\
+	_FP_FRAC_HIGH_RAW_##fs (X) |= _FP_QNANBIT_##fs;		\
+    }								\
+  while (0)
+#define _FP_SETQNAN_SEMIRAW(fs, wc, X)				\
+  do								\
+    {								\
+      if (_FP_QNANNEGATEDP)					\
+	{							\
+	  _FP_FRAC_HIGH_##fs (X) &= _FP_QNANBIT_SH_##fs - 1;	\
+	  if (_FP_FRAC_ZEROP_##wc (X))				\
+	    {							\
+	      X##_s = _FP_NANSIGN_##fs;				\
+	      _FP_FRAC_SET_##wc (X, _FP_NANFRAC_##fs);		\
+	      _FP_FRAC_SLL_##wc (X, _FP_WORKBITS);		\
+	    }							\
+	}							\
+      else							\
+	_FP_FRAC_HIGH_##fs (X) |= _FP_QNANBIT_SH_##fs;		\
+    }								\
+  while (0)
+
+/* Test whether a biased exponent is normal (not zero or maximum).  */
+#define _FP_EXP_NORMAL(fs, wc, X)	(((X##_e + 1) & _FP_EXPMAX_##fs) > 1)
+
+/* Prepare to pack an fp value in semi-raw mode: the mantissa is
+   rounded and shifted right, with the rounding possibly increasing
+   the exponent (including changing a finite value to infinity).  */
+#define _FP_PACK_SEMIRAW(fs, wc, X)				\
+  do								\
+    {								\
+      int _FP_PACK_SEMIRAW_is_tiny				\
+	= X##_e = 0 && !_FP_FRAC_ZEROP_##wc (X);		\
+      if (_FP_TININESS_AFTER_ROUNDING				\
+	  && _FP_PACK_SEMIRAW_is_tiny)				\
+	{							\
+	  FP_DECL_##fs (_FP_PACK_SEMIRAW_T);			\
+	  _FP_FRAC_COPY_##wc (_FP_PACK_SEMIRAW_T, X);		\
+	  _FP_PACK_SEMIRAW_T##_s = X##_s;			\
+	  _FP_PACK_SEMIRAW_T##_e = X##_e;			\
+	  _FP_FRAC_SLL_##wc (_FP_PACK_SEMIRAW_T, 1);		\
+	  _FP_ROUND (wc, _FP_PACK_SEMIRAW_T);			\
+	  if (_FP_FRAC_OVERP_##wc (fs, _FP_PACK_SEMIRAW_T))	\
+	    _FP_PACK_SEMIRAW_is_tiny = 0;			\
+	}							\
+      _FP_ROUND (wc, X);					\
+      if (_FP_PACK_SEMIRAW_is_tiny)				\
+	{							\
+	  if ((FP_CUR_EXCEPTIONS & FP_EX_INEXACT)		\
+	      || (FP_TRAPPING_EXCEPTIONS & FP_EX_UNDERFLOW))	\
+	    FP_SET_EXCEPTION (FP_EX_UNDERFLOW);			\
+	}							\
+      if (_FP_FRAC_HIGH_##fs (X)				\
+	  & (_FP_OVERFLOW_##fs >> 1))				\
+	{							\
+	  _FP_FRAC_HIGH_##fs (X) &= ~(_FP_OVERFLOW_##fs >> 1);	\
+	  X##_e++;						\
+	  if (X##_e = _FP_EXPMAX_##fs)				\
+	    _FP_OVERFLOW_SEMIRAW (fs, wc, X);			\
+	}							\
+      _FP_FRAC_SRL_##wc (X, _FP_WORKBITS);			\
+      if (X##_e = _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc (X))	\
+	{							\
+	  if (!_FP_KEEPNANFRACP)				\
+	    {							\
+	      _FP_FRAC_SET_##wc (X, _FP_NANFRAC_##fs);		\
+	      X##_s = _FP_NANSIGN_##fs;				\
+	    }							\
+	  else							\
+	    _FP_SETQNAN (fs, wc, X);				\
+	}							\
+    }								\
+  while (0)
+
+/* Before packing the bits back into the native fp result, take care
+   of such mundane things as rounding and overflow.  Also, for some
+   kinds of fp values, the original parts may not have been fully
+   extracted -- but that is ok, we can regenerate them now.  */
+
+#define _FP_PACK_CANONICAL(fs, wc, X)					\
+  do									\
+    {									\
+      switch (X##_c)							\
+	{								\
+	case FP_CLS_NORMAL:						\
+	  X##_e += _FP_EXPBIAS_##fs;					\
+	  if (X##_e > 0)						\
+	    {								\
+	      _FP_ROUND (wc, X);					\
+	      if (_FP_FRAC_OVERP_##wc (fs, X))				\
+		{							\
+		  _FP_FRAC_CLEAR_OVERP_##wc (fs, X);			\
+		  X##_e++;						\
+		}							\
+	      _FP_FRAC_SRL_##wc (X, _FP_WORKBITS);			\
+	      if (X##_e >= _FP_EXPMAX_##fs)				\
+		{							\
+		  /* Overflow.  */					\
+		  switch (FP_ROUNDMODE)					\
+		    {							\
+		    case FP_RND_NEAREST:				\
+		      X##_c = FP_CLS_INF;				\
+		      break;						\
+		    case FP_RND_PINF:					\
+		      if (!X##_s)					\
+			X##_c = FP_CLS_INF;				\
+		      break;						\
+		    case FP_RND_MINF:					\
+		      if (X##_s)					\
+			X##_c = FP_CLS_INF;				\
+		      break;						\
+		    }							\
+		  if (X##_c = FP_CLS_INF)				\
+		    {							\
+		      /* Overflow to infinity.  */			\
+		      X##_e = _FP_EXPMAX_##fs;				\
+		      _FP_FRAC_SET_##wc (X, _FP_ZEROFRAC_##wc);		\
+		    }							\
+		  else							\
+		    {							\
+		      /* Overflow to maximum normal.  */		\
+		      X##_e = _FP_EXPMAX_##fs - 1;			\
+		      _FP_FRAC_SET_##wc (X, _FP_MAXFRAC_##wc);		\
+		    }							\
+		  FP_SET_EXCEPTION (FP_EX_OVERFLOW);			\
+		  FP_SET_EXCEPTION (FP_EX_INEXACT);			\
+		}							\
+	    }								\
+	  else								\
+	    {								\
+	      /* We've got a denormalized number.  */			\
+	      int _FP_PACK_CANONICAL_is_tiny = 1;			\
+	      if (_FP_TININESS_AFTER_ROUNDING && X##_e = 0)		\
+		{							\
+		  FP_DECL_##fs (_FP_PACK_CANONICAL_T);			\
+		  _FP_FRAC_COPY_##wc (_FP_PACK_CANONICAL_T, X);		\
+		  _FP_PACK_CANONICAL_T##_s = X##_s;			\
+		  _FP_PACK_CANONICAL_T##_e = X##_e;			\
+		  _FP_ROUND (wc, _FP_PACK_CANONICAL_T);			\
+		  if (_FP_FRAC_OVERP_##wc (fs, _FP_PACK_CANONICAL_T))	\
+		    _FP_PACK_CANONICAL_is_tiny = 0;			\
+		}							\
+	      X##_e = -X##_e + 1;					\
+	      if (X##_e <= _FP_WFRACBITS_##fs)				\
+		{							\
+		  _FP_FRAC_SRS_##wc (X, X##_e, _FP_WFRACBITS_##fs);	\
+		  _FP_ROUND (wc, X);					\
+		  if (_FP_FRAC_HIGH_##fs (X)				\
+		      & (_FP_OVERFLOW_##fs >> 1))			\
+		    {							\
+		      X##_e = 1;					\
+		      _FP_FRAC_SET_##wc (X, _FP_ZEROFRAC_##wc);		\
+		      FP_SET_EXCEPTION (FP_EX_INEXACT);			\
+		    }							\
+		  else							\
+		    {							\
+		      X##_e = 0;					\
+		      _FP_FRAC_SRL_##wc (X, _FP_WORKBITS);		\
+		    }							\
+		  if (_FP_PACK_CANONICAL_is_tiny			\
+		      && ((FP_CUR_EXCEPTIONS & FP_EX_INEXACT)		\
+			  || (FP_TRAPPING_EXCEPTIONS			\
+			      & FP_EX_UNDERFLOW)))			\
+		    FP_SET_EXCEPTION (FP_EX_UNDERFLOW);			\
+		}							\
+	      else							\
+		{							\
+		  /* Underflow to zero.  */				\
+		  X##_e = 0;						\
+		  if (!_FP_FRAC_ZEROP_##wc (X))				\
+		    {							\
+		      _FP_FRAC_SET_##wc (X, _FP_MINFRAC_##wc);		\
+		      _FP_ROUND (wc, X);				\
+		      _FP_FRAC_LOW_##wc (X) >>= (_FP_WORKBITS);		\
+		    }							\
+		  FP_SET_EXCEPTION (FP_EX_UNDERFLOW);			\
+		}							\
+	    }								\
+	  break;							\
+									\
+	case FP_CLS_ZERO:						\
+	  X##_e = 0;							\
+	  _FP_FRAC_SET_##wc (X, _FP_ZEROFRAC_##wc);			\
+	  break;							\
+									\
+	case FP_CLS_INF:						\
+	  X##_e = _FP_EXPMAX_##fs;					\
+	  _FP_FRAC_SET_##wc (X, _FP_ZEROFRAC_##wc);			\
+	  break;							\
+									\
+	case FP_CLS_NAN:						\
+	  X##_e = _FP_EXPMAX_##fs;					\
+	  if (!_FP_KEEPNANFRACP)					\
+	    {								\
+	      _FP_FRAC_SET_##wc (X, _FP_NANFRAC_##fs);			\
+	      X##_s = _FP_NANSIGN_##fs;					\
+	    }								\
+	  else								\
+	    _FP_SETQNAN (fs, wc, X);					\
+	  break;							\
+	}								\
+    }									\
+  while (0)
 
 /* This one accepts raw argument and not cooked,  returns
- * 1 if X is a signaling NaN.
- */
-#define _FP_ISSIGNAN(fs, wc, X)					\
-({								\
-  int __ret = 0;						\
-  if (X##_e = _FP_EXPMAX_##fs)					\
+   1 if X is a signaling NaN.  */
+#define _FP_ISSIGNAN(fs, wc, X)			\
+  ({						\
+    int _FP_ISSIGNAN_ret = 0;			\
+    if (X##_e = _FP_EXPMAX_##fs)		\
+      {						\
+	if (!_FP_FRAC_ZEROP_##wc (X)		\
+	    && _FP_FRAC_SNANP (fs, X))		\
+	  _FP_ISSIGNAN_ret = 1;			\
+      }						\
+    _FP_ISSIGNAN_ret;				\
+  })
+
+
+
+
+
+/* Addition on semi-raw values.  */
+#define _FP_ADD_INTERNAL(fs, wc, R, X, Y, OP)				\
+  do									\
+    {									\
+      _FP_CHECK_FLUSH_ZERO (fs, wc, X);					\
+      _FP_CHECK_FLUSH_ZERO (fs, wc, Y);					\
+      if (X##_s = Y##_s)						\
+	{								\
+	  /* Addition.  */						\
+	  __label__ add1, add2, add3, add_done;				\
+	  R##_s = X##_s;						\
+	  int _FP_ADD_INTERNAL_ediff = X##_e - Y##_e;			\
+	  if (_FP_ADD_INTERNAL_ediff > 0)				\
+	    {								\
+	      R##_e = X##_e;						\
+	      if (Y##_e = 0)						\
+		{							\
+		  /* Y is zero or denormalized.  */			\
+		  if (_FP_FRAC_ZEROP_##wc (Y))				\
+		    {							\
+		      _FP_CHECK_SIGNAN_SEMIRAW (fs, wc, X);		\
+		      _FP_FRAC_COPY_##wc (R, X);			\
+		      goto add_done;					\
+		    }							\
+		  else							\
+		    {							\
+		      FP_SET_EXCEPTION (FP_EX_DENORM);			\
+		      _FP_ADD_INTERNAL_ediff--;				\
+		      if (_FP_ADD_INTERNAL_ediff = 0)			\
+			{						\
+			  _FP_FRAC_ADD_##wc (R, X, Y);			\
+			  goto add3;					\
+			}						\
+		      if (X##_e = _FP_EXPMAX_##fs)			\
+			{						\
+			  _FP_CHECK_SIGNAN_SEMIRAW (fs, wc, X);		\
+			  _FP_FRAC_COPY_##wc (R, X);			\
+			  goto add_done;				\
+			}						\
+		      goto add1;					\
+		    }							\
+		}							\
+	      else if (X##_e = _FP_EXPMAX_##fs)			\
+		{							\
+		  /* X is NaN or Inf, Y is normal.  */			\
+		  _FP_CHECK_SIGNAN_SEMIRAW (fs, wc, X);			\
+		  _FP_FRAC_COPY_##wc (R, X);				\
+		  goto add_done;					\
+		}							\
+									\
+	      /* Insert implicit MSB of Y.  */				\
+	      _FP_FRAC_HIGH_##fs (Y) |= _FP_IMPLBIT_SH_##fs;		\
+									\
+	    add1:							\
+	      /* Shift the mantissa of Y to the right			\
+		 _FP_ADD_INTERNAL_EDIFF steps; remember to account	\
+		 later for the implicit MSB of X.  */			\
+	      if (_FP_ADD_INTERNAL_ediff <= _FP_WFRACBITS_##fs)		\
+		_FP_FRAC_SRS_##wc (Y, _FP_ADD_INTERNAL_ediff,		\
+				   _FP_WFRACBITS_##fs);			\
+	      else if (!_FP_FRAC_ZEROP_##wc (Y))			\
+		_FP_FRAC_SET_##wc (Y, _FP_MINFRAC_##wc);		\
+	      _FP_FRAC_ADD_##wc (R, X, Y);				\
+	    }								\
+	  else if (_FP_ADD_INTERNAL_ediff < 0)				\
+	    {								\
+	      _FP_ADD_INTERNAL_ediff = -_FP_ADD_INTERNAL_ediff;		\
+	      R##_e = Y##_e;						\
+	      if (X##_e = 0)						\
+		{							\
+		  /* X is zero or denormalized.  */			\
+		  if (_FP_FRAC_ZEROP_##wc (X))				\
+		    {							\
+		      _FP_CHECK_SIGNAN_SEMIRAW (fs, wc, Y);		\
+		      _FP_FRAC_COPY_##wc (R, Y);			\
+		      goto add_done;					\
+		    }							\
+		  else							\
+		    {							\
+		      FP_SET_EXCEPTION (FP_EX_DENORM);			\
+		      _FP_ADD_INTERNAL_ediff--;				\
+		      if (_FP_ADD_INTERNAL_ediff = 0)			\
+			{						\
+			  _FP_FRAC_ADD_##wc (R, Y, X);			\
+			  goto add3;					\
+			}						\
+		      if (Y##_e = _FP_EXPMAX_##fs)			\
+			{						\
+			  _FP_CHECK_SIGNAN_SEMIRAW (fs, wc, Y);		\
+			  _FP_FRAC_COPY_##wc (R, Y);			\
+			  goto add_done;				\
+			}						\
+		      goto add2;					\
+		    }							\
+		}							\
+	      else if (Y##_e = _FP_EXPMAX_##fs)			\
+		{							\
+		  /* Y is NaN or Inf, X is normal.  */			\
+		  _FP_CHECK_SIGNAN_SEMIRAW (fs, wc, Y);			\
+		  _FP_FRAC_COPY_##wc (R, Y);				\
+		  goto add_done;					\
+		}							\
+									\
+	      /* Insert implicit MSB of X.  */				\
+	      _FP_FRAC_HIGH_##fs (X) |= _FP_IMPLBIT_SH_##fs;		\
+									\
+	    add2:							\
+	      /* Shift the mantissa of X to the right			\
+		 _FP_ADD_INTERNAL_EDIFF steps; remember to account	\
+		 later for the implicit MSB of Y.  */			\
+	      if (_FP_ADD_INTERNAL_ediff <= _FP_WFRACBITS_##fs)		\
+		_FP_FRAC_SRS_##wc (X, _FP_ADD_INTERNAL_ediff,		\
+				   _FP_WFRACBITS_##fs);			\
+	      else if (!_FP_FRAC_ZEROP_##wc (X))			\
+		_FP_FRAC_SET_##wc (X, _FP_MINFRAC_##wc);		\
+	      _FP_FRAC_ADD_##wc (R, Y, X);				\
+	    }								\
+	  else								\
+	    {								\
+	      /* _FP_ADD_INTERNAL_ediff = 0.  */			\
+	      if (!_FP_EXP_NORMAL (fs, wc, X))				\
+		{							\
+		  if (X##_e = 0)					\
+		    {							\
+		      /* X and Y are zero or denormalized.  */		\
+		      R##_e = 0;					\
+		      if (_FP_FRAC_ZEROP_##wc (X))			\
+			{						\
+			  if (!_FP_FRAC_ZEROP_##wc (Y))			\
+			    FP_SET_EXCEPTION (FP_EX_DENORM);		\
+			  _FP_FRAC_COPY_##wc (R, Y);			\
+			  goto add_done;				\
+			}						\
+		      else if (_FP_FRAC_ZEROP_##wc (Y))			\
+			{						\
+			  FP_SET_EXCEPTION (FP_EX_DENORM);		\
+			  _FP_FRAC_COPY_##wc (R, X);			\
+			  goto add_done;				\
+			}						\
+		      else						\
+			{						\
+			  FP_SET_EXCEPTION (FP_EX_DENORM);		\
+			  _FP_FRAC_ADD_##wc (R, X, Y);			\
+			  if (_FP_FRAC_HIGH_##fs (R) & _FP_IMPLBIT_SH_##fs) \
+			    {						\
+			      /* Normalized result.  */			\
+			      _FP_FRAC_HIGH_##fs (R)			\
+				&= ~(_FP_W_TYPE) _FP_IMPLBIT_SH_##fs;	\
+			      R##_e = 1;				\
+			    }						\
+			  goto add_done;				\
+			}						\
+		    }							\
+		  else							\
+		    {							\
+		      /* X and Y are NaN or Inf.  */			\
+		      _FP_CHECK_SIGNAN_SEMIRAW (fs, wc, X);		\
+		      _FP_CHECK_SIGNAN_SEMIRAW (fs, wc, Y);		\
+		      R##_e = _FP_EXPMAX_##fs;				\
+		      if (_FP_FRAC_ZEROP_##wc (X))			\
+			_FP_FRAC_COPY_##wc (R, Y);			\
+		      else if (_FP_FRAC_ZEROP_##wc (Y))			\
+			_FP_FRAC_COPY_##wc (R, X);			\
+		      else						\
+			_FP_CHOOSENAN_SEMIRAW (fs, wc, R, X, Y, OP);	\
+		      goto add_done;					\
+		    }							\
+		}							\
+	      /* The exponents of X and Y, both normal, are equal.  The	\
+		 implicit MSBs will always add to increase the		\
+		 exponent.  */						\
+	      _FP_FRAC_ADD_##wc (R, X, Y);				\
+	      R##_e = X##_e + 1;					\
+	      _FP_FRAC_SRS_##wc (R, 1, _FP_WFRACBITS_##fs);		\
+	      if (R##_e = _FP_EXPMAX_##fs)				\
+		/* Overflow to infinity (depending on rounding mode).  */ \
+		_FP_OVERFLOW_SEMIRAW (fs, wc, R);			\
+	      goto add_done;						\
+	    }								\
+	add3:								\
+	  if (_FP_FRAC_HIGH_##fs (R) & _FP_IMPLBIT_SH_##fs)		\
+	    {								\
+	      /* Overflow.  */						\
+	      _FP_FRAC_HIGH_##fs (R) &= ~(_FP_W_TYPE) _FP_IMPLBIT_SH_##fs; \
+	      R##_e++;							\
+	      _FP_FRAC_SRS_##wc (R, 1, _FP_WFRACBITS_##fs);		\
+	      if (R##_e = _FP_EXPMAX_##fs)				\
+		/* Overflow to infinity (depending on rounding mode).  */ \
+		_FP_OVERFLOW_SEMIRAW (fs, wc, R);			\
+	    }								\
+	add_done: ;							\
+	}								\
+      else								\
+	{								\
+	  /* Subtraction.  */						\
+	  __label__ sub1, sub2, sub3, norm, sub_done;			\
+	  int _FP_ADD_INTERNAL_ediff = X##_e - Y##_e;			\
+	  if (_FP_ADD_INTERNAL_ediff > 0)				\
+	    {								\
+	      R##_e = X##_e;						\
+	      R##_s = X##_s;						\
+	      if (Y##_e = 0)						\
+		{							\
+		  /* Y is zero or denormalized.  */			\
+		  if (_FP_FRAC_ZEROP_##wc (Y))				\
+		    {							\
+		      _FP_CHECK_SIGNAN_SEMIRAW (fs, wc, X);		\
+		      _FP_FRAC_COPY_##wc (R, X);			\
+		      goto sub_done;					\
+		    }							\
+		  else							\
+		    {							\
+		      FP_SET_EXCEPTION (FP_EX_DENORM);			\
+		      _FP_ADD_INTERNAL_ediff--;				\
+		      if (_FP_ADD_INTERNAL_ediff = 0)			\
+			{						\
+			  _FP_FRAC_SUB_##wc (R, X, Y);			\
+			  goto sub3;					\
+			}						\
+		      if (X##_e = _FP_EXPMAX_##fs)			\
+			{						\
+			  _FP_CHECK_SIGNAN_SEMIRAW (fs, wc, X);		\
+			  _FP_FRAC_COPY_##wc (R, X);			\
+			  goto sub_done;				\
+			}						\
+		      goto sub1;					\
+		    }							\
+		}							\
+	      else if (X##_e = _FP_EXPMAX_##fs)			\
+		{							\
+		  /* X is NaN or Inf, Y is normal.  */			\
+		  _FP_CHECK_SIGNAN_SEMIRAW (fs, wc, X);			\
+		  _FP_FRAC_COPY_##wc (R, X);				\
+		  goto sub_done;					\
+		}							\
+									\
+	      /* Insert implicit MSB of Y.  */				\
+	      _FP_FRAC_HIGH_##fs (Y) |= _FP_IMPLBIT_SH_##fs;		\
+									\
+	    sub1:							\
+	      /* Shift the mantissa of Y to the right			\
+		 _FP_ADD_INTERNAL_EDIFF steps; remember to account	\
+		 later for the implicit MSB of X.  */			\
+	      if (_FP_ADD_INTERNAL_ediff <= _FP_WFRACBITS_##fs)		\
+		_FP_FRAC_SRS_##wc (Y, _FP_ADD_INTERNAL_ediff,		\
+				   _FP_WFRACBITS_##fs);			\
+	      else if (!_FP_FRAC_ZEROP_##wc (Y))			\
+		_FP_FRAC_SET_##wc (Y, _FP_MINFRAC_##wc);		\
+	      _FP_FRAC_SUB_##wc (R, X, Y);				\
+	    }								\
+	  else if (_FP_ADD_INTERNAL_ediff < 0)				\
+	    {								\
+	      _FP_ADD_INTERNAL_ediff = -_FP_ADD_INTERNAL_ediff;		\
+	      R##_e = Y##_e;						\
+	      R##_s = Y##_s;						\
+	      if (X##_e = 0)						\
+		{							\
+		  /* X is zero or denormalized.  */			\
+		  if (_FP_FRAC_ZEROP_##wc (X))				\
+		    {							\
+		      _FP_CHECK_SIGNAN_SEMIRAW (fs, wc, Y);		\
+		      _FP_FRAC_COPY_##wc (R, Y);			\
+		      goto sub_done;					\
+		    }							\
+		  else							\
+		    {							\
+		      FP_SET_EXCEPTION (FP_EX_DENORM);			\
+		      _FP_ADD_INTERNAL_ediff--;				\
+		      if (_FP_ADD_INTERNAL_ediff = 0)			\
+			{						\
+			  _FP_FRAC_SUB_##wc (R, Y, X);			\
+			  goto sub3;					\
+			}						\
+		      if (Y##_e = _FP_EXPMAX_##fs)			\
+			{						\
+			  _FP_CHECK_SIGNAN_SEMIRAW (fs, wc, Y);		\
+			  _FP_FRAC_COPY_##wc (R, Y);			\
+			  goto sub_done;				\
+			}						\
+		      goto sub2;					\
+		    }							\
+		}							\
+	      else if (Y##_e = _FP_EXPMAX_##fs)			\
+		{							\
+		  /* Y is NaN or Inf, X is normal.  */			\
+		  _FP_CHECK_SIGNAN_SEMIRAW (fs, wc, Y);			\
+		  _FP_FRAC_COPY_##wc (R, Y);				\
+		  goto sub_done;					\
+		}							\
+									\
+	      /* Insert implicit MSB of X.  */				\
+	      _FP_FRAC_HIGH_##fs (X) |= _FP_IMPLBIT_SH_##fs;		\
+									\
+	    sub2:							\
+	      /* Shift the mantissa of X to the right			\
+		 _FP_ADD_INTERNAL_EDIFF steps; remember to account	\
+		 later for the implicit MSB of Y.  */			\
+	      if (_FP_ADD_INTERNAL_ediff <= _FP_WFRACBITS_##fs)		\
+		_FP_FRAC_SRS_##wc (X, _FP_ADD_INTERNAL_ediff,		\
+				   _FP_WFRACBITS_##fs);			\
+	      else if (!_FP_FRAC_ZEROP_##wc (X))			\
+		_FP_FRAC_SET_##wc (X, _FP_MINFRAC_##wc);		\
+	      _FP_FRAC_SUB_##wc (R, Y, X);				\
+	    }								\
+	  else								\
+	    {								\
+	      /* ediff = 0.  */					\
+	      if (!_FP_EXP_NORMAL (fs, wc, X))				\
+		{							\
+		  if (X##_e = 0)					\
+		    {							\
+		      /* X and Y are zero or denormalized.  */		\
+		      R##_e = 0;					\
+		      if (_FP_FRAC_ZEROP_##wc (X))			\
+			{						\
+			  _FP_FRAC_COPY_##wc (R, Y);			\
+			  if (_FP_FRAC_ZEROP_##wc (Y))			\
+			    R##_s = (FP_ROUNDMODE = FP_RND_MINF);	\
+			  else						\
+			    {						\
+			      FP_SET_EXCEPTION (FP_EX_DENORM);		\
+			      R##_s = Y##_s;				\
+			    }						\
+			  goto sub_done;				\
+			}						\
+		      else if (_FP_FRAC_ZEROP_##wc (Y))			\
+			{						\
+			  FP_SET_EXCEPTION (FP_EX_DENORM);		\
+			  _FP_FRAC_COPY_##wc (R, X);			\
+			  R##_s = X##_s;				\
+			  goto sub_done;				\
+			}						\
+		      else						\
+			{						\
+			  FP_SET_EXCEPTION (FP_EX_DENORM);		\
+			  _FP_FRAC_SUB_##wc (R, X, Y);			\
+			  R##_s = X##_s;				\
+			  if (_FP_FRAC_HIGH_##fs (R) & _FP_IMPLBIT_SH_##fs) \
+			    {						\
+			      /* |X| < |Y|, negate result.  */		\
+			      _FP_FRAC_SUB_##wc (R, Y, X);		\
+			      R##_s = Y##_s;				\
+			    }						\
+			  else if (_FP_FRAC_ZEROP_##wc (R))		\
+			    R##_s = (FP_ROUNDMODE = FP_RND_MINF);	\
+			  goto sub_done;				\
+			}						\
+		    }							\
+		  else							\
+		    {							\
+		      /* X and Y are NaN or Inf, of opposite signs.  */	\
+		      _FP_CHECK_SIGNAN_SEMIRAW (fs, wc, X);		\
+		      _FP_CHECK_SIGNAN_SEMIRAW (fs, wc, Y);		\
+		      R##_e = _FP_EXPMAX_##fs;				\
+		      if (_FP_FRAC_ZEROP_##wc (X))			\
+			{						\
+			  if (_FP_FRAC_ZEROP_##wc (Y))			\
+			    {						\
+			      /* Inf - Inf.  */				\
+			      R##_s = _FP_NANSIGN_##fs;			\
+			      _FP_FRAC_SET_##wc (R, _FP_NANFRAC_##fs);	\
+			      _FP_FRAC_SLL_##wc (R, _FP_WORKBITS);	\
+			      FP_SET_EXCEPTION (FP_EX_INVALID		\
+						| FP_EX_INVALID_ISI);	\
+			    }						\
+			  else						\
+			    {						\
+			      /* Inf - NaN.  */				\
+			      R##_s = Y##_s;				\
+			      _FP_FRAC_COPY_##wc (R, Y);		\
+			    }						\
+			}						\
+		      else						\
+			{						\
+			  if (_FP_FRAC_ZEROP_##wc (Y))			\
+			    {						\
+			      /* NaN - Inf.  */				\
+			      R##_s = X##_s;				\
+			      _FP_FRAC_COPY_##wc (R, X);		\
+			    }						\
+			  else						\
+			    {						\
+			      /* NaN - NaN.  */				\
+			      _FP_CHOOSENAN_SEMIRAW (fs, wc, R, X, Y, OP); \
+			    }						\
+			}						\
+		      goto sub_done;					\
+		    }							\
+		}							\
+	      /* The exponents of X and Y, both normal, are equal.  The	\
+		 implicit MSBs cancel.  */				\
+	      R##_e = X##_e;						\
+	      _FP_FRAC_SUB_##wc (R, X, Y);				\
+	      R##_s = X##_s;						\
+	      if (_FP_FRAC_HIGH_##fs (R) & _FP_IMPLBIT_SH_##fs)		\
+		{							\
+		  /* |X| < |Y|, negate result.  */			\
+		  _FP_FRAC_SUB_##wc (R, Y, X);				\
+		  R##_s = Y##_s;					\
+		}							\
+	      else if (_FP_FRAC_ZEROP_##wc (R))				\
+		{							\
+		  R##_e = 0;						\
+		  R##_s = (FP_ROUNDMODE = FP_RND_MINF);		\
+		  goto sub_done;					\
+		}							\
+	      goto norm;						\
+	    }								\
+	sub3:								\
+	  if (_FP_FRAC_HIGH_##fs (R) & _FP_IMPLBIT_SH_##fs)		\
+	    {								\
+	      int _FP_ADD_INTERNAL_diff;				\
+	      /* Carry into most significant bit of larger one of X and Y, \
+		 canceling it; renormalize.  */				\
+	      _FP_FRAC_HIGH_##fs (R) &= _FP_IMPLBIT_SH_##fs - 1;	\
+	    norm:							\
+	      _FP_FRAC_CLZ_##wc (_FP_ADD_INTERNAL_diff, R);		\
+	      _FP_ADD_INTERNAL_diff -= _FP_WFRACXBITS_##fs;		\
+	      _FP_FRAC_SLL_##wc (R, _FP_ADD_INTERNAL_diff);		\
+	      if (R##_e <= _FP_ADD_INTERNAL_diff)			\
+		{							\
+		  /* R is denormalized.  */				\
+		  _FP_ADD_INTERNAL_diff					\
+		    = _FP_ADD_INTERNAL_diff - R##_e + 1;		\
+		  _FP_FRAC_SRS_##wc (R, _FP_ADD_INTERNAL_diff,		\
+				     _FP_WFRACBITS_##fs);		\
+		  R##_e = 0;						\
+		}							\
+	      else							\
+		{							\
+		  R##_e -= _FP_ADD_INTERNAL_diff;			\
+		  _FP_FRAC_HIGH_##fs (R) &= ~(_FP_W_TYPE) _FP_IMPLBIT_SH_##fs; \
+		}							\
+	    }								\
+	sub_done: ;							\
+	}								\
+    }									\
+  while (0)
+
+#define _FP_ADD(fs, wc, R, X, Y) _FP_ADD_INTERNAL (fs, wc, R, X, Y, '+')
+#define _FP_SUB(fs, wc, R, X, Y)					\
+  do									\
+    {									\
+      if (!(Y##_e = _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc (Y)))	\
+	Y##_s ^= 1;							\
+      _FP_ADD_INTERNAL (fs, wc, R, X, Y, '-');				\
+    }									\
+  while (0)
+
+
+/* Main negation routine.  The input value is raw.  */
+
+#define _FP_NEG(fs, wc, R, X)			\
+  do						\
+    {						\
+      _FP_FRAC_COPY_##wc (R, X);		\
+      R##_e = X##_e;				\
+      R##_s = 1 ^ X##_s;			\
+    }						\
+  while (0)
+
+
+/* Main multiplication routine.  The input values should be cooked.  */
+
+#define _FP_MUL(fs, wc, R, X, Y)				\
+  do								\
     {								\
-      if (!_FP_FRAC_ZEROP_##wc(X)				\
-	  && !(_FP_FRAC_HIGH_RAW_##fs(X) & _FP_QNANBIT_##fs))	\
-	__ret = 1;						\
+      R##_s = X##_s ^ Y##_s;					\
+      R##_e = X##_e + Y##_e + 1;				\
+      switch (_FP_CLS_COMBINE (X##_c, Y##_c))			\
+	{							\
+	case _FP_CLS_COMBINE (FP_CLS_NORMAL, FP_CLS_NORMAL):	\
+	  R##_c = FP_CLS_NORMAL;				\
+								\
+	  _FP_MUL_MEAT_##fs (R, X, Y);				\
+								\
+	  if (_FP_FRAC_OVERP_##wc (fs, R))			\
+	    _FP_FRAC_SRS_##wc (R, 1, _FP_WFRACBITS_##fs);	\
+	  else							\
+	    R##_e--;						\
+	  break;						\
+								\
+	case _FP_CLS_COMBINE (FP_CLS_NAN, FP_CLS_NAN):		\
+	  _FP_CHOOSENAN (fs, wc, R, X, Y, '*');			\
+	  break;						\
+								\
+	case _FP_CLS_COMBINE (FP_CLS_NAN, FP_CLS_NORMAL):	\
+	case _FP_CLS_COMBINE (FP_CLS_NAN, FP_CLS_INF):		\
+	case _FP_CLS_COMBINE (FP_CLS_NAN, FP_CLS_ZERO):		\
+	  R##_s = X##_s;					\
+								\
+	case _FP_CLS_COMBINE (FP_CLS_INF, FP_CLS_INF):		\
+	case _FP_CLS_COMBINE (FP_CLS_INF, FP_CLS_NORMAL):	\
+	case _FP_CLS_COMBINE (FP_CLS_ZERO, FP_CLS_NORMAL):	\
+	case _FP_CLS_COMBINE (FP_CLS_ZERO, FP_CLS_ZERO):	\
+	  _FP_FRAC_COPY_##wc (R, X);				\
+	  R##_c = X##_c;					\
+	  break;						\
+								\
+	case _FP_CLS_COMBINE (FP_CLS_NORMAL, FP_CLS_NAN):	\
+	case _FP_CLS_COMBINE (FP_CLS_INF, FP_CLS_NAN):		\
+	case _FP_CLS_COMBINE (FP_CLS_ZERO, FP_CLS_NAN):		\
+	  R##_s = Y##_s;					\
+								\
+	case _FP_CLS_COMBINE (FP_CLS_NORMAL, FP_CLS_INF):	\
+	case _FP_CLS_COMBINE (FP_CLS_NORMAL, FP_CLS_ZERO):	\
+	  _FP_FRAC_COPY_##wc (R, Y);				\
+	  R##_c = Y##_c;					\
+	  break;						\
+								\
+	case _FP_CLS_COMBINE (FP_CLS_INF, FP_CLS_ZERO):		\
+	case _FP_CLS_COMBINE (FP_CLS_ZERO, FP_CLS_INF):		\
+	  R##_s = _FP_NANSIGN_##fs;				\
+	  R##_c = FP_CLS_NAN;					\
+	  _FP_FRAC_SET_##wc (R, _FP_NANFRAC_##fs);		\
+	  FP_SET_EXCEPTION (FP_EX_INVALID | FP_EX_INVALID_IMZ);	\
+	  break;						\
+								\
+	default:						\
+	  _FP_UNREACHABLE;					\
+	}							\
     }								\
-  __ret;							\
-})
-
-
-
-
-
-/*
- * Main addition routine.  The input values should be cooked.
- */
-
-#define _FP_ADD_INTERNAL(fs, wc, R, X, Y, OP)				     \
-do {									     \
-  switch (_FP_CLS_COMBINE(X##_c, Y##_c))				     \
-  {									     \
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_NORMAL):			     \
-    {									     \
-      /* shift the smaller number so that its exponent matches the larger */ \
-      _FP_I_TYPE diff = X##_e - Y##_e;					     \
-									     \
-      if (diff < 0)							     \
-	{								     \
-	  diff = -diff;							     \
-	  if (diff <= _FP_WFRACBITS_##fs)				     \
-	    _FP_FRAC_SRS_##wc(X, diff, _FP_WFRACBITS_##fs);		     \
-	  else if (!_FP_FRAC_ZEROP_##wc(X))				     \
-	    _FP_FRAC_SET_##wc(X, _FP_MINFRAC_##wc);			     \
-	  R##_e = Y##_e;						     \
-	}								     \
-      else								     \
-	{								     \
-	  if (diff > 0)							     \
-	    {								     \
-	      if (diff <= _FP_WFRACBITS_##fs)				     \
-	        _FP_FRAC_SRS_##wc(Y, diff, _FP_WFRACBITS_##fs);		     \
-	      else if (!_FP_FRAC_ZEROP_##wc(Y))				     \
-	        _FP_FRAC_SET_##wc(Y, _FP_MINFRAC_##wc);			     \
-	    }								     \
-	  R##_e = X##_e;						     \
-	}								     \
-									     \
-      R##_c = FP_CLS_NORMAL;						     \
-									     \
-      if (X##_s = Y##_s)						     \
-	{								     \
-	  R##_s = X##_s;						     \
-	  _FP_FRAC_ADD_##wc(R, X, Y);					     \
-	  if (_FP_FRAC_OVERP_##wc(fs, R))				     \
-	    {								     \
-	      _FP_FRAC_SRS_##wc(R, 1, _FP_WFRACBITS_##fs);		     \
-	      R##_e++;							     \
-	    }								     \
-	}								     \
-      else								     \
-	{								     \
-	  R##_s = X##_s;						     \
-	  _FP_FRAC_SUB_##wc(R, X, Y);					     \
-	  if (_FP_FRAC_ZEROP_##wc(R))					     \
-	    {								     \
-	      /* return an exact zero */				     \
-	      if (FP_ROUNDMODE = FP_RND_MINF)				     \
-		R##_s |= Y##_s;						     \
-	      else							     \
-		R##_s &= Y##_s;						     \
-	      R##_c = FP_CLS_ZERO;					     \
-	    }								     \
-	  else								     \
-	    {								     \
-	      if (_FP_FRAC_NEGP_##wc(R))				     \
-		{							     \
-		  _FP_FRAC_SUB_##wc(R, Y, X);				     \
-		  R##_s = Y##_s;					     \
-		}							     \
-									     \
-	      /* renormalize after subtraction */			     \
-	      _FP_FRAC_CLZ_##wc(diff, R);				     \
-	      diff -= _FP_WFRACXBITS_##fs;				     \
-	      if (diff)							     \
-		{							     \
-		  R##_e -= diff;					     \
-		  _FP_FRAC_SLL_##wc(R, diff);				     \
-		}							     \
-	    }								     \
-	}								     \
-      break;								     \
-    }									     \
-									     \
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_NAN):				     \
-    _FP_CHOOSENAN(fs, wc, R, X, Y, OP);					     \
-    break;								     \
-									     \
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_ZERO):			     \
-    R##_e = X##_e;							     \
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_NORMAL):			     \
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_INF):				     \
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_ZERO):				     \
-    _FP_FRAC_COPY_##wc(R, X);						     \
-    R##_s = X##_s;							     \
-    R##_c = X##_c;							     \
-    break;								     \
-									     \
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_NORMAL):			     \
-    R##_e = Y##_e;							     \
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_NAN):			     \
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_NAN):				     \
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_NAN):				     \
-    _FP_FRAC_COPY_##wc(R, Y);						     \
-    R##_s = Y##_s;							     \
-    R##_c = Y##_c;							     \
-    break;								     \
-									     \
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_INF):				     \
-    if (X##_s != Y##_s)							     \
-      {									     \
-	/* +INF + -INF => NAN */					     \
-	_FP_FRAC_SET_##wc(R, _FP_NANFRAC_##fs);				     \
-	R##_s = _FP_NANSIGN_##fs;					     \
-	R##_c = FP_CLS_NAN;						     \
-	FP_SET_EXCEPTION(FP_EX_INVALID | FP_EX_INVALID_ISI);		     \
-	break;								     \
-      }									     \
-    /* FALLTHRU */							     \
-									     \
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_NORMAL):			     \
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_ZERO):				     \
-    R##_s = X##_s;							     \
-    R##_c = FP_CLS_INF;							     \
-    break;								     \
-									     \
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_INF):			     \
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_INF):				     \
-    R##_s = Y##_s;							     \
-    R##_c = FP_CLS_INF;							     \
-    break;								     \
-									     \
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_ZERO):			     \
-    /* make sure the sign is correct */					     \
-    if (FP_ROUNDMODE = FP_RND_MINF)					     \
-      R##_s = X##_s | Y##_s;						     \
-    else								     \
-      R##_s = X##_s & Y##_s;						     \
-    R##_c = FP_CLS_ZERO;						     \
-    break;								     \
-									     \
-  default:								     \
-    abort();								     \
-  }									     \
-} while (0)
-
-#define _FP_ADD(fs, wc, R, X, Y) _FP_ADD_INTERNAL(fs, wc, R, X, Y, '+')
-#define _FP_SUB(fs, wc, R, X, Y)					     \
-  do {									     \
-    if (Y##_c != FP_CLS_NAN) Y##_s ^= 1;				     \
-    _FP_ADD_INTERNAL(fs, wc, R, X, Y, '-');				     \
-  } while (0)
-
-
-/*
- * Main negation routine.  FIXME -- when we care about setting exception
- * bits reliably, this will not do.  We should examine all of the fp classes.
- */
-
-#define _FP_NEG(fs, wc, R, X)		\
-  do {					\
-    _FP_FRAC_COPY_##wc(R, X);		\
-    R##_c = X##_c;			\
-    R##_e = X##_e;			\
-    R##_s = 1 ^ X##_s;			\
-  } while (0)
-
-
-/*
- * Main multiplication routine.  The input values should be cooked.
- */
-
-#define _FP_MUL(fs, wc, R, X, Y)			\
-do {							\
-  R##_s = X##_s ^ Y##_s;				\
-  switch (_FP_CLS_COMBINE(X##_c, Y##_c))		\
-  {							\
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_NORMAL):	\
-    R##_c = FP_CLS_NORMAL;				\
-    R##_e = X##_e + Y##_e + 1;				\
-							\
-    _FP_MUL_MEAT_##fs(R,X,Y);				\
-							\
-    if (_FP_FRAC_OVERP_##wc(fs, R))			\
-      _FP_FRAC_SRS_##wc(R, 1, _FP_WFRACBITS_##fs);	\
-    else						\
-      R##_e--;						\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_NAN):		\
-    _FP_CHOOSENAN(fs, wc, R, X, Y, '*');		\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_NORMAL):	\
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_INF):		\
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_ZERO):		\
-    R##_s = X##_s;					\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_INF):		\
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_NORMAL):	\
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_NORMAL):	\
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_ZERO):	\
-    _FP_FRAC_COPY_##wc(R, X);				\
-    R##_c = X##_c;					\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_NAN):	\
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_NAN):		\
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_NAN):		\
-    R##_s = Y##_s;					\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_INF):	\
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_ZERO):	\
-    _FP_FRAC_COPY_##wc(R, Y);				\
-    R##_c = Y##_c;					\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_ZERO):		\
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_INF):		\
-    R##_s = _FP_NANSIGN_##fs;				\
-    R##_c = FP_CLS_NAN;					\
-    _FP_FRAC_SET_##wc(R, _FP_NANFRAC_##fs);		\
-    FP_SET_EXCEPTION(FP_EX_INVALID | FP_EX_INVALID_IMZ);\
-    break;						\
-							\
-  default:						\
-    abort();						\
-  }							\
-} while (0)
-
-
-/*
- * Main division routine.  The input values should be cooked.
- */
-
-#define _FP_DIV(fs, wc, R, X, Y)			\
-do {							\
-  R##_s = X##_s ^ Y##_s;				\
-  switch (_FP_CLS_COMBINE(X##_c, Y##_c))		\
-  {							\
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_NORMAL):	\
-    R##_c = FP_CLS_NORMAL;				\
-    R##_e = X##_e - Y##_e;				\
-							\
-    _FP_DIV_MEAT_##fs(R,X,Y);				\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_NAN):		\
-    _FP_CHOOSENAN(fs, wc, R, X, Y, '/');		\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_NORMAL):	\
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_INF):		\
-  case _FP_CLS_COMBINE(FP_CLS_NAN,FP_CLS_ZERO):		\
-    R##_s = X##_s;					\
-    _FP_FRAC_COPY_##wc(R, X);				\
-    R##_c = X##_c;					\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_NAN):	\
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_NAN):		\
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_NAN):		\
-    R##_s = Y##_s;					\
-    _FP_FRAC_COPY_##wc(R, Y);				\
-    R##_c = Y##_c;					\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_INF):	\
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_INF):		\
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_NORMAL):	\
-    R##_c = FP_CLS_ZERO;				\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_NORMAL,FP_CLS_ZERO):	\
-    FP_SET_EXCEPTION(FP_EX_DIVZERO);			\
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_ZERO):		\
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_NORMAL):	\
-    R##_c = FP_CLS_INF;					\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_INF,FP_CLS_INF):		\
-    R##_s = _FP_NANSIGN_##fs;				\
-    R##_c = FP_CLS_NAN;					\
-    _FP_FRAC_SET_##wc(R, _FP_NANFRAC_##fs);		\
-    FP_SET_EXCEPTION(FP_EX_INVALID | FP_EX_INVALID_IDI);\
-    break;						\
-							\
-  case _FP_CLS_COMBINE(FP_CLS_ZERO,FP_CLS_ZERO):	\
-    R##_s = _FP_NANSIGN_##fs;				\
-    R##_c = FP_CLS_NAN;					\
-    _FP_FRAC_SET_##wc(R, _FP_NANFRAC_##fs);		\
-    FP_SET_EXCEPTION(FP_EX_INVALID | FP_EX_INVALID_ZDZ);\
-    break;						\
-							\
-  default:						\
-    abort();						\
-  }							\
-} while (0)
-
-
-/*
- * Main differential comparison routine.  The inputs should be raw not
- * cooked.  The return is -1,0,1 for normal values, 2 otherwise.
- */
-
-#define _FP_CMP(fs, wc, ret, X, Y, un)					\
-  do {									\
-    /* NANs are unordered */						\
-    if ((X##_e = _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc(X))		\
-	|| (Y##_e = _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc(Y)))	\
-      {									\
-	ret = un;							\
-      }									\
-    else								\
-      {									\
-	int __is_zero_x;						\
-	int __is_zero_y;						\
-									\
-	__is_zero_x = (!X##_e && _FP_FRAC_ZEROP_##wc(X)) ? 1 : 0;	\
-	__is_zero_y = (!Y##_e && _FP_FRAC_ZEROP_##wc(Y)) ? 1 : 0;	\
-									\
-	if (__is_zero_x && __is_zero_y)					\
-		ret = 0;						\
-	else if (__is_zero_x)						\
-		ret = Y##_s ? 1 : -1;					\
-	else if (__is_zero_y)						\
-		ret = X##_s ? -1 : 1;					\
-	else if (X##_s != Y##_s)					\
-	  ret = X##_s ? -1 : 1;						\
-	else if (X##_e > Y##_e)						\
-	  ret = X##_s ? -1 : 1;						\
-	else if (X##_e < Y##_e)						\
-	  ret = X##_s ? 1 : -1;						\
-	else if (_FP_FRAC_GT_##wc(X, Y))				\
-	  ret = X##_s ? -1 : 1;						\
-	else if (_FP_FRAC_GT_##wc(Y, X))				\
-	  ret = X##_s ? 1 : -1;						\
-	else								\
-	  ret = 0;							\
-      }									\
-  } while (0)
+  while (0)
+
+
+/* Fused multiply-add.  The input values should be cooked.  */
+
+#define _FP_FMA(fs, wc, dwc, R, X, Y, Z)				\
+  do									\
+    {									\
+      __label__ done_fma;						\
+      FP_DECL_##fs (_FP_FMA_T);						\
+      _FP_FMA_T##_s = X##_s ^ Y##_s;					\
+      _FP_FMA_T##_e = X##_e + Y##_e + 1;				\
+      switch (_FP_CLS_COMBINE (X##_c, Y##_c))				\
+	{								\
+	case _FP_CLS_COMBINE (FP_CLS_NORMAL, FP_CLS_NORMAL):		\
+	  switch (Z##_c)						\
+	    {								\
+	    case FP_CLS_INF:						\
+	    case FP_CLS_NAN:						\
+	      R##_s = Z##_s;						\
+	      _FP_FRAC_COPY_##wc (R, Z);				\
+	      R##_c = Z##_c;						\
+	      break;							\
+									\
+	    case FP_CLS_ZERO:						\
+	      R##_c = FP_CLS_NORMAL;					\
+	      R##_s = _FP_FMA_T##_s;					\
+	      R##_e = _FP_FMA_T##_e;					\
+									\
+	      _FP_MUL_MEAT_##fs (R, X, Y);				\
+									\
+	      if (_FP_FRAC_OVERP_##wc (fs, R))				\
+		_FP_FRAC_SRS_##wc (R, 1, _FP_WFRACBITS_##fs);		\
+	      else							\
+		R##_e--;						\
+	      break;							\
+									\
+	    case FP_CLS_NORMAL:;					\
+	      _FP_FRAC_DECL_##dwc (_FP_FMA_TD);				\
+	      _FP_FRAC_DECL_##dwc (_FP_FMA_ZD);				\
+	      _FP_FRAC_DECL_##dwc (_FP_FMA_RD);				\
+	      _FP_MUL_MEAT_DW_##fs (_FP_FMA_TD, X, Y);			\
+	      R##_e = _FP_FMA_T##_e;					\
+	      int _FP_FMA_tsh						\
+		= _FP_FRAC_HIGHBIT_DW_##dwc (fs, _FP_FMA_TD) = 0;	\
+	      _FP_FMA_T##_e -= _FP_FMA_tsh;				\
+	      int _FP_FMA_ediff = _FP_FMA_T##_e - Z##_e;		\
+	      if (_FP_FMA_ediff >= 0)					\
+		{							\
+		  int _FP_FMA_shift					\
+		    = _FP_WFRACBITS_##fs - _FP_FMA_tsh - _FP_FMA_ediff;	\
+		  if (_FP_FMA_shift <= -_FP_WFRACBITS_##fs)		\
+		    _FP_FRAC_SET_##dwc (_FP_FMA_ZD, _FP_MINFRAC_##dwc);	\
+		  else							\
+		    {							\
+		      _FP_FRAC_COPY_##dwc##_##wc (_FP_FMA_ZD, Z);	\
+		      if (_FP_FMA_shift < 0)				\
+			_FP_FRAC_SRS_##dwc (_FP_FMA_ZD, -_FP_FMA_shift,	\
+					    _FP_WFRACBITS_DW_##fs);	\
+		      else if (_FP_FMA_shift > 0)			\
+			_FP_FRAC_SLL_##dwc (_FP_FMA_ZD, _FP_FMA_shift);	\
+		    }							\
+		  R##_s = _FP_FMA_T##_s;				\
+		  if (_FP_FMA_T##_s = Z##_s)				\
+		    _FP_FRAC_ADD_##dwc (_FP_FMA_RD, _FP_FMA_TD,		\
+					_FP_FMA_ZD);			\
+		  else							\
+		    {							\
+		      _FP_FRAC_SUB_##dwc (_FP_FMA_RD, _FP_FMA_TD,	\
+					  _FP_FMA_ZD);			\
+		      if (_FP_FRAC_NEGP_##dwc (_FP_FMA_RD))		\
+			{						\
+			  R##_s = Z##_s;				\
+			  _FP_FRAC_SUB_##dwc (_FP_FMA_RD, _FP_FMA_ZD,	\
+					      _FP_FMA_TD);		\
+			}						\
+		    }							\
+		}							\
+	      else							\
+		{							\
+		  R##_e = Z##_e;					\
+		  R##_s = Z##_s;					\
+		  _FP_FRAC_COPY_##dwc##_##wc (_FP_FMA_ZD, Z);		\
+		  _FP_FRAC_SLL_##dwc (_FP_FMA_ZD, _FP_WFRACBITS_##fs);	\
+		  int _FP_FMA_shift = -_FP_FMA_ediff - _FP_FMA_tsh;	\
+		  if (_FP_FMA_shift >= _FP_WFRACBITS_DW_##fs)		\
+		    _FP_FRAC_SET_##dwc (_FP_FMA_TD, _FP_MINFRAC_##dwc);	\
+		  else if (_FP_FMA_shift > 0)				\
+		    _FP_FRAC_SRS_##dwc (_FP_FMA_TD, _FP_FMA_shift,	\
+					_FP_WFRACBITS_DW_##fs);		\
+		  if (Z##_s = _FP_FMA_T##_s)				\
+		    _FP_FRAC_ADD_##dwc (_FP_FMA_RD, _FP_FMA_ZD,		\
+					_FP_FMA_TD);			\
+		  else							\
+		    _FP_FRAC_SUB_##dwc (_FP_FMA_RD, _FP_FMA_ZD,		\
+					_FP_FMA_TD);			\
+		}							\
+	      if (_FP_FRAC_ZEROP_##dwc (_FP_FMA_RD))			\
+		{							\
+		  if (_FP_FMA_T##_s = Z##_s)				\
+		    R##_s = Z##_s;					\
+		  else							\
+		    R##_s = (FP_ROUNDMODE = FP_RND_MINF);		\
+		  _FP_FRAC_SET_##wc (R, _FP_ZEROFRAC_##wc);		\
+		  R##_c = FP_CLS_ZERO;					\
+		}							\
+	      else							\
+		{							\
+		  int _FP_FMA_rlz;					\
+		  _FP_FRAC_CLZ_##dwc (_FP_FMA_rlz, _FP_FMA_RD);		\
+		  _FP_FMA_rlz -= _FP_WFRACXBITS_DW_##fs;		\
+		  R##_e -= _FP_FMA_rlz;					\
+		  int _FP_FMA_shift = _FP_WFRACBITS_##fs - _FP_FMA_rlz;	\
+		  if (_FP_FMA_shift > 0)				\
+		    _FP_FRAC_SRS_##dwc (_FP_FMA_RD, _FP_FMA_shift,	\
+					_FP_WFRACBITS_DW_##fs);		\
+		  else if (_FP_FMA_shift < 0)				\
+		    _FP_FRAC_SLL_##dwc (_FP_FMA_RD, -_FP_FMA_shift);	\
+		  _FP_FRAC_COPY_##wc##_##dwc (R, _FP_FMA_RD);		\
+		  R##_c = FP_CLS_NORMAL;				\
+		}							\
+	      break;							\
+	    }								\
+	  goto done_fma;						\
+									\
+	case _FP_CLS_COMBINE (FP_CLS_NAN, FP_CLS_NAN):			\
+	  _FP_CHOOSENAN (fs, wc, _FP_FMA_T, X, Y, '*');			\
+	  break;							\
+									\
+	case _FP_CLS_COMBINE (FP_CLS_NAN, FP_CLS_NORMAL):		\
+	case _FP_CLS_COMBINE (FP_CLS_NAN, FP_CLS_INF):			\
+	case _FP_CLS_COMBINE (FP_CLS_NAN, FP_CLS_ZERO):			\
+	  _FP_FMA_T##_s = X##_s;					\
+									\
+	case _FP_CLS_COMBINE (FP_CLS_INF, FP_CLS_INF):			\
+	case _FP_CLS_COMBINE (FP_CLS_INF, FP_CLS_NORMAL):		\
+	case _FP_CLS_COMBINE (FP_CLS_ZERO, FP_CLS_NORMAL):		\
+	case _FP_CLS_COMBINE (FP_CLS_ZERO, FP_CLS_ZERO):		\
+	  _FP_FRAC_COPY_##wc (_FP_FMA_T, X);				\
+	  _FP_FMA_T##_c = X##_c;					\
+	  break;							\
+									\
+	case _FP_CLS_COMBINE (FP_CLS_NORMAL, FP_CLS_NAN):		\
+	case _FP_CLS_COMBINE (FP_CLS_INF, FP_CLS_NAN):			\
+	case _FP_CLS_COMBINE (FP_CLS_ZERO, FP_CLS_NAN):			\
+	  _FP_FMA_T##_s = Y##_s;					\
+									\
+	case _FP_CLS_COMBINE (FP_CLS_NORMAL, FP_CLS_INF):		\
+	case _FP_CLS_COMBINE (FP_CLS_NORMAL, FP_CLS_ZERO):		\
+	  _FP_FRAC_COPY_##wc (_FP_FMA_T, Y);				\
+	  _FP_FMA_T##_c = Y##_c;					\
+	  break;							\
+									\
+	case _FP_CLS_COMBINE (FP_CLS_INF, FP_CLS_ZERO):			\
+	case _FP_CLS_COMBINE (FP_CLS_ZERO, FP_CLS_INF):			\
+	  _FP_FMA_T##_s = _FP_NANSIGN_##fs;				\
+	  _FP_FMA_T##_c = FP_CLS_NAN;					\
+	  _FP_FRAC_SET_##wc (_FP_FMA_T, _FP_NANFRAC_##fs);		\
+	  FP_SET_EXCEPTION (FP_EX_INVALID | FP_EX_INVALID_IMZ_FMA);	\
+	  break;							\
+									\
+	default:							\
+	  _FP_UNREACHABLE;						\
+	}								\
+									\
+      /* T = X * Y is zero, infinity or NaN.  */			\
+      switch (_FP_CLS_COMBINE (_FP_FMA_T##_c, Z##_c))			\
+	{								\
+	case _FP_CLS_COMBINE (FP_CLS_NAN, FP_CLS_NAN):			\
+	  _FP_CHOOSENAN (fs, wc, R, _FP_FMA_T, Z, '+');			\
+	  break;							\
+									\
+	case _FP_CLS_COMBINE (FP_CLS_NAN, FP_CLS_NORMAL):		\
+	case _FP_CLS_COMBINE (FP_CLS_NAN, FP_CLS_INF):			\
+	case _FP_CLS_COMBINE (FP_CLS_NAN, FP_CLS_ZERO):			\
+	case _FP_CLS_COMBINE (FP_CLS_INF, FP_CLS_NORMAL):		\
+	case _FP_CLS_COMBINE (FP_CLS_INF, FP_CLS_ZERO):			\
+	  R##_s = _FP_FMA_T##_s;					\
+	  _FP_FRAC_COPY_##wc (R, _FP_FMA_T);				\
+	  R##_c = _FP_FMA_T##_c;					\
+	  break;							\
+									\
+	case _FP_CLS_COMBINE (FP_CLS_INF, FP_CLS_NAN):			\
+	case _FP_CLS_COMBINE (FP_CLS_ZERO, FP_CLS_NAN):			\
+	case _FP_CLS_COMBINE (FP_CLS_ZERO, FP_CLS_NORMAL):		\
+	case _FP_CLS_COMBINE (FP_CLS_ZERO, FP_CLS_INF):			\
+	  R##_s = Z##_s;						\
+	  _FP_FRAC_COPY_##wc (R, Z);					\
+	  R##_c = Z##_c;						\
+	  R##_e = Z##_e;						\
+	  break;							\
+									\
+	case _FP_CLS_COMBINE (FP_CLS_INF, FP_CLS_INF):			\
+	  if (_FP_FMA_T##_s = Z##_s)					\
+	    {								\
+	      R##_s = Z##_s;						\
+	      _FP_FRAC_COPY_##wc (R, Z);				\
+	      R##_c = Z##_c;						\
+	    }								\
+	  else								\
+	    {								\
+	      R##_s = _FP_NANSIGN_##fs;					\
+	      R##_c = FP_CLS_NAN;					\
+	      _FP_FRAC_SET_##wc (R, _FP_NANFRAC_##fs);			\
+	      FP_SET_EXCEPTION (FP_EX_INVALID | FP_EX_INVALID_ISI);	\
+	    }								\
+	  break;							\
+									\
+	case _FP_CLS_COMBINE (FP_CLS_ZERO, FP_CLS_ZERO):		\
+	  if (_FP_FMA_T##_s = Z##_s)					\
+	    R##_s = Z##_s;						\
+	  else								\
+	    R##_s = (FP_ROUNDMODE = FP_RND_MINF);			\
+	  _FP_FRAC_COPY_##wc (R, Z);					\
+	  R##_c = Z##_c;						\
+	  break;							\
+									\
+	default:							\
+	  _FP_UNREACHABLE;						\
+	}								\
+    done_fma: ;								\
+    }									\
+  while (0)
+
+
+/* Main division routine.  The input values should be cooked.  */
+
+#define _FP_DIV(fs, wc, R, X, Y)				\
+  do								\
+    {								\
+      R##_s = X##_s ^ Y##_s;					\
+      R##_e = X##_e - Y##_e;					\
+      switch (_FP_CLS_COMBINE (X##_c, Y##_c))			\
+	{							\
+	case _FP_CLS_COMBINE (FP_CLS_NORMAL, FP_CLS_NORMAL):	\
+	  R##_c = FP_CLS_NORMAL;				\
+								\
+	  _FP_DIV_MEAT_##fs (R, X, Y);				\
+	  break;						\
+								\
+	case _FP_CLS_COMBINE (FP_CLS_NAN, FP_CLS_NAN):		\
+	  _FP_CHOOSENAN (fs, wc, R, X, Y, '/');			\
+	  break;						\
+								\
+	case _FP_CLS_COMBINE (FP_CLS_NAN, FP_CLS_NORMAL):	\
+	case _FP_CLS_COMBINE (FP_CLS_NAN, FP_CLS_INF):		\
+	case _FP_CLS_COMBINE (FP_CLS_NAN, FP_CLS_ZERO):		\
+	  R##_s = X##_s;					\
+	  _FP_FRAC_COPY_##wc (R, X);				\
+	  R##_c = X##_c;					\
+	  break;						\
+								\
+	case _FP_CLS_COMBINE (FP_CLS_NORMAL, FP_CLS_NAN):	\
+	case _FP_CLS_COMBINE (FP_CLS_INF, FP_CLS_NAN):		\
+	case _FP_CLS_COMBINE (FP_CLS_ZERO, FP_CLS_NAN):		\
+	  R##_s = Y##_s;					\
+	  _FP_FRAC_COPY_##wc (R, Y);				\
+	  R##_c = Y##_c;					\
+	  break;						\
+								\
+	case _FP_CLS_COMBINE (FP_CLS_NORMAL, FP_CLS_INF):	\
+	case _FP_CLS_COMBINE (FP_CLS_ZERO, FP_CLS_INF):		\
+	case _FP_CLS_COMBINE (FP_CLS_ZERO, FP_CLS_NORMAL):	\
+	  R##_c = FP_CLS_ZERO;					\
+	  break;						\
+								\
+	case _FP_CLS_COMBINE (FP_CLS_NORMAL, FP_CLS_ZERO):	\
+	  FP_SET_EXCEPTION (FP_EX_DIVZERO);			\
+	case _FP_CLS_COMBINE (FP_CLS_INF, FP_CLS_ZERO):		\
+	case _FP_CLS_COMBINE (FP_CLS_INF, FP_CLS_NORMAL):	\
+	  R##_c = FP_CLS_INF;					\
+	  break;						\
+								\
+	case _FP_CLS_COMBINE (FP_CLS_INF, FP_CLS_INF):		\
+	case _FP_CLS_COMBINE (FP_CLS_ZERO, FP_CLS_ZERO):	\
+	  R##_s = _FP_NANSIGN_##fs;				\
+	  R##_c = FP_CLS_NAN;					\
+	  _FP_FRAC_SET_##wc (R, _FP_NANFRAC_##fs);		\
+	  FP_SET_EXCEPTION (FP_EX_INVALID			\
+			    | (X##_c = FP_CLS_INF		\
+			       ? FP_EX_INVALID_IDI		\
+			       : FP_EX_INVALID_ZDZ));		\
+	  break;						\
+								\
+	default:						\
+	  _FP_UNREACHABLE;					\
+	}							\
+    }								\
+  while (0)
+
+
+/* Helper for comparisons.  EX is 0 not to raise exceptions, 1 to
+   raise exceptions for signaling NaN operands, 2 to raise exceptions
+   for all NaN operands.  Conditionals are organized to allow the
+   compiler to optimize away code based on the value of EX.  */
+
+#define _FP_CMP_CHECK_NAN(fs, wc, X, Y, ex)				\
+  do									\
+    {									\
+      /* The arguments are unordered, which may or may not result in	\
+	 an exception.  */						\
+      if (ex)								\
+	{								\
+	  /* At least some cases of unordered arguments result in	\
+	     exceptions; check whether this is one.  */			\
+	  if (FP_EX_INVALID_SNAN || FP_EX_INVALID_VC)			\
+	    {								\
+	      /* Check separately for each case of "invalid"		\
+		 exceptions.  */					\
+	      if ((ex) = 2)						\
+		FP_SET_EXCEPTION (FP_EX_INVALID | FP_EX_INVALID_VC);	\
+	      if (_FP_ISSIGNAN (fs, wc, X)				\
+		  || _FP_ISSIGNAN (fs, wc, Y))				\
+		FP_SET_EXCEPTION (FP_EX_INVALID | FP_EX_INVALID_SNAN);	\
+	    }								\
+	  /* Otherwise, we only need to check whether to raise an	\
+	     exception, not which case or cases it is.  */		\
+	  else if ((ex) = 2						\
+		   || _FP_ISSIGNAN (fs, wc, X)				\
+		   || _FP_ISSIGNAN (fs, wc, Y))				\
+	    FP_SET_EXCEPTION (FP_EX_INVALID);				\
+	}								\
+    }									\
+  while (0)
+
+/* Helper for comparisons.  If denormal operands would raise an
+   exception, check for them, and flush to zero as appropriate
+   (otherwise, we need only check and flush to zero if it might affect
+   the result, which is done later with _FP_CMP_CHECK_FLUSH_ZERO).  */
+#define _FP_CMP_CHECK_DENORM(fs, wc, X, Y)				\
+  do									\
+    {									\
+      if (FP_EX_DENORM != 0)						\
+	{								\
+	  /* We must ensure the correct exceptions are raised for	\
+	     denormal operands, even though this may not affect the	\
+	     result of the comparison.  */				\
+	  if (FP_DENORM_ZERO)						\
+	    {								\
+	      _FP_CHECK_FLUSH_ZERO (fs, wc, X);				\
+	      _FP_CHECK_FLUSH_ZERO (fs, wc, Y);				\
+	    }								\
+	  else								\
+	    {								\
+	      if ((X##_e = 0 && !_FP_FRAC_ZEROP_##wc (X))		\
+		  || (Y##_e = 0 && !_FP_FRAC_ZEROP_##wc (Y)))		\
+		FP_SET_EXCEPTION (FP_EX_DENORM);			\
+	    }								\
+	}								\
+    }									\
+  while (0)
+
+/* Helper for comparisons.  Check for flushing denormals for zero if
+   we didn't need to check earlier for any denormal operands.  */
+#define _FP_CMP_CHECK_FLUSH_ZERO(fs, wc, X, Y)	\
+  do						\
+    {						\
+      if (FP_EX_DENORM = 0)			\
+	{					\
+	  _FP_CHECK_FLUSH_ZERO (fs, wc, X);	\
+	  _FP_CHECK_FLUSH_ZERO (fs, wc, Y);	\
+	}					\
+    }						\
+  while (0)
+
+/* Main differential comparison routine.  The inputs should be raw not
+   cooked.  The return is -1, 0, 1 for normal values, UN
+   otherwise.  */
+
+#define _FP_CMP(fs, wc, ret, X, Y, un, ex)				\
+  do									\
+    {									\
+      _FP_CMP_CHECK_DENORM (fs, wc, X, Y);				\
+      /* NANs are unordered.  */					\
+      if ((X##_e = _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc (X))	\
+	  || (Y##_e = _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc (Y)))	\
+	{								\
+	  (ret) = (un);							\
+	  _FP_CMP_CHECK_NAN (fs, wc, X, Y, (ex));			\
+	}								\
+      else								\
+	{								\
+	  int _FP_CMP_is_zero_x;					\
+	  int _FP_CMP_is_zero_y;					\
+									\
+	  _FP_CMP_CHECK_FLUSH_ZERO (fs, wc, X, Y);			\
+									\
+	  _FP_CMP_is_zero_x						\
+	    = (!X##_e && _FP_FRAC_ZEROP_##wc (X)) ? 1 : 0;		\
+	  _FP_CMP_is_zero_y						\
+	    = (!Y##_e && _FP_FRAC_ZEROP_##wc (Y)) ? 1 : 0;		\
+									\
+	  if (_FP_CMP_is_zero_x && _FP_CMP_is_zero_y)			\
+	    (ret) = 0;							\
+	  else if (_FP_CMP_is_zero_x)					\
+	    (ret) = Y##_s ? 1 : -1;					\
+	  else if (_FP_CMP_is_zero_y)					\
+	    (ret) = X##_s ? -1 : 1;					\
+	  else if (X##_s != Y##_s)					\
+	    (ret) = X##_s ? -1 : 1;					\
+	  else if (X##_e > Y##_e)					\
+	    (ret) = X##_s ? -1 : 1;					\
+	  else if (X##_e < Y##_e)					\
+	    (ret) = X##_s ? 1 : -1;					\
+	  else if (_FP_FRAC_GT_##wc (X, Y))				\
+	    (ret) = X##_s ? -1 : 1;					\
+	  else if (_FP_FRAC_GT_##wc (Y, X))				\
+	    (ret) = X##_s ? 1 : -1;					\
+	  else								\
+	    (ret) = 0;							\
+	}								\
+    }									\
+  while (0)
 
 
 /* Simplification for strict equality.  */
 
-#define _FP_CMP_EQ(fs, wc, ret, X, Y)					  \
-  do {									  \
-    /* NANs are unordered */						  \
-    if ((X##_e = _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc(X))		  \
-	|| (Y##_e = _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc(Y)))	  \
-      {									  \
-	ret = 1;							  \
-      }									  \
-    else								  \
-      {									  \
-	ret = !(X##_e = Y##_e						  \
-		&& _FP_FRAC_EQ_##wc(X, Y)				  \
-		&& (X##_s = Y##_s || !X##_e && _FP_FRAC_ZEROP_##wc(X))); \
-      }									  \
-  } while (0)
-
-/*
- * Main square root routine.  The input value should be cooked.
- */
+#define _FP_CMP_EQ(fs, wc, ret, X, Y, ex)				\
+  do									\
+    {									\
+      _FP_CMP_CHECK_DENORM (fs, wc, X, Y);				\
+      /* NANs are unordered.  */					\
+      if ((X##_e = _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc (X))	\
+	  || (Y##_e = _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc (Y)))	\
+	{								\
+	  (ret) = 1;							\
+	  _FP_CMP_CHECK_NAN (fs, wc, X, Y, (ex));			\
+	}								\
+      else								\
+	{								\
+	  _FP_CMP_CHECK_FLUSH_ZERO (fs, wc, X, Y);			\
+									\
+	  (ret) = !(X##_e = Y##_e					\
+		    && _FP_FRAC_EQ_##wc (X, Y)				\
+		    && (X##_s = Y##_s					\
+			|| (!X##_e && _FP_FRAC_ZEROP_##wc (X))));	\
+	}								\
+    }									\
+  while (0)
+
+/* Version to test unordered.  */
+
+#define _FP_CMP_UNORD(fs, wc, ret, X, Y, ex)				\
+  do									\
+    {									\
+      _FP_CMP_CHECK_DENORM (fs, wc, X, Y);				\
+      (ret) = ((X##_e = _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc (X))	\
+	       || (Y##_e = _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc (Y))); \
+      if (ret)								\
+	_FP_CMP_CHECK_NAN (fs, wc, X, Y, (ex));				\
+    }									\
+  while (0)
+
+/* Main square root routine.  The input value should be cooked.  */
 
 #define _FP_SQRT(fs, wc, R, X)						\
-do {									\
-    _FP_FRAC_DECL_##wc(T); _FP_FRAC_DECL_##wc(S);			\
-    _FP_W_TYPE q;							\
-    switch (X##_c)							\
+  do									\
     {									\
-    case FP_CLS_NAN:							\
-	_FP_FRAC_COPY_##wc(R, X);					\
-	R##_s = X##_s;							\
-    	R##_c = FP_CLS_NAN;						\
-    	break;								\
-    case FP_CLS_INF:							\
-    	if (X##_s)							\
-    	  {								\
-    	    R##_s = _FP_NANSIGN_##fs;					\
-	    R##_c = FP_CLS_NAN; /* NAN */				\
-	    _FP_FRAC_SET_##wc(R, _FP_NANFRAC_##fs);			\
-	    FP_SET_EXCEPTION(FP_EX_INVALID);				\
-    	  }								\
-    	else								\
-    	  {								\
-    	    R##_s = 0;							\
-    	    R##_c = FP_CLS_INF; /* sqrt(+inf) = +inf */			\
-    	  }								\
-    	break;								\
-    case FP_CLS_ZERO:							\
-	R##_s = X##_s;							\
-	R##_c = FP_CLS_ZERO; /* sqrt(+-0) = +-0 */			\
-	break;								\
-    case FP_CLS_NORMAL:							\
-    	R##_s = 0;							\
-        if (X##_s)							\
-          {								\
-	    R##_c = FP_CLS_NAN; /* sNAN */				\
-	    R##_s = _FP_NANSIGN_##fs;					\
-	    _FP_FRAC_SET_##wc(R, _FP_NANFRAC_##fs);			\
-	    FP_SET_EXCEPTION(FP_EX_INVALID);				\
-	    break;							\
-          }								\
-    	R##_c = FP_CLS_NORMAL;						\
-        if (X##_e & 1)							\
-          _FP_FRAC_SLL_##wc(X, 1);					\
-        R##_e = X##_e >> 1;						\
-        _FP_FRAC_SET_##wc(S, _FP_ZEROFRAC_##wc);			\
-        _FP_FRAC_SET_##wc(R, _FP_ZEROFRAC_##wc);			\
-        q = _FP_OVERFLOW_##fs >> 1;					\
-        _FP_SQRT_MEAT_##wc(R, S, T, X, q);				\
+      _FP_FRAC_DECL_##wc (_FP_SQRT_T);					\
+      _FP_FRAC_DECL_##wc (_FP_SQRT_S);					\
+      _FP_W_TYPE _FP_SQRT_q;						\
+      switch (X##_c)							\
+	{								\
+	case FP_CLS_NAN:						\
+	  _FP_FRAC_COPY_##wc (R, X);					\
+	  R##_s = X##_s;						\
+	  R##_c = FP_CLS_NAN;						\
+	  break;							\
+	case FP_CLS_INF:						\
+	  if (X##_s)							\
+	    {								\
+	      R##_s = _FP_NANSIGN_##fs;					\
+	      R##_c = FP_CLS_NAN; /* NAN */				\
+	      _FP_FRAC_SET_##wc (R, _FP_NANFRAC_##fs);			\
+	      FP_SET_EXCEPTION (FP_EX_INVALID | FP_EX_INVALID_SQRT);	\
+	    }								\
+	  else								\
+	    {								\
+	      R##_s = 0;						\
+	      R##_c = FP_CLS_INF; /* sqrt(+inf) = +inf */		\
+	    }								\
+	  break;							\
+	case FP_CLS_ZERO:						\
+	  R##_s = X##_s;						\
+	  R##_c = FP_CLS_ZERO; /* sqrt(+-0) = +-0 */			\
+	  break;							\
+	case FP_CLS_NORMAL:						\
+	  R##_s = 0;							\
+	  if (X##_s)							\
+	    {								\
+	      R##_c = FP_CLS_NAN; /* NAN */				\
+	      R##_s = _FP_NANSIGN_##fs;					\
+	      _FP_FRAC_SET_##wc (R, _FP_NANFRAC_##fs);			\
+	      FP_SET_EXCEPTION (FP_EX_INVALID | FP_EX_INVALID_SQRT);	\
+	      break;							\
+	    }								\
+	  R##_c = FP_CLS_NORMAL;					\
+	  if (X##_e & 1)						\
+	    _FP_FRAC_SLL_##wc (X, 1);					\
+	  R##_e = X##_e >> 1;						\
+	  _FP_FRAC_SET_##wc (_FP_SQRT_S, _FP_ZEROFRAC_##wc);		\
+	  _FP_FRAC_SET_##wc (R, _FP_ZEROFRAC_##wc);			\
+	  _FP_SQRT_q = _FP_OVERFLOW_##fs >> 1;				\
+	  _FP_SQRT_MEAT_##wc (R, _FP_SQRT_S, _FP_SQRT_T, X,		\
+			      _FP_SQRT_q);				\
+	}								\
     }									\
-  } while (0)
+  while (0)
 
-/*
- * Convert from FP to integer
- */
+/* Convert from FP to integer.  Input is raw.  */
 
 /* RSIGNED can have following values:
- * 0:  the number is required to be 0..(2^rsize)-1, if not, NV is set plus
- *     the result is either 0 or (2^rsize)-1 depending on the sign in such case.
- * 1:  the number is required to be -(2^(rsize-1))..(2^(rsize-1))-1, if not, NV is
- *     set plus the result is either -(2^(rsize-1)) or (2^(rsize-1))-1 depending
- *     on the sign in such case.
- * 2:  the number is required to be -(2^(rsize-1))..(2^(rsize-1))-1, if not, NV is
- *     set plus the result is truncated to fit into destination.
- * -1: the number is required to be -(2^(rsize-1))..(2^rsize)-1, if not, NV is
- *     set plus the result is either -(2^(rsize-1)) or (2^(rsize-1))-1 depending
- *     on the sign in such case.
- */
-#define _FP_TO_INT(fs, wc, r, X, rsize, rsigned)				\
-  do {										\
-    switch (X##_c)								\
-      {										\
-      case FP_CLS_NORMAL:							\
-	if (X##_e < 0)								\
-	  {									\
-	    FP_SET_EXCEPTION(FP_EX_INEXACT);					\
-	  case FP_CLS_ZERO:							\
-	    r = 0;								\
-	  }									\
-	else if (X##_e >= rsize - (rsigned > 0 || X##_s)			\
-		 || (!rsigned && X##_s))					\
-	  {	/* overflow */							\
-	  case FP_CLS_NAN:                                                      \
-	  case FP_CLS_INF:							\
-	    if (rsigned = 2)							\
-	      {									\
-		if (X##_c != FP_CLS_NORMAL					\
-		    || X##_e >= rsize - 1 + _FP_WFRACBITS_##fs)			\
-		  r = 0;							\
-		else								\
-		  {								\
-		    _FP_FRAC_SLL_##wc(X, (X##_e - _FP_WFRACBITS_##fs + 1));	\
-		    _FP_FRAC_ASSEMBLE_##wc(r, X, rsize);			\
-		  }								\
-	      }									\
-	    else if (rsigned)							\
-	      {									\
-		r = 1;								\
-		r <<= rsize - 1;						\
-		r -= 1 - X##_s;							\
-	      }									\
-	    else								\
-	      {									\
-		r = 0;								\
-		if (!X##_s)							\
-		  r = ~r;							\
-	      }									\
-	    FP_SET_EXCEPTION(FP_EX_INVALID);					\
-	  }									\
-	else									\
-	  {									\
-	    if (_FP_W_TYPE_SIZE*wc < rsize)					\
-	      {									\
-		_FP_FRAC_ASSEMBLE_##wc(r, X, rsize);				\
-		r <<= X##_e - _FP_WFRACBITS_##fs;				\
-	      }									\
-	    else								\
-	      {									\
-		if (X##_e >= _FP_WFRACBITS_##fs)				\
-		  _FP_FRAC_SLL_##wc(X, (X##_e - _FP_WFRACBITS_##fs + 1));	\
-		else if (X##_e < _FP_WFRACBITS_##fs - 1)			\
-		  {								\
-		    _FP_FRAC_SRS_##wc(X, (_FP_WFRACBITS_##fs - X##_e - 2),	\
-				      _FP_WFRACBITS_##fs);			\
-		    if (_FP_FRAC_LOW_##wc(X) & 1)				\
-		      FP_SET_EXCEPTION(FP_EX_INEXACT);				\
-		    _FP_FRAC_SRL_##wc(X, 1);					\
-		  }								\
-		_FP_FRAC_ASSEMBLE_##wc(r, X, rsize);				\
-	      }									\
-	    if (rsigned && X##_s)						\
-	      r = -r;								\
-	  }									\
-	break;									\
-      }										\
-  } while (0)
-
-#define _FP_TO_INT_ROUND(fs, wc, r, X, rsize, rsigned)				\
-  do {										\
-    r = 0;									\
-    switch (X##_c)								\
-      {										\
-      case FP_CLS_NORMAL:							\
-	if (X##_e >= _FP_FRACBITS_##fs - 1)					\
-	  {									\
-	    if (X##_e < rsize - 1 + _FP_WFRACBITS_##fs)				\
-	      {									\
-		if (X##_e >= _FP_WFRACBITS_##fs - 1)				\
-		  {								\
-		    _FP_FRAC_ASSEMBLE_##wc(r, X, rsize);			\
-		    r <<= X##_e - _FP_WFRACBITS_##fs + 1;			\
-		  }								\
-		else								\
-		  {								\
-		    _FP_FRAC_SRL_##wc(X, _FP_WORKBITS - X##_e			\
-				      + _FP_FRACBITS_##fs - 1);			\
-		    _FP_FRAC_ASSEMBLE_##wc(r, X, rsize);			\
-		  }								\
-	      }									\
-	  }									\
-	else									\
-	  {									\
-	    int _lz0, _lz1;							\
-	    if (X##_e <= -_FP_WORKBITS - 1)					\
-	      _FP_FRAC_SET_##wc(X, _FP_MINFRAC_##wc);				\
-	    else								\
-	      _FP_FRAC_SRS_##wc(X, _FP_FRACBITS_##fs - 1 - X##_e,		\
-				_FP_WFRACBITS_##fs);				\
-	    _FP_FRAC_CLZ_##wc(_lz0, X);						\
-	    _FP_ROUND(wc, X);							\
-	    _FP_FRAC_CLZ_##wc(_lz1, X);						\
-	    if (_lz1 < _lz0)							\
-	      X##_e++; /* For overflow detection.  */				\
-	    _FP_FRAC_SRL_##wc(X, _FP_WORKBITS);					\
-	    _FP_FRAC_ASSEMBLE_##wc(r, X, rsize);				\
-	  }									\
-	if (rsigned && X##_s)							\
-	  r = -r;								\
-	if (X##_e >= rsize - (rsigned > 0 || X##_s)				\
-	    || (!rsigned && X##_s))						\
-	  {	/* overflow */							\
-	  case FP_CLS_NAN:                                                      \
-	  case FP_CLS_INF:							\
-	    if (!rsigned)							\
-	      {									\
-		r = 0;								\
-		if (!X##_s)							\
-		  r = ~r;							\
-	      }									\
-	    else if (rsigned != 2)						\
-	      {									\
-		r = 1;								\
-		r <<= rsize - 1;						\
-		r -= 1 - X##_s;							\
-	      }									\
-	    FP_SET_EXCEPTION(FP_EX_INVALID);					\
-	  }									\
-	break;									\
-      case FP_CLS_ZERO:								\
-        break;									\
-      }										\
-  } while (0)
+   0:  the number is required to be 0..(2^rsize)-1, if not, NV is set plus
+       the result is either 0 or (2^rsize)-1 depending on the sign in such
+       case.
+   1:  the number is required to be -(2^(rsize-1))..(2^(rsize-1))-1, if not,
+       NV is set plus the result is either -(2^(rsize-1)) or (2^(rsize-1))-1
+       depending on the sign in such case.
+   2:  the number is required to be -(2^(rsize-1))..(2^(rsize-1))-1, if not,
+       NV is set plus the result is reduced modulo 2^rsize.
+   -1: the number is required to be -(2^(rsize-1))..(2^rsize)-1, if not, NV is
+       set plus the result is either -(2^(rsize-1)) or (2^(rsize-1))-1
+       depending on the sign in such case.  */
+#define _FP_TO_INT(fs, wc, r, X, rsize, rsigned)			\
+  do									\
+    {									\
+      if (X##_e < _FP_EXPBIAS_##fs)					\
+	{								\
+	  (r) = 0;							\
+	  if (X##_e = 0)						\
+	    {								\
+	      if (!_FP_FRAC_ZEROP_##wc (X))				\
+		{							\
+		  if (!FP_DENORM_ZERO)					\
+		    FP_SET_EXCEPTION (FP_EX_INEXACT);			\
+		  FP_SET_EXCEPTION (FP_EX_DENORM);			\
+		}							\
+	    }								\
+	  else								\
+	    FP_SET_EXCEPTION (FP_EX_INEXACT);				\
+	}								\
+      else if ((rsigned) = 2						\
+	       && (X##_e						\
+		   >= ((_FP_EXPMAX_##fs					\
+			< _FP_EXPBIAS_##fs + _FP_FRACBITS_##fs + (rsize) - 1) \
+		       ? _FP_EXPMAX_##fs				\
+		       : _FP_EXPBIAS_##fs + _FP_FRACBITS_##fs + (rsize) - 1))) \
+	{								\
+	  /* Overflow resulting in 0.  */				\
+	  (r) = 0;							\
+	  FP_SET_EXCEPTION (FP_EX_INVALID				\
+			    | FP_EX_INVALID_CVI				\
+			    | ((FP_EX_INVALID_SNAN			\
+				&& _FP_ISSIGNAN (fs, wc, X))		\
+			       ? FP_EX_INVALID_SNAN			\
+			       : 0));					\
+	}								\
+      else if ((rsigned) != 2						\
+	       && (X##_e >= (_FP_EXPMAX_##fs < _FP_EXPBIAS_##fs + (rsize) \
+			     ? _FP_EXPMAX_##fs				\
+			     : (_FP_EXPBIAS_##fs + (rsize)		\
+				- ((rsigned) > 0 || X##_s)))		\
+		   || (!(rsigned) && X##_s)))				\
+	{								\
+	  /* Overflow or converting to the most negative integer.  */	\
+	  if (rsigned)							\
+	    {								\
+	      (r) = 1;							\
+	      (r) <<= (rsize) - 1;					\
+	      (r) -= 1 - X##_s;						\
+	    }								\
+	  else								\
+	    {								\
+	      (r) = 0;							\
+	      if (!X##_s)						\
+		(r) = ~(r);						\
+	    }								\
+									\
+	  if (_FP_EXPBIAS_##fs + (rsize) - 1 < _FP_EXPMAX_##fs		\
+	      && (rsigned)						\
+	      && X##_s							\
+	      && X##_e = _FP_EXPBIAS_##fs + (rsize) - 1)		\
+	    {								\
+	      /* Possibly converting to most negative integer; check the \
+		 mantissa.  */						\
+	      int _FP_TO_INT_inexact = 0;				\
+	      (void) ((_FP_FRACBITS_##fs > (rsize))			\
+		      ? ({						\
+			  _FP_FRAC_SRST_##wc (X, _FP_TO_INT_inexact,	\
+					      _FP_FRACBITS_##fs - (rsize), \
+					      _FP_FRACBITS_##fs);	\
+			  0;						\
+			})						\
+		      : 0);						\
+	      if (!_FP_FRAC_ZEROP_##wc (X))				\
+		FP_SET_EXCEPTION (FP_EX_INVALID | FP_EX_INVALID_CVI);	\
+	      else if (_FP_TO_INT_inexact)				\
+		FP_SET_EXCEPTION (FP_EX_INEXACT);			\
+	    }								\
+	  else								\
+	    FP_SET_EXCEPTION (FP_EX_INVALID				\
+			      | FP_EX_INVALID_CVI			\
+			      | ((FP_EX_INVALID_SNAN			\
+				  && _FP_ISSIGNAN (fs, wc, X))		\
+				 ? FP_EX_INVALID_SNAN			\
+				 : 0));					\
+	}								\
+      else								\
+	{								\
+	  int _FP_TO_INT_inexact = 0;					\
+	  _FP_FRAC_HIGH_RAW_##fs (X) |= _FP_IMPLBIT_##fs;		\
+	  if (X##_e >= _FP_EXPBIAS_##fs + _FP_FRACBITS_##fs - 1)	\
+	    {								\
+	      _FP_FRAC_ASSEMBLE_##wc ((r), X, (rsize));			\
+	      (r) <<= X##_e - _FP_EXPBIAS_##fs - _FP_FRACBITS_##fs + 1; \
+	    }								\
+	  else								\
+	    {								\
+	      _FP_FRAC_SRST_##wc (X, _FP_TO_INT_inexact,		\
+				  (_FP_FRACBITS_##fs + _FP_EXPBIAS_##fs - 1 \
+				   - X##_e),				\
+				  _FP_FRACBITS_##fs);			\
+	      _FP_FRAC_ASSEMBLE_##wc ((r), X, (rsize));			\
+	    }								\
+	  if ((rsigned) && X##_s)					\
+	    (r) = -(r);							\
+	  if ((rsigned) = 2 && X##_e >= _FP_EXPBIAS_##fs + (rsize) - 1) \
+	    {								\
+	      /* Overflow or converting to the most negative integer.  */ \
+	      if (X##_e > _FP_EXPBIAS_##fs + (rsize) - 1		\
+		  || !X##_s						\
+		  || (r) != (((typeof (r)) 1) << ((rsize) - 1)))	\
+		{							\
+		  _FP_TO_INT_inexact = 0;				\
+		  FP_SET_EXCEPTION (FP_EX_INVALID | FP_EX_INVALID_CVI);	\
+		}							\
+	    }								\
+	  if (_FP_TO_INT_inexact)					\
+	    FP_SET_EXCEPTION (FP_EX_INEXACT);				\
+	}								\
+    }									\
+  while (0)
+
+/* Convert from floating point to integer, rounding according to the
+   current rounding direction.  Input is raw.  RSIGNED is as for
+   _FP_TO_INT.  */
+#define _FP_TO_INT_ROUND(fs, wc, r, X, rsize, rsigned)			\
+  do									\
+    {									\
+      __label__ _FP_TO_INT_ROUND_done;					\
+      if (X##_e < _FP_EXPBIAS_##fs)					\
+	{								\
+	  int _FP_TO_INT_ROUND_rounds_away = 0;				\
+	  if (X##_e = 0)						\
+	    {								\
+	      if (_FP_FRAC_ZEROP_##wc (X))				\
+		{							\
+		  (r) = 0;						\
+		  goto _FP_TO_INT_ROUND_done;				\
+		}							\
+	      else							\
+		{							\
+		  FP_SET_EXCEPTION (FP_EX_DENORM);			\
+		  if (FP_DENORM_ZERO)					\
+		    {							\
+		      (r) = 0;						\
+		      goto _FP_TO_INT_ROUND_done;			\
+		    }							\
+		}							\
+	    }								\
+	  /* The result is 0, 1 or -1 depending on the rounding mode;	\
+	     -1 may cause overflow in the unsigned case.  */		\
+	  switch (FP_ROUNDMODE)						\
+	    {								\
+	    case FP_RND_NEAREST:					\
+	      _FP_TO_INT_ROUND_rounds_away				\
+		= (X##_e = _FP_EXPBIAS_##fs - 1			\
+		   && !_FP_FRAC_ZEROP_##wc (X));			\
+	      break;							\
+	    case FP_RND_ZERO:						\
+	      /* _FP_TO_INT_ROUND_rounds_away is already 0.  */		\
+	      break;							\
+	    case FP_RND_PINF:						\
+	      _FP_TO_INT_ROUND_rounds_away = !X##_s;			\
+	      break;							\
+	    case FP_RND_MINF:						\
+	      _FP_TO_INT_ROUND_rounds_away = X##_s;			\
+	      break;							\
+	    }								\
+	  if ((rsigned) = 0 && _FP_TO_INT_ROUND_rounds_away && X##_s)	\
+	    {								\
+	      /* Result of -1 for an unsigned conversion.  */		\
+	      (r) = 0;							\
+	      FP_SET_EXCEPTION (FP_EX_INVALID | FP_EX_INVALID_CVI);	\
+	    }								\
+	  else if ((rsize) = 1 && (rsigned) > 0			\
+		   && _FP_TO_INT_ROUND_rounds_away && !X##_s)		\
+	    {								\
+	      /* Converting to a 1-bit signed bit-field, which cannot	\
+		 represent +1.  */					\
+	      (r) = ((rsigned) = 2 ? -1 : 0);				\
+	      FP_SET_EXCEPTION (FP_EX_INVALID | FP_EX_INVALID_CVI);	\
+	    }								\
+	  else								\
+	    {								\
+	      (r) = (_FP_TO_INT_ROUND_rounds_away			\
+		     ? (X##_s ? -1 : 1)					\
+		     : 0);						\
+	      FP_SET_EXCEPTION (FP_EX_INEXACT);				\
+	    }								\
+	}								\
+      else if ((rsigned) = 2						\
+	       && (X##_e						\
+		   >= ((_FP_EXPMAX_##fs					\
+			< _FP_EXPBIAS_##fs + _FP_FRACBITS_##fs + (rsize) - 1) \
+		       ? _FP_EXPMAX_##fs				\
+		       : _FP_EXPBIAS_##fs + _FP_FRACBITS_##fs + (rsize) - 1))) \
+	{								\
+	  /* Overflow resulting in 0.  */				\
+	  (r) = 0;							\
+	  FP_SET_EXCEPTION (FP_EX_INVALID				\
+			    | FP_EX_INVALID_CVI				\
+			    | ((FP_EX_INVALID_SNAN			\
+				&& _FP_ISSIGNAN (fs, wc, X))		\
+			       ? FP_EX_INVALID_SNAN			\
+			       : 0));					\
+	}								\
+      else if ((rsigned) != 2						\
+	       && (X##_e >= (_FP_EXPMAX_##fs < _FP_EXPBIAS_##fs + (rsize) \
+			     ? _FP_EXPMAX_##fs				\
+			     : (_FP_EXPBIAS_##fs + (rsize)		\
+				- ((rsigned) > 0 && !X##_s)))		\
+		   || ((rsigned) = 0 && X##_s)))			\
+	{								\
+	  /* Definite overflow (does not require rounding to tell).  */	\
+	  if ((rsigned) != 0)						\
+	    {								\
+	      (r) = 1;							\
+	      (r) <<= (rsize) - 1;					\
+	      (r) -= 1 - X##_s;						\
+	    }								\
+	  else								\
+	    {								\
+	      (r) = 0;							\
+	      if (!X##_s)						\
+		(r) = ~(r);						\
+	    }								\
+									\
+	  FP_SET_EXCEPTION (FP_EX_INVALID				\
+			    | FP_EX_INVALID_CVI				\
+			    | ((FP_EX_INVALID_SNAN			\
+				&& _FP_ISSIGNAN (fs, wc, X))		\
+			       ? FP_EX_INVALID_SNAN			\
+			       : 0));					\
+	}								\
+      else								\
+	{								\
+	  /* The value is finite, with magnitude at least 1.  If	\
+	     the conversion is unsigned, the value is positive.		\
+	     If RSIGNED is not 2, the value does not definitely		\
+	     overflow by virtue of its exponent, but may still turn	\
+	     out to overflow after rounding; if RSIGNED is 2, the	\
+	     exponent may be such that the value definitely overflows,	\
+	     but at least one mantissa bit will not be shifted out.  */ \
+	  int _FP_TO_INT_ROUND_inexact = 0;				\
+	  _FP_FRAC_HIGH_RAW_##fs (X) |= _FP_IMPLBIT_##fs;		\
+	  if (X##_e >= _FP_EXPBIAS_##fs + _FP_FRACBITS_##fs - 1)	\
+	    {								\
+	      /* The value is an integer, no rounding needed.  */	\
+	      _FP_FRAC_ASSEMBLE_##wc ((r), X, (rsize));			\
+	      (r) <<= X##_e - _FP_EXPBIAS_##fs - _FP_FRACBITS_##fs + 1; \
+	    }								\
+	  else								\
+	    {								\
+	      /* May need to shift in order to round (unless there	\
+		 are exactly _FP_WORKBITS fractional bits already).  */	\
+	      int _FP_TO_INT_ROUND_rshift				\
+		= (_FP_FRACBITS_##fs + _FP_EXPBIAS_##fs			\
+		   - 1 - _FP_WORKBITS - X##_e);				\
+	      if (_FP_TO_INT_ROUND_rshift > 0)				\
+		_FP_FRAC_SRS_##wc (X, _FP_TO_INT_ROUND_rshift,		\
+				   _FP_WFRACBITS_##fs);			\
+	      else if (_FP_TO_INT_ROUND_rshift < 0)			\
+		_FP_FRAC_SLL_##wc (X, -_FP_TO_INT_ROUND_rshift);	\
+	      /* Round like _FP_ROUND, but setting			\
+		 _FP_TO_INT_ROUND_inexact instead of directly setting	\
+		 the "inexact" exception, since it may turn out we	\
+		 should set "invalid" instead.  */			\
+	      if (_FP_FRAC_LOW_##wc (X) & 7)				\
+		{							\
+		  _FP_TO_INT_ROUND_inexact = 1;				\
+		  switch (FP_ROUNDMODE)					\
+		    {							\
+		    case FP_RND_NEAREST:				\
+		      _FP_ROUND_NEAREST (wc, X);			\
+		      break;						\
+		    case FP_RND_ZERO:					\
+		      _FP_ROUND_ZERO (wc, X);				\
+		      break;						\
+		    case FP_RND_PINF:					\
+		      _FP_ROUND_PINF (wc, X);				\
+		      break;						\
+		    case FP_RND_MINF:					\
+		      _FP_ROUND_MINF (wc, X);				\
+		      break;						\
+		    }							\
+		}							\
+	      _FP_FRAC_SRL_##wc (X, _FP_WORKBITS);			\
+	      _FP_FRAC_ASSEMBLE_##wc ((r), X, (rsize));			\
+	    }								\
+	  if ((rsigned) != 0 && X##_s)					\
+	    (r) = -(r);							\
+	  /* An exponent of RSIZE - 1 always needs testing for		\
+	     overflow (either directly overflowing, or overflowing	\
+	     when rounding up results in 2^RSIZE).  An exponent of	\
+	     RSIZE - 2 can overflow for positive values when rounding	\
+	     up to 2^(RSIZE-1), but cannot overflow for negative	\
+	     values.  Smaller exponents cannot overflow.  */		\
+	  if (X##_e >= (_FP_EXPBIAS_##fs + (rsize) - 1			\
+			- ((rsigned) > 0 && !X##_s)))			\
+	    {								\
+	      if (X##_e > _FP_EXPBIAS_##fs + (rsize) - 1		\
+		  || (X##_e = _FP_EXPBIAS_##fs + (rsize) - 1		\
+		      && (X##_s						\
+			  ? (r) != (((typeof (r)) 1) << ((rsize) - 1))	\
+			  : ((rsigned) > 0 || (r) = 0)))		\
+		  || ((rsigned) > 0					\
+		      && !X##_s						\
+		      && X##_e = _FP_EXPBIAS_##fs + (rsize) - 2	\
+		      && (r) = (((typeof (r)) 1) << ((rsize) - 1))))	\
+		{							\
+		  if ((rsigned) != 2)					\
+		    {							\
+		      if ((rsigned) != 0)				\
+			{						\
+			  (r) = 1;					\
+			  (r) <<= (rsize) - 1;				\
+			  (r) -= 1 - X##_s;				\
+			}						\
+		      else						\
+			{						\
+			  (r) = 0;					\
+			  (r) = ~(r);					\
+			}						\
+		    }							\
+		  _FP_TO_INT_ROUND_inexact = 0;				\
+		  FP_SET_EXCEPTION (FP_EX_INVALID | FP_EX_INVALID_CVI);	\
+		}							\
+	    }								\
+	  if (_FP_TO_INT_ROUND_inexact)					\
+	    FP_SET_EXCEPTION (FP_EX_INEXACT);				\
+	}								\
+    _FP_TO_INT_ROUND_done: ;						\
+    }									\
+  while (0)
 
+/* Convert integer to fp.  Output is raw.  RTYPE is unsigned even if
+   input is signed.  */
 #define _FP_FROM_INT(fs, wc, X, r, rsize, rtype)			\
-  do {									\
-    if (r)								\
-      {									\
-        unsigned rtype ur_;						\
-	X##_c = FP_CLS_NORMAL;						\
-									\
-	if ((X##_s = (r < 0)))						\
-	  ur_ = (unsigned rtype) -r;					\
-	else								\
-	  ur_ = (unsigned rtype) r;					\
-	if (rsize <= _FP_W_TYPE_SIZE)					\
-	  __FP_CLZ(X##_e, ur_);						\
-	else								\
-	  __FP_CLZ_2(X##_e, (_FP_W_TYPE)(ur_ >> _FP_W_TYPE_SIZE), 	\
-		     (_FP_W_TYPE)ur_);					\
-	if (rsize < _FP_W_TYPE_SIZE)					\
-		X##_e -= (_FP_W_TYPE_SIZE - rsize);			\
-	X##_e = rsize - X##_e - 1;					\
-									\
-	if (_FP_FRACBITS_##fs < rsize && _FP_WFRACBITS_##fs <= X##_e)	\
-	  __FP_FRAC_SRS_1(ur_, (X##_e - _FP_WFRACBITS_##fs + 1), rsize);\
-	_FP_FRAC_DISASSEMBLE_##wc(X, ur_, rsize);			\
-	if ((_FP_WFRACBITS_##fs - X##_e - 1) > 0)			\
-	  _FP_FRAC_SLL_##wc(X, (_FP_WFRACBITS_##fs - X##_e - 1));	\
-      }									\
-    else								\
-      {									\
-	X##_c = FP_CLS_ZERO, X##_s = 0;					\
-      }									\
-  } while (0)
-
-
-#define FP_CONV(dfs,sfs,dwc,swc,D,S)			\
-  do {							\
-    _FP_FRAC_CONV_##dwc##_##swc(dfs, sfs, D, S);	\
-    D##_e = S##_e;					\
-    D##_c = S##_c;					\
-    D##_s = S##_s;					\
-  } while (0)
-
-/*
- * Helper primitives.
- */
+  do									\
+    {									\
+      __label__ pack_semiraw;						\
+      if (r)								\
+	{								\
+	  rtype _FP_FROM_INT_ur = (r);					\
+									\
+	  if ((X##_s = ((r) < 0)))					\
+	    _FP_FROM_INT_ur = -_FP_FROM_INT_ur;				\
+									\
+	  _FP_STATIC_ASSERT ((rsize) <= 2 * _FP_W_TYPE_SIZE,		\
+			     "rsize too large");			\
+	  (void) (((rsize) <= _FP_W_TYPE_SIZE)				\
+		  ? ({							\
+		      int _FP_FROM_INT_lz;				\
+		      __FP_CLZ (_FP_FROM_INT_lz,			\
+				(_FP_W_TYPE) _FP_FROM_INT_ur);		\
+		      X##_e = (_FP_EXPBIAS_##fs + _FP_W_TYPE_SIZE - 1	\
+			       - _FP_FROM_INT_lz);			\
+		    })							\
+		  : ({						\
+		      int _FP_FROM_INT_lz;				\
+		      __FP_CLZ_2 (_FP_FROM_INT_lz,			\
+				  (_FP_W_TYPE) (_FP_FROM_INT_ur		\
+						>> _FP_W_TYPE_SIZE),	\
+				  (_FP_W_TYPE) _FP_FROM_INT_ur);	\
+		      X##_e = (_FP_EXPBIAS_##fs + 2 * _FP_W_TYPE_SIZE - 1 \
+			       - _FP_FROM_INT_lz);			\
+		    }));						\
+									\
+	  if ((rsize) - 1 + _FP_EXPBIAS_##fs >= _FP_EXPMAX_##fs		\
+	      && X##_e >= _FP_EXPMAX_##fs)				\
+	    {								\
+	      /* Exponent too big; overflow to infinity.  (May also	\
+		 happen after rounding below.)  */			\
+	      _FP_OVERFLOW_SEMIRAW (fs, wc, X);				\
+	      goto pack_semiraw;					\
+	    }								\
+									\
+	  if ((rsize) <= _FP_FRACBITS_##fs				\
+	      || X##_e < _FP_EXPBIAS_##fs + _FP_FRACBITS_##fs)		\
+	    {								\
+	      /* Exactly representable; shift left.  */			\
+	      _FP_FRAC_DISASSEMBLE_##wc (X, _FP_FROM_INT_ur, (rsize));	\
+	      if (_FP_EXPBIAS_##fs + _FP_FRACBITS_##fs - 1 - X##_e > 0)	\
+		_FP_FRAC_SLL_##wc (X, (_FP_EXPBIAS_##fs			\
+				       + _FP_FRACBITS_##fs - 1 - X##_e)); \
+	    }								\
+	  else								\
+	    {								\
+	      /* More bits in integer than in floating type; need to	\
+		 round.  */						\
+	      if (_FP_EXPBIAS_##fs + _FP_WFRACBITS_##fs - 1 < X##_e)	\
+		_FP_FROM_INT_ur						\
+		  = ((_FP_FROM_INT_ur >> (X##_e - _FP_EXPBIAS_##fs	\
+					  - _FP_WFRACBITS_##fs + 1))	\
+		     | ((_FP_FROM_INT_ur				\
+			 << ((rsize) - (X##_e - _FP_EXPBIAS_##fs	\
+					- _FP_WFRACBITS_##fs + 1)))	\
+			!= 0));						\
+	      _FP_FRAC_DISASSEMBLE_##wc (X, _FP_FROM_INT_ur, (rsize));	\
+	      if ((_FP_EXPBIAS_##fs + _FP_WFRACBITS_##fs - 1 - X##_e) > 0) \
+		_FP_FRAC_SLL_##wc (X, (_FP_EXPBIAS_##fs			\
+				       + _FP_WFRACBITS_##fs - 1 - X##_e)); \
+	      _FP_FRAC_HIGH_##fs (X) &= ~(_FP_W_TYPE) _FP_IMPLBIT_SH_##fs; \
+	    pack_semiraw:						\
+	      _FP_PACK_SEMIRAW (fs, wc, X);				\
+	    }								\
+	}								\
+      else								\
+	{								\
+	  X##_s = 0;							\
+	  X##_e = 0;							\
+	  _FP_FRAC_SET_##wc (X, _FP_ZEROFRAC_##wc);			\
+	}								\
+    }									\
+  while (0)
+
+
+/* Extend from a narrower floating-point format to a wider one.  Input
+   and output are raw.  If CHECK_NAN, then signaling NaNs are
+   converted to quiet with the "invalid" exception raised; otherwise
+   signaling NaNs remain signaling with no exception.  */
+#define _FP_EXTEND_CNAN(dfs, sfs, dwc, swc, D, S, check_nan)		\
+  do									\
+    {									\
+      _FP_STATIC_ASSERT (_FP_FRACBITS_##dfs >= _FP_FRACBITS_##sfs,	\
+			 "destination mantissa narrower than source");	\
+      _FP_STATIC_ASSERT ((_FP_EXPMAX_##dfs - _FP_EXPBIAS_##dfs		\
+			  >= _FP_EXPMAX_##sfs - _FP_EXPBIAS_##sfs),	\
+			 "destination max exponent smaller"		\
+			 " than source");				\
+      _FP_STATIC_ASSERT (((_FP_EXPBIAS_##dfs				\
+			   >= (_FP_EXPBIAS_##sfs			\
+			       + _FP_FRACBITS_##sfs - 1))		\
+			  || (_FP_EXPBIAS_##dfs = _FP_EXPBIAS_##sfs)), \
+			 "source subnormals do not all become normal,"	\
+			 " but bias not the same");			\
+      D##_s = S##_s;							\
+      _FP_FRAC_COPY_##dwc##_##swc (D, S);				\
+      if (_FP_EXP_NORMAL (sfs, swc, S))					\
+	{								\
+	  D##_e = S##_e + _FP_EXPBIAS_##dfs - _FP_EXPBIAS_##sfs;	\
+	  _FP_FRAC_SLL_##dwc (D, (_FP_FRACBITS_##dfs - _FP_FRACBITS_##sfs)); \
+	}								\
+      else								\
+	{								\
+	  if (S##_e = 0)						\
+	    {								\
+	      _FP_CHECK_FLUSH_ZERO (sfs, swc, S);			\
+	      if (_FP_FRAC_ZEROP_##swc (S))				\
+		D##_e = 0;						\
+	      else if (_FP_EXPBIAS_##dfs				\
+		       < _FP_EXPBIAS_##sfs + _FP_FRACBITS_##sfs - 1)	\
+		{							\
+		  FP_SET_EXCEPTION (FP_EX_DENORM);			\
+		  _FP_FRAC_SLL_##dwc (D, (_FP_FRACBITS_##dfs		\
+					  - _FP_FRACBITS_##sfs));	\
+		  D##_e = 0;						\
+		  if (FP_TRAPPING_EXCEPTIONS & FP_EX_UNDERFLOW)		\
+		    FP_SET_EXCEPTION (FP_EX_UNDERFLOW);			\
+		}							\
+	      else							\
+		{							\
+		  int FP_EXTEND_lz;					\
+		  FP_SET_EXCEPTION (FP_EX_DENORM);			\
+		  _FP_FRAC_CLZ_##swc (FP_EXTEND_lz, S);			\
+		  _FP_FRAC_SLL_##dwc (D,				\
+				      FP_EXTEND_lz + _FP_FRACBITS_##dfs	\
+				      - _FP_FRACTBITS_##sfs);		\
+		  D##_e = (_FP_EXPBIAS_##dfs - _FP_EXPBIAS_##sfs + 1	\
+			   + _FP_FRACXBITS_##sfs - FP_EXTEND_lz);	\
+		}							\
+	    }								\
+	  else								\
+	    {								\
+	      D##_e = _FP_EXPMAX_##dfs;					\
+	      if (!_FP_FRAC_ZEROP_##swc (S))				\
+		{							\
+		  if (check_nan && _FP_FRAC_SNANP (sfs, S))		\
+		    FP_SET_EXCEPTION (FP_EX_INVALID			\
+				      | FP_EX_INVALID_SNAN);		\
+		  _FP_FRAC_SLL_##dwc (D, (_FP_FRACBITS_##dfs		\
+					  - _FP_FRACBITS_##sfs));	\
+		  if (check_nan)					\
+		    _FP_SETQNAN (dfs, dwc, D);				\
+		}							\
+	    }								\
+	}								\
+    }									\
+  while (0)
+
+#define FP_EXTEND(dfs, sfs, dwc, swc, D, S)		\
+    _FP_EXTEND_CNAN (dfs, sfs, dwc, swc, D, S, 1)
+
+/* Truncate from a wider floating-point format to a narrower one.
+   Input and output are semi-raw.  */
+#define FP_TRUNC(dfs, sfs, dwc, swc, D, S)				\
+  do									\
+    {									\
+      _FP_STATIC_ASSERT (_FP_FRACBITS_##sfs >= _FP_FRACBITS_##dfs,	\
+			 "destination mantissa wider than source");	\
+      _FP_STATIC_ASSERT (((_FP_EXPBIAS_##sfs				\
+			   >= (_FP_EXPBIAS_##dfs			\
+			       + _FP_FRACBITS_##dfs - 1))		\
+			  || _FP_EXPBIAS_##sfs = _FP_EXPBIAS_##dfs),	\
+			 "source subnormals do not all become same,"	\
+			 " but bias not the same");			\
+      D##_s = S##_s;							\
+      if (_FP_EXP_NORMAL (sfs, swc, S))					\
+	{								\
+	  D##_e = S##_e + _FP_EXPBIAS_##dfs - _FP_EXPBIAS_##sfs;	\
+	  if (D##_e >= _FP_EXPMAX_##dfs)				\
+	    _FP_OVERFLOW_SEMIRAW (dfs, dwc, D);				\
+	  else								\
+	    {								\
+	      if (D##_e <= 0)						\
+		{							\
+		  if (D##_e < 1 - _FP_FRACBITS_##dfs)			\
+		    {							\
+		      _FP_FRAC_SET_##swc (S, _FP_ZEROFRAC_##swc);	\
+		      _FP_FRAC_LOW_##swc (S) |= 1;			\
+		    }							\
+		  else							\
+		    {							\
+		      _FP_FRAC_HIGH_##sfs (S) |= _FP_IMPLBIT_SH_##sfs;	\
+		      _FP_FRAC_SRS_##swc (S, (_FP_WFRACBITS_##sfs	\
+					      - _FP_WFRACBITS_##dfs	\
+					      + 1 - D##_e),		\
+					  _FP_WFRACBITS_##sfs);		\
+		    }							\
+		  D##_e = 0;						\
+		}							\
+	      else							\
+		_FP_FRAC_SRS_##swc (S, (_FP_WFRACBITS_##sfs		\
+					- _FP_WFRACBITS_##dfs),		\
+				    _FP_WFRACBITS_##sfs);		\
+	      _FP_FRAC_COPY_##dwc##_##swc (D, S);			\
+	    }								\
+	}								\
+      else								\
+	{								\
+	  if (S##_e = 0)						\
+	    {								\
+	      _FP_CHECK_FLUSH_ZERO (sfs, swc, S);			\
+	      D##_e = 0;						\
+	      if (_FP_FRAC_ZEROP_##swc (S))				\
+		_FP_FRAC_SET_##dwc (D, _FP_ZEROFRAC_##dwc);		\
+	      else							\
+		{							\
+		  FP_SET_EXCEPTION (FP_EX_DENORM);			\
+		  if (_FP_EXPBIAS_##sfs					\
+		      < _FP_EXPBIAS_##dfs + _FP_FRACBITS_##dfs - 1)	\
+		    {							\
+		      _FP_FRAC_SRS_##swc (S, (_FP_WFRACBITS_##sfs	\
+					      - _FP_WFRACBITS_##dfs),	\
+					  _FP_WFRACBITS_##sfs);		\
+		      _FP_FRAC_COPY_##dwc##_##swc (D, S);		\
+		    }							\
+		  else							\
+		    {							\
+		      _FP_FRAC_SET_##dwc (D, _FP_ZEROFRAC_##dwc);	\
+		      _FP_FRAC_LOW_##dwc (D) |= 1;			\
+		    }							\
+		}							\
+	    }								\
+	  else								\
+	    {								\
+	      D##_e = _FP_EXPMAX_##dfs;					\
+	      if (_FP_FRAC_ZEROP_##swc (S))				\
+		_FP_FRAC_SET_##dwc (D, _FP_ZEROFRAC_##dwc);		\
+	      else							\
+		{							\
+		  _FP_CHECK_SIGNAN_SEMIRAW (sfs, swc, S);		\
+		  _FP_FRAC_SRL_##swc (S, (_FP_WFRACBITS_##sfs		\
+					  - _FP_WFRACBITS_##dfs));	\
+		  _FP_FRAC_COPY_##dwc##_##swc (D, S);			\
+		  /* Semi-raw NaN must have all workbits cleared.  */	\
+		  _FP_FRAC_LOW_##dwc (D)				\
+		    &= ~(_FP_W_TYPE) ((1 << _FP_WORKBITS) - 1);		\
+		  _FP_SETQNAN_SEMIRAW (dfs, dwc, D);			\
+		}							\
+	    }								\
+	}								\
+    }									\
+  while (0)
+
+/* Helper primitives.  */
 
 /* Count leading zeros in a word.  */
 
 #ifndef __FP_CLZ
-#if _FP_W_TYPE_SIZE < 64
-/* this is just to shut the compiler up about shifts > word length -- PMM 02/1998 */
-#define __FP_CLZ(r, x)				\
-  do {						\
-    _FP_W_TYPE _t = (x);			\
-    r = _FP_W_TYPE_SIZE - 1;			\
-    if (_t > 0xffff) r -= 16;			\
-    if (_t > 0xffff) _t >>= 16;			\
-    if (_t > 0xff) r -= 8;			\
-    if (_t > 0xff) _t >>= 8;			\
-    if (_t & 0xf0) r -= 4;			\
-    if (_t & 0xf0) _t >>= 4;			\
-    if (_t & 0xc) r -= 2;			\
-    if (_t & 0xc) _t >>= 2;			\
-    if (_t & 0x2) r -= 1;			\
-  } while (0)
-#else /* not _FP_W_TYPE_SIZE < 64 */
-#define __FP_CLZ(r, x)				\
-  do {						\
-    _FP_W_TYPE _t = (x);			\
-    r = _FP_W_TYPE_SIZE - 1;			\
-    if (_t > 0xffffffff) r -= 32;		\
-    if (_t > 0xffffffff) _t >>= 32;		\
-    if (_t > 0xffff) r -= 16;			\
-    if (_t > 0xffff) _t >>= 16;			\
-    if (_t > 0xff) r -= 8;			\
-    if (_t > 0xff) _t >>= 8;			\
-    if (_t & 0xf0) r -= 4;			\
-    if (_t & 0xf0) _t >>= 4;			\
-    if (_t & 0xc) r -= 2;			\
-    if (_t & 0xc) _t >>= 2;			\
-    if (_t & 0x2) r -= 1;			\
-  } while (0)
-#endif /* not _FP_W_TYPE_SIZE < 64 */
+/* GCC 3.4 and later provide the builtins for us.  */
+# define __FP_CLZ(r, x)							\
+  do									\
+    {									\
+      _FP_STATIC_ASSERT ((sizeof (_FP_W_TYPE) = sizeof (unsigned int)	\
+			  || (sizeof (_FP_W_TYPE)			\
+			      = sizeof (unsigned long))		\
+			  || (sizeof (_FP_W_TYPE)			\
+			      = sizeof (unsigned long long))),		\
+			 "_FP_W_TYPE size unsupported for clz");	\
+      if (sizeof (_FP_W_TYPE) = sizeof (unsigned int))			\
+	(r) = __builtin_clz (x);					\
+      else if (sizeof (_FP_W_TYPE) = sizeof (unsigned long))		\
+	(r) = __builtin_clzl (x);					\
+      else /* sizeof (_FP_W_TYPE) = sizeof (unsigned long long).  */	\
+	(r) = __builtin_clzll (x);					\
+    }									\
+  while (0)
 #endif /* ndef __FP_CLZ */
 
 #define _FP_DIV_HELP_imm(q, r, n, d)		\
-  do {						\
-    q = n / d, r = n % d;			\
-  } while (0)
+  do						\
+    {						\
+      (q) = (n) / (d), (r) = (n) % (d);		\
+    }						\
+  while (0)
+
+
+/* A restoring bit-by-bit division primitive.  */
+
+#define _FP_DIV_MEAT_N_loop(fs, wc, R, X, Y)				\
+  do									\
+    {									\
+      int _FP_DIV_MEAT_N_loop_count = _FP_WFRACBITS_##fs;		\
+      _FP_FRAC_DECL_##wc (_FP_DIV_MEAT_N_loop_u);			\
+      _FP_FRAC_DECL_##wc (_FP_DIV_MEAT_N_loop_v);			\
+      _FP_FRAC_COPY_##wc (_FP_DIV_MEAT_N_loop_u, X);			\
+      _FP_FRAC_COPY_##wc (_FP_DIV_MEAT_N_loop_v, Y);			\
+      _FP_FRAC_SET_##wc (R, _FP_ZEROFRAC_##wc);				\
+      /* Normalize _FP_DIV_MEAT_N_LOOP_U and _FP_DIV_MEAT_N_LOOP_V.  */	\
+      _FP_FRAC_SLL_##wc (_FP_DIV_MEAT_N_loop_u, _FP_WFRACXBITS_##fs);	\
+      _FP_FRAC_SLL_##wc (_FP_DIV_MEAT_N_loop_v, _FP_WFRACXBITS_##fs);	\
+      /* First round.  Since the operands are normalized, either the	\
+	 first or second bit will be set in the fraction.  Produce a	\
+	 normalized result by checking which and adjusting the loop	\
+	 count and exponent accordingly.  */				\
+      if (_FP_FRAC_GE_1 (_FP_DIV_MEAT_N_loop_u, _FP_DIV_MEAT_N_loop_v))	\
+	{								\
+	  _FP_FRAC_SUB_##wc (_FP_DIV_MEAT_N_loop_u,			\
+			     _FP_DIV_MEAT_N_loop_u,			\
+			     _FP_DIV_MEAT_N_loop_v);			\
+	  _FP_FRAC_LOW_##wc (R) |= 1;					\
+	  _FP_DIV_MEAT_N_loop_count--;					\
+	}								\
+      else								\
+	R##_e--;							\
+      /* Subsequent rounds.  */						\
+      do								\
+	{								\
+	  int _FP_DIV_MEAT_N_loop_msb					\
+	    = (_FP_WS_TYPE) _FP_FRAC_HIGH_##wc (_FP_DIV_MEAT_N_loop_u) < 0; \
+	  _FP_FRAC_SLL_##wc (_FP_DIV_MEAT_N_loop_u, 1);			\
+	  _FP_FRAC_SLL_##wc (R, 1);					\
+	  if (_FP_DIV_MEAT_N_loop_msb					\
+	      || _FP_FRAC_GE_1 (_FP_DIV_MEAT_N_loop_u,			\
+				_FP_DIV_MEAT_N_loop_v))			\
+	    {								\
+	      _FP_FRAC_SUB_##wc (_FP_DIV_MEAT_N_loop_u,			\
+				 _FP_DIV_MEAT_N_loop_u,			\
+				 _FP_DIV_MEAT_N_loop_v);		\
+	      _FP_FRAC_LOW_##wc (R) |= 1;				\
+	    }								\
+	}								\
+      while (--_FP_DIV_MEAT_N_loop_count > 0);				\
+      /* If there's anything left in _FP_DIV_MEAT_N_LOOP_U, the result	\
+	 is inexact.  */						\
+      _FP_FRAC_LOW_##wc (R)						\
+	|= !_FP_FRAC_ZEROP_##wc (_FP_DIV_MEAT_N_loop_u);		\
+    }									\
+  while (0)
+
+#define _FP_DIV_MEAT_1_loop(fs, R, X, Y)  _FP_DIV_MEAT_N_loop (fs, 1, R, X, Y)
+#define _FP_DIV_MEAT_2_loop(fs, R, X, Y)  _FP_DIV_MEAT_N_loop (fs, 2, R, X, Y)
+#define _FP_DIV_MEAT_4_loop(fs, R, X, Y)  _FP_DIV_MEAT_N_loop (fs, 4, R, X, Y)
 
-#endif /* __MATH_EMU_OP_COMMON_H__ */
+#endif /* !SOFT_FP_OP_COMMON_H */
diff --git a/include/math-emu/quad.h b/include/math-emu/quad.h
index 6161136..9b5191c 100644
--- a/include/math-emu/quad.h
+++ b/include/math-emu/quad.h
@@ -1,6 +1,6 @@
 /* Software floating-point emulation.
    Definitions for IEEE Quad Precision.
-   Copyright (C) 1997,1998,1999 Free Software Foundation, Inc.
+   Copyright (C) 1997-2015 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
    Contributed by Richard Henderson (rth@cygnus.com),
 		  Jakub Jelinek (jj@ultra.linux.cz),
@@ -8,31 +8,41 @@
 		  Peter Maydell (pmaydell@chiark.greenend.org.uk).
 
    The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Library General Public License as
-   published by the Free Software Foundation; either version 2 of the
-   License, or (at your option) any later version.
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   In addition to the permissions in the GNU Lesser General Public
+   License, the Free Software Foundation gives you unlimited
+   permission to link the compiled version of this file into
+   combinations with other programs, and to distribute those
+   combinations without any restriction coming from the use of this
+   file.  (The Lesser General Public License restrictions do apply in
+   other respects; for example, they cover modification of the file,
+   and distribution when not linked into a combine executable.)
 
    The GNU C Library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Library General Public License for more details.
+   Lesser General Public License for more details.
 
-   You should have received a copy of the GNU Library General Public
-   License along with the GNU C Library; see the file COPYING.LIB.  If
-   not, write to the Free Software Foundation, Inc.,
-   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
 
-#ifndef  __MATH_EMU_QUAD_H__
-#define  __MATH_EMU_QUAD_H__
+#ifndef SOFT_FP_QUAD_H
+#define SOFT_FP_QUAD_H	1
 
 #if _FP_W_TYPE_SIZE < 32
-#error "Here's a nickel, kid. Go buy yourself a real computer."
+# error "Here's a nickel, kid. Go buy yourself a real computer."
 #endif
 
 #if _FP_W_TYPE_SIZE < 64
-#define _FP_FRACTBITS_Q         (4*_FP_W_TYPE_SIZE)
+# define _FP_FRACTBITS_Q	(4*_FP_W_TYPE_SIZE)
+# define _FP_FRACTBITS_DW_Q	(8*_FP_W_TYPE_SIZE)
 #else
-#define _FP_FRACTBITS_Q		(2*_FP_W_TYPE_SIZE)
+# define _FP_FRACTBITS_Q		(2*_FP_W_TYPE_SIZE)
+# define _FP_FRACTBITS_DW_Q	(4*_FP_W_TYPE_SIZE)
 #endif
 
 #define _FP_FRACBITS_Q		113
@@ -44,165 +54,277 @@
 #define _FP_EXPMAX_Q		32767
 
 #define _FP_QNANBIT_Q		\
-	((_FP_W_TYPE)1 << (_FP_FRACBITS_Q-2) % _FP_W_TYPE_SIZE)
+	((_FP_W_TYPE) 1 << (_FP_FRACBITS_Q-2) % _FP_W_TYPE_SIZE)
+#define _FP_QNANBIT_SH_Q		\
+	((_FP_W_TYPE) 1 << (_FP_FRACBITS_Q-2+_FP_WORKBITS) % _FP_W_TYPE_SIZE)
 #define _FP_IMPLBIT_Q		\
-	((_FP_W_TYPE)1 << (_FP_FRACBITS_Q-1) % _FP_W_TYPE_SIZE)
+	((_FP_W_TYPE) 1 << (_FP_FRACBITS_Q-1) % _FP_W_TYPE_SIZE)
+#define _FP_IMPLBIT_SH_Q		\
+	((_FP_W_TYPE) 1 << (_FP_FRACBITS_Q-1+_FP_WORKBITS) % _FP_W_TYPE_SIZE)
 #define _FP_OVERFLOW_Q		\
-	((_FP_W_TYPE)1 << (_FP_WFRACBITS_Q % _FP_W_TYPE_SIZE))
+	((_FP_W_TYPE) 1 << (_FP_WFRACBITS_Q % _FP_W_TYPE_SIZE))
+
+#define _FP_WFRACBITS_DW_Q	(2 * _FP_WFRACBITS_Q)
+#define _FP_WFRACXBITS_DW_Q	(_FP_FRACTBITS_DW_Q - _FP_WFRACBITS_DW_Q)
+#define _FP_HIGHBIT_DW_Q	\
+  ((_FP_W_TYPE) 1 << (_FP_WFRACBITS_DW_Q - 1) % _FP_W_TYPE_SIZE)
+
+typedef float TFtype __attribute__ ((mode (TF)));
 
 #if _FP_W_TYPE_SIZE < 64
 
 union _FP_UNION_Q
 {
-   long double flt;
-   struct 
-   {
-#if __BYTE_ORDER = __BIG_ENDIAN
-      unsigned sign : 1;
-      unsigned exp : _FP_EXPBITS_Q;
-      unsigned long frac3 : _FP_FRACBITS_Q - (_FP_IMPLBIT_Q != 0)-(_FP_W_TYPE_SIZE * 3);
-      unsigned long frac2 : _FP_W_TYPE_SIZE;
-      unsigned long frac1 : _FP_W_TYPE_SIZE;
-      unsigned long frac0 : _FP_W_TYPE_SIZE;
-#else
-      unsigned long frac0 : _FP_W_TYPE_SIZE;
-      unsigned long frac1 : _FP_W_TYPE_SIZE;
-      unsigned long frac2 : _FP_W_TYPE_SIZE;
-      unsigned long frac3 : _FP_FRACBITS_Q - (_FP_IMPLBIT_Q != 0)-(_FP_W_TYPE_SIZE * 3);
-      unsigned exp : _FP_EXPBITS_Q;
-      unsigned sign : 1;
-#endif /* not bigendian */
-   } bits __attribute__((packed));
+  TFtype flt;
+  struct _FP_STRUCT_LAYOUT
+  {
+# if __BYTE_ORDER = __BIG_ENDIAN
+    unsigned sign : 1;
+    unsigned exp : _FP_EXPBITS_Q;
+    unsigned long frac3 : _FP_FRACBITS_Q - (_FP_IMPLBIT_Q != 0)-(_FP_W_TYPE_SIZE * 3);
+    unsigned long frac2 : _FP_W_TYPE_SIZE;
+    unsigned long frac1 : _FP_W_TYPE_SIZE;
+    unsigned long frac0 : _FP_W_TYPE_SIZE;
+# else
+    unsigned long frac0 : _FP_W_TYPE_SIZE;
+    unsigned long frac1 : _FP_W_TYPE_SIZE;
+    unsigned long frac2 : _FP_W_TYPE_SIZE;
+    unsigned long frac3 : _FP_FRACBITS_Q - (_FP_IMPLBIT_Q != 0)-(_FP_W_TYPE_SIZE * 3);
+    unsigned exp : _FP_EXPBITS_Q;
+    unsigned sign : 1;
+# endif /* not bigendian */
+  } bits __attribute__ ((packed));
 };
 
 
-#define FP_DECL_Q(X)		_FP_DECL(4,X)
-#define FP_UNPACK_RAW_Q(X,val)	_FP_UNPACK_RAW_4(Q,X,val)
-#define FP_UNPACK_RAW_QP(X,val)	_FP_UNPACK_RAW_4_P(Q,X,val)
-#define FP_PACK_RAW_Q(val,X)	_FP_PACK_RAW_4(Q,val,X)
-#define FP_PACK_RAW_QP(val,X)		\
-  do {					\
-    if (!FP_INHIBIT_RESULTS)		\
-      _FP_PACK_RAW_4_P(Q,val,X);	\
-  } while (0)
-
-#define FP_UNPACK_Q(X,val)		\
-  do {					\
-    _FP_UNPACK_RAW_4(Q,X,val);		\
-    _FP_UNPACK_CANONICAL(Q,4,X);	\
-  } while (0)
-
-#define FP_UNPACK_QP(X,val)		\
-  do {					\
-    _FP_UNPACK_RAW_4_P(Q,X,val);	\
-    _FP_UNPACK_CANONICAL(Q,4,X);	\
-  } while (0)
-
-#define FP_PACK_Q(val,X)		\
-  do {					\
-    _FP_PACK_CANONICAL(Q,4,X);		\
-    _FP_PACK_RAW_4(Q,val,X);		\
-  } while (0)
-
-#define FP_PACK_QP(val,X)		\
-  do {					\
-    _FP_PACK_CANONICAL(Q,4,X);		\
-    if (!FP_INHIBIT_RESULTS)		\
-      _FP_PACK_RAW_4_P(Q,val,X);	\
-  } while (0)
-
-#define FP_ISSIGNAN_Q(X)		_FP_ISSIGNAN(Q,4,X)
-#define FP_NEG_Q(R,X)			_FP_NEG(Q,4,R,X)
-#define FP_ADD_Q(R,X,Y)			_FP_ADD(Q,4,R,X,Y)
-#define FP_SUB_Q(R,X,Y)			_FP_SUB(Q,4,R,X,Y)
-#define FP_MUL_Q(R,X,Y)			_FP_MUL(Q,4,R,X,Y)
-#define FP_DIV_Q(R,X,Y)			_FP_DIV(Q,4,R,X,Y)
-#define FP_SQRT_Q(R,X)			_FP_SQRT(Q,4,R,X)
-#define _FP_SQRT_MEAT_Q(R,S,T,X,Q)	_FP_SQRT_MEAT_4(R,S,T,X,Q)
-
-#define FP_CMP_Q(r,X,Y,un)	_FP_CMP(Q,4,r,X,Y,un)
-#define FP_CMP_EQ_Q(r,X,Y)	_FP_CMP_EQ(Q,4,r,X,Y)
-
-#define FP_TO_INT_Q(r,X,rsz,rsg)	_FP_TO_INT(Q,4,r,X,rsz,rsg)
-#define FP_TO_INT_ROUND_Q(r,X,rsz,rsg)	_FP_TO_INT_ROUND(Q,4,r,X,rsz,rsg)
-#define FP_FROM_INT_Q(X,r,rs,rt)	_FP_FROM_INT(Q,4,X,r,rs,rt)
-
-#define _FP_FRAC_HIGH_Q(X)	_FP_FRAC_HIGH_4(X)
-#define _FP_FRAC_HIGH_RAW_Q(X)	_FP_FRAC_HIGH_4(X)
+# define FP_DECL_Q(X)		_FP_DECL (4, X)
+# define FP_UNPACK_RAW_Q(X, val)	_FP_UNPACK_RAW_4 (Q, X, (val))
+# define FP_UNPACK_RAW_QP(X, val)	_FP_UNPACK_RAW_4_P (Q, X, (val))
+# define FP_PACK_RAW_Q(val, X)	_FP_PACK_RAW_4 (Q, (val), X)
+# define FP_PACK_RAW_QP(val, X)			\
+  do						\
+    {						\
+      if (!FP_INHIBIT_RESULTS)			\
+	_FP_PACK_RAW_4_P (Q, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_UNPACK_Q(X, val)			\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_4 (Q, X, (val));		\
+      _FP_UNPACK_CANONICAL (Q, 4, X);		\
+    }						\
+  while (0)
+
+# define FP_UNPACK_QP(X, val)			\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_4_P (Q, X, (val));		\
+      _FP_UNPACK_CANONICAL (Q, 4, X);		\
+    }						\
+  while (0)
+
+# define FP_UNPACK_SEMIRAW_Q(X, val)		\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_4 (Q, X, (val));		\
+      _FP_UNPACK_SEMIRAW (Q, 4, X);		\
+    }						\
+  while (0)
+
+# define FP_UNPACK_SEMIRAW_QP(X, val)		\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_4_P (Q, X, (val));		\
+      _FP_UNPACK_SEMIRAW (Q, 4, X);		\
+    }						\
+  while (0)
+
+# define FP_PACK_Q(val, X)			\
+  do						\
+    {						\
+      _FP_PACK_CANONICAL (Q, 4, X);		\
+      _FP_PACK_RAW_4 (Q, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_PACK_QP(val, X)			\
+  do						\
+    {						\
+      _FP_PACK_CANONICAL (Q, 4, X);		\
+      if (!FP_INHIBIT_RESULTS)			\
+	_FP_PACK_RAW_4_P (Q, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_PACK_SEMIRAW_Q(val, X)		\
+  do						\
+    {						\
+      _FP_PACK_SEMIRAW (Q, 4, X);		\
+      _FP_PACK_RAW_4 (Q, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_PACK_SEMIRAW_QP(val, X)		\
+  do						\
+    {						\
+      _FP_PACK_SEMIRAW (Q, 4, X);		\
+      if (!FP_INHIBIT_RESULTS)			\
+	_FP_PACK_RAW_4_P (Q, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_ISSIGNAN_Q(X)		_FP_ISSIGNAN (Q, 4, X)
+# define FP_NEG_Q(R, X)			_FP_NEG (Q, 4, R, X)
+# define FP_ADD_Q(R, X, Y)		_FP_ADD (Q, 4, R, X, Y)
+# define FP_SUB_Q(R, X, Y)		_FP_SUB (Q, 4, R, X, Y)
+# define FP_MUL_Q(R, X, Y)		_FP_MUL (Q, 4, R, X, Y)
+# define FP_DIV_Q(R, X, Y)		_FP_DIV (Q, 4, R, X, Y)
+# define FP_SQRT_Q(R, X)		_FP_SQRT (Q, 4, R, X)
+# define _FP_SQRT_MEAT_Q(R, S, T, X, Q)	_FP_SQRT_MEAT_4 (R, S, T, X, (Q))
+# define FP_FMA_Q(R, X, Y, Z)		_FP_FMA (Q, 4, 8, R, X, Y, Z)
+
+# define FP_CMP_Q(r, X, Y, un, ex)	_FP_CMP (Q, 4, (r), X, Y, (un), (ex))
+# define FP_CMP_EQ_Q(r, X, Y, ex)	_FP_CMP_EQ (Q, 4, (r), X, Y, (ex))
+# define FP_CMP_UNORD_Q(r, X, Y, ex)	_FP_CMP_UNORD (Q, 4, (r), X, Y, (ex))
+
+# define FP_TO_INT_Q(r, X, rsz, rsg)	_FP_TO_INT (Q, 4, (r), X, (rsz), (rsg))
+# define FP_TO_INT_ROUND_Q(r, X, rsz, rsg)	\
+  _FP_TO_INT_ROUND (Q, 4, (r), X, (rsz), (rsg))
+# define FP_FROM_INT_Q(X, r, rs, rt)	_FP_FROM_INT (Q, 4, X, (r), (rs), rt)
+
+# define _FP_FRAC_HIGH_Q(X)	_FP_FRAC_HIGH_4 (X)
+# define _FP_FRAC_HIGH_RAW_Q(X)	_FP_FRAC_HIGH_4 (X)
+
+# define _FP_FRAC_HIGH_DW_Q(X)	_FP_FRAC_HIGH_8 (X)
 
 #else   /* not _FP_W_TYPE_SIZE < 64 */
 union _FP_UNION_Q
 {
-  long double flt /* __attribute__((mode(TF))) */ ;
-  struct {
-#if __BYTE_ORDER = __BIG_ENDIAN
-    unsigned sign  : 1;
-    unsigned exp   : _FP_EXPBITS_Q;
-    unsigned long frac1 : _FP_FRACBITS_Q-(_FP_IMPLBIT_Q != 0)-_FP_W_TYPE_SIZE;
-    unsigned long frac0 : _FP_W_TYPE_SIZE;
-#else
-    unsigned long frac0 : _FP_W_TYPE_SIZE;
-    unsigned long frac1 : _FP_FRACBITS_Q-(_FP_IMPLBIT_Q != 0)-_FP_W_TYPE_SIZE;
-    unsigned exp   : _FP_EXPBITS_Q;
-    unsigned sign  : 1;
-#endif
+  TFtype flt /* __attribute__ ((mode (TF))) */ ;
+  struct _FP_STRUCT_LAYOUT
+  {
+    _FP_W_TYPE a, b;
+  } longs;
+  struct _FP_STRUCT_LAYOUT
+  {
+# if __BYTE_ORDER = __BIG_ENDIAN
+    unsigned sign    : 1;
+    unsigned exp     : _FP_EXPBITS_Q;
+    _FP_W_TYPE frac1 : _FP_FRACBITS_Q - (_FP_IMPLBIT_Q != 0) - _FP_W_TYPE_SIZE;
+    _FP_W_TYPE frac0 : _FP_W_TYPE_SIZE;
+# else
+    _FP_W_TYPE frac0 : _FP_W_TYPE_SIZE;
+    _FP_W_TYPE frac1 : _FP_FRACBITS_Q - (_FP_IMPLBIT_Q != 0) - _FP_W_TYPE_SIZE;
+    unsigned exp     : _FP_EXPBITS_Q;
+    unsigned sign    : 1;
+# endif
   } bits;
 };
 
-#define FP_DECL_Q(X)		_FP_DECL(2,X)
-#define FP_UNPACK_RAW_Q(X,val)	_FP_UNPACK_RAW_2(Q,X,val)
-#define FP_UNPACK_RAW_QP(X,val)	_FP_UNPACK_RAW_2_P(Q,X,val)
-#define FP_PACK_RAW_Q(val,X)	_FP_PACK_RAW_2(Q,val,X)
-#define FP_PACK_RAW_QP(val,X)		\
-  do {					\
-    if (!FP_INHIBIT_RESULTS)		\
-      _FP_PACK_RAW_2_P(Q,val,X);	\
-  } while (0)
-
-#define FP_UNPACK_Q(X,val)		\
-  do {					\
-    _FP_UNPACK_RAW_2(Q,X,val);		\
-    _FP_UNPACK_CANONICAL(Q,2,X);	\
-  } while (0)
-
-#define FP_UNPACK_QP(X,val)		\
-  do {					\
-    _FP_UNPACK_RAW_2_P(Q,X,val);	\
-    _FP_UNPACK_CANONICAL(Q,2,X);	\
-  } while (0)
-
-#define FP_PACK_Q(val,X)		\
-  do {					\
-    _FP_PACK_CANONICAL(Q,2,X);		\
-    _FP_PACK_RAW_2(Q,val,X);		\
-  } while (0)
-
-#define FP_PACK_QP(val,X)		\
-  do {					\
-    _FP_PACK_CANONICAL(Q,2,X);		\
-    if (!FP_INHIBIT_RESULTS)		\
-      _FP_PACK_RAW_2_P(Q,val,X);	\
-  } while (0)
-
-#define FP_ISSIGNAN_Q(X)		_FP_ISSIGNAN(Q,2,X)
-#define FP_NEG_Q(R,X)			_FP_NEG(Q,2,R,X)
-#define FP_ADD_Q(R,X,Y)			_FP_ADD(Q,2,R,X,Y)
-#define FP_SUB_Q(R,X,Y)			_FP_SUB(Q,2,R,X,Y)
-#define FP_MUL_Q(R,X,Y)			_FP_MUL(Q,2,R,X,Y)
-#define FP_DIV_Q(R,X,Y)			_FP_DIV(Q,2,R,X,Y)
-#define FP_SQRT_Q(R,X)			_FP_SQRT(Q,2,R,X)
-#define _FP_SQRT_MEAT_Q(R,S,T,X,Q)	_FP_SQRT_MEAT_2(R,S,T,X,Q)
-
-#define FP_CMP_Q(r,X,Y,un)	_FP_CMP(Q,2,r,X,Y,un)
-#define FP_CMP_EQ_Q(r,X,Y)	_FP_CMP_EQ(Q,2,r,X,Y)
-
-#define FP_TO_INT_Q(r,X,rsz,rsg)	_FP_TO_INT(Q,2,r,X,rsz,rsg)
-#define FP_TO_INT_ROUND_Q(r,X,rsz,rsg)	_FP_TO_INT_ROUND(Q,2,r,X,rsz,rsg)
-#define FP_FROM_INT_Q(X,r,rs,rt)	_FP_FROM_INT(Q,2,X,r,rs,rt)
-
-#define _FP_FRAC_HIGH_Q(X)	_FP_FRAC_HIGH_2(X)
-#define _FP_FRAC_HIGH_RAW_Q(X)	_FP_FRAC_HIGH_2(X)
+# define FP_DECL_Q(X)		_FP_DECL (2, X)
+# define FP_UNPACK_RAW_Q(X, val)	_FP_UNPACK_RAW_2 (Q, X, (val))
+# define FP_UNPACK_RAW_QP(X, val)	_FP_UNPACK_RAW_2_P (Q, X, (val))
+# define FP_PACK_RAW_Q(val, X)	_FP_PACK_RAW_2 (Q, (val), X)
+# define FP_PACK_RAW_QP(val, X)			\
+  do						\
+    {						\
+      if (!FP_INHIBIT_RESULTS)			\
+	_FP_PACK_RAW_2_P (Q, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_UNPACK_Q(X, val)			\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_2 (Q, X, (val));		\
+      _FP_UNPACK_CANONICAL (Q, 2, X);		\
+    }						\
+  while (0)
+
+# define FP_UNPACK_QP(X, val)			\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_2_P (Q, X, (val));		\
+      _FP_UNPACK_CANONICAL (Q, 2, X);		\
+    }						\
+  while (0)
+
+# define FP_UNPACK_SEMIRAW_Q(X, val)		\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_2 (Q, X, (val));		\
+      _FP_UNPACK_SEMIRAW (Q, 2, X);		\
+    }						\
+  while (0)
+
+# define FP_UNPACK_SEMIRAW_QP(X, val)		\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_2_P (Q, X, (val));		\
+      _FP_UNPACK_SEMIRAW (Q, 2, X);		\
+    }						\
+  while (0)
+
+# define FP_PACK_Q(val, X)			\
+  do						\
+    {						\
+      _FP_PACK_CANONICAL (Q, 2, X);		\
+      _FP_PACK_RAW_2 (Q, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_PACK_QP(val, X)			\
+  do						\
+    {						\
+      _FP_PACK_CANONICAL (Q, 2, X);		\
+      if (!FP_INHIBIT_RESULTS)			\
+	_FP_PACK_RAW_2_P (Q, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_PACK_SEMIRAW_Q(val, X)		\
+  do						\
+    {						\
+      _FP_PACK_SEMIRAW (Q, 2, X);		\
+      _FP_PACK_RAW_2 (Q, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_PACK_SEMIRAW_QP(val, X)		\
+  do						\
+    {						\
+      _FP_PACK_SEMIRAW (Q, 2, X);		\
+      if (!FP_INHIBIT_RESULTS)			\
+	_FP_PACK_RAW_2_P (Q, (val), X);		\
+    }						\
+  while (0)
+
+# define FP_ISSIGNAN_Q(X)		_FP_ISSIGNAN (Q, 2, X)
+# define FP_NEG_Q(R, X)			_FP_NEG (Q, 2, R, X)
+# define FP_ADD_Q(R, X, Y)		_FP_ADD (Q, 2, R, X, Y)
+# define FP_SUB_Q(R, X, Y)		_FP_SUB (Q, 2, R, X, Y)
+# define FP_MUL_Q(R, X, Y)		_FP_MUL (Q, 2, R, X, Y)
+# define FP_DIV_Q(R, X, Y)		_FP_DIV (Q, 2, R, X, Y)
+# define FP_SQRT_Q(R, X)		_FP_SQRT (Q, 2, R, X)
+# define _FP_SQRT_MEAT_Q(R, S, T, X, Q)	_FP_SQRT_MEAT_2 (R, S, T, X, (Q))
+# define FP_FMA_Q(R, X, Y, Z)		_FP_FMA (Q, 2, 4, R, X, Y, Z)
+
+# define FP_CMP_Q(r, X, Y, un, ex)	_FP_CMP (Q, 2, (r), X, Y, (un), (ex))
+# define FP_CMP_EQ_Q(r, X, Y, ex)	_FP_CMP_EQ (Q, 2, (r), X, Y, (ex))
+# define FP_CMP_UNORD_Q(r, X, Y, ex)	_FP_CMP_UNORD (Q, 2, (r), X, Y, (ex))
+
+# define FP_TO_INT_Q(r, X, rsz, rsg)	_FP_TO_INT (Q, 2, (r), X, (rsz), (rsg))
+# define FP_TO_INT_ROUND_Q(r, X, rsz, rsg)	\
+  _FP_TO_INT_ROUND (Q, 2, (r), X, (rsz), (rsg))
+# define FP_FROM_INT_Q(X, r, rs, rt)	_FP_FROM_INT (Q, 2, X, (r), (rs), rt)
+
+# define _FP_FRAC_HIGH_Q(X)	_FP_FRAC_HIGH_2 (X)
+# define _FP_FRAC_HIGH_RAW_Q(X)	_FP_FRAC_HIGH_2 (X)
+
+# define _FP_FRAC_HIGH_DW_Q(X)	_FP_FRAC_HIGH_4 (X)
 
 #endif /* not _FP_W_TYPE_SIZE < 64 */
 
-#endif /* __MATH_EMU_QUAD_H__ */
+#endif /* !SOFT_FP_QUAD_H */
diff --git a/include/math-emu/single.h b/include/math-emu/single.h
index 87f90b0..b035140 100644
--- a/include/math-emu/single.h
+++ b/include/math-emu/single.h
@@ -1,6 +1,6 @@
 /* Software floating-point emulation.
    Definitions for IEEE Single Precision.
-   Copyright (C) 1997,1998,1999 Free Software Foundation, Inc.
+   Copyright (C) 1997-2015 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
    Contributed by Richard Henderson (rth@cygnus.com),
 		  Jakub Jelinek (jj@ultra.linux.cz),
@@ -8,45 +8,71 @@
 		  Peter Maydell (pmaydell@chiark.greenend.org.uk).
 
    The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Library General Public License as
-   published by the Free Software Foundation; either version 2 of the
-   License, or (at your option) any later version.
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   In addition to the permissions in the GNU Lesser General Public
+   License, the Free Software Foundation gives you unlimited
+   permission to link the compiled version of this file into
+   combinations with other programs, and to distribute those
+   combinations without any restriction coming from the use of this
+   file.  (The Lesser General Public License restrictions do apply in
+   other respects; for example, they cover modification of the file,
+   and distribution when not linked into a combine executable.)
 
    The GNU C Library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Library General Public License for more details.
+   Lesser General Public License for more details.
 
-   You should have received a copy of the GNU Library General Public
-   License along with the GNU C Library; see the file COPYING.LIB.  If
-   not, write to the Free Software Foundation, Inc.,
-   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
 
-#ifndef    __MATH_EMU_SINGLE_H__
-#define    __MATH_EMU_SINGLE_H__
+#ifndef SOFT_FP_SINGLE_H
+#define SOFT_FP_SINGLE_H	1
 
 #if _FP_W_TYPE_SIZE < 32
-#error "Here's a nickel kid.  Go buy yourself a real computer."
+# error "Here's a nickel kid.  Go buy yourself a real computer."
+#endif
+
+#define _FP_FRACTBITS_S		_FP_W_TYPE_SIZE
+
+#if _FP_W_TYPE_SIZE < 64
+# define _FP_FRACTBITS_DW_S	(2 * _FP_W_TYPE_SIZE)
+#else
+# define _FP_FRACTBITS_DW_S	_FP_W_TYPE_SIZE
 #endif
 
 #define _FP_FRACBITS_S		24
-#define _FP_FRACXBITS_S		(_FP_W_TYPE_SIZE - _FP_FRACBITS_S)
+#define _FP_FRACXBITS_S		(_FP_FRACTBITS_S - _FP_FRACBITS_S)
 #define _FP_WFRACBITS_S		(_FP_WORKBITS + _FP_FRACBITS_S)
-#define _FP_WFRACXBITS_S	(_FP_W_TYPE_SIZE - _FP_WFRACBITS_S)
+#define _FP_WFRACXBITS_S	(_FP_FRACTBITS_S - _FP_WFRACBITS_S)
 #define _FP_EXPBITS_S		8
 #define _FP_EXPBIAS_S		127
 #define _FP_EXPMAX_S		255
-#define _FP_QNANBIT_S		((_FP_W_TYPE)1 << (_FP_FRACBITS_S-2))
-#define _FP_IMPLBIT_S		((_FP_W_TYPE)1 << (_FP_FRACBITS_S-1))
-#define _FP_OVERFLOW_S		((_FP_W_TYPE)1 << (_FP_WFRACBITS_S))
+#define _FP_QNANBIT_S		((_FP_W_TYPE) 1 << (_FP_FRACBITS_S-2))
+#define _FP_QNANBIT_SH_S	((_FP_W_TYPE) 1 << (_FP_FRACBITS_S-2+_FP_WORKBITS))
+#define _FP_IMPLBIT_S		((_FP_W_TYPE) 1 << (_FP_FRACBITS_S-1))
+#define _FP_IMPLBIT_SH_S	((_FP_W_TYPE) 1 << (_FP_FRACBITS_S-1+_FP_WORKBITS))
+#define _FP_OVERFLOW_S		((_FP_W_TYPE) 1 << (_FP_WFRACBITS_S))
+
+#define _FP_WFRACBITS_DW_S	(2 * _FP_WFRACBITS_S)
+#define _FP_WFRACXBITS_DW_S	(_FP_FRACTBITS_DW_S - _FP_WFRACBITS_DW_S)
+#define _FP_HIGHBIT_DW_S	\
+  ((_FP_W_TYPE) 1 << (_FP_WFRACBITS_DW_S - 1) % _FP_W_TYPE_SIZE)
 
 /* The implementation of _FP_MUL_MEAT_S and _FP_DIV_MEAT_S should be
    chosen by the target machine.  */
 
+typedef float SFtype __attribute__ ((mode (SF)));
+
 union _FP_UNION_S
 {
-  float flt;
-  struct {
+  SFtype flt;
+  struct _FP_STRUCT_LAYOUT
+  {
 #if __BYTE_ORDER = __BIG_ENDIAN
     unsigned sign : 1;
     unsigned exp  : _FP_EXPBITS_S;
@@ -56,61 +82,118 @@ union _FP_UNION_S
     unsigned exp  : _FP_EXPBITS_S;
     unsigned sign : 1;
 #endif
-  } bits __attribute__((packed));
+  } bits __attribute__ ((packed));
 };
 
-#define FP_DECL_S(X)		_FP_DECL(1,X)
-#define FP_UNPACK_RAW_S(X,val)	_FP_UNPACK_RAW_1(S,X,val)
-#define FP_UNPACK_RAW_SP(X,val)	_FP_UNPACK_RAW_1_P(S,X,val)
-#define FP_PACK_RAW_S(val,X)	_FP_PACK_RAW_1(S,val,X)
-#define FP_PACK_RAW_SP(val,X)		\
-  do {					\
-    if (!FP_INHIBIT_RESULTS)		\
-      _FP_PACK_RAW_1_P(S,val,X);	\
-  } while (0)
-
-#define FP_UNPACK_S(X,val)		\
-  do {					\
-    _FP_UNPACK_RAW_1(S,X,val);		\
-    _FP_UNPACK_CANONICAL(S,1,X);	\
-  } while (0)
-
-#define FP_UNPACK_SP(X,val)		\
-  do {					\
-    _FP_UNPACK_RAW_1_P(S,X,val);	\
-    _FP_UNPACK_CANONICAL(S,1,X);	\
-  } while (0)
-
-#define FP_PACK_S(val,X)		\
-  do {					\
-    _FP_PACK_CANONICAL(S,1,X);		\
-    _FP_PACK_RAW_1(S,val,X);		\
-  } while (0)
-
-#define FP_PACK_SP(val,X)		\
-  do {					\
-    _FP_PACK_CANONICAL(S,1,X);		\
-    if (!FP_INHIBIT_RESULTS)		\
-      _FP_PACK_RAW_1_P(S,val,X);	\
-  } while (0)
-
-#define FP_ISSIGNAN_S(X)		_FP_ISSIGNAN(S,1,X)
-#define FP_NEG_S(R,X)			_FP_NEG(S,1,R,X)
-#define FP_ADD_S(R,X,Y)			_FP_ADD(S,1,R,X,Y)
-#define FP_SUB_S(R,X,Y)			_FP_SUB(S,1,R,X,Y)
-#define FP_MUL_S(R,X,Y)			_FP_MUL(S,1,R,X,Y)
-#define FP_DIV_S(R,X,Y)			_FP_DIV(S,1,R,X,Y)
-#define FP_SQRT_S(R,X)			_FP_SQRT(S,1,R,X)
-#define _FP_SQRT_MEAT_S(R,S,T,X,Q)	_FP_SQRT_MEAT_1(R,S,T,X,Q)
-
-#define FP_CMP_S(r,X,Y,un)	_FP_CMP(S,1,r,X,Y,un)
-#define FP_CMP_EQ_S(r,X,Y)	_FP_CMP_EQ(S,1,r,X,Y)
-
-#define FP_TO_INT_S(r,X,rsz,rsg)	_FP_TO_INT(S,1,r,X,rsz,rsg)
-#define FP_TO_INT_ROUND_S(r,X,rsz,rsg)	_FP_TO_INT_ROUND(S,1,r,X,rsz,rsg)
-#define FP_FROM_INT_S(X,r,rs,rt)	_FP_FROM_INT(S,1,X,r,rs,rt)
-
-#define _FP_FRAC_HIGH_S(X)	_FP_FRAC_HIGH_1(X)
-#define _FP_FRAC_HIGH_RAW_S(X)	_FP_FRAC_HIGH_1(X)
-
-#endif /* __MATH_EMU_SINGLE_H__ */
+#define FP_DECL_S(X)		_FP_DECL (1, X)
+#define FP_UNPACK_RAW_S(X, val)	_FP_UNPACK_RAW_1 (S, X, (val))
+#define FP_UNPACK_RAW_SP(X, val)	_FP_UNPACK_RAW_1_P (S, X, (val))
+#define FP_PACK_RAW_S(val, X)	_FP_PACK_RAW_1 (S, (val), X)
+#define FP_PACK_RAW_SP(val, X)			\
+  do						\
+    {						\
+      if (!FP_INHIBIT_RESULTS)			\
+	_FP_PACK_RAW_1_P (S, (val), X);		\
+    }						\
+  while (0)
+
+#define FP_UNPACK_S(X, val)			\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_1 (S, X, (val));		\
+      _FP_UNPACK_CANONICAL (S, 1, X);		\
+    }						\
+  while (0)
+
+#define FP_UNPACK_SP(X, val)			\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_1_P (S, X, (val));		\
+      _FP_UNPACK_CANONICAL (S, 1, X);		\
+    }						\
+  while (0)
+
+#define FP_UNPACK_SEMIRAW_S(X, val)		\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_1 (S, X, (val));		\
+      _FP_UNPACK_SEMIRAW (S, 1, X);		\
+    }						\
+  while (0)
+
+#define FP_UNPACK_SEMIRAW_SP(X, val)		\
+  do						\
+    {						\
+      _FP_UNPACK_RAW_1_P (S, X, (val));		\
+      _FP_UNPACK_SEMIRAW (S, 1, X);		\
+    }						\
+  while (0)
+
+#define FP_PACK_S(val, X)			\
+  do						\
+    {						\
+      _FP_PACK_CANONICAL (S, 1, X);		\
+      _FP_PACK_RAW_1 (S, (val), X);		\
+    }						\
+  while (0)
+
+#define FP_PACK_SP(val, X)			\
+  do						\
+    {						\
+      _FP_PACK_CANONICAL (S, 1, X);		\
+      if (!FP_INHIBIT_RESULTS)			\
+	_FP_PACK_RAW_1_P (S, (val), X);		\
+    }						\
+  while (0)
+
+#define FP_PACK_SEMIRAW_S(val, X)		\
+  do						\
+    {						\
+      _FP_PACK_SEMIRAW (S, 1, X);		\
+      _FP_PACK_RAW_1 (S, (val), X);		\
+    }						\
+  while (0)
+
+#define FP_PACK_SEMIRAW_SP(val, X)		\
+  do						\
+    {						\
+      _FP_PACK_SEMIRAW (S, 1, X);		\
+      if (!FP_INHIBIT_RESULTS)			\
+	_FP_PACK_RAW_1_P (S, (val), X);		\
+    }						\
+  while (0)
+
+#define FP_ISSIGNAN_S(X)		_FP_ISSIGNAN (S, 1, X)
+#define FP_NEG_S(R, X)			_FP_NEG (S, 1, R, X)
+#define FP_ADD_S(R, X, Y)		_FP_ADD (S, 1, R, X, Y)
+#define FP_SUB_S(R, X, Y)		_FP_SUB (S, 1, R, X, Y)
+#define FP_MUL_S(R, X, Y)		_FP_MUL (S, 1, R, X, Y)
+#define FP_DIV_S(R, X, Y)		_FP_DIV (S, 1, R, X, Y)
+#define FP_SQRT_S(R, X)			_FP_SQRT (S, 1, R, X)
+#define _FP_SQRT_MEAT_S(R, S, T, X, Q)	_FP_SQRT_MEAT_1 (R, S, T, X, (Q))
+
+#if _FP_W_TYPE_SIZE < 64
+# define FP_FMA_S(R, X, Y, Z)	_FP_FMA (S, 1, 2, R, X, Y, Z)
+#else
+# define FP_FMA_S(R, X, Y, Z)	_FP_FMA (S, 1, 1, R, X, Y, Z)
+#endif
+
+#define FP_CMP_S(r, X, Y, un, ex)	_FP_CMP (S, 1, (r), X, Y, (un), (ex))
+#define FP_CMP_EQ_S(r, X, Y, ex)	_FP_CMP_EQ (S, 1, (r), X, Y, (ex))
+#define FP_CMP_UNORD_S(r, X, Y, ex)	_FP_CMP_UNORD (S, 1, (r), X, Y, (ex))
+
+#define FP_TO_INT_S(r, X, rsz, rsg)	_FP_TO_INT (S, 1, (r), X, (rsz), (rsg))
+#define FP_TO_INT_ROUND_S(r, X, rsz, rsg)	\
+  _FP_TO_INT_ROUND (S, 1, (r), X, (rsz), (rsg))
+#define FP_FROM_INT_S(X, r, rs, rt)	_FP_FROM_INT (S, 1, X, (r), (rs), rt)
+
+#define _FP_FRAC_HIGH_S(X)	_FP_FRAC_HIGH_1 (X)
+#define _FP_FRAC_HIGH_RAW_S(X)	_FP_FRAC_HIGH_1 (X)
+
+#if _FP_W_TYPE_SIZE < 64
+# define _FP_FRAC_HIGH_DW_S(X)	_FP_FRAC_HIGH_2 (X)
+#else
+# define _FP_FRAC_HIGH_DW_S(X)	_FP_FRAC_HIGH_1 (X)
+#endif
+
+#endif /* !SOFT_FP_SINGLE_H */
diff --git a/include/math-emu/soft-fp.h b/include/math-emu/soft-fp.h
index 3f284bc..3b39336 100644
--- a/include/math-emu/soft-fp.h
+++ b/include/math-emu/soft-fp.h
@@ -1,5 +1,5 @@
 /* Software floating-point emulation.
-   Copyright (C) 1997,1998,1999 Free Software Foundation, Inc.
+   Copyright (C) 1997-2015 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
    Contributed by Richard Henderson (rth@cygnus.com),
 		  Jakub Jelinek (jj@ultra.linux.cz),
@@ -7,201 +7,348 @@
 		  Peter Maydell (pmaydell@chiark.greenend.org.uk).
 
    The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Library General Public License as
-   published by the Free Software Foundation; either version 2 of the
-   License, or (at your option) any later version.
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   In addition to the permissions in the GNU Lesser General Public
+   License, the Free Software Foundation gives you unlimited
+   permission to link the compiled version of this file into
+   combinations with other programs, and to distribute those
+   combinations without any restriction coming from the use of this
+   file.  (The Lesser General Public License restrictions do apply in
+   other respects; for example, they cover modification of the file,
+   and distribution when not linked into a combine executable.)
 
    The GNU C Library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Library General Public License for more details.
+   Lesser General Public License for more details.
 
-   You should have received a copy of the GNU Library General Public
-   License along with the GNU C Library; see the file COPYING.LIB.  If
-   not, write to the Free Software Foundation, Inc.,
-   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
 
-#ifndef __MATH_EMU_SOFT_FP_H__
-#define __MATH_EMU_SOFT_FP_H__
+#ifndef SOFT_FP_H
+#define SOFT_FP_H	1
 
-#include <asm/sfp-machine.h>
+#ifdef _LIBC
+# include <sfp-machine.h>
+#elif defined __KERNEL__
+/* The Linux kernel uses asm/ names for architecture-specific
+   files.  */
+# include <asm/sfp-machine.h>
+#else
+# include "sfp-machine.h"
+#endif
 
-/* Allow sfp-machine to have its own byte order definitions. */
+/* Allow sfp-machine to have its own byte order definitions.  */
 #ifndef __BYTE_ORDER
-#include <endian.h>
+# ifdef _LIBC
+#  include <endian.h>
+# else
+#  error "endianness not defined by sfp-machine.h"
+# endif
+#endif
+
+/* For unreachable default cases in switch statements over bitwise OR
+   of FP_CLS_* values.  */
+#if (defined __GNUC__							\
+     && (__GNUC__ > 4 || (__GNUC__ = 4 && __GNUC_MINOR__ >= 5)))
+# define _FP_UNREACHABLE	__builtin_unreachable ()
+#else
+# define _FP_UNREACHABLE	abort ()
+#endif
+
+#if ((defined __GNUC__							\
+      && (__GNUC__ > 4 || (__GNUC__ = 4 && __GNUC_MINOR__ >= 6)))	\
+     || (defined __STDC_VERSION__ && __STDC_VERSION__ >= 201112L))
+# define _FP_STATIC_ASSERT(expr, msg)		\
+  _Static_assert ((expr), msg)
+#else
+# define _FP_STATIC_ASSERT(expr, msg)					\
+  extern int (*__Static_assert_function (void))				\
+    [!!sizeof (struct { int __error_if_negative: (expr) ? 2 : -1; })]
+#endif
+
+/* In the Linux kernel, some architectures have a single function that
+   uses different kinds of unpacking and packing depending on the
+   instruction being emulated, meaning it is not readily visible to
+   the compiler that variables from _FP_DECL and _FP_FRAC_DECL_*
+   macros are only used in cases where they were initialized.  */
+#ifdef __KERNEL__
+# define _FP_ZERO_INIT		= 0
+#else
+# define _FP_ZERO_INIT
 #endif
 
 #define _FP_WORKBITS		3
-#define _FP_WORK_LSB		((_FP_W_TYPE)1 << 3)
-#define _FP_WORK_ROUND		((_FP_W_TYPE)1 << 2)
-#define _FP_WORK_GUARD		((_FP_W_TYPE)1 << 1)
-#define _FP_WORK_STICKY		((_FP_W_TYPE)1 << 0)
+#define _FP_WORK_LSB		((_FP_W_TYPE) 1 << 3)
+#define _FP_WORK_ROUND		((_FP_W_TYPE) 1 << 2)
+#define _FP_WORK_GUARD		((_FP_W_TYPE) 1 << 1)
+#define _FP_WORK_STICKY		((_FP_W_TYPE) 1 << 0)
 
 #ifndef FP_RND_NEAREST
 # define FP_RND_NEAREST		0
 # define FP_RND_ZERO		1
 # define FP_RND_PINF		2
 # define FP_RND_MINF		3
+#endif
 #ifndef FP_ROUNDMODE
 # define FP_ROUNDMODE		FP_RND_NEAREST
 #endif
-#endif
 
-/* By default don't care about exceptions. */
+/* By default don't care about exceptions.  */
 #ifndef FP_EX_INVALID
-#define FP_EX_INVALID		0
+# define FP_EX_INVALID		0
 #endif
-#ifndef FP_EX_INVALID_SNAN
-#define FP_EX_INVALID_SNAN	0
+#ifndef FP_EX_OVERFLOW
+# define FP_EX_OVERFLOW		0
 #endif
-/* inf - inf */
-#ifndef FP_EX_INVALID_ISI
-#define FP_EX_INVALID_ISI	0
+#ifndef FP_EX_UNDERFLOW
+# define FP_EX_UNDERFLOW	0
 #endif
-/* inf / inf */
-#ifndef FP_EX_INVALID_IDI
-#define FP_EX_INVALID_IDI	0
+#ifndef FP_EX_DIVZERO
+# define FP_EX_DIVZERO		0
 #endif
-/* 0 / 0 */
-#ifndef FP_EX_INVALID_ZDZ
-#define FP_EX_INVALID_ZDZ	0
+#ifndef FP_EX_INEXACT
+# define FP_EX_INEXACT		0
+#endif
+#ifndef FP_EX_DENORM
+# define FP_EX_DENORM		0
 #endif
-/* inf * 0 */
+
+/* Sub-exceptions of "invalid".  */
+/* Signaling NaN operand.  */
+#ifndef FP_EX_INVALID_SNAN
+# define FP_EX_INVALID_SNAN	0
+#endif
+/* Inf * 0.  */
 #ifndef FP_EX_INVALID_IMZ
-#define FP_EX_INVALID_IMZ	0
+# define FP_EX_INVALID_IMZ	0
 #endif
-#ifndef FP_EX_OVERFLOW
-#define FP_EX_OVERFLOW		0
+/* fma (Inf, 0, c).  */
+#ifndef FP_EX_INVALID_IMZ_FMA
+# define FP_EX_INVALID_IMZ_FMA	0
 #endif
-#ifndef FP_EX_UNDERFLOW
-#define FP_EX_UNDERFLOW		
+/* Inf - Inf.  */
+#ifndef FP_EX_INVALID_ISI
+# define FP_EX_INVALID_ISI	0
 #endif
-#ifndef FP_EX_DIVZERO
-#define FP_EX_DIVZERO		0
+/* 0 / 0.  */
+#ifndef FP_EX_INVALID_ZDZ
+# define FP_EX_INVALID_ZDZ	0
 #endif
-#ifndef FP_EX_INEXACT
-#define FP_EX_INEXACT		0
+/* Inf / Inf.  */
+#ifndef FP_EX_INVALID_IDI
+# define FP_EX_INVALID_IDI	0
 #endif
-#ifndef FP_EX_DENORM
-#define FP_EX_DENORM		0
+/* sqrt (negative).  */
+#ifndef FP_EX_INVALID_SQRT
+# define FP_EX_INVALID_SQRT	0
+#endif
+/* Invalid conversion to integer.  */
+#ifndef FP_EX_INVALID_CVI
+# define FP_EX_INVALID_CVI	0
+#endif
+/* Invalid comparison.  */
+#ifndef FP_EX_INVALID_VC
+# define FP_EX_INVALID_VC	0
+#endif
+
+/* _FP_STRUCT_LAYOUT may be defined as an attribute to determine the
+   struct layout variant used for structures where bit-fields are used
+   to access specific parts of binary floating-point numbers.  This is
+   required for systems where the default ABI uses struct layout with
+   differences in how consecutive bit-fields are laid out from the
+   default expected by soft-fp.  */
+#ifndef _FP_STRUCT_LAYOUT
+# define _FP_STRUCT_LAYOUT
 #endif
 
 #ifdef _FP_DECL_EX
-#define FP_DECL_EX					\
+# define FP_DECL_EX					\
   int _fex = 0;						\
   _FP_DECL_EX
 #else
-#define FP_DECL_EX int _fex = 0
+# define FP_DECL_EX int _fex = 0
 #endif
-  
+
+/* Initialize any machine-specific state used in FP_ROUNDMODE,
+   FP_TRAPPING_EXCEPTIONS or FP_HANDLE_EXCEPTIONS.  */
 #ifndef FP_INIT_ROUNDMODE
-#define FP_INIT_ROUNDMODE do {} while (0)
+# define FP_INIT_ROUNDMODE do {} while (0)
+#endif
+
+/* Initialize any machine-specific state used in
+   FP_TRAPPING_EXCEPTIONS or FP_HANDLE_EXCEPTIONS.  */
+#ifndef FP_INIT_TRAPPING_EXCEPTIONS
+# define FP_INIT_TRAPPING_EXCEPTIONS FP_INIT_ROUNDMODE
+#endif
+
+/* Initialize any machine-specific state used in
+   FP_HANDLE_EXCEPTIONS.  */
+#ifndef FP_INIT_EXCEPTIONS
+# define FP_INIT_EXCEPTIONS FP_INIT_TRAPPING_EXCEPTIONS
 #endif
 
 #ifndef FP_HANDLE_EXCEPTIONS
-#define FP_HANDLE_EXCEPTIONS do {} while (0)
+# define FP_HANDLE_EXCEPTIONS do {} while (0)
 #endif
 
-/* By default we never flush denormal input operands to signed zero. */
+/* Whether to flush subnormal inputs to zero with the same sign.  */
 #ifndef FP_DENORM_ZERO
-#define FP_DENORM_ZERO 0
+# define FP_DENORM_ZERO 0
 #endif
 
 #ifndef FP_INHIBIT_RESULTS
 /* By default we write the results always.
- * sfp-machine may override this and e.g.
- * check if some exceptions are unmasked
- * and inhibit it in such a case.
- */
-#define FP_INHIBIT_RESULTS 0
-#endif
-
-#ifndef FP_TRAPPING_EXCEPTIONS
-#define FP_TRAPPING_EXCEPTIONS 0
+   sfp-machine may override this and e.g.
+   check if some exceptions are unmasked
+   and inhibit it in such a case.  */
+# define FP_INHIBIT_RESULTS 0
 #endif
 
 #define FP_SET_EXCEPTION(ex)				\
   _fex |= (ex)
-  
-#define FP_UNSET_EXCEPTION(ex)				\
-  _fex &= ~(ex)
 
 #define FP_CUR_EXCEPTIONS				\
   (_fex)
 
-#define FP_CLEAR_EXCEPTIONS				\
-  _fex = 0
+#ifndef FP_TRAPPING_EXCEPTIONS
+# define FP_TRAPPING_EXCEPTIONS 0
+#endif
+
+/* A file using soft-fp may define FP_NO_EXCEPTIONS before including
+   soft-fp.h to indicate that, although a macro used there could raise
+   exceptions, or do rounding and potentially thereby raise
+   exceptions, for some arguments, for the particular arguments used
+   in that file no exceptions or rounding can occur.  Such a file
+   should not itself use macros relating to handling exceptions and
+   rounding modes; this is only for indirect uses (in particular, in
+   _FP_FROM_INT and the macros it calls).  */
+#ifdef FP_NO_EXCEPTIONS
+
+# undef FP_SET_EXCEPTION
+# define FP_SET_EXCEPTION(ex) do {} while (0)
 
-#define _FP_ROUND_NEAREST(wc, X)			\
-do {							\
-    if ((_FP_FRAC_LOW_##wc(X) & 15) != _FP_WORK_ROUND)	\
-      _FP_FRAC_ADDI_##wc(X, _FP_WORK_ROUND);		\
-} while (0)
+# undef FP_CUR_EXCEPTIONS
+# define FP_CUR_EXCEPTIONS 0
 
-#define _FP_ROUND_ZERO(wc, X)		0
+# undef FP_TRAPPING_EXCEPTIONS
+# define FP_TRAPPING_EXCEPTIONS 0
+
+# undef FP_ROUNDMODE
+# define FP_ROUNDMODE FP_RND_ZERO
+
+# undef _FP_TININESS_AFTER_ROUNDING
+# define _FP_TININESS_AFTER_ROUNDING 0
+
+#endif
+
+/* A file using soft-fp may define FP_NO_EXACT_UNDERFLOW before
+   including soft-fp.h to indicate that, although a macro used there
+   could allow for the case of exact underflow requiring the underflow
+   exception to be raised if traps are enabled, for the particular
+   arguments used in that file no exact underflow can occur.  */
+#ifdef FP_NO_EXACT_UNDERFLOW
+# undef FP_TRAPPING_EXCEPTIONS
+# define FP_TRAPPING_EXCEPTIONS 0
+#endif
+
+#define _FP_ROUND_NEAREST(wc, X)				\
+  do								\
+    {								\
+      if ((_FP_FRAC_LOW_##wc (X) & 15) != _FP_WORK_ROUND)	\
+	_FP_FRAC_ADDI_##wc (X, _FP_WORK_ROUND);			\
+    }								\
+  while (0)
+
+#define _FP_ROUND_ZERO(wc, X)		(void) 0
 
 #define _FP_ROUND_PINF(wc, X)				\
-do {							\
-    if (!X##_s && (_FP_FRAC_LOW_##wc(X) & 7))		\
-      _FP_FRAC_ADDI_##wc(X, _FP_WORK_LSB);		\
-} while (0)
+  do							\
+    {							\
+      if (!X##_s && (_FP_FRAC_LOW_##wc (X) & 7))	\
+	_FP_FRAC_ADDI_##wc (X, _FP_WORK_LSB);		\
+    }							\
+  while (0)
 
-#define _FP_ROUND_MINF(wc, X)				\
-do {							\
-    if (X##_s && (_FP_FRAC_LOW_##wc(X) & 7))		\
-      _FP_FRAC_ADDI_##wc(X, _FP_WORK_LSB);		\
-} while (0)
+#define _FP_ROUND_MINF(wc, X)			\
+  do						\
+    {						\
+      if (X##_s && (_FP_FRAC_LOW_##wc (X) & 7))	\
+	_FP_FRAC_ADDI_##wc (X, _FP_WORK_LSB);	\
+    }						\
+  while (0)
 
 #define _FP_ROUND(wc, X)			\
-do {						\
-	if (_FP_FRAC_LOW_##wc(X) & 7)		\
-	  FP_SET_EXCEPTION(FP_EX_INEXACT);	\
-	switch (FP_ROUNDMODE)			\
+  do						\
+    {						\
+      if (_FP_FRAC_LOW_##wc (X) & 7)		\
 	{					\
-	  case FP_RND_NEAREST:			\
-	    _FP_ROUND_NEAREST(wc,X);		\
-	    break;				\
-	  case FP_RND_ZERO:			\
-	    _FP_ROUND_ZERO(wc,X);		\
-	    break;				\
-	  case FP_RND_PINF:			\
-	    _FP_ROUND_PINF(wc,X);		\
-	    break;				\
-	  case FP_RND_MINF:			\
-	    _FP_ROUND_MINF(wc,X);		\
-	    break;				\
+	  FP_SET_EXCEPTION (FP_EX_INEXACT);	\
+	  switch (FP_ROUNDMODE)			\
+	    {					\
+	    case FP_RND_NEAREST:		\
+	      _FP_ROUND_NEAREST (wc, X);	\
+	      break;				\
+	    case FP_RND_ZERO:			\
+	      _FP_ROUND_ZERO (wc, X);		\
+	      break;				\
+	    case FP_RND_PINF:			\
+	      _FP_ROUND_PINF (wc, X);		\
+	      break;				\
+	    case FP_RND_MINF:			\
+	      _FP_ROUND_MINF (wc, X);		\
+	      break;				\
+	    }					\
 	}					\
-} while (0)
+    }						\
+  while (0)
 
 #define FP_CLS_NORMAL		0
 #define FP_CLS_ZERO		1
 #define FP_CLS_INF		2
 #define FP_CLS_NAN		3
 
-#define _FP_CLS_COMBINE(x,y)	(((x) << 2) | (y))
+#define _FP_CLS_COMBINE(x, y)	(((x) << 2) | (y))
 
-#include <math-emu/op-1.h>
-#include <math-emu/op-2.h>
-#include <math-emu/op-4.h>
-#include <math-emu/op-8.h>
-#include <math-emu/op-common.h>
+#include "op-1.h"
+#include "op-2.h"
+#include "op-4.h"
+#include "op-8.h"
+#include "op-common.h"
 
 /* Sigh.  Silly things longlong.h needs.  */
 #define UWtype		_FP_W_TYPE
 #define W_TYPE_SIZE	_FP_W_TYPE_SIZE
 
-typedef int SItype __attribute__((mode(SI)));
-typedef int DItype __attribute__((mode(DI)));
-typedef unsigned int USItype __attribute__((mode(SI)));
-typedef unsigned int UDItype __attribute__((mode(DI)));
+typedef int QItype __attribute__ ((mode (QI)));
+typedef int SItype __attribute__ ((mode (SI)));
+typedef int DItype __attribute__ ((mode (DI)));
+typedef unsigned int UQItype __attribute__ ((mode (QI)));
+typedef unsigned int USItype __attribute__ ((mode (SI)));
+typedef unsigned int UDItype __attribute__ ((mode (DI)));
 #if _FP_W_TYPE_SIZE = 32
-typedef unsigned int UHWtype __attribute__((mode(HI)));
+typedef unsigned int UHWtype __attribute__ ((mode (HI)));
 #elif _FP_W_TYPE_SIZE = 64
 typedef USItype UHWtype;
 #endif
 
+#ifndef CMPtype
+# define CMPtype	int
+#endif
+
+#define SI_BITS		(__CHAR_BIT__ * (int) sizeof (SItype))
+#define DI_BITS		(__CHAR_BIT__ * (int) sizeof (DItype))
+
 #ifndef umul_ppmm
-#include <stdlib/longlong.h>
+# ifdef _LIBC
+#  include <stdlib/longlong.h>
+# else
+#  include "longlong.h"
+# endif
 #endif
 
-#endif /* __MATH_EMU_SOFT_FP_H__ */
+#endif /* !SOFT_FP_H */


-- 
Joseph S. Myers
joseph@codesourcery.com
