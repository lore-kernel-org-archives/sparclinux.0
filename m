From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 27 Jul 2017 21:57:28 +0000
Subject: [PATCH RFC 2/4] arch/sparc: Rename exception handlers
Message-Id: <1501192650-1043374-2-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1501192650-1043374-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1501192650-1043374-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, babu.moger@oracle.com

Rename exception handlers to memcpy_xxx as these
are going to be used by new memcpy routines and these
handlers are not exclusive to NG4memcpy anymore.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
---
 arch/sparc/lib/Memcpy_utils.S |  120 +++++++++++++++++++-------------------
 arch/sparc/lib/NG4memcpy.S    |  128 ++++++++++++++++++++--------------------
 2 files changed, 124 insertions(+), 124 deletions(-)

diff --git a/arch/sparc/lib/Memcpy_utils.S b/arch/sparc/lib/Memcpy_utils.S
index f7a26e0..bcc5d77 100644
--- a/arch/sparc/lib/Memcpy_utils.S
+++ b/arch/sparc/lib/Memcpy_utils.S
@@ -16,148 +16,148 @@ ENTRY(__restore_asi)
 	 wr	%g0, ASI_AIUS, %asi
 ENDPROC(__restore_asi)
 
-ENTRY(NG4_retl_o2)
+ENTRY(memcpy_retl_o2)
 	ba,pt	%xcc, __restore_asi
 	 mov	%o2, %o0
