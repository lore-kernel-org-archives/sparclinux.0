From: Babu Moger <babu.moger@oracle.com>
Date: Fri, 17 Mar 2017 20:52:21 +0000
Subject: [PATCH v2] arch/sparc: Avoid DCTI Couples
Message-Id: <1489783941-509645-1-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: davem@davemloft.net
Cc: rob.gardner@oracle.com, khalid.aziz@oracle.com, babu.moger@oracle.com, allen.pais@oracle.com, viro@zeniv.linux.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Avoid un-intended DCTI Couples. Use of DCTI couples is deprecated.
Also address the "Programming Note" for optimal performance.

Here is the complete text from Oracle SPARC Architecture Specs.

6.3.4.7 DCTI Couples
"A delayed control transfer instruction (DCTI) in the delay slot of
another DCTI is referred to as a “DCTI couple”. The use of DCTI couples
is deprecated in the Oracle SPARC Architecture; no new software should
place a DCTI in the delay slot of another DCTI, because on future Oracle
SPARC Architecture implementations DCTI couples may execute either
slowly or differently than the programmer assumes it will.

SPARC V8 and SPARC V9 Compatibility Note
The SPARC V8 architecture left behavior undefined for a DCTI couple. The
SPARC V9 architecture defined behavior in that case, but as of
UltraSPARC Architecture 2005, use of DCTI couples was deprecated.
Software should not expect high performance from DCTI couples, and
performance of DCTI couples should be expected to decline further in
future processors.

Programming Note
As noted in TABLE 6-5 on page 115, an annulled branch-always
(branch-always with a = 1) instruction is not architecturally a DCTI.
However, since not all implementations make that distinction, for
optimal performance, a DCTI should not be placed in the instruction word
immediately following an annulled branch-always instruction (BA,A or
BPA,A)."

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Reviewed-by: Rob Gardner <rob.gardner@oracle.com>
---
 arch/sparc/kernel/head_64.S        |    4 ++++
 arch/sparc/kernel/misctrap.S       |    1 +
 arch/sparc/kernel/rtrap_64.S       |    1 +
 arch/sparc/kernel/spiterrs.S       |    1 +
 arch/sparc/kernel/sun4v_tlb_miss.S |    1 +
 arch/sparc/kernel/urtt_fill.S      |    1 +
 arch/sparc/kernel/winfixup.S       |    2 ++
 arch/sparc/lib/NG2memcpy.S         |    4 ++++
 arch/sparc/lib/NG4memcpy.S         |    1 +
 arch/sparc/lib/NG4memset.S         |    1 +
 arch/sparc/lib/NGmemcpy.S          |    1 +
 11 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 6aa3da1..4410119 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -96,6 +96,7 @@ sparc64_boot:
 	andn	%g1, PSTATE_AM, %g1
 	wrpr	%g1, 0x0, %pstate
 	ba,a,pt	%xcc, 1f
+	 nop
 
 	.globl	prom_finddev_name, prom_chosen_path, prom_root_node
 	.globl	prom_getprop_name, prom_mmu_name, prom_peer_name
@@ -613,6 +614,7 @@ niagara_tlb_fixup:
 	 nop
 
 	ba,a,pt	%xcc, 80f
+	 nop
 niagara4_patch:
 	call	niagara4_patch_copyops
 	 nop
@@ -622,6 +624,7 @@ niagara4_patch:
 	 nop
 
 	ba,a,pt	%xcc, 80f
+	 nop
 
 niagara2_patch:
 	call	niagara2_patch_copyops
@@ -632,6 +635,7 @@ niagara2_patch:
 	 nop
 
 	ba,a,pt	%xcc, 80f
+	 nop
 
 niagara_patch:
 	call	niagara_patch_copyops
diff --git a/arch/sparc/kernel/misctrap.S b/arch/sparc/kernel/misctrap.S
index 34b4933..9276d2f 100644
--- a/arch/sparc/kernel/misctrap.S
+++ b/arch/sparc/kernel/misctrap.S
@@ -82,6 +82,7 @@ do_stdfmna:
 	call		handle_stdfmna
 	 add		%sp, PTREGS_OFF, %o0
 	ba,a,pt		%xcc, rtrap
+	 nop
 	.size		do_stdfmna,.-do_stdfmna
 
 	.type		breakpoint_trap,#function
diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
index 216948c..709a82e 100644
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -237,6 +237,7 @@ rt_continue:	ldx			[%sp + PTREGS_OFF + PT_V9_G1], %g1
 		bne,pt			%xcc, user_rtt_fill_32bit
 		 wrpr			%g1, %cwp
 		ba,a,pt			%xcc, user_rtt_fill_64bit
+		 nop
 
 user_rtt_fill_fixup_dax:
 		ba,pt	%xcc, user_rtt_fill_fixup_common
