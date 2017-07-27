From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 27 Jul 2017 21:57:30 +0000
Subject: [PATCH RFC 4/4] arch/sparc: Add accurate exception reporting in M7memcpy
Message-Id: <1501192650-1043374-4-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1501192650-1043374-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1501192650-1043374-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, babu.moger@oracle.com

Add accurate exception reporting in M7memcpy

Signed-off-by: Babu Moger <babu.moger@oracle.com>
---
 arch/sparc/lib/M7copy_from_user.S |   11 +-
 arch/sparc/lib/M7copy_to_user.S   |   10 +-
 arch/sparc/lib/M7memcpy.S         |  396 ++++++++++++++++++------------------
 arch/sparc/lib/Memcpy_utils.S     |  182 +++++++++++++++++
 4 files changed, 390 insertions(+), 209 deletions(-)

diff --git a/arch/sparc/lib/M7copy_from_user.S b/arch/sparc/lib/M7copy_from_user.S
index d0689d7..66464b3 100644
--- a/arch/sparc/lib/M7copy_from_user.S
+++ b/arch/sparc/lib/M7copy_from_user.S
@@ -5,23 +5,22 @@
  */
 
 
-#define EX_LD(x)			\
+#define EX_LD(x, y)			\
 98:	x;				\
 	.section __ex_table,"a";	\
 	.align 4;			\
-	.word 98b, __restore_asi;	\
+	.word 98b, y;			\
 	.text;				\
 	.align 4;
 
-#define EX_LD_FP(x)			\
+#define EX_LD_FP(x, y)			\
 98:	x;				\
 	.section __ex_table,"a";	\
 	.align 4;			\
-	.word 98b, __restore_asi_fp;	\
+	.word 98b, y##_fp;		\
 	.text;				\
 	.align 4;
 
-
 #ifndef ASI_AIUS
 #define ASI_AIUS	0x11
 #endif
@@ -35,7 +34,7 @@
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
 	bne,pn		%icc, raw_copy_in_user;		\
-	nop
+	 nop
 #endif
 
 #include "M7memcpy.S"
diff --git a/arch/sparc/lib/M7copy_to_user.S b/arch/sparc/lib/M7copy_to_user.S
index d3be132..a60ac46 100644
--- a/arch/sparc/lib/M7copy_to_user.S
+++ b/arch/sparc/lib/M7copy_to_user.S
@@ -5,19 +5,19 @@
  */
 
 
-#define EX_ST(x)			\
+#define EX_ST(x, y)			\
 98:	x;				\
 	.section __ex_table,"a";	\
 	.align 4;			\
-	.word 98b, __restore_asi;	\
+	.word 98b, y;			\
 	.text;				\
 	.align 4;
 
-#define EX_ST_FP(x)			\
+#define EX_ST_FP(x, y)			\
 98:	x;				\
 	.section __ex_table,"a";	\
 	.align 4;			\
-	.word 98b, __restore_asi_fp;	\
+	.word 98b, y##_fp;		\
 	.text;				\
 	.align 4;
 
@@ -45,7 +45,7 @@
 	rd		%asi, %g1;			\
 	cmp		%g1, ASI_AIUS;			\
 	bne,pn		%icc, raw_copy_in_user;		\
-	nop
+	 nop
 #endif
 
 #include "M7memcpy.S"
diff --git a/arch/sparc/lib/M7memcpy.S b/arch/sparc/lib/M7memcpy.S
index d49f702..5cb3dae 100644
--- a/arch/sparc/lib/M7memcpy.S
+++ b/arch/sparc/lib/M7memcpy.S
@@ -96,17 +96,17 @@
 #endif
 
 #ifndef EX_LD
-#define EX_LD(x)	x
+#define EX_LD(x,y)	x
 #endif
 #ifndef EX_LD_FP
-#define EX_LD_FP(x)	x
+#define EX_LD_FP(x,y)	x
 #endif
 
 #ifndef EX_ST
-#define EX_ST(x)	x
+#define EX_ST(x,y)	x
 #endif
 #ifndef EX_ST_FP
-#define EX_ST_FP(x)	x
+#define EX_ST_FP(x,y)	x
 #endif
 
 #ifndef EX_RETVAL
@@ -207,9 +207,9 @@ FUNC_NAME:
 	sub	%o1, %o0, %o1		! %o1 gets the difference
 7:					! dst aligning loop
 	add	%o1, %o0, %o4
-	EX_LD(LOAD(ldub, %o4, %o4))	! load one byte
+	EX_LD(LOAD(ldub, %o4, %o4), memcpy_retl_o2_plus_o5)	! load one byte
 	subcc	%o5, 1, %o5
-	EX_ST(STORE(stb, %o4, %o0))
+	EX_ST(STORE(stb, %o4, %o0), memcpy_retl_o2_plus_o5_plus_1)
 	bgu,pt	%ncc, 7b
 	 add	%o0, 1, %o0		! advance dst
 	add	%o1, %o0, %o1		! restore %o1
@@ -234,64 +234,64 @@ FUNC_NAME:
 	ble,pn	%ncc, .Lmedl63		! skip big loop if less than 64 bytes
 	 nop
 .Lmedl64:
-	EX_LD(LOAD(ldx, %o1, %o4))	! load
+	EX_LD(LOAD(ldx, %o1, %o4), memcpy_retl_o2_plus_63)	! load
 	subcc	%o2, 64, %o2		! decrement length count
-	EX_ST(STORE(stx, %o4, %o0))	! and store
-	EX_LD(LOAD(ldx, %o1+8, %o3))	! a block of 64 bytes
-	EX_ST(STORE(stx, %o3, %o0+8))
-	EX_LD(LOAD(ldx, %o1+16, %o4))
-	EX_ST(STORE(stx, %o4, %o0+16))
-	EX_LD(LOAD(ldx, %o1+24, %o3))
-	EX_ST(STORE(stx, %o3, %o0+24))
-	EX_LD(LOAD(ldx, %o1+32, %o4))	! load
-	EX_ST(STORE(stx, %o4, %o0+32))	! and store
-	EX_LD(LOAD(ldx, %o1+40, %o3))	! a block of 64 bytes
+	EX_ST(STORE(stx, %o4, %o0), memcpy_retl_o2_plus_63_64)	! and store
+	EX_LD(LOAD(ldx, %o1+8, %o3), memcpy_retl_o2_plus_63_56)	! a block of 64
+	EX_ST(STORE(stx, %o3, %o0+8), memcpy_retl_o2_plus_63_56)
+	EX_LD(LOAD(ldx, %o1+16, %o4), memcpy_retl_o2_plus_63_48)
+	EX_ST(STORE(stx, %o4, %o0+16), memcpy_retl_o2_plus_63_48)
+	EX_LD(LOAD(ldx, %o1+24, %o3), memcpy_retl_o2_plus_63_40)
+	EX_ST(STORE(stx, %o3, %o0+24), memcpy_retl_o2_plus_63_40)
+	EX_LD(LOAD(ldx, %o1+32, %o4), memcpy_retl_o2_plus_63_32)! load and store
+	EX_ST(STORE(stx, %o4, %o0+32), memcpy_retl_o2_plus_63_32)
+	EX_LD(LOAD(ldx, %o1+40, %o3), memcpy_retl_o2_plus_63_24)! a block of 64
 	add	%o1, 64, %o1		! increase src ptr by 64
-	EX_ST(STORE(stx, %o3, %o0+40))
-	EX_LD(LOAD(ldx, %o1-16, %o4))
+	EX_ST(STORE(stx, %o3, %o0+40), memcpy_retl_o2_plus_63_24)
+	EX_LD(LOAD(ldx, %o1-16, %o4), memcpy_retl_o2_plus_63_16)
 	add	%o0, 64, %o0		! increase dst ptr by 64
-	EX_ST(STORE(stx, %o4, %o0-16))
-	EX_LD(LOAD(ldx, %o1-8, %o3))
+	EX_ST(STORE(stx, %o4, %o0-16), memcpy_retl_o2_plus_63_16)
+	EX_LD(LOAD(ldx, %o1-8, %o3), memcpy_retl_o2_plus_63_8)
 	bgu,pt	%ncc, .Lmedl64		! repeat if at least 64 bytes left