-ENDPROC(NG4_retl_o2)
-ENTRY(NG4_retl_o2_plus_1)
+ENDPROC(memcpy_retl_o2)
+ENTRY(memcpy_retl_o2_plus_1)
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, 1, %o0
-ENDPROC(NG4_retl_o2_plus_1)
-ENTRY(NG4_retl_o2_plus_4)
+ENDPROC(memcpy_retl_o2_plus_1)
+ENTRY(memcpy_retl_o2_plus_4)
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, 4, %o0
-ENDPROC(NG4_retl_o2_plus_4)
-ENTRY(NG4_retl_o2_plus_o5)
+ENDPROC(memcpy_retl_o2_plus_4)
+ENTRY(memcpy_retl_o2_plus_o5)
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o5, %o0
-ENDPROC(NG4_retl_o2_plus_o5)
-ENTRY(NG4_retl_o2_plus_o5_plus_4)
+ENDPROC(memcpy_retl_o2_plus_o5)
+ENTRY(memcpy_retl_o2_plus_o5_plus_4)
 	add	%o5, 4, %o5
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o5, %o0
-ENDPROC(NG4_retl_o2_plus_o5_plus_4)
-ENTRY(NG4_retl_o2_plus_o5_plus_8)
+ENDPROC(memcpy_retl_o2_plus_o5_plus_4)
+ENTRY(memcpy_retl_o2_plus_o5_plus_8)
 	add	%o5, 8, %o5
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o5, %o0
-ENDPROC(NG4_retl_o2_plus_o5_plus_8)
-ENTRY(NG4_retl_o2_plus_o5_plus_16)
+ENDPROC(memcpy_retl_o2_plus_o5_plus_8)
+ENTRY(memcpy_retl_o2_plus_o5_plus_16)
 	add	%o5, 16, %o5
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o5, %o0
-ENDPROC(NG4_retl_o2_plus_o5_plus_16)
-ENTRY(NG4_retl_o2_plus_o5_plus_24)
+ENDPROC(memcpy_retl_o2_plus_o5_plus_16)
+ENTRY(memcpy_retl_o2_plus_o5_plus_24)
 	add	%o5, 24, %o5
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o5, %o0
-ENDPROC(NG4_retl_o2_plus_o5_plus_24)
-ENTRY(NG4_retl_o2_plus_o5_plus_32)
+ENDPROC(memcpy_retl_o2_plus_o5_plus_24)
+ENTRY(memcpy_retl_o2_plus_o5_plus_32)
 	add	%o5, 32, %o5
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o5, %o0
-ENDPROC(NG4_retl_o2_plus_o5_plus_32)
-ENTRY(NG4_retl_o2_plus_g1)
+ENDPROC(memcpy_retl_o2_plus_o5_plus_32)
+ENTRY(memcpy_retl_o2_plus_g1)
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %g1, %o0
-ENDPROC(NG4_retl_o2_plus_g1)
-ENTRY(NG4_retl_o2_plus_g1_plus_1)
+ENDPROC(memcpy_retl_o2_plus_g1)
+ENTRY(memcpy_retl_o2_plus_g1_plus_1)
 	add	%g1, 1, %g1
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %g1, %o0
-ENDPROC(NG4_retl_o2_plus_g1_plus_1)
-ENTRY(NG4_retl_o2_plus_g1_plus_8)
+ENDPROC(memcpy_retl_o2_plus_g1_plus_1)
+ENTRY(memcpy_retl_o2_plus_g1_plus_8)
 	add	%g1, 8, %g1
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %g1, %o0
-ENDPROC(NG4_retl_o2_plus_g1_plus_8)
-ENTRY(NG4_retl_o2_plus_o4)
+ENDPROC(memcpy_retl_o2_plus_g1_plus_8)
+ENTRY(memcpy_retl_o2_plus_o4)
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4)
-ENTRY(NG4_retl_o2_plus_o4_plus_8)
+ENDPROC(memcpy_retl_o2_plus_o4)
+ENTRY(memcpy_retl_o2_plus_o4_plus_8)
 	add	%o4, 8, %o4
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_8)
-ENTRY(NG4_retl_o2_plus_o4_plus_16)
+ENDPROC(memcpy_retl_o2_plus_o4_plus_8)
+ENTRY(memcpy_retl_o2_plus_o4_plus_16)
 	add	%o4, 16, %o4
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_16)
-ENTRY(NG4_retl_o2_plus_o4_plus_24)
+ENDPROC(memcpy_retl_o2_plus_o4_plus_16)
+ENTRY(memcpy_retl_o2_plus_o4_plus_24)
 	add	%o4, 24, %o4
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_24)
-ENTRY(NG4_retl_o2_plus_o4_plus_32)
+ENDPROC(memcpy_retl_o2_plus_o4_plus_24)
+ENTRY(memcpy_retl_o2_plus_o4_plus_32)
 	add	%o4, 32, %o4
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_32)
-ENTRY(NG4_retl_o2_plus_o4_plus_40)
+ENDPROC(memcpy_retl_o2_plus_o4_plus_32)
+ENTRY(memcpy_retl_o2_plus_o4_plus_40)
 	add	%o4, 40, %o4
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_40)
-ENTRY(NG4_retl_o2_plus_o4_plus_48)
+ENDPROC(memcpy_retl_o2_plus_o4_plus_40)
+ENTRY(memcpy_retl_o2_plus_o4_plus_48)
 	add	%o4, 48, %o4
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_48)
-ENTRY(NG4_retl_o2_plus_o4_plus_56)
+ENDPROC(memcpy_retl_o2_plus_o4_plus_48)
+ENTRY(memcpy_retl_o2_plus_o4_plus_56)
 	add	%o4, 56, %o4
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_56)
-ENTRY(NG4_retl_o2_plus_o4_plus_64)
+ENDPROC(memcpy_retl_o2_plus_o4_plus_56)
+ENTRY(memcpy_retl_o2_plus_o4_plus_64)
 	add	%o4, 64, %o4
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_64)
-ENTRY(NG4_retl_o2_plus_o4_fp)
+ENDPROC(memcpy_retl_o2_plus_o4_plus_64)
+ENTRY(memcpy_retl_o2_plus_o4_fp)
 	ba,pt	%xcc, __restore_asi_fp
 	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_fp)
-ENTRY(NG4_retl_o2_plus_o4_plus_8_fp)
+ENDPROC(memcpy_retl_o2_plus_o4_fp)
+ENTRY(memcpy_retl_o2_plus_o4_plus_8_fp)
 	add	%o4, 8, %o4
 	ba,pt	%xcc, __restore_asi_fp
 	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_8_fp)