diff --git a/arch/sparc/kernel/spiterrs.S b/arch/sparc/kernel/spiterrs.S
index 4a73009..d7e5408 100644
--- a/arch/sparc/kernel/spiterrs.S
+++ b/arch/sparc/kernel/spiterrs.S
@@ -86,6 +86,7 @@ __spitfire_cee_trap_continue:
 	 rd		%pc, %g7
 
 	ba,a,pt		%xcc, 2f
+	 nop
 
 1:	ba,pt		%xcc, etrap_irq
 	 rd		%pc, %g7
diff --git a/arch/sparc/kernel/sun4v_tlb_miss.S b/arch/sparc/kernel/sun4v_tlb_miss.S
index 6179e19..c19f352 100644
--- a/arch/sparc/kernel/sun4v_tlb_miss.S
+++ b/arch/sparc/kernel/sun4v_tlb_miss.S
@@ -352,6 +352,7 @@ sun4v_mna:
 	call	sun4v_do_mna
 	 add	%sp, PTREGS_OFF, %o0
 	ba,a,pt	%xcc, rtrap
+	 nop
 
 	/* Privileged Action.  */
 sun4v_privact:
diff --git a/arch/sparc/kernel/urtt_fill.S b/arch/sparc/kernel/urtt_fill.S
index 5604a2b..364af32 100644
--- a/arch/sparc/kernel/urtt_fill.S
+++ b/arch/sparc/kernel/urtt_fill.S
@@ -92,6 +92,7 @@ user_rtt_fill_fixup_common:
 		call	sun4v_data_access_exception
 		 nop
 		ba,a,pt	%xcc, rtrap
+		 nop
 
 1:		call	spitfire_data_access_exception
 		 nop
diff --git a/arch/sparc/kernel/winfixup.S b/arch/sparc/kernel/winfixup.S
index 855019a..1ee173c 100644
--- a/arch/sparc/kernel/winfixup.S
+++ b/arch/sparc/kernel/winfixup.S
@@ -152,6 +152,8 @@ fill_fixup_dax:
 	call	sun4v_data_access_exception
 	 nop
 	ba,a,pt	%xcc, rtrap
+	 nop
 1:	call	spitfire_data_access_exception
 	 nop
 	ba,a,pt	%xcc, rtrap
+	 nop
diff --git a/arch/sparc/lib/NG2memcpy.S b/arch/sparc/lib/NG2memcpy.S
index c629dbd..64dcd6c 100644
--- a/arch/sparc/lib/NG2memcpy.S
+++ b/arch/sparc/lib/NG2memcpy.S
@@ -326,11 +326,13 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	blu		170f
 	 nop
 	ba,a,pt		%xcc, 180f
+	 nop
 
 4:	/* 32 <= low bits < 48 */
 	blu		150f
 	 nop
 	ba,a,pt		%xcc, 160f
+	 nop
 5:	/* 0 < low bits < 32 */
 	blu,a		6f
 	 cmp		%g2, 8
@@ -338,6 +340,7 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	blu		130f
 	 nop
 	ba,a,pt		%xcc, 140f
+	 nop
 6:	/* 0 < low bits < 16 */
 	bgeu		120f
 	 nop
@@ -475,6 +478,7 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	brz,pt		%o2, 85f
 	 sub		%o0, %o1, GLOBAL_SPARE
 	ba,a,pt		%XCC, 90f
+	 nop
 
 	.align		64
 75: /* 16 < len <= 64 */
diff --git a/arch/sparc/lib/NG4memcpy.S b/arch/sparc/lib/NG4memcpy.S
index 75bb93b..78ea962 100644
--- a/arch/sparc/lib/NG4memcpy.S
+++ b/arch/sparc/lib/NG4memcpy.S
@@ -530,4 +530,5 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	bne,pt		%icc, 1b
 	 EX_ST(STORE(stb, %g1, %o0 - 0x01), NG4_retl_o2_plus_1)
 	ba,a,pt		%icc, .Lexit
+	 nop
 	.size		FUNC_NAME, .-FUNC_NAME
diff --git a/arch/sparc/lib/NG4memset.S b/arch/sparc/lib/NG4memset.S
index 41da4bd..7c0c81f 100644
--- a/arch/sparc/lib/NG4memset.S
+++ b/arch/sparc/lib/NG4memset.S
@@ -102,4 +102,5 @@ NG4bzero:
 	bne,pt		%icc, 1b
 	 add		%o0, 0x30, %o0
 	ba,a,pt		%icc, .Lpostloop
+	 nop
 	.size		NG4bzero,.-NG4bzero
diff --git a/arch/sparc/lib/NGmemcpy.S b/arch/sparc/lib/NGmemcpy.S
index d88c4ed..cd654a7 100644
--- a/arch/sparc/lib/NGmemcpy.S
+++ b/arch/sparc/lib/NGmemcpy.S
@@ -394,6 +394,7 @@ FUNC_NAME:	/* %i0=dst, %i1=src, %i2=len */
 	brz,pt		%i2, 85f
 	 sub		%o0, %i1, %i3
 	ba,a,pt		%XCC, 90f
+	 nop
 
 	.align		64
 70: /* 16 < len <= 64 */
-- 
1.7.1