-	 EX_ST(STORE(stx, %o3, %o0-8))
+	 EX_ST(STORE(stx, %o3, %o0-8), memcpy_retl_o2_plus_63_8)
 .Lmedl63:
 	addcc	%o2, 32, %o2		! adjust remaining count
 	ble,pt	%ncc, .Lmedl31		! to skip if 31 or fewer bytes left
 	 nop
-	EX_LD(LOAD(ldx, %o1, %o4))	! load
+	EX_LD(LOAD(ldx, %o1, %o4), memcpy_retl_o2_plus_31)	! load
 	sub	%o2, 32, %o2		! decrement length count
-	EX_ST(STORE(stx, %o4, %o0))	! and store
-	EX_LD(LOAD(ldx, %o1+8, %o3))	! a block of 32 bytes
+	EX_ST(STORE(stx, %o4, %o0), memcpy_retl_o2_plus_31_32)	! and store
+	EX_LD(LOAD(ldx, %o1+8, %o3), memcpy_retl_o2_plus_31_24)	! a block of 32
 	add	%o1, 32, %o1		! increase src ptr by 32
-	EX_ST(STORE(stx, %o3, %o0+8))
-	EX_LD(LOAD(ldx, %o1-16, %o4))
+	EX_ST(STORE(stx, %o3, %o0+8), memcpy_retl_o2_plus_31_24)
+	EX_LD(LOAD(ldx, %o1-16, %o4), memcpy_retl_o2_plus_31_16)
 	add	%o0, 32, %o0		! increase dst ptr by 32
-	EX_ST(STORE(stx, %o4, %o0-16))
-	EX_LD(LOAD(ldx, %o1-8, %o3))
-	EX_ST(STORE(stx, %o3, %o0-8))
+	EX_ST(STORE(stx, %o4, %o0-16), memcpy_retl_o2_plus_31_16)
+	EX_LD(LOAD(ldx, %o1-8, %o3), memcpy_retl_o2_plus_31_8)
+	EX_ST(STORE(stx, %o3, %o0-8), memcpy_retl_o2_plus_31_8)
 .Lmedl31:
 	addcc	%o2, 16, %o2		! adjust remaining count
 	ble,pt	%ncc, .Lmedl15		! skip if 15 or fewer bytes left
 	 nop				!
-	EX_LD(LOAD(ldx, %o1, %o4))
+	EX_LD(LOAD(ldx, %o1, %o4), memcpy_retl_o2_plus_15)
 	add	%o1, 16, %o1		! increase src ptr by 16
-	EX_ST(STORE(stx, %o4, %o0))
+	EX_ST(STORE(stx, %o4, %o0), memcpy_retl_o2_plus_15)
 	sub	%o2, 16, %o2		! decrease count by 16
-	EX_LD(LOAD(ldx, %o1-8, %o3))
+	EX_LD(LOAD(ldx, %o1-8, %o3), memcpy_retl_o2_plus_15_8)
 	add	%o0, 16, %o0		! increase dst ptr by 16
-	EX_ST(STORE(stx, %o3, %o0-8))
+	EX_ST(STORE(stx, %o3, %o0-8), memcpy_retl_o2_plus_15_8)
 .Lmedl15:
 	addcc	%o2, 15, %o2		! restore count
 	bz,pt	%ncc, .Lsmallx	! exit if finished
 	 cmp	%o2, 8
 	blt,pt	%ncc, .Lmedw7		! skip if 7 or fewer bytes left
 	 tst	%o2
-	EX_LD(LOAD(ldx, %o1, %o4))	! load 8 bytes
+	EX_LD(LOAD(ldx, %o1, %o4), memcpy_retl_o2)	! load 8 bytes
 	add	%o1, 8, %o1		! increase src ptr by 8
 	add	%o0, 8, %o0		! increase dst ptr by 8
 	subcc	%o2, 8, %o2		! decrease count by 8
 	bnz,pn	%ncc, .Lmedw7
-	EX_ST(STORE(stx, %o4, %o0-8))	! and store 8 bytes
+	 EX_ST(STORE(stx, %o4, %o0-8), memcpy_retl_o2_plus_8)	! and store 8
 	retl
 	 mov	EX_RETVAL(%g1), %o0	! restore %o0
 
@@ -319,30 +319,30 @@ FUNC_NAME:
 					! for end of loop
 	ble,pt	%ncc, .Lmedw31		! skip big loop if less than 16
 .Lmedw32:
-	EX_LD(LOAD(ld, %o1, %o4))	! move a block of 32 bytes
+	EX_LD(LOAD(ld, %o1, %o4), memcpy_retl_o2_plus_31)! move a block of 32
 	sllx	%o4, 32, %o5
-	EX_LD(LOAD(ld, %o1+4, %o4))
+	EX_LD(LOAD(ld, %o1+4, %o4), memcpy_retl_o2_plus_31)
 	or	%o4, %o5, %o5
-	EX_ST(STORE(stx, %o5, %o0))
+	EX_ST(STORE(stx, %o5, %o0), memcpy_retl_o2_plus_31)
 	subcc	%o2, 32, %o2		! decrement length count
-	EX_LD(LOAD(ld, %o1+8, %o4))
+	EX_LD(LOAD(ld, %o1+8, %o4), memcpy_retl_o2_plus_31_24)
 	sllx	%o4, 32, %o5
-	EX_LD(LOAD(ld, %o1+12, %o4))
+	EX_LD(LOAD(ld, %o1+12, %o4), memcpy_retl_o2_plus_31_24)
 	or	%o4, %o5, %o5
-	EX_ST(STORE(stx, %o5, %o0+8))
+	EX_ST(STORE(stx, %o5, %o0+8), memcpy_retl_o2_plus_31_24)
 	add	%o1, 32, %o1		! increase src ptr by 32
-	EX_LD(LOAD(ld, %o1-16, %o4))
+	EX_LD(LOAD(ld, %o1-16, %o4), memcpy_retl_o2_plus_31_16)
 	sllx	%o4, 32, %o5
-	EX_LD(LOAD(ld, %o1-12, %o4))
+	EX_LD(LOAD(ld, %o1-12, %o4), memcpy_retl_o2_plus_31_16)
 	or	%o4, %o5, %o5
-	EX_ST(STORE(stx, %o5, %o0+16))
+	EX_ST(STORE(stx, %o5, %o0+16), memcpy_retl_o2_plus_31_16)
 	add	%o0, 32, %o0		! increase dst ptr by 32
-	EX_LD(LOAD(ld, %o1-8, %o4))
+	EX_LD(LOAD(ld, %o1-8, %o4), memcpy_retl_o2_plus_31_8)
 	sllx	%o4, 32, %o5
-	EX_LD(LOAD(ld, %o1-4, %o4))
+	EX_LD(LOAD(ld, %o1-4, %o4), memcpy_retl_o2_plus_31_8)
 	or	%o4, %o5, %o5
 	bgu,pt	%ncc, .Lmedw32		! repeat if at least 32 bytes left
-	 EX_ST(STORE(stx, %o5, %o0-8))
+	 EX_ST(STORE(stx, %o5, %o0-8), memcpy_retl_o2_plus_31_8)
 .Lmedw31:
 	addcc	%o2, 31, %o2		! restore count
 
@@ -351,42 +351,42 @@ FUNC_NAME:
 	cmp	%o2, 16
 	blt,pt	%ncc, .Lmedw15
 	 nop
-	EX_LD(LOAD(ld, %o1, %o4))	! move a block of 16 bytes
+	EX_LD(LOAD(ld, %o1, %o4), memcpy_retl_o2)! move a block of 16 bytes
 	sllx	%o4, 32, %o5
 	subcc	%o2, 16, %o2		! decrement length count
-	EX_LD(LOAD(ld, %o1+4, %o4))
+	EX_LD(LOAD(ld, %o1+4, %o4), memcpy_retl_o2_plus_16)
 	or	%o4, %o5, %o5
-	EX_ST(STORE(stx, %o5, %o0))
+	EX_ST(STORE(stx, %o5, %o0), memcpy_retl_o2_plus_16)
 	add	%o1, 16, %o1		! increase src ptr by 16