-ENTRY(NG4_retl_o2_plus_o4_plus_16_fp)
+ENDPROC(memcpy_retl_o2_plus_o4_plus_8_fp)
+ENTRY(memcpy_retl_o2_plus_o4_plus_16_fp)
 	add	%o4, 16, %o4
 	ba,pt	%xcc, __restore_asi_fp
 	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_16_fp)
-ENTRY(NG4_retl_o2_plus_o4_plus_24_fp)
+ENDPROC(memcpy_retl_o2_plus_o4_plus_16_fp)
+ENTRY(memcpy_retl_o2_plus_o4_plus_24_fp)
 	add	%o4, 24, %o4
 	ba,pt	%xcc, __restore_asi_fp
 	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_24_fp)
-ENTRY(NG4_retl_o2_plus_o4_plus_32_fp)
+ENDPROC(memcpy_retl_o2_plus_o4_plus_24_fp)
+ENTRY(memcpy_retl_o2_plus_o4_plus_32_fp)
 	add	%o4, 32, %o4
 	ba,pt	%xcc, __restore_asi_fp
 	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_32_fp)
-ENTRY(NG4_retl_o2_plus_o4_plus_40_fp)
+ENDPROC(memcpy_retl_o2_plus_o4_plus_32_fp)
+ENTRY(memcpy_retl_o2_plus_o4_plus_40_fp)
 	add	%o4, 40, %o4
 	ba,pt	%xcc, __restore_asi_fp
 	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_40_fp)
-ENTRY(NG4_retl_o2_plus_o4_plus_48_fp)
+ENDPROC(memcpy_retl_o2_plus_o4_plus_40_fp)
+ENTRY(memcpy_retl_o2_plus_o4_plus_48_fp)
 	add	%o4, 48, %o4
 	ba,pt	%xcc, __restore_asi_fp
 	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_48_fp)
-ENTRY(NG4_retl_o2_plus_o4_plus_56_fp)
+ENDPROC(memcpy_retl_o2_plus_o4_plus_48_fp)
+ENTRY(memcpy_retl_o2_plus_o4_plus_56_fp)
 	add	%o4, 56, %o4
 	ba,pt	%xcc, __restore_asi_fp
 	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_56_fp)
-ENTRY(NG4_retl_o2_plus_o4_plus_64_fp)
+ENDPROC(memcpy_retl_o2_plus_o4_plus_56_fp)
+ENTRY(memcpy_retl_o2_plus_o4_plus_64_fp)
 	add	%o4, 64, %o4
 	ba,pt	%xcc, __restore_asi_fp
 	 add	%o2, %o4, %o0
-ENDPROC(NG4_retl_o2_plus_o4_plus_64_fp)
+ENDPROC(memcpy_retl_o2_plus_o4_plus_64_fp)
 
 #endif
diff --git a/arch/sparc/lib/NG4memcpy.S b/arch/sparc/lib/NG4memcpy.S
index e20d654..b5dacd1 100644
--- a/arch/sparc/lib/NG4memcpy.S
+++ b/arch/sparc/lib/NG4memcpy.S
@@ -126,12 +126,12 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	 sub		%o2, %g1, %o2
 
 
-1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2), NG4_retl_o2_plus_g1)
+1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2), memcpy_retl_o2_plus_g1)
 	add		%o1, 1, %o1
 	subcc		%g1, 1, %g1
 	add		%o0, 1, %o0
 	bne,pt		%icc, 1b
