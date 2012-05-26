From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 07:20:05 +0000
Subject: [PATCH 01/15] sparc32: string and whitespace cleanup in head_32.S
Message-Id: <1338016819-22245-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

A few strings have been adopted to show more relevant info.

Julian Calaby <julian.calaby@gmail.com> pointed out one
that I would otherwise have missed.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/head_32.S |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index a0f5c20..693fb08 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -46,8 +46,8 @@ cputypvar:
 
 	.align 4
 
-sun4c_notsup:
-	.asciz	"Sparc-Linux sun4/sun4c support does no longer exist.\n\n"
+notsup:
+	.asciz	"Sparc-Linux sun4/sun4c or MMU-less not supported\n\n"
 	.align 4
 
 sun4e_notsup:
@@ -123,7 +123,7 @@ current_pc:
 		tst	%o0
 		be	no_sun4u_here
 		 mov	%g4, %o7		/* Previous %o7. */
-	
+
 		mov	%o0, %l0		! stash away romvec
 		mov	%o0, %g7		! put it here too
 		mov	%o1, %l1		! stash away debug_vec too
@@ -132,7 +132,7 @@ current_pc:
 		set	current_pc, %g5
 		cmp	%g3, %g5
 		be	already_mapped
-		 nop 
+		 nop
 
 		/* %l6 will hold the offset we have to subtract
 		 * from absolute symbols in order to access areas
@@ -194,7 +194,7 @@ copy_prom_done:
 
 halt_sun4_or_sun4c:
 		ld	[%g7 + 0x68], %o1
-		set	sun4c_notsup, %o0
+		set	notsup, %o0
 		sub	%o0, %l6, %o0
 		call	%o1
 		 nop
@@ -230,12 +230,12 @@ srmmu_remap:
 		subcc	%g3, 0x0, %g0
 		bnz	srmmu_nviking			! is in mbus mode
 		 nop
-		
+
 		rd	%psr, %g3			! DO NOT TOUCH %g3
 		andn	%g3, PSR_ET, %g2
 		wr	%g2, 0x0, %psr
 		WRITE_PAUSE
-		
+
 		/* Get context table pointer, then convert to
 		 * a physical address, which is 36 bits.
 		 */
@@ -258,12 +258,12 @@ srmmu_remap:
 		lda	[%g4] ASI_M_BYPASS, %o1		! This is a level 1 ptr
 		srl	%o1, 0x4, %o1			! Clear low 4 bits
 		sll	%o1, 0x8, %o1			! Make physical
-		
+
 		/* Ok, pull in the PTD. */
 		lda	[%o1] ASI_M_BYPASS, %o2		! This is the 0x0 16MB pgd
 
 		/* Calculate to KERNBASE entry. */
-		add	%o1, KERNBASE >> (SRMMU_PGDIR_SHIFT - 2), %o3		
+		add	%o1, KERNBASE >> (SRMMU_PGDIR_SHIFT - 2), %o3
 
 		/* Poke the entry into the calculated address. */
 		sta	%o2, [%o3] ASI_M_BYPASS
@@ -480,7 +480,7 @@ continue_boot:
 		set	__bss_start , %o0	! First address of BSS
 		set	_end , %o1		! Last address of BSS
 		add	%o0, 0x1, %o0
-1:	
+1:
 		stb	%g0, [%o0]
 		subcc	%o0, %o1, %g0
 		bl	1b
@@ -546,7 +546,7 @@ continue_boot:
 		set	dest, %g2; \
 		ld	[%g5], %g4; \
 		st	%g4, [%g2];
-	
+
 		/* Patch for window spills... */
 		PATCH_INSN(spnwin_patch1_7win, spnwin_patch1)
 		PATCH_INSN(spnwin_patch2_7win, spnwin_patch2)
@@ -597,7 +597,7 @@ continue_boot:
 		st	%g4, [%g5 + 0x18]
 		st	%g4, [%g5 + 0x1c]
 
-2:		
+2:
 		sethi	%hi(nwindows), %g4
 		st	%g3, [%g4 + %lo(nwindows)]	! store final value
 		sub	%g3, 0x1, %g3
@@ -626,9 +626,9 @@ continue_boot:
 		call	prom_init
 		 nop
 
-		call 	start_kernel
+		call	start_kernel
 		 nop
-	
+
 		/* We should not get here. */
 		call	halt_me
 		 nop
@@ -659,7 +659,7 @@ sun4u_5:
 		.asciz "write"
 		.align	4
 sun4u_6:
-        	.asciz  "\n\rOn sun4u you have to use UltraLinux (64bit) kernel\n\rand not a 32bit sun4[cdem] version\n\r\n\r"
+		.asciz  "\n\rOn sun4u you have to use sparc64 kernel\n\rand not a sparc32 version\n\r\n\r"
 sun4u_6e:
 		.align	4
 sun4u_7:
-- 
1.6.0.6