-	EX_LD(LOAD(ld, %o1-8, %o4))
+	EX_LD(LOAD(ld, %o1-8, %o4), memcpy_retl_o2_plus_8)
 	add	%o0, 16, %o0		! increase dst ptr by 16
 	sllx	%o4, 32, %o5
-	EX_LD(LOAD(ld, %o1-4, %o4))
+	EX_LD(LOAD(ld, %o1-4, %o4), memcpy_retl_o2_plus_8)
 	or	%o4, %o5, %o5
-	EX_ST(STORE(stx, %o5, %o0-8))
+	EX_ST(STORE(stx, %o5, %o0-8), memcpy_retl_o2_plus_8)
 .Lmedw15:
 	bz,pt	%ncc, .Lsmallx	! exit if finished
 	 cmp	%o2, 8
 	blt,pn	%ncc, .Lmedw7		! skip if 7 or fewer bytes left
 	 tst	%o2
-	EX_LD(LOAD(ld, %o1, %o4))	! load 4 bytes
+	EX_LD(LOAD(ld, %o1, %o4), memcpy_retl_o2)	! load 4 bytes
 	subcc	%o2, 8, %o2		! decrease count by 8
-	EX_ST(STORE(stw, %o4, %o0))	! and store 4 bytes
+	EX_ST(STORE(stw, %o4, %o0), memcpy_retl_o2_plus_8)! and store 4 bytes
 	add	%o1, 8, %o1		! increase src ptr by 8
-	EX_LD(LOAD(ld, %o1-4, %o3))	! load 4 bytes
+	EX_LD(LOAD(ld, %o1-4, %o3), memcpy_retl_o2_plus_4)	! load 4 bytes
 	add	%o0, 8, %o0		! increase dst ptr by 8
-	EX_ST(STORE(stw, %o3, %o0-4))	! and store 4 bytes
+	EX_ST(STORE(stw, %o3, %o0-4), memcpy_retl_o2_plus_4)! and store 4 bytes
 	bz,pt	%ncc, .Lsmallx	! exit if finished
 .Lmedw7:				! count is ge 1, less than 8
 	cmp	%o2, 4			! check for 4 bytes left
 	blt,pn	%ncc, .Lsmallleft3	! skip if 3 or fewer bytes left
 	 nop				!
-	EX_LD(LOAD(ld, %o1, %o4))	! load 4 bytes
+	EX_LD(LOAD(ld, %o1, %o4), memcpy_retl_o2)	! load 4 bytes
 	add	%o1, 4, %o1		! increase src ptr by 4
 	add	%o0, 4, %o0		! increase dst ptr by 4
 	subcc	%o2, 4, %o2		! decrease count by 4
 	bnz	.Lsmallleft3
-	 EX_ST(STORE(stw, %o4, %o0-4))! and store 4 bytes
+	 EX_ST(STORE(stw, %o4, %o0-4), memcpy_retl_o2_plus_4)! and store 4 bytes
 	retl
 	 mov	EX_RETVAL(%g1), %o0
 
@@ -398,37 +398,37 @@ FUNC_NAME:
 	 andcc	%o0, 8, %o3		! odd long words to move?
 	brz,pt	%o3, .Laligned_to_16
 	 nop
-	EX_LD(LOAD(ldx, %o1, %o4))
+	EX_LD(LOAD(ldx, %o1, %o4), memcpy_retl_o2)
 	sub	%o2, 8, %o2
 	add	%o1, 8, %o1		! increment src ptr
 	add	%o0, 8, %o0		! increment dst ptr
-	EX_ST(STORE(stx, %o4, %o0-8))
+	EX_ST(STORE(stx, %o4, %o0-8), memcpy_retl_o2_plus_8)
 .Laligned_to_16:
 	andcc	%o0, 16, %o3		! pair of long words to move?
 	brz,pt	%o3, .Laligned_to_32
 	 nop
-	EX_LD(LOAD(ldx, %o1, %o4))
+	EX_LD(LOAD(ldx, %o1, %o4), memcpy_retl_o2)
 	sub	%o2, 16, %o2
-	EX_ST(STORE(stx, %o4, %o0))
+	EX_ST(STORE(stx, %o4, %o0), memcpy_retl_o2_plus_16)
 	add	%o1, 16, %o1		! increment src ptr
-	EX_LD(LOAD(ldx, %o1-8, %o4))
+	EX_LD(LOAD(ldx, %o1-8, %o4), memcpy_retl_o2_plus_8)
 	add	%o0, 16, %o0		! increment dst ptr
-	EX_ST(STORE(stx, %o4, %o0-8))
+	EX_ST(STORE(stx, %o4, %o0-8), memcpy_retl_o2_plus_8)
 .Laligned_to_32:
 	andcc	%o0, 32, %o3		! four long words to move?
 	brz,pt	%o3, .Laligned_to_64
 	 nop
-	EX_LD(LOAD(ldx, %o1, %o4))
+	EX_LD(LOAD(ldx, %o1, %o4), memcpy_retl_o2)
 	sub	%o2, 32, %o2
-	EX_ST(STORE(stx, %o4, %o0))
-	EX_LD(LOAD(ldx, %o1+8, %o4))
-	EX_ST(STORE(stx, %o4, %o0+8))
-	EX_LD(LOAD(ldx, %o1+16, %o4))
-	EX_ST(STORE(stx, %o4, %o0+16))
+	EX_ST(STORE(stx, %o4, %o0), memcpy_retl_o2_plus_32)
+	EX_LD(LOAD(ldx, %o1+8, %o4), memcpy_retl_o2_plus_24)
+	EX_ST(STORE(stx, %o4, %o0+8), memcpy_retl_o2_plus_24)
+	EX_LD(LOAD(ldx, %o1+16, %o4), memcpy_retl_o2_plus_16)
+	EX_ST(STORE(stx, %o4, %o0+16), memcpy_retl_o2_plus_16)
 	add	%o1, 32, %o1		! increment src ptr
-	EX_LD(LOAD(ldx, %o1-8, %o4))
+	EX_LD(LOAD(ldx, %o1-8, %o4), memcpy_retl_o2_plus_8)
 	add	%o0, 32, %o0		! increment dst ptr
-	EX_ST(STORE(stx, %o4, %o0-8))
+	EX_ST(STORE(stx, %o4, %o0-8), memcpy_retl_o2_plus_8)
 .Laligned_to_64:
 !
 !	Using block init store (BIS) instructions to avoid fetching cache
@@ -462,10 +462,10 @@ FUNC_NAME:
 .Lalign_loop_start:
 	prefetch [%o1 + (ALIGN_PRE * BLOCK_SIZE)], 21
 	subcc	%o3, 1, %o3
-	EX_LD(LOAD(ldx, %o1, %o4))
+	EX_LD(LOAD(ldx, %o1, %o4), memcpy_retl_o2_plus_o5)
 	add	%o1, 64, %o1
 	add	%o0, 8, %o0
-	EX_ST(STORE_INIT_MRU(%o4, %o0))
+	EX_ST(STORE_INIT_MRU(%o4, %o0), memcpy_retl_o2_plus_o5)
 	bgu	%ncc,.Lalign_loop_start
 	 add	%o0, 56, %o0
 
@@ -475,32 +475,32 @@ FUNC_NAME:
 	sub	%o0, %o4, %o0		! reset %o0
 
 .Lalign_loop_rest:
-	EX_LD(LOAD(ldx, %o1+8, %o4))
+	EX_LD(LOAD(ldx, %o1+8, %o4), memcpy_retl_o2_plus_o5)
 	add	%o0, 16, %o0
-	EX_ST(STORE_INIT_MRU(%o4, %o0))
-	EX_LD(LOAD(ldx, %o1+16, %o4))
+	EX_ST(STORE_INIT_MRU(%o4, %o0), memcpy_retl_o2_plus_o5)
+	EX_LD(LOAD(ldx, %o1+16, %o4), memcpy_retl_o2_plus_o5)
 	add	%o0, 8, %o0
-	EX_ST(STORE_INIT_MRU(%o4, %o0))
+	EX_ST(STORE_INIT_MRU(%o4, %o0), memcpy_retl_o2_plus_o5)
 	subcc	%o3, 1, %o3