-	 EX_ST(STORE(stb, %g2, %o0 - 0x01), NG4_retl_o2_plus_g1_plus_1)
+	 EX_ST(STORE(stb, %g2, %o0 - 0x01), memcpy_retl_o2_plus_g1_plus_1)
 
 51:	LOAD(prefetch, %o1 + 0x040, #n_reads_strong)
 	LOAD(prefetch, %o1 + 0x080, #n_reads_strong)
@@ -156,43 +156,43 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	brz,pt		%g1, .Llarge_aligned
 	 sub		%o2, %g1, %o2
 
-1:	EX_LD(LOAD(ldx, %o1 + 0x00, %g2), NG4_retl_o2_plus_g1)
+1:	EX_LD(LOAD(ldx, %o1 + 0x00, %g2), memcpy_retl_o2_plus_g1)
 	add		%o1, 8, %o1
 	subcc		%g1, 8, %g1
 	add		%o0, 8, %o0
 	bne,pt		%icc, 1b
-	 EX_ST(STORE(stx, %g2, %o0 - 0x08), NG4_retl_o2_plus_g1_plus_8)
+	 EX_ST(STORE(stx, %g2, %o0 - 0x08), memcpy_retl_o2_plus_g1_plus_8)
 
 .Llarge_aligned:
 	/* len >= 0x80 && src 8-byte aligned && dest 8-byte aligned */
 	andn		%o2, 0x3f, %o4
 	sub		%o2, %o4, %o2
 
-1:	EX_LD(LOAD(ldx, %o1 + 0x00, %g1), NG4_retl_o2_plus_o4)
+1:	EX_LD(LOAD(ldx, %o1 + 0x00, %g1), memcpy_retl_o2_plus_o4)
 	add		%o1, 0x40, %o1
-	EX_LD(LOAD(ldx, %o1 - 0x38, %g2), NG4_retl_o2_plus_o4)
+	EX_LD(LOAD(ldx, %o1 - 0x38, %g2), memcpy_retl_o2_plus_o4)
 	subcc		%o4, 0x40, %o4
-	EX_LD(LOAD(ldx, %o1 - 0x30, %g3), NG4_retl_o2_plus_o4_plus_64)
-	EX_LD(LOAD(ldx, %o1 - 0x28, GLOBAL_SPARE), NG4_retl_o2_plus_o4_plus_64)
-	EX_LD(LOAD(ldx, %o1 - 0x20, %o5), NG4_retl_o2_plus_o4_plus_64)
-	EX_ST(STORE_INIT(%g1, %o0), NG4_retl_o2_plus_o4_plus_64)
+	EX_LD(LOAD(ldx, %o1 - 0x30, %g3), memcpy_retl_o2_plus_o4_plus_64)
+	EX_LD(LOAD(ldx, %o1 - 0x28, GLOBAL_SPARE), memcpy_retl_o2_plus_o4_plus_64)
+	EX_LD(LOAD(ldx, %o1 - 0x20, %o5), memcpy_retl_o2_plus_o4_plus_64)
+	EX_ST(STORE_INIT(%g1, %o0), memcpy_retl_o2_plus_o4_plus_64)
 	add		%o0, 0x08, %o0
-	EX_ST(STORE_INIT(%g2, %o0), NG4_retl_o2_plus_o4_plus_56)
+	EX_ST(STORE_INIT(%g2, %o0), memcpy_retl_o2_plus_o4_plus_56)
 	add		%o0, 0x08, %o0
-	EX_LD(LOAD(ldx, %o1 - 0x18, %g2), NG4_retl_o2_plus_o4_plus_48)
-	EX_ST(STORE_INIT(%g3, %o0), NG4_retl_o2_plus_o4_plus_48)
+	EX_LD(LOAD(ldx, %o1 - 0x18, %g2), memcpy_retl_o2_plus_o4_plus_48)
+	EX_ST(STORE_INIT(%g3, %o0), memcpy_retl_o2_plus_o4_plus_48)
 	add		%o0, 0x08, %o0
-	EX_LD(LOAD(ldx, %o1 - 0x10, %g3), NG4_retl_o2_plus_o4_plus_40)
-	EX_ST(STORE_INIT(GLOBAL_SPARE, %o0), NG4_retl_o2_plus_o4_plus_40)
+	EX_LD(LOAD(ldx, %o1 - 0x10, %g3), memcpy_retl_o2_plus_o4_plus_40)
+	EX_ST(STORE_INIT(GLOBAL_SPARE, %o0), memcpy_retl_o2_plus_o4_plus_40)
 	add		%o0, 0x08, %o0
-	EX_LD(LOAD(ldx, %o1 - 0x08, GLOBAL_SPARE), NG4_retl_o2_plus_o4_plus_32)
-	EX_ST(STORE_INIT(%o5, %o0), NG4_retl_o2_plus_o4_plus_32)
+	EX_LD(LOAD(ldx, %o1 - 0x08, GLOBAL_SPARE), memcpy_retl_o2_plus_o4_plus_32)
+	EX_ST(STORE_INIT(%o5, %o0), memcpy_retl_o2_plus_o4_plus_32)
 	add		%o0, 0x08, %o0
-	EX_ST(STORE_INIT(%g2, %o0), NG4_retl_o2_plus_o4_plus_24)
+	EX_ST(STORE_INIT(%g2, %o0), memcpy_retl_o2_plus_o4_plus_24)
 	add		%o0, 0x08, %o0
-	EX_ST(STORE_INIT(%g3, %o0), NG4_retl_o2_plus_o4_plus_16)
+	EX_ST(STORE_INIT(%g3, %o0), memcpy_retl_o2_plus_o4_plus_16)
 	add		%o0, 0x08, %o0
-	EX_ST(STORE_INIT(GLOBAL_SPARE, %o0), NG4_retl_o2_plus_o4_plus_8)
+	EX_ST(STORE_INIT(GLOBAL_SPARE, %o0), memcpy_retl_o2_plus_o4_plus_8)
 	add		%o0, 0x08, %o0
 	bne,pt		%icc, 1b
 	 LOAD(prefetch, %o1 + 0x200, #n_reads_strong)
@@ -218,17 +218,17 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	sub		%o2, %o4, %o2
 	alignaddr	%o1, %g0, %g1
 	add		%o1, %o4, %o1
-	EX_LD_FP(LOAD(ldd, %g1 + 0x00, %f0), NG4_retl_o2_plus_o4)
-1:	EX_LD_FP(LOAD(ldd, %g1 + 0x08, %f2), NG4_retl_o2_plus_o4)
+	EX_LD_FP(LOAD(ldd, %g1 + 0x00, %f0), memcpy_retl_o2_plus_o4)
+1:	EX_LD_FP(LOAD(ldd, %g1 + 0x08, %f2), memcpy_retl_o2_plus_o4)
 	subcc		%o4, 0x40, %o4
-	EX_LD_FP(LOAD(ldd, %g1 + 0x10, %f4), NG4_retl_o2_plus_o4_plus_64)
-	EX_LD_FP(LOAD(ldd, %g1 + 0x18, %f6), NG4_retl_o2_plus_o4_plus_64)
-	EX_LD_FP(LOAD(ldd, %g1 + 0x20, %f8), NG4_retl_o2_plus_o4_plus_64)
-	EX_LD_FP(LOAD(ldd, %g1 + 0x28, %f10), NG4_retl_o2_plus_o4_plus_64)
-	EX_LD_FP(LOAD(ldd, %g1 + 0x30, %f12), NG4_retl_o2_plus_o4_plus_64)
-	EX_LD_FP(LOAD(ldd, %g1 + 0x38, %f14), NG4_retl_o2_plus_o4_plus_64)
+	EX_LD_FP(LOAD(ldd, %g1 + 0x10, %f4), memcpy_retl_o2_plus_o4_plus_64)
+	EX_LD_FP(LOAD(ldd, %g1 + 0x18, %f6), memcpy_retl_o2_plus_o4_plus_64)
+	EX_LD_FP(LOAD(ldd, %g1 + 0x20, %f8), memcpy_retl_o2_plus_o4_plus_64)
+	EX_LD_FP(LOAD(ldd, %g1 + 0x28, %f10), memcpy_retl_o2_plus_o4_plus_64)
+	EX_LD_FP(LOAD(ldd, %g1 + 0x30, %f12), memcpy_retl_o2_plus_o4_plus_64)
+	EX_LD_FP(LOAD(ldd, %g1 + 0x38, %f14), memcpy_retl_o2_plus_o4_plus_64)
 	faligndata	%f0, %f2, %f16
-	EX_LD_FP(LOAD(ldd, %g1 + 0x40, %f0), NG4_retl_o2_plus_o4_plus_64)
+	EX_LD_FP(LOAD(ldd, %g1 + 0x40, %f0), memcpy_retl_o2_plus_o4_plus_64)
 	faligndata	%f2, %f4, %f18
 	add		%g1, 0x40, %g1
 	faligndata	%f4, %f6, %f20
@@ -237,14 +237,14 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	faligndata	%f10, %f12, %f26
 	faligndata	%f12, %f14, %f28
 	faligndata	%f14, %f0, %f30
-	EX_ST_FP(STORE(std, %f16, %o0 + 0x00), NG4_retl_o2_plus_o4_plus_64)
-	EX_ST_FP(STORE(std, %f18, %o0 + 0x08), NG4_retl_o2_plus_o4_plus_56)
-	EX_ST_FP(STORE(std, %f20, %o0 + 0x10), NG4_retl_o2_plus_o4_plus_48)
-	EX_ST_FP(STORE(std, %f22, %o0 + 0x18), NG4_retl_o2_plus_o4_plus_40)
-	EX_ST_FP(STORE(std, %f24, %o0 + 0x20), NG4_retl_o2_plus_o4_plus_32)
-	EX_ST_FP(STORE(std, %f26, %o0 + 0x28), NG4_retl_o2_plus_o4_plus_24)
-	EX_ST_FP(STORE(std, %f28, %o0 + 0x30), NG4_retl_o2_plus_o4_plus_16)
-	EX_ST_FP(STORE(std, %f30, %o0 + 0x38), NG4_retl_o2_plus_o4_plus_8)
+	EX_ST_FP(STORE(std, %f16, %o0 + 0x00), memcpy_retl_o2_plus_o4_plus_64)
+	EX_ST_FP(STORE(std, %f18, %o0 + 0x08), memcpy_retl_o2_plus_o4_plus_56)
+	EX_ST_FP(STORE(std, %f20, %o0 + 0x10), memcpy_retl_o2_plus_o4_plus_48)
+	EX_ST_FP(STORE(std, %f22, %o0 + 0x18), memcpy_retl_o2_plus_o4_plus_40)
+	EX_ST_FP(STORE(std, %f24, %o0 + 0x20), memcpy_retl_o2_plus_o4_plus_32)
+	EX_ST_FP(STORE(std, %f26, %o0 + 0x28), memcpy_retl_o2_plus_o4_plus_24)
+	EX_ST_FP(STORE(std, %f28, %o0 + 0x30), memcpy_retl_o2_plus_o4_plus_16)
+	EX_ST_FP(STORE(std, %f30, %o0 + 0x38), memcpy_retl_o2_plus_o4_plus_8)
 	add		%o0, 0x40, %o0
 	bne,pt		%icc, 1b
 	 LOAD(prefetch, %g1 + 0x200, #n_reads_strong)
@@ -272,38 +272,38 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	andncc		%o2, 0x20 - 1, %o5
 	be,pn		%icc, 2f
 	 sub		%o2, %o5, %o2
-1:	EX_LD(LOAD(ldx, %o1 + 0x00, %g1), NG4_retl_o2_plus_o5)
-	EX_LD(LOAD(ldx, %o1 + 0x08, %g2), NG4_retl_o2_plus_o5)
-	EX_LD(LOAD(ldx, %o1 + 0x10, GLOBAL_SPARE), NG4_retl_o2_plus_o5)
-	EX_LD(LOAD(ldx, %o1 + 0x18, %o4), NG4_retl_o2_plus_o5)
+1:	EX_LD(LOAD(ldx, %o1 + 0x00, %g1), memcpy_retl_o2_plus_o5)
+	EX_LD(LOAD(ldx, %o1 + 0x08, %g2), memcpy_retl_o2_plus_o5)
+	EX_LD(LOAD(ldx, %o1 + 0x10, GLOBAL_SPARE), memcpy_retl_o2_plus_o5)
+	EX_LD(LOAD(ldx, %o1 + 0x18, %o4), memcpy_retl_o2_plus_o5)
 	add		%o1, 0x20, %o1
 	subcc		%o5, 0x20, %o5
-	EX_ST(STORE(stx, %g1, %o0 + 0x00), NG4_retl_o2_plus_o5_plus_32)
-	EX_ST(STORE(stx, %g2, %o0 + 0x08), NG4_retl_o2_plus_o5_plus_24)
-	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x10), NG4_retl_o2_plus_o5_plus_24)
-	EX_ST(STORE(stx, %o4, %o0 + 0x18), NG4_retl_o2_plus_o5_plus_8)
+	EX_ST(STORE(stx, %g1, %o0 + 0x00), memcpy_retl_o2_plus_o5_plus_32)
+	EX_ST(STORE(stx, %g2, %o0 + 0x08), memcpy_retl_o2_plus_o5_plus_24)
+	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_24)
+	EX_ST(STORE(stx, %o4, %o0 + 0x18), memcpy_retl_o2_plus_o5_plus_8)
 	bne,pt		%icc, 1b
 	 add		%o0, 0x20, %o0
 2:	andcc		%o2, 0x18, %o5
 	be,pt		%icc, 3f
 	 sub		%o2, %o5, %o2
 
-1:	EX_LD(LOAD(ldx, %o1 + 0x00, %g1), NG4_retl_o2_plus_o5)
+1:	EX_LD(LOAD(ldx, %o1 + 0x00, %g1), memcpy_retl_o2_plus_o5)
 	add		%o1, 0x08, %o1
 	add		%o0, 0x08, %o0
 	subcc		%o5, 0x08, %o5
 	bne,pt		%icc, 1b
-	 EX_ST(STORE(stx, %g1, %o0 - 0x08), NG4_retl_o2_plus_o5_plus_8)
+	 EX_ST(STORE(stx, %g1, %o0 - 0x08), memcpy_retl_o2_plus_o5_plus_8)
 3:	brz,pt		%o2, .Lexit
 	 cmp		%o2, 0x04
 	bl,pn		%icc, .Ltiny
 	 nop
-	EX_LD(LOAD(lduw, %o1 + 0x00, %g1), NG4_retl_o2)
+	EX_LD(LOAD(lduw, %o1 + 0x00, %g1), memcpy_retl_o2)
 	add		%o1, 0x04, %o1
 	add		%o0, 0x04, %o0
 	subcc		%o2, 0x04, %o2
 	bne,pn		%icc, .Ltiny
-	 EX_ST(STORE(stw, %g1, %o0 - 0x04), NG4_retl_o2_plus_4)
+	 EX_ST(STORE(stw, %g1, %o0 - 0x04), memcpy_retl_o2_plus_4)
 	ba,a,pt		%icc, .Lexit
 .Lmedium_unaligned:
 	/* First get dest 8 byte aligned.  */
@@ -312,12 +312,12 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	brz,pt		%g1, 2f
 	 sub		%o2, %g1, %o2
 
-1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2), NG4_retl_o2_plus_g1)
+1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2), memcpy_retl_o2_plus_g1)
 	add		%o1, 1, %o1
 	subcc		%g1, 1, %g1
 	add		%o0, 1, %o0
 	bne,pt		%icc, 1b
