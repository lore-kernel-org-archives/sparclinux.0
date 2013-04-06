From: David Miller <davem@davemloft.net>
Date: Sat, 06 Apr 2013 21:53:59 +0000
Subject: [PATCH] sparc: Consistently use 'wr' and 'rd' instructions for ASRs.
Message-Id: <20130406.175359.2022788792784378259.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


For consistency, don't use 'mov'.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/head_32.h | 6 +++---
 arch/sparc/kernel/leon_pmc.c     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/include/asm/head_32.h b/arch/sparc/include/asm/head_32.h
index a768748..5f1dbe3 100644
--- a/arch/sparc/include/asm/head_32.h
+++ b/arch/sparc/include/asm/head_32.h
@@ -55,15 +55,15 @@
 
 /* The Get Condition Codes software trap for userland. */
 #define GETCC_TRAP \
-        b getcc_trap_handler; mov %psr, %l0; nop; nop;
+        b getcc_trap_handler; rd %psr, %l0; nop; nop;
 
 /* The Set Condition Codes software trap for userland. */
 #define SETCC_TRAP \
-        b setcc_trap_handler; mov %psr, %l0; nop; nop;
+        b setcc_trap_handler; rd %psr, %l0; nop; nop;
 
 /* The Get PSR software trap for userland. */
 #define GETPSR_TRAP \
-	mov %psr, %i0; jmp %l2; rett %l2 + 4; nop;
+	rd %psr, %i0; jmp %l2; rett %l2 + 4; nop;
 
 /* This is for hard interrupts from level 1-14, 15 is non-maskable (nmi) and
  * gets handled with another macro.
diff --git a/arch/sparc/kernel/leon_pmc.c b/arch/sparc/kernel/leon_pmc.c
index 708bca4..bdf53d9 100644
--- a/arch/sparc/kernel/leon_pmc.c
+++ b/arch/sparc/kernel/leon_pmc.c
@@ -48,7 +48,7 @@ void pmc_leon_idle_fixup(void)
 	 */
 	register unsigned int address = (unsigned int)leon3_irqctrl_regs;
 	__asm__ __volatile__ (
-		"mov	%%g0, %%asr19\n"
+		"wr	%%g0, %%asr19\n"
 		"lda	[%0] %1, %%g0\n"
 		:
 		: "r"(address), "i"(ASI_LEON_BYPASS));
@@ -61,7 +61,7 @@ void pmc_leon_idle_fixup(void)
 void pmc_leon_idle(void)
 {
 	/* For systems without power-down, this will be no-op */
-	__asm__ __volatile__ ("mov	%g0, %asr19\n\t");
+	__asm__ __volatile__ ("wr	%g0, %asr19\n\t");
 }
 
 /* Install LEON Power Down function */
-- 
1.7.11.7