-	EX_LD(LOAD(ldx, %o1+24, %o4))
+	EX_LD(LOAD(ldx, %o1+24, %o4), memcpy_retl_o2_plus_o5)
 	add	%o0, 8, %o0
-	EX_ST(STORE_INIT_MRU(%o4, %o0))
-	EX_LD(LOAD(ldx, %o1+32, %o4))
+	EX_ST(STORE_INIT_MRU(%o4, %o0), memcpy_retl_o2_plus_o5)
+	EX_LD(LOAD(ldx, %o1+32, %o4), memcpy_retl_o2_plus_o5)
 	add	%o0, 8, %o0
-	EX_ST(STORE_INIT_MRU(%o4, %o0))
-	EX_LD(LOAD(ldx, %o1+40, %o4))
+	EX_ST(STORE_INIT_MRU(%o4, %o0), memcpy_retl_o2_plus_o5)
+	EX_LD(LOAD(ldx, %o1+40, %o4), memcpy_retl_o2_plus_o5)
 	add	%o0, 8, %o0
-	EX_ST(STORE_INIT_MRU(%o4, %o0))
-	EX_LD(LOAD(ldx, %o1+48, %o4))
+	EX_ST(STORE_INIT_MRU(%o4, %o0), memcpy_retl_o2_plus_o5)
+	EX_LD(LOAD(ldx, %o1+48, %o4), memcpy_retl_o2_plus_o5)
 	add	%o1, 64, %o1
 	add	%o0, 8, %o0
-	EX_ST(STORE_INIT_MRU(%o4, %o0))
+	EX_ST(STORE_INIT_MRU(%o4, %o0), memcpy_retl_o2_plus_o5)
 	add	%o0, 8, %o0
-	EX_LD(LOAD(ldx, %o1-8, %o4))
+	EX_LD(LOAD(ldx, %o1-8, %o4), memcpy_retl_o2_plus_o5)
 	sub	%o5, 64, %o5
 	bgu	%ncc,.Lalign_loop_rest
 	! mark cache line as LRU
-	 EX_ST(STORE_INIT(%o4, %o0))
+	 EX_ST(STORE_INIT(%o4, %o0), memcpy_retl_o2_plus_o5_plus_64)
 
 	cmp	%o5, ST_CHUNK*64
 	bgu,pt	%ncc, .Lalign_loop_start
@@ -510,26 +510,26 @@ FUNC_NAME:
 	beq	.Lalign_done
 	 nop
 .Lalign_loop_fin:
-	EX_LD(LOAD(ldx, %o1, %o4))
-	EX_ST(STORE(stx, %o4, %o0+8))
-	EX_LD(LOAD(ldx, %o1+8, %o4))
-	EX_ST(STORE(stx, %o4, %o0+8+8))
-	EX_LD(LOAD(ldx, %o1+16, %o4))
-	EX_ST(STORE(stx, %o4, %o0+8+16))
+	EX_LD(LOAD(ldx, %o1, %o4), memcpy_retl_o2_plus_o5)
+	EX_ST(STORE(stx, %o4, %o0+8), memcpy_retl_o2_plus_o5)
+	EX_LD(LOAD(ldx, %o1+8, %o4), memcpy_retl_o2_plus_o5)
+	EX_ST(STORE(stx, %o4, %o0+8+8), memcpy_retl_o2_plus_o5)
+	EX_LD(LOAD(ldx, %o1+16, %o4), memcpy_retl_o2_plus_o5)
+	EX_ST(STORE(stx, %o4, %o0+8+16), memcpy_retl_o2_plus_o5)
 	subcc	%o5, 64, %o5
-	EX_LD(LOAD(ldx, %o1+24, %o4))
-	EX_ST(STORE(stx, %o4, %o0+8+24))
-	EX_LD(LOAD(ldx, %o1+32, %o4))
-	EX_ST(STORE(stx, %o4, %o0+8+32))
-	EX_LD(LOAD(ldx, %o1+40, %o4))
-	EX_ST(STORE(stx, %o4, %o0+8+40))
-	EX_LD(LOAD(ldx, %o1+48, %o4))
+	EX_LD(LOAD(ldx, %o1+24, %o4), memcpy_retl_o2_plus_o5_64)
+	EX_ST(STORE(stx, %o4, %o0+8+24), memcpy_retl_o2_plus_o5_64)
+	EX_LD(LOAD(ldx, %o1+32, %o4), memcpy_retl_o2_plus_o5_64)
+	EX_ST(STORE(stx, %o4, %o0+8+32), memcpy_retl_o2_plus_o5_64)
+	EX_LD(LOAD(ldx, %o1+40, %o4), memcpy_retl_o2_plus_o5_64)
+	EX_ST(STORE(stx, %o4, %o0+8+40), memcpy_retl_o2_plus_o5_64)
+	EX_LD(LOAD(ldx, %o1+48, %o4), memcpy_retl_o2_plus_o5_64)
 	add	%o1, 64, %o1
-	EX_ST(STORE(stx, %o4, %o0+8+48))
+	EX_ST(STORE(stx, %o4, %o0+8+48), memcpy_retl_o2_plus_o5_64)
 	add	%o0, 64, %o0
-	EX_LD(LOAD(ldx, %o1-8, %o4))
+	EX_LD(LOAD(ldx, %o1-8, %o4), memcpy_retl_o2_plus_o5_64)
 	bgu	%ncc,.Lalign_loop_fin
-	 EX_ST(STORE(stx, %o4, %o0))
+	 EX_ST(STORE(stx, %o4, %o0), memcpy_retl_o2_plus_o5_64)
 
 .Lalign_done:
 	add	%o0, 8, %o0		! restore %o0 from ASI alignment
@@ -564,34 +564,34 @@ FUNC_NAME:
 .Lunalign_adjust:
 	alignaddr %o1, %g0, %g0		! generate %gsr
 	add	%o1, %o5, %o1		! advance %o1 to after blocks
-	EX_LD_FP(LOAD(ldd, %o4, %f0))
+	EX_LD_FP(LOAD(ldd, %o4, %f0), memcpy_retl_o2_plus_o5)
 .Lunalign_loop:
-	EX_LD_FP(LOAD(ldd, %o4+8, %f2))
+	EX_LD_FP(LOAD(ldd, %o4+8, %f2), memcpy_retl_o2_plus_o5)
 	faligndata %f0, %f2, %f16
-	EX_LD_FP(LOAD(ldd, %o4+16, %f4))
+	EX_LD_FP(LOAD(ldd, %o4+16, %f4), memcpy_retl_o2_plus_o5)
 	subcc	%o5, BLOCK_SIZE, %o5
-	EX_ST_FP(STORE(std, %f16, %o0))
+	EX_ST_FP(STORE(std, %f16, %o0), memcpy_retl_o2_plus_o5_plus_64)
 	faligndata %f2, %f4, %f18
-	EX_LD_FP(LOAD(ldd, %o4+24, %f6))
-	EX_ST_FP(STORE(std, %f18, %o0+8))
+	EX_LD_FP(LOAD(ldd, %o4+24, %f6), memcpy_retl_o2_plus_o5_plus_56)
+	EX_ST_FP(STORE(std, %f18, %o0+8), memcpy_retl_o2_plus_o5_plus_56)
 	faligndata %f4, %f6, %f20
-	EX_LD_FP(LOAD(ldd, %o4+32, %f8))
-	EX_ST_FP(STORE(std, %f20, %o0+16))
+	EX_LD_FP(LOAD(ldd, %o4+32, %f8), memcpy_retl_o2_plus_o5_plus_48)
+	EX_ST_FP(STORE(std, %f20, %o0+16), memcpy_retl_o2_plus_o5_plus_48)
 	faligndata %f6, %f8, %f22
-	EX_LD_FP(LOAD(ldd, %o4+40, %f10))
-	EX_ST_FP(STORE(std, %f22, %o0+24))
+	EX_LD_FP(LOAD(ldd, %o4+40, %f10), memcpy_retl_o2_plus_o5_plus_40)
+	EX_ST_FP(STORE(std, %f22, %o0+24), memcpy_retl_o2_plus_o5_plus_40)
 	faligndata %f8, %f10, %f24