-	 EX_ST(STORE(stb, %g2, %o0 - 0x01), NG4_retl_o2_plus_g1_plus_1)
+	 EX_ST(STORE(stb, %g2, %o0 - 0x01), memcpy_retl_o2_plus_g1_plus_1)
 2:
 	and		%o1, 0x7, %g1
 	brz,pn		%g1, .Lmedium_noprefetch
@@ -325,16 +325,16 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	mov		64, %g2
 	sub		%g2, %g1, %g2
 	andn		%o1, 0x7, %o1
-	EX_LD(LOAD(ldx, %o1 + 0x00, %o4), NG4_retl_o2)
+	EX_LD(LOAD(ldx, %o1 + 0x00, %o4), memcpy_retl_o2)
 	sllx		%o4, %g1, %o4
 	andn		%o2, 0x08 - 1, %o5
 	sub		%o2, %o5, %o2
-1:	EX_LD(LOAD(ldx, %o1 + 0x08, %g3), NG4_retl_o2_plus_o5)
+1:	EX_LD(LOAD(ldx, %o1 + 0x08, %g3), memcpy_retl_o2_plus_o5)
 	add		%o1, 0x08, %o1
 	subcc		%o5, 0x08, %o5
 	srlx		%g3, %g2, GLOBAL_SPARE
 	or		GLOBAL_SPARE, %o4, GLOBAL_SPARE
