From: Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Fri, 18 Aug 2017 00:59:03 +0000
Subject: [PATCH] sparc64: speed up etrap/rtrap on NG2 and later processors
Message-Id: <1503017943-23575-1-git-send-email-anthony.yznaga@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

For many sun4v processor types, reading or writing a privileged register
has a latency of 40 to 70 cycles.  Use a combination of the low-latency
allclean, otherw, normalw, and nop instructions in etrap and rtrap to
replace 2 rdpr and 5 wrpr instructions and improve etrap/rtrap
performance.  allclean, otherw, and normalw are available on NG2 and
later processors.

The average ticks to execute the flush windows trap ("ta 0x3") with and
without this patch on select platforms:

 CPU            Not patched     Patched    % Latency Reduction

 NG2            1762            1558            -11.58
 NG4            3619            3204            -11.47
 M7             3015            2624            -12.97
 SPARC64-X      829             770              -7.12

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/sparc/include/asm/trap_block.h |    2 ++
 arch/sparc/kernel/etrap_64.S        |   26 ++++++++++++++++++++++----
 arch/sparc/kernel/rtrap_64.S        |   13 +++++++++++--
 arch/sparc/kernel/setup_64.c        |   14 ++++++++++++++
 arch/sparc/kernel/vmlinux.lds.S     |    5 +++++
 5 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/trap_block.h b/arch/sparc/include/asm/trap_block.h
index ff05992..dfc5386 100644
--- a/arch/sparc/include/asm/trap_block.h
+++ b/arch/sparc/include/asm/trap_block.h
@@ -73,6 +73,8 @@ struct sun4v_1insn_patch_entry {
 };
 extern struct sun4v_1insn_patch_entry __sun4v_1insn_patch,
 	__sun4v_1insn_patch_end;
+extern struct sun4v_1insn_patch_entry __fast_win_ctrl_1insn_patch,
+	__fast_win_ctrl_1insn_patch_end;
 
 struct sun4v_2insn_patch_entry {
 	unsigned int	addr;
diff --git a/arch/sparc/kernel/etrap_64.S b/arch/sparc/kernel/etrap_64.S
index 1276ca2..5c23746 100644
--- a/arch/sparc/kernel/etrap_64.S
+++ b/arch/sparc/kernel/etrap_64.S
@@ -38,7 +38,11 @@ etrap_syscall:	TRAP_LOAD_THREAD_REG(%g6, %g1)
 		or	%g1, %g3, %g1
 		bne,pn	%xcc, 1f
 		 sub	%sp, STACKFRAME_SZ+TRACEREG_SZ-STACK_BIAS, %g2
-		wrpr	%g0, 7, %cleanwin
+661:		wrpr	%g0, 7, %cleanwin
+		.section .fast_win_ctrl_1insn_patch, "ax"
+		.word	661b
+		.word	0x85880000	! allclean
+		.previous
 
 		sethi	%hi(TASK_REGOFF), %g2
 		sethi	%hi(TSTATE_PEF), %g3
@@ -88,16 +92,30 @@ etrap_save:	save	%g2, -STACK_BIAS, %sp
 
 		bne,pn	%xcc, 3f
 		 mov	PRIMARY_CONTEXT, %l4
-		rdpr	%canrestore, %g3
+661:		rdpr	%canrestore, %g3
+		.section .fast_win_ctrl_1insn_patch, "ax"
+		.word	661b
+		nop
+		.previous
+
 		rdpr	%wstate, %g2
-		wrpr	%g0, 0, %canrestore
+661:		wrpr	%g0, 0, %canrestore
+		.section .fast_win_ctrl_1insn_patch, "ax"
+		.word	661b
+		nop
+		.previous
 		sll	%g2, 3, %g2
 
 		/* Set TI_SYS_FPDEPTH to 1 and clear TI_SYS_NOERROR.  */
 		mov	1, %l5
 		sth	%l5, [%l6 + TI_SYS_NOERROR]
 
-		wrpr	%g3, 0, %otherwin
+661:		wrpr	%g3, 0, %otherwin
+		.section .fast_win_ctrl_1insn_patch, "ax"
+		.word	661b
+		.word	0x87880000	! otherw
+		.previous
+
 		wrpr	%g2, 0, %wstate
 		sethi	%hi(sparc64_kern_pri_context), %g2
 		ldx	[%g2 + %lo(sparc64_kern_pri_context)], %g3
diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
index 709a82e..dff86fa 100644
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -224,10 +224,19 @@ rt_continue:	ldx			[%sp + PTREGS_OFF + PT_V9_G1], %g1
 		rdpr			%otherwin, %l2
 		srl			%l1, 3, %l1
 
-		wrpr			%l2, %g0, %canrestore
+661:		wrpr			%l2, %g0, %canrestore
+		.section		.fast_win_ctrl_1insn_patch, "ax"
+		.word			661b
+		.word			0x89880000	! normalw
+		.previous
+
 		wrpr			%l1, %g0, %wstate
 		brnz,pt			%l2, user_rtt_restore
-		 wrpr			%g0, %g0, %otherwin
+661:		 wrpr			%g0, %g0, %otherwin
+		.section		.fast_win_ctrl_1insn_patch, "ax"
+		.word			661b
+		 nop
+		.previous
 
 		ldx			[%g6 + TI_FLAGS], %g3
 		wr			%g0, ASI_AIUP, %asi
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index c4088a3..c1baf5d 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -300,6 +300,20 @@ static void __init sun4v_patch(void)
 		break;
 	}
 
+	switch (sun4v_chip_type) {
+	case SUN4V_CHIP_NIAGARA2:
+	case SUN4V_CHIP_NIAGARA3:
+	case SUN4V_CHIP_NIAGARA4:
+	case SUN4V_CHIP_NIAGARA5:
+	case SUN4V_CHIP_SPARC_M6:
+	case SUN4V_CHIP_SPARC_M7:
+	case SUN4V_CHIP_SPARC_M8:
+	case SUN4V_CHIP_SPARC64X:
+	case SUN4V_CHIP_SPARC_SN:
+		sun4v_patch_1insn_range(&__fast_win_ctrl_1insn_patch,
+					&__fast_win_ctrl_1insn_patch_end);
+	}
+
 	sun4v_hvapi_init();
 }
 
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 34d37e6..d78847d 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -159,6 +159,11 @@ SECTIONS
 		*(.pud_huge_patch)
 		__pud_huge_patch_end = .;
 	}
+	.fast_win_ctrl_1insn_patch : {
+		__fast_win_ctrl_1insn_patch = .;
+		*(.fast_win_ctrl_1insn_patch)
+		__fast_win_ctrl_1insn_patch_end = .;
+	}
 	PERCPU_SECTION(SMP_CACHE_BYTES)
 
 #ifdef CONFIG_JUMP_LABEL
-- 
1.7.1