-	EX_LD_FP(LOAD(ldd, %o4+48, %f12))
-	EX_ST_FP(STORE(std, %f24, %o0+32))
+	EX_LD_FP(LOAD(ldd, %o4+48, %f12), memcpy_retl_o2_plus_o5_plus_32)
+	EX_ST_FP(STORE(std, %f24, %o0+32), memcpy_retl_o2_plus_o5_plus_32)
 	faligndata %f10, %f12, %f26
-	EX_LD_FP(LOAD(ldd, %o4+56, %f14))
+	EX_LD_FP(LOAD(ldd, %o4+56, %f14), memcpy_retl_o2_plus_o5_plus_24)
 	add	%o4, BLOCK_SIZE, %o4
-	EX_ST_FP(STORE(std, %f26, %o0+40))
+	EX_ST_FP(STORE(std, %f26, %o0+40), memcpy_retl_o2_plus_o5_plus_24)
 	faligndata %f12, %f14, %f28
-	EX_LD_FP(LOAD(ldd, %o4, %f0))
-	EX_ST_FP(STORE(std, %f28, %o0+48))
+	EX_LD_FP(LOAD(ldd, %o4, %f0), memcpy_retl_o2_plus_o5_plus_16)
+	EX_ST_FP(STORE(std, %f28, %o0+48), memcpy_retl_o2_plus_o5_plus_16)
 	faligndata %f14, %f0, %f30
-	EX_ST_FP(STORE(std, %f30, %o0+56))
+	EX_ST_FP(STORE(std, %f30, %o0+56), memcpy_retl_o2_plus_o5_plus_8)
 	add	%o0, BLOCK_SIZE, %o0
 	bgu,pt	%ncc, .Lunalign_loop
 	 prefetch [%o4 + (5 * BLOCK_SIZE)], 20
@@ -613,27 +613,27 @@ FUNC_NAME:
 	 nop
 	! Src is word aligned
 .Lunalignword:
-	EX_LD_FP(LOAD(ld, %o1, %o4))	! load 4 bytes
+	EX_LD_FP(LOAD(ld, %o1, %o4), memcpy_retl_o2_plus_o3)	! load 4 bytes
 	add	%o1, 8, %o1		! increase src ptr by 8
-	EX_ST_FP(STORE(stw, %o4, %o0))	! and store 4 bytes
+	EX_ST_FP(STORE(stw, %o4, %o0), memcpy_retl_o2_plus_o3)	! and store 4
 	subcc	%o3, 8, %o3		! decrease count by 8
-	EX_LD_FP(LOAD(ld, %o1-4, %o4))	! load 4 bytes
+	EX_LD_FP(LOAD(ld, %o1-4, %o4), memcpy_retl_o2_plus_o3_plus_4)! load 4
 	add	%o0, 8, %o0		! increase dst ptr by 8
 	bnz	%ncc, .Lunalignword
-	 EX_ST_FP(STORE(stw, %o4, %o0-4))! and store 4 bytes
+	 EX_ST_FP(STORE(stw, %o4, %o0-4), memcpy_retl_o2_plus_o3_plus_4)
 	ba	.Lunalignsrc
 	 nop
 
 	! Src is half-word aligned
 .Lunalignhalf:
-	EX_LD_FP(LOAD(lduh, %o1, %o4))	! load 2 bytes
+	EX_LD_FP(LOAD(lduh, %o1, %o4), memcpy_retl_o2_plus_o3)	! load 2 bytes
 	sllx	%o4, 32, %o5		! shift left
-	EX_LD_FP(LOAD(lduw, %o1+2, %o4))
+	EX_LD_FP(LOAD(lduw, %o1+2, %o4), memcpy_retl_o2_plus_o3)
 	or	%o4, %o5, %o5
 	sllx	%o5, 16, %o5
-	EX_LD_FP(LOAD(lduh, %o1+6, %o4))
+	EX_LD_FP(LOAD(lduh, %o1+6, %o4), memcpy_retl_o2_plus_o3)
 	or	%o4, %o5, %o5
-	EX_ST_FP(STORE(stx, %o5, %o0))
+	EX_ST_FP(STORE(stx, %o5, %o0), memcpy_retl_o2_plus_o3)
 	add	%o1, 8, %o1
 	subcc	%o3, 8, %o3
 	bnz	%ncc, .Lunalignhalf
@@ -645,21 +645,21 @@ FUNC_NAME:
 .Lunalignbyte:
 	sub	%o0, %o1, %o0		! share pointer advance
 .Lunalignbyte_loop:
-	EX_LD_FP(LOAD(ldub, %o1, %o4))
+	EX_LD_FP(LOAD(ldub, %o1, %o4), memcpy_retl_o2_plus_o3)
 	sllx	%o4, 56, %o5
-	EX_LD_FP(LOAD(lduh, %o1+1, %o4))
+	EX_LD_FP(LOAD(lduh, %o1+1, %o4), memcpy_retl_o2_plus_o3)
 	sllx	%o4, 40, %o4
 	or	%o4, %o5, %o5
-	EX_LD_FP(LOAD(lduh, %o1+3, %o4))
+	EX_LD_FP(LOAD(lduh, %o1+3, %o4), memcpy_retl_o2_plus_o3)
 	sllx	%o4, 24, %o4
 	or	%o4, %o5, %o5
-	EX_LD_FP(LOAD(lduh, %o1+5, %o4))
+	EX_LD_FP(LOAD(lduh, %o1+5, %o4), memcpy_retl_o2_plus_o3)
 	sllx	%o4,  8, %o4
 	or	%o4, %o5, %o5
-	EX_LD_FP(LOAD(ldub, %o1+7, %o4))
+	EX_LD_FP(LOAD(ldub, %o1+7, %o4), memcpy_retl_o2_plus_o3)
 	or	%o4, %o5, %o5
 	add	%o0, %o1, %o0
-	EX_ST_FP(STORE(stx, %o5, %o0))
+	EX_ST_FP(STORE(stx, %o5, %o0), memcpy_retl_o2_plus_o3)
 	sub	%o0, %o1, %o0
 	subcc	%o3, 8, %o3
 	bnz	%ncc, .Lunalignbyte_loop
@@ -677,36 +677,36 @@ FUNC_NAME:
 	alignaddr %o1, %g0, %g0		! generate %gsr
 	add	%o1, %o5, %o1		! advance %o1 to after blocks
 
-	EX_LD_FP(LOAD(ldd, %o4, %f14))
+	EX_LD_FP(LOAD(ldd, %o4, %f14), memcpy_retl_o2_plus_o5)
 	add	%o4, 8, %o4
 .Lunalign_sloop:
-	EX_LD_FP(LOAD(ldd, %o4, %f16))
+	EX_LD_FP(LOAD(ldd, %o4, %f16), memcpy_retl_o2_plus_o5)
 	faligndata %f14, %f16, %f0
-	EX_LD_FP(LOAD(ldd, %o4+8, %f18))
+	EX_LD_FP(LOAD(ldd, %o4+8, %f18), memcpy_retl_o2_plus_o5)
 	faligndata %f16, %f18, %f2
-	EX_LD_FP(LOAD(ldd, %o4+16, %f20))
+	EX_LD_FP(LOAD(ldd, %o4+16, %f20), memcpy_retl_o2_plus_o5)
 	faligndata %f18, %f20, %f4
-	EX_ST_FP(STORE(std, %f0, %o0))
+	EX_ST_FP(STORE(std, %f0, %o0), memcpy_retl_o2_plus_o5)
 	subcc	%o5, 64, %o5
-	EX_LD_FP(LOAD(ldd, %o4+24, %f22))
+	EX_LD_FP(LOAD(ldd, %o4+24, %f22), memcpy_retl_o2_plus_o5_plus_56)
 	faligndata %f20, %f22, %f6
-	EX_ST_FP(STORE(std, %f2, %o0+8))
-	EX_LD_FP(LOAD(ldd, %o4+32, %f24))
+	EX_ST_FP(STORE(std, %f2, %o0+8), memcpy_retl_o2_plus_o5_plus_56)
+	EX_LD_FP(LOAD(ldd, %o4+32, %f24), memcpy_retl_o2_plus_o5_plus_48)
 	faligndata %f22, %f24, %f8