-	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x00), NG4_retl_o2_plus_o5_plus_8)
+	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x00), memcpy_retl_o2_plus_o5_plus_8)
 	add		%o0, 0x08, %o0
 	bne,pt		%icc, 1b
 	 sllx		%g3, %g1, %o4
@@ -345,17 +345,17 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	ba,pt		%icc, .Lsmall_unaligned
 
 .Ltiny:
-	EX_LD(LOAD(ldub, %o1 + 0x00, %g1), NG4_retl_o2)
+	EX_LD(LOAD(ldub, %o1 + 0x00, %g1), memcpy_retl_o2)
 	subcc		%o2, 1, %o2
 	be,pn		%icc, .Lexit
-	 EX_ST(STORE(stb, %g1, %o0 + 0x00), NG4_retl_o2_plus_1)
-	EX_LD(LOAD(ldub, %o1 + 0x01, %g1), NG4_retl_o2)
+	 EX_ST(STORE(stb, %g1, %o0 + 0x00), memcpy_retl_o2_plus_1)
+	EX_LD(LOAD(ldub, %o1 + 0x01, %g1), memcpy_retl_o2)
 	subcc		%o2, 1, %o2
 	be,pn		%icc, .Lexit
-	 EX_ST(STORE(stb, %g1, %o0 + 0x01), NG4_retl_o2_plus_1)
-	EX_LD(LOAD(ldub, %o1 + 0x02, %g1), NG4_retl_o2)
+	 EX_ST(STORE(stb, %g1, %o0 + 0x01), memcpy_retl_o2_plus_1)
+	EX_LD(LOAD(ldub, %o1 + 0x02, %g1), memcpy_retl_o2)
 	ba,pt		%icc, .Lexit