-	EX_ST_FP(STORE(std, %f4, %o0+16))
-	EX_LD_FP(LOAD(ldd, %o4+40, %f26))
+	EX_ST_FP(STORE(std, %f4, %o0+16), memcpy_retl_o2_plus_o5_plus_48)
+	EX_LD_FP(LOAD(ldd, %o4+40, %f26), memcpy_retl_o2_plus_o5_plus_40)
 	faligndata %f24, %f26, %f10
-	EX_ST_FP(STORE(std, %f6, %o0+24))
-	EX_LD_FP(LOAD(ldd, %o4+48, %f28))
+	EX_ST_FP(STORE(std, %f6, %o0+24), memcpy_retl_o2_plus_o5_plus_40)
+	EX_LD_FP(LOAD(ldd, %o4+48, %f28), memcpy_retl_o2_plus_o5_plus_40)
 	faligndata %f26, %f28, %f12
-	EX_ST_FP(STORE(std, %f8, %o0+32))
+	EX_ST_FP(STORE(std, %f8, %o0+32), memcpy_retl_o2_plus_o5_plus_40)
 	add	%o4, 64, %o4
-	EX_LD_FP(LOAD(ldd, %o4-8, %f30))
+	EX_LD_FP(LOAD(ldd, %o4-8, %f30), memcpy_retl_o2_plus_o5_plus_40)
 	faligndata %f28, %f30, %f14
-	EX_ST_FP(STORE(std, %f10, %o0+40))
-	EX_ST_FP(STORE(std, %f12, %o0+48))
+	EX_ST_FP(STORE(std, %f10, %o0+40), memcpy_retl_o2_plus_o5_plus_40)
+	EX_ST_FP(STORE(std, %f12, %o0+48), memcpy_retl_o2_plus_o5_plus_40)
 	add	%o0, 64, %o0
-	EX_ST_FP(STORE(std, %f14, %o0-8))
+	EX_ST_FP(STORE(std, %f14, %o0-8), memcpy_retl_o2_plus_o5_plus_40)
 	fsrc2	%f30, %f14
 	bgu,pt	%ncc, .Lunalign_sloop
 	 prefetch [%o4 + (8 * BLOCK_SIZE)], 20
@@ -723,13 +723,13 @@ FUNC_NAME:
 	sub	%o5, 8, %o5		! insure we do not load past end of src
 	andn	%o1, 0x7, %o4		! %o4 has long word aligned src address
 	add	%o1, %o5, %o1		! advance %o1 to after multiple of 8
-	EX_LD_FP(LOAD(ldd, %o4, %f0))	! fetch partial word
+	EX_LD_FP(LOAD(ldd, %o4, %f0), memcpy_retl_o2_plus_o5)! fetch partialword
 .Lunalign_by8:
-	EX_LD_FP(LOAD(ldd, %o4+8, %f2))
+	EX_LD_FP(LOAD(ldd, %o4+8, %f2), memcpy_retl_o2_plus_o5)
 	add	%o4, 8, %o4
 	faligndata %f0, %f2, %f16
 	subcc	%o5, 8, %o5
-	EX_ST_FP(STORE(std, %f16, %o0))
+	EX_ST_FP(STORE(std, %f16, %o0), memcpy_retl_o2_plus_o5)
 	fsrc2	%f2, %f0
 	bgu,pt	%ncc, .Lunalign_by8
 	 add	%o0, 8, %o0
@@ -765,37 +765,37 @@ FUNC_NAME:
 	andncc	%o2, 0x20 - 1, %o5
 	be,pn	%ncc, 2f
 	 sub	%o2, %o5, %o2
-1:	EX_LD(LOAD(ldx, %o1 + 0x00, %o3))
-	EX_LD(LOAD(ldx, %o1 + 0x08, %g2))
-	EX_LD(LOAD(ldx, %o1 + 0x10, %g7))
-	EX_LD(LOAD(ldx, %o1 + 0x18, %o4))
+1:	EX_LD(LOAD(ldx, %o1 + 0x00, %o3), memcpy_retl_o2_plus_o5)
+	EX_LD(LOAD(ldx, %o1 + 0x08, %g2), memcpy_retl_o2_plus_o5)
+	EX_LD(LOAD(ldx, %o1 + 0x10, %g7), memcpy_retl_o2_plus_o5)
+	EX_LD(LOAD(ldx, %o1 + 0x18, %o4), memcpy_retl_o2_plus_o5)
 	add	%o1, 0x20, %o1
 	subcc	%o5, 0x20, %o5
-	EX_ST(STORE(stx, %o3, %o0 + 0x00))
-	EX_ST(STORE(stx, %g2, %o0 + 0x08))
-	EX_ST(STORE(stx, %g7, %o0 + 0x10))
-	EX_ST(STORE(stx, %o4, %o0 + 0x18))
+	EX_ST(STORE(stx, %o3, %o0 + 0x00), memcpy_retl_o2_plus_o5_plus_32)
+	EX_ST(STORE(stx, %g2, %o0 + 0x08), memcpy_retl_o2_plus_o5_plus_24)
+	EX_ST(STORE(stx, %g7, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_24)
+	EX_ST(STORE(stx, %o4, %o0 + 0x18), memcpy_retl_o2_plus_o5_plus_8)
 	bne,pt	%ncc, 1b
 	 add	%o0, 0x20, %o0
 2:	andcc	%o2, 0x18, %o5
 	be,pt	%ncc, 3f
 	 sub	%o2, %o5, %o2
-1:	EX_LD(LOAD(ldx, %o1 + 0x00, %o3))
+1:	EX_LD(LOAD(ldx, %o1 + 0x00, %o3), memcpy_retl_o2_plus_o5)
 	add	%o1, 0x08, %o1
 	add	%o0, 0x08, %o0
 	subcc	%o5, 0x08, %o5
 	bne,pt	%ncc, 1b
-	 EX_ST(STORE(stx, %o3, %o0 - 0x08))
+	 EX_ST(STORE(stx, %o3, %o0 - 0x08), memcpy_retl_o2_plus_o5_plus_8)
 3:	brz,pt	%o2, .Lexit_cp
 	 cmp	%o2, 0x04
 	bl,pn	%ncc, .Ltiny_cp
 	 nop
-	EX_LD(LOAD(lduw, %o1 + 0x00, %o3))
+	EX_LD(LOAD(lduw, %o1 + 0x00, %o3), memcpy_retl_o2)
 	add	%o1, 0x04, %o1
 	add	%o0, 0x04, %o0
 	subcc	%o2, 0x04, %o2
 	bne,pn	%ncc, .Ltiny_cp
-	 EX_ST(STORE(stw, %o3, %o0 - 0x04))
+	 EX_ST(STORE(stw, %o3, %o0 - 0x04), memcpy_retl_o2_plus_4)
 	ba,a,pt	%ncc, .Lexit_cp
 
 .Lmedium_unaligned_cp:
@@ -805,12 +805,12 @@ FUNC_NAME:
 	brz,pt	%o3, 2f
 	 sub	%o2, %o3, %o2
 
-1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2))
+1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2), memcpy_retl_o2_plus_g1)
 	add	%o1, 1, %o1
 	subcc	%o3, 1, %o3
 	add	%o0, 1, %o0
 	bne,pt	%ncc, 1b
-	 EX_ST(STORE(stb, %g2, %o0 - 0x01))
+	 EX_ST(STORE(stb, %g2, %o0 - 0x01), memcpy_retl_o2_plus_g1_plus_1)
 2:
 	and	%o1, 0x7, %o3
 	brz,pn	%o3, .Lmedium_noprefetch_cp
@@ -818,17 +818,17 @@ FUNC_NAME:
 	mov	64, %g2
 	sub	%g2, %o3, %g2
 	andn	%o1, 0x7, %o1
-	EX_LD(LOAD(ldx, %o1 + 0x00, %o4))
+	EX_LD(LOAD(ldx, %o1 + 0x00, %o4), memcpy_retl_o2)
 	sllx	%o4, %o3, %o4
 	andn	%o2, 0x08 - 1, %o5
 	sub	%o2, %o5, %o2
 
-1:	EX_LD(LOAD(ldx, %o1 + 0x08, %g3))
+1:	EX_LD(LOAD(ldx, %o1 + 0x08, %g3), memcpy_retl_o2_plus_o5)
 	add	%o1, 0x08, %o1
 	subcc	%o5, 0x08, %o5
 	srlx	%g3, %g2, %g7
 	or	%g7, %o4, %g7
-	EX_ST(STORE(stx, %g7, %o0 + 0x00))
+	EX_ST(STORE(stx, %g7, %o0 + 0x00), memcpy_retl_o2_plus_o5_plus_8)
 	add	%o0, 0x08, %o0
 	bne,pt	%ncc, 1b
 	 sllx	%g3, %o3, %o4
@@ -839,17 +839,17 @@ FUNC_NAME:
 	ba,pt	%ncc, .Lsmall_unaligned_cp
 
 .Ltiny_cp:
-	EX_LD(LOAD(ldub, %o1 + 0x00, %o3))
+	EX_LD(LOAD(ldub, %o1 + 0x00, %o3), memcpy_retl_o2)
 	subcc	%o2, 1, %o2
 	be,pn	%ncc, .Lexit_cp
-	 EX_ST(STORE(stb, %o3, %o0 + 0x00))
-	EX_LD(LOAD(ldub, %o1 + 0x01, %o3))
+	 EX_ST(STORE(stb, %o3, %o0 + 0x00), memcpy_retl_o2_plus_1)
+	EX_LD(LOAD(ldub, %o1 + 0x01, %o3), memcpy_retl_o2)
 	subcc	%o2, 1, %o2
 	be,pn	%ncc, .Lexit_cp
-	 EX_ST(STORE(stb, %o3, %o0 + 0x01))
-	EX_LD(LOAD(ldub, %o1 + 0x02, %o3))
+	 EX_ST(STORE(stb, %o3, %o0 + 0x01), memcpy_retl_o2_plus_1)
+	EX_LD(LOAD(ldub, %o1 + 0x02, %o3), memcpy_retl_o2)
 	ba,pt	%ncc, .Lexit_cp
-	 EX_ST(STORE(stb, %o3, %o0 + 0x02))
+	 EX_ST(STORE(stb, %o3, %o0 + 0x02), memcpy_retl_o2)
 
 .Lsmall_cp:
 	andcc	%g2, 0x3, %g0
@@ -857,23 +857,23 @@ FUNC_NAME:
 	 andn	%o2, 0x4 - 1, %o5
 	sub	%o2, %o5, %o2
 1:
-	EX_LD(LOAD(lduw, %o1 + 0x00, %o3))
+	EX_LD(LOAD(lduw, %o1 + 0x00, %o3), memcpy_retl_o2_plus_o5)
 	add	%o1, 0x04, %o1
 	subcc	%o5, 0x04, %o5
 	add	%o0, 0x04, %o0
 	bne,pt	%ncc, 1b
-	 EX_ST(STORE(stw, %o3, %o0 - 0x04))
+	 EX_ST(STORE(stw, %o3, %o0 - 0x04), memcpy_retl_o2_plus_o5_plus_4)
 	brz,pt	%o2, .Lexit_cp
 	 nop
 	ba,a,pt	%ncc, .Ltiny_cp
 
 .Lsmall_unaligned_cp:
-1:	EX_LD(LOAD(ldub, %o1 + 0x00, %o3))
+1:	EX_LD(LOAD(ldub, %o1 + 0x00, %o3), memcpy_retl_o2)
 	add	%o1, 1, %o1
 	add	%o0, 1, %o0
 	subcc	%o2, 1, %o2
 	bne,pt	%ncc, 1b
-	 EX_ST(STORE(stb, %o3, %o0 - 0x01))
+	 EX_ST(STORE(stb, %o3, %o0 - 0x01), memcpy_retl_o2_plus_1)
 	ba,a,pt	%ncc, .Lexit_cp
 
 .Lsmallrest:
@@ -884,31 +884,31 @@ FUNC_NAME:
 	 nop
 	sub	%o2, 3, %o2
 .Lsmallnotalign4:
-	EX_LD(LOAD(ldub, %o1, %o3))! read byte
+	EX_LD(LOAD(ldub, %o1, %o3), memcpy_retl_o2_plus_3)! read byte
 	subcc	%o2, 4, %o2		! reduce count by 4
-	EX_ST(STORE(stb, %o3, %o0))	! write byte
-	EX_LD(LOAD(ldub, %o1+1, %o3))! repeat for total of 4 bytes
+	EX_ST(STORE(stb, %o3, %o0), memcpy_retl_o2_plus_7)! write byte & repeat
+	EX_LD(LOAD(ldub, %o1+1, %o3), memcpy_retl_o2_plus_6)! for total of 4
 	add	%o1, 4, %o1		! advance SRC by 4
-	EX_ST(STORE(stb, %o3, %o0+1))
-	EX_LD(LOAD(ldub, %o1-2, %o3))
+	EX_ST(STORE(stb, %o3, %o0+1), memcpy_retl_o2_plus_6)
+	EX_LD(LOAD(ldub, %o1-2, %o3), memcpy_retl_o2_plus_5)
 	add	%o0, 4, %o0		! advance DST by 4
-	EX_ST(STORE(stb, %o3, %o0-2))
-	EX_LD(LOAD(ldub, %o1-1, %o3))
+	EX_ST(STORE(stb, %o3, %o0-2), memcpy_retl_o2_plus_5)
+	EX_LD(LOAD(ldub, %o1-1, %o3), memcpy_retl_o2_plus_4)
 	bgu,pt	%ncc, .Lsmallnotalign4	! loop til 3 or fewer bytes remain
-	EX_ST(STORE(stb, %o3, %o0-1))
+	EX_ST(STORE(stb, %o3, %o0-1), memcpy_retl_o2_plus_4)
 	addcc	%o2, 3, %o2		! restore count
 	bz,pt	%ncc, .Lsmallx
 .Lsmallleft3:				! 1, 2, or 3 bytes remain
 	subcc	%o2, 1, %o2
-	EX_LD(LOAD(ldub, %o1, %o3))	! load one byte
+	EX_LD(LOAD(ldub, %o1, %o3), memcpy_retl_o2_plus_1)	! load one byte
 	bz,pt	%ncc, .Lsmallx
-	 EX_ST(STORE(stb, %o3, %o0))	! store one byte
-	EX_LD(LOAD(ldub, %o1+1, %o3))	! load second byte
+	EX_ST(STORE(stb, %o3, %o0), memcpy_retl_o2_plus_1)	! store one byte
+	EX_LD(LOAD(ldub, %o1+1, %o3), memcpy_retl_o2)	! load second byte
 	subcc	%o2, 1, %o2
 	bz,pt	%ncc, .Lsmallx
-	 EX_ST(STORE(stb, %o3, %o0+1))! store second byte
-	EX_LD(LOAD(ldub, %o1+2, %o3))	! load third byte
-	EX_ST(STORE(stb, %o3, %o0+2))	! store third byte
+	EX_ST(STORE(stb, %o3, %o0+1), memcpy_retl_o2_plus_1)! store second byte
+	EX_LD(LOAD(ldub, %o1+2, %o3), memcpy_retl_o2)	! load third byte
+	EX_ST(STORE(stb, %o3, %o0+2), memcpy_retl_o2)	! store third byte
 .Lsmallx:
 	retl
 	 mov	EX_RETVAL(%g1), %o0
diff --git a/arch/sparc/lib/Memcpy_utils.S b/arch/sparc/lib/Memcpy_utils.S
index bcc5d77..64fbac2 100644
--- a/arch/sparc/lib/Memcpy_utils.S
+++ b/arch/sparc/lib/Memcpy_utils.S
@@ -24,14 +24,128 @@ ENTRY(memcpy_retl_o2_plus_1)
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, 1, %o0
 ENDPROC(memcpy_retl_o2_plus_1)
+ENTRY(memcpy_retl_o2_plus_3)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 3, %o0
+ENDPROC(memcpy_retl_o2_plus_3)
 ENTRY(memcpy_retl_o2_plus_4)
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, 4, %o0
 ENDPROC(memcpy_retl_o2_plus_4)