-	 EX_ST(STORE(stb, %g1, %o0 + 0x02), NG4_retl_o2)
+	 EX_ST(STORE(stb, %g1, %o0 + 0x02), memcpy_retl_o2)
 
 .Lsmall:
 	andcc		%g2, 0x3, %g0
@@ -363,23 +363,23 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	 andn		%o2, 0x4 - 1, %o5
 	sub		%o2, %o5, %o2
 1:
-	EX_LD(LOAD(lduw, %o1 + 0x00, %g1), NG4_retl_o2_plus_o5)
+	EX_LD(LOAD(lduw, %o1 + 0x00, %g1), memcpy_retl_o2_plus_o5)
 	add		%o1, 0x04, %o1
 	subcc		%o5, 0x04, %o5
 	add		%o0, 0x04, %o0
 	bne,pt		%icc, 1b
-	 EX_ST(STORE(stw, %g1, %o0 - 0x04), NG4_retl_o2_plus_o5_plus_4)
+	 EX_ST(STORE(stw, %g1, %o0 - 0x04), memcpy_retl_o2_plus_o5_plus_4)
 	brz,pt		%o2, .Lexit
 	 nop
 	ba,a,pt		%icc, .Ltiny
 
 .Lsmall_unaligned:
-1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g1), NG4_retl_o2)
+1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g1), memcpy_retl_o2)
 	add		%o1, 1, %o1
 	add		%o0, 1, %o0
 	subcc		%o2, 1, %o2
 	bne,pt		%icc, 1b
-	 EX_ST(STORE(stb, %g1, %o0 - 0x01), NG4_retl_o2_plus_1)
+	 EX_ST(STORE(stb, %g1, %o0 - 0x01), memcpy_retl_o2_plus_1)
 	ba,a,pt		%icc, .Lexit
 	 nop
 	.size		FUNC_NAME, .-FUNC_NAME
-- 
1.7.1