+ENTRY(memcpy_retl_o2_plus_5)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 5, %o0
+ENDPROC(memcpy_retl_o2_plus_5)
+ENTRY(memcpy_retl_o2_plus_6)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 6, %o0
+ENDPROC(memcpy_retl_o2_plus_6)
+ENTRY(memcpy_retl_o2_plus_7)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 7, %o0
+ENDPROC(memcpy_retl_o2_plus_7)
+ENTRY(memcpy_retl_o2_plus_8)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 8, %o0
+ENDPROC(memcpy_retl_o2_plus_8)
+ENTRY(memcpy_retl_o2_plus_15)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 15, %o0
+ENDPROC(memcpy_retl_o2_plus_15)
+ENTRY(memcpy_retl_o2_plus_15_8)
+	 add	%o2, 15, %o2
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 8, %o0
+ENDPROC(memcpy_retl_o2_plus_15_8)
+ENTRY(memcpy_retl_o2_plus_16)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 16, %o0
+ENDPROC(memcpy_retl_o2_plus_16)
+ENTRY(memcpy_retl_o2_plus_24)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 24, %o0
+ENDPROC(memcpy_retl_o2_plus_24)
+ENTRY(memcpy_retl_o2_plus_31)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 31, %o0
+ENDPROC(memcpy_retl_o2_plus_31)
+ENTRY(memcpy_retl_o2_plus_32)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 32, %o0
+ENDPROC(memcpy_retl_o2_plus_32)
+ENTRY(memcpy_retl_o2_plus_31_32)
+	add	%o2, 31, %o2
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 32, %o0
+ENDPROC(memcpy_retl_o2_plus_31_32)
+ENTRY(memcpy_retl_o2_plus_31_24)
+	add	%o2, 31, %o2
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 24, %o0
+ENDPROC(memcpy_retl_o2_plus_31_24)
+ENTRY(memcpy_retl_o2_plus_31_16)
+	add	%o2, 31, %o2
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 16, %o0
+ENDPROC(memcpy_retl_o2_plus_31_16)
+ENTRY(memcpy_retl_o2_plus_31_8)
+	add	%o2, 31, %o2
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 8, %o0
+ENDPROC(memcpy_retl_o2_plus_31_8)
+ENTRY(memcpy_retl_o2_plus_63)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 63, %o0
+ENDPROC(memcpy_retl_o2_plus_63)
+ENTRY(memcpy_retl_o2_plus_63_64)
+	 add	%o2, 63, %o2
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 64, %o0
+ENDPROC(memcpy_retl_o2_plus_63_64)
+ENTRY(memcpy_retl_o2_plus_63_56)
+	 add	%o2, 63, %o2
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 56, %o0
+ENDPROC(memcpy_retl_o2_plus_63_56)
+ENTRY(memcpy_retl_o2_plus_63_48)
+	 add	%o2, 63, %o2
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 48, %o0
+ENDPROC(memcpy_retl_o2_plus_63_48)
+ENTRY(memcpy_retl_o2_plus_63_40)
+	 add	%o2, 63, %o2
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 40, %o0
+ENDPROC(memcpy_retl_o2_plus_63_40)
+ENTRY(memcpy_retl_o2_plus_63_32)
+	 add	%o2, 63, %o2
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 32, %o0
+ENDPROC(memcpy_retl_o2_plus_63_32)
+ENTRY(memcpy_retl_o2_plus_63_24)
+	 add	%o2, 63, %o2
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 24, %o0
+ENDPROC(memcpy_retl_o2_plus_63_24)
+ENTRY(memcpy_retl_o2_plus_63_16)
+	 add	%o2, 63, %o2
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 16, %o0
+ENDPROC(memcpy_retl_o2_plus_63_16)
+ENTRY(memcpy_retl_o2_plus_63_8)
+	 add	%o2, 63, %o2
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, 8, %o0
+ENDPROC(memcpy_retl_o2_plus_63_8)
 ENTRY(memcpy_retl_o2_plus_o5)
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5)
+ENTRY(memcpy_retl_o2_plus_o5_plus_1)
+	add	%o5, 1, %o5
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o5, %o0
+ENDPROC(memcpy_retl_o2_plus_o5_plus_1)
 ENTRY(memcpy_retl_o2_plus_o5_plus_4)
 	add	%o5, 4, %o5
 	ba,pt	%xcc, __restore_asi
@@ -57,6 +171,11 @@ ENTRY(memcpy_retl_o2_plus_o5_plus_32)
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o5, %o0
 ENDPROC(memcpy_retl_o2_plus_o5_plus_32)
+ENTRY(memcpy_retl_o2_plus_o5_64)
+	add	%o5, 32, %o5
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o5, %o0
+ENDPROC(memcpy_retl_o2_plus_o5_64)
 ENTRY(memcpy_retl_o2_plus_g1)
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %g1, %o0
@@ -115,6 +234,25 @@ ENTRY(memcpy_retl_o2_plus_o4_plus_64)
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_plus_64)
+ENTRY(memcpy_retl_o2_plus_o5_plus_64)
+	add	%o5, 64, %o5
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o5, %o0
+ENDPROC(memcpy_retl_o2_plus_o5_plus_64)
+ENTRY(memcpy_retl_o2_plus_o3_fp)
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o3, %o0
+ENDPROC(memcpy_retl_o2_plus_o3_fp)
+ENTRY(memcpy_retl_o2_plus_o3_plus_1_fp)
+	add	%o3, 1, %o3
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o3, %o0
+ENDPROC(memcpy_retl_o2_plus_o3_plus_1_fp)
+ENTRY(memcpy_retl_o2_plus_o3_plus_4_fp)
+	add	%o3, 4, %o3
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o3, %o0
+ENDPROC(memcpy_retl_o2_plus_o3_plus_4_fp)
 ENTRY(memcpy_retl_o2_plus_o4_fp)
 	ba,pt	%xcc, __restore_asi_fp
 	 add	%o2, %o4, %o0
@@ -159,5 +297,49 @@ ENTRY(memcpy_retl_o2_plus_o4_plus_64_fp)
 	ba,pt	%xcc, __restore_asi_fp
 	 add	%o2, %o4, %o0
 ENDPROC(memcpy_retl_o2_plus_o4_plus_64_fp)
+ENTRY(memcpy_retl_o2_plus_o5_fp)
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o5, %o0
+ENDPROC(memcpy_retl_o2_plus_o5_fp)
+ENTRY(memcpy_retl_o2_plus_o5_plus_64_fp)
+	add	%o5, 64, %o5
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o5, %o0
+ENDPROC(memcpy_retl_o2_plus_o5_plus_64_fp)
+ENTRY(memcpy_retl_o2_plus_o5_plus_56_fp)
+	add	%o5, 56, %o5
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o5, %o0
+ENDPROC(memcpy_retl_o2_plus_o5_plus_56_fp)
+ENTRY(memcpy_retl_o2_plus_o5_plus_48_fp)
+	add	%o5, 48, %o5
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o5, %o0
+ENDPROC(memcpy_retl_o2_plus_o5_plus_48_fp)
+ENTRY(memcpy_retl_o2_plus_o5_plus_40_fp)
+	add	%o5, 40, %o5
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o5, %o0
+ENDPROC(memcpy_retl_o2_plus_o5_plus_40_fp)
+ENTRY(memcpy_retl_o2_plus_o5_plus_32_fp)
+	add	%o5, 32, %o5
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o5, %o0
+ENDPROC(memcpy_retl_o2_plus_o5_plus_32_fp)
+ENTRY(memcpy_retl_o2_plus_o5_plus_24_fp)
+	add	%o5, 24, %o5
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o5, %o0
+ENDPROC(memcpy_retl_o2_plus_o5_plus_24_fp)
+ENTRY(memcpy_retl_o2_plus_o5_plus_16_fp)
+	add	%o5, 16, %o5
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o5, %o0
+ENDPROC(memcpy_retl_o2_plus_o5_plus_16_fp)
+ENTRY(memcpy_retl_o2_plus_o5_plus_8_fp)
+	add	%o5, 8, %o5
+	ba,pt	%xcc, __restore_asi_fp
+	 add	%o2, %o5, %o0
+ENDPROC(memcpy_retl_o2_plus_o5_plus_8_fp)
 
 #endif
-- 
1.7.1

